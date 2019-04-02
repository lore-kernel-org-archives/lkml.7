Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177ACC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E533420883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbfDBNbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:31:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfDBNbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:31:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 571483082A4C;
        Tue,  2 Apr 2019 13:31:34 +0000 (UTC)
Received: from treble (ovpn-123-221.rdu2.redhat.com [10.10.123.221])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43D6783EAF;
        Tue,  2 Apr 2019 13:31:28 +0000 (UTC)
Date:   Tue, 2 Apr 2019 08:31:21 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     tip-bot for Josh Poimboeuf <tipbot@zytor.com>
Cc:     linux-tip-commits@vger.kernel.org, aarcange@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        jikos@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, longman@redhat.com
Subject: Re: [tip:smp/hotplug] cpu/hotplug: Create SMT sysfs interface for
 all arches
Message-ID: <20190402133121.kvf55gv6rz4ssf5o@treble>
References: <469c2b98055f2c41e75748e06447d592a64080c9.1553635520.git.jpoimboe@redhat.com>
 <tip-de7b77e5bb9451417ca57f1b6501da654587c048@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tip-de7b77e5bb9451417ca57f1b6501da654587c048@git.kernel.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 02 Apr 2019 13:31:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 03:40:06AM -0700, tip-bot for Josh Poimboeuf wrote:
> Commit-ID:  de7b77e5bb9451417ca57f1b6501da654587c048
> Gitweb:     https://git.kernel.org/tip/de7b77e5bb9451417ca57f1b6501da654587c048
> Author:     Josh Poimboeuf <jpoimboe@redhat.com>
> AuthorDate: Wed, 27 Mar 2019 07:00:29 -0500
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Tue, 2 Apr 2019 12:36:56 +0200
> 
> cpu/hotplug: Create SMT sysfs interface for all arches
> 
> Make the /sys/devices/system/cpu/smt/* files available on all arches, so
> user space has a consistent way to detect whether SMT is enabled.
> 
> The 'control' file now shows 'notimplemented' for architectures which
> don't yet have CONFIG_HOTPLUG_SMT.
> 
> [ tglx: Make notimplemented a real state ]

Yes, that's better.  Thanks!

> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Link: https://lkml.kernel.org/r/469c2b98055f2c41e75748e06447d592a64080c9.1553635520.git.jpoimboe@redhat.com
> 
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 10 ++--
>  include/linux/cpu.h                                |  3 +-
>  kernel/cpu.c                                       | 64 +++++++++++++---------
>  3 files changed, 47 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 9605dbd4b5b5..5eea46fefcb2 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -511,10 +511,12 @@ Description:	Control Symetric Multi Threading (SMT)
>  		control: Read/write interface to control SMT. Possible
>  			 values:
>  
> -			 "on"		SMT is enabled
> -			 "off"		SMT is disabled
> -			 "forceoff"	SMT is force disabled. Cannot be changed.
> -			 "notsupported" SMT is not supported by the CPU
> +			 "on"		  SMT is enabled
> +			 "off"		  SMT is disabled
> +			 "forceoff"	  SMT is force disabled. Cannot be changed.
> +			 "notsupported"   SMT is not supported by the CPU
> +			 "notimplemented" SMT runtime toggling is not
> +					  implemented for the architecture
>  
>  			 If control status is "forceoff" or "notsupported" writes
>  			 are rejected.
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 5041357d0297..ae99dde02320 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -175,6 +175,7 @@ enum cpuhp_smt_control {
>  	CPU_SMT_DISABLED,
>  	CPU_SMT_FORCE_DISABLED,
>  	CPU_SMT_NOT_SUPPORTED,
> +	CPU_SMT_NOT_IMPLEMENTED,
>  };
>  
>  #if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
> @@ -182,7 +183,7 @@ extern enum cpuhp_smt_control cpu_smt_control;
>  extern void cpu_smt_disable(bool force);
>  extern void cpu_smt_check_topology(void);
>  #else
> -# define cpu_smt_control		(CPU_SMT_ENABLED)
> +# define cpu_smt_control		(CPU_SMT_NOT_IMPLEMENTED)
>  static inline void cpu_smt_disable(bool force) { }
>  static inline void cpu_smt_check_topology(void) { }
>  #endif
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6754f3ecfd94..b8bf3f93e39b 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2033,19 +2033,6 @@ static const struct attribute_group cpuhp_cpu_root_attr_group = {
>  
>  #ifdef CONFIG_HOTPLUG_SMT
>  
> -static const char *smt_states[] = {
> -	[CPU_SMT_ENABLED]		= "on",
> -	[CPU_SMT_DISABLED]		= "off",
> -	[CPU_SMT_FORCE_DISABLED]	= "forceoff",
> -	[CPU_SMT_NOT_SUPPORTED]		= "notsupported",
> -};
> -
> -static ssize_t
> -show_smt_control(struct device *dev, struct device_attribute *attr, char *buf)
> -{
> -	return snprintf(buf, PAGE_SIZE - 2, "%s\n", smt_states[cpu_smt_control]);
> -}
> -
>  static void cpuhp_offline_cpu_device(unsigned int cpu)
>  {
>  	struct device *dev = get_cpu_device(cpu);
> @@ -2116,9 +2103,10 @@ static int cpuhp_smt_enable(void)
>  	return ret;
>  }
>  
> +
>  static ssize_t
> -store_smt_control(struct device *dev, struct device_attribute *attr,
> -		  const char *buf, size_t count)
> +__store_smt_control(struct device *dev, struct device_attribute *attr,
> +		    const char *buf, size_t count)
>  {
>  	int ctrlval, ret;
>  
> @@ -2156,14 +2144,44 @@ store_smt_control(struct device *dev, struct device_attribute *attr,
>  	unlock_device_hotplug();
>  	return ret ? ret : count;
>  }
> +
> +#else /* !CONFIG_HOTPLUG_SMT */
> +static ssize_t
> +__store_smt_control(struct device *dev, struct device_attribute *attr,
> +		    const char *buf, size_t count)
> +{
> +	return -ENODEV;
> +}
> +#endif /* CONFIG_HOTPLUG_SMT */
> +
> +static const char *smt_states[] = {
> +	[CPU_SMT_ENABLED]		= "on",
> +	[CPU_SMT_DISABLED]		= "off",
> +	[CPU_SMT_FORCE_DISABLED]	= "forceoff",
> +	[CPU_SMT_NOT_SUPPORTED]		= "notsupported",
> +	[CPU_SMT_NOT_IMPLEMENTED]	= "notimplemented",
> +};
> +
> +static ssize_t
> +show_smt_control(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	const char *state = smt_states[cpu_smt_control];
> +
> +	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
> +}
> +
> +static ssize_t
> +store_smt_control(struct device *dev, struct device_attribute *attr,
> +		  const char *buf, size_t count)
> +{
> +	return __store_smt_control(dev, attr, buf, count);
> +}
>  static DEVICE_ATTR(control, 0644, show_smt_control, store_smt_control);
>  
>  static ssize_t
>  show_smt_active(struct device *dev, struct device_attribute *attr, char *buf)
>  {
> -	bool active = topology_max_smt_threads() > 1;
> -
> -	return snprintf(buf, PAGE_SIZE - 2, "%d\n", active);
> +	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
>  }
>  static DEVICE_ATTR(active, 0444, show_smt_active, NULL);
>  
> @@ -2179,21 +2197,17 @@ static const struct attribute_group cpuhp_smt_attr_group = {
>  	NULL
>  };
>  
> -static int __init cpu_smt_state_init(void)
> +static int __init cpu_smt_sysfs_init(void)
>  {
>  	return sysfs_create_group(&cpu_subsys.dev_root->kobj,
>  				  &cpuhp_smt_attr_group);
>  }
>  
> -#else
> -static inline int cpu_smt_state_init(void) { return 0; }
> -#endif
> -
>  static int __init cpuhp_sysfs_init(void)
>  {
>  	int cpu, ret;
>  
> -	ret = cpu_smt_state_init();
> +	ret = cpu_smt_sysfs_init();
>  	if (ret)
>  		return ret;
>  
> @@ -2214,7 +2228,7 @@ static int __init cpuhp_sysfs_init(void)
>  	return 0;
>  }
>  device_initcall(cpuhp_sysfs_init);
> -#endif
> +#endif /* CONFIG_SYSFS && CONFIG_HOTPLUG_CPU */
>  
>  /*
>   * cpu_bit_bitmap[] is a special, "compressed" data structure that

-- 
Josh
