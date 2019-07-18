Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A322DC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDB420880
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389279AbfGRH7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:59:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43337 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRH7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:59:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so27530754wru.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 00:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YU7xn75zhWNLYZOYfhl/a8jSpCY374NewaLRikXTmDo=;
        b=iB7F/QQfzIfmg2lc9Uv9N2aB086fDVQ1Qv0QIffj9ZNuMO12aB+UCnU5VWE+zBczUk
         R05u0TfmWJMX5wgrwnXA0H9V1oRBRXc4H+Ik++bRG2GiU0eot1jEgxsu+1CHPpkv07a/
         aPT2a9N4MVTmd0Oq7CloIB9earImWxE3Yp8afJghb9qYYbcTbULksYqpqE+toPLVqYKb
         sQETayVcFJD7ippUutx486NSALqj4xZq6nykBqAAu4vd1CLGl6gbUVrYF7KAWRMqgcaU
         ISKczCrxFmR4Ac+p4Z/xYJMSkjXhA+FsTMTZhlousmJ7zWsX68r5zUVZjrlRPTQPojVN
         H7Yg==
X-Gm-Message-State: APjAAAUG1WsAnx6YWYdKjt52UWlIoys4uwhFBc10gZ0Jkrze5XUvvqzu
        xT1tTMxeARyFpmGO76WDsO+EOQ==
X-Google-Smtp-Source: APXvYqzWOySTek5F18g1Rk+88tPU7Ltg9YyBhOWSMynJ49lXZcAstzow7qtQj3uQua/BgR9A1MHXIA==
X-Received: by 2002:a5d:4941:: with SMTP id r1mr46108607wrs.225.1563436761296;
        Thu, 18 Jul 2019 00:59:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2? ([2001:b07:6468:f312:e427:3beb:1110:dda2])
        by smtp.gmail.com with ESMTPSA id q18sm27264015wrw.36.2019.07.18.00.59.19
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 00:59:20 -0700 (PDT)
Subject: Re: [PATCH RESEND] KVM: Boosting vCPUs that are delivering interrupts
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <1562915730-9490-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f95fbf72-090f-fb34-3c20-64508979f251@redhat.com>
Date:   Thu, 18 Jul 2019 09:59:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562915730-9490-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/19 09:15, Wanpeng Li wrote:
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index b4ab59d..2c46705 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2404,8 +2404,10 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
>  	int me;
>  	int cpu = vcpu->cpu;
>  
> -	if (kvm_vcpu_wake_up(vcpu))
> +	if (kvm_vcpu_wake_up(vcpu)) {
> +		vcpu->preempted = true;
>  		return;
> +	}
>  
>  	me = get_cpu();
>  	if (cpu != me && (unsigned)cpu < nr_cpu_ids && cpu_online(cpu))
> 

Who is resetting vcpu->preempted to false in this case?  This also
applies to s390 in fact.

Paolo
