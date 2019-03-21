Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E31C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1A9218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfCUQbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:31:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59264 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbfCUQbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:31:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11AF1374;
        Thu, 21 Mar 2019 09:31:05 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45C3D3F614;
        Thu, 21 Mar 2019 09:31:04 -0700 (PDT)
Subject: Re: [WARNING] tick_handle_oneshot_broadcast() on !online CPU
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
References: <7fe83094-6821-dd94-f91e-6beb658bc7e6@arm.com>
 <alpine.DEB.2.21.1903211540180.1784@nanos.tec.linutronix.de>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <786a6467-21f4-d33a-e032-030c97fd3577@arm.com>
Date:   Thu, 21 Mar 2019 16:31:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903211540180.1784@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2019 15:39, Thomas Gleixner wrote:
> On Thu, 21 Mar 2019, Valentin Schneider wrote:
>> I stared at the code and did a bit of tracing, the sequence seems to be:
>>
>> ---
>> echo 0 > /sys/devices/system/cpu/cpu2/online
>>
>> takedown_cpu()
>>   take_cpu_down()
>>      __cpu_disable() (clears CPU in cpu_online_mask & cpu_active_mask)
> 
> active_mask has been cleared long ago.

Right, dunno where I picked that up...

[...]
> Hmm. This only seems to be an issue with forced broadcast. The dynamic
> broadcast stuff does not have that problem as the CPU is obviously not idle
> while going down.
> 
> Patch below (completely untested) should fix it.
> 
> Thanks,
> 

No more warns after a few hundred iterations, and the tick_offline_cpu()
in take_cpu_down() makes sense to me.

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks!
Valentin

> 	tglx
> 
> 8<---------------
> 
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -68,6 +68,12 @@ extern void tick_broadcast_control(enum
>  static inline void tick_broadcast_control(enum tick_broadcast_mode mode) { }
>  #endif /* BROADCAST */
>  
> +#if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_CPU)
> +extern void tick_offline_cpu(unsigned int cpu);
> +#else
> +static inline void tick_offline_cpu(unsigned int cpu) { }
> +#endif
> +
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
>  extern int tick_broadcast_oneshot_control(enum tick_broadcast_state state);
>  #else
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -844,6 +844,8 @@ static int take_cpu_down(void *_param)
>  
>  	/* Give up timekeeping duties */
>  	tick_handover_do_timer();
> +	/* Remove CPU from timer broadcasting */
> +	tick_offline_cpu(cpu);
>  	/* Park the stopper thread */
>  	stop_machine_park(cpu);
>  	return 0;
> --- a/kernel/time/clockevents.c
> +++ b/kernel/time/clockevents.c
> @@ -611,6 +611,22 @@ void clockevents_resume(void)
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> +
> +# ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> +/**
> + * tick_offline_cpu - Take CPU out of the broadcast mechanism
> + * @cpu:	The outgoing CPU
> + *
> + * Called on the outgoing CPU after it took itself offline.
> + */
> +void tick_offline_cpu(unsigned int cpu)
> +{
> +	raw_spin_lock(&clockevents_lock);
> +	tick_broadcast_offline(cpu);
> +	raw_spin_unlock(&clockevents_lock);
> +}
> +# endif
> +
>  /**
>   * tick_cleanup_dead_cpu - Cleanup the tick and clockevents of a dead cpu
>   */
> @@ -621,8 +637,6 @@ void tick_cleanup_dead_cpu(int cpu)
>  
>  	raw_spin_lock_irqsave(&clockevents_lock, flags);
>  
> -	tick_shutdown_broadcast_oneshot(cpu);
> -	tick_shutdown_broadcast(cpu);
>  	tick_shutdown(cpu);
>  	/*
>  	 * Unregister the clock event devices which were
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -36,10 +36,12 @@ static __cacheline_aligned_in_smp DEFINE
>  static void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
>  static void tick_broadcast_clear_oneshot(int cpu);
>  static void tick_resume_broadcast_oneshot(struct clock_event_device *bc);
> +static void tick_broadcast_oneshot_offline(unsigned int cpu);
>  #else
>  static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc) { BUG(); }
>  static inline void tick_broadcast_clear_oneshot(int cpu) { }
>  static inline void tick_resume_broadcast_oneshot(struct clock_event_device *bc) { }
> +static inline void tick_broadcast_oneshot_offline(unsigned int cpu) { }
>  #endif
>  
>  /*
> @@ -444,8 +446,6 @@ void tick_shutdown_broadcast(unsigned in
>  	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
>  
>  	bc = tick_broadcast_device.evtdev;
> -	cpumask_clear_cpu(cpu, tick_broadcast_mask);
> -	cpumask_clear_cpu(cpu, tick_broadcast_on);
>  
>  	if (tick_broadcast_device.mode == TICKDEV_MODE_PERIODIC) {
>  		if (bc && cpumask_empty(tick_broadcast_mask))
> @@ -454,6 +454,16 @@ void tick_shutdown_broadcast(unsigned in
>  
>  	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
>  }
> +
> +void tick_broadcast_offline(unsigned int cpu)
> +{
> +	raw_spin_lock(&tick_broadcast_lock);
> +	cpumask_clear_cpu(cpu, tick_broadcast_mask);
> +	cpumask_clear_cpu(cpu, tick_broadcast_on);
> +	tick_broadcast_oneshot_offline(cpu);
> +	raw_spin_unlock(&tick_broadcast_lock);
> +}
> +
>  #endif
>  
>  void tick_suspend_broadcast(void)
> @@ -950,14 +960,10 @@ void hotplug_cpu__broadcast_tick_pull(in
>  }
>  
>  /*
> - * Remove a dead CPU from broadcasting
> + * Remove a dying CPU from broadcasting
>   */
> -void tick_shutdown_broadcast_oneshot(unsigned int cpu)
> +static void tick_broadcast_oneshot_offline(unsigned int cpu)
>  {
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
> -
>  	/*
>  	 * Clear the broadcast masks for the dead cpu, but do not stop
>  	 * the broadcast device!
> @@ -965,8 +971,6 @@ void tick_shutdown_broadcast_oneshot(uns
>  	cpumask_clear_cpu(cpu, tick_broadcast_oneshot_mask);
>  	cpumask_clear_cpu(cpu, tick_broadcast_pending_mask);
>  	cpumask_clear_cpu(cpu, tick_broadcast_force_mask);
> -
> -	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
>  }
>  #endif
>  
> --- a/kernel/time/tick-internal.h
> +++ b/kernel/time/tick-internal.h
> @@ -64,7 +64,6 @@ extern ssize_t sysfs_get_uname(const cha
>  extern int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu);
>  extern void tick_install_broadcast_device(struct clock_event_device *dev);
>  extern int tick_is_broadcast_device(struct clock_event_device *dev);
> -extern void tick_shutdown_broadcast(unsigned int cpu);
>  extern void tick_suspend_broadcast(void);
>  extern void tick_resume_broadcast(void);
>  extern bool tick_resume_check_broadcast(void);
> @@ -78,7 +77,6 @@ static inline void tick_install_broadcas
>  static inline int tick_is_broadcast_device(struct clock_event_device *dev) { return 0; }
>  static inline int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu) { return 0; }
>  static inline void tick_do_periodic_broadcast(struct clock_event_device *d) { }
> -static inline void tick_shutdown_broadcast(unsigned int cpu) { }
>  static inline void tick_suspend_broadcast(void) { }
>  static inline void tick_resume_broadcast(void) { }
>  static inline bool tick_resume_check_broadcast(void) { return false; }
> @@ -128,19 +126,23 @@ static inline int tick_check_oneshot_cha
>  /* Functions related to oneshot broadcasting */
>  #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_TICK_ONESHOT)
>  extern void tick_broadcast_switch_to_oneshot(void);
> -extern void tick_shutdown_broadcast_oneshot(unsigned int cpu);
>  extern int tick_broadcast_oneshot_active(void);
>  extern void tick_check_oneshot_broadcast_this_cpu(void);
>  bool tick_broadcast_oneshot_available(void);
>  extern struct cpumask *tick_get_broadcast_oneshot_mask(void);
>  #else /* !(BROADCAST && ONESHOT): */
>  static inline void tick_broadcast_switch_to_oneshot(void) { }
> -static inline void tick_shutdown_broadcast_oneshot(unsigned int cpu) { }
>  static inline int tick_broadcast_oneshot_active(void) { return 0; }
>  static inline void tick_check_oneshot_broadcast_this_cpu(void) { }
>  static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_possible(); }
>  #endif /* !(BROADCAST && ONESHOT) */
>  
> +#if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_CPU)
> +extern void tick_broadcast_offline(unsigned int cpu);
> +#else
> +static inline void tick_broadcast_offline(unsigned int cpu) { }
> +#endif
> +
>  /* NO_HZ_FULL internal */
>  #ifdef CONFIG_NO_HZ_FULL
>  extern void tick_nohz_init(void);
> 
