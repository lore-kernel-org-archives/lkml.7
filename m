Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF873C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F91D20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gO12hy1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfC1UXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:23:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37047 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfC1UXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:23:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so24547296wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 13:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eZs7jwA94rECRgPg1/76+n5kwLCPqO5QUgxAih47yf0=;
        b=gO12hy1wefXS0lJ9EJixUVK62FPryBj5Pco3lETJHsIkpyDV+FGFbLHL9Yr4YJsMAW
         blxDrP8N2bHu6iQr2qGRT2qmAE+GyhtcsptdHngiaQs5bw/aIqFmCjSKeZP4T+QsHHTU
         l+jkHck7Hehwu9UWrs8cRHX7nuWaZe7WdYSpm1Y/0jpFx2brpppcKja4rPCfT1V9ZicV
         Ln0gdPdXqNA/6deTC3538WmWUUL51JH1huuj1/vF8qV7hcyJfmf+PEtN7e7zSuj+ckP+
         YCpH1EeJUq3SsYQKMOAdp9OkEOAnRbz/XrlrpqTetferU+PrkjVncRd35IsJTs2jIcWh
         kJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eZs7jwA94rECRgPg1/76+n5kwLCPqO5QUgxAih47yf0=;
        b=XZW5h84EHreAgHb8s5AEhuTXo8ckkea/hIUZFUjuWMSiOopFCaYgtfakcFnluUzEeI
         j5c+pKin1QUIair6nvTfqctQY/g6pdbFQkyzLURD/yeo+MgjO1wMc/aeAkXYBwbAIMti
         6QlEQxsPgvmZ62q80XP65xA1lRq8ZTSvK10l4DxlVvrHBHNvWPhAP1idLKcl6tiJNNy9
         zdHBEUd7r3nsxcyXrk2VupHh2H8u66oEQVPzI6XNWTRbu3pMajOvdpfRvJYT39lhXq51
         g5GOlgM5xHVYQMXKhBt1oQsnHtkXd8jSJmYEdW7gYctjgScXgX92uO0iEekohkBLXWMU
         7guw==
X-Gm-Message-State: APjAAAUsvdDJy3m00SnaULFPq6Q9m/Cn+tPdtHVcacA1Xqr4W2xF/jOf
        S7cWZp0Ih46CeYnKyg63z6OksQ==
X-Google-Smtp-Source: APXvYqwHB9rBcXXrrMq8DtEwOkU4Imc8SriRNTiGgSiGi6N3jhh8WL2tqsUOztFj7zJhZzv3N2Stzg==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr27802504wrr.275.1553804617607;
        Thu, 28 Mar 2019 13:23:37 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id t17sm64268wrr.26.2019.03.28.13.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 13:23:36 -0700 (PDT)
Subject: Re: [PATCH 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
To:     Quentin Perret <quentin.perret@arm.com>, edubezval@gmail.com,
        rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com
Cc:     dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-4-quentin.perret@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <30926b3d-0074-8c84-a081-d3dbc9258525@linaro.org>
Date:   Thu, 28 Mar 2019 21:23:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328101352.25657-4-quentin.perret@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2019 11:13, Quentin Perret wrote:
> The newly introduced Energy Model framework manages power cost tables in
> a generic way. Moreover, it supports a several types of models since the
> tables can come from DT or firmware (through SCMI) for example. On the
> other hand, the cpu_cooling subsystem manages its own power cost tables
> using only DT data.
> 
> In order to avoid the duplication of data in the kernel, and in order to
> enable IPA with EMs coming from more than just DT, remove the private
> tables from cpu_cooling.c and migrate it to using the centralized EM
> framework.
> 
> The case where the thermal subsystem is used without an Energy Model
> (cpufreq_cooling_ops) is handled by looking directly at CPUFreq's
> frequency table which is already a dependency for cpu_cooling.c anyway.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/thermal/cpu_cooling.c | 231 +++++++++++-----------------------
>  1 file changed, 75 insertions(+), 156 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index f7c1f49ec87f..a74ec8269b7b 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -31,6 +31,7 @@
>  #include <linux/slab.h>
>  #include <linux/cpu.h>
>  #include <linux/cpu_cooling.h>
> +#include <linux/energy_model.h>
>  
>  #include <trace/events/thermal.h>
>  
> @@ -48,19 +49,6 @@
>   *	...
>   */
>  
> -/**
> - * struct freq_table - frequency table along with power entries
> - * @frequency:	frequency in KHz
> - * @power:	power in mW
> - *
> - * This structure is built when the cooling device registers and helps
> - * in translating frequency to power and vice versa.
> - */
> -struct freq_table {
> -	u32 frequency;
> -	u32 power;
> -};
> -
>  /**
>   * struct time_in_idle - Idle time stats
>   * @time: previous reading of the absolute time that this cpu was idle
> @@ -82,7 +70,7 @@ struct time_in_idle {
>   *	frequency.
>   * @max_level: maximum cooling level. One less than total number of valid
>   *	cpufreq frequencies.
> - * @freq_table: Freq table in descending order of frequencies
> + * @em: Reference on the Energy Model of the device
>   * @cdev: thermal_cooling_device pointer to keep track of the
>   *	registered cooling device.
>   * @policy: cpufreq policy.
> @@ -98,7 +86,7 @@ struct cpufreq_cooling_device {
>  	unsigned int cpufreq_state;
>  	unsigned int clipped_freq;
>  	unsigned int max_level;
> -	struct freq_table *freq_table;	/* In descending order */
> +	struct em_perf_domain *em;

Why do you need to add this field? it will be accessible via policy->em, no?

>  	struct thermal_cooling_device *cdev;
>  	struct cpufreq_policy *policy;
>  	struct list_head node;
> @@ -121,14 +109,14 @@ static LIST_HEAD(cpufreq_cdev_list);
>  static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
[ ... ]

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

