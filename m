Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73011C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426D3206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbfI3Plp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:41:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730780AbfI3Plp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:41:45 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CAB7859FF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 15:41:44 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id t11so4688009wrq.19
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 08:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=t36SD6rbG6Ox7eVRaZRgR+czMyT+mDl4LHkZc37z7nY=;
        b=PxiS5V63IPtKDlQJjR0VKTrNaYlyWWcq7ECq0jLpaw/TfF9eHuJ4rkrQQrpOWl//tz
         UrMvzSP/+ZOC898F39pCdHYC9q54S0VIIsg3pvkK46I+9TbwUvZtXe/Z5djdr2dXOkf4
         ktSGLGanhfGYvy+kEKeWwN+QpCs+dTJvtkb4g1k5c0HLMBYeLjn3GI7Cw6WIW0Bqfeq+
         SZfBCnqH1nFtqB+LMnbr7CGsMqmdiZrL9WAvVFdw+GihnFx3U+xNl3iB56WLJns9DlMG
         w2IicBfWdLTi2tsxDureP6INSgkjq40/UTFx6JvXxTpz+aATsYW42pFRqIB0uobLXoSN
         5RRg==
X-Gm-Message-State: APjAAAXjUBeLJbgrX8Tb5aHOY+e2CQVp69DcqWAfRjHvaJpAKOAvJs33
        29dJlUTp3xvTCYRDu0Bq/s/ZUXOUIByRoUNixQHySlTcQ9YBhzbkE8DDrd4TiB6UuY0UqNmX6Cv
        7USiBEk7QPHnqeqOvLMrJpqfO
X-Received: by 2002:a1c:6841:: with SMTP id d62mr18329730wmc.48.1569858102972;
        Mon, 30 Sep 2019 08:41:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyWbVgHFrBFTAT6FQPdm5LZaBJahRiGfad0UBdHndQAWlE2Om7W6ldTAC1qNejT8OzwpWGVBA==
X-Received: by 2002:a1c:6841:: with SMTP id d62mr18329702wmc.48.1569858102711;
        Mon, 30 Sep 2019 08:41:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d78sm16644579wmd.47.2019.09.30.08.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 08:41:42 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/3] KVM: X86: Add "nopvspin" parameter to disable PV spinlocks
In-Reply-To: <1569759666-26904-2-git-send-email-zhenzhong.duan@oracle.com>
References: <1569759666-26904-1-git-send-email-zhenzhong.duan@oracle.com> <1569759666-26904-2-git-send-email-zhenzhong.duan@oracle.com>
Date:   Mon, 30 Sep 2019 17:41:41 +0200
Message-ID: <87pnjh3i6i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhenzhong Duan <zhenzhong.duan@oracle.com> writes:

> There are cases where a guest tries to switch spinlocks to bare metal
> behavior (e.g. by setting "xen_nopvspin" on XEN platform and
> "hv_nopvspin" on HYPER_V).
>
> That feature is missed on KVM, add a new parameter "nopvspin" to disable
> PV spinlocks for KVM guest.
>
> This new parameter is also intended to replace "xen_nopvspin" and
> "hv_nopvspin" in the future.

Any reason to not do it right now? We will probably need to have compat
code to support xen_nopvspin/hv_nopvspin too but emit a 'is deprecated'
warning.

>
> The global variable pvspin isn't defined as __initdata as it's used at
> runtime by XEN guest.
>
> Refactor the print stuff with pr_* which is preferred.

Please do it in a separate patch.

>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krcmar <rkrcmar@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  arch/x86/include/asm/qspinlock.h                |  1 +
>  arch/x86/kernel/kvm.c                           | 27 ++++++++++++++++---------
>  kernel/locking/qspinlock.c                      |  7 +++++++
>  4 files changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c7ac2f3..4b956d8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5330,6 +5330,10 @@
>  			as generic guest with no PV drivers. Currently support
>  			XEN HVM, KVM, HYPER_V and VMWARE guest.
>  
> +	nopvspin	[X86,KVM] Disables the qspinlock slow path
> +			using PV optimizations which allow the hypervisor to
> +			'idle' the guest on lock contention.
> +
>  	xirc2ps_cs=	[NET,PCMCIA]
>  			Format:
>  			<irq>,<irq_mask>,<io>,<full_duplex>,<do_sound>,<lockup_hack>[,<irq2>[,<irq3>[,<irq4>]]]
> diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
> index 444d6fd..34a4484 100644
> --- a/arch/x86/include/asm/qspinlock.h
> +++ b/arch/x86/include/asm/qspinlock.h
> @@ -32,6 +32,7 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
>  extern void __pv_init_lock_hash(void);
>  extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
>  extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
> +extern bool pvspin;
>  
>  #define	queued_spin_unlock queued_spin_unlock
>  /**
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index e820568..7b8cf0d 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -7,6 +7,8 @@
>   *   Authors: Anthony Liguori <aliguori@us.ibm.com>
>   */
>  
> +#define pr_fmt(fmt) "KVM: " fmt
> +
>  #include <linux/context_tracking.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -286,7 +288,7 @@ static void kvm_register_steal_time(void)
>  		return;
>  
>  	wrmsrl(MSR_KVM_STEAL_TIME, (slow_virt_to_phys(st) | KVM_MSR_ENABLED));
> -	pr_info("kvm-stealtime: cpu %d, msr %llx\n",
> +	pr_info("stealtime: cpu %d, msr %llx\n",
>  		cpu, (unsigned long long) slow_virt_to_phys(st));
>  }
>  
> @@ -321,7 +323,7 @@ static void kvm_guest_cpu_init(void)
>  
>  		wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
>  		__this_cpu_write(apf_reason.enabled, 1);
> -		printk(KERN_INFO"KVM setup async PF for cpu %d\n",
> +		pr_info("setup async PF for cpu %d\n",
>  		       smp_processor_id());
>  	}
>  
> @@ -347,7 +349,7 @@ static void kvm_pv_disable_apf(void)
>  	wrmsrl(MSR_KVM_ASYNC_PF_EN, 0);
>  	__this_cpu_write(apf_reason.enabled, 0);
>  
> -	printk(KERN_INFO"Unregister pv shared memory for cpu %d\n",
> +	pr_info("Unregister pv shared memory for cpu %d\n",
>  	       smp_processor_id());
>  }
>  
> @@ -509,7 +511,7 @@ static void kvm_setup_pv_ipi(void)
>  {
>  	apic->send_IPI_mask = kvm_send_ipi_mask;
>  	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
> -	pr_info("KVM setup pv IPIs\n");
> +	pr_info("setup pv IPIs\n");
>  }
>  
>  static void kvm_smp_send_call_func_ipi(const struct cpumask *mask)
> @@ -639,11 +641,11 @@ static void __init kvm_guest_init(void)
>  	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
>  	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
>  		smp_ops.send_call_func_ipi = kvm_smp_send_call_func_ipi;
> -		pr_info("KVM setup pv sched yield\n");
> +		pr_info("setup pv sched yield\n");
>  	}
>  	if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/kvm:online",
>  				      kvm_cpu_online, kvm_cpu_down_prepare) < 0)
> -		pr_err("kvm_guest: Failed to install cpu hotplug callbacks\n");
> +		pr_err("failed to install cpu hotplug callbacks\n");
>  #else
>  	sev_map_percpu_data();
>  	kvm_guest_cpu_init();
> @@ -746,7 +748,7 @@ static __init int kvm_setup_pv_tlb_flush(void)
>  			zalloc_cpumask_var_node(per_cpu_ptr(&__pv_tlb_mask, cpu),
>  				GFP_KERNEL, cpu_to_node(cpu));
>  		}
> -		pr_info("KVM setup pv remote TLB flush\n");
> +		pr_info("setup pv remote TLB flush\n");
>  	}
>  
>  	return 0;
> @@ -842,6 +844,13 @@ void __init kvm_spinlock_init(void)
>  	if (num_possible_cpus() == 1)
>  		return;
>  
> +	if (!pvspin) {
> +		pr_info("PV spinlocks disabled\n");
> +		static_branch_disable(&virt_spin_lock_key);
> +		return;
> +	}
> +	pr_info("PV spinlocks enabled\n");
> +
>  	__pv_init_lock_hash();
>  	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
>  	pv_ops.lock.queued_spin_unlock =
> @@ -872,8 +881,8 @@ static void kvm_enable_host_haltpoll(void *i)
>  void arch_haltpoll_enable(unsigned int cpu)
>  {
>  	if (!kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL)) {
> -		pr_err_once("kvm: host does not support poll control\n");
> -		pr_err_once("kvm: host upgrade recommended\n");
> +		pr_err_once("host does not support poll control\n");
> +		pr_err_once("host upgrade recommended\n");
>  		return;
>  	}
>  
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 2473f10..945b510 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -580,4 +580,11 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  #include "qspinlock_paravirt.h"
>  #include "qspinlock.c"
>  
> +bool pvspin = true;
> +static __init int parse_nopvspin(char *arg)
> +{
> +	pvspin = false;
> +	return 0;
> +}
> +early_param("nopvspin", parse_nopvspin);
>  #endif

-- 
Vitaly
