Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA92FC2BBE2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 14:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9839D2467B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 14:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEXsRsUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfLGOnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 09:43:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42052 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfLGOnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 09:43:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id e28so10743452ljo.9;
        Sat, 07 Dec 2019 06:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M4178m5wqKcjur6WZ9VbgwAy1j68KdshPPjyIN/6tPs=;
        b=JEXsRsUjV2g10sr0Ks0k3FUw9U5Tv97+5vrfYHJZOIcNSgd6M+N5vTtgaCHX3c8/8a
         +oNhdRKUkWMzF/WSTpiuN4ecPb7ElQcmbs2mNsXjcnxARF1D/yvdqxmsTYRUbn6iq9EX
         QWPn4LtwsAJt2utSabQVTf8KbxeHmW61Q93SPmk9gzIFH8IyCqeH3royTvXmlDHUqMiX
         JXzhDznChEN8g9jgpuJyTjWuW3g57aSUeC/E3MrGn7Z+ZoDte3AzDVtEH8M0HlO9Mp4i
         AtmyKD5OcVxL7iXM/75BCdU8CI9/SZEArBOGMMhwzOagt8LV3x/rei58gUrWU05odAD8
         y0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M4178m5wqKcjur6WZ9VbgwAy1j68KdshPPjyIN/6tPs=;
        b=hcJh6kbCTLgxHjrLlas+Cl3dLyXDEbha6PDQ8KSl4Na6/sJBgHqNz9PnJEN/vOqEL3
         E5lYVf/RJl8ILwv1c8q4IrsCaeQWQ5idE31TikA+S+XZjjGU58yt5ylxEkW/7M8mONUt
         OGVvOurwB4bhlyD+2qXlVCZDkgCFUoe5CdpqeLfKU6ws7IyqWLpCAtQl+SzLRcJsP6/Y
         Ia7d+ZtBn+fAjJnjc270P7DFcssSNmm5GQgi8aTY5C8E7YLDM//ydsH00xcQ58mYJQo4
         0Z1MCNzG8+ehKcTrEJknVF9A0YX2Ed0Kg2d/j+RSzYKuhTKp0W5WiXi85MNXOkelFSDd
         NRhA==
X-Gm-Message-State: APjAAAWdKv9Wk6U0h2yxF/dyeALCB7+TJHqBNRzsSMwoMKrmVfyVXTb4
        flej5HQo5r6e46N88buQGW4=
X-Google-Smtp-Source: APXvYqyqrq36nLJ9lM39hAYXIi5EgLPNDsEijYW1ZwyxcXInMqQSgLCoGiMV6ulTtSVLZFqJpT8q6Q==
X-Received: by 2002:a2e:8e72:: with SMTP id t18mr2688107ljk.132.1575729830747;
        Sat, 07 Dec 2019 06:43:50 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id w2sm8155909ljo.61.2019.12.07.06.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 06:43:50 -0800 (PST)
Subject: Re: [PATCH v3 06/15] clk: tegra: Remove tegra_pmc_clk_init along with
 clk ids
From:   Dmitry Osipenko <digetx@gmail.com>
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
Message-ID: <e342a6e7-f213-53b4-1388-23cf61cf6fbb@gmail.com>
Date:   Sat, 7 Dec 2019 17:43:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <3880aa15-c47a-5ab2-dd39-e8a47f6a3d6a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.12.2019 17:33, Dmitry Osipenko пишет:
> 06.12.2019 05:48, Sowjanya Komatineni пишет:
>> Current Tegra clock driver registers PMC clocks clk_out_1, clk_out_2,
>> clk_out_3 and blink output in tegra_pmc_init() which does direct Tegra
>> PMC access during clk_ops and these PMC register read and write access
>> will not happen when PMC is in secure mode.
>>
>> Any direct PMC register access from non-secure world will not go
>> through and all the PMC clocks and blink control are done in Tegra PMC
>> driver with PMC as clock provider.
>>
>> This patch removes tegra_pmc_clk_init along with corresponding clk ids
>> from Tegra clock driver.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
> 
> [snip]
> 
>> @@ -1230,9 +1222,6 @@ static struct tegra_clk_init_table init_table[] __initdata = {
> 
>>  	{ TEGRA30_CLK_PLL_A, TEGRA30_CLK_CLK_MAX, 564480000, 1 },
>>  	{ TEGRA30_CLK_PLL_A_OUT0, TEGRA30_CLK_CLK_MAX, 11289600, 1 },
>>  	{ TEGRA30_CLK_EXTERN1, TEGRA30_CLK_PLL_A_OUT0, 0, 1 },
> 
> Perhaps these clocks do not need to be always-enabled?
> 
> [snip]
> 

Also, EXTERN1 parent configuration should be moved to the audio
driver/device-tree as well.

Maybe it even makes sense to move the whole configuration, including
PLLA. I don't see why clk driver need to do something for the audio driver.
