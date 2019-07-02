Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97683C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7889A20989
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfGBQni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:43:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35783 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfGBQnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:43:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id c27so10932345wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 09:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kV2rDBr8f3q9kLby6YRxl8ZXleRdsPAklKANirTDrb4=;
        b=BtY0TyB7W1mIGsHa26owqlwL4sPnP0O0CKoIS0hGtee/0d44LfWqf8KluiJKPhiaJQ
         l+6v7OMas7H5/bNxOcnmCnqN9S3skEjOgfXnR9PsP7LSU6eHuAMjNmzbI1oHQaOaXhmn
         ostgPinZg0i5vq0czBXVWFWBSzhsz/9J+vSXs//mx9GqVAKemWNZZbRYzXRXtoWnE8R8
         esLQwWHhu2+sd1ytHM8maZC2ZIRNzuWr7U/otPbwGQHnFlaQlDDvMYldrmgG5yLPGxBu
         Z8Wg8q50nE2CgufMCVZnXdZTbDRvlirLIHd464gOVnXfR5nvuAl/Th1gvw70I77gFkYG
         B7VA==
X-Gm-Message-State: APjAAAUa+vskDvLSJOFYQhwTw2S/Romoz892xA7hpacIlGM1ij7psef8
        4zl0itJxVtGenR5qc2gIB17jWw==
X-Google-Smtp-Source: APXvYqyCjkw4IWIQFh2eWCekFXDCVrk3wVqWTz5BvaxR3YLEORVKvovktt+CsNcs/+L6TdZmGAhXPg==
X-Received: by 2002:a5d:500f:: with SMTP id e15mr12587591wrt.41.1562085814230;
        Tue, 02 Jul 2019 09:43:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b8:794:183e:9e2a? ([2001:b07:6468:f312:b8:794:183e:9e2a])
        by smtp.gmail.com with ESMTPSA id z1sm15403353wrv.90.2019.07.02.09.43.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 09:43:33 -0700 (PDT)
Subject: Re: [PATCH] KVM: LAPIC: Fix pending interrupt in IRR blocked by
 software disable LAPIC
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rong Chen <rong.a.chen@intel.com>,
        Feng Tang <feng.tang@intel.com>, stable@vger.kernel.org
References: <1562059502-8581-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c75371c8-7dbc-7ce8-c0f3-0396305b896b@redhat.com>
Date:   Tue, 2 Jul 2019 18:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562059502-8581-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/19 11:25, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Thomas reported that:
> 
>  | Background:
>  | 
>  |    In preparation of supporting IPI shorthands I changed the CPU offline
>  |    code to software disable the local APIC instead of just masking it.
>  |    That's done by clearing the APIC_SPIV_APIC_ENABLED bit in the APIC_SPIV
>  |    register.
>  | 
>  | Failure:
>  | 
>  |    When the CPU comes back online the startup code triggers occasionally
>  |    the warning in apic_pending_intr_clear(). That complains that the IRRs
>  |    are not empty.
>  | 
>  |    The offending vector is the local APIC timer vector who's IRR bit is set
>  |    and stays set.
>  | 
>  | It took me quite some time to reproduce the issue locally, but now I can
>  | see what happens.
>  | 
>  | It requires apicv_enabled=0, i.e. full apic emulation. With apicv_enabled=1
>  | (and hardware support) it behaves correctly.
>  | 
>  | Here is the series of events:
>  | 
>  |     Guest CPU
>  | 
>  |     goes down
>  | 
>  |       native_cpu_disable()		
>  | 
>  | 			apic_soft_disable();
>  | 
>  |     play_dead()
>  | 
>  |     ....
>  | 
>  |     startup()
>  | 
>  |       if (apic_enabled())
>  |         apic_pending_intr_clear()	<- Not taken
>  | 
>  |      enable APIC
>  | 
>  |         apic_pending_intr_clear()	<- Triggers warning because IRR is stale
>  | 
>  | When this happens then the deadline timer or the regular APIC timer -
>  | happens with both, has fired shortly before the APIC is disabled, but the
>  | interrupt was not serviced because the guest CPU was in an interrupt
>  | disabled region at that point.
>  | 
>  | The state of the timer vector ISR/IRR bits:
>  | 
>  |     	     	       	        ISR     IRR
>  | before apic_soft_disable()    0	      1
>  | after apic_soft_disable()     0	      1
>  | 
>  | On startup		      		 0	      1
>  | 
>  | Now one would assume that the IRR is cleared after the INIT reset, but this
>  | happens only on CPU0.
>  | 
>  | Why?
>  | 
>  | Because our CPU0 hotplug is just for testing to make sure nothing breaks
>  | and goes through an NMI wakeup vehicle because INIT would send it through
>  | the boots-trap code which is not really working if that CPU was not
>  | physically unplugged.
>  | 
>  | Now looking at a real world APIC the situation in that case is:
>  | 
>  |     	     	       	      	ISR     IRR
>  | before apic_soft_disable()    0	      1
>  | after apic_soft_disable()     0	      1
>  | 
>  | On startup		      		 0	      0
>  | 
>  | Why?
>  | 
>  | Once the dying CPU reenables interrupts the pending interrupt gets
>  | delivered as a spurious interupt and then the state is clear.
>  | 
>  | While that CPU0 hotplug test case is surely an esoteric issue, the APIC
>  | emulation is still wrong, Even if the play_dead() code would not enable
>  | interrupts then the pending IRR bit would turn into an ISR .. interrupt
>  | when the APIC is reenabled on startup.
> 
> 
> From SDM 10.4.7.2 Local APIC State After It Has Been Software Disabled
> * Pending interrupts in the IRR and ISR registers are held and require
>   masking or handling by the CPU.
> 
> In Thomas's testing, hardware cpu will not respect soft disable LAPIC 
> when IRR has already been set or APICv posted-interrupt is in flight, 
> so we can skip soft disable APIC checking when clearing IRR and set ISR,
> continue to respect soft disable APIC when attempting to set IRR.
> 
> Reported-by: Rong Chen <rong.a.chen@intel.com>
> Reported-by: Feng Tang <feng.tang@intel.com>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rong Chen <rong.a.chen@intel.com>
> Cc: Feng Tang <feng.tang@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 05d8934..f857a12 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2376,7 +2376,7 @@ int kvm_apic_has_interrupt(struct kvm_vcpu *vcpu)
>  	struct kvm_lapic *apic = vcpu->arch.apic;
>  	u32 ppr;
>  
> -	if (!apic_enabled(apic))
> +	if (!kvm_apic_hw_enabled(apic))
>  		return -1;
>  
>  	__apic_update_ppr(apic, &ppr);
> 

Queued, thanks.

Paolo
