Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D00C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2889A206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbfGaM5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:57:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38840 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388017AbfGaM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:57:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so38376262wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IZIh6MlDVtHPiwAsFVJnNtW03boho+9QyTSEdiXSHBw=;
        b=AjZdmR7Vrh0heSuyoz9V2gpHq1aMBoFnhWjc/XjMPBakGnZoaPOJf16RG5060yfEWK
         H9dAwkc6Cq/RLhwLlMRqpDZIaAJ9RV11AdubRi2/UuzrM9uHXavIY0wh0oQ20IBdKl5y
         K0AJhkK+pSc3dS70y4eCT9CoAMefG7f4nLRzo1GOupsq+WSVxMxL4e5a1xDHVEKOe715
         Tbyyv3JzTnW03U0/4k1eENK7Dvzc2auIgKeaIn9Nzv7UpuFfrf9R5/lrMIojSlkILPHU
         jxnDFaT3aw2RLUqbWZXgqCkziV7WUkzg7uaT4/bcPnQgNsKfklzJ6YvGBwdDcCqrEF5p
         zpBg==
X-Gm-Message-State: APjAAAXqLxTZdSOuVk23yJ8t6ZlnP1pJ5leOfty/M1G/8orzObDg4C2v
        ytbinCqbEK1fctR0N40G35tnag==
X-Google-Smtp-Source: APXvYqz8x2TA8RbHG4GAy8dlpCQQz81WPB7zCXKR7/QFoeY/qXr2v3TBsMrBuO+d2w6k9t6UtAvXsg==
X-Received: by 2002:a1c:be05:: with SMTP id o5mr112635648wmf.52.1564577818394;
        Wed, 31 Jul 2019 05:56:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91e7:65e:d8cd:fdb3? ([2001:b07:6468:f312:91e7:65e:d8cd:fdb3])
        by smtp.gmail.com with ESMTPSA id r4sm40675504wrq.82.2019.07.31.05.56.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 05:56:57 -0700 (PDT)
Subject: Re: [PATCH 1/3] KVM: Don't need to wakeup vCPU twice afer timer fire
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1564572438-15518-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ab8f8b07-e3f9-4831-c386-0bfa0314f9c3@redhat.com>
Date:   Wed, 31 Jul 2019 14:56:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564572438-15518-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/19 13:27, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> kvm_set_pending_timer() will take care to wake up the sleeping vCPU which 
> has pending timer, don't need to check this in apic_timer_expired() again.

No, it doesn't.  kvm_make_request never kicks the vCPU.

Paolo

> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 0aa1586..685d17c 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1548,7 +1548,6 @@ static void kvm_apic_inject_pending_timer_irqs(struct kvm_lapic *apic)
>  static void apic_timer_expired(struct kvm_lapic *apic)
>  {
>  	struct kvm_vcpu *vcpu = apic->vcpu;
> -	struct swait_queue_head *q = &vcpu->wq;
>  	struct kvm_timer *ktimer = &apic->lapic_timer;
>  
>  	if (atomic_read(&apic->lapic_timer.pending))
> @@ -1566,13 +1565,6 @@ static void apic_timer_expired(struct kvm_lapic *apic)
>  
>  	atomic_inc(&apic->lapic_timer.pending);
>  	kvm_set_pending_timer(vcpu);
> -
> -	/*
> -	 * For x86, the atomic_inc() is serialized, thus
> -	 * using swait_active() is safe.
> -	 */
> -	if (swait_active(q))
> -		swake_up_one(q);
>  }
>  
>  static void start_sw_tscdeadline(struct kvm_lapic *apic)
> 

