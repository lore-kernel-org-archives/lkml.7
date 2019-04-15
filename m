Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF6CC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB7C20825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/jgEdzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfDONfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:35:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39769 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfDONfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:35:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so21983071wrn.6;
        Mon, 15 Apr 2019 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=l0BXPxJnV3M/J78ZMbwuKScX2XPGMDAUphIyQ4g9kDA=;
        b=Q/jgEdzkF4nepfcxennCLIYCl9fP1zp9OBSVmbnlIuZhuXy2pKUIey8FaD1lloz24f
         7QQ8dx1f/gW6kXcdS1uQ0LOGkyYAUr1NOQhQbkZeBUqhmDZRiZBuqjQxZ+UiYNNrn/e0
         G5uGDOBeX+0imXAJLC+1HV/WmKGzhY/SsMoM1Ve2qutyaXj8ZqzExuEQc4PUQ35oOoCF
         UOvqxdIA7LED/W7V+jPFCygMPOlQnuy9C3NqZqmYFyNrB9xPz4IvZ8Eq+XRjnPHIdrEy
         6OPeD4BVxsWf6RHACaJDmRtdRl3V3D/znYrOv6RxDPySkwAX4WcgHLiWMsRh5iZwqWae
         6GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=l0BXPxJnV3M/J78ZMbwuKScX2XPGMDAUphIyQ4g9kDA=;
        b=Tnpxv8UX3PVOl/w0uyDv18BcTTbRM9tjC1z2iCmk0oGXBTtb1ZvnTsCHjAlLIsVUz6
         OgekZI0+m2ao8cKZJADNAxlLwDgg8sXQ4FN7FjUvhOWe/ORQxBHCIiQFsdCFEDJtQHMT
         MLcLqYNfEUM3wm1as0pq099zBr/AedG00gP4M+5lAucz/q/ugjIlGBmt3YCmfUlMS3gl
         M/wrYgXl1A7MpF8Q8m/C4Acy39lPGanEuRrYSbe/ORCGnJmwcMZowZFjxEfmH9eBUTha
         m/yFgmHoMALYj3YVIQa2LOghkYKdhkDJY4tuYBoq1yfavLxovvGAethF693a2LYGa0U8
         HanA==
X-Gm-Message-State: APjAAAUGifShuKs9KSdipUPneYqUJm19nA0iaFIrbhGn879NUxMdKoDZ
        /VQ0yhMhiPYVmgh88CwmWAVVf5Un
X-Google-Smtp-Source: APXvYqw0AzQCMv19es+zU5KyToQN9VfqoXmOBpOZ4SZ56H/mTl/c5kCQvS0SVlXWpxJ1zzj98ro83A==
X-Received: by 2002:a5d:5190:: with SMTP id k16mr48330416wrv.10.1555335336701;
        Mon, 15 Apr 2019 06:35:36 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id z20sm12965574wmf.34.2019.04.15.06.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 06:35:35 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] KVM: nVMX: allow tests to use bad virtual-APIC page address
Date:   Mon, 15 Apr 2019 15:35:33 +0200
Message-Id: <1555335333-23636-2-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in the comment, there are some special cases where we can simply
clear the TPR shadow bit from the CPU-based execution controls in the vmcs02.
Handle them so that we can remove some XFAILs from vmx.flat.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 25 ++++++++++++++++---------
 arch/x86/kvm/vmx/vmx.c    |  2 +-
 arch/x86/kvm/vmx/vmx.h    |  2 ++
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 7ec9bb1dd723..a22af5a85540 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2873,20 +2873,27 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 		/*
 		 * If translation failed, VM entry will fail because
 		 * prepare_vmcs02 set VIRTUAL_APIC_PAGE_ADDR to -1ull.
-		 * Failing the vm entry is _not_ what the processor
-		 * does but it's basically the only possibility we
-		 * have.  We could still enter the guest if CR8 load
-		 * exits are enabled, CR8 store exits are enabled, and
-		 * virtualize APIC access is disabled; in this case
-		 * the processor would never use the TPR shadow and we
-		 * could simply clear the bit from the execution
-		 * control.  But such a configuration is useless, so
-		 * let's keep the code simple.
 		 */
 		if (!is_error_page(page)) {
 			vmx->nested.virtual_apic_page = page;
 			hpa = page_to_phys(vmx->nested.virtual_apic_page);
 			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, hpa);
+		} else if (nested_cpu_has(vmcs12, CPU_BASED_CR8_LOAD_EXITING) &&
+		           nested_cpu_has(vmcs12, CPU_BASED_CR8_STORE_EXITING) &&
+			   !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
+			/*
+			 * The processor will never use the TPR shadow, simply
+			 * clear the bit from the execution control.  Such a
+			 * configuration is useless, but it happens in tests.
+			 * For any other configuration, failing the vm entry is
+			 * _not_ what the processor does but it's basically the
+			 * only possibility we have.
+			 */
+			vmcs_clear_bits(CPU_BASED_VM_EXEC_CONTROL,
+					CPU_BASED_TPR_SHADOW);
+		} else {
+			printk("bad virtual-APIC page address\n");
+			dump_vmcs();
 		}
 	}
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f8054dc1de65..14cacfd7ffd0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5603,7 +5603,7 @@ static void vmx_dump_dtsel(char *name, uint32_t limit)
 	       vmcs_readl(limit + GUEST_GDTR_BASE - GUEST_GDTR_LIMIT));
 }
 
-static void dump_vmcs(void)
+void dump_vmcs(void)
 {
 	u32 vmentry_ctl = vmcs_read32(VM_ENTRY_CONTROLS);
 	u32 vmexit_ctl = vmcs_read32(VM_EXIT_CONTROLS);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index a1e00d0a2482..f879529906b4 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -517,4 +517,6 @@ static inline void decache_tsc_multiplier(struct vcpu_vmx *vmx)
 	vmcs_write64(TSC_MULTIPLIER, vmx->current_tsc_ratio);
 }
 
+void dump_vmcs(void);
+
 #endif /* __KVM_X86_VMX_H */
-- 
1.8.3.1

