Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD9AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF552082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255141;
	bh=14K6QcrZIMwy1VNyACkwitEs+UFcU47o/OnCKsgMkmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HURxnr6cXTL1zvnK84ZAWe19jdydyNQDpCCPqT09/Dosc/pHPL9vMa/Rh+Uc9seYg
	 53ntVNsxJ4a/htrCnir2uetjc+u8Y3Yknw8scZ4HZyyncMc0Yl55cy7uuvSkmRm7GM
	 BTIqrjVheCDPB3463+z3JfhGqFIvAZuP0NdzwB9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbfCVLpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:45:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbfCVLph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:45:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C192218B0;
        Fri, 22 Mar 2019 11:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255136;
        bh=14K6QcrZIMwy1VNyACkwitEs+UFcU47o/OnCKsgMkmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tUW7XeGpi5qS3Haq7ypwzWtdcw6g4YNkJZIqSysudbYrjXz8Rwsnl+HgxFgZypRBj
         UAUq/NcVvFwcyJ+RGvbhNG2rtLWOrAM42prBp/ZNf4FWm0ATBPqUI0O/8Tc7tMKzkb
         jdpN7cJCkY8wGox3feX8iIA29Z7ZIAFn5qzef2Ig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 117/118] KVM: nVMX: Ignore limit checks on VMX instructions using flat segments
Date:   Fri, 22 Mar 2019 12:16:29 +0100
Message-Id: <20190322111224.541514316@linuxfoundation.org>
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

commit 34333cc6c2cb021662fd32e24e618d1b86de95bf upstream.

Regarding segments with a limit==0xffffffff, the SDM officially states:

    When the effective limit is FFFFFFFFH (4 GBytes), these accesses may
    or may not cause the indicated exceptions.  Behavior is
    implementation-specific and may vary from one execution to another.

In practice, all CPUs that support VMX ignore limit checks for "flat
segments", i.e. an expand-up data or code segment with base=0 and
limit=0xffffffff.  This is subtly different than wrapping the effective
address calculation based on the address size, as the flat segment
behavior also applies to accesses that would wrap the 4g boundary, e.g.
a 4-byte access starting at 0xffffffff will access linear addresses
0xffffffff, 0x0, 0x1 and 0x2.

Fixes: f9eb4af67c9d ("KVM: nVMX: VMX instructions: add checks for #GP/#SS exceptions")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7092,10 +7092,16 @@ static int get_vmx_mem_address(struct kv
 		/* Protected mode: #GP(0)/#SS(0) if the segment is unusable.
 		 */
 		exn = (s.unusable != 0);
-		/* Protected mode: #GP(0)/#SS(0) if the memory
-		 * operand is outside the segment limit.
+
+		/*
+		 * Protected mode: #GP(0)/#SS(0) if the memory operand is
+		 * outside the segment limit.  All CPUs that support VMX ignore
+		 * limit checks for flat segments, i.e. segments with base==0,
+		 * limit==0xffffffff and of type expand-up data or code.
 		 */
-		exn = exn || (off + sizeof(u64) > s.limit);
+		if (!(s.base == 0 && s.limit == 0xffffffff &&
+		     ((s.type & 8) || !(s.type & 4))))
+			exn = exn || (off + sizeof(u64) > s.limit);
 	}
 	if (exn) {
 		kvm_queue_exception_e(vcpu,


