Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA5DC31E5F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B589A2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806547;
	bh=V74ppKiDPTtoJkVaUg5yrN9xHpa08o9+cO9Vl17UQhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=njw/nzaM8jddxPaYsEuvF7F6eLRiv7Gt+W/zZOF3BbJETYOQgdspP032Skcx9AcRU
	 C9J22kO2iXR/YVQJWYOUa61qfiAn7FjBBpFW6lFZ+RKalK23cGA33CFQXnxTOAjHvn
	 XoF/asRTyeE8NyTXhJhR651pBsuJ67gAiK6XDadg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbfFQVWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729053AbfFQVWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:22:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE14D20B1F;
        Mon, 17 Jun 2019 21:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806542;
        bh=V74ppKiDPTtoJkVaUg5yrN9xHpa08o9+cO9Vl17UQhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gEyCHbc3aoNy7PaNfWp68x3sMVxRMaqEplpCUV39x7UAKNgeD7Bfsj7vRXtgrNjqk
         94TMQQqigCZNLOcn2VbQFNGEfU9cLm9SXKUQru5XC0syaWV2du/y9VThHgR3u5xf5Y
         VsqSxca7HqRvOgNbiXn2yc+3ZlrFyFzEhwVhNE04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yi Wang <wang.yi59@zte.com.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 086/115] kvm: vmx: Fix -Wmissing-prototypes warnings
Date:   Mon, 17 Jun 2019 23:09:46 +0200
Message-Id: <20190617210804.371263954@linuxfoundation.org>
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

[ Upstream commit 4d259965655c92053f3255aca14d81aab1e21219 ]

We get a warning when build kernel W=1:
arch/x86/kvm/vmx/vmx.c:6365:6: warning: no previous prototype for ‘vmx_update_host_rsp’ [-Wmissing-prototypes]
 void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp)

Add the missing declaration to fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx/vmx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index f879529906b4..9cd72decdfe4 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -314,6 +314,7 @@ void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
 void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
 struct shared_msr_entry *find_msr_entry(struct vcpu_vmx *vmx, u32 msr);
 void pt_update_intercept_for_msr(struct vcpu_vmx *vmx);
+void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp);
 
 #define POSTED_INTR_ON  0
 #define POSTED_INTR_SN  1
-- 
2.20.1



