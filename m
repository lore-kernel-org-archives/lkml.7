Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5C1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8992070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258200;
	bh=lUBQ6gYomRJZewnYUvks34V6RI1Cq1Fa0Zk1YtAUSBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aAN/rH515WTIh2OPefgqv9kWApDV6DjV4lsu2HW6k4mrJ1oCd57wel9xryxibTXIT
	 TNSG6E1+9QzPg5n2modXs2dqNnFhizzZuj8t09yqJNBhoWxNgI6iwfG74Wtw/Oq6gs
	 axfsRDkvzbka7qkK1B71K2u/y6ap5Ldg2olfHfE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbfCVMKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388861AbfCVMKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:10:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 768C82082C;
        Fri, 22 Mar 2019 12:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256650;
        bh=lUBQ6gYomRJZewnYUvks34V6RI1Cq1Fa0Zk1YtAUSBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQMcxF1t23uEY99ALZ6DzG9SZO0JFC5hQ6Wb29SFpRHxhcrry/nOIFo6/dNawxYBf
         zj/Ese+xp538u9ubBAPniUXm++jAj2j69F+R+SEb7xUWIJwSUIYvgo0c7xoQFmT/gW
         vE/kbIVYtCM5KnPtB3zqA0K5gL/mKuYvSwhe2ALQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 277/280] KVM: nVMX: Apply addr size mask to effective address for VMX instructions
Date:   Fri, 22 Mar 2019 12:17:10 +0100
Message-Id: <20190322111347.530882091@linuxfoundation.org>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 8570f9e881e3fde98801bb3a47eef84dd934d405 upstream.

The address size of an instruction affects the effective address, not
the virtual/linear address.  The final address may still be truncated,
e.g. to 32-bits outside of long mode, but that happens irrespective of
the address size, e.g. a 32-bit address size can yield a 64-bit virtual
address when using FS/GS with a non-zero base.

Fixes: 064aea774768 ("KVM: nVMX: Decoding memory operands of VMX instructions")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8193,20 +8193,41 @@ static int get_vmx_mem_address(struct kv
 	if (index_is_valid)
 		off += kvm_register_read(vcpu, index_reg)<<scaling;
 	vmx_get_segment(vcpu, &s, seg_reg);
-	*ret = s.base + off;
 
+	/*
+	 * The effective address, i.e. @off, of a memory operand is truncated
+	 * based on the address size of the instruction.  Note that this is
+	 * the *effective address*, i.e. the address prior to accounting for
+	 * the segment's base.
+	 */
 	if (addr_size == 1) /* 32 bit */
-		*ret &= 0xffffffff;
+		off &= 0xffffffff;
+	else if (addr_size == 0) /* 16 bit */
+		off &= 0xffff;
 
 	/* Checks for #GP/#SS exceptions. */
 	exn = false;
 	if (is_long_mode(vcpu)) {
+		/*
+		 * The virtual/linear address is never truncated in 64-bit
+		 * mode, e.g. a 32-bit address size can yield a 64-bit virtual
+		 * address when using FS/GS with a non-zero base.
+		 */
+		*ret = s.base + off;
+
 		/* Long mode: #GP(0)/#SS(0) if the memory address is in a
 		 * non-canonical form. This is the only check on the memory
 		 * destination for long mode!
 		 */
 		exn = is_noncanonical_address(*ret, vcpu);
 	} else if (is_protmode(vcpu)) {
+		/*
+		 * When not in long mode, the virtual/linear address is
+		 * unconditionally truncated to 32 bits regardless of the
+		 * address size.
+		 */
+		*ret = (s.base + off) & 0xffffffff;
+
 		/* Protected mode: apply checks for segment validity in the
 		 * following order:
 		 * - segment type check (#GP(0) may be thrown)


