Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BA3C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8160B2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGCQZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:25:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45387 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGCQZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:25:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id f9so3501362wre.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ikRLK3Ph+biXIkYRKj5FiXXJi2K3aKBPVe0fP3FxzK8=;
        b=nO7A+HovlJJfUBZUvU8xfQEv+cyeAt7JAvrXpAPZg/rpQM2pfsn5+LcL25ScG+HJMy
         4n4bMCpW7DzDZ5LWD5Z3oeBj744LNy6wqaeqPllrhadQKHpF+IupamQ+U8WZ57IaiX21
         hmXRh4oun9bCSCxMUidt6ZCuZtMz4LWFdO1qdBDrryQqwsK7vN+U00yXIL6Pov5QYoKD
         8PLYmhtRjHZ0rMTp8zMxyJk6xLnmKJX0brletJ/eTPD1Zh9Iyi4KE3GROm9Mk5pifz/7
         Dcnobo8bvchvJV2ivJ9G74r1VbUZZvsW2chqObKQJhzPnPAPIW+G5hHolX+XbrinzPq3
         7B9A==
X-Gm-Message-State: APjAAAVOVW4ZbGFtFZHR3O0oJtQM5V+OJvVK1P47tGnqdnlshxHSUPX/
        x53EtoWx8rdsQbQ+u1jJxssngqDtgPHuMQ==
X-Google-Smtp-Source: APXvYqywAlBGtT5TxMbw9XvOcUKcZudM92t0WsE2uhFk4qVstWc1Nr2JZoz5tL6Cl+cznc2eglJxSQ==
X-Received: by 2002:a5d:430c:: with SMTP id h12mr29914401wrq.163.1562171108195;
        Wed, 03 Jul 2019 09:25:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6c1d:63cc:b81d:e1a9? ([2001:b07:6468:f312:6c1d:63cc:b81d:e1a9])
        by smtp.gmail.com with ESMTPSA id s63sm2908489wme.17.2019.07.03.09.25.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:25:07 -0700 (PDT)
Subject: Re: [PATCH 4/4] kvm: x86: convert TSC pr_debugs to be gated by
 CONFIG_KVM_DEBUG
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        up2wing@gmail.com, wang.liang82@zte.com.cn
References: <1561962071-25974-1-git-send-email-wang.yi59@zte.com.cn>
 <1561962071-25974-5-git-send-email-wang.yi59@zte.com.cn>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <108995bd-fac1-03f0-c3a9-822b3219be82@redhat.com>
Date:   Wed, 3 Jul 2019 18:25:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1561962071-25974-5-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/19 08:21, Yi Wang wrote:
> There are some pr_debug in TSC code, which may affect
> performance, so it may make sense to wrap them using a new
> macro tsc_debug which takes effect only when CONFIG_KVM_DEBUG
> is defined.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
>  arch/x86/kvm/x86.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 83aefd7..1505e53 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -74,6 +74,12 @@
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
>  
> +#ifdef CONFIG_KVM_DEBUG
> +#define tsc_debug(x...) pr_debug(x)
> +#else
> +#define tsc_debug(x...)
> +#endif
> +
>  #define MAX_IO_MSRS 256
>  #define KVM_MAX_MCE_BANKS 32
>  u64 __read_mostly kvm_mce_cap_supported = MCG_CTL_P | MCG_SER_P;
> @@ -1522,7 +1528,7 @@ static void kvm_get_time_scale(uint64_t scaled_hz, uint64_t base_hz,
>  	*pshift = shift;
>  	*pmultiplier = div_frac(scaled64, tps32);
>  
> -	pr_debug("%s: base_hz %llu => %llu, shift %d, mul %u\n",
> +	tsc_debug("%s: base_hz %llu => %llu, shift %d, mul %u\n",
>  		 __func__, base_hz, scaled_hz, shift, *pmultiplier);
>  }

Just remove this.

> @@ -1603,7 +1609,7 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, u32 user_tsc_khz)
>  	thresh_lo = adjust_tsc_khz(tsc_khz, -tsc_tolerance_ppm);
>  	thresh_hi = adjust_tsc_khz(tsc_khz, tsc_tolerance_ppm);
>  	if (user_tsc_khz < thresh_lo || user_tsc_khz > thresh_hi) {
> -		pr_debug("kvm: requested TSC rate %u falls outside tolerance [%u,%u]\n", user_tsc_khz, thresh_lo, thresh_hi);
> +		tsc_debug("kvm: requested TSC rate %u falls outside tolerance [%u,%u]\n", user_tsc_khz, thresh_lo, thresh_hi);

This is okay as a pr_debug, it only happens once per VM and only if it
is configured wrong.

>  		use_scaling = 1;
>  	}
>  	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
> @@ -1766,12 +1772,12 @@ void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  	    vcpu->arch.virtual_tsc_khz == kvm->arch.last_tsc_khz) {
>  		if (!kvm_check_tsc_unstable()) {
>  			offset = kvm->arch.cur_tsc_offset;
> -			pr_debug("kvm: matched tsc offset for %llu\n", data);
> +			tsc_debug("kvm: matched tsc offset for %llu\n", data);
>  		} else {
>  			u64 delta = nsec_to_cycles(vcpu, elapsed);
>  			data += delta;
>  			offset = kvm_compute_tsc_offset(vcpu, data);
> -			pr_debug("kvm: adjusted tsc offset by %llu\n", delta);
> +			tsc_debug("kvm: adjusted tsc offset by %llu\n", delta);

Again just drop these, there are tracepoints for it.
>  		}
>  		matched = true;
>  		already_matched = (vcpu->arch.this_tsc_generation == kvm->arch.cur_tsc_generation);
> @@ -1790,7 +1796,7 @@ void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  		kvm->arch.cur_tsc_write = data;
>  		kvm->arch.cur_tsc_offset = offset;
>  		matched = false;
> -		pr_debug("kvm: new tsc generation %llu, clock %llu\n",
> +		tsc_debug("kvm: new tsc generation %llu, clock %llu\n",
>  			 kvm->arch.cur_tsc_generation, data);

Drop.

>  	}
>  
> @@ -6860,7 +6866,7 @@ static void kvm_timer_init(void)
>  		cpufreq_register_notifier(&kvmclock_cpufreq_notifier_block,
>  					  CPUFREQ_TRANSITION_NOTIFIER);
>  	}
> -	pr_debug("kvm: max_tsc_khz = %ld\n", max_tsc_khz);
> +	tsc_debug("kvm: max_tsc_khz = %ld\n", max_tsc_khz);

Drop.

Thanks,

Paolo

>  	cpuhp_setup_state(CPUHP_AP_X86_KVM_CLK_ONLINE, "x86/kvm/clk:online",
>  			  kvmclock_cpu_online, kvmclock_cpu_down_prep);
> 

