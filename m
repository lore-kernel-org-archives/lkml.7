Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524B0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAB22077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="b/0lanJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfDXJqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:46:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43699 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfDXJqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:46:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3O9kAal2518691
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 24 Apr 2019 02:46:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3O9kAal2518691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556099171;
        bh=xPovtyLZRGpun0AvzZMMiX8I7BA3ug94EB2KClXe9C0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=b/0lanJ+jJBSQ6ic+OX0iffHBJUuTgXs1vm6tfjUtKRABDS4aZtn0hQqF4vxzaREd
         shOW7OHpE/xNomSA0OTl3/B4ypD/8foZQdH4K+fELtFPPXSZ7o8+N5xejDrB8ouLdm
         0SW3M8rLKSUuW8XXu182citB2fsMeevFo3PbwylNBeEJuxnZEwQ0SFMj1hW63Hu4jI
         G11XMKU0PLOAh+/R1ADJxQ35+NjgtvFZNqny0npNrs1imWCx4IRe2PCRsIWAVyRcrD
         c2VrgnIjMv2zDOvVS0owwWHel4WIoIxOZBEyLZP3G4YzMslVfiNvdzT27pT3alHqVr
         Rlm3R9q8vZk3g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3O9k9TK2518688;
        Wed, 24 Apr 2019 02:46:09 -0700
Date:   Wed, 24 Apr 2019 02:46:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qian Cai <tipbot@zytor.com>
Message-ID: <tip-0d02113b31b2017dd349ec9df2314e798a90fa6e@git.kernel.org>
Cc:     bp@suse.de, mingo@kernel.org, catalin.marinas@arm.com,
        brijesh.singh@amd.com, mingo@redhat.com, peterz@infradead.org,
        cai@lca.pw, x86@kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: peterz@infradead.org, mingo@redhat.com, catalin.marinas@arm.com,
          brijesh.singh@amd.com, mingo@kernel.org, bp@suse.de,
          hpa@zytor.com, tglx@linutronix.de, luto@kernel.org,
          dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
          x86@kernel.org, cai@lca.pw
In-Reply-To: <20190423165811.36699-1-cai@lca.pw>
References: <20190423165811.36699-1-cai@lca.pw>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Fix a crash with kmemleak_scan()
Git-Commit-ID: 0d02113b31b2017dd349ec9df2314e798a90fa6e
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

Commit-ID:  0d02113b31b2017dd349ec9df2314e798a90fa6e
Gitweb:     https://git.kernel.org/tip/0d02113b31b2017dd349ec9df2314e798a90fa6e
Author:     Qian Cai <cai@lca.pw>
AuthorDate: Tue, 23 Apr 2019 12:58:11 -0400
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 24 Apr 2019 11:32:34 +0200

x86/mm: Fix a crash with kmemleak_scan()

The first kmemleak_scan() call after boot would trigger the crash below
because this callpath:

  kernel_init
    free_initmem
      mem_encrypt_free_decrypted_mem
        free_init_pages

unmaps memory inside the .bss when DEBUG_PAGEALLOC=y.

kmemleak_init() will register the .data/.bss sections and then
kmemleak_scan() will scan those addresses and dereference them looking
for pointer references. If free_init_pages() frees and unmaps pages in
those sections, kmemleak_scan() will crash if referencing one of those
addresses:

  BUG: unable to handle kernel paging request at ffffffffbd402000
  CPU: 12 PID: 325 Comm: kmemleak Not tainted 5.1.0-rc4+ #4
  RIP: 0010:scan_block
  Call Trace:
   scan_gray_list
   kmemleak_scan
   kmemleak_scan_thread
   kthread
   ret_from_fork

Since kmemleak_free_part() is tolerant to unknown objects (not tracked
by kmemleak), it is fine to call it from free_init_pages() even if not
all address ranges passed to this function are known to kmemleak.

 [ bp: Massage. ]

Fixes: b3f0907c71e0 ("x86/mm: Add .bss..decrypted section to hold shared variables")
Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190423165811.36699-1-cai@lca.pw
---
 arch/x86/mm/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index f905a2371080..8dacdb96899e 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -5,6 +5,7 @@
 #include <linux/memblock.h>
 #include <linux/swapfile.h>
 #include <linux/swapops.h>
+#include <linux/kmemleak.h>
 
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
@@ -766,6 +767,11 @@ void free_init_pages(const char *what, unsigned long begin, unsigned long end)
 	if (debug_pagealloc_enabled()) {
 		pr_info("debug: unmapping init [mem %#010lx-%#010lx]\n",
 			begin, end - 1);
+		/*
+		 * Inform kmemleak about the hole in the memory since the
+		 * corresponding pages will be unmapped.
+		 */
+		kmemleak_free_part((void *)begin, end - begin);
 		set_memory_np(begin, (end - begin) >> PAGE_SHIFT);
 	} else {
 		/*
