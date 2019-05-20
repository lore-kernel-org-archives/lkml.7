Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBE9C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2439D20675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbfETKao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:30:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52860 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfETKao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:30:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id y3so12720263wmm.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 03:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0PmYvULW8b+vhtRBg4p2Q8VUlpSkSvMV+uikqOEEQ0M=;
        b=TmodBsiif1DqOIDzY6XTBpa2f+Yy0mvyBXcVLtO1vvY/uVTiilck4eS2+XM6CCgG8Y
         A3KDVGqEVJ/NkiE5Q6Qxy9Wwj9JorLLE6UNJ7ZfijZXxkk6J2Sq5cssQAh6XJmnxi4Y2
         nNT5PyAPP3K9d9mfcL8ZPdSKMGID5Yzf5tnv0oMgECSz8N6SQT2KiCiQEOr1pkEOJTOx
         /1NiHfnnkSZY1g9EH2IlcLxhbZh7yaw9MSQVO4YCUCJjO1fY++GCZ9V+YJiN0ny2/JEo
         RGVSWrkFQX3DUNK+l80sQpr3kB3YQrY0X/j//2blHdIua9fJU+z63pI0OynKkt8hYelV
         0ZvA==
X-Gm-Message-State: APjAAAUAY2ruILbS6yiQGu9NNZ46d1H48DMvK7rAMPtifvlceSYYijnM
        f9vJr8k318czm7EMbozzabxPlw==
X-Google-Smtp-Source: APXvYqy8mwAvgC577RNezQmaz8YthJFOSgFun9/nFroItHZdPx2TxQO2lK0CONgi/ac8AFIc3xOCBg==
X-Received: by 2002:a1c:f910:: with SMTP id x16mr11906527wmh.132.1558348242247;
        Mon, 20 May 2019 03:30:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id u2sm26308457wra.82.2019.05.20.03.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 03:30:41 -0700 (PDT)
Subject: Re: [PATCH 1/4] KVM: x86: Disable intercept for CORE cstate read
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>
References: <1558082990-7822-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7787e0cb-2c46-b5b5-94ea-72c061ea0235@redhat.com>
Date:   Mon, 20 May 2019 12:30:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558082990-7822-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/19 10:49, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Allow guest reads CORE cstate when exposing host CPU power management capabilities 
> to the guest. PKG cstate is restricted to avoid a guest to get the whole package 
> information in multi-tenant scenario.

Hmm, I am not sure about this.  I can see why it can be useful to run
turbostat in the guest, but is it a good idea to share it with the
guest, since it counts from machine reset rather than from VM reset?

Maybe it could use a separate bit for KVM_CAP_X86_DISABLE_EXITS?

Thanks,

Paolo

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 771d3bf..b0d6be5 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6615,6 +6615,12 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
>  	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_CS, MSR_TYPE_RW);
>  	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_ESP, MSR_TYPE_RW);
>  	vmx_disable_intercept_for_msr(msr_bitmap, MSR_IA32_SYSENTER_EIP, MSR_TYPE_RW);
> +	if (kvm_mwait_in_guest(kvm)) {
> +		vmx_disable_intercept_for_msr(msr_bitmap, MSR_CORE_C1_RES, MSR_TYPE_R);
> +		vmx_disable_intercept_for_msr(msr_bitmap, MSR_CORE_C3_RESIDENCY, MSR_TYPE_R);
> +		vmx_disable_intercept_for_msr(msr_bitmap, MSR_CORE_C6_RESIDENCY, MSR_TYPE_R);
> +		vmx_disable_intercept_for_msr(msr_bitmap, MSR_CORE_C7_RESIDENCY, MSR_TYPE_R);
> +	}
>  	vmx->msr_bitmap_mode = 0;
>  
>  	vmx->loaded_vmcs = &vmx->vmcs01;
> 

