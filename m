Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6E3C010A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180B8206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbfKEKXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:23:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388363AbfKEKXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:23:18 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3964085541
        for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2019 10:23:17 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id 92so12123064wro.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 02:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PcBBgu6SOROWeQPJhgSxyE0icLieOSEFxVr+4CYsprY=;
        b=VvT++sdcUXvZztQXbb6RIGyRW1bH8WOI86GH0OO3oYtXGh5nBqAb66QJi6Hpd+m6m9
         cbgDsKArJMZgKvHytjHQ1iAEDBJVfeg10MJ3JtOWvgUNs4tbfbMJu4ZquAmfWdN2OBwP
         j88dxppUOzLRrktBUO2rDvtw8LyTClBaRqzB0hYlst/OOl7gs8k5mwOMDZ8IARiibGNK
         6/IiehW077BBZsS+dWbPbLXJXHG27z8OTkMOO7CPpTB5w5kc0nJxunoqclgBgmw8suFy
         T8feCMBgEVxUSlsUkibBLWITS3ANNK9ogZWhr8U3yreOAKQcilrMHORFe0elU0s6vAmp
         CaTw==
X-Gm-Message-State: APjAAAUF+vlqMeic2zvcfCf4F1AleyqBPx0dx68ru0576ksqrdCyV8J0
        t54JnuIeZ8kgufqRAV7Qg2sHhs3Nc818QYxo22ribN2IkrdR6Xc6kN2anBVBAkU8/qO7oTgaD3k
        pLAa+H+nn9+pHHKCEqcQi88g3
X-Received: by 2002:a5d:6947:: with SMTP id r7mr3007068wrw.129.1572949395716;
        Tue, 05 Nov 2019 02:23:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqybAnv9rx4J+dG+3zALibmvXj0MCS3vNaSu6P5s+2lri5gmcAcljRuafrbJ+2RXJymJ54T8bQ==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr3007044wrw.129.1572949395415;
        Tue, 05 Nov 2019 02:23:15 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id 205sm20611901wmb.3.2019.11.05.02.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 02:23:14 -0800 (PST)
Subject: Re: [PATCH 12/13] KVM: retpolines: x86: eliminate retpoline from
 svm.c exit handlers
To:     Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20191104230001.27774-1-aarcange@redhat.com>
 <20191104230001.27774-13-aarcange@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5ed26dee-e439-6c2f-cd10-e73fefbd3a02@redhat.com>
Date:   Tue, 5 Nov 2019 11:21:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191104230001.27774-13-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/19 00:00, Andrea Arcangeli wrote:
> It's enough to check the exit value and issue a direct call to avoid
> the retpoline for all the common vmexit reasons.
> 
> After this commit is applied, here the most common retpolines executed
> under a high resolution timer workload in the guest on a SVM host:
> 
> [..]
> @[
>     trace_retpoline+1
>     __trace_retpoline+30
>     __x86_indirect_thunk_rax+33
>     ktime_get_update_offsets_now+70
>     hrtimer_interrupt+131
>     smp_apic_timer_interrupt+106
>     apic_timer_interrupt+15
>     start_sw_timer+359
>     restart_apic_timer+85
>     kvm_set_msr_common+1497
>     msr_interception+142
>     vcpu_enter_guest+684
>     kvm_arch_vcpu_ioctl_run+261
>     kvm_vcpu_ioctl+559
>     do_vfs_ioctl+164
>     ksys_ioctl+96
>     __x64_sys_ioctl+22
>     do_syscall_64+89
>     entry_SYSCALL_64_after_hwframe+68
> ]: 1940
> @[
>     trace_retpoline+1
>     __trace_retpoline+30
>     __x86_indirect_thunk_r12+33
>     force_qs_rnp+217
>     rcu_gp_kthread+1270
>     kthread+268
>     ret_from_fork+34
> ]: 4644
> @[]: 25095
> @[
>     trace_retpoline+1
>     __trace_retpoline+30
>     __x86_indirect_thunk_rax+33
>     lapic_next_event+28
>     clockevents_program_event+148
>     hrtimer_start_range_ns+528
>     start_sw_timer+356
>     restart_apic_timer+85
>     kvm_set_msr_common+1497
>     msr_interception+142
>     vcpu_enter_guest+684
>     kvm_arch_vcpu_ioctl_run+261
>     kvm_vcpu_ioctl+559
>     do_vfs_ioctl+164
>     ksys_ioctl+96
>     __x64_sys_ioctl+22
>     do_syscall_64+89
>     entry_SYSCALL_64_after_hwframe+68
> ]: 41474
> @[
>     trace_retpoline+1
>     __trace_retpoline+30
>     __x86_indirect_thunk_rax+33
>     clockevents_program_event+148
>     hrtimer_start_range_ns+528
>     start_sw_timer+356
>     restart_apic_timer+85
>     kvm_set_msr_common+1497
>     msr_interception+142
>     vcpu_enter_guest+684
>     kvm_arch_vcpu_ioctl_run+261
>     kvm_vcpu_ioctl+559
>     do_vfs_ioctl+164
>     ksys_ioctl+96
>     __x64_sys_ioctl+22
>     do_syscall_64+89
>     entry_SYSCALL_64_after_hwframe+68
> ]: 41474
> @[
>     trace_retpoline+1
>     __trace_retpoline+30
>     __x86_indirect_thunk_rax+33
>     ktime_get+58
>     clockevents_program_event+84
>     hrtimer_start_range_ns+528
>     start_sw_timer+356
>     restart_apic_timer+85
>     kvm_set_msr_common+1497
>     msr_interception+142
>     vcpu_enter_guest+684
>     kvm_arch_vcpu_ioctl_run+261
>     kvm_vcpu_ioctl+559
>     do_vfs_ioctl+164
>     ksys_ioctl+96
>     __x64_sys_ioctl+22
>     do_syscall_64+89
>     entry_SYSCALL_64_after_hwframe+68
> ]: 41887
> @[
>     trace_retpoline+1
>     __trace_retpoline+30
>     __x86_indirect_thunk_rax+33
>     lapic_next_event+28
>     clockevents_program_event+148
>     hrtimer_try_to_cancel+168
>     hrtimer_cancel+21
>     kvm_set_lapic_tscdeadline_msr+43
>     kvm_set_msr_common+1497
>     msr_interception+142
>     vcpu_enter_guest+684
>     kvm_arch_vcpu_ioctl_run+261
>     kvm_vcpu_ioctl+559
>     do_vfs_ioctl+164
>     ksys_ioctl+96
>     __x64_sys_ioctl+22
>     do_syscall_64+89
>     entry_SYSCALL_64_after_hwframe+68
> ]: 42723
> @[
>     trace_retpoline+1
>     __trace_retpoline+30
>     __x86_indirect_thunk_rax+33
>     clockevents_program_event+148
>     hrtimer_try_to_cancel+168
>     hrtimer_cancel+21
>     kvm_set_lapic_tscdeadline_msr+43
>     kvm_set_msr_common+1497
>     msr_interception+142
>     vcpu_enter_guest+684
>     kvm_arch_vcpu_ioctl_run+261
>     kvm_vcpu_ioctl+559
>     do_vfs_ioctl+164
>     ksys_ioctl+96
>     __x64_sys_ioctl+22
>     do_syscall_64+89
>     entry_SYSCALL_64_after_hwframe+68
> ]: 42766
> @[
>     trace_retpoline+1
>     __trace_retpoline+30
>     __x86_indirect_thunk_rax+33
>     ktime_get+58
>     clockevents_program_event+84
>     hrtimer_try_to_cancel+168
>     hrtimer_cancel+21
>     kvm_set_lapic_tscdeadline_msr+43
>     kvm_set_msr_common+1497
>     msr_interception+142
>     vcpu_enter_guest+684
>     kvm_arch_vcpu_ioctl_run+261
>     kvm_vcpu_ioctl+559
>     do_vfs_ioctl+164
>     ksys_ioctl+96
>     __x64_sys_ioctl+22
>     do_syscall_64+89
>     entry_SYSCALL_64_after_hwframe+68
> ]: 42848
> @[
>     trace_retpoline+1
>     __trace_retpoline+30
>     __x86_indirect_thunk_rax+33
>     ktime_get+58
>     start_sw_timer+279
>     restart_apic_timer+85
>     kvm_set_msr_common+1497
>     msr_interception+142
>     vcpu_enter_guest+684
>     kvm_arch_vcpu_ioctl_run+261
>     kvm_vcpu_ioctl+559
>     do_vfs_ioctl+164
>     ksys_ioctl+96
>     __x64_sys_ioctl+22
>     do_syscall_64+89
>     entry_SYSCALL_64_after_hwframe+68
> ]: 499845
> 
> @total: 1780243
> 
> SVM has no TSC based programmable preemption timer so it is invoking
> ktime_get() frequently.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  arch/x86/kvm/svm.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 0021e11fd1fb..3942bca46740 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -4995,6 +4995,18 @@ int kvm_x86_handle_exit(struct kvm_vcpu *vcpu)
>  		return 0;
>  	}
>  
> +#ifdef CONFIG_RETPOLINE
> +	if (exit_code == SVM_EXIT_MSR)
> +		return msr_interception(svm);
> +	else if (exit_code == SVM_EXIT_VINTR)
> +		return interrupt_window_interception(svm);
> +	else if (exit_code == SVM_EXIT_INTR)
> +		return intr_interception(svm);
> +	else if (exit_code == SVM_EXIT_HLT)
> +		return halt_interception(svm);
> +	else if (exit_code == SVM_EXIT_NPF)
> +		return npf_interception(svm);
> +#endif
>  	return svm_exit_handlers[exit_code](svm);
>  }
>  
> 

Queued, thanks (BTW, I still disagree about HLT exits but okay).

Paolo
