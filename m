Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D99FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1996B20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfCYIHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:07:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:50930 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbfCYIHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:07:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 01:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="134474066"
Received: from lxy-server.sh.intel.com ([10.239.48.11])
  by fmsmga008.fm.intel.com with ESMTP; 25 Mar 2019 01:07:15 -0700
From:   Xiaoyao Li <xiaoyao.li@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Xiaoyao Li <xiaoyao.li@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        chao.gao@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 1/2] kvm/vmx: Switch MSR_MISC_FEATURES_ENABLES between host and guest
Date:   Mon, 25 Mar 2019 16:06:49 +0800
Message-Id: <20190325080650.19896-2-xiaoyao.li@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190325080650.19896-1-xiaoyao.li@linux.intel.com>
References: <20190325080650.19896-1-xiaoyao.li@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two defined bits in MSR_MISC_FEATURES_ENABLES, bit 0 for cpuid
faulting and bit 1 for ring3mwait.

== cpuid Faulting ==
cpuid faulting is a feature about CPUID instruction. When cpuid faulting
is enabled, all execution of the CPUID instruction outside system-management
mode (SMM) cause a general-protection (#GP) if the CPL > 0.

About this feature, detailed information can be found at
https://www.intel.com/content/dam/www/public/us/en/documents/application-notes/virtualization-technology-flexmigration-application-note.pdf

Current KVM provides software emulation of this feature for guest.
However, because cpuid faulting takes higher priority over CPUID vm exit (Intel
SDM vol3.25.1.1), there is a risk of leaking cpuid faulting to guest when host
enables it. If host enables cpuid faulting by setting the bit 0 of
MSR_MISC_FEATURES_ENABLES, it will pass to guest since there is no switch of
MSR_MISC_FEATURES_ENABLES yet. As a result, when guest calls CPUID instruction
in CPL > 0, it will generate a #GP instead of CPUID vm eixt.

This issue will cause guest boot failure when guest uses *modprobe*
to load modules. *modprobe* calls CPUID instruction, thus causing #GP in
guest. Since there is no handling of cpuid faulting in #GP handler, guest
fails boot.

== ring3mwait ==
Ring3mwait is a Xeon-Phi Product Family x200 series specific feature,
which allows the MONITOR and MWAIT instructions to be executed in rings
other than ring 0. The feature can be enabled by setting bit 1 in
MSR_MISC_FEATURES_ENABLES. The register can also be read to determine
whether the instructions are enabled at other than ring 0.

About this feature, description can be found at
https://software.intel.com/en-us/blogs/2016/10/06/intel-xeon-phi-product-family-x200-knl-user-mode-ring-3-monitor-and-mwait

Current kvm doesn't expose feature ring3mwait to guest. However, there is also
a risk of leaking ring3mwait to guest if host enables it since there is no
switch of MSR_MISC_FEATURES_ENABLES.

== solution ==
From above analysis, both cpuid faulting and ring3mwait can be leaked to guest.
To fix this issue, MSR_MISC_FEATURES_ENABLES should be switched between host
and guest. Since MSR_MISC_FEATURES_ENABLES is intel-specific, this patch
implement the switching only in vmx.

For the reason that kvm provides the software emulation of cpuid faulting and
kvm doesn't expose ring3mwait to guest. MSR_MISC_FEATURES_ENABLES can be just
cleared to zero for guest when any of the features is enabled in host.

Signed-off-by: Xiaoyao Li <xiaoyao.li@linux.intel.com>
---
 arch/x86/kernel/process.c |  1 +
 arch/x86/kvm/vmx/vmx.c    | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1bba1a3c0b01..94a566e79b6c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -191,6 +191,7 @@ int set_tsc_mode(unsigned int val)
 }
 
 DEFINE_PER_CPU(u64, msr_misc_features_shadow);
+EXPORT_PER_CPU_SYMBOL_GPL(msr_misc_features_shadow);
 
 static void set_cpuid_faulting(bool on)
 {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 270c6566fd5a..65aa947947ba 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1031,6 +1031,16 @@ static void pt_guest_exit(struct vcpu_vmx *vmx)
 	wrmsrl(MSR_IA32_RTIT_CTL, vmx->pt_desc.host.ctl);
 }
 
+static void vmx_prepare_guest_misc_features_enables(struct vcpu_vmx *vmx)
+{
+	u64 msrval = this_cpu_read(msr_misc_features_shadow);
+
+	if (!msrval)
+		return;
+
+	wrmsrl(MSR_MISC_FEATURES_ENABLES, 0ULL);
+}
+
 void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -1064,6 +1074,8 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	vmx->loaded_cpu_state = vmx->loaded_vmcs;
 	host_state = &vmx->loaded_cpu_state->host_state;
 
+	vmx_prepare_guest_misc_features_enables(vmx);
+
 	/*
 	 * Set host fs and gs selectors.  Unfortunately, 22.2.3 does not
 	 * allow segment selectors with cpl > 0 or ti == 1.
@@ -1120,6 +1132,16 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void vmx_load_host_misc_features_enables(struct vcpu_vmx *vmx)
+{
+	u64 msrval = this_cpu_read(msr_misc_features_shadow);
+
+	if (!msrval)
+		return;
+
+	wrmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
+}
+
 static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
 {
 	struct vmcs_host_state *host_state;
@@ -1133,6 +1155,8 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
 	++vmx->vcpu.stat.host_state_reload;
 	vmx->loaded_cpu_state = NULL;
 
+	vmx_load_host_misc_features_enables(vmx);
+
 #ifdef CONFIG_X86_64
 	rdmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
 #endif
-- 
2.19.1

