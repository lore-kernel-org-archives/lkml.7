Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD829C2D0C6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70651206A4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 14:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikTPpXF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfL1O23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 09:28:29 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35099 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfL1O22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 09:28:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so21982675lja.2;
        Sat, 28 Dec 2019 06:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iAuK2SBAgN48OmwXuS6DbfYeXQRIySmXgJ5nwEn6J+0=;
        b=ikTPpXF27m2ICXJim+rCrrRHWHjsrqOyiZ5r0f9CyoOwRsVnnmB82THtJadZClWkGG
         4kKt5rbX3X8doChqSkTclrGZtBm3mhfxxifOYHL4JTTlz9/4LMwy7r/zeifzotHVBxcb
         V5c3yYwAIlYSU34W70FFp6PIGKFWPeore8OIgKxVlxSu0D7I0Yc1qBvt53+we1zdrcZe
         TBRSGheIXAGofownsYtROn14ZSXV15Vp3RvwanWQ6FAYGiaexfDLHH6nAUiDQKYXbU5s
         VTJ2Ytz0zUPixs+yOQgjnzOxCbFNS8NUYSAudM6IU5gbmMRwNVF7F+vzbJKTBzZ4t5rn
         WvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iAuK2SBAgN48OmwXuS6DbfYeXQRIySmXgJ5nwEn6J+0=;
        b=LC7qui1GaD+2cKLnidwIYboKgo3jUNIFocBkmfjjOeyMO7+bbU67BJIiOPh4t+0nD3
         ZHDZSQTxlXnZENWYFEioOMJ63TF99q8JOiPHybFFrvZwTwZxj21YOecIRJcC8PTUjRFo
         AYTvekks99j7LrU83PbE6+rBuahEWmi2A9Qhl0QFoRk7peS3q1NGf9Jpx1m2iGcmEABo
         JPJWnuNmEclm+DLfugFpIqEy3Ns11pPy881Hw+DPZwg+/axAF3jb1hLzZ2RBI0MMOpE4
         EgDOKB8FbhlkoIs8fqwGgb4vZf4aGM9cYQThqFl4P4Z1GfZWqQA9n6Ux1mej4dvJvZcr
         UIUQ==
X-Gm-Message-State: APjAAAUT5qAswZw7cA/pUae9MTBXIQ/s3EeJuFnt0wOpDNJk6l9trmEl
        xHkKrKIkeUNZ+lPfu/seD4m7Ysi9
X-Google-Smtp-Source: APXvYqwGqwZTitCaAQUNh8JS2PZCo6OVi4od8nkDUpw1fzGBpuBimCLDHKiFLVX9Py5c7NXixEpGEA==
X-Received: by 2002:a2e:9e55:: with SMTP id g21mr10456969ljk.245.1577543306222;
        Sat, 28 Dec 2019 06:28:26 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id w6sm16026296lfq.95.2019.12.28.06.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Dec 2019 06:28:25 -0800 (PST)
Subject: Re: [PATCH v5 12/19] ASoC: tegra: Add initial parent configuration
 for audio mclk
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-13-git-send-email-skomatineni@nvidia.com>
 <a6567ff1-7bc2-3ca5-1200-92a63eb44ddb@gmail.com>
 <1b79ab92-c163-3857-dd38-df35c509b823@gmail.com>
 <4fd01e04-8240-8562-467d-324f7adbdbdf@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0eaf3942-047b-2412-7843-315842dcf5d1@gmail.com>
Date:   Sat, 28 Dec 2019 17:28:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <4fd01e04-8240-8562-467d-324f7adbdbdf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

28.12.2019 00:25, Sowjanya Komatineni пишет:
> 
> On 12/22/19 1:18 PM, Dmitry Osipenko wrote:
>> 23.12.2019 00:14, Dmitry Osipenko пишет:
>>> 21.12.2019 01:26, Sowjanya Komatineni пишет:
>>>> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
>>>> through Tegra210 and currently Tegra clock driver does initial parent
>>>> configuration for audio mclk "clk_out_1" and enables them by default.
>>>>
>>>> With the move of Tera PMC clocks from clock driver to Tegra PMC
>>>> driver, initial parent configuration for audio clocks are through
>>>> the device tree using assigned-clock-parents property.
>>>>
>>>> Default clock parents can be specified in device tree using
>>>> assigned-clocks and assigned-clock-parents and there is no need
>>>> to have clock driver do parent configuration and enable audio related
>>>> clocks.
>>>>
>>>> This patch has implementation for initial parent configuration in
>>>> audio driver when default parent configuration is not specified in the
>>>> device tree using assigned-clock properties and enables audio clocks
>>>> during the clock rate change.
>>>>
>>>> This patch configures PLLA_OUT0 as parent to extern1 and extern1
>>>> as parent to clk_out_1 and uses clk_out_1 as cdev1 clock to allow
>>>> mclk control from this driver.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>>>   sound/soc/tegra/tegra_asoc_utils.c | 71
>>>> ++++++++++++++++++++++----------------
>>>>   1 file changed, 41 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>>> index 38535962029c..fc3135c08f43 100644
>>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>>> @@ -7,6 +7,7 @@
>>>>    */
>>>>     #include <linux/clk.h>
>>>> +#include <linux/clk-provider.h>
>>> This is illegal, it is not a clock provider.
>>>
> __clk_is_enabled API is used in this patch to disable clock only when
> its enabled.

As I wrote in the other reply, this is a wrong solution since it works
around the problem and doesn't solve the root of the problem. Please fix
it properly in the next version.

> __clk_is_enabled API is from clk-provider.h

That's exactly the reason why it is in clk-provider.h, you absolutely
cannot use __clk_is_enabled() outside of clk providers because:

1. __clk_is_enabled doesn't use any lockings, so you need to be very
careful when using it

2. every function that is prefixed with __ is usually meant for internal
use only

3. tegra_asoc_utils is simply not a clk provider, such cases when you
need to do hacks in order to achieve something are a good indication
about that you're likely doing something wrong
