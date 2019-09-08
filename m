Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E0AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C1D21A4C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946659;
	bh=WD7JZOmWMKwETyoeSdIpQDaUzS9OhQQvEvg9UVgNCsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OO6XookWVj80ClRkuFIyFYbcN7DCKGJvoJQBn39F1tkE19G2XaZ99Akf05bRu616H
	 JLWILP7QupTUfIfe5IcgZBvqKTOV0POYOAlp1qSY1t0w4NBlu6opJLWn7nqUpRz/O9
	 66EGAc5Rv9Q6k/bGtxWED3gdYq8Y8n+ddbN54xFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbfIHMoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbfIHMoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:44:12 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81980218DE;
        Sun,  8 Sep 2019 12:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946652;
        bh=WD7JZOmWMKwETyoeSdIpQDaUzS9OhQQvEvg9UVgNCsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYv11BsiFYeyZZbvDYHUPRKjlMbRV1G7z0520SbEzDEKZifIGcq/6tOiTHz0AjHLR
         uUdAWvBRuhyxMYyqyi85LqbPMm5HBL+nsm86s/y6DRSJHMik6pf9AZxdFGNGYbdIkl
         YfKh7S2CTV71WO8cE0qTgEVkyZgK+UacHuPQfZpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 16/26] KVM: arm/arm64: Only skip MMIO insn once
Date:   Sun,  8 Sep 2019 13:41:55 +0100
Message-Id: <20190908121106.124679233@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121057.216802689@linuxfoundation.org>
References: <20190908121057.216802689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



