Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58534C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EC62089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfIKQHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:07:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbfIKQHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:07:09 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B993796FC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 16:07:09 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id b9so10629428wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 09:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B/S0TKkh///EsNRFEKwugE3C+En+WB89iDH3SdhNlRE=;
        b=UHB/Rl3/mMfHIvDY4NAVjBAIY9EzyiP+QGCfmkT64gazXf3EoYSHgjfOQcOzIM5mQ8
         /ZKm1ocsyJTGu2rSqLYH4pEiCylStu9UJm/dG/DXg1HpOh1shXq5KlJn+KZtZ/De4i/0
         SZZ60BjK2ofUp/ZN46pS2MbmTp5BZ3xAIcJNE/pap6l2prl81sK/28+0oe4cL+fx9VG/
         V5nRL69+Id/l2h0MAK0XJJSQhuXldt6ikE4x+73Yn465hb3f9NDc4WdP6olE5TVQZCcE
         LGYFqtJKURFWmszBkpXGVWN5F/ejcE//zElc74Er9MhYlLdKv10A37AXFqPhhxHfv9qP
         ASjg==
X-Gm-Message-State: APjAAAUgWTQCWpbhPAmDLZGGfvvKtgktVSEOG2jxupFHL0bhIVT9TDCE
        HRVWsiVpJ64StGCiTWcgg6rZDnbIRyeQEO15wKqLVa9dfqM2QNYLPBJN2rgGycf9qD400DULZc7
        qPRy76FkD+q15jtMKzj05j7/H
X-Received: by 2002:a1c:a6ca:: with SMTP id p193mr4509428wme.103.1568218028199;
        Wed, 11 Sep 2019 09:07:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz40/LD2YjoatJ8x8wP88TO4G3SZTOx+s9gIrPeXLOKq6V3pp00n5o0Rw4IO6/4fws059Z+TA==
X-Received: by 2002:a1c:a6ca:: with SMTP id p193mr4509410wme.103.1568218027958;
        Wed, 11 Sep 2019 09:07:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:102b:3795:6714:7df6? ([2001:b07:6468:f312:102b:3795:6714:7df6])
        by smtp.gmail.com with ESMTPSA id c8sm9314872wrr.49.2019.09.11.09.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 09:07:07 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: VMX: Stop the preemption timer during vCPU reset
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1567664788-10249-1-git-send-email-wanpengli@tencent.com>
 <1567664788-10249-2-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d7b46861-2787-f8c0-fa84-5368235db830@redhat.com>
Date:   Wed, 11 Sep 2019 18:06:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567664788-10249-2-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/19 08:26, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> The hrtimer which is used to emulate lapic timer is stopped during 
> vcpu reset, preemption timer should do the same.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 570a233..f794929 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4162,6 +4162,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  
>  	vcpu->arch.microcode_version = 0x100000000ULL;
>  	vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
> +	vmx->hv_deadline_tsc = -1;
>  	kvm_set_cr8(vcpu, 0);
>  
>  	if (!init_event) {
> 

Queued both, thanks.

Paolo
