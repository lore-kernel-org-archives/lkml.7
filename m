Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774C6C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D752053B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfIQNiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:38:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfIQNiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:38:21 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 571A351EF4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 13:38:20 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id z1so1315200wrw.21
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pNylua/wjzgg680hRcrNCRacO/4UoddbeF1Frj0pR4U=;
        b=ZDgDLr2Py+nma/TFrQeEG3Fs2cT9BtlTYZJNjIp+TzU/LaN2/dxjRFlGVI/+IvRPNt
         rSYcNh1Ombs8HLs7ZraYbr8kaaz5wRJmIC5f3MPvvQ0xPZiMTqNuH+TTNHcsrJsF1veU
         C4PzlSM53Q54y4Ru0WqyFdF8T0XLxx5kX105tHb7vW7GjT+eGIr5iuiBsi6fM8cdgMmZ
         Y3efMGwjaCaynjJMHvodbxCkN6hboDEB5Oaz1KhGw1+RjTenAFpSggpfrmdXT784I15L
         GGl5OLCqKUaAlEv4vKdpUExy+qKU/ioSuShZmCedbo4F3mVoaR+zjJyMx5xQu7MRpAGM
         zBnw==
X-Gm-Message-State: APjAAAUumS0kBn2OMif9h9XLOolilft0yZliiMhxS9Zjipf8Xii5nssW
        0G9uKB9LaC7bnjGkQKIS6uPgEamALlFRCkxujc30+jjDRNGmzgUCqcwIuuqDxGpqRI2yAb/FsFH
        +MoVIxtUPG0u+b253uMwXFJGm
X-Received: by 2002:a1c:a616:: with SMTP id p22mr3528055wme.3.1568727498905;
        Tue, 17 Sep 2019 06:38:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxsLvWxCOsc23J98JYGRanNCdRrqAWk2KLztQrObdWEYvU54V6yD328/x7LlelVd9drNJQ4uQ==
X-Received: by 2002:a1c:a616:: with SMTP id p22mr3528025wme.3.1568727498617;
        Tue, 17 Sep 2019 06:38:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c46c:2acb:d8d2:21d8? ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
        by smtp.gmail.com with ESMTPSA id r20sm3286243wrg.61.2019.09.17.06.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 06:38:17 -0700 (PDT)
Subject: Re: [PATCH v3] KVM: hyperv: Fix Direct Synthetic timers assert an
 interrupt w/o lapic_in_kernel
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1568619752-3885-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <34368da9-2ef7-7fa2-d210-eb8937204896@redhat.com>
Date:   Tue, 17 Sep 2019 15:38:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568619752-3885-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/19 09:42, Wanpeng Li wrote:
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
>  
> 

Queued, thanks.

Paolo
