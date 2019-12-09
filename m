Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F857C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4727A2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZPp2x0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfLIUGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:06:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45036 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIUGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:06:46 -0500
Received: by mail-lf1-f68.google.com with SMTP id v201so11710979lfa.11;
        Mon, 09 Dec 2019 12:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u/GIJzR3wCJLmedQ7wGRBS+zeddea2lYVEojwPiD6Yg=;
        b=oZPp2x0KYxbPwBtd9Bz9vftSNS82Y5FinyxDJCnDx2uNsfnPkXAhPTKTe3j4NpZ5Cs
         p+KWi1//D2a/TJnpwe1IwmXq2bCL3BtSOBGNOuWrixen25yxv/VrPaYzpSiDDazdKx8C
         hRvR8g73NRKSpNSRjkvDUYbmEmap789FiQBh2AhZFR7Ec+BkGxl/DOIroAUK6KU/p5up
         lHYK0ov6a5WB8dy1k59kJR0Dc7T2F60lRib16DTSmBGXL/u3p+JIFivbd7mcJDUe4i4p
         EgiIB9X4QPwJZUoDNjWyeq30+2Oz1n3+BGLsplQPOhkESvwZawjHzJJsiqjNL/saRKXl
         s9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u/GIJzR3wCJLmedQ7wGRBS+zeddea2lYVEojwPiD6Yg=;
        b=a5Tis+3c16C5vlTI23AES4M25AwRo9dbjOOqexF/cCuOKoeqt04482SJ+YQoSuV/sV
         wj7smbrgIx3Wy02pD0hDzv7zi161VX3MbS3weAMBJPd74Q/Ih2Y1exVaA3KJ6BFnCe1V
         rO/qw3vYY6hMggZHj6ruvGJg1wybwWJ3UON6rMsgGAldq8eUYJcQ2WAYD0i/sU0OdjSk
         vi+RClQbirekN9aQSw61eoXNMK37gThQgtglBBHpibkP5EIOuF9W+EKizAyX6MCFkWtV
         Ll4oWO+l+POqm042J9GlpJsmguOOVXAzKW44Bu2aNEwoC3RxG1cWPITZATRanaW5E+Ti
         Ku9Q==
X-Gm-Message-State: APjAAAXTtwzz1qwKeia5TzTYDsM220trWspPWJKKA4CQ6eXps8x5LQ29
        nOn5LE9vBZhmQbH4v0t3me0=
X-Google-Smtp-Source: APXvYqzr/+Nhv/yjlchThUWzU8Ials6Sj/mgzcKHAB5uF8w2Nk+cbzB9kVAwf3QSc6wMaPML/Ctokw==
X-Received: by 2002:a19:784:: with SMTP id 126mr10095957lfh.191.1575922003500;
        Mon, 09 Dec 2019 12:06:43 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id m11sm202649lfj.89.2019.12.09.12.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 12:06:42 -0800 (PST)
Subject: Re: [PATCH v3 08/15] ASoC: tegra: Add audio mclk control through
 clk_out_1 and extern1
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     allison@lohutok.net, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alexios.zavras@intel.com, alsa-devel@alsa-project.org
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-9-git-send-email-skomatineni@nvidia.com>
 <0ce2e83b-800c-da1e-7a3c-3cf1427cfe20@gmail.com>
 <2eeceabe-b5f0-6f9e-ff8c-4ac6167b7cc3@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5d26e32c-a346-4d42-9872-840964512144@gmail.com>
Date:   Mon, 9 Dec 2019 23:06:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <2eeceabe-b5f0-6f9e-ff8c-4ac6167b7cc3@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.12.2019 22:20, Sowjanya Komatineni пишет:
> 
> On 12/7/19 6:58 AM, Dmitry Osipenko wrote:
>> 06.12.2019 05:48, Sowjanya Komatineni пишет:
>>> Current ASoC driver uses extern1 as cdev1 clock from Tegra30 onwards
>>> through device tree.
>>>
>>> Actual audio mclk is clk_out_1 and to use PLLA for mclk rate control,
>>> need to clk_out_1_mux parent to extern1 and extern1 parent to PLLA_OUT0.
>>>
>>> Currently Tegra clock driver init sets the parents and enables both
>>> clk_out_1 and extern1 clocks. But these clocks parent and enables should
>>> be controlled by ASoC driver.
>>>
>>> Clock parents can be specified in device tree using assigned-clocks
>>> and assigned-clock-parents.
>>>
>>> To enable audio mclk, both clk_out_1 and extern1 clocks need to be
>>> enabled.
>>>
>>> This patch configures parents for clk_out_1 and extern1 clocks if device
>>> tree does not specify clock parents inorder to support old device tree
>>> and controls mclk using both clk_out_1 and extern1 clocks.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>>   sound/soc/tegra/tegra_asoc_utils.c | 66
>>> ++++++++++++++++++++++++++++++++++++++
>>>   sound/soc/tegra/tegra_asoc_utils.h |  1 +
>>>   2 files changed, 67 insertions(+)
>>>
>>> diff --git a/sound/soc/tegra/tegra_asoc_utils.c
>>> b/sound/soc/tegra/tegra_asoc_utils.c
>>> index 536a578e9512..8e3a3740df7c 100644
>>> --- a/sound/soc/tegra/tegra_asoc_utils.c
>>> +++ b/sound/soc/tegra/tegra_asoc_utils.c
>>> @@ -60,6 +60,7 @@ int tegra_asoc_utils_set_rate(struct
>>> tegra_asoc_utils_data *data, int srate,
>>>       data->set_mclk = 0;
>>>         clk_disable_unprepare(data->clk_cdev1);
>>> +    clk_disable_unprepare(data->clk_extern1);
>>>       clk_disable_unprepare(data->clk_pll_a_out0);
>>>       clk_disable_unprepare(data->clk_pll_a);
>>>   @@ -89,6 +90,14 @@ int tegra_asoc_utils_set_rate(struct
>>> tegra_asoc_utils_data *data, int srate,
>>>           return err;
>>>       }
>>>   +    if (!IS_ERR_OR_NULL(data->clk_extern1)) {
>>> +        err = clk_prepare_enable(data->clk_extern1);
>>> +        if (err) {
>>> +            dev_err(data->dev, "Can't enable extern1: %d\n", err);
>>> +            return err;
>>> +        }
>>> +    }
>>> +
>>>       err = clk_prepare_enable(data->clk_cdev1);
>>>       if (err) {
>>>           dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>>> @@ -109,6 +118,7 @@ int tegra_asoc_utils_set_ac97_rate(struct
>>> tegra_asoc_utils_data *data)
>>>       int err;
>>>         clk_disable_unprepare(data->clk_cdev1);
>>> +    clk_disable_unprepare(data->clk_extern1);
>>>       clk_disable_unprepare(data->clk_pll_a_out0);
>>>       clk_disable_unprepare(data->clk_pll_a);
>>>   @@ -142,6 +152,14 @@ int tegra_asoc_utils_set_ac97_rate(struct
>>> tegra_asoc_utils_data *data)
>>>           return err;
>>>       }
>>>   +    if (!IS_ERR_OR_NULL(data->clk_extern1)) {
>>> +        err = clk_prepare_enable(data->clk_extern1);
>>> +        if (err) {
>>> +            dev_err(data->dev, "Can't enable extern1: %d\n", err);
>>> +            return err;
>>> +        }
>>> +    }
>> Why this is needed given that clk_extern1 is either a child of MCLK or
>> MCLK itself (on T20)? The child clocks are enabled when the parent is
>> enabled.
> 
> For T30 and later, clk_extern1 is one of the source for clk_out_1_mux.
> clk_extern1 is in CAR and it has its own gate and mux.
> 
> As audio mclk related clocks (clk_out_1, clk_out_1_mux, and extern1) are
> moved into ASoC driver from clock driver
> 
> need to enable extern1 gate as well along with clk_out1 for T30 through
> T210.
> 
> Just FYI, extern1 enable here happens only when data->clk_extern1 is
> available which is for T30 onwards.

clk_out_1 is the parent of extern1, thus extern1 is enabled by the clk
core whenever clk_out_1 is enabled because data->clk_cdev1=clk_out_1. An
I missing something?

[snip]
