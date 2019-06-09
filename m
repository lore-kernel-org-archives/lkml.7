Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C71C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69092081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099547;
	bh=mG9WWvmiafGM1Jp5WLEKcKC1+c4dOrfZesDiegjzvaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OV4notavE0a5NNagqIRdzbIqFuJ/RXndPlaIGaf/WOBNLluZbfjdZE5g5Hi1D7FBX
	 ue81VVRplf1QSuNMZG7QlXlpBT7ZCt/y3/VI9rtU763974f2ClZLKXKHqKaRU0DCGR
	 1bddxfOf2zJEyKGvsMyHu3d9Wg0jP2JehHrK8vbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbfFIQ7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732775AbfFIQ7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:59:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D441204EC;
        Sun,  9 Jun 2019 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099543;
        bh=mG9WWvmiafGM1Jp5WLEKcKC1+c4dOrfZesDiegjzvaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJvrmaxG0QOl2g/HcY1hoBFRT4IHQs/v6W8E2+SY1wsGVaIhr/Q4VtTDFzFlCRlaP
         34pLB3TIAWWQ1VeyqiGc87k+2Ecc4AIxLFPxv5xf+mY1umih8pWTEuZxbCPPmCZXQT
         KoyGiz5LQhnwI9HfxMpUWZ/mHgTuuahta2Zr5xMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 077/241] KVM: x86: fix return value for reserved EFER
Date:   Sun,  9 Jun 2019 18:40:19 +0200
Message-Id: <20190609164149.995300080@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
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
@@ -1026,7 +1026,7 @@ static int set_efer(struct kvm_vcpu *vcp
 	u64 efer = msr_info->data;
 
 	if (efer & efer_reserved_bits)
-		return false;
+		return 1;
 
 	if (!msr_info->host_initiated) {
 		if (!__kvm_valid_efer(vcpu, efer))


