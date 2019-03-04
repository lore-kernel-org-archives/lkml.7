Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CD4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9882820863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687817;
	bh=756n/tYO6jVzTOzUswmDItDtd6JSro0DHH+jPmgv2vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RADdfXOHuk3M8Y2ZJjZfp9wVJN7zk68RhW/wrCIpVKMMh29ttmHQBIZshvbxisvA6
	 Wd2Ronf57Mo3vcvreebMVIkWZBQeIg+VzcnidiH2cQKLNk8QNJYEHSalpNOMBHdAuR
	 nzjQyduzC9vpUPj3ezuQqGTBMTlc13HyxjnDR4rk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfCDIXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:23:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfCDIXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:23:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 887DC20823;
        Mon,  4 Mar 2019 08:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687811;
        bh=756n/tYO6jVzTOzUswmDItDtd6JSro0DHH+jPmgv2vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wsJft+BVN9yWTqtv1LnMfH/B+a9UAXhS3aGZ9fAD3koSHoZ+TgZtP9VAe7ei+6oI/
         ID269jU+0nQVJRQOvkj5rAQBpGToQoaqTG3AjyS1B1EomMeAbk8bYfMeTaL03buWdK
         /Z3Uip0sPrcSucBTXHsDrJTeTEcEuq8Kjk+MEXW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 27/32] svm: Fix AVIC incomplete IPI emulation
Date:   Mon,  4 Mar 2019 09:22:15 +0100
Message-Id: <20190304081604.297725172@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
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

[ Upstream commit bb218fbcfaaa3b115d4cd7a43c0ca164f3a96e57 ]

In case of incomplete IPI with invalid interrupt type, the current
SVM driver does not properly emulate the IPI, and fails to boot
FreeBSD guests with multiple vcpus when enabling AVIC.

Fix this by update APIC ICR high/low registers, which also
emulate sending the IPI.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index c8efacf2e65f1..afc2bd03b4d9e 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3932,25 +3932,14 @@ static int avic_incomplete_ipi_interception(struct vcpu_svm *svm)
 		kvm_lapic_reg_write(apic, APIC_ICR, icrl);
 		break;
 	case AVIC_IPI_FAILURE_TARGET_NOT_RUNNING: {
-		int i;
-		struct kvm_vcpu *vcpu;
-		struct kvm *kvm = svm->vcpu.kvm;
 		struct kvm_lapic *apic = svm->vcpu.arch.apic;
 
 		/*
-		 * At this point, we expect that the AVIC HW has already
-		 * set the appropriate IRR bits on the valid target
-		 * vcpus. So, we just need to kick the appropriate vcpu.
+		 * Update ICR high and low, then emulate sending IPI,
+		 * which is handled when writing APIC_ICR.
 		 */
-		kvm_for_each_vcpu(i, vcpu, kvm) {
-			bool m = kvm_apic_match_dest(vcpu, apic,
-						     icrl & KVM_APIC_SHORT_MASK,
-						     GET_APIC_DEST_FIELD(icrh),
-						     icrl & KVM_APIC_DEST_MASK);
-
-			if (m && !avic_vcpu_is_running(vcpu))
-				kvm_vcpu_wake_up(vcpu);
-		}
+		kvm_lapic_reg_write(apic, APIC_ICR2, icrh);
+		kvm_lapic_reg_write(apic, APIC_ICR, icrl);
 		break;
 	}
 	case AVIC_IPI_FAILURE_INVALID_TARGET:
-- 
2.19.1



