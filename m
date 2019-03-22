Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962FEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D91D218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257471;
	bh=yiGsCWcDQ9I3eio8snQoFDZfvkha7ftCoXgMr+sc1Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ky15AiKI3hRt4Py9vB3nDgtw4+ug+lQQQkTU1zPEZGR1P9po2WjPGu/kx09m5eEVB
	 mnidMftsT4zlKPQYMh59YTj7pGbIgtk6Qmy98IYo6rWPP0+3qePW4jhJGqR9Wg1Y5A
	 zVrvoskbbmrjspF4zGSPgl15PTegRDK47WImKdX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403797AbfCVMYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403783AbfCVMY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:24:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB3AF2054F;
        Fri, 22 Mar 2019 12:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257465;
        bh=yiGsCWcDQ9I3eio8snQoFDZfvkha7ftCoXgMr+sc1Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpOqIeFQh15IG55pXOkhYZk5OydRV7YybkdhCRZDH4sSrNuh3Wx2b/J+r4Eng19lb
         PbdVy+0pzFiDjDev2wOtZWNgHZIcPDVdhQemFkYQJTWjTTI5UzPp4N2slR1tnkqhPv
         MiwqgZ1wZzt+/2/fqwJQqxttMxtbr6LR7NUVZK0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 231/238] KVM: nVMX: Ignore limit checks on VMX instructions using flat segments
Date:   Fri, 22 Mar 2019 12:17:30 +0100
Message-Id: <20190322111312.006994000@linuxfoundation.org>
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
 arch/x86/kvm/vmx/nested.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4102,10 +4102,16 @@ int get_vmx_mem_address(struct kvm_vcpu
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


