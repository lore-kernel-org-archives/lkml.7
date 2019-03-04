Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC59C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10F520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfCDOal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:30:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:49488 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbfCDOal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:30:41 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 06:30:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="131088556"
Received: from chenyu-office.sh.intel.com ([10.239.158.163])
  by orsmga003.jf.intel.com with ESMTP; 04 Mar 2019 06:30:38 -0800
Date:   Mon, 4 Mar 2019 22:39:28 +0800
From:   Yu Chen <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [RFT][Update][PATCH 2/2] cpufreq: intel_pstate: Update max CPU
 frequency on global turbo changes
Message-ID: <20190304143928.GA13701@chenyu-office.sh.intel.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan>
 <2046937.YMVy5Qh3Pm@aspire.rjw.lan>
 <3017597.CVkTxgYgAs@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3017597.CVkTxgYgAs@aspire.rjw.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 01:57:06PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> While the cpuinfo.max_freq value doesn't really matter for
> intel_pstate in the active mode, in the passive mode it is used by
> governors as the maximum physical frequency of the CPU and the
> results of governor computations generally depend on it.  Also it
> is made available to user space via sysfs and it should match the
> current HW configuration.
> 
> For this reason, make intel_pstate update cpuinfo.max_freq for all
> CPUs if it detects a global change of turbo frequency settings from
> "disable" to "enable" or the other way associated with a _PPC change
> notification from the platform firmware.
> 
> Note that policy_is_inactive() and cpufreq_set_policy() need to be
> made available to it for this purpose.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
> Reported-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Update, because the patch sent previously doesn't build, due to an extra
> arg declared for intel_pstate_update_max_freq().
> 
> ---
>  drivers/cpufreq/cpufreq.c      |   12 ++----------
>  drivers/cpufreq/intel_pstate.c |   33 ++++++++++++++++++++++++++++++++-
>  include/linux/cpufreq.h        |    7 +++++++
>  3 files changed, 41 insertions(+), 11 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -897,6 +897,36 @@ static void intel_pstate_update_policies
>  		cpufreq_update_policy(cpu);
>  }
>  
> +static void intel_pstate_update_max_freq(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +	struct cpufreq_policy new_policy;
> +	struct cpudata *cpudata;
> +
> +	if (!policy)
> +		return;
> +
> +	down_write(&policy->rwsem);
> +
> +	if (policy_is_inactive(policy))
> +		goto unlock;
> +
> +	cpudata = all_cpu_data[cpu];
> +	policy->cpuinfo.max_freq = global.turbo_disabled_upd ?
> +			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
> +
> +	memcpy(&new_policy, policy, sizeof(*policy));
> +	new_policy.max = min(policy->user_policy.max, policy->cpuinfo.max_freq);
> +	new_policy.min = min(policy->user_policy.min, new_policy.max);
> +
> +	cpufreq_set_policy(policy, &new_policy);
> +
> +unlock:
> +	up_write(&policy->rwsem);
> +
> +	cpufreq_cpu_put(policy);
> +}
> +
I tried to test on a macbook in hand however I did not see the _PPC
notifier on this machine so it might not cover the code path in
this patch. I checked the cpufreq with this patch using
different load and the cpufreq scales well.

>  static void intel_pstate_update_limits(unsigned int cpu)
>  {
>  	mutex_lock(&intel_pstate_driver_lock);
> @@ -908,7 +938,8 @@ static void intel_pstate_update_limits(u
>  	 */
>  	if (global.turbo_disabled_upd != global.turbo_disabled) {
>  		global.turbo_disabled_upd = global.turbo_disabled;
> -		intel_pstate_update_policies();
> +		for_each_possible_cpu(cpu)
> +			intel_pstate_update_max_freq(cpu);
>  	} else {
>  		cpufreq_update_policy(cpu);
>  	}
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -34,11 +34,6 @@
>  
>  static LIST_HEAD(cpufreq_policy_list);
>  
> -static inline bool policy_is_inactive(struct cpufreq_policy *policy)
> -{
> -	return cpumask_empty(policy->cpus);
> -}
> -
>  /* Macros to iterate over CPU policies */
>  #define for_each_suitable_policy(__policy, __active)			 \
>  	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
> @@ -675,9 +670,6 @@ static ssize_t show_scaling_cur_freq(str
>  	return ret;
>  }
>  
> -static int cpufreq_set_policy(struct cpufreq_policy *policy,
> -				struct cpufreq_policy *new_policy);
> -
>  /**
>   * cpufreq_per_cpu_attr_write() / store_##file_name() - sysfs write access
>   */
> @@ -2235,8 +2227,8 @@ EXPORT_SYMBOL(cpufreq_get_policy);
>   *
>   * The cpuinfo part of @policy is not updated by this function.
>   */
There first seems to be some patching error when applying this on
top of upstream 5.0, but I realized that this patch is based on
intel-next.

Thanks,
Ryan

> -static int cpufreq_set_policy(struct cpufreq_policy *policy,
> -			      struct cpufreq_policy *new_policy)
> +int cpufreq_set_policy(struct cpufreq_policy *policy,
> +		       struct cpufreq_policy *new_policy)
>  {
>  	struct cpufreq_governor *old_gov;
>  	int ret;
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -178,6 +178,11 @@ static inline struct cpufreq_policy *cpu
>  static inline void cpufreq_cpu_put(struct cpufreq_policy *policy) { }
>  #endif
>  
> +static inline bool policy_is_inactive(struct cpufreq_policy *policy)
> +{
> +	return cpumask_empty(policy->cpus);
> +}
> +
>  static inline bool policy_is_shared(struct cpufreq_policy *policy)
>  {
>  	return cpumask_weight(policy->cpus) > 1;
> @@ -194,6 +199,8 @@ void disable_cpufreq(void);
>  
>  u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
>  int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
> +int cpufreq_set_policy(struct cpufreq_policy *policy,
> +		       struct cpufreq_policy *new_policy);
>  void cpufreq_update_policy(unsigned int cpu);
>  void cpufreq_update_limits(unsigned int cpu);
>  bool have_governor_per_policy(void);
> 
