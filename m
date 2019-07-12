Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568F3C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFD8208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934435;
	bh=jxuRC5RWgmFE6A1v+sw6c/9f28Z+K+sY/u9/2MPqFmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ll2Flby3cVmNQqMJ2jq9IdLg9qumXLOhiS7i27VbP0y5acH1scZRucUY6pbSZzrNK
	 NK8xL1SStqLizf1WBTz7iMqKecAL/IfplGHT2MWGycxrERELfxfgrPzVBbKfXCI5R3
	 hWtu1nDyj1P0lEBpgp2XidGAbdEAY4aliV9knSw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfGLM1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:27:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbfGLM1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:27:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9CFA21019;
        Fri, 12 Jul 2019 12:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934432;
        bh=jxuRC5RWgmFE6A1v+sw6c/9f28Z+K+sY/u9/2MPqFmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qa62tvIHtePOIGc6agk+V3uDD1Y+Fs8vQ9Zya1xMyf0m0BEU2pQr9g8UXkG2E8ySQ
         BOCJ8OWXuNwF83nqTy2UZEXYv0lGRhXQ+OrWQKNF4W6j4HzD1V4vDXiI+8iM2UXh6c
         kjfyZg9W10RRv96Z2AeBQ0hoq6gjMeAnJYfayLwQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 053/138] KVM: nVMX: use correct clean fields when copying from eVMCS
Date:   Fri, 12 Jul 2019 14:18:37 +0200
Message-Id: <20190712121630.701445555@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f9bc5227652df4900eff12a9b8b38e9a8c7c78ea ]

Unfortunately, a couple of mistakes were made while implementing
Enlightened VMCS support, in particular, wrong clean fields were
used in copy_enlightened_to_vmcs12():
- exception_bitmap is covered by CONTROL_EXCPN;
- vm_exit_controls/pin_based_vm_exec_control/secondary_vm_exec_control
  are covered by CONTROL_GRP1.

Fixes: 945679e301ea0 ("KVM: nVMX: add enlightened VMCS state")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/nested.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 5fa0c17d0b41..4ca834d22169 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1404,7 +1404,7 @@ static int copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx)
 	}
 
 	if (unlikely(!(evmcs->hv_clean_fields &
-		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_PROC))) {
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_EXCPN))) {
 		vmcs12->exception_bitmap = evmcs->exception_bitmap;
 	}
 
@@ -1444,7 +1444,7 @@ static int copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx)
 	}
 
 	if (unlikely(!(evmcs->hv_clean_fields &
-		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_HOST_GRP1))) {
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_CONTROL_GRP1))) {
 		vmcs12->pin_based_vm_exec_control =
 			evmcs->pin_based_vm_exec_control;
 		vmcs12->vm_exit_controls = evmcs->vm_exit_controls;
-- 
2.20.1



