Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE93C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A72F2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbfFTLDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 07:03:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731450AbfFTLCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:02:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6FFCC0578FA;
        Thu, 20 Jun 2019 11:02:49 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AA565D9D2;
        Thu, 20 Jun 2019 11:02:48 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH RFC 3/5] x86: KVM: svm: clear interrupt shadow on all paths in skip_emulated_instruction()
Date:   Thu, 20 Jun 2019 13:02:38 +0200
Message-Id: <20190620110240.25799-4-vkuznets@redhat.com>
In-Reply-To: <20190620110240.25799-1-vkuznets@redhat.com>
References: <20190620110240.25799-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 20 Jun 2019 11:02:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regardless of the way how we skip instruction, interrupt shadow needs to be
cleared.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 68f1f0218c95..f980fc43372d 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -783,13 +783,15 @@ static void skip_emulated_instruction(struct kvm_vcpu *vcpu)
 				EMULATE_DONE)
 			pr_err_once("KVM: %s: unable to skip instruction\n",
 				    __func__);
-		return;
+		goto clear_int_shadow;
 	}
 	if (svm->next_rip - kvm_rip_read(vcpu) > MAX_INST_SIZE)
 		printk(KERN_ERR "%s: ip 0x%lx next 0x%llx\n",
 		       __func__, kvm_rip_read(vcpu), svm->next_rip);
 
 	kvm_rip_write(vcpu, svm->next_rip);
+
+clear_int_shadow:
 	svm_set_interrupt_shadow(vcpu, 0);
 }
 
-- 
2.20.1

