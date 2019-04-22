Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F204BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C346C20693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4yJLfC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfDVLo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 07:44:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35021 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfDVLoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 07:44:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so14199285wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 04:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3YIh3hHvBZ7BaXs+3YAwERcSnfSNsChZK/sbht0VfxE=;
        b=T4yJLfC+kupU+qX7A3pI0xLYFwwzOVUlLOy1JRy/Kz0QbEM3erk4k4Hnr5dY0ONEMb
         hCKzyMx8XcTNLO8jVVegbvRn16ZoH82lGgBOw7pkuWycPlY2Opc7NY0NvWeCsk156bfD
         J+0Qt3E4CPZLIF72HYuGI9xvf4/VCBYOK/aaUocEuVX6fucqMGEHdoKKEYHx8ePRoIlb
         MvYM9ED0p4vfCc7S7TvIU+fgSyyvEQj+T2il00NkwmEj0EDrHlD4wo65oWHBkc5fYO6l
         Frfl9llzsUhv/nbSyZuLJIaISgv5pZYBQ9KLVaRzZqyxHLtYKxRqCQYt2MQwJKCc7MBA
         +w2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3YIh3hHvBZ7BaXs+3YAwERcSnfSNsChZK/sbht0VfxE=;
        b=UVuGdlfLUu2lpCMcyVkI+ay3Ll9+vnTnSJmDsJM0oZN/6PNcX+bXYe7+mFo3KqDHZ9
         tGaQH7TSBtS8Sd/lzeVWxDL6F4H7Bn0vjiGwDxbyg+f8moopPEPOqS/DYIvQWRmIx4xe
         I7Nh7Lv7Yc4YKCioCUHUCK4fMpAASYCBQpS6wIOt/jfAnhZsyBVmixEWyBzPb9ZghcBG
         Mi483wnzbBGBuGF4Hueh0NQjy4dcrzVAfRSDMZtGAzOi+xpHtHSdrbFhFBl595+YBkPW
         Is5glj3wYRzYhj2Ic0uWGMOXMrP9X3m6awmUdiMZplXfJW7JarNaMJ3/+TskyE3R+g38
         AKqg==
X-Gm-Message-State: APjAAAU2Mv7zpNHkxG3Dog291+8LFg0IDFYKWX5lDzwcimaBLY1C0s/+
        sqgo6Jw0uea6Ej+vAsq6hRWy8w==
X-Google-Smtp-Source: APXvYqxyn2cRm1w2onk1AW+e9B4V01SSiNFGLHUlwiQTvPsQP2i4/ep+XIFIcV5pM9vTbWyQANsxxA==
X-Received: by 2002:a1c:cf83:: with SMTP id f125mr11168607wmg.96.1555933493626;
        Mon, 22 Apr 2019 04:44:53 -0700 (PDT)
Received: from [192.168.1.2] (200.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.200])
        by smtp.gmail.com with ESMTPSA id h8sm10913684wrx.45.2019.04.22.04.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 04:44:52 -0700 (PDT)
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
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <31e17283-c374-f16e-df95-09aaf1854435@linaro.org>
Date:   Mon, 22 Apr 2019 13:44:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <155085910216.77512.12604271825136479370@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 19:11, Stephen Boyd wrote:
> Quoting Jorge Ramirez-Ortiz (2019-01-28 10:32:52)
>> @@ -61,6 +65,25 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
>>         if (!a53cc)
>>                 return -ENOMEM;
>>  
>> +       /* check if the parent names are present in the device tree */
> 
> This looks odd.
> 
>> +       ret = devm_clk_bulk_get(parent, ARRAY_SIZE(pclks), pclks);
>> +       if (ret == -EPROBE_DEFER)
>> +               return ret;
> 
> Why can't we use of_clk_parent_fill() if we know this is always a DT
> platform?  The parent clks may not be registered at the time of probe?

yes, and AFAICS the important thing at this point is that the clock is
registered hence the handling of defer.

I could use of_clk_parent_fill and then - if needed - call
devm_clk_bulk_get but I am not sure of the gains of doing it (wouldnt
this just make the code more confusing?)


> Maybe this series should wait for the parent registration stuff I'm
> working on so that this can be made simpler.

the need for the clock name is not intrinsic to this driver (the driver
itself doesnt use these names) but it just feeds these to the framework.

I was looking into your parent registration code and I am not sure how
can I use it in this particular driver other than simply removing the
names and hoping that things are handled properly at the lower
levels.... could you clarify please?


> 
>> +
>> +       if (!ret) {
>> +               gpll0_a53cc[0] = __clk_get_name(pclks[0].clk);
>> +               gpll0_a53cc[1] = __clk_get_name(pclks[1].clk);
>> +               a53cc->pclk = pclks[1].clk;
>> +       } else {
>> +               /* support old binding where only pll was explicitily defined */
>> +               a53cc->pclk = devm_clk_get(parent, NULL);
>> +               if (IS_ERR(a53cc->pclk)) {
>> +                       ret = PTR_ERR(a53cc->pclk);
>> +                       dev_err(dev, "failed to get clk: %d\n", ret);
>> +                       return ret;
>> +               }
>> +       }
>> +
>>         init.name = "a53mux";
>>         init.parent_names = gpll0_a53cc;
>>         init.num_parents = ARRAY_SIZE(gpll0_a53cc);
> 

