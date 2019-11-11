Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED67C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2622184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 22:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfKKWfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 17:35:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKWfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:35:44 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUIHd-0000td-VV; Mon, 11 Nov 2019 23:35:42 +0100
Message-Id: <20191111223051.865129706@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 11 Nov 2019 23:03:18 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [patch V2 04/16] x86/tss: Fix and move VMX BUILD_BUG_ON()
References: <20191111220314.519933535@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
V2: New patch
---
 arch/x86/kvm/vmx/vmx.c       |    8 --------
 arch/x86/mm/cpu_entry_area.c |    8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1338,14 +1338,6 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu
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
 
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -161,6 +161,14 @@ static void __init setup_cpu_entry_area(
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
 


