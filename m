Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418ACC2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 23:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1072E2467A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 23:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2e3DVoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfLGXY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 18:24:58 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41031 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfLGXY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 18:24:58 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so11525956ljc.8;
        Sat, 07 Dec 2019 15:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UYYclqI+qbEWxgjHzSQw1mRE8Z+HNZO1kpO5Dr5T5Zo=;
        b=m2e3DVoJEoIDL+VUAjilEa45HADkdtPQ5yqtDXIeKD7IyMxe7/l2p2UTMdO/G5ZSMh
         JV36MAs5NUacLjejDjRHiL0axTSr/l8rtQHgIJuPKBq+XXvn/lUFY5RhMhWjemyBinTW
         Fj0+9DwxlchlD2NRJ9WShFXNHXwrm1QW+DbAIx0sBwT7H4QM/slfpRGTbL79Oa7+bnFC
         T/DkK5f9SCOVtQa4cm87GQ1blSqIogDXcGdoZtTh6c2eQzNKdG0Q/fiKwH4qsx1BaPpH
         3bbQlJ3G8WFeqPWU8uCcaksknWRyWBhapQjk/AfaQbxsfrbtluK4FDXqq8BOK9nYQKrZ
         aI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UYYclqI+qbEWxgjHzSQw1mRE8Z+HNZO1kpO5Dr5T5Zo=;
        b=ec4Em6JOUMXFYV8EyVZPQHFgZDMVhTaQcSrY60MHFHDp0+4+QoL+L6TqftdEoTM6o6
         Fc4IbjLlWcdVGz3I3P9jqgPHYXq5L11MJw+5x6Zv5p2gXmWL/Jw+YAdLNLQ1KadXmgG3
         OcoaByTUKJpoLX913bL8AwP0R9THQJcGqXU3gAUeIA3XlK038kh8xB+VV/NOckEp0M69
         d85zKHBQBZAjhEjPGGuFmaUsYXbTVjFD7Lopnkj4zi8LswZyik/s4ZXKdQD/23pua7Yc
         JhXxXvCceC3y5oqvfPkp9UYFo8WV3zOUIZShMxWz5wTOdBPXEoUJNIWs1XMV37GRM/WY
         6jzw==
X-Gm-Message-State: APjAAAUHLnzjcVTzVzkSabT5zsCpf4AXfsOx/vrXw5LXCF+hpH6EHV8v
        elt7qHJ++xu3vQSpyuRmRAI=
X-Google-Smtp-Source: APXvYqyhVxrvLXBCuvNVTxG/3XJJJA+cgc3K90h56oHZ1wvKmB/jS+aOEEXAQQRzF0rA1zwaXQqVmA==
X-Received: by 2002:a2e:9bd9:: with SMTP id w25mr10729689ljj.212.1575761095167;
        Sat, 07 Dec 2019 15:24:55 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id p26sm8604243lfh.64.2019.12.07.15.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 15:24:54 -0800 (PST)
Subject: Re: [PATCH v3 06/15] clk: tegra: Remove tegra_pmc_clk_init along with
 clk ids
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
 <1575600535-26877-7-git-send-email-skomatineni@nvidia.com>
 <3880aa15-c47a-5ab2-dd39-e8a47f6a3d6a@gmail.com>
 <e342a6e7-f213-53b4-1388-23cf61cf6fbb@gmail.com>
 <5938df22-2474-3950-fc33-3e19cbf3da9c@gmail.com>
 <c81ccd45-781e-0fce-4f20-65281b8c6119@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f8188f0d-ec7e-7d4a-f977-16273b594838@gmail.com>
Date:   Sun, 8 Dec 2019 02:24:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <c81ccd45-781e-0fce-4f20-65281b8c6119@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.12.2019 22:35, Sowjanya Komatineni пишет:
> 
> On 12/7/19 7:04 AM, Dmitry Osipenko wrote:
>> 07.12.2019 17:43, Dmitry Osipenko пишет:
>>> 07.12.2019 17:33, Dmitry Osipenko пишет:
>>>> 06.12.2019 05:48, Sowjanya Komatineni пишет:
>>>>> Current Tegra clock driver registers PMC clocks clk_out_1, clk_out_2,
>>>>> clk_out_3 and blink output in tegra_pmc_init() which does direct Tegra
>>>>> PMC access during clk_ops and these PMC register read and write access
>>>>> will not happen when PMC is in secure mode.
>>>>>
>>>>> Any direct PMC register access from non-secure world will not go
>>>>> through and all the PMC clocks and blink control are done in Tegra PMC
>>>>> driver with PMC as clock provider.
>>>>>
>>>>> This patch removes tegra_pmc_clk_init along with corresponding clk ids
>>>>> from Tegra clock driver.
>>>>>
>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>> ---
>>>> [snip]
>>>>
>>>>> @@ -1230,9 +1222,6 @@ static struct tegra_clk_init_table
>>>>> init_table[] __initdata = {
>>>>>       { TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 1 },
>>>>>       { TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 1 },
>>>>>       { TEGRA30_CLK_EXTERN1, TEGRA30_CLK_PLL_A_OUT0, 0, 1 },
>>>> Perhaps these clocks do not need to be always-enabled?
>>>>
>>>> [snip]
>>>>
>>> Also, EXTERN1 parent configuration should be moved to the audio
>>> driver/device-tree as well.
>> Ah, I missed that it's done in the patch #10.
> Yes its done in Patch#10
>>
>>> Maybe it even makes sense to move the whole configuration, including
>>> PLLA. I don't see why clk driver need to do something for the audio
>>> driver.
> 
> Current ASoC driver already takes care of PLLA rate and enables.
> 
> So PLLA init can be removed from clock driver too. I didn't went through
> complete audio driver to be confident to remove this.
> 
> But PLLA is needed for i2s clock also and currently I2S driver takes
> care of only I2S clock rate using PLLA as parent set by clock driver and
> clock driver enables PLLA earlier to have it ready by the time both I2S
> driver and ASoC driver .
I2S could use assigned-clocks, but probably it's not really necessary
and predefined configuration in the clk driver is good enough.

At least PLLA doesn't need to be always-enabled since audio drivers
enable it when necessary.
