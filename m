Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27425C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCEC206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153524;
	bh=egkP3sJ+gY1BD2t3nH5Y9gV7Pntrz0MosAeGmt+n9bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K/IuI4jRfeAeNVlmLSDxSo+HkR6TfhlIWyYh1AQkn4BDcFlahsBqJxSaV7mGnqoAD
	 V/rcR+9MYic1ae7uQ3LoUoVGP1mn6FT7n1MWS5VE2CV1vTPRWtMD3O1oebFImIohrc
	 545CWNOQMiUrTypLU9I91QiCqiiwGqMKm2mknQqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfEFOim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfEFOik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:38:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEC7C214AE;
        Mon,  6 May 2019 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153519;
        bh=egkP3sJ+gY1BD2t3nH5Y9gV7Pntrz0MosAeGmt+n9bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PRJOQFaFDsct95FYkpTOzcNEn4NuX5GF3TKjboh4souPl/43dqg/2yP0WaPdMoblh
         XQCWQud7TGKA1ke0HyxQRh77mdtrdHOU6pWiP7eUVYQh9CwvyUYnuTAN+PJ4Sy7zEj
         kMt1Ui42sELmgY1PlDUfu0xGW5lsKimhrDwoL9I0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>
Subject: [PATCH 5.0 119/122] x86/mm: Fix a crash with kmemleak_scan()
Date:   Mon,  6 May 2019 16:32:57 +0200
Message-Id: <20190506143105.074769856@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qian Cai <cai@lca.pw>

commit 0d02113b31b2017dd349ec9df2314e798a90fa6e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/init.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -5,6 +5,7 @@
 #include <linux/memblock.h>
 #include <linux/swapfile.h>
 #include <linux/swapops.h>
+#include <linux/kmemleak.h>
 
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
@@ -766,6 +767,11 @@ void free_init_pages(const char *what, u
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


