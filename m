Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85006C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5642C249BC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186466;
	bh=56vgd8SDkEUz3UFrrp79KWlabZkIwvwexkR8pA6e3O8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PswNTyD0jkoKmXRIz9z0E7x0SWcj+RKvfW6nrffbF3hvvy9yekxwdw/KG2gZiaR/m
	 5MKJne5+PeNmHpt6zZhHhO3pDDu4hx+87Ta1SaROXZXmgBFJ/dwcbzpOrDBERR9kza
	 GLcLw8gFsBJBKOj3EH2w34i9n2bSOpBTqsUBU1eQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732445AbfE3DVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:21:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730622AbfE3DQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:13 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA3E1245AB;
        Thu, 30 May 2019 03:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186172;
        bh=56vgd8SDkEUz3UFrrp79KWlabZkIwvwexkR8pA6e3O8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pgQgAc94r1kaZGI8HiUMA+3fTiqH0Ve2N561khZkvTrRixvtlgD6/wP1YhqeFo3K/
         +ips+2p8BmlKpGnILyAn2zbi5qh9vsm+mbnQ7s7gC9ebtHOeMF3D3dmqHoJglCRMAu
         PWvnW+flSiTIHeKX2pIvcIh+GiO1kqmAx8Qtzucg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 005/276] KVM: x86: fix return value for reserved EFER
Date:   Wed, 29 May 2019 20:02:43 -0700
Message-Id: <20190530030523.731037078@linuxfoundation.org>
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
@@ -1188,7 +1188,7 @@ static int set_efer(struct kvm_vcpu *vcp
 	u64 efer = msr_info->data;
 
 	if (efer & efer_reserved_bits)
-		return false;
+		return 1;
 
 	if (!msr_info->host_initiated) {
 		if (!__kvm_valid_efer(vcpu, efer))


