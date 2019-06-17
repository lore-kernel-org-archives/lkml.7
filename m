Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EE8C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E0B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560807360;
	bh=s5fDWmwWmrDxUH/d22JDRo/fiF3jlxW6KHX6xmItwZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tl/H/FTXz4CqniHO1EEMflyh0yRsXqDutyQO8Ogbq8YbF4WXkgEYwKdA59/yEgxFA
	 eNH8OLmeBwRh43TsBIKCrtT2GkUrMSDMD3mOX6fs5N+Nfa7jAMOkChwZNiGKWx2oNF
	 vKvJ4xms6mOK4DsVkMkI+SbWlAqym8x+zen0sVAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfFQVf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729501AbfFQVWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:22:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E7D420861;
        Mon, 17 Jun 2019 21:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806536;
        bh=s5fDWmwWmrDxUH/d22JDRo/fiF3jlxW6KHX6xmItwZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJ70kvQ9HZsZPD/SBJQcudOSEDEY8fza83VGjDO2pS5xr1WkOuR2t03tw68Zv6bKz
         pG/mGd0R2iI21eA9OvSkDgzdMZMsv3WsI7lZPENvuEYcUOiaOTeMNLm2m4zyan1Ssn
         3bGvOPNOzCvsUUPgHe9KS3Q3Sks8wFLrVX2fYebA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 084/115] KVM: nVMX: really fix the size checks on KVM_SET_NESTED_STATE
Date:   Mon, 17 Jun 2019 23:09:44 +0200
Message-Id: <20190617210804.287554747@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit db80927ea1977a845230a161df643b48fd1e1ea4 ]

The offset for reading the shadow VMCS is sizeof(*kvm_state)+VMCS12_SIZE,
so the correct size must be that plus sizeof(*vmcs12).  This could lead
to KVM reading garbage data from userspace and not reporting an error,
but is otherwise not sensitive.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 8f6f69c26c35..5fa0c17d0b41 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5467,7 +5467,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	    vmcs12->vmcs_link_pointer != -1ull) {
 		struct vmcs12 *shadow_vmcs12 = get_shadow_vmcs12(vcpu);
 
-		if (kvm_state->size < sizeof(*kvm_state) + 2 * sizeof(*vmcs12))
+		if (kvm_state->size < sizeof(*kvm_state) + VMCS12_SIZE + sizeof(*vmcs12))
 			return -EINVAL;
 
 		if (copy_from_user(shadow_vmcs12,
-- 
2.20.1



