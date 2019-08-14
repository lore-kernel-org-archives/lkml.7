Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7F6C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E36E21721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802493;
	bh=Xdpt2zY/imvHs4oLSI3d+hTOzAVL2o8s930jvI2QNU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hUNyIIRILaBx9pPhrSXexHJi+vp3YSmRU1y3KGm9UoEL8OotCTbgP8WtZemw1qBFQ
	 LegvHtFNtaCz9ZzqZXykM/QWWKxzHcv2yLxhk9I9LGlw4b3q46Zwf1Dlchgqbwy2yP
	 GUBSIsrbm6t/nn3ZsHUbTAUZiyMkc6xxdJ+AQo0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbfHNRIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbfHNRIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:08:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22924214DA;
        Wed, 14 Aug 2019 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802490;
        bh=Xdpt2zY/imvHs4oLSI3d+hTOzAVL2o8s930jvI2QNU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3joxSzBpv6z2kbF8sm/ceIeoK1K58N+k+EchUCAeVkidY3M8PBq29VCKugTX85Tf
         3m0RuNEDSDNblSs7jkbqDllr+ksmvKLPskPiZfoSDQKJToqqOrH9OMqFvelay19JOJ
         iCTn4X14zakZB/9mbjnE2DwjX2pYoeQyHN3lB+YM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.2 120/144] KVM/nSVM: properly map nested VMCB
Date:   Wed, 14 Aug 2019 19:01:16 +0200
Message-Id: <20190814165804.946479142@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit 8f38302c0be2d2daf3b40f7d2142ec77e35d209e upstream.

Commit 8c5fbf1a7231 ("KVM/nSVM: Use the new mapping API for mapping guest
memory") broke nested SVM completely: kvm_vcpu_map()'s second parameter is
GFN so vmcb_gpa needs to be converted with gpa_to_gfn(), not the other way
around.

Fixes: 8c5fbf1a7231 ("KVM/nSVM: Use the new mapping API for mapping guest memory")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3290,7 +3290,7 @@ static int nested_svm_vmexit(struct vcpu
 				       vmcb->control.exit_int_info_err,
 				       KVM_ISA_SVM);
 
-	rc = kvm_vcpu_map(&svm->vcpu, gfn_to_gpa(svm->nested.vmcb), &map);
+	rc = kvm_vcpu_map(&svm->vcpu, gpa_to_gfn(svm->nested.vmcb), &map);
 	if (rc) {
 		if (rc == -EINVAL)
 			kvm_inject_gp(&svm->vcpu, 0);
@@ -3580,7 +3580,7 @@ static bool nested_svm_vmrun(struct vcpu
 
 	vmcb_gpa = svm->vmcb->save.rax;
 
-	rc = kvm_vcpu_map(&svm->vcpu, gfn_to_gpa(vmcb_gpa), &map);
+	rc = kvm_vcpu_map(&svm->vcpu, gpa_to_gfn(vmcb_gpa), &map);
 	if (rc) {
 		if (rc == -EINVAL)
 			kvm_inject_gp(&svm->vcpu, 0);


