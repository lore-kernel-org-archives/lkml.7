Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E91C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D8121473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139138;
	bh=JMUr0Uspdw55QzEQxgiYIjp+nIyJRkpc9Skb7+L8n2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rq7M+n2QwPKm2p2YQcxVdksk5LWkcxOL8YGCDc4emkZXxksJ9OuFCFsy5AjIKvH1D
	 pGYdZwKNPNUqvqJDwn5UTf1iiI2SSSyj1APGPcxMMKUgyUmUFVaL3HN5tIAZmOMwOx
	 WpFm9pEkPLCYVKdV4S5kC9YhwN8oCMwncveeWWXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbfDARS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731197AbfDARSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:18:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2384220883;
        Mon,  1 Apr 2019 17:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139134;
        bh=JMUr0Uspdw55QzEQxgiYIjp+nIyJRkpc9Skb7+L8n2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPljFMU4Qw5pZWu7lBf3JR3nAqdl5PYyQxAqtofG5CmbSVBDrfbmIJhyHjAkOTn9W
         4GWdQd6zLz/yhegEFfi/6ylQ83+X2JjV7e0ZIOtuTrEbvsDqvgXj5YMl1jSfsNlBWe
         GHfQ7ePgyG+0+z7+bJ6tRf2TBoP/3mS0/8dc97f4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 124/134] KVM: x86: update %rip after emulating IO
Date:   Mon,  1 Apr 2019 19:02:40 +0200
Message-Id: <20190401170055.877090613@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 45def77ebf79e2e8942b89ed79294d97ce914fa0 upstream.

Most (all?) x86 platforms provide a port IO based reset mechanism, e.g.
OUT 92h or CF9h.  Userspace may emulate said mechanism, i.e. reset a
vCPU in response to KVM_EXIT_IO, without explicitly announcing to KVM
that it is doing a reset, e.g. Qemu jams vCPU state and resumes running.

To avoid corruping %rip after such a reset, commit 0967b7bf1c22 ("KVM:
Skip pio instruction when it is emulated, not executed") changed the
behavior of PIO handlers, i.e. today's "fast" PIO handling to skip the
instruction prior to exiting to userspace.  Full emulation doesn't need
such tricks becase re-emulating the instruction will naturally handle
%rip being changed to point at the reset vector.

Updating %rip prior to executing to userspace has several drawbacks:

  - Userspace sees the wrong %rip on the exit, e.g. if PIO emulation
    fails it will likely yell about the wrong address.
  - Single step exits to userspace for are effectively dropped as
    KVM_EXIT_DEBUG is overwritten with KVM_EXIT_IO.
  - Behavior of PIO emulation is different depending on whether it
    goes down the fast path or the slow path.

Rather than skip the PIO instruction before exiting to userspace,
snapshot the linear %rip and cancel PIO completion if the current
value does not match the snapshot.  For a 64-bit vCPU, i.e. the most
common scenario, the snapshot and comparison has negligible overhead
as VMCS.GUEST_RIP will be cached regardless, i.e. there is no extra
VMREAD in this case.

All other alternatives to snapshotting the linear %rip that don't
rely on an explicit reset announcenment suffer from one corner case
or another.  For example, canceling PIO completion on any write to
%rip fails if userspace does a save/restore of %rip, and attempting to
avoid that issue by canceling PIO only if %rip changed then fails if PIO
collides with the reset %rip.  Attempting to zero in on the exact reset
vector won't work for APs, which means adding more hooks such as the
vCPU's MP_STATE, and so on and so forth.

Checking for a linear %rip match technically suffers from corner cases,
e.g. userspace could theoretically rewrite the underlying code page and
expect a different instruction to execute, or the guest hardcodes a PIO
reset at 0xfffffff0, but those are far, far outside of what can be
considered normal operation.

Fixes: 432baf60eee3 ("KVM: VMX: use kvm_fast_pio_in for handling IN I/O")
Cc: <stable@vger.kernel.org>
Reported-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/kvm_host.h |    1 +
 arch/x86/kvm/x86.c              |   36 ++++++++++++++++++++++++++----------
 2 files changed, 27 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -315,6 +315,7 @@ struct kvm_mmu_page {
 };
 
 struct kvm_pio_request {
+	unsigned long linear_rip;
 	unsigned long count;
 	int in;
 	int port;
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6317,14 +6317,27 @@ int kvm_emulate_instruction_from_buffer(
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_instruction_from_buffer);
 
+static int complete_fast_pio_out(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.pio.count = 0;
+
+	if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.pio.linear_rip)))
+		return 1;
+
+	return kvm_skip_emulated_instruction(vcpu);
+}
+
 static int kvm_fast_pio_out(struct kvm_vcpu *vcpu, int size,
 			    unsigned short port)
 {
 	unsigned long val = kvm_register_read(vcpu, VCPU_REGS_RAX);
 	int ret = emulator_pio_out_emulated(&vcpu->arch.emulate_ctxt,
 					    size, port, &val, 1);
-	/* do not return to emulator after return from userspace */
-	vcpu->arch.pio.count = 0;
+
+	if (!ret) {
+		vcpu->arch.pio.linear_rip = kvm_get_linear_rip(vcpu);
+		vcpu->arch.complete_userspace_io = complete_fast_pio_out;
+	}
 	return ret;
 }
 
@@ -6335,6 +6348,11 @@ static int complete_fast_pio_in(struct k
 	/* We should only ever be called with arch.pio.count equal to 1 */
 	BUG_ON(vcpu->arch.pio.count != 1);
 
+	if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.pio.linear_rip))) {
+		vcpu->arch.pio.count = 0;
+		return 1;
+	}
+
 	/* For size less than 4 we merge, else we zero extend */
 	val = (vcpu->arch.pio.size < 4) ? kvm_register_read(vcpu, VCPU_REGS_RAX)
 					: 0;
@@ -6347,7 +6365,7 @@ static int complete_fast_pio_in(struct k
 				 vcpu->arch.pio.port, &val, 1);
 	kvm_register_write(vcpu, VCPU_REGS_RAX, val);
 
-	return 1;
+	return kvm_skip_emulated_instruction(vcpu);
 }
 
 static int kvm_fast_pio_in(struct kvm_vcpu *vcpu, int size,
@@ -6366,6 +6384,7 @@ static int kvm_fast_pio_in(struct kvm_vc
 		return ret;
 	}
 
+	vcpu->arch.pio.linear_rip = kvm_get_linear_rip(vcpu);
 	vcpu->arch.complete_userspace_io = complete_fast_pio_in;
 
 	return 0;
@@ -6373,16 +6392,13 @@ static int kvm_fast_pio_in(struct kvm_vc
 
 int kvm_fast_pio(struct kvm_vcpu *vcpu, int size, unsigned short port, int in)
 {
-	int ret = kvm_skip_emulated_instruction(vcpu);
+	int ret;
 
-	/*
-	 * TODO: we might be squashing a KVM_GUESTDBG_SINGLESTEP-triggered
-	 * KVM_EXIT_DEBUG here.
-	 */
 	if (in)
-		return kvm_fast_pio_in(vcpu, size, port) && ret;
+		ret = kvm_fast_pio_in(vcpu, size, port);
 	else
-		return kvm_fast_pio_out(vcpu, size, port) && ret;
+		ret = kvm_fast_pio_out(vcpu, size, port);
+	return ret && kvm_skip_emulated_instruction(vcpu);
 }
 EXPORT_SYMBOL_GPL(kvm_fast_pio);
 


