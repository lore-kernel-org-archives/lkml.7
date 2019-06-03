Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE956C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07F726A4D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hq13E+vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfFCM7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:59:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59191 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfFCM7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:59:41 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53Cx2if601518
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 05:59:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53Cx2if601518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559566743;
        bh=jEygdx87i/j9q88sGfVRvjkbl9QSUse80iqW0PNV28M=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Hq13E+vc/PDtt/9CeexGF0BQTGNu7ykCcSKEEN21jI/AfI0sCV+8rDnpebs1BgVmT
         GoIzPT6feaYs1iSja31pvebVnhygCDDIr9bKE2ec6eeK4lCm1wTqZ3Np477kHh2oF1
         SnBk4pmvolLj5ORe0l5Ew+5rBmUzjzgcnxg4oj94um9BRzePRWAB4/fA7rzBwKtXk8
         idECGf7lYGAOl8zl985ojYE1OumHGp1T9Dn/Sl0jpuKpAkWAvJdnXElZv9jektj6SZ
         0fbgqMnLTYVsHMgXOQCYDC70td/6ttETKICR+kbe3AhIabVsOpGncussUppp33h/Os
         Cu6CVyaNgLdHw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53Cx0OO601515;
        Mon, 3 Jun 2019 05:59:00 -0700
Date:   Mon, 3 Jun 2019 05:59:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rick Edgecombe <tipbot@zytor.com>
Message-ID: <tip-8e41f8726dcf423621e2b6938d015b9796f6f676@git.kernel.org>
Cc:     tglx@linutronix.de, namit@vmware.com, hpa@zytor.com,
        rick.p.edgecombe@intel.com, dave.hansen@intel.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        luto@kernel.org, mingo@kernel.org, davem@davemloft.net,
        mroos@linux.ee
Reply-To: rick.p.edgecombe@intel.com, dave.hansen@intel.com,
          torvalds@linux-foundation.org, tglx@linutronix.de,
          namit@vmware.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          bp@alien8.de, peterz@infradead.org, luto@kernel.org,
          mingo@kernel.org, davem@davemloft.net, mroos@linux.ee,
          akpm@linux-foundation.org
In-Reply-To: <20190527211058.2729-2-rick.p.edgecombe@intel.com>
References: <20190527211058.2729-2-rick.p.edgecombe@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] mm/vmalloc: Fix calculation of direct map addr
 range
Git-Commit-ID: 8e41f8726dcf423621e2b6938d015b9796f6f676
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8e41f8726dcf423621e2b6938d015b9796f6f676
Gitweb:     https://git.kernel.org/tip/8e41f8726dcf423621e2b6938d015b9796f6f676
Author:     Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate: Mon, 27 May 2019 14:10:57 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:47:25 +0200

mm/vmalloc: Fix calculation of direct map addr range

The calculation of the direct map address range to flush was wrong.
This could cause the RO direct map alias to not get flushed. Today
this shouldn't be a problem because this flush is only needed on x86
right now and the spurious fault handler will fix cached RO->RW
translations. In the future though, it could cause the permissions
to remain RO in the TLB for the direct map alias, and then the page
would return from the page allocator to some other component as RO
and cause a crash.

So fix fix the address range calculation so the flush will include the
direct map range.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Meelis Roos <mroos@linux.ee>
Cc: Nadav Amit <namit@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 868b104d7379 ("mm/vmalloc: Add flag for freeing of special permsissions")
Link: https://lkml.kernel.org/r/20190527211058.2729-2-rick.p.edgecombe@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 mm/vmalloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 7350a124524b..93b2dca2aadb 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2123,7 +2123,6 @@ static inline void set_area_direct_map(const struct vm_struct *area,
 /* Handle removing and resetting vm mappings related to the vm_struct. */
 static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 {
-	unsigned long addr = (unsigned long)area->addr;
 	unsigned long start = ULONG_MAX, end = 0;
 	int flush_reset = area->flags & VM_FLUSH_RESET_PERMS;
 	int i;
@@ -2135,8 +2134,8 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 	 * execute permissions, without leaving a RW+X window.
 	 */
 	if (flush_reset && !IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
-		set_memory_nx(addr, area->nr_pages);
-		set_memory_rw(addr, area->nr_pages);
+		set_memory_nx((unsigned long)area->addr, area->nr_pages);
+		set_memory_rw((unsigned long)area->addr, area->nr_pages);
 	}
 
 	remove_vm_area(area->addr);
@@ -2160,9 +2159,10 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 	 * the vm_unmap_aliases() flush includes the direct map.
 	 */
 	for (i = 0; i < area->nr_pages; i++) {
-		if (page_address(area->pages[i])) {
+		unsigned long addr = (unsigned long)page_address(area->pages[i]);
+		if (addr) {
 			start = min(addr, start);
-			end = max(addr, end);
+			end = max(addr + PAGE_SIZE, end);
 		}
 	}
 
