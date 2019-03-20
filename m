Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656EBC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3668E218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553119110;
	bh=UREsLb677xaNO93tx/w4Pa/Bbp6V0/MKire0ZbbSw2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e3a6H6mVjldGB0DpXTJoRicPitpSCcKNygD2ncOscCOTJszULzIoWOgtmdeHXQQXZ
	 RikNcYEVGJcjWyvH6p3JXUrJ1LBhWx0sjNcJyb0cWlkMn10+VjFTwKY0PuhVIZFUL4
	 3ZjyqzbEg9AWFSIrHD25FT2Qx4XjtdDyWX27/qfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfCTV62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:58:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfCTV62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:58:28 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 24B566DB7;
        Wed, 20 Mar 2019 21:58:27 +0000 (UTC)
Date:   Wed, 20 Mar 2019 14:58:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mgorman@techsingularity.net, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND#2 PATCH] mm/compaction: fix an undefined behaviour
Message-Id: <20190320145826.9c647fe53bd999bbd2ee188d@linux-foundation.org>
In-Reply-To: <20190320203338.53367-1-cai@lca.pw>
References: <20190320203338.53367-1-cai@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 16:33:38 -0400 Qian Cai <cai@lca.pw> wrote:

> In a low-memory situation, cc->fast_search_fail can keep increasing as
> it is unable to find an available page to isolate in
> fast_isolate_freepages(). As the result, it could trigger an error
> below, so just compare with the maximum bits can be shifted first.
> 
> UBSAN: Undefined behaviour in mm/compaction.c:1160:30
> shift exponent 64 is too large for 64-bit type 'unsigned long'
> CPU: 131 PID: 1308 Comm: kcompactd1 Kdump: loaded Tainted: G
> W    L    5.0.0+ #17
> Call trace:
>  dump_backtrace+0x0/0x450
>  show_stack+0x20/0x2c
>  dump_stack+0xc8/0x14c
>  __ubsan_handle_shift_out_of_bounds+0x7e8/0x8c4
>  compaction_alloc+0x2344/0x2484
>  unmap_and_move+0xdc/0x1dbc
>  migrate_pages+0x274/0x1310
>  compact_zone+0x26ec/0x43bc
>  kcompactd+0x15b8/0x1a24
>  kthread+0x374/0x390
>  ret_from_fork+0x10/0x18
> 
> Fixes: 70b44595eafe ("mm, compaction: use free lists to quickly locate a migration source")
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/compaction.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index e1a08fc92353..0d1156578114 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1157,7 +1157,9 @@ static bool suitable_migration_target(struct compact_control *cc,
>  static inline unsigned int
>  freelist_scan_limit(struct compact_control *cc)
>  {
> -	return (COMPACT_CLUSTER_MAX >> cc->fast_search_fail) + 1;
> +	return (COMPACT_CLUSTER_MAX >>
> +		min((unsigned short)(BITS_PER_LONG - 1), cc->fast_search_fail))
> +		+ 1;
>  }

That's rather an eyesore.  How about

static inline unsigned int
freelist_scan_limit(struct compact_control *cc)
{
	unsigned short shift = BITS_PER_LONG - 1;

	return (COMPACT_CLUSTER_MAX >> min(shift, cc->fast_search_fail)) + 1;
}

