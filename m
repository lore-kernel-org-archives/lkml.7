Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D288C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C42D2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfIKPpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 11:45:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32519 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbfIKPpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:45:23 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA55DEB9A0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 15:45:22 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id f23so740944wmh.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 08:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8dvzBDV3dcBvAdrSrp3rimgoPNd8Y7sL0ZbKHpa3Sbk=;
        b=Of4OjuyW2zL86IWRyMvXYqUKDpanlkr77aru474oevSyK63SrCqjptoYbraRdsWRU2
         lT7dUzCbVpLEzqIznKFk+IvOflB3mVdNVv7qWTJfI0u0z4g5RjWTu55kmB2AZwqjn9yX
         40q42JsBDLIdpanKRRkv9CTLyaViQlPxiiIhyBgX2gI6w1GX6odsZC5Y3bftBdF8ArA4
         AUN0N9jXjeUCbVxtqDVUSgtlSwJz6UszY92XgeoCEkEaTLiXmHnRVBT3czQpcA+hFbL3
         dS1BA/o0Rr3W8A0Iat3YnzXCYl1VwWzw+fHYvXf+m5uCgLKHQTYPWWp7i5FBf+VT+hO5
         EC4A==
X-Gm-Message-State: APjAAAWgH/8MrDDhU8Itc241YnBZkDuiORJaDVhuYLcrsCG495AJCwYx
        FaQSj3UzThHZVwxrS+iMXdF4gPJ5K6ZeM04iRpGdMznK1s9g2JPcr4cew6CGhYE04nI6G83Or/G
        FrCshElQjUkgexRVebFF/mVYm
X-Received: by 2002:a5d:5450:: with SMTP id w16mr11023790wrv.55.1568216721321;
        Wed, 11 Sep 2019 08:45:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwP9UdiTBuy5I8iMOFwJ1GcuVJ635HWUdT53JwFA00UHZ5AruDu4dWVvIgy3uHzBtAPani9xQ==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr11023771wrv.55.1568216721083;
        Wed, 11 Sep 2019 08:45:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:102b:3795:6714:7df6? ([2001:b07:6468:f312:102b:3795:6714:7df6])
        by smtp.gmail.com with ESMTPSA id o11sm2591258wmc.7.2019.09.11.08.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 08:45:20 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] KVM: LAPIC: Tune lapic_timer_advance_ns smoothly
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1566980342-22045-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a1c6c974-a6f2-aa71-aa2e-4c987447f419@redhat.com>
Date:   Wed, 11 Sep 2019 17:45:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566980342-22045-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/19 10:19, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Using a moving average based on per-vCPU lapic_timer_advance_ns to tune 
> smoothly, filter out drastic fluctuation which prevents this before, 
> let's assume it is 10000 cycles.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index e904ff0..181537a 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -69,6 +69,7 @@
>  #define LAPIC_TIMER_ADVANCE_ADJUST_INIT 1000
>  /* step-by-step approximation to mitigate fluctuation */
>  #define LAPIC_TIMER_ADVANCE_ADJUST_STEP 8
> +#define LAPIC_TIMER_ADVANCE_FILTER 10000
>  
>  static inline int apic_test_vector(int vec, void *bitmap)
>  {
> @@ -1484,23 +1485,28 @@ static inline void adjust_lapic_timer_advance(struct kvm_vcpu *vcpu,
>  					      s64 advance_expire_delta)
>  {
>  	struct kvm_lapic *apic = vcpu->arch.apic;
> -	u32 timer_advance_ns = apic->lapic_timer.timer_advance_ns;
> -	u64 ns;
> +	u32 timer_advance_ns = apic->lapic_timer.timer_advance_ns, ns;
> +
> +	if (abs(advance_expire_delta) > LAPIC_TIMER_ADVANCE_FILTER)
> +		/* filter out drastic fluctuations */
> +		return;
>  
>  	/* too early */
>  	if (advance_expire_delta < 0) {
>  		ns = -advance_expire_delta * 1000000ULL;
>  		do_div(ns, vcpu->arch.virtual_tsc_khz);
> -		timer_advance_ns -= min((u32)ns,
> -			timer_advance_ns / LAPIC_TIMER_ADVANCE_ADJUST_STEP);
> +		timer_advance_ns -= ns;
>  	} else {
>  	/* too late */
>  		ns = advance_expire_delta * 1000000ULL;
>  		do_div(ns, vcpu->arch.virtual_tsc_khz);
> -		timer_advance_ns += min((u32)ns,
> -			timer_advance_ns / LAPIC_TIMER_ADVANCE_ADJUST_STEP);
> +		timer_advance_ns += ns;
>  	}
>  
> +	timer_advance_ns = (apic->lapic_timer.timer_advance_ns *
> +		(LAPIC_TIMER_ADVANCE_ADJUST_STEP - 1) + advance_expire_delta) /
> +		LAPIC_TIMER_ADVANCE_ADJUST_STEP;
> +
>  	if (abs(advance_expire_delta) < LAPIC_TIMER_ADVANCE_ADJUST_DONE)
>  		apic->lapic_timer.timer_advance_adjust_done = true;
>  	if (unlikely(timer_advance_ns > 5000)) {
> 

This looks great.  But instead of patch 2, why not remove
timer_advance_adjust_done altogether?

Paolo
