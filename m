Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99348C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A0E2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NFukpqff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfDLHjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:39:11 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:38532 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfDLHjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:39:11 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190412073906epoutp047e5eaeec923900117cc401df82a2294b~Uqg2Z7KsR1890718907epoutp04B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:39:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190412073906epoutp047e5eaeec923900117cc401df82a2294b~Uqg2Z7KsR1890718907epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1555054746;
        bh=am8n0aAVqX+sjM9wSLVLSLKpvU4RXAHfFhdjMUH3J0k=;
        h=From:Subject:To:Cc:Date:In-Reply-To:References:From;
        b=NFukpqff9xIJwkxzG/xLk8SrpjxykpMnuYt0oBBS0zkaizMODV9APLG/dtY+3RSBN
         WdGU0NTZV6e6bxrkFDTKxa7/xm3cteU4JzNHYhGM9tQGPSGH+fgcpMvfzQ3UE/Jaif
         LqYDzN91iV3D7Gm7UstYD0WE/t+TGsvsv+kxQ/ug=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190412073903epcas1p461b3b539721c01fb1fc920c4dc187b53~Uqgzogc6j2670226702epcas1p4L;
        Fri, 12 Apr 2019 07:39:03 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.AA.04257.79040BC5; Fri, 12 Apr 2019 16:39:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190412073903epcas1p1ae08ecf3f735baa95e5a70007a75bade~UqgzGDrUl2294422944epcas1p1P;
        Fri, 12 Apr 2019 07:39:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190412073903epsmtrp24d5f009fdc558e72550b83739d9a594f~UqgzEVQqw2086920869epsmtrp21;
        Fri, 12 Apr 2019 07:39:03 +0000 (GMT)
X-AuditID: b6c32a38-5cbff700000010a1-eb-5cb04097df25
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.FC.03662.79040BC5; Fri, 12 Apr 2019 16:39:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190412073902epsmtip1f2785ae634f66f57d94b402169b469b7~UqgyzdHTC0473304733epsmtip1W;
        Fri, 12 Apr 2019 07:39:02 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH RFC 3/9] PM / devfreq: Add cpu based scaling support to
 passive_governor
To:     Sibi Sankar <sibis@codeaurora.org>, robh+dt@kernel.org,
        andy.gross@linaro.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, david.brown@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, linux-pm@vger.kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        dianders@chromium.org, Saravana Kannan <skannan@codeaurora.org>
Organization: Samsung Electronics
Message-ID: <6e639c37-c231-f0b5-a280-9a69f2211ccc@samsung.com>
Date:   Fri, 12 Apr 2019 16:39:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328152822.532-4-sibis@codeaurora.org>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbVRjOub339naxetZ9HTFqdxeWgNJRSvFsFiQOzXXyg8RNjKJ4pTel
        oV/pbbcVY8LYJowIY87Z2MnAVD6GS/h0IlAZDIcEOlcqHyqKmfuxzApmSIczGba9W+Tf8z7v
        875PnnPyMjLVMXkSY7a5BKeNt7D0BvLi5RRNmje3syj98sDTeG1chyeGFknc8U+QwH801QLc
        OHqVwsGWYRofX/AS2BvopnGwMiLH//rr5Tjc/ymNl2tHAW6eDRH45yNtNI6sxmYnJ6Yo3PJD
        D4WPB0bl+N5MF4lnPlui8KXQKRp3rXC5W7kL5y4A7mxFiOTCdbUE191+gubmZwZprne6iuTq
        etsBNzb3FcEtdz9RoHi9zFAq8EbBqRZsJXaj2WbKZl9+pXhvsT4rXZum3Y2fYdU23ipks3n5
        BWkvmi2xjKz6IG9xx6gCXhTZXTkGp93tEtSldtGVzQoOo8Wx26EReavotpk0JXbrHm16eoY+
        Jny7rHT43izp8DWAw5HgLVABIuU1QMEgmIm84TGiBmxgVLAPoCuV12VScRugqu+PUlIRBahm
        rkn2YGRg7Q4tNQIAhe7WAalYAqj181/lcRUNU9HQzTk6jjfBt9C51khi7+a4qHHgLog3ZHCW
        QNE+XRw/Arej6dXfE7wS5qCbq/NkHJMwGbW3LiTwFvgaWrjSSUmajWj8kxsxnmEUEKNj3xVJ
        K7ehn240EhJ+Eh398mzCF8EjDPqz8hItRchDwy2NQMKb0K2xXrmEk9DyYuC+5l10fnyUloar
        AeodukZJDR0aaj5NxI1lMAV19O+SzB5GiysfUHEaQSWqfl8lqXeg8G+/EBJ+FPmrTtxfz6Hp
        O36qHmz3rUvjWxfBty6C73+zJkC2g62CQ7SaBFHryFz/390gcQGpuA8MXs0fAZAB7EPKNkNH
        kYriD4oe6whAjIzdrNxPxiilkfeUC057sdNtEcQRoI899ilZ0pYSe+yebK5irT5Dp9PhTG2W
        Xqtltyk7cvcWqaCJdwllguAQnA/mCEaRVAEes5wxsB9H6cdzrjlyNgaqXtJNEObn/JkV1RrP
        O38NTqecbMtaTg6/pzDKD/X3TH2zVn/9I9r8aoYOrnxROPn85J7TDao8zcnmv73PJkNTVnkX
        nC+MXvSMd0aD+PaPhzwNZ9KWDn/9ofoF92KhIXxAfEP0e5+ayu/Z9+a3syU7Q30sKZby2lSZ
        U+T/A/kYh6QXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7bCSnO50hw0xBq2XmC3+nzS2OL3/HYvF
        +p9nmSxeL+hltJh/5ByrxdllB9ksWu9PZ7KYvncTm8XZpjfsFr8XT2C3uLxrDpvF594jjBZL
        r19ksrjduILN4s0PoN4zpy+xWiy7spnVonXvEXaLf9c2slhcW/ie1eLAxYlsFhu/ejiIeayZ
        t4bRY3bDRRaPy329TB6bVnWyedy5tofNY8vVdhaPvi2rGD2O39jO5PF5k1wAZxSXTUpqTmZZ
        apG+XQJXxsF/11kKZs1lrHhz9hVjA+Obqi5GTg4JAROJ3f+/s3UxcnEICexmlPgw8wYzREJS
        YtrFo0A2B5AtLHH4cDFIWEjgLaPEzsl1IDabgJbE/hc32EBsYYE4iXnL34C1igi8Z5RY+lAC
        ZCazwFUmia7/3YwQC3YySnxtfAfWwS+gKHH1x2NGEJtXwE7ixY87LCA2i4CqxKrl98FsUYEI
        iTPvV7BA1AhKnJz5hAXkIE4BC4mWEzEgYWYBdYk/8y4xQ9jiEreezGeCsOUlmrfOZp7AKDwL
        SfcsJC2zkLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcCLQ0trBeOJE
        /CFGAQ5GJR7eFTbrY4RYE8uKK3MPMUpwMCuJ8IawAIV4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        yucfixQSSE8sSc1OTS1ILYLJMnFwSjUwLnM+6xa6R/lisrGa7sv3Oq/2/de9XsD/4vWcTXox
        /cdTb+xtj+ted9hzmrVB5foJdwXXWrL9jlmg33PRUP30nZ98i93Tf63UWfHo44373y+Inz8d
        uPtBdkLovkMtmps5v2ZMcNw5ad2EFqkuN243q9UH4479fPRcreFkppis62PJtVX3Dn7YGabE
        UpyRaKjFXFScCAB12L3eAAMAAA==
X-CMS-MailID: 20190412073903epcas1p1ae08ecf3f735baa95e5a70007a75bade
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190328152906epcas1p15eb7c52740986df90a44ce265bef7d7c
References: <20190328152822.532-1-sibis@codeaurora.org>
        <CGME20190328152906epcas1p15eb7c52740986df90a44ce265bef7d7c@epcas1p1.samsung.com>
        <20190328152822.532-4-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I agree this approach absolutely.
Just I add some comments. Please check it.

On 19. 3. 29. 오전 12:28, Sibi Sankar wrote:
> From: Saravana Kannan <skannan@codeaurora.org>
> 
> Many CPU architectures have caches that can scale independent of the
> CPUs. Frequency scaling of the caches is necessary to make sure the cache
> is not a performance bottleneck that leads to poor performance and
> power. The same idea applies for RAM/DDR.
> 
> To achieve this, this patch add support for cpu based scaling to the
> passive governor. This is accomplished by taking the current frequency
> of each CPU frequency domain and then adjusts the frequency of the cache
> (or any devfreq device) based on the frequency of the CPUs. It listens
> to CPU frequency transition notifiers to keep itself up to date on the
> current CPU frequency.
> 
> To decide the frequency of the device, the governor does one of the
> following:
> * Constructs a CPU frequency to device frequency mapping table from
>   required-opps property of the devfreq device's opp_table
> 
> * Scales the device frequency in proportion to the CPU frequency. So, if
>   the CPUs are running at their max frequency, the device runs at its
>   max frequency. If the CPUs are running at their min frequency, the
>   device runs at its min frequency. It is interpolated for frequencies
>   in between.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> [Sibi: Integrated cpu-freqmap governor into passive_governor]
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/devfreq/Kconfig            |   4 +
>  drivers/devfreq/governor_passive.c | 276 ++++++++++++++++++++++++++++-
>  include/linux/devfreq.h            |  43 ++++-
>  3 files changed, 315 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 6a172d338f6d..9a45f464a56b 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -72,6 +72,10 @@ config DEVFREQ_GOV_PASSIVE
>  	  device. This governor does not change the frequency by itself
>  	  through sysfs entries. The passive governor recommends that
>  	  devfreq device uses the OPP table to get the frequency/voltage.
> +	  Alternatively the governor can also be chosen to scale based on
> +	  the online CPUs current frequency. A CPU frequency to device
> +	  frequency mapping table(s) is auto-populated by the governor
> +	  for this purpose.
>  
>  comment "DEVFREQ Drivers"
>  
> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> index 3bc29acbd54e..2506682b233b 100644
> --- a/drivers/devfreq/governor_passive.c
> +++ b/drivers/devfreq/governor_passive.c
> @@ -11,10 +11,63 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/cpumask.h>
>  #include <linux/device.h>
>  #include <linux/devfreq.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
>  #include "governor.h"
>  
> +static unsigned int xlate_cpufreq_to_devfreq(struct devfreq_passive_data *data,
> +					     unsigned int cpu)
> +{
> +	unsigned int cpu_min, cpu_max;
> +	struct devfreq *devfreq = (struct devfreq *)data->this;
> +	unsigned int dev_min, dev_max, cpu_percent, cpu_freq = 0, freq = 0;
> +	unsigned long *freq_table = devfreq->profile->freq_table;
> +	struct device *dev = devfreq->dev.parent;
> +	struct devfreq_map *map;
> +	int opp_cnt, i;
> +
> +	if (!data->state[cpu] || data->state[cpu]->first_cpu != cpu) {
> +		freq = 0;
> +		goto out;

goto out -> return 0;

> +	}
> +
> +	/* Use Interpolation if map is not available */
> +	cpu_freq = data->state[cpu]->freq;
> +	if (!data->map) {
> +		cpu_min = data->state[cpu]->min_freq;
> +		cpu_max = data->state[cpu]->max_freq;
> +		if (freq_table) {
> +			dev_min = freq_table[0];
> +			dev_max = freq_table[devfreq->profile->max_state - 1];

Actually, it is not always true. The devfreq recommend the ascending order for
'freq_table'. But, it is not mandatory. Also, some devfreq device uses the
decending order for 'freq_table'. So, a patch[1] was considering the order
when getting the minimum/maximum frequency from freq_table. 

If you want to get the minimum/maximum frequency, you have to consider the order
of 'freq_table' as the patch[1].

[1] df5cf4a36178 ("PM / devfreq: Fix handling of min/max_freq == 0")

             /* Get minimum frequency according to sorting order */
+               if (freq_table[0] < freq_table[df->profile->max_state - 1])
+                       value = freq_table[0];
+               else
+                       value = freq_table[df->profile->max_state - 1];


> +		} else {
> +			if (devfreq->max_freq <= devfreq->min_freq)
> +				return 0;
> +			dev_min = devfreq->min_freq;
> +			dev_max = devfreq->max_freq;
> +		}
> +
> +		cpu_percent = ((cpu_freq - cpu_min) * 100) / cpu_max - cpu_min;
> +		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
> +		goto out;

You don't need to jump 'out'. Instead, you better to use the 'else' statement
for if data->map is not NULL. I think that almost case when using this patch
will be available of data->map. In order to skip the likely 'false' statement,
I recommend the following sequence.

	if (data->map) {
		map = data->map[cpu];
		...
	} else {
		/* Use Interpolation if map is not available */
	}


> +	}
> +
> +	map = data->map[cpu];
> +	opp_cnt = dev_pm_opp_get_opp_count(dev);
> +	for (i = 0; i < opp_cnt; i++) {
> +		freq = max(freq, map[i].dev_hz);
> +		if (map[i].cpu_khz >= cpu_freq)
> +			break;
> +	}
> +out:
> +	dev_dbg(dev, "CPU%u: %d -> dev: %u\n", cpu, cpu_freq, freq);

IMO, I think it is not necessary. If you want to print log, you better to print
it on device driver instead of governor.

> +	return freq;
> +}
> +
>  static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  					unsigned long *freq)
>  {
> @@ -23,6 +76,7 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  	struct devfreq *parent_devfreq = (struct devfreq *)p_data->parent;
>  	unsigned long child_freq = ULONG_MAX;
>  	struct dev_pm_opp *opp;
> +	unsigned int cpu, tgt_freq = 0;

tgt means 'target'? If right, just use target_freq intead of 'tgt_freq'
for the readability.

>  	int i, count, ret = 0;
>  
>  	/*
> @@ -35,6 +89,14 @@ static int devfreq_passive_get_target_freq(struct devfreq *devfreq,
>  		goto out;
>  	}
>  
> +	if (p_data->cpufreq_type) {
> +		for_each_possible_cpu(cpu)
> +			tgt_freq = max(tgt_freq,
> +				       xlate_cpufreq_to_devfreq(p_data, cpu));
> +		*freq = tgt_freq;

You better to change from 'tgt_freq' to 'target_freq' for the readability.

> +		goto out;
> +	}

I think that 'goto out' using is not proper for supporting two case.
Instead, you better to split out as following according to the type
of parent device (devfreq device or cpufreq device).

	switch (p_data->parent_type) {
	case DEVFREQ_PARENT_DEV:
		ret = get_target_freq_with_devfreq() 
		break;
	case CPUFREQ_PARENT_DEV:
		ret = get_target_freq_with_cpufreq()
		break;
	default:
		dev_err(...)
		ret = -EINVAL;
		goto out;
	}
		
	if (ret < 0) {
		/* exception handling for 'ret' value */
	}

> +
>  	/*
>  	 * If the parent and passive devfreq device uses the OPP table,
>  	 * get the next frequency by using the OPP table.
> @@ -149,6 +211,200 @@ static int devfreq_passive_notifier_call(struct notifier_block *nb,
>  	return NOTIFY_DONE;
>  }
>  
> +static int cpufreq_passive_notifier_call(struct notifier_block *nb,
> +					 unsigned long event, void *ptr)
> +{
> +	struct devfreq_passive_data *data =
> +			container_of(nb, struct devfreq_passive_data, nb);
> +	struct devfreq *devfreq = (struct devfreq *)data->this;
> +	struct cpufreq_freqs *freq = ptr;
> +	struct devfreq_cpu_state *state;

nitpick. how about using 'cpu_state' instead of 'state'?
in order to get the meaning from just variable name.

> +	int ret = 0;
> +
> +	if (event != CPUFREQ_POSTCHANGE)
> +		goto out;

just 'return' is simple instead of 'goto out' because this case  
don't need to treat the any restoring code. And also, you have
to check whether freq is NULL or not as following:

	if (event != CPUFREQ_POSTCHANGE || !freq || data->state[freq->cpu])
		return ret;
	state = data->state[freq->cpu];

> +
> +	state = data->state[freq->cpu];
> +	if (!state)
> +		goto out;
> +
> +	if (state->freq != freq->new) {
> +		state->freq = freq->new;

You have to update the frequency after update_devfreq() is completed without error.

> +		mutex_lock(&devfreq->lock);
> +		ret = update_devfreq(devfreq);
> +		mutex_unlock(&devfreq->lock);
> +		if (ret)
> +			dev_err(&devfreq->dev, "Frequency update failed.\n");

Almost devfreq error used the following format: "Couldn't ..." .
If there is no any specific reason to change the format for error log,
	"Couldnt update the frequency.\n" 

> +	}> +out:
> +	return ret;

Also, we can reduce the unneeded indentation as following:

	if (state->freq == freq->new)
		return ret;
	
	mutex_lock(&devfreq->lock);
	ret = update_devfreq(devfreq);
	mutex_unlock(&devfreq->lock);
	if (ret) {
		dev_err(&devfreq->dev, "Couldnt update the frequency.\n");
		return ret;
	}
	state->freq = freq->new;

	return 0;

> +}
> +
> +static int cpufreq_passive_register(struct devfreq_passive_data **p_data)
> +{
> +	unsigned int cpu;
> +	struct devfreq_map **cpu_map;
> +	struct devfreq_map *map, *per_cpu_map;
> +	struct devfreq_passive_data *data = *p_data;
> +	struct devfreq *devfreq = (struct devfreq *)data->this;
> +	int i, count = 0, opp_cnt = 0, ret = 0, iter_val = 0;
> +	struct device_node *np, *opp_table_np, *cpu_np;
> +	struct opp_table *opp_table, *cpu_opp_tbl;
> +	struct device *dev = devfreq->dev.parent;
> +	struct devfreq_cpu_state *state;
> +	struct dev_pm_opp *opp, *cpu_opp;
> +	struct cpufreq_policy *policy;
> +	struct device *cpu_dev;
> +	u64 cpu_khz, dev_hz;
> +
> +	get_online_cpus();
> +	data->nb.notifier_call = cpufreq_passive_notifier_call;
> +	ret = cpufreq_register_notifier(&data->nb,
> +					CPUFREQ_TRANSITION_NOTIFIER);
> +	if (ret)
> +		return ret;
> +
> +	/* Populate devfreq_cpu_state */
> +	for_each_online_cpu(cpu) {
> +		if (data->state[cpu])
> +			continue;
> +
> +		policy = cpufreq_cpu_get(cpu);
> +		if (policy) {
> +			state = kzalloc(sizeof(*state), GFP_KERNEL);
> +			if (!state)
> +				return -ENOMEM;
> +
> +			state->first_cpu = cpumask_first(policy->related_cpus);
> +			state->freq = policy->cur;
> +			state->min_freq = policy->cpuinfo.min_freq;
> +			state->max_freq = policy->cpuinfo.max_freq;
> +			data->state[cpu] = state;
> +			cpufreq_cpu_put(policy);
> +		} else {
> +			return -EPROBE_DEFER;
> +		}
> +	}
> +
> +	opp_table_np = dev_pm_opp_of_get_opp_desc_node(dev);
> +	if (!opp_table_np)
> +		goto out;
> +
> +	opp_cnt = dev_pm_opp_get_opp_count(dev);
> +	if (opp_cnt <= 0)
> +		goto put_opp_table;
> +
> +	/* Allocate memory for devfreq_map*/
> +	cpu_map = kcalloc(num_possible_cpus(), sizeof(*cpu_map), GFP_KERNEL);
> +	if (!cpu_map)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu) {
> +		per_cpu_map = kcalloc(opp_cnt, sizeof(*per_cpu_map),
> +				      GFP_KERNEL);
> +		if (!per_cpu_map)
> +			return -ENOMEM;
> +		cpu_map[cpu] = per_cpu_map;
> +	}
> +	data->map = cpu_map;
> +
> +	/* Populate devfreq_map */
> +	opp_table = dev_pm_opp_get_opp_table(dev);
> +	if (!opp_table)
> +		return -ENOMEM;
> +
> +	for_each_available_child_of_node(opp_table_np, np) {
> +		opp = dev_pm_opp_find_opp_of_np(opp_table, np);
> +		if (IS_ERR(opp))
> +			continue;
> +
> +		dev_hz = dev_pm_opp_get_freq(opp);
> +		dev_pm_opp_put(opp);
> +
> +		count = of_count_phandle_with_args(np, "required-opps", NULL);
> +		for (i = 0; i < count; i++) {
> +			for_each_possible_cpu(cpu) {
> +				cpu_dev = get_cpu_device(cpu);
> +				if (!cpu_dev) {
> +					dev_err(dev, "CPU get device failed.\n");
> +					continue;
> +				}
> +
> +				cpu_np = of_parse_required_opp(np, i);
> +				if (!cpu_np) {
> +					dev_err(dev, "Parsing required opp failed.\n");
> +					continue;
> +				}
> +
> +				/* Get cpu opp-table */
> +				cpu_opp_tbl = dev_pm_opp_get_opp_table(cpu_dev);
> +				if (!cpu_opp_tbl) {
> +					dev_err(dev, "CPU opp table get failed.\n");
> +					goto put_cpu_node;
> +				}
> +
> +				/* Match the cpu opp node from required-opp with
> +				 * the cpu-opp table */
> +				cpu_opp = dev_pm_opp_find_opp_of_np(cpu_opp_tbl,
> +								    cpu_np);
> +				if (!cpu_opp) {
> +					dev_dbg(dev, "CPU opp get failed.\n");
> +					goto put_cpu_opp_table;
> +				}
> +
> +				cpu_khz = dev_pm_opp_get_freq(cpu_opp);
> +				if (cpu_opp && cpu_khz) {
> +					/* Update freq-map if not already set */
> +					map = cpu_map[cpu];
> +					map[iter_val].cpu_khz = cpu_khz / 1000;
> +					map[iter_val].dev_hz = dev_hz;
> +				}
> +				dev_pm_opp_put(cpu_opp);
> +put_cpu_opp_table:
> +				dev_pm_opp_put_opp_table(cpu_opp_tbl);
> +put_cpu_node:
> +				of_node_put(cpu_np);
> +			}
> +		}
> +		iter_val++;
> +	}
> +	dev_pm_opp_put_opp_table(opp_table);
> +put_opp_table:
> +	of_node_put(opp_table_np);
> +out:
> +	put_online_cpus();
> +
> +	/* Update devfreq */
> +	mutex_lock(&devfreq->lock);
> +	ret = update_devfreq(devfreq);
> +	mutex_unlock(&devfreq->lock);
> +	if (ret)
> +		dev_err(dev, "Frequency update failed.\n");
> +
> +	return ret;
> +}
> +
> +static int cpufreq_passive_unregister(struct devfreq_passive_data **p_data)
> +{
> +	int cpu;
> +	struct devfreq_passive_data *data = *p_data;
> +
> +	cpufreq_unregister_notifier(&data->nb,
> +				    CPUFREQ_TRANSITION_NOTIFIER);
> +
> +	for_each_possible_cpu(cpu) {
> +		kfree(data->state[cpu]);
> +		kfree(data->map[cpu]);
> +		data->state[cpu] = NULL;
> +		data->map[cpu] = NULL;
> +	}
> +
> +	kfree(data->map);
> +	data->map = NULL;
> +
> +	return 0;
> +}
> +
>  static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  				unsigned int event, void *data)
>  {
> @@ -159,7 +415,7 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  	struct notifier_block *nb = &p_data->nb;
>  	int ret = 0;
>  
> -	if (!parent)
> +	if (!parent && !p_data->cpufreq_type)
>  		return -EPROBE_DEFER;

It makes the fault for the existing devfreq devices with passive governor.
Please remove '!p_data->cpufreq_type' condition.

>  
>  	switch (event) {
> @@ -167,13 +423,21 @@ static int devfreq_passive_event_handler(struct devfreq *devfreq,
>  		if (!p_data->this)
>  			p_data->this = devfreq;
>  
> -		nb->notifier_call = devfreq_passive_notifier_call;
> -		ret = devm_devfreq_register_notifier(dev, parent, nb,
> -					DEVFREQ_TRANSITION_NOTIFIER);
> +		if (p_data->cpufreq_type) {
> +			ret = cpufreq_passive_register(&p_data);
> +		} else {
> +			nb->notifier_call = devfreq_passive_notifier_call;
> +			ret = devm_devfreq_register_notifier(dev, parent, nb,
> +						DEVFREQ_TRANSITION_NOTIFIER);
> +		}

I suggested the my opinion aboyt 'cpufreq_type' variable below.
You can separte it for more clready with using parent device type.

		if (p_data->parent_type == DEVFREQ_PARENT_DEV)
			...
		else if (p_data->parent_type == CPUFREQ_PARENT_DEV)
			...
		else 
			// error handling

>  		break;
>  	case DEVFREQ_GOV_STOP:
> -		devm_devfreq_unregister_notifier(dev, parent, nb,
> -					DEVFREQ_TRANSITION_NOTIFIER);
> +		if (p_data->cpufreq_type) {
> +			cpufreq_passive_unregister(&p_data);
> +		} else {
> +			devm_devfreq_unregister_notifier(dev, parent, nb,
> +						DEVFREQ_TRANSITION_NOTIFIER);
> +		}

ditto.

>  		break;
>  	default:
>  		break;
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index fbffa74bfc1b..e8235fbe49e6 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -265,6 +265,38 @@ struct devfreq_simple_ondemand_data {
>  #endif
>  
>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_PASSIVE)
> +/**
> + * struct devfreq_cpu_state - holds the per-cpu state
> + * @freq:	holds the current frequency of the cpu.
> + * @min_freq:	holds the min frequency of the cpu.
> + * @max_freq:	holds the max frequency of the cpu.
> + * @first_cpu:	holds the cpumask of the first cpu of a policy.
> + *
> + * This structure stores the required cpu_state of a cpu.
> + * This is auto-populated by the governor.
> + */
> +struct devfreq_cpu_state {
> +	unsigned int freq;
> +	unsigned int min_freq;
> +	unsigned int max_freq;
> +	unsigned int first_cpu;
> +};
> +
> +/**
> + * struct devfreq_map - holds mapping from cpu frequency
> + * to devfreq frequency
> + * @cpu_khz:	holds the cpu frequency in Khz
> + * @dev_hz:	holds the devfreq device frequency in Hz
> + *
> + * This structure stores the lookup table between cpu
> + * and the devfreq device. This is auto-populated by the
> + * governor.
> + */
> +struct devfreq_map {

How about changing the structure name as following or others?
- devfreq_freq_map or devfreq_cpufreq_map or others.

Because this structure name guessing the meaning of mapping
between devfreq frequency and cpufreq frequency.

> +	unsigned int cpu_khz;
> +	unsigned int dev_hz;
> +};
> +
>  /**
>   * struct devfreq_passive_data - void *data fed to struct devfreq
>   *	and devfreq_add_device
> @@ -278,11 +310,13 @@ struct devfreq_simple_ondemand_data {
>   *			the next frequency, should use this callback.
>   * @this:	the devfreq instance of own device.
>   * @nb:		the notifier block for DEVFREQ_TRANSITION_NOTIFIER list
> + * @state:	holds the state min/max/current frequency of all online cpu's

As I commented above, how about using 'cpu_state' instead of 'state'?
in order to get the meaning from just variable name.

nitpick. Also,  I think that you can skip 'holds' from the description
of 'state' variable.


> + * @map:	holds the maps between cpu frequency and device frequency

How about using 'cpufreq_map' instead of 'map' for the readability?
IMHO, Because this variable is only used when parent device is cpu. 
I think that if you add to specify the meaningful prefix about cpu to variable name,
it is easy to catch the meaning of variable.
- map -> cpufreq_map.

nitpick. Also,  I think that you can skip 'holds' from the description
of 'map' variable.

>   *
>   * The devfreq_passive_data have to set the devfreq instance of parent
>   * device with governors except for the passive governor. But, don't need to
> - * initialize the 'this' and 'nb' field because the devfreq core will handle
> - * them.
> + * initialize the 'this', 'nb', 'state' and 'map' field because the devfreq

If you agree my opinion above, 
- state -> cpu_state.
- map -> cpufreq_map

> + * core will handle them.
>   */
>  struct devfreq_passive_data {
>  	/* Should set the devfreq instance of parent device */
> @@ -291,9 +325,14 @@ struct devfreq_passive_data {
>  	/* Optional callback to decide the next frequency of passvice device */
>  	int (*get_target_freq)(struct devfreq *this, unsigned long *freq);
>  
> +	/* Should be set if the devfreq device wants to be scaled with cpu*/
> +	u8 cpufreq_type;

The devfreq devices with passive governor have always parent
either devfreq device or cpufreq device. So, you better to specify
the parent type as following: I think that it is more clear to check
the type of parent device.

	enum devfreq_parent_dev_type {
		DEVFREQ_PARENT_DEV,
		CPUFREQ_PARENT_DEV,
	};

	enum devfreq_parent_dev_type parent_type;

> +
>  	/* For passive governor's internal use. Don't need to set them */
>  	struct devfreq *this;
>  	struct notifier_block nb;
> +	struct devfreq_cpu_state *state[NR_CPUS];
> +	struct devfreq_map **map;

ditto.

>  };
>  #endif
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
