Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4D3ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDE32133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfJIKk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:40:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfJIKk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:40:57 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62CF27EBAE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 10:40:57 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id k4so925872wru.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 03:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=abCd/PKSbtDlFwGQhdNXFUNQ7UiKs2xVKNU/aJBjBBk=;
        b=S4r7PWa3qaidb64I8KqUm7eIFgtTPK1Yg4EEKZADNBq7gasoh19Zapn4+FC3hS+Qcv
         zv/G/EwnT5kLNuJj8UiQUQlhqQXcOl2A0cOBbakO1lVaNCEzunHl1h+gDT+6w9fX0eWx
         X4rRvco9ULm9Rjj5yPkYtIKx8cOndmyMr2cRiH04efojcaM/5IEFq5yF451Aka9kPYGv
         wVyzCnmQRFxX+OWpEmw/rx2Wk+AWWBMR/Y8vFvetqNxJLdHGn23fUuAwCj2PlPfZiDoB
         GEiVu1Go/iycbWpbTDErXduoY2/6qVqKTIPTvmE78WNdTOGKXmSIG8LhGGwI3kJDuR9a
         xPxA==
X-Gm-Message-State: APjAAAXBliojnOqhgPzVO6S6OnPD/GamU2Ky6VHjoVXZz5xWPKxoY1lm
        MoMzb/yI8+t18n9Pzp/QU77BoMIrffU6wFOxg+X4L7AmBJvJob9j1Cef8NQIOjM4y51sl9bRhJS
        gFFOPLf+3JJUGlnyXBKXrj/DS
X-Received: by 2002:a1c:2681:: with SMTP id m123mr2216812wmm.92.1570617655928;
        Wed, 09 Oct 2019 03:40:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwT2x/b1oBSgwdq+6U7Wh93Jf0B2d8CCa3AaNhng0FeeOSIcddFsBpCniq0qNd7tXS1DtNUgg==
X-Received: by 2002:a1c:2681:: with SMTP id m123mr2216782wmm.92.1570617655636;
        Wed, 09 Oct 2019 03:40:55 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id d78sm1880033wmd.47.2019.10.09.03.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 03:40:55 -0700 (PDT)
Subject: Re: [PATCH v2 4/8] KVM: VMX: Optimize vmx_set_rflags() for
 unrestricted guest
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reto Buerki <reet@codelabs.ch>,
        Liran Alon <liran.alon@oracle.com>
References: <20190927214523.3376-1-sean.j.christopherson@intel.com>
 <20190927214523.3376-5-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <99e57095-d855-99d7-e10e-a415c6ef13b2@redhat.com>
Date:   Wed, 9 Oct 2019 12:40:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927214523.3376-5-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/19 23:45, Sean Christopherson wrote:
> Rework vmx_set_rflags() to avoid the extra code need to handle emulation
> of real mode and invalid state when unrestricted guest is disabled.  The
> primary reason for doing so is to avoid the call to vmx_get_rflags(),
> which will incur a VMREAD when RFLAGS is not already available.  When
> running nested VMs, the majority of calls to vmx_set_rflags() will occur
> without an associated vmx_get_rflags(), i.e. when stuffing GUEST_RFLAGS
> during transitions between vmcs01 and vmcs02.
> 
> Note, vmx_get_rflags() guarantees RFLAGS is marked available.

Slightly nicer this way:

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 8de9853d7ab6..62ab19d65efd 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1431,9 +1431,17 @@ unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
 void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	unsigned long old_rflags = vmx_get_rflags(vcpu);
+	unsigned long old_rflags;
+
+	if (enable_unrestricted_guest) {
+		__set_bit(VCPU_EXREG_RFLAGS, (ulong *)&vcpu->arch.regs_avail);
+		vmx->rflags = rflags;
+		vmcs_writel(GUEST_RFLAGS, rflags);
+		return;
+	}
+
+	old_rflags = vmx_get_rflags(vcpu);
 
-	__set_bit(VCPU_EXREG_RFLAGS, (ulong *)&vcpu->arch.regs_avail);
 	vmx->rflags = rflags;
 	if (vmx->rmode.vm86_active) {
 		vmx->rmode.save_rflags = rflags;

Paolo
