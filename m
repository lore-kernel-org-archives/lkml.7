Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127B4C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64EE20684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKAuMwAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfFFPYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:24:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39920 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfFFPYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:24:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so2872856wrt.6;
        Thu, 06 Jun 2019 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=Dw7cSZKWSMHArIj0WE4OX73VU5F8NKFc8iS3jVX8wfA=;
        b=JKAuMwAUtM3lwNbrNBHRPimCVUS7ar4ByI57V4EzbX/Yl+nxMc+cj4EW6kxdUNL0XZ
         koDvgghquI7tWBrEXpkXr5BkMB48j7Mz5qjcW1y6Hhhyw9AIBphuIczkzVebcLGUKCyS
         rOov1wQwEvqn/t8EpnmkRxgpT9/hijreNwX3ZPqH9yRv7SQnW3gIeepx7uDDLmzn6uRK
         0ao42nX69iIc9qsm3Y3euGD5NRg1NsBccVjjG6uxeQ4xEWfKiIx3MZrLwz72/850tX4d
         cg3Thxon0hTleGfB1bflvY/mmsYrhlq1rqj3XSBk+m36E9mK4d75S+qJMlf1NCnYDc6q
         bhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=Dw7cSZKWSMHArIj0WE4OX73VU5F8NKFc8iS3jVX8wfA=;
        b=ryaJ373XuayjGFgHr2Idk2OEoEMx/Ek+NEA936v+dtalPym3bIVjmI+cLKCf6ACgCh
         EPmTUMSbXkc6weWGWw6wu3X8Em38Rqg76m4rZ9vMp42j6jz5nqLEhcU4dJo/WSZFDojQ
         JiL0dB1SnOXTDT05PDg/p1/FPZYuQ+x5HIrUi4kAmXp3ET876pj3+aZpFSj3UYrEeDKF
         20fy0/EAUjvOJo66pR1S09PNopr4LFZ2g3Yl0lyYMs+Ksz5Mf6ojwC3j6OfrpFPeNgV+
         Fad2r27NmRJSE94gD4864uCu8jRFhyMv8evTySp8ms+qcNjHMRIWOcCTiyHiKIYuVhOi
         7ERA==
X-Gm-Message-State: APjAAAVfxxc/T/kqZJzuRsCKE73IadZFsAN9gv2P561yu5au4ZAZWMIj
        dCvsgbJYKz1Wl2nJQi6TL5Z4MD2u
X-Google-Smtp-Source: APXvYqzpZkC5OsC1ZQmgT2sTgOXps5WBuf7vaWyQ4c6fyFaFBRLWWCveFz57MNXev4TGtkn/W1/4Lg==
X-Received: by 2002:a5d:518c:: with SMTP id k12mr30501567wrv.322.1559834655328;
        Thu, 06 Jun 2019 08:24:15 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id j132sm2641937wmj.21.2019.06.06.08.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 08:24:13 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] KVM: nVMX: Rename prepare_vmcs02_*_full to prepare_vmcs02_*_extra
Date:   Thu,  6 Jun 2019 17:24:12 +0200
Message-Id: <1559834652-105872-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These function do not prepare the entire state of the vmcs02, only the
rarely needed parts.  Rename them to make this clearer.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 84438cf23d37..fd8150ef6cce 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1955,7 +1955,7 @@ static void prepare_vmcs02_constant_state(struct vcpu_vmx *vmx)
 	vmx_set_constant_host_state(vmx);
 }
 
-static void prepare_vmcs02_early_full(struct vcpu_vmx *vmx,
+static void prepare_vmcs02_early_extra(struct vcpu_vmx *vmx,
 				      struct vmcs12 *vmcs12)
 {
 	prepare_vmcs02_constant_state(vmx);
@@ -1976,7 +1976,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 	u64 guest_efer = nested_vmx_calc_efer(vmx, vmcs12);
 
 	if (vmx->nested.dirty_vmcs12 || vmx->nested.hv_evmcs)
-		prepare_vmcs02_early_full(vmx, vmcs12);
+		prepare_vmcs02_early_extra(vmx, vmcs12);
 
 	/*
 	 * PIN CONTROLS
@@ -2130,7 +2130,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 	}
 }
 
-static void prepare_vmcs02_full(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
+static void prepare_vmcs02_extra(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 {
 	struct hv_enlightened_vmcs *hv_evmcs = vmx->nested.hv_evmcs;
 
@@ -2254,7 +2254,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
 	if (vmx->nested.dirty_vmcs12 || vmx->nested.hv_evmcs) {
-		prepare_vmcs02_full(vmx, vmcs12);
+		prepare_vmcs02_extra(vmx, vmcs12);
 		vmx->nested.dirty_vmcs12 = false;
 	}
 
-- 
1.8.3.1

