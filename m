Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09FAC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4E121900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfCURO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:14:57 -0400
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:42377 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727987AbfCURO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:14:57 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id B8FF71C2B3B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 17:14:54 +0000 (GMT)
Received: (qmail 30480 invoked from network); 21 Mar 2019 17:14:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Mar 2019 17:14:54 -0000
Date:   Thu, 21 Mar 2019 17:14:53 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        mikhail.v.gavrilov@gmail.com, vbabka@suse.cz,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/compaction: abort search if isolation fails
Message-ID: <20190321171453.GE3189@techsingularity.net>
References: <20190320192648.52499-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190320192648.52499-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 03:26:48PM -0400, Qian Cai wrote:
> Running LTP oom01 in a tight loop or memory stress testing put the
> system in a low-memory situation could triggers random memory
> corruption like page flag corruption below due to in
> fast_isolate_freepages(), if isolation fails, next_search_order() does
> not abort the search immediately could lead to improper accesses.
> 
> UBSAN: Undefined behaviour in ./include/linux/mm.h:1195:50
> index 7 is out of range for type 'zone [5]'
> Call Trace:
>  dump_stack+0x62/0x9a
>  ubsan_epilogue+0xd/0x7f
>  __ubsan_handle_out_of_bounds+0x14d/0x192
>  __isolate_free_page+0x52c/0x600
>  compaction_alloc+0x886/0x25f0
>  unmap_and_move+0x37/0x1e70
>  migrate_pages+0x2ca/0xb20
>  compact_zone+0x19cb/0x3620
>  kcompactd_do_work+0x2df/0x680
>  kcompactd+0x1d8/0x6c0
>  kthread+0x32c/0x3f0
>  ret_from_fork+0x35/0x40
> ------------[ cut here ]------------
> kernel BUG at mm/page_alloc.c:3124!
> invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> RIP: 0010:__isolate_free_page+0x464/0x600
> RSP: 0000:ffff888b9e1af848 EFLAGS: 00010007
> RAX: 0000000030000000 RBX: ffff888c39fcf0f8 RCX: 0000000000000000
> RDX: 1ffff111873f9e25 RSI: 0000000000000004 RDI: ffffed1173c35ef6
> RBP: ffff888b9e1af898 R08: fffffbfff4fc2461 R09: fffffbfff4fc2460
> R10: fffffbfff4fc2460 R11: ffffffffa7e12303 R12: 0000000000000008
> R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000007
> FS:  0000000000000000(0000) GS:ffff888ba8e80000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc7abc00000 CR3: 0000000752416004 CR4: 00000000001606a0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  compaction_alloc+0x886/0x25f0
>  unmap_and_move+0x37/0x1e70
>  migrate_pages+0x2ca/0xb20
>  compact_zone+0x19cb/0x3620
>  kcompactd_do_work+0x2df/0x680
>  kcompactd+0x1d8/0x6c0
>  kthread+0x32c/0x3f0
>  ret_from_fork+0x35/0x40
> 
> Fixes: dbe2d4e4f12e ("mm, compaction: round-robin the order while searching the free lists for a target")
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
