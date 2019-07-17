Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1075C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABED20880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 10:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfGQKXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:23:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43909 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfGQKXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 06:23:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so24153883wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 03:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OgDJWdqKExQDn29jdefxbq2X4b+zlsDENGAuQ8C2S/0=;
        b=YmWlUbrCibszo4fUeAuBOgHQSi5mc/fx7KKR1j/jndMJJUOuzDaAFNIVUTRgDqPb3o
         XZup5p/S1+g4KKOjLWRdsgi7fGOB4ubckaU73qIV6rKBdaDoRHe9IreB3yFSiWzJ3bqs
         NPY8fGiQ6VWUF0suDdR4FfkAftA47KO5WDagZFYEv9Ubn98LO0R2ifK8Mn7da3LARXgb
         HixTNdSwxG9UYg9j6lTXdSNS0y4RbKEQmgR7kfXQHkABuQWikD0a3pHUm5/jPlYXMjBs
         yIHjPbuyi47w7sGRDqbV8NoUQbQf8OxE7N4HASnzrS2nsbOPdYR2STzZqxiFjdU+ksjB
         8hzA==
X-Gm-Message-State: APjAAAV6oSnSF4HMH4cDV4fl2io+kx+ui6JNRHjne0D8AzY1BlkXyN5s
        9C30MIngUdKGIsT3qvR8jMn8LminD50EDw==
X-Google-Smtp-Source: APXvYqwr7wStccjcUL3kS2LjSeL9qna9HUuZyfa6OlP+sb0srZC6+du92eULywd0hzhEbzXZw6cr5g==
X-Received: by 2002:a05:6000:187:: with SMTP id p7mr39272926wrx.189.1563359008856;
        Wed, 17 Jul 2019 03:23:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2? ([2001:b07:6468:f312:e427:3beb:1110:dda2])
        by smtp.gmail.com with ESMTPSA id t24sm21805289wmj.14.2019.07.17.03.23.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 03:23:28 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/vPMU: reset pmc->counter to 0 for pmu
 fixed_counters
To:     Like Xu <like.xu@linux.intel.com>
Cc:     wehuang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190717025118.16783-1-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <20682ae6-5699-3963-318e-55a177ccd57f@redhat.com>
Date:   Wed, 17 Jul 2019 12:23:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717025118.16783-1-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/19 04:51, Like Xu wrote:
> To avoid semantic inconsistency, the fixed_counters in Intel vPMU
> need to be reset to 0 in intel_pmu_reset() as gp_counters does.
> 
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 68d231d49c7a..4dea0e0e7e39 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -337,17 +337,22 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
>  static void intel_pmu_reset(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	struct kvm_pmc *pmc = NULL;
>  	int i;
>  
>  	for (i = 0; i < INTEL_PMC_MAX_GENERIC; i++) {
> -		struct kvm_pmc *pmc = &pmu->gp_counters[i];
> +		pmc = &pmu->gp_counters[i];
>  
>  		pmc_stop_counter(pmc);
>  		pmc->counter = pmc->eventsel = 0;
>  	}
>  
> -	for (i = 0; i < INTEL_PMC_MAX_FIXED; i++)
> -		pmc_stop_counter(&pmu->fixed_counters[i]);
> +	for (i = 0; i < INTEL_PMC_MAX_FIXED; i++) {
> +		pmc = &pmu->fixed_counters[i];
> +
> +		pmc_stop_counter(pmc);
> +		pmc->counter = 0;
> +	}
>  
>  	pmu->fixed_ctr_ctrl = pmu->global_ctrl = pmu->global_status =
>  		pmu->global_ovf_ctrl = 0;
> 

Queued, thanks.

Paolo
