Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CAFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACA02082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394926AbfIFPrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:47:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:2595 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbfIFPrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:47:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 08:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="358818953"
Received: from ibutcher-mobl1.ger.corp.intel.com (HELO [10.251.95.104]) ([10.251.95.104])
  by orsmga005.jf.intel.com with ESMTP; 06 Sep 2019 08:47:39 -0700
Subject: Re: [Intel-gfx] [PATCH v4 5/5] drm/i915/pmu: Support multiple GPUs
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190801141732.31335-5-tvrtko.ursulin@linux.intel.com>
 <20190801155438.23986-1-tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Michal Wajdeczko <michal.wajdeczko@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <fe351573-7d82-d50f-e004-32da7c6a0407@linux.intel.com>
Date:   Fri, 6 Sep 2019 16:47:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801155438.23986-1-tvrtko.ursulin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter, Thomas,

If you could spare a moment for some brainstorming on the topic of 
uncore PMU and multiple providers it would be appreciated.

So from i915 we export some metrics as uncore PMU, which shows up under 
/sys/devices/i915. Shortsightedness or what, we did not realize that one 
day we could have more than one i915 device in a system which now 
creates a problem, or at least raises a question on naming.

The patch below works around this by appending the PCI device name to 
additional instances of i915 when it registers with perf_pmu_register.

Question is if there is a better solution, or if not, whether you are 
aware of any plans to extend the perf core to better support this? Are 
there any other uncore PMU providers in an identical situation?

Regards,

Tvrtko

On 01/08/2019 16:54, Tvrtko Ursulin wrote:
> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> 
> With discrete graphics system can have both integrated and discrete GPU
> handled by i915.
> 
> Currently we use a fixed name ("i915") when registering as the uncore PMU
> provider which stops working in this case.
> 
> To fix this we add the PCI device name string to non-integrated devices
> handled by us. Integrated devices keep the legacy name preserving
> backward compatibility.
> 
> v2:
>   * Detect IGP and keep legacy name. (Michal)
>   * Use PCI device name as suffix. (Michal, Chris)
> 
> v3:
>   * Constify the name. (Chris)
>   * Use pci_domain_nr. (Chris)
> 
> v4:
>   * Fix kfree_const usage. (Chris)
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
> ---
>   drivers/gpu/drm/i915/i915_pmu.c | 25 +++++++++++++++++++++++--
>   drivers/gpu/drm/i915/i915_pmu.h |  4 ++++
>   2 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index e0e0180bca7c..e0fea227077e 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -1053,6 +1053,15 @@ static void i915_pmu_unregister_cpuhp_state(struct i915_pmu *pmu)
>   	cpuhp_remove_multi_state(cpuhp_slot);
>   }
>   
> +static bool is_igp(struct pci_dev *pdev)
> +{
> +	/* IGP is 0000:00:02.0 */
> +	return pci_domain_nr(pdev->bus) == 0 &&
> +	       pdev->bus->number == 0 &&
> +	       PCI_SLOT(pdev->devfn) == 2 &&
> +	       PCI_FUNC(pdev->devfn) == 0;
> +}
> +
>   void i915_pmu_register(struct drm_i915_private *i915)
>   {
>   	struct i915_pmu *pmu = &i915->pmu;
> @@ -1083,10 +1092,19 @@ void i915_pmu_register(struct drm_i915_private *i915)
>   	hrtimer_init(&pmu->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>   	pmu->timer.function = i915_sample;
>   
> -	ret = perf_pmu_register(&pmu->base, "i915", -1);
> -	if (ret)
> +	if (!is_igp(i915->drm.pdev))
> +		pmu->name = kasprintf(GFP_KERNEL,
> +				      "i915-%s",
> +				      dev_name(i915->drm.dev));
> +	else
> +		pmu->name = "i915";
> +	if (!pmu->name)
>   		goto err;
>   
> +	ret = perf_pmu_register(&pmu->base, pmu->name, -1);
> +	if (ret)
> +		goto err_name;
> +
>   	ret = i915_pmu_register_cpuhp_state(pmu);
>   	if (ret)
>   		goto err_unreg;
> @@ -1095,6 +1113,8 @@ void i915_pmu_register(struct drm_i915_private *i915)
>   
>   err_unreg:
>   	perf_pmu_unregister(&pmu->base);
> +err_name:
> +	kfree_const(pmu->name);
>   err:
>   	pmu->base.event_init = NULL;
>   	free_event_attributes(pmu);
> @@ -1116,5 +1136,6 @@ void i915_pmu_unregister(struct drm_i915_private *i915)
>   
>   	perf_pmu_unregister(&pmu->base);
>   	pmu->base.event_init = NULL;
> +	kfree_const(pmu->name);
>   	free_event_attributes(pmu);
>   }
> diff --git a/drivers/gpu/drm/i915/i915_pmu.h b/drivers/gpu/drm/i915/i915_pmu.h
> index 4fc4f2478301..ff24f3bb0102 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.h
> +++ b/drivers/gpu/drm/i915/i915_pmu.h
> @@ -46,6 +46,10 @@ struct i915_pmu {
>   	 * @base: PMU base.
>   	 */
>   	struct pmu base;
> +	/**
> +	 * @name: Name as registered with perf core.
> +	 */
> +	const char *name;
>   	/**
>   	 * @lock: Lock protecting enable mask and ref count handling.
>   	 */
> 
