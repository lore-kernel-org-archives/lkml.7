Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0B2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033C32084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9HyP1Dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfFQPBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:01:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34871 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfFQPBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:01:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so10358376wrv.2;
        Mon, 17 Jun 2019 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vIJkWrJfyxWYUDsQW4fhx8mVPinUeTZ/tiAX2FB2DeE=;
        b=I9HyP1DlWFTX4NSLL+MG/STQvwPLGlv5Zd3gJlQDO/w6i84n4kFmDeApMTePkSwcC4
         RVfB20DmZF5rvG1jeyLm6AKS8nyb51GwrH6GGLW/IsQMmkr9wfo+X4wPgl3Is87ceF9H
         cw468Wv69s1KtiDhBIcuazZ/PnrlF7h428U6JWnTZ0QqeTRKn37R3+7RydrGI4Qn0EL4
         GqDdrl7JL9a5tD8eDju/nER3uXSS5olHbqR+JdRDL1gIUtuoAt7+KgEgFz31xP77lA94
         jtKNXC6HYDkDmIQCdFW8a1APMQuw/zh4co033U0zkiXETZrXIbo6+LhdZ9funrtwJEtw
         fqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vIJkWrJfyxWYUDsQW4fhx8mVPinUeTZ/tiAX2FB2DeE=;
        b=Hog53pfzXcRcAuMxa4RSkm/GGRixSoPixQe0Fd1Hu0WE1sTatVo12RJbwGcVE0DTpk
         gQyiqP9y3YiP9scZt1PZv0zgue+74FNBKsqVqM5MQ28yCjI8/6Das4N5QGlacmGgaRFQ
         23epH6YNB/13JNrFOiBIpbf6pUyQfhdFrmvBo7jBvXLlNUudc0nxAN5Cz+Mq4qOuvz6x
         hshVthCiszk0R7DhMkW4CLSiPuFX0NfT9z7bASvKzPrh2QpGBc7XBaMLREpeKMl/Wlom
         Zughgz27yB8RShaz/EiCdltIZ0bFORif8BvoWbf3i/PvBs2NqbrrPKsXzYRKHATBUqUO
         D4vg==
X-Gm-Message-State: APjAAAXmEy2V9C8jJjjvGptTcpbrCcDkmio793FUzFb4vKjjS8u4TO4b
        Pc0opYF27ntzxaVXL6vIKCMtVvgy
X-Google-Smtp-Source: APXvYqzI85jGF00H08XkQKAeJwEAv+JQOpUckJBA+V+jvzDanX4zwiUo/yB2zEEhL5tjqp7HG9a+Bw==
X-Received: by 2002:adf:df10:: with SMTP id y16mr19123329wrl.302.1560783693281;
        Mon, 17 Jun 2019 08:01:33 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id 72sm4623261wrk.22.2019.06.17.08.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:01:32 -0700 (PDT)
Subject: Re: [PATCH v4 05/10] memory: tegra20-emc: Replace clk_get_sys with
 devm_clk_get
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190616233551.6838-1-digetx@gmail.com>
 <20190616233551.6838-6-digetx@gmail.com> <20190617094602.GC508@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <204a38c2-90ff-3a44-d320-bdc031679ec3@gmail.com>
Date:   Mon, 17 Jun 2019 18:01:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617094602.GC508@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2019 12:46, Thierry Reding пишет:
> On Mon, Jun 17, 2019 at 02:35:46AM +0300, Dmitry Osipenko wrote:
>> There is no problem for drivers to request pll_m and pll_p clocks for
>> the device, hence there is no need to use clk_get_sys() and it could be
>> replaced with devm_clk_get() for consistency.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/memory/tegra/tegra20-emc.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
>> index 43aef3614b65..527aa4b90e95 100644
>> --- a/drivers/memory/tegra/tegra20-emc.c
>> +++ b/drivers/memory/tegra/tegra20-emc.c
>> @@ -527,33 +527,29 @@ static int tegra_emc_probe(struct platform_device *pdev)
>>  		goto unset_cb;
>>  	}
>>  
>> -	emc->pll_m = clk_get_sys(NULL, "pll_m");
>> +	emc->pll_m = devm_clk_get(&pdev->dev, "pll_m");
> 
> Interesting... I didn't know that clk_get() had a fallback path to
> return clk_get_sys() if the named clock wasn't found in DT. That's
> nice.
> 
> Looks good to me.

Yes, I didn't know either until recently. Thanks!
