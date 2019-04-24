Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D2AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15BB2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127685;
	bh=y/0aG/HlXwylPub4CXxvzD6seuHsVyZ2rZPp/lGFBoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ogjsnQSsSnEBd+B7ENLPAXszahXji1HOolAuePLWjHS9ssQ6eHb8S1Tw3U2BqK3y0
	 YS5D0bQom8bEtPWTX2jtrDdN51NXSUpMLYGeAq/gnCfWMaCbxH3ZUsPD4FgofeVZbk
	 mJcjOVn4NAUxJZrvyQyBBULwp3dip3e/dP9TnYbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404056AbfDXRlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392161AbfDXRgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:46 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFB852054F;
        Wed, 24 Apr 2019 17:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127405;
        bh=y/0aG/HlXwylPub4CXxvzD6seuHsVyZ2rZPp/lGFBoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wTtwzA67PvfbVI5Nq9IwrOCNsdM8ZnW3e/ewbx45yRjwFnVHZt/JETm0XuEO4tzpo
         a8UJMnWmXx0L1RFHEB37bcnO8QoHZVdROVTy9sNgZQZfkiQyOqlC8ODGHrntMyY8zp
         JJ0Z2AnOEyJyMB4UqehXAin/9AvlOaYwooFi0xYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Oren Twaig <oren@scalemp.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 5.0 080/115] Revert "svm: Fix AVIC incomplete IPI emulation"
Date:   Wed, 24 Apr 2019 19:10:16 +0200
Message-Id: <20190424170929.659823680@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>

commit 4a58038b9e420276157785afa0a0bbb4b9bc2265 upstream.

This reverts commit bb218fbcfaaa3b115d4cd7a43c0ca164f3a96e57.

As Oren Twaig pointed out the old discussion:

  https://patchwork.kernel.org/patch/8292231/

that the change coud potentially cause an extra IPI to be sent to
the destination vcpu because the AVIC hardware already set the IRR bit
before the incomplete IPI #VMEXIT with id=1 (target vcpu is not running).
Since writting to ICR and ICR2 will also set the IRR. If something triggers
the destination vcpu to get scheduled before the emulation finishes, then
this could result in an additional IPI.

Also, the issue mentioned in the commit bb218fbcfaaa was misdiagnosed.

Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Reported-by: Oren Twaig <oren@scalemp.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -4515,14 +4515,25 @@ static int avic_incomplete_ipi_intercept
 		kvm_lapic_reg_write(apic, APIC_ICR, icrl);
 		break;
 	case AVIC_IPI_FAILURE_TARGET_NOT_RUNNING: {
+		int i;
+		struct kvm_vcpu *vcpu;
+		struct kvm *kvm = svm->vcpu.kvm;
 		struct kvm_lapic *apic = svm->vcpu.arch.apic;
 
 		/*
-		 * Update ICR high and low, then emulate sending IPI,
-		 * which is handled when writing APIC_ICR.
+		 * At this point, we expect that the AVIC HW has already
+		 * set the appropriate IRR bits on the valid target
+		 * vcpus. So, we just need to kick the appropriate vcpu.
 		 */
-		kvm_lapic_reg_write(apic, APIC_ICR2, icrh);
-		kvm_lapic_reg_write(apic, APIC_ICR, icrl);
+		kvm_for_each_vcpu(i, vcpu, kvm) {
+			bool m = kvm_apic_match_dest(vcpu, apic,
+						     icrl & KVM_APIC_SHORT_MASK,
+						     GET_APIC_DEST_FIELD(icrh),
+						     icrl & KVM_APIC_DEST_MASK);
+
+			if (m && !avic_vcpu_is_running(vcpu))
+				kvm_vcpu_wake_up(vcpu);
+		}
 		break;
 	}
 	case AVIC_IPI_FAILURE_INVALID_TARGET:


