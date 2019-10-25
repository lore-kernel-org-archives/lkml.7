Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39926CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B0221D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408848AbfJYJmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:42:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404139AbfJYJmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:42:51 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 53D254E83E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 09:42:51 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id o188so793771wmo.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 02:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Su5mUmgqqoSKIbW4drXCkRx6lRPLA56dSafb0hwckxU=;
        b=cg/XFJ15EBSpeAZd0whnqkwSYq5F6IocVPcYzWBrump1r2JK1q5vI84Nt5kfpzJToY
         BynwyvT0PoOrGBvZVWHi8BZQURJiPnhKvRJKfWrhBMFO7pASAdgDJsivkORmaiBEeS1S
         S8RmorykLuTipL7clFdHAoIphAm5F6a/IOimveHNAqJ+iTGcCDcx/TqMmlrY0FW5cokf
         FheDLghssIAS6ff2o2YFp5RYPjgm5m6sAmowc4b3+KwI0cWXIbzBwJ4xpQM5SBEutt87
         6aOtySTG/x4hxueV016P2EtNG8pXBzrz6UEZSimJmtJoKcrO7iPPFw/hsF2XCp65GZIB
         RejQ==
X-Gm-Message-State: APjAAAXlUX1nqHoWNkxn7xB68AHBM2nMeAb9PTrUQeIuAGy69SS0keKh
        Y9v+YgeR+yWOyabFFTS/CDQozID+TWPmGKVUAETI2HPNH+teR+0Ea3yqqlYHmD1MfvSj3wjmzlP
        tZqcExC+xSg3xhy06wN7aO2Bz
X-Received: by 2002:a5d:6203:: with SMTP id y3mr2121328wru.142.1571996569676;
        Fri, 25 Oct 2019 02:42:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw+TyMMcilll6N+0gfpVvf2epd/Br+KvMYhqCFFBhyze59q+zNxmdA4a3YGx9+9ftzm75BhtA==
X-Received: by 2002:a5d:6203:: with SMTP id y3mr2121303wru.142.1571996569391;
        Fri, 25 Oct 2019 02:42:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:302c:998e:a769:c583? ([2001:b07:6468:f312:302c:998e:a769:c583])
        by smtp.gmail.com with ESMTPSA id w9sm1705905wrt.85.2019.10.25.02.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 02:42:48 -0700 (PDT)
Subject: Re: [PATCH] KVM: avoid unnecessary bitmap clear ops
To:     Miaohe Lin <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1571970281-20083-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fcb852b8-d391-63d5-e0b6-558005481e45@redhat.com>
Date:   Fri, 25 Oct 2019 11:42:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1571970281-20083-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/19 04:24, Miaohe Lin wrote:
> When set one bit in bitmap, there is no need to
> clear it before.

Hi,

in general the Linux coding style prefers:

	a = x;
	if (...);
		a = y;

to

	if (...)
		a = y;
	else
		a = x;

which is why these lines were written this way.

Thanks,

Paolo

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/svm.c | 3 ++-
>  arch/x86/kvm/x86.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index ca200b50cde4..d997d011a942 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -2044,9 +2044,10 @@ static void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  	entry &= ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
>  	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
>  
> -	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
>  	if (svm->avic_is_running)
>  		entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
> +	else
> +		entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
>  
>  	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
>  	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ff395f812719..9b535888ea90 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1036,9 +1036,10 @@ static void kvm_update_dr7(struct kvm_vcpu *vcpu)
>  	else
>  		dr7 = vcpu->arch.dr7;
>  	kvm_x86_ops->set_dr7(vcpu, dr7);
> -	vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_BP_ENABLED;
>  	if (dr7 & DR7_BP_EN_MASK)
>  		vcpu->arch.switch_db_regs |= KVM_DEBUGREG_BP_ENABLED;
> +	else
> +		vcpu->arch.switch_db_regs &= ~KVM_DEBUGREG_BP_ENABLED;
>  }
>  
>  static u64 kvm_dr6_fixed(struct kvm_vcpu *vcpu)
> 

