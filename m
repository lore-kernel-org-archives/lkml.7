Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2729FC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC2C24494
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185795;
	bh=2W0LCAp+js594ct7JLGSdDfTbTh5tQVJFIJpPYJMW8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tYrUy/k1kcJNoRzLvzfZtPvqTb3SAwOxBGJsQVL/US/jiGcqZ+XFZhRXiWbxQGrV/
	 2jG3hy2UCLeJn+CnSHIYJVigrHIDtnyoNjR/6zI8N39BovEg7cixlhNYdVDoLIlDLf
	 AU6MB+/tHD5mJZwhz4uFMECF6bJLYKA1vwJmRTu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfE3DJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbfE3DJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:09:40 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F3522447B;
        Thu, 30 May 2019 03:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185780;
        bh=2W0LCAp+js594ct7JLGSdDfTbTh5tQVJFIJpPYJMW8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8TXreuDLI04VU+nAJZtxhZR4tq55dM+n1jvrv+6ctLbw9QPL4Jd0kCA5cpqXcN98
         4EkSsGCwAANv4rmmxUsRojdFA37DwobrsjGaAbJFM+tX6PdM0+XcAri/465RBkV+tA
         63a1BcTrWM5V0B5TtaqantKrHVJPA66KohbuB5O0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.1 004/405] KVM: x86: fix return value for reserved EFER
Date:   Wed, 29 May 2019 20:00:02 -0700
Message-Id: <20190530030540.572663263@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 66f61c92889ff3ca365161fb29dd36d6354682ba upstream.

Commit 11988499e62b ("KVM: x86: Skip EFER vs. guest CPUID checks for
host-initiated writes", 2019-04-02) introduced a "return false" in a
function returning int, and anyway set_efer has a "nonzero on error"
conventon so it should be returning 1.

Reported-by: Pavel Machek <pavel@denx.de>
Fixes: 11988499e62b ("KVM: x86: Skip EFER vs. guest CPUID checks for host-initiated writes")
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1288,7 +1288,7 @@ static int set_efer(struct kvm_vcpu *vcp
 	u64 efer = msr_info->data;
 
 	if (efer & efer_reserved_bits)
-		return false;
+		return 1;
 
 	if (!msr_info->host_initiated) {
 		if (!__kvm_valid_efer(vcpu, efer))


