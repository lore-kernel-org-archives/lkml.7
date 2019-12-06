Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5027C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905CA20707
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9rhlogH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfLFOQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:16:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39532 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfLFOP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:15:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id y11so7914886wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 06:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t5llNTRUbyRpihnmRqZnRoqYD+4XI93t6fyxrzfPIvk=;
        b=W9rhlogH9A+SQ9Z7RRHOfvR0jHQr+XubRvBNbZnelmkbiHmvaVoAq0Isl5VKP836Lg
         RSo4otnt0T0d/gZql8yEsfQY1/6le/I5/OPUJEcFva+6tKwCDyyfZKr41L7ldVdhIupB
         3IPcmNL8rBES8QTw8mFPWeViQkBMV1RERDu6giLuwwSRFAuZ+PeJXekJ6l5nk8juLReD
         zR88uuBjdyy74Gswb8f+0SQrS+4aYrEK5tK0angsroxuk7z25BwCn0hM6L9lxa/ZxbdH
         Rjzsjm9QrDKybjAhq+OU7sy5yyOMoTyHh7XphAIIGgomuKZQZMXT6aoDvcBH0nXRJNh0
         wIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=t5llNTRUbyRpihnmRqZnRoqYD+4XI93t6fyxrzfPIvk=;
        b=DC7mNJ0vWlI7KngIS3Lx/TJnLaH8b1OhBybY66B4qWt36zZQ+AWjefpflb/mw6DZC5
         qLVUCqqGq8DfBgEso70pG6+/NxK1ue3JKkrQVz+5hSMD95vgAMknW+WHlIPKeyo/W3q9
         ppyK5IHuBkYG9zcQ77FcxjVWxZcUKtwOaALXdgC6DklHhHKW6oGZPgrcksAcL0R1OYBn
         jwRXvFqHC+B8lgWhTBre8EwbHxmN1+2UOHNE+JbPpPOqNOecz62R37MiLBNYAARrCtqx
         eZ6GPWlRAUy19fVtUJtszqRlyDS1mQut1n8AcAZk6MzL9CAmpsDcgQrcEIXlha5Nocwb
         KQqg==
X-Gm-Message-State: APjAAAUN4SN4OtW/EjlyS9LYGa/GinwQid7kfOYZ4ZhHTW1IW9ToMdvt
        wgvuc1WdBZr5JyXhioVbZfXJGuyhzAM=
X-Google-Smtp-Source: APXvYqy3Ks3x6f/3AG9PEkTmOEy6rizrQt+gdL/t2ewEYJVrbPtTANP67BPvpeqGqtX8YupziUZYdg==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr15798347wrl.190.1575641756231;
        Fri, 06 Dec 2019 06:15:56 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:143f:da10:4344:50a6? ([2a01:e34:ed2f:f020:143f:da10:4344:50a6])
        by smtp.googlemail.com with ESMTPSA id t81sm3745672wmg.6.2019.12.06.06.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 06:15:55 -0800 (PST)
Subject: Re: [PATCH V4 4/4] thermal/drivers/cpu_cooling: Rename to
 cpufreq_cooling
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, edubezval@gmail.com,
        rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
References: <20191204153930.9128-4-daniel.lezcano@linaro.org>
 <20191206113315.18954-1-martin.kepplinger@puri.sm>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e6cbe4fb-8b04-cff6-f2af-6c5829d9deb1@linaro.org>
Date:   Fri, 6 Dec 2019 15:15:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191206113315.18954-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2019 12:33, Martin Kepplinger wrote:
> I tested this on the librem5-devkit and see the
> cooling devices in sysfs. I configure ARM_PSCI_CPUIDLE, not ARM_CPUIDLE and
> add the patch below in register the cooling device there. "psci_idle"
> is listed as the cpuidle_driver.
> 
> That's what I'm running, in case you want to see it all:
> https://source.puri.sm/martin.kepplinger/linux-next/commits/next-20191205/librem5_cpuidle_mainline_atf
> 
> so I add a trip temperature description like this:
> https://source.puri.sm/martin.kepplinger/linux-next/commit/361f49f93ae2c477fd012790831cabd0ed976660
> 
> When I let the SoC heat up, cpuidle cooling won't kick it. In sysfs:
> 
> catting the relevant files in /sys/class/thermal after heating up,
> if that makes sense:
> 
> 87000
> 85000
> 85000
> thermal-cpufreq-0
> 1
> thermal-idle-0
> 0
> thermal-idle-1                                                                  
> 0                                                                               
> thermal-idle-2
> 0
> thermal-idle-3
> 0
> 
> with ARM_CPUIDLE instead of ARM_PSCI_CPUIDLE (and registering the cooling dev
> during cpuidle-arm.c init) I won't have a cpuidle driver and thus no cpu-sleep
> state at all.
> 
> Can you see where the problem here lies?

Yes, I removed the registration via the DT.

Can you try the following:

diff --git a/drivers/cpuidle/dt_idle_states.c
b/drivers/cpuidle/dt_idle_states.c
index d06d21a9525d..01367ddec49a 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/cpu_cooling.h>
 #include <linux/of.h>
 #include <linux/of_device.h>

@@ -205,6 +206,9 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 			err = -EINVAL;
 			break;
 		}
+
+		cpuidle_of_cooling_register(state_node, drv);
+
 		of_node_put(state_node);
 	}

That's a hack for the moment.


> ---
>  drivers/cpuidle/cpuidle-psci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
> index f3c1a2396f98..de6e7f444a66 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -8,6 +8,7 @@
>  
>  #define pr_fmt(fmt) "CPUidle PSCI: " fmt
>  
> +#include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -195,6 +196,8 @@ static int __init psci_idle_init_cpu(int cpu)
>  	if (ret)
>  		goto out_kfree_drv;
>  
> +	cpuidle_cooling_register(drv);
> +
>  	return 0;
>  
>  out_kfree_drv:
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

