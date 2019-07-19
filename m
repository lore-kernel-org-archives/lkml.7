Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E94AC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EA421849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 08:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfGSIQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 04:16:21 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6860 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726029AbfGSIQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 04:16:21 -0400
X-IronPort-AV: E=Sophos;i="5.64,280,1559491200"; 
   d="scan'208";a="71774757"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Jul 2019 16:16:18 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 9DAE34CDE904;
        Fri, 19 Jul 2019 16:16:19 +0800 (CST)
Received: from TSAO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 19 Jul 2019 16:16:24 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <luto@kernel.org>
Subject: [PATCH] x86/irq/64: fix the missing update on comment
Date:   Fri, 19 Jul 2019 16:16:35 +0800
Message-ID: <20190719081635.26528-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 9DAE34CDE904.ACF02
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e6401c130931 ("x86/irq/64: Split the IRQ stack into its own pages")
missed to update one piece of comment as it did to its peer in Xen, which
will confuse people who still need to read comment.

A bonus fix to identation in ZO's linker script: spaces -> tab.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/vmlinux.lds.S | 4 ++--
 arch/x86/kernel/head_64.S              | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 508cfa6828c5..23100c52a7d0 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -64,8 +64,8 @@ SECTIONS
 		_ebss = .;
 	}
 #ifdef CONFIG_X86_64
-       . = ALIGN(PAGE_SIZE);
-       .pgtable : {
+	. = ALIGN(PAGE_SIZE);
+	.pgtable : {
 		_pgtable = . ;
 		*(.pgtable)
 		_epgtable = . ;
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index bcd206c8ac90..cba94468795e 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -195,10 +195,10 @@ ENTRY(secondary_startup_64)
 
 	/* Set up %gs.
 	 *
-	 * The base of %gs always points to the bottom of the irqstack
-	 * union.  If the stack protector canary is enabled, it is
-	 * located at %gs:40.  Note that, on SMP, the boot cpu uses
-	 * init data section till per cpu areas are set up.
+	 * The base of %gs always points to fixed_percpu_data. If the
+	 * stack protector canary is enabled, it is located at %gs:40.
+	 * Note that, on SMP, the boot cpu uses init data section till
+	 * per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
 	movl	initial_gs(%rip),%eax
-- 
2.17.0



