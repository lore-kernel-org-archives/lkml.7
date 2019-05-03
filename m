Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1203C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 21:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A137C2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 21:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EY8Wl3cm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfECVL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 17:11:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38544 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfECVL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 17:11:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id k16so9454066wrn.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4wsRkkLLbJZmIvxgiyssDJeBv4EOkgSlgxV1aVYUQGg=;
        b=EY8Wl3cmPCIHcC7tSICoTy7i1jTYAsNZQ00IkCRNDeUDGRCi84sp1wmDsp+y7Nm1bF
         q4ilEa6paeqrhCFs9yybJoSO7xWZ34eMqyYuhj3Ykin+hdTWPWy2MDSAKRwltLMQjt9j
         MVElim7mXFADIzxluh4ujiwpTSCJ9ou5596ZOvhCuwdCcM6Or2RDxspWMi9BBHQEUgkW
         axYhFUeLIDcIRKthpNNvP370b6GiNYhCSIQDG13l4GnQL2o0q2dyRMRe7YdOBpxWHdwk
         /1sNK56kKQl4uuAmVrgNO0wZY7SMMJ1H0XcRGhGlC3P1iDmCIgyY+mQyfOa5qJcDD++U
         cbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4wsRkkLLbJZmIvxgiyssDJeBv4EOkgSlgxV1aVYUQGg=;
        b=KNWFp9yUKH97W8Fp/kf5gzy63gJl8bbruEUp6LMXirgrsREbA9gnZFSoZ23LyA632s
         lbSQ97sAqSBSzq35EwXSUoByNmtNNs7VReaqkrnywNCiuoUFOD2niacQ64dCqtSYFSgr
         NastNfhohOlCCutOKtjGMZgnHtRezn2f4yuPRPEnnxh/Y4+AzMwJgVgLea4fNGInI2W3
         Y4RpVPlVC24XC7ckhzknxNuti+i7L8lZO5JI1b/vWioZ7oE9MZTP+m6IZk9hJ9efCWsn
         PAcvltwAay6uFMavrZXQMzFddmr4anEpqLpfgYpmupHFooYSPDbDxOB5r5rZILintv3V
         wwJw==
X-Gm-Message-State: APjAAAWRYskKC982nADQ0NXU7X9887LZ65rhOXkMlQiYL5RBIE2zrK8K
        0mhDqSjhbKMBBERezfLt2vycQQ==
X-Google-Smtp-Source: APXvYqwX2tUgC0PUey+3pTZ86MgfL66WCy5mH6BpAhqy+lsTFiJoUry4MdTl6Om/dIUsOZniRNwwgg==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr2004398wrt.212.1556917886220;
        Fri, 03 May 2019 14:11:26 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id u11sm5269768wmu.15.2019.05.03.14.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 14:11:25 -0700 (PDT)
Subject: Re: [PATCH] thermal: cpu_cooling: Actually trace CPU load in
 thermal_power_cpu_get_power
To:     Matthias Kaehlcke <mka@chromium.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
References: <20190502183238.182058-1-mka@chromium.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <85246ec5-2dd7-f7fb-535f-0268af399480@linaro.org>
Date:   Fri, 3 May 2019 23:11:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502183238.182058-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2019 20:32, Matthias Kaehlcke wrote:
> The CPU load values passed to the thermal_power_cpu_get_power
> tracepoint are zero for all CPUs, unless, unless the
> thermal_power_cpu_limit tracepoint is enabled too:
> 
>   irq/41-rockchip-98    [000] ....   290.972410: thermal_power_cpu_get_power:
>   cpus=0000000f freq=1800000 load={{0x0,0x0,0x0,0x0}} dynamic_power=4815
> 
> vs
> 
>   irq/41-rockchip-96    [000] ....    95.773585: thermal_power_cpu_get_power:
>   cpus=0000000f freq=1800000 load={{0x56,0x64,0x64,0x5e}} dynamic_power=4959
>   irq/41-rockchip-96    [000] ....    95.773596: thermal_power_cpu_limit:
>   cpus=0000000f freq=408000 cdev_state=10 power=416
> 
> There seems to be no good reason for omitting the CPU load information
> depending on another tracepoint. My guess is that the intention was to
> check whether thermal_power_cpu_get_power is (still) enabled, however
> 'load_cpu != NULL' already indicates that it was at least enabled when
> cpufreq_get_requested_power() was entered, there seems little gain
> from omitting the assignment if the tracepoint was just disabled, so
> just remove the check.
> 
> Fixes: 6828a4711f99 ("thermal: add trace events to the power allocator governor")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Yes, load_cpu is needed in any case for both traces. The change makes sense.

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

