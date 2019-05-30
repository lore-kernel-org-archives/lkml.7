Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC931C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A6924CA5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187939;
	bh=SAzFDsewiCPjzYSPONmROVQkzi0S0thIkqhQiidclBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bhaCE8MbyXnVyYverg9sLTvsb/9ALfFBwyrAE6pHpgnHgutIggehGKhBaN0rAK1p3
	 N4gFAGlIE/OgxfHUBn1oCtPAJxAslwrrvsA/ANcqJpqC672C3jVoG0fAiC7N9OPIjL
	 0zZgYkh7+WbYfqsJYV/H6uJbHw7MR+9z+I+YqeI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfE3DUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:20:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730575AbfE3DQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:03 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E46A624585;
        Thu, 30 May 2019 03:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186163;
        bh=SAzFDsewiCPjzYSPONmROVQkzi0S0thIkqhQiidclBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NdE86ixMWWnnsYFBD+PrU56kziJSm0vPZhqpmL2cml/i3gNvXwYCjVQq10IhCBA0M
         Hv2uZlUXFmB2oteWSzj0MvOMfeFcuwPsV2hOIqYGDfBJAmDjqnHVxc+b4mWm43rkrW
         MpxSRPRdbWJCknwtPV8mUIFAU997mUO4jro07wrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 012/276] kvm: svm/avic: fix off-by-one in checking host APIC ID
Date:   Wed, 29 May 2019 20:02:50 -0700
Message-Id: <20190530030524.513568972@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>

commit c9bcd3e3335d0a29d89fabd2c385e1b989e6f1b0 upstream.

Current logic does not allow VCPU to be loaded onto CPU with
APIC ID 255. This should be allowed since the host physical APIC ID
field in the AVIC Physical APIC table entry is an 8-bit value,
and APIC ID 255 is valid in system with x2APIC enabled.
Instead, do not allow VCPU load if the host APIC ID cannot be
represented by an 8-bit value.

Also, use the more appropriate AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK
instead of AVIC_MAX_PHYSICAL_ID_COUNT.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2022,7 +2022,11 @@ static void avic_vcpu_load(struct kvm_vc
 	if (!kvm_vcpu_apicv_active(vcpu))
 		return;
 
-	if (WARN_ON(h_physical_id >= AVIC_MAX_PHYSICAL_ID_COUNT))
+	/*
+	 * Since the host physical APIC id is 8 bits,
+	 * we can support host APIC ID upto 255.
+	 */
+	if (WARN_ON(h_physical_id > AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
 		return;
 
 	entry = READ_ONCE(*(svm->avic_physical_id_cache));


