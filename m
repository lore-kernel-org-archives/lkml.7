Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F9BC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8598B20673
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfJKS2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:28:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33590 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbfJKS2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:28:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iIzdp-0008Sl-Rk; Fri, 11 Oct 2019 20:27:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7B1DD1C0178;
        Fri, 11 Oct 2019 20:27:53 +0200 (CEST)
Date:   Fri, 11 Oct 2019 18:27:53 -0000
From:   "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/64: Round memory hole size up to next PMD page
Cc:     Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Baoquan He <bhe@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        dimitri.sivanich@hpe.com, Feng Tang <feng.tang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Juergen Gross <jgross@suse.com>, mike.travis@hpe.com,
        russ.anderson@hpe.com, Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <df4f49f05c0c27f108234eb93db5c613d09ea62e.1569358539.git.steve.wahl@hpe.com>
References: <df4f49f05c0c27f108234eb93db5c613d09ea62e.1569358539.git.steve.wahl@hpe.com>
MIME-Version: 1.0
Message-ID: <157081847335.9978.12589261969290312814.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1869dbe87cb94dc9a218ae1d9301dea3678bd4ff
Gitweb:        https://git.kernel.org/tip/1869dbe87cb94dc9a218ae1d9301dea3678bd4ff
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Tue, 24 Sep 2019 16:04:31 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 11 Oct 2019 18:47:23 +02:00

x86/boot/64: Round memory hole size up to next PMD page

The kernel image map is created using PMD pages, which can include
some extra space beyond what's actually needed.  Round the size of the
memory hole we search for up to the next PMD boundary, to be certain
all of the space to be mapped is usable RAM and includes no reserved
areas.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: dimitri.sivanich@hpe.com
Cc: Feng Tang <feng.tang@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jordan Borgner <mail@jordan-borgner.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: mike.travis@hpe.com
Cc: russ.anderson@hpe.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Link: https://lkml.kernel.org/r/df4f49f05c0c27f108234eb93db5c613d09ea62e.1569358539.git.steve.wahl@hpe.com
---
 arch/x86/boot/compressed/misc.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 53ac0cb..9652d5c 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -345,6 +345,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 {
 	const unsigned long kernel_total_size = VO__end - VO__text;
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
+	unsigned long needed_size;
 
 	/* Retain x86 boot parameters pointer passed from startup_32/64. */
 	boot_params = rmode;
@@ -379,26 +380,38 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	free_mem_ptr     = heap;	/* Heap */
 	free_mem_end_ptr = heap + BOOT_HEAP_SIZE;
 
+	/*
+	 * The memory hole needed for the kernel is the larger of either
+	 * the entire decompressed kernel plus relocation table, or the
+	 * entire decompressed kernel plus .bss and .brk sections.
+	 *
+	 * On X86_64, the memory is mapped with PMD pages. Round the
+	 * size up so that the full extent of PMD pages mapped is
+	 * included in the check against the valid memory table
+	 * entries. This ensures the full mapped area is usable RAM
+	 * and doesn't include any reserved areas.
+	 */
+	needed_size = max(output_len, kernel_total_size);
+#ifdef CONFIG_X86_64
+	needed_size = ALIGN(needed_size, MIN_KERNEL_ALIGN);
+#endif
+
 	/* Report initial kernel position details. */
 	debug_putaddr(input_data);
 	debug_putaddr(input_len);
 	debug_putaddr(output);
 	debug_putaddr(output_len);
 	debug_putaddr(kernel_total_size);
+	debug_putaddr(needed_size);
 
 #ifdef CONFIG_X86_64
 	/* Report address of 32-bit trampoline */
 	debug_putaddr(trampoline_32bit);
 #endif
 
-	/*
-	 * The memory hole needed for the kernel is the larger of either
-	 * the entire decompressed kernel plus relocation table, or the
-	 * entire decompressed kernel plus .bss and .brk sections.
-	 */
 	choose_random_location((unsigned long)input_data, input_len,
 				(unsigned long *)&output,
-				max(output_len, kernel_total_size),
+				needed_size,
 				&virt_addr);
 
 	/* Validate memory location choices. */
