Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C22C4CEC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B05214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 08:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbfIPIzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 04:55:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfIPIzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 04:55:13 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 911F2C059B7A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:55:12 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id d10so5271094wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 01:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SUB1IVXL6hgEq88Q4J0UTBzixwOO6EmRLqrfJRI+g3o=;
        b=q9nV0dLFOhZ4j1ynK6Xx6kS2u1xAD4/EVaeYhRyqz2FGrYRrNiCnWElINAmIOtMExJ
         dQN985TbcnSIEGCDkuuH6knVrZa9+RUeqvzpDgA90nXYG3ofQJFU3b1cclj//RbjzUsN
         xi6njKExvSOtTX+saVuW1/78ot6b1SWmPSpVlZjA/IA9YuhyVJhUsvnE+CTb9kXtqrkz
         Er6Cswv0ec4uDJ1TtXfXaP6LYjwRldRXsjGXOPbbjTZBtddJEDh0bD/iRqX1ZYyY48yx
         vqsFDaIQilsCZY9MZ0SizuF7rACdU2AxnGqlkoTqoFMyy7CUeRjOQJRK4fqVsR2QyX3u
         r0Zw==
X-Gm-Message-State: APjAAAWcdzOcTApIQDEigMasQDZkzmDEJv8RQ/RE3Mh5N+Nvn8HEtOcL
        L3CMJb7ICHmj5oqVFAEM/EqzGjfw9op+pgnRVEEwsVDxNBKmoEeMWZgCeQJbypHG68XdLj8LbWz
        H+STdUSq8Q4BMpAA+y0GDl9mm
X-Received: by 2002:adf:de0d:: with SMTP id b13mr19749478wrm.140.1568624111207;
        Mon, 16 Sep 2019 01:55:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxB6gC9RNDOJt+z56qp5dQpVvWDMYCdc+fZNySO8MEVvHEiJSJfxbdldHJcoj+LPYeFXQKdgw==
X-Received: by 2002:adf:de0d:: with SMTP id b13mr19749460wrm.140.1568624110978;
        Mon, 16 Sep 2019 01:55:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a10sm2214994wrv.64.2019.09.16.01.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 01:55:10 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3] KVM: hyperv: Fix Direct Synthetic timers assert an interrupt w/o lapic_in_kernel
In-Reply-To: <1568619752-3885-1-git-send-email-wanpengli@tencent.com>
References: <1568619752-3885-1-git-send-email-wanpengli@tencent.com>
Date:   Mon, 16 Sep 2019 10:55:09 +0200
Message-ID: <87muf4boya.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> Reported by syzkaller:
>
> 	kasan: GPF could be caused by NULL-ptr deref or user memory access
> 	general protection fault: 0000 [#1] PREEMPT SMP KASAN
> 	RIP: 0010:__apic_accept_irq+0x46/0x740 arch/x86/kvm/lapic.c:1029
> 	Call Trace:
> 	kvm_apic_set_irq+0xb4/0x140 arch/x86/kvm/lapic.c:558
> 	stimer_notify_direct arch/x86/kvm/hyperv.c:648 [inline]
> 	stimer_expiration arch/x86/kvm/hyperv.c:659 [inline]
> 	kvm_hv_process_stimers+0x594/0x1650 arch/x86/kvm/hyperv.c:686
> 	vcpu_enter_guest+0x2b2a/0x54b0 arch/x86/kvm/x86.c:7896
> 	vcpu_run+0x393/0xd40 arch/x86/kvm/x86.c:8152
> 	kvm_arch_vcpu_ioctl_run+0x636/0x900 arch/x86/kvm/x86.c:8360
> 	kvm_vcpu_ioctl+0x6cf/0xaf0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2765
>
> The testcase programs HV_X64_MSR_STIMERn_CONFIG/HV_X64_MSR_STIMERn_COUNT,
> in addition, there is no lapic in the kernel, the counters value are small
> enough in order that kvm_hv_process_stimers() inject this already-expired
> timer interrupt into the guest through lapic in the kernel which triggers
> the NULL deferencing. This patch fixes it by don't advertise direct mode 
> synthetic timers and discarding the inject when lapic is not in kernel.
>
> syzkaller source: https://syzkaller.appspot.com/x/repro.c?x=1752fe0a600000
>
> Reported-by: syzbot+dff25ee91f0c7d5c1695@syzkaller.appspotmail.com
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v2 -> v3:
>  * add the link of syzkaller source
> v1 -> v2:
>  * don't advertise direct mode synthetic timers when lapic is not in kernel
>
>  arch/x86/kvm/hyperv.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index c10a8b1..069e655 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -645,7 +645,9 @@ static int stimer_notify_direct(struct kvm_vcpu_hv_stimer *stimer)
>  		.vector = stimer->config.apic_vector
>  	};
>  
> -	return !kvm_apic_set_irq(vcpu, &irq, NULL);
> +	if (lapic_in_kernel(vcpu))
> +		return !kvm_apic_set_irq(vcpu, &irq, NULL);
> +	return 0;

We can go even further and forbid to enable direct mode by adding
lapic_in_kernel() check to stimer_set_config() but the guest (or
userspace setting CPUIDs) is already misbehaving and we can't magically
fix things in KVM.

>  }
>  
>  static void stimer_expiration(struct kvm_vcpu_hv_stimer *stimer)
> @@ -1849,7 +1851,13 @@ int kvm_vcpu_ioctl_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  
>  			ent->edx |= HV_FEATURE_FREQUENCY_MSRS_AVAILABLE;
>  			ent->edx |= HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
> -			ent->edx |= HV_STIMER_DIRECT_MODE_AVAILABLE;
> +
> +			/*
> +			 * Direct Synthetic timers only make sense with in-kernel
> +			 * LAPIC
> +			 */
> +			if (lapic_in_kernel(vcpu))
> +				ent->edx |= HV_STIMER_DIRECT_MODE_AVAILABLE;
>  
>  			break;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
