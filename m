Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3EDC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFDA233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102684;
	bh=TRr3eqjeN9vKj8xC4jj12Yb6FOLAm7jqEyir9I4h9EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IPeOYoKRC5P1iPbZPdCspzybaiPNvjORlyry7WpH9YO36t2WB+3EM7KKjkqK6AyQi
	 dqjFDd4hACo0zP52ucwoB/nGbVFOy9P2AbX491b2vxkl8VWe1t2LuKmmb0zd+lKyVz
	 saZOoxc2CvKCbP4C/GvnM8CoEiCCiVkX38rV5Sew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfH2SSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730291AbfH2SSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:18:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A1ED2189D;
        Thu, 29 Aug 2019 18:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102681;
        bh=TRr3eqjeN9vKj8xC4jj12Yb6FOLAm7jqEyir9I4h9EI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQdvdYVhbEQ1G6TCn+lISry9MJ6Xe1QtuftWk7a9MKHkUrgyQFTLTbnBc6qJUQKfj
         9cusz36Ef+xP2pL7Wni4MPgzUa31W2NDgL+V4Dx9Wd9nO6iK9xNvUBmIDn8UYdAUgA
         7H+W5HLfucGH+C7b2nDUr7Vpft9cf/XSRnXvLjBk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 4.9 16/16] KVM: arm/arm64: Only skip MMIO insn once
Date:   Thu, 29 Aug 2019 14:17:34 -0400
Message-Id: <20190829181736.9040-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181736.9040-1-sashal@kernel.org>
References: <20190829181736.9040-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Jones <drjones@redhat.com>

[ Upstream commit 2113c5f62b7423e4a72b890bd479704aa85c81ba ]

If after an MMIO exit to userspace a VCPU is immediately run with an
immediate_exit request, such as when a signal is delivered or an MMIO
emulation completion is needed, then the VCPU completes the MMIO
emulation and immediately returns to userspace. As the exit_reason
does not get changed from KVM_EXIT_MMIO in these cases we have to
be careful not to complete the MMIO emulation again, when the VCPU is
eventually run again, because the emulation does an instruction skip
(and doing too many skips would be a waste of guest code :-) We need
to use additional VCPU state to track if the emulation is complete.
As luck would have it, we already have 'mmio_needed', which even
appears to be used in this way by other architectures already.

Fixes: 0d640732dbeb ("arm64: KVM: Skip MMIO insn after emulation")
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kvm/mmio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kvm/mmio.c b/arch/arm/kvm/mmio.c
index 08443a15e6be8..3caee91bca089 100644
--- a/arch/arm/kvm/mmio.c
+++ b/arch/arm/kvm/mmio.c
@@ -98,6 +98,12 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	unsigned int len;
 	int mask;
 
+	/* Detect an already handled MMIO return */
+	if (unlikely(!vcpu->mmio_needed))
+		return 0;
+
+	vcpu->mmio_needed = 0;
+
 	if (!run->mmio.is_write) {
 		len = run->mmio.len;
 		if (len > sizeof(unsigned long))
@@ -200,6 +206,7 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	run->mmio.is_write	= is_write;
 	run->mmio.phys_addr	= fault_ipa;
 	run->mmio.len		= len;
+	vcpu->mmio_needed	= 1;
 
 	if (!ret) {
 		/* We handled the access successfully in the kernel. */
-- 
2.20.1

