Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFB7C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9170B2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nfgMBpn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388112AbfDYVmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:42:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34328 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbfDYVmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:42:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id r186so2529508wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iy3NdgbIw8q0NrLQWP14D1k9PBg9PXIezpgxK2Kpvt8=;
        b=nfgMBpn0VLzv2y/39VvisZXvwl0g1ff0uEVrQFqtXEi+IjoMh0ZHIIbnOUsw5fsd/W
         FKm7EGq74Ds+UYYPiIaWus6jzqCbkrCKQezGRCuxfUrwkhnQnHPa3hYGuJu1SHMUr92y
         eCqShVUazsp1eADb8LFYI9KDlPbp1O+bU2NAhXH3gosVTIqdi5ExCp1RM2CFopWlGzhh
         2G5AKktg6e3NfrwnB89I2GG7Y4FT/ujBmIq4ERjCgXg1ZX/gPtn31Rwr8O9yHyUNLHQ4
         5ElWbbGsOnBurVQ5t4vqkNjpqrWeJuEKOEwVsuU9eHjt+AbJEPfQ0J03wmmeVqSH0t4c
         /14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iy3NdgbIw8q0NrLQWP14D1k9PBg9PXIezpgxK2Kpvt8=;
        b=uVxJPV03VcgFoeLJLstN+QxXb9OJ1sxL54R6V4p5wtEbwcWyhYE5MrLMvdsYWLscWK
         KRe5t6HfagPNbvT7doh8VWDIJ8Of812A+i7mXcKbzi3oToiEKSzk2ZiF+aSRR0JqpAfy
         FT7Anrg/mQUM9SjQa3mHLbf+8TSAnagxMhAcDO7GaMH0PL301BhBvQPYco5lhGi72wN2
         LFfBvo/t78melhoWidSgT1pe+uI1b+apWnerJB23zCXgWC4lUNzVJVmhmw9BirfVgNnL
         9WQfUY7K9+m55f0ZurNqfLzFgMiYt9MViYIvlL2DulbQOMEekImBDvC5Tggwp20Rpn07
         9QaQ==
X-Gm-Message-State: APjAAAVeKxPo6M4Ii8jdz+nR/MSTKkDwDstWCQOI+9o8Qd0+ex5OOZKO
        hW4AKJ7Zw2LGmQNgmEUcXJLgkg==
X-Google-Smtp-Source: APXvYqzqP3+gjk2J3h2F6CDZLSJq96Xih8o53HRzjnXMD79MSmH/RZ8anTbJATFtknEflg3sGCfVEQ==
X-Received: by 2002:a1c:7005:: with SMTP id l5mr1521684wmc.149.1556228553779;
        Thu, 25 Apr 2019 14:42:33 -0700 (PDT)
Received: from [192.168.1.2] (200.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.200])
        by smtp.gmail.com with ESMTPSA id r196sm22224312wmf.22.2019.04.25.14.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 14:42:32 -0700 (PDT)
Subject: Re: [PATCH v2 05/14] clk: qcom: apcs-msm8916: get parent clock names
 from DT
To:     Stephen Boyd <sboyd@kernel.org>, andy.gross@linaro.org,
        arnd@arndb.de, bjorn.andersson@linaro.org, david.brown@linaro.org,
        enric.balletbo@collabora.com, heiko@sntech.de,
        horms+renesas@verge.net.au, jagan@amarulasolutions.com,
        jassisinghbrar@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, olof@lixom.net, robh+dt@kernel.org,
        sibis@codeaurora.org, will.deacon@arm.com
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548700381-22376-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <155085910216.77512.12604271825136479370@swboyd.mtv.corp.google.com>
 <31e17283-c374-f16e-df95-09aaf1854435@linaro.org>
 <155622774551.15276.4140891469702307355@swboyd.mtv.corp.google.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <5d17334c-ed2f-5112-dba6-72a050bfd1b2@linaro.org>
Date:   Thu, 25 Apr 2019 23:42:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <155622774551.15276.4140891469702307355@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/19 23:29, Stephen Boyd wrote:
> Quoting Jorge Ramirez (2019-04-22 04:44:50)
>> On 2/22/19 19:11, Stephen Boyd wrote:
>>> Quoting Jorge Ramirez-Ortiz (2019-01-28 10:32:52)
>>>> @@ -61,6 +65,25 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
>>>>         if (!a53cc)
>>>>                 return -ENOMEM;
>>>>  
>>>> +       /* check if the parent names are present in the device tree */
>>>
>>> This looks odd.
>>>
>>>> +       ret = devm_clk_bulk_get(parent, ARRAY_SIZE(pclks), pclks);
>>>> +       if (ret == -EPROBE_DEFER)
>>>> +               return ret;
>>>
>>> Why can't we use of_clk_parent_fill() if we know this is always a DT
>>> platform?  The parent clks may not be registered at the time of probe?
>>
>> yes, and AFAICS the important thing at this point is that the clock is
>> registered hence the handling of defer.
>>
>> I could use of_clk_parent_fill and then - if needed - call
>> devm_clk_bulk_get but I am not sure of the gains of doing it (wouldnt
>> this just make the code more confusing?)
> 
> Yeah of_clk_parent_fill() isn't the best approach. But it at least keeps
> this driver from using clk consumer APIs?

ok will do that then.

> 
>>
>>
>>> Maybe this series should wait for the parent registration stuff I'm
>>> working on so that this can be made simpler.
>>
>> the need for the clock name is not intrinsic to this driver (the driver
>> itself doesnt use these names) but it just feeds these to the framework.
>>
>> I was looking into your parent registration code and I am not sure how
>> can I use it in this particular driver other than simply removing the
>> names and hoping that things are handled properly at the lower
>> levels.... could you clarify please?
>>
> 
> I think so. I've forgotten the context of this patch, but the general
> idea would be to specify the parents with clock-names or DT index in the
> DT node for the clks registered here and not use of_clk_parent_fill() or
> do any sort of devm_clk_bulk_get() calls. Then the framework will take
> care of finding the parents for the clks and hooking things up properly
> for the parent-child relationship.
> 
> 

ok will try that. thanks for confirming!

