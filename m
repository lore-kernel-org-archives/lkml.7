Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F21C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BA0218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfCNIZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:25:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:49340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726624AbfCNIZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:25:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36A06ACE3;
        Thu, 14 Mar 2019 08:25:28 +0000 (UTC)
Subject: Re: [RESEND PATCH] mm/compaction: fix an undefined behaviour
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190313180616.47908-1-cai@lca.pw>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <433eedda-bba6-798d-31e8-d603fa33a20d@suse.cz>
Date:   Thu, 14 Mar 2019 09:25:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190313180616.47908-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/19 7:06 PM, Qian Cai wrote:
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
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> 
> Resend because Andrew's email was bounced back at some point.
> 
>  mm/compaction.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index f171a83707ce..6aebf1eb8d98 100644
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
>  
>  /*
> 

