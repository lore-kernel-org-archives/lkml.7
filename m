Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7FBC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9E821019
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 13:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390445AbfGRNw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:52:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46664 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfGRNw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 09:52:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so28767254wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 06:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2defXGb6i7e6Mhp08ZGJPyYpwSINwFXbDxPiExwBqLw=;
        b=CMJHMbnau61zLAZQXPOJ5T5SnDYuskeGreQc8/uFEn9bNmAy4BUIyUbKS6x5vktaoS
         //FWIOHpPUJxqpCxktLeJgBpqf3WJtJvS2byDoZIRixBtxFC8SM0c/QZQcXxlvaTdIfK
         o/OBiKQYgNmE72eJtJL5/sQZYwe/slRBd/9wms4ggoohAVpmhLWxbd/HPgJZQLSK/Fui
         tKkh437xiApEe4vkD8ZkBGaVkfSV0PGE3LtWCvm3zszjMIQiu33BxK17gss9ZK/R6ZcF
         SWVMeOxTL4pxV1yMbfXF0nUknLKYz2E6YHA/FShF7KmriDwOnNMVvBgLfELUPd3FuhU2
         s1Pg==
X-Gm-Message-State: APjAAAVKZPrjSjvGSkxyd9uPOa89mJNu5c9GYlnZL/pBUfk64b96E3vm
        ryAir16+lo/s07QV5ynOndmv+c5MoCHH5Q==
X-Google-Smtp-Source: APXvYqyWEoHk4aK6RXQz+bas0Gq722UUqaEAn6c901GtELogmOWF10zIm+PB7Lewb7/ketJ/Fti5Rw==
X-Received: by 2002:adf:f186:: with SMTP id h6mr37752268wro.274.1563457975062;
        Thu, 18 Jul 2019 06:52:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2? ([2001:b07:6468:f312:e427:3beb:1110:dda2])
        by smtp.gmail.com with ESMTPSA id r123sm24558962wme.7.2019.07.18.06.52.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:52:54 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86/vPMU: refine kvm_pmu err msg when event
 creation failed
To:     Like Xu <like.xu@linux.intel.com>, Avi Kivity <avi@scylladb.com>
Cc:     Joe Perches <joe@perches.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190718053514.59742-1-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3d1d84a0-7c63-e470-a1d1-b32f56e52f74@redhat.com>
Date:   Thu, 18 Jul 2019 15:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718053514.59742-1-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/19 07:35, Like Xu wrote:
> If a perf_event creation fails due to any reason of the host perf
> subsystem, it has no chance to log the corresponding event for guest
> which may cause abnormal sampling data in guest result. In debug mode,
> this message helps to understand the state of vPMC and we may not
> limit the number of occurrences but not in a spamming style.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
>  arch/x86/kvm/pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index aa5a2597305a..cedaa01ceb6f 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -131,8 +131,8 @@ static void pmc_reprogram_counter(struct kvm_pmc *pmc, u32 type,
>  						 intr ? kvm_perf_overflow_intr :
>  						 kvm_perf_overflow, pmc);
>  	if (IS_ERR(event)) {
> -		printk_once("kvm_pmu: event creation failed %ld\n",
> -			    PTR_ERR(event));
> +		pr_debug_ratelimited("kvm_pmu: event creation failed %ld for pmc->idx = %d\n",
> +			    PTR_ERR(event), pmc->idx);
>  		return;
>  	}
>  
> 

Queued, thanks.

Paolo
