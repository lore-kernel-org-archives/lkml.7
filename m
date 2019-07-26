Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E74EC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5582F22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfGZTlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:41:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33087 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfGZTli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:41:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so55639517wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZvWSqPjibgGXA0LoZsQsVI2IHjEaKKck/rv+AQUCjH0=;
        b=WE9a+7thjBGVVIkvjlaR9wZm9d4tulKAj+9wUmFyXpqYBoCalsq1D9ULxdUIYk7OVP
         zcWcTswSX/NUSn2j0cFd+c9u8ft15IRNnsoXuFk8ecg7fK5vdsqCG7MlvGrA2exPTlet
         iTk3krgylUa8Ez+gscV5JTPtGmqZHlOiWhpzgxB17mWJ1O/KftCMLh9cn7tI+xAZJjGG
         r9NN+mNLp/1iSzUvHxq5NaFn1x3eNRfPXoA9ik3pyRQxu/emKe78FMRD44g4fwvb/4Xq
         l28XsjweR3Uq5XH8HaHkQ7g5S/UflUdY6VKQgnsebgKk0F6KD3ZdL0scJ8WiaUCNBiWs
         gt1w==
X-Gm-Message-State: APjAAAUmB/gSxpAsstS0G5EKBD41RsM912ZO+H5rcGBwIigRqiHnqDXG
        OqM7ZFaGBfJcBDeWfkO7+iiV8Q==
X-Google-Smtp-Source: APXvYqw8D9qW7E7D7wSq1aiagwygXtodCp2APYd461jf9vywteqA6OD/zt8xAwJ/pcuBCZBVeSZPhQ==
X-Received: by 2002:a5d:5692:: with SMTP id f18mr57691607wrv.104.1564170096649;
        Fri, 26 Jul 2019 12:41:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee? ([2001:b07:6468:f312:cc23:f353:392:d2ee])
        by smtp.gmail.com with ESMTPSA id w25sm51292326wmk.18.2019.07.26.12.41.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 12:41:35 -0700 (PDT)
Subject: Re: [patch 07/12] KVM: LAPIC: Mark hrtimer to expire in hard
 interrupt context
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Juergen Gross <jgross@suse.com>
References: <20190726183048.982726647@linutronix.de>
 <20190726185753.363363474@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6fea9141-1391-8466-0cf5-27f193daf5c9@redhat.com>
Date:   Fri, 26 Jul 2019 21:41:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726185753.363363474@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/19 20:30, Thomas Gleixner wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> On PREEMPT_RT enabled kernels unmarked hrtimers are moved into soft
> interrupt expiry mode by default.
> 
> While that's not a functional requirement for the KVM local APIC timer
> emulation, it's a latency issue which can be avoided by marking the timer
> so hard interrupt context expiry is enforced.
> 
> No functional change.
> 
> [ tglx: Split out from larger combo patch. Add changelog. ]
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: kvm@vger.kernel.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/lapic.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2302,7 +2302,7 @@ int kvm_create_lapic(struct kvm_vcpu *vc
>  	apic->vcpu = vcpu;
>  
>  	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
> -		     HRTIMER_MODE_ABS);
> +		     HRTIMER_MODE_ABS_HARD);
>  	apic->lapic_timer.timer.function = apic_timer_fn;
>  	if (timer_advance_ns == -1) {
>  		apic->lapic_timer.timer_advance_ns = LAPIC_TIMER_ADVANCE_ADJUST_INIT;
> 
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>
