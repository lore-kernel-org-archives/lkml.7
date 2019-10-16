Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4B0FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A9B21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406545AbfJPQza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:55:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23521 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406111AbfJPQz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:55:29 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33DE12D6A0F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 16:55:29 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id j125so1465427wmj.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5eauZ8UWoa8Teikz+lMqufdR9RWWOJTpe6HYZySF3XQ=;
        b=hOzAAJFOqf8qVZVsLFsbswuOggUq73ly7AHHQEW+tlPzwS9Sh1SiHuUe8phvRlOZ76
         NNSOFwz2YMNL/GhN2UrFsxGWhO308FNH1xOihGfhZFkKYL4QADmGM9uyt7oqZ6HRdGYP
         TfmNxZVCyoP2VVOP0Bj9PrhTcsUQJ7hrw9Dh8Vq7bIQVHnwopPdGa9NhNBQjD6BHjDsv
         Fmhjone2NDjBm0bdgQCE4Ki8PMA4m79dXovKHBsentXe6jNUel5VNObQL8oN+LHrh10E
         /3FKaHi791ZVAc6fVZKuS3AxcptSWS1/DYBY+gMkqX+zn1jvGwFFmB8I03M/YPVf74em
         JhuA==
X-Gm-Message-State: APjAAAWsNRgkNXN2ii8/xLRnWYePHc6d06gi8ddpdFpkJRb8peMsePVJ
        ev2MWqn5x6PnjnKBO0LMVCBluyaCCxFtkv0o80zqVnvmPZYUu6joNQ+Lt4c9zlp6SF9sGxujSem
        Pda+nbDBA3qXcw+0nv0aaZDXD
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr4252060wmj.126.1571244927627;
        Wed, 16 Oct 2019 09:55:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyuvglafYRyO2dw3NYNU7hLZnq5YAdlC0kd1+/aDdwG5i7+O3zXN79X77AarslEyv0RfZFXgw==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr4252040wmj.126.1571244927345;
        Wed, 16 Oct 2019 09:55:27 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a71sm2976147wme.11.2019.10.16.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 09:55:26 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linmiaohe@huawei.com, mingfangsen@huawei.com, pbonzini@redhat.com,
        rkrcmar@redhat.com, sean.j.christopherson@intel.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: SVM: Fix potential wrong physical id in avic_handle_ldr_update
In-Reply-To: <1571217908-7693-1-git-send-email-linmiaohe@huawei.com>
References: <1571217908-7693-1-git-send-email-linmiaohe@huawei.com>
Date:   Wed, 16 Oct 2019 18:55:25 +0200
Message-ID: <87zhi03a0y.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> Guest physical APIC ID may not equal to vcpu->vcpu_id in some case.
> We may set the wrong physical id in avic_handle_ldr_update as we
> always use vcpu->vcpu_id.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/svm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index f8ecb6d..67cb5ba 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -4591,6 +4591,8 @@ static int avic_handle_ldr_update(struct kvm_vcpu *vcpu)
>  	int ret = 0;
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	u32 ldr = kvm_lapic_get_reg(vcpu->arch.apic, APIC_LDR);
> +	u32 apic_id_reg = kvm_lapic_get_reg(vcpu->arch.apic, APIC_ID);
> +	u32 id = (apic_id_reg >> 24) & 0xff;

If we reach here than we're guaranteed to be in xAPIC mode, right? Could
you maybe export and use kvm_xapic_id() here then (and in
avic_handle_apic_id_update() too)?

>  
>  	if (ldr == svm->ldr_reg)
>  		return 0;
> @@ -4598,7 +4600,7 @@ static int avic_handle_ldr_update(struct kvm_vcpu *vcpu)
>  	avic_invalidate_logical_id_entry(vcpu);
>  
>  	if (ldr)
> -		ret = avic_ldr_write(vcpu, vcpu->vcpu_id, ldr);
> +		ret = avic_ldr_write(vcpu, id, ldr);
>  
>  	if (!ret)
>  		svm->ldr_reg = ldr;

-- 
Vitaly
