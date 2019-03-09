Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8EDC10F0C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1786020851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfCIA2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:28:45 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:49083 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbfCIA2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 19:28:44 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 30F1B1C2BA1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 00:28:43 +0000 (GMT)
Received: (qmail 8266 invoked from network); 9 Mar 2019 00:28:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Mar 2019 00:28:42 -0000
Date:   Sat, 9 Mar 2019 00:28:41 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/compaction: fix an undefined behaviour
Message-ID: <20190309002841.GL9565@techsingularity.net>
References: <20190308224650.68955-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190308224650.68955-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 05:46:50PM -0500, Qian Cai wrote:
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
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

FWIW, I had seen the same message when trying to isolate potential
corruption (still unsuccessful, the tests always complete) but
considered it relatively benign and harmless. Still worth fixing so
thanks.

-- 
Mel Gorman
SUSE Labs
