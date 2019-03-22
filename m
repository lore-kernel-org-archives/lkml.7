Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8640C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37CB2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255943;
	bh=Ewv3nsAzJ/9CfI9m421GeM56SzPQfl3q46MN0kmjcL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mhRJbWYUvSqRmigO0HvYOx23647cHOBag8/XsReM58cIfkvC8v8SfUMDOe7XlX/Sc
	 cIU7wzijG7PvVM3SZSPeXOXTOma9yrL6a4fPzEno6YGU9gxAaJfdH7xXouKLKnfp+s
	 GVJYcuY4+IBaVh9fBL1U2FFdlhGm+6Gt7zwqhCBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbfCVL7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:59:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387910AbfCVL66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:58:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03CDC2192D;
        Fri, 22 Mar 2019 11:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255937;
        bh=Ewv3nsAzJ/9CfI9m421GeM56SzPQfl3q46MN0kmjcL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=htkzqAOlGcjRwe4IHZS9kZISRNJvuwe6M5d7KoqR3RSeBQCIo/jeqTk6qenjnW7hr
         tkWGs69+risAnro97t9EP/ncG4dY/iBrq4sh8NAmCui6rJN+WaYh+baJ7YJW/bKeQs
         f/LSArdOTuY0Mqv59bvPfIB5l+iAN+7lpUPnYRFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 042/280] KVM: arm64: Forbid kprobing of the VHE world-switch code
Date:   Fri, 22 Mar 2019 12:13:15 +0100
Message-Id: <20190322111308.681987514@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7d82602909ed9c73b34ad26f05d10db4850a4f8c ]

On systems with VHE the kernel and KVM's world-switch code run at the
same exception level. Code that is only used on a VHE system does not
need to be annotated as __hyp_text as it can reside anywhere in the
kernel text.

__hyp_text was also used to prevent kprobes from patching breakpoint
instructions into this region, as this code runs at a different
exception level. While this is no longer true with VHE, KVM still
switches VBAR_EL1, meaning a kprobe's breakpoint executed in the
world-switch code will cause a hyp-panic.

echo "p:weasel sysreg_save_guest_state_vhe" > /sys/kernel/debug/tracing/kprobe_events
echo 1 > /sys/kernel/debug/tracing/events/kprobes/weasel/enable
lkvm run -k /boot/Image --console serial -p "console=ttyS0 earlycon=uart,mmio,0x3f8"

  # lkvm run -k /boot/Image -m 384 -c 3 --name guest-1474
  Info: Placing fdt at 0x8fe00000 - 0x8fffffff
  Info: virtio-mmio.devices=0x200@0x10000:36

  Info: virtio-mmio.devices=0x200@0x10200:37

  Info: virtio-mmio.devices=0x200@0x10400:38

[  614.178186] Kernel panic - not syncing: HYP panic:
[  614.178186] PS:404003c9 PC:ffff0000100d70e0 ESR:f2000004
[  614.178186] FAR:0000000080080000 HPFAR:0000000000800800 PAR:1d00007edbadc0de
[  614.178186] VCPU:00000000f8de32f1
[  614.178383] CPU: 2 PID: 1482 Comm: kvm-vcpu-0 Not tainted 5.0.0-rc2 #10799
[  614.178446] Call trace:
[  614.178480]  dump_backtrace+0x0/0x148
[  614.178567]  show_stack+0x24/0x30
[  614.178658]  dump_stack+0x90/0xb4
[  614.178710]  panic+0x13c/0x2d8
[  614.178793]  hyp_panic+0xac/0xd8
[  614.178880]  kvm_vcpu_run_vhe+0x9c/0xe0
[  614.178958]  kvm_arch_vcpu_ioctl_run+0x454/0x798
[  614.179038]  kvm_vcpu_ioctl+0x360/0x898
[  614.179087]  do_vfs_ioctl+0xc4/0x858
[  614.179174]  ksys_ioctl+0x84/0xb8
[  614.179261]  __arm64_sys_ioctl+0x28/0x38
[  614.179348]  el0_svc_common+0x94/0x108
[  614.179401]  el0_svc_handler+0x38/0x78
[  614.179487]  el0_svc+0x8/0xc
[  614.179558] SMP: stopping secondary CPUs
[  614.179661] Kernel Offset: disabled
[  614.179695] CPU features: 0x003,2a80aa38
[  614.179758] Memory Limit: none
[  614.179858] ---[ end Kernel panic - not syncing: HYP panic:
[  614.179858] PS:404003c9 PC:ffff0000100d70e0 ESR:f2000004
[  614.179858] FAR:0000000080080000 HPFAR:0000000000800800 PAR:1d00007edbadc0de
[  614.179858] VCPU:00000000f8de32f1 ]---

Annotate the VHE world-switch functions that aren't marked
__hyp_text using NOKPROBE_SYMBOL().

Signed-off-by: James Morse <james.morse@arm.com>
Fixes: 3f5c90b890ac ("KVM: arm64: Introduce VHE-specific kvm_vcpu_run")
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/hyp/switch.c    | 5 +++++
 arch/arm64/kvm/hyp/sysreg-sr.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index a1c32c1f2267..6290a4e81d57 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -23,6 +23,7 @@
 #include <kvm/arm_psci.h>
 
 #include <asm/cpufeature.h>
+#include <asm/kprobes.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_host.h>
@@ -107,6 +108,7 @@ static void activate_traps_vhe(struct kvm_vcpu *vcpu)
 
 	write_sysreg(kvm_get_hyp_vector(), vbar_el1);
 }
+NOKPROBE_SYMBOL(activate_traps_vhe);
 
 static void __hyp_text __activate_traps_nvhe(struct kvm_vcpu *vcpu)
 {
@@ -146,6 +148,7 @@ static void deactivate_traps_vhe(void)
 	write_sysreg(CPACR_EL1_DEFAULT, cpacr_el1);
 	write_sysreg(vectors, vbar_el1);
 }
+NOKPROBE_SYMBOL(deactivate_traps_vhe);
 
 static void __hyp_text __deactivate_traps_nvhe(void)
 {
@@ -529,6 +532,7 @@ int kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	return exit_code;
 }
+NOKPROBE_SYMBOL(kvm_vcpu_run_vhe);
 
 /* Switch to the guest for legacy non-VHE systems */
 int __hyp_text __kvm_vcpu_run_nvhe(struct kvm_vcpu *vcpu)
@@ -636,6 +640,7 @@ static void __hyp_call_panic_vhe(u64 spsr, u64 elr, u64 par,
 	      read_sysreg_el2(esr),   read_sysreg_el2(far),
 	      read_sysreg(hpfar_el2), par, vcpu);
 }
+NOKPROBE_SYMBOL(__hyp_call_panic_vhe);
 
 void __hyp_text __noreturn hyp_panic(struct kvm_cpu_context *host_ctxt)
 {
diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
index 9ce223944983..963d669ae3a2 100644
--- a/arch/arm64/kvm/hyp/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/sysreg-sr.c
@@ -18,6 +18,7 @@
 #include <linux/compiler.h>
 #include <linux/kvm_host.h>
 
+#include <asm/kprobes.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
@@ -98,12 +99,14 @@ void sysreg_save_host_state_vhe(struct kvm_cpu_context *ctxt)
 {
 	__sysreg_save_common_state(ctxt);
 }
+NOKPROBE_SYMBOL(sysreg_save_host_state_vhe);
 
 void sysreg_save_guest_state_vhe(struct kvm_cpu_context *ctxt)
 {
 	__sysreg_save_common_state(ctxt);
 	__sysreg_save_el2_return_state(ctxt);
 }
+NOKPROBE_SYMBOL(sysreg_save_guest_state_vhe);
 
 static void __hyp_text __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
 {
@@ -171,12 +174,14 @@ void sysreg_restore_host_state_vhe(struct kvm_cpu_context *ctxt)
 {
 	__sysreg_restore_common_state(ctxt);
 }
+NOKPROBE_SYMBOL(sysreg_restore_host_state_vhe);
 
 void sysreg_restore_guest_state_vhe(struct kvm_cpu_context *ctxt)
 {
 	__sysreg_restore_common_state(ctxt);
 	__sysreg_restore_el2_return_state(ctxt);
 }
+NOKPROBE_SYMBOL(sysreg_restore_guest_state_vhe);
 
 void __hyp_text __sysreg32_save_state(struct kvm_vcpu *vcpu)
 {
-- 
2.19.1



