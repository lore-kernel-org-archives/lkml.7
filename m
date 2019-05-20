Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A2DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED1D20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbfETM4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:56:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34836 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732625AbfETM4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:56:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id q15so12934447wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 05:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=POdzCkn+BD1xo1P2qkRXdnWiMHzE1h+gIx0vGRX+ho8=;
        b=WjxLLvzhcm86lah3jHAQ5NfVUiRYqo2VNMR4YMXmcKYnCJjML3+nCqe2Nz2z3rFvsv
         ONS4vjSHklbVBT0OhR6tWM2woZZEQqIhTk358V0/7MaxmLD1gbRLTz3vEHA2U71wVfj8
         IJt3RDtN+6TjRMB7kNUpBwq5KSHKlpgvsWmH7m71B3TRqxmgmxaqq3yuEmeaInUcnTJM
         1ogrcN3D5SUY60zXGGA+7W6mOViam4LEGTmnoFBcxuc1edYm7R88N0uPddTfKmf03HhZ
         1yJ7zkVjdnwnvlWALxgpe6XYUihag7kYcwSeoXQs7lcfk0QByVydEHlVSedx+OsnPoyb
         txGg==
X-Gm-Message-State: APjAAAV/TOY1RTXlsdlYOHVmhx8yJRd7HELtWogNdP2VZJxS8MGU2Wej
        FcmKIS4j+7MW4ZCyqXoUpmsqNA==
X-Google-Smtp-Source: APXvYqx5pXXCwxwx4x3VvqGSmM62foFIjaxcXPie2D4bBE9OAyupnN+bbaEloCiMX9qJ4TNU8ne+BQ==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr7138843wmk.67.1558356962715;
        Mon, 20 May 2019 05:56:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844? ([2001:b07:6468:f312:ac04:eef9:b257:b844])
        by smtp.gmail.com with ESMTPSA id a10sm20115664wrm.94.2019.05.20.05.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 05:56:02 -0700 (PDT)
Subject: Re: [PATCH] svm/avic: Do not send AVIC doorbell to self
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>
References: <1556890721-9613-1-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4275b74a-a228-d2a3-cb7d-5abce0a86f59@redhat.com>
Date:   Mon, 20 May 2019 14:56:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556890721-9613-1-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/19 15:38, Suthikulpanit, Suravee wrote:
> AVIC doorbell is used to notify a running vCPU that interrupts
> has been injected into the vCPU AVIC backing page. Current logic
> checks only if a VCPU is running before sending a doorbell.
> However, the doorbell is not necessary if the destination
> CPU is itself.
> 
> Add logic to check currently running CPU before sending doorbell.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kvm/svm.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 122788f..4bbf6fc 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5283,10 +5283,13 @@ static void svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
>  	kvm_lapic_set_irr(vec, vcpu->arch.apic);
>  	smp_mb__after_atomic();
>  
> -	if (avic_vcpu_is_running(vcpu))
> -		wrmsrl(SVM_AVIC_DOORBELL,
> -		       kvm_cpu_get_apicid(vcpu->cpu));
> -	else
> +	if (avic_vcpu_is_running(vcpu)) {
> +		int cpuid = vcpu->cpu;
> +
> +		if (cpuid != get_cpu())
> +			wrmsrl(SVM_AVIC_DOORBELL, kvm_cpu_get_apicid(cpuid));
> +		put_cpu();
> +	} else
>  		kvm_vcpu_wake_up(vcpu);
>  }
>  
> 

Queued, thanks.

Paolo
