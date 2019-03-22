Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F03C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E8A2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257467;
	bh=LwWW/2YumICoiQCFNzUERyNYLcdA1V20u3ZBjVDaPVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lpm0rQe4bSu3cQoV+foyk7W6qqwbxUJ2vcD1mfD5UNut3FAB2M6ebTuwU1YW4A7i+
	 ekn4Hq8cIOUakdAHG5Iwp7nxOFhg1qTyj/wTJHn7o7CAHMQ1fbJcRj/NIGFdk5YwOA
	 dl7q4w4r5oRC1EZDG0IluVt/lnqO90zAHJtMKvRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403785AbfCVMYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403774AbfCVMYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:24:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ECBB2054F;
        Fri, 22 Mar 2019 12:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257462;
        bh=LwWW/2YumICoiQCFNzUERyNYLcdA1V20u3ZBjVDaPVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZeCCUNcqVFj+3WTNpVNjY5S01mFr6WmNULwchXnwqU67pCfP+WGgiPaOsnEd5O1Lz
         0CZNtldevz023s3XwNku3LH8X/t9heVtXIhh/VDqtghoPMEj7/bHhNlusA4nX4qC8i
         x5MmEAzCxorAlEv/ycGRLvXZs7KKRmWIT9SpIzMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 230/238] KVM: nVMX: Apply addr size mask to effective address for VMX instructions
Date:   Fri, 22 Mar 2019 12:17:29 +0100
Message-Id: <20190322111311.941845625@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
 arch/x86/kvm/vmx/nested.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4044,20 +4044,41 @@ int get_vmx_mem_address(struct kvm_vcpu
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


