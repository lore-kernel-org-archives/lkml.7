Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A419CC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E48521774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axPapZiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfK1NK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:10:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42194 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK1NK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:10:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id e28so4273693ljo.9;
        Thu, 28 Nov 2019 05:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=moaWqxsCTNcr/KHQtrcCoszt/hAeOw9BWifx1uk8A5Q=;
        b=axPapZizquiOGFlRJBrXPULlzZp3tlQPQ+W+0ssp5CEgmUMlleysHaw7dxfJOxsXyG
         rG10jIDfUvkkLtkgp/3gvenvxAh8w6jxQB68PN89JsiEZWvZihr7Bu5XKX4z/uKqZeh9
         1cUtGzGdouhtkdzzPYL7pKp83JZQvZbg+vjm3ey86tIxlB9eLdqgIO/XKZ2qy8q3m6pe
         L+vleUmTtZ8MGm09lHp4DrODX04aJg8Or+UMNsImNFuuobkHoAo672Gsntsg2qRX7TbM
         KRBxzWl3VAkQdjCzCE8fKo/KKVi6mE/oYn+AOOgs55MJLaOY3vFwrHcrLAGfR/TO7vqc
         IHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=moaWqxsCTNcr/KHQtrcCoszt/hAeOw9BWifx1uk8A5Q=;
        b=fGmwk1xYtZjDECvMf+6qizSLMcVhr+iQwyPrIc/P4ErD/aNXpWShWdyct60SRtn7eS
         LCztfr4aOpXSp0y1pwo7CBMCulqIUDS6nBZhd5fuTFfrv5Bses505JLSVXG3eCBiYqv8
         TomxC0PWxXbeMl17Oap3sLNY+RP9BLyZDoFokSNYwm3PqgS3immydhj2gBdhIFVK57t5
         12ErZ9Z93QeGx5U1Ka/eFcJFwkW4QNiebmml9YVHOfzkDsp6DaP0JMtdoj0zXwKlpeZu
         Gw9r+LIBUlIb3/ZrOQ8xJo4ZNq+U6L+/StYqEK0AVFIpkVA6ChKukWzzU461eckgrV8P
         JXkw==
X-Gm-Message-State: APjAAAUveGM9UiHoRWEb6aHs+EEsktGj0XxFETRqV1pqiU6OjSN0dGTS
        /AkQyBl4Xa4acSErBVVBkzJSwnAf
X-Google-Smtp-Source: APXvYqwj8wYYiVvIaKk7aE7WjXr1yvvmuNWb7KDyFLO2q96zPD8Hep4DWS0HOeg5a60gzo7iKRaXFw==
X-Received: by 2002:a2e:7e0b:: with SMTP id z11mr34405718ljc.45.1574946654374;
        Thu, 28 Nov 2019 05:10:54 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id d24sm3229691lja.82.2019.11.28.05.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 05:10:53 -0800 (PST)
Subject: Re: [PATCH v2 00/11] Move PMC clocks into Tegra PMC driver
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        mperttunen@nvidia.com, sboyd@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, allison@lohutok.net, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, mturquette@baylibre.com,
        horms+renesas@verge.net.au, Jisheng.Zhang@synaptics.com,
        krzk@kernel.org, arnd@arndb.de, spujar@nvidia.com,
        josephl@nvidia.com, vidyas@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
 <79e7bd6a-f138-1e7d-6e0b-435adde3b3e5@gmail.com>
 <20191128122619.GB2300319@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <174fd19d-50de-b854-e5c6-65493efd1ea0@gmail.com>
Date:   Thu, 28 Nov 2019 16:10:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191128122619.GB2300319@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.11.2019 15:26, Thierry Reding пишет:
> On Wed, Nov 27, 2019 at 05:31:34PM +0300, Dmitry Osipenko wrote:
>> 27.11.2019 07:59, Sowjanya Komatineni пишет:
>>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls which
>>> are currently registered by Tegra clock driver using clk_regiser_mux and
>>> clk_register_gate which performs direct Tegra PMC register access.
>>>
>>> When Tegra PMC is in secure mode, any access from non-secure world will
>>> not go through.
>>>
>>> This patch series adds these Tegra PMC clocks and blink controls to Tegra
>>> PMC driver with PMC as clock provider and removed them from Tegra clock
>>> driver. This also adds PMC specific clock id's to use in device tree and
>>> removed clock ids of PMC clock from Tegra clock driver.
>>>
>>> This series also includes patch to update clock provider from tegra_car
>>> to pmc in the device tree tegra210-smaug.dts that uses clk_out_2 from PMC.
>>>
>>> [v2]:	Changes between v1 and v2 are
>>> 	- v2 includes patches for adding clk_out_1, clk_out_2, clk_out_3,
>>> 	  blink controls to Tegra PMC driver and removing clk-tegra-pmc.
>>> 	- feedback related to pmc clocks in Tegra PMC driver from v1
>>> 	- Removed patches for WB0 PLLM overrides and PLLE IDDQ PMC programming
>>> 	  by the clock driver using helper functions from Tegra PMC.
>>>
>>>  	  Note:
>>> 	  To use helper functions from PMC driver, PMC early init need to
>>> 	  happen prior to using helper functions and these helper functions are
>>> 	  for PLLM Override and PLLE IDDQ programming in PMC during PLLM/PLLE
>>> 	  clock registration which happen in clock_init prior to Tegra PMC
>>> 	  probe.
>>> 	  Moving PLLM/PLLE clocks registration to happen after Tegra PMC
>>> 	  impacts other clocks EMC, MC and corresponding tegra_emc_init and
>>> 	  tegra_mc_init.
>>> 	  This implementation of configuring PMC registers thru helper
>>> 	  functions in clock driver needs proper changes across PMC, Clock,
>>> 	  EMC and MC inits to have it work across all Tegra platforms.
>>>
>>> 	  Currently PLLM Override is not enabled in the bootloader so proper
>>> 	  patches for this fix will be taken care separately.
>>
>> Hello Sowjanya,
>>
>> Could you please clarify what do you mean by "PLLM Override not enabled
>> in bootloader"?
>>
>> There is T124 Nyan Big Chromebook which is supported in upstream kernel,
>> it has PLLM Override set by bootloader. I also have T30 Nexus 7 tablet
>> which has the PLLM Override set by bootloader as well. It's not clear to
>> me whether this patch series is supposed to break these devices. If the
>> breakage is the case here, then I'm afraid you can't postpone supporting
>> the PLLM Override and a full-featured implementation is needed.
> 
> For some more background on why we chose to take this shortcut for now:
> Sowjanya was looking at the full-featured implementation and that ended
> up being a can of worms. The problem is that there are various inter-
> dependencies between the PLLM override and the MC/EMC clocks.
> 
> Unfortunately we depend a lot on the explicit ordering of driver probe,
> especially during early boot, so this started to get very complicated,
> very quickly.
> 
> The bottom line was basically that we would need to move a whole bunch
> of clocks to register at a very late point in time and support deferred
> probe throughout in order to make it all work together nicely. Sowjanya
> had a crack at that, and while the system ended up booting, there were a
> number of errors from the MC and IOMMU drivers.
> 
> At the end, we decided to take a look at that separately because, as was
> mentioned earlier, the PLLM override is not used on platforms where the
> PMC is locked down, so the existing PLLM override code is going to
> continue to work fine on the platforms where it's currently used.
> 
> Thierry

Thank you and Sowjanya for the clarification.

[snip]
