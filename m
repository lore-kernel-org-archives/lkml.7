Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1036C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F46A21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255137;
	bh=gscy3P9UOiqhZa2QE2VgJZnUn9WGd4xfohhiRz6gK44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EXzzpyg/k3qClfuy6SHi0o1B5/egtMJxz+3JP3vSwOQz29kyfKIkaGW8EG46Cbz8U
	 J6CbhXi7uiODxin/k23HVETWQb2yIXnBVk0g3N/1QcQ0C/BVQxxCunDMYrMvzPAEx6
	 mFzRvZ6mxUWU1LG96o7NSnqIqA+ftWwN9Y0XpmCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfCVLpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730976AbfCVLpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:45:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B0CF218B0;
        Fri, 22 Mar 2019 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255132;
        bh=gscy3P9UOiqhZa2QE2VgJZnUn9WGd4xfohhiRz6gK44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0gf5SkaPn4Z3k85TN64I4fzLbuuKyhKZx6T4cN3vr65v1iI5KMtjpfQUpqtyOk2yL
         eVjlnWuSfXFr7d7VkSNeHx5eAwmEsXaE30pw3SrHtWhejdFpBuRNo+rpv8Zk/wYejE
         C5vpPToW+7Ec6yqshUyAGMpYFMjugBKpoJylkyGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 116/118] KVM: nVMX: Sign extend displacements of VMX instrs mem operands
Date:   Fri, 22 Mar 2019 12:16:28 +0100
Message-Id: <20190322111224.483891898@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 946c522b603f281195af1df91837a1d4d1eb3bc9 upstream.

The VMCS.EXIT_QUALIFCATION field reports the displacements of memory
operands for various instructions, including VMX instructions, as a
naturally sized unsigned value, but masks the value by the addr size,
e.g. given a ModRM encoded as -0x28(%ebp), the -0x28 displacement is
reported as 0xffffffd8 for a 32-bit address size.  Despite some weird
wording regarding sign extension, the SDM explicitly states that bits
beyond the instructions address size are undefined:

    In all cases, bits of this field beyond the instructionâ€™s address
    size are undefined.

Failure to sign extend the displacement results in KVM incorrectly
treating a negative displacement as a large positive displacement when
the address size of the VMX instruction is smaller than KVM's native
size, e.g. a 32-bit address size on a 64-bit KVM.

The very original decoding, added by commit 064aea774768 ("KVM: nVMX:
Decoding memory operands of VMX instructions"), sort of modeled sign
extension by truncating the final virtual/linear address for a 32-bit
address size.  I.e. it messed up the effective address but made it work
by adjusting the final address.

When segmentation checks were added, the truncation logic was kept
as-is and no sign extension logic was introduced.  In other words, it
kept calculating the wrong effective address while mostly generating
the correct virtual/linear address.  As the effective address is what's
used in the segment limit checks, this results in KVM incorreclty
injecting #GP/#SS faults due to non-existent segment violations when
a nested VMM uses negative displacements with an address size smaller
than KVM's native address size.

Using the -0x28(%ebp) example, an EBP value of 0x1000 will result in
KVM using 0x100000fd8 as the effective address when checking for a
segment limit violation.  This causes a 100% failure rate when running
a 32-bit KVM build as L1 on top of a 64-bit KVM L0.

Fixes: f9eb4af67c9d ("KVM: nVMX: VMX instructions: add checks for #GP/#SS exceptions")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7046,6 +7046,10 @@ static int get_vmx_mem_address(struct kv
 	/* Addr = segment_base + offset */
 	/* offset = base + [index * scale] + displacement */
 	off = exit_qualification; /* holds the displacement */
+	if (addr_size == 1)
+		off = (gva_t)sign_extend64(off, 31);
+	else if (addr_size == 0)
+		off = (gva_t)sign_extend64(off, 15);
 	if (base_is_valid)
 		off += kvm_register_read(vcpu, base_reg);
 	if (index_is_valid)


