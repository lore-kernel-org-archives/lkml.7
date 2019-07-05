Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BF4C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032BF218CA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfGEMkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:40:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39471 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfGEMka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:40:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so9779861wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 05:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l8x9dhvz7TMokwr3sn5UWhMUIMcQlqc6m7Wb8cBeajU=;
        b=YEV039cONOTmKiznvjq3miKaRWH8rzVwsTADe8OAEKQiXULEQzZ+grjX1O6c+7Gsy8
         YVvn+X42tPNfgeX2YJmQBsX9WzmvVFu2Au1K+FO31j0ieg6Qvn5/suNnGJZrOKMTwWzr
         OkwKv8FtcWheBsA+mNy3ejB5a4XRUSccNZfNb3GnuvcDWHh87oEmP16870K/jGeHTmhO
         3G7kWBPdtCmwBA73DyUNRYs0ucddHpNsOj9NdasV7STo167sTu4I/j0lCBHOezp4TdeP
         4YhheS74a9gE3upG5dAAAUC/keP54D7jO+efNT9I8pf7YvGjmdLfCTX7uOXJBH7UQvbZ
         0hbA==
X-Gm-Message-State: APjAAAVzsQu6wcYtULDrW/gwmmlJ9mUYiMJgavBwYXl9JPZQdecAKXL1
        dt/Q12GBEVQc60ET1rmDjnQ13Q==
X-Google-Smtp-Source: APXvYqzsvfIgDRLDpqO1yoitLvd8abmdL76b4tnZhwgDNNS9W39D4awx5a3XB+tWwAH1tYKngkhEjQ==
X-Received: by 2002:adf:ab1d:: with SMTP id q29mr4339062wrc.18.1562330428452;
        Fri, 05 Jul 2019 05:40:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e943:5a4e:e068:244a? ([2001:b07:6468:f312:e943:5a4e:e068:244a])
        by smtp.gmail.com with ESMTPSA id n2sm7067453wmi.38.2019.07.05.05.40.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 05:40:27 -0700 (PDT)
Subject: Re: [PATCH v5 4/4] KVM: LAPIC: Don't inject already-expired timer via
 posted interrupt
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
References: <1561110002-4438-1-git-send-email-wanpengli@tencent.com>
 <1561110002-4438-5-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <67fad01b-8a77-5892-d963-77a3d321bb65@redhat.com>
Date:   Fri, 5 Jul 2019 14:40:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1561110002-4438-5-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/19 11:40, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> already-expired timer interrupt can be injected to guest when vCPU who 
> arms the lapic timer re-vmentry, don't posted inject in this case.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index ae575c0..7cd95ea 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1452,7 +1452,7 @@ static void kvm_apic_inject_pending_timer_irqs(struct kvm_lapic *apic)
>  	}
>  }
>  
> -static void apic_timer_expired(struct kvm_lapic *apic)
> +static void apic_timer_expired(struct kvm_lapic *apic, bool can_pi_inject)
>  {
>  	struct kvm_vcpu *vcpu = apic->vcpu;
>  	struct swait_queue_head *q = &vcpu->wq;
> @@ -1464,7 +1464,7 @@ static void apic_timer_expired(struct kvm_lapic *apic)
>  	if (apic_lvtt_tscdeadline(apic) || ktimer->hv_timer_in_use)
>  		ktimer->expired_tscdeadline = ktimer->tscdeadline;
>  
> -	if (posted_interrupt_inject_timer(apic->vcpu)) {
> +	if (can_pi_inject && posted_interrupt_inject_timer(apic->vcpu)) {

Perhaps it should use a posted interrupt if kvm_arch_should_kick(vcpu),
i.e. just add kvm_arch_vcpu_should_kick(apic->vcpu) to
posted_interrupt_inject_timer?

Paolo

>  		if (apic->lapic_timer.timer_advance_ns)
>  			kvm_wait_lapic_expire(vcpu, true);
>  		kvm_apic_inject_pending_timer_irqs(apic);
> @@ -1607,7 +1607,7 @@ static void start_sw_tscdeadline(struct kvm_lapic *apic)
>  		expire = ktime_sub_ns(expire, ktimer->timer_advance_ns);
>  		hrtimer_start(&ktimer->timer, expire, HRTIMER_MODE_ABS);
>  	} else
> -		apic_timer_expired(apic);
> +		apic_timer_expired(apic, false);
>  
>  	local_irq_restore(flags);
>  }
> @@ -1697,7 +1697,7 @@ static void start_sw_period(struct kvm_lapic *apic)
>  
>  	if (ktime_after(ktime_get(),
>  			apic->lapic_timer.target_expiration)) {
> -		apic_timer_expired(apic);
> +		apic_timer_expired(apic, false);
>  
>  		if (apic_lvtt_oneshot(apic))
>  			return;
> @@ -1759,7 +1759,7 @@ static bool start_hv_timer(struct kvm_lapic *apic)
>  		if (atomic_read(&ktimer->pending)) {
>  			cancel_hv_timer(apic);
>  		} else if (expired) {
> -			apic_timer_expired(apic);
> +			apic_timer_expired(apic, false);
>  			cancel_hv_timer(apic);
>  		}
>  	}
> @@ -1809,7 +1809,7 @@ void kvm_lapic_expired_hv_timer(struct kvm_vcpu *vcpu)
>  		goto out;
>  	WARN_ON(swait_active(&vcpu->wq));
>  	cancel_hv_timer(apic);
> -	apic_timer_expired(apic);
> +	apic_timer_expired(apic, false);
>  
>  	if (apic_lvtt_period(apic) && apic->lapic_timer.period) {
>  		advance_periodic_target_expiration(apic);
> @@ -2312,7 +2312,7 @@ static enum hrtimer_restart apic_timer_fn(struct hrtimer *data)
>  	struct kvm_timer *ktimer = container_of(data, struct kvm_timer, timer);
>  	struct kvm_lapic *apic = container_of(ktimer, struct kvm_lapic, lapic_timer);
>  
> -	apic_timer_expired(apic);
> +	apic_timer_expired(apic, true);
>  
>  	if (lapic_is_periodic(apic)) {
>  		advance_periodic_target_expiration(apic);
> 

