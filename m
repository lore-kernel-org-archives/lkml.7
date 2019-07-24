Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED82C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611DD229F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfGXMRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:17:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39851 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfGXMRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:17:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id u25so31062230wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 05:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d/bnNeFnlnArvv9m90hzgTqoTaqu56sti/BTphxXxoM=;
        b=siuAUNvS+b/QckEx64PUlU7QEMHBc9b1dMA1tCllq4S4rF2Ig1qMt2YnJGxzMHmMMm
         s/W/VaHKtWtlnFTiowA0osy1yO+6TapvwgZZQRbTydvq852Yjr9GcH5AffQkOzuDcV6V
         w+rQV35hlVAE3nxOL8dy56O90pWpwplWQRW1IgJ8koY4wEmCqbtywkZxQV0rCqaUyBOT
         HMBeRB7+HLCacTwFkgakkA8pUsOg3i5/aq7lwKtfwT7j+dXaU/NNqHpR6IHkOkzHQ+uc
         kOpJZ3uPEvoV4MrPSPm/KMMl0SG2KSw6dP2OamBTDvGzH6SkehLpWGCu+h4ZXQ3AI9C4
         gxPQ==
X-Gm-Message-State: APjAAAUv1B/ATuwQBV5WvN+E59pnEKH0xNGaadF3JR03eoqtcAoV/Hqi
        2Tg6T3plCZhvgzoUw1/tD5ZIKn5BrVg=
X-Google-Smtp-Source: APXvYqwCvrf4yPzzk3NFn3Qx2+lKh32KmGRJqKMQSlgWv3da79lYQl+eEShtkRMIfH4axXaXxN60Qw==
X-Received: by 2002:a1c:407:: with SMTP id 7mr78394104wme.113.1563970635452;
        Wed, 24 Jul 2019 05:17:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512? ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
        by smtp.gmail.com with ESMTPSA id y12sm41112207wrm.79.2019.07.24.05.17.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 05:17:14 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Boost queue head vCPU to mitigate lock waiter
 preemption
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1563961393-10301-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5ffaea5b-fb07-0141-cab8-6dce39071abe@redhat.com>
Date:   Wed, 24 Jul 2019 14:17:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563961393-10301-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/19 11:43, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Commit 11752adb (locking/pvqspinlock: Implement hybrid PV queued/unfair locks)
> introduces hybrid PV queued/unfair locks 
>  - queued mode (no starvation)
>  - unfair mode (good performance on not heavily contended lock)
> The lock waiter goes into the unfair mode especially in VMs with over-commit
> vCPUs since increaing over-commitment increase the likehood that the queue 
> head vCPU may have been preempted and not actively spinning.
> 
> However, reschedule queue head vCPU timely to acquire the lock still can get 
> better performance than just depending on lock stealing in over-subscribe 
> scenario.
> 
> Testing on 80 HT 2 socket Xeon Skylake server, with 80 vCPUs VM 80GB RAM:
> ebizzy -M
>              vanilla     boosting    improved
>  1VM          23520        25040         6%
>  2VM           8000        13600        70%
>  3VM           3100         5400        74%
> 
> The lock holder vCPU yields to the queue head vCPU when unlock, to boost queue 
> head vCPU which is involuntary preemption or the one which is voluntary halt 
> due to fail to acquire the lock after a short spin in the guest.

Clever!  I have applied the patch.

Paolo

> Cc: Waiman Long <longman@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/x86.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 01e18ca..c6d951c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7206,7 +7206,7 @@ static void kvm_sched_yield(struct kvm *kvm, unsigned long dest_id)
>  
>  	rcu_read_unlock();
>  
> -	if (target)
> +	if (target && READ_ONCE(target->ready))
>  		kvm_vcpu_yield_to(target);
>  }
>  
> @@ -7246,6 +7246,7 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>  		break;
>  	case KVM_HC_KICK_CPU:
>  		kvm_pv_kick_cpu_op(vcpu->kvm, a0, a1);
> +		kvm_sched_yield(vcpu->kvm, a1);
>  		ret = 0;
>  		break;
>  #ifdef CONFIG_X86_64
> 

