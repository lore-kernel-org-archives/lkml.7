Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B428C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37A42175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfDWKUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:20:21 -0400
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:57990 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbfDWKUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:20:21 -0400
Received: from mail.blacknight.com (unknown [81.17.254.11])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id B7B201C1E00
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 11:20:18 +0100 (IST)
Received: (qmail 15122 invoked from network); 23 Apr 2019 10:20:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Apr 2019 10:20:18 -0000
Date:   Tue, 23 Apr 2019 11:20:17 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Meelis Roos <mroos@linux.ee>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 5.1-rc6: UBSAN: Undefined behaviour in mm/compaction.c:1167:30
Message-ID: <20190423102017.GO18914@techsingularity.net>
References: <b39f32a3-2cd8-2be0-00f0-9d899bb70754@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <b39f32a3-2cd8-2be0-00f0-9d899bb70754@linux.ee>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 12:14:57PM +0300, Meelis Roos wrote:
> The warning UBSAN: Undefined behaviour in mm/compaction.c:1167:30 happened with 5.1-rc6 on UP 32-bit P4 PC with highmem.
> 
> [   95.135408] ================================================================================
> [   95.135478] UBSAN: Undefined behaviour in mm/compaction.c:1167:30
> [   95.135528] shift exponent 32 is too large for 32-bit type 'long unsigned int'
> [   95.135579] CPU: 0 PID: 13 Comm: kcompactd0 Not tainted 5.1.0-rc6 #71
> [   95.135626] Hardware name: MSI                              MS-6547                         /MS-6547                         , BIOS 07.00T
> [   95.135681] Call Trace:
> [   95.135742]  dump_stack+0x16/0x1e
> [   95.135791]  ubsan_epilogue+0xb/0x29
> [   95.135836]  __ubsan_handle_shift_out_of_bounds.cold.14+0x20/0x6a
> [   95.135887]  ? page_vma_mapped_walk+0x125/0x410
> [   95.135935]  ? page_counter_cancel+0x16/0x30
> [   95.135984]  compaction_alloc.cold.43+0x56/0xbc
> [   95.136033]  ? free_unref_page_commit.isra.95+0x7a/0x80
> [   95.136082]  migrate_pages+0x99/0x732
> [   95.136127]  ? isolate_migratepages_block+0x940/0x940
> [   95.136172]  ? __ClearPageMovable+0x10/0x10
> [   95.136217]  compact_zone+0x7e2/0xb70
> [   95.136262]  ? compaction_suitable+0x49/0x60
> [   95.136306]  kcompactd_do_work+0xdb/0x1d0
> [   95.136389]  ? __switch_to_asm+0x26/0x4c
> [   95.136470]  kcompactd+0x4f/0x110
> [   95.136550]  ? wait_woken+0x60/0x60
> [   95.136630]  kthread+0xe5/0x100
> [   95.136709]  ? kcompactd_do_work+0x1d0/0x1d0
> [   95.136789]  ? kthread_create_worker_on_cpu+0x20/0x20
> [   95.136870]  ret_from_fork+0x2e/0x38
> [   95.136949] ================================================================================
> 
> It is not reproducible at will - did not happen on 2 next reboots, so it probably originates
> from an earlier version.
> 

A fix for this is waiting in Andrew's tree
mm-compaction-fix-an-undefined-behaviour.patch . I expect it'll be merged
during the next merge window as the issue is not severe. Once merged,
it should be picked up for 5.1-stable.

Thanks.

---8<---
From: Qian Cai <cai@lca.pw>
Subject: mm/compaction.c: fix an undefined behaviour

In a low-memory situation, cc->fast_search_fail can keep increasing as it
is unable to find an available page to isolate in
fast_isolate_freepages().  As the result, it could trigger an error below,
so just compare with the maximum bits can be shifted first.

UBSAN: Undefined behaviour in mm/compaction.c:1160:30
shift exponent 64 is too large for 64-bit type 'unsigned long'
CPU: 131 PID: 1308 Comm: kcompactd1 Kdump: loaded Tainted: G
W    L    5.0.0+ #17
Call trace:
 dump_backtrace+0x0/0x450
 show_stack+0x20/0x2c
 dump_stack+0xc8/0x14c
 __ubsan_handle_shift_out_of_bounds+0x7e8/0x8c4
 compaction_alloc+0x2344/0x2484
 unmap_and_move+0xdc/0x1dbc
 migrate_pages+0x274/0x1310
 compact_zone+0x26ec/0x43bc
 kcompactd+0x15b8/0x1a24
 kthread+0x374/0x390
 ret_from_fork+0x10/0x18

Link: http://lkml.kernel.org/r/20190320203338.53367-1-cai@lca.pw
Fixes: 70b44595eafe ("mm, compaction: use free lists to quickly locate a migration source")
Signed-off-by: Qian Cai <cai@lca.pw>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/compaction.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/mm/compaction.c~mm-compaction-fix-an-undefined-behaviour
+++ a/mm/compaction.c
@@ -1164,7 +1164,9 @@ static bool suitable_migration_target(st
 static inline unsigned int
 freelist_scan_limit(struct compact_control *cc)
 {
-	return (COMPACT_CLUSTER_MAX >> cc->fast_search_fail) + 1;
+	return (COMPACT_CLUSTER_MAX >>
+		min((unsigned short)(BITS_PER_LONG - 1), cc->fast_search_fail))
+		+ 1;
 }
 
 /*
_
