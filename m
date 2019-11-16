Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DA9C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B23206A4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 11:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfKPLvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 06:51:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45284 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfKPLve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 06:51:34 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVwby-0002Bb-Bf; Sat, 16 Nov 2019 12:51:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1572A1C190A;
        Sat, 16 Nov 2019 12:51:24 +0100 (CET)
Date:   Sat, 16 Nov 2019 11:51:24 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/iopl] x86/tss: Fix and move VMX BUILD_BUG_ON()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157390508404.12247.9112539095572004762.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/iopl branch of tip:

Commit-ID:     6b546e1c9ad2a25f874f8bc6077d0f55f9446414
Gitweb:        https://git.kernel.org/tip/6b546e1c9ad2a25f874f8bc6077d0f55f9446414
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 11 Nov 2019 23:03:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Nov 2019 11:24:00 +01:00

x86/tss: Fix and move VMX BUILD_BUG_ON()

The BUILD_BUG_ON(IO_BITMAP_OFFSET - 1 == 0x67) in the VMX code is bogus in
two aspects:

1) This wants to be in generic x86 code simply to catch issues even when
   VMX is disabled in Kconfig.

2) The IO_BITMAP_OFFSET is not the right thing to check because it makes
   asssumptions about the layout of tss_struct. Nothing requires that the
   I/O bitmap is placed right after x86_tss, which is the hardware mandated
   tss structure. It pointlessly makes restrictions on the struct
   tss_struct layout.

The proper thing to check is:

    - Offset of x86_tss in tss_struct is 0
    - Size of x86_tss == 0x68

Move it to the other build time TSS checks and make it do the right thing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Andy Lutomirski <luto@kernel.org>

---
 arch/x86/kvm/vmx/vmx.c       | 8 --------
 arch/x86/mm/cpu_entry_area.c | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5d21a4a..311fd48 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1338,14 +1338,6 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu)
 			    (unsigned long)&get_cpu_entry_area(cpu)->tss.x86_tss);
 		vmcs_writel(HOST_GDTR_BASE, (unsigned long)gdt);   /* 22.2.4 */
 
-		/*
-		 * VM exits change the host TR limit to 0x67 after a VM
-		 * exit.  This is okay, since 0x67 covers everything except
-		 * the IO bitmap and have have code to handle the IO bitmap
-		 * being lost after a VM exit.
-		 */
-		BUILD_BUG_ON(IO_BITMAP_OFFSET - 1 != 0x67);
-
 		rdmsrl(MSR_IA32_SYSENTER_ESP, sysenter_esp);
 		vmcs_writel(HOST_IA32_SYSENTER_ESP, sysenter_esp); /* 22.2.3 */
 
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 752ad11..2c1d422 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -161,6 +161,14 @@ static void __init setup_cpu_entry_area(unsigned int cpu)
 	BUILD_BUG_ON((offsetof(struct tss_struct, x86_tss) ^
 		      offsetofend(struct tss_struct, x86_tss)) & PAGE_MASK);
 	BUILD_BUG_ON(sizeof(struct tss_struct) % PAGE_SIZE != 0);
+	/*
+	 * VMX changes the host TR limit to 0x67 after a VM exit. This is
+	 * okay, since 0x67 covers the size of struct x86_hw_tss. Make sure
+	 * that this is correct.
+	 */
+	BUILD_BUG_ON(offsetof(struct tss_struct, x86_tss) != 0);
+	BUILD_BUG_ON(sizeof(struct x86_hw_tss) != 0x68);
+
 	cea_map_percpu_pages(&cea->tss, &per_cpu(cpu_tss_rw, cpu),
 			     sizeof(struct tss_struct) / PAGE_SIZE, tss_prot);
 
