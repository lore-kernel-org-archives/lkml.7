Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1D3C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A620A2184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 15:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfGEPqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 11:46:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54050 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfGEPqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 11:46:45 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so9568430wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 08:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=05Q35+GTTpUYXJL1Rwag0mMQtzgdvg4fi4Hn+VrKK8E=;
        b=Lt+2g1paNHjA6l1yzJ23RZIefYrXOsHWRLos7IOVhvI2Ao+hVFxH0ajRlFCB3RgboZ
         9qLDbDq+iiZzHI9vRBxXbsCWXs0XJReaJnHe+zrCTJgCRfYrENiBeMnVVTA7MAyRDkbM
         whHRU6zGpbjHAfXi0njMLBCXth1xKxcvxT/8F1H3bxcebUPBrX/AZWvKXsMYHj4wRaqO
         JbLDzFRoH6XZ2eyLgLvnWf5AhWlKWkGV8pG5ZqnaMp1beh9KnL3VgBnVSmyTrJB9iG76
         ThSknHWCon42WNv2n8v+oFngnu8N/8ewTfi1eQQxEuuSRxHDP7AtINQqbgHznGTR7Tj1
         UjRg==
X-Gm-Message-State: APjAAAUGgLHITBxiMEGxjo5U1MzEVIrGyKZ/1amLqlJHkNpJbRAhk+dz
        ZNW2WQG92MAjmb+Y3qAaPkjvXQ==
X-Google-Smtp-Source: APXvYqxLDxgwbbyPy1jXiFOSU0No+ezL7hxBj4s55FwrNPiWik5aUBg2K0Vb9f+kn1IoOV+TemaD/w==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr3948230wmc.170.1562341603285;
        Fri, 05 Jul 2019 08:46:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e943:5a4e:e068:244a? ([2001:b07:6468:f312:e943:5a4e:e068:244a])
        by smtp.gmail.com with ESMTPSA id q10sm9019757wrf.32.2019.07.05.08.46.42
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 08:46:42 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: LAPIC: Retry tune per-vCPU timer_advance_ns if
 adaptive tuning goes insane
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1562340222-31324-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <96d0bcf5-a18e-770d-3962-a8c330a2f803@redhat.com>
Date:   Fri, 5 Jul 2019 17:46:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562340222-31324-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/19 17:23, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Retry tune per-vCPU timer_advance_ns if adaptive tuning goes insane which 
> can happen sporadically in product environment.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * retry max 10 times if adaptive tuning goes insane

Is there any advantage at stopping the retry (also it should not be a
local variable of course).

Paolo

>  arch/x86/kvm/lapic.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 95affa5..bd0dbe5 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1538,6 +1538,7 @@ static inline void adjust_lapic_timer_advance(struct kvm_vcpu *vcpu,
>  	struct kvm_lapic *apic = vcpu->arch.apic;
>  	u32 timer_advance_ns = apic->lapic_timer.timer_advance_ns;
>  	u64 ns;
> +	uint retry_count = 0;
>  
>  	/* too early */
>  	if (advance_expire_delta < 0) {
> @@ -1556,8 +1557,10 @@ static inline void adjust_lapic_timer_advance(struct kvm_vcpu *vcpu,
>  	if (abs(advance_expire_delta) < LAPIC_TIMER_ADVANCE_ADJUST_DONE)
>  		apic->lapic_timer.timer_advance_adjust_done = true;
>  	if (unlikely(timer_advance_ns > 5000)) {
> -		timer_advance_ns = 0;
> -		apic->lapic_timer.timer_advance_adjust_done = true;
> +		timer_advance_ns = 1000;
> +		apic->lapic_timer.timer_advance_adjust_done = false;
> +		if (++retry_count > 10)
> +			apic->lapic_timer.timer_advance_adjust_done = true;
>  	}
>  	apic->lapic_timer.timer_advance_ns = timer_advance_ns;
>  }
> 

