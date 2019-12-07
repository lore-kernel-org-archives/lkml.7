Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C1C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 14:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75C02467B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 14:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIF9CxEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfLGO0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 09:26:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41820 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfLGO0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 09:26:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so10731697ljc.8;
        Sat, 07 Dec 2019 06:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y2jLemfM6NAa2htdvtNYO/Blymq/6is+o20B/osA9Ro=;
        b=qIF9CxEQ6k1EF/wqZtxvEai9mTLlsDwyNz++ooTbsAS9QwTtkSqRAk+YvNmtXp9QPe
         k/4V29MeSX3PW7cKFz65qoEa3W9fgRweWAYOFYYc3WpCESIC9euKFqMe1lVW2EOievFt
         3/h1JzjIiU5M1miTi/jx+eUuQ/seDVanFdxnI0cxiEDdSutLkFFP/cCVb8Er3+3eEmaX
         dztGrSqarJD18XnypryEKxayizmfQISw/uRsHZk89Hoj9j8aOXNNOogX3tpCbVqBLtXt
         Eya6SEryR9plGqUKupDB8B3lHDzo2dO4p6ZAphHrhZWb58dO2mbfMR5jJRPBX60n/2Gc
         KtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y2jLemfM6NAa2htdvtNYO/Blymq/6is+o20B/osA9Ro=;
        b=orotlePkznKHY5ULOhSPPWVj7hWRE0jjrudPrFwRT4t+6RmCLnVUMh2onVrUeYhmf0
         9eMuv9QHkI49EvIlH7NZhyWCiz56b8JXAWdcC7wbXUJt80RL4bwyuPREGS6F0FDaqlVP
         Yi0bRVGbvfTH3045UUBTThC/JrMx4GcJsdRu2WzWGvFDipgb5RT/AyFl+fmlOuaHMepn
         iIF1IrmbgBREXUK3gup+knaX2wecOV1JtHL59Q8C7sLk/K8lSCqGlXx88C1gZpxOSmln
         6LGrco/QksBXG1WynzpI2qcopbm6bN6VD43v604TU5bAACaYfxkdvpWV4XiiGOAfnBFB
         lcCA==
X-Gm-Message-State: APjAAAUl3Qi1HXgrAOYiua/O8KxiYeFIIme2CzvQHi86+huMssPQWBVj
        UMtdZKlZ8T+c6iy4Gmk/NW8=
X-Google-Smtp-Source: APXvYqz1YRFRFNxLt0h0j6p1bp3b8kcTYDbdTpKf1RHHQ0N+EIL0IYrF/JF8vAisr83u1gPfUooNgg==
X-Received: by 2002:a05:651c:1139:: with SMTP id e25mr11792174ljo.200.1575728777693;
        Sat, 07 Dec 2019 06:26:17 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id d16sm8147955lfa.16.2019.12.07.06.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 06:26:16 -0800 (PST)
Subject: Re: [PATCH v3 00/15] Move PMC clocks into Tegra PMC driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, allison@lohutok.net, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, mturquette@baylibre.com,
        horms+renesas@verge.net.au, Jisheng.Zhang@synaptics.com,
        krzk@kernel.org, arnd@arndb.de, spujar@nvidia.com,
        josephl@nvidia.com, vidyas@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alexios.zavras@intel.com,
        alsa-devel@alsa-project.org
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dfda896d-27f3-7185-146e-4f697d823471@gmail.com>
Date:   Sat, 7 Dec 2019 17:26:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.12.2019 05:48, Sowjanya Komatineni пишет:
> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls which
> are currently registered by Tegra clock driver using clk_regiser_mux and
> clk_register_gate which performs direct Tegra PMC register access.
> 
> When Tegra PMC is in secure mode, any access from non-secure world will
> not go through.
> 
> This patch series adds these Tegra PMC clocks and blink controls to Tegra
> PMC driver with PMC as clock provider and removed them from Tegra clock
> driver. This also adds PMC specific clock id's to use in device tree and
> removed clock ids of PMC clock from Tegra clock driver.
> 
> clk_out_1 is dedicated for audio mclk and current ASoC driver does not
> setting extern1 as parent for clk_out_1 and enabling clk_out_1 and
> currently this is taken care by Tegra clock driver during clock inits
> and there is no need to enable this during clock init.
> 
> So, this series also includes patch that updates ASoC driver to take
> care of configuring parent of mclk and enabling mclk using both extern1
> and clk_out_1 and updates all device trees to use clk_out_1 from pmc as
> mclk incase if device tree don't specify assigned-clock-parents.
> 
> This series also includes a patch for mclk fallback to use extern1
> when retrieving mclk fails with new device tree which uses pmc provider
> to have this backward compatible of new DT with old kernels.
> 
> This series also includes a patch to remove clock ids for these clocks
> from clock dt-binding as these clocks are not used in any of the existing
> device tree except in tegra210-smaug.dts and this series includes a patch
> to update clock provider from tegra_car to pmc in tegra210-smaug.dts for
> clk_out_2.
> 
> [v3]:	Changes between v2 and v3 are
> 	- Removes set parent of clk_out_1_mux to extern1 and enabling
> 	  extern1 from the clock driver.
> 	- Doesn't enable clk_out_1 and blink by default in pmc driver
> 	- Updates ASoC driver to take care of audio mclk parent
> 	  configuration incase if device tree don't specify assigned
> 	  clock parent properties and enables mclk using both clk_out_1
> 	  and extern1.
> 	- updates all device trees using extern1 as mclk in sound node
> 	  to use clk_out_1 from pmc.
> 	- patch for YAML format pmc dt-binding
> 	- Includes v2 feedback
> 
> [v2]:	Changes between v1 and v2 are
> 	- v2 includes patches for adding clk_out_1, clk_out_2, clk_out_3,
> 	  blink controls to Tegra PMC driver and removing clk-tegra-pmc.
> 	- feedback related to pmc clocks in Tegra PMC driver from v1
> 	- Removed patches for WB0 PLLM overrides and PLLE IDDQ PMC programming
> 	  by the clock driver using helper functions from Tegra PMC.
> 
>  	  Note:
> 	  To use helper functions from PMC driver, PMC early init need to
> 	  happen prior to using helper functions and these helper functions are
> 	  for PLLM Override and PLLE IDDQ programming in PMC during PLLM/PLLE
> 	  clock registration which happen in clock_init prior to Tegra PMC
> 	  probe.
> 	  Moving PLLM/PLLE clocks registration to happen after Tegra PMC
> 	  impacts other clocks EMC, MC and corresponding tegra_emc_init and
> 	  tegra_mc_init.
> 	  This implementation of configuring PMC registers thru helper
> 	  functions in clock driver needs proper changes across PMC, Clock,
> 	  EMC and MC inits to have it work across all Tegra platforms.
> 
> 	  Currently PLLM Override is not enabled in the bootloader so proper
> 	  patches for this fix will be taken care separately.
> 
> [v1]:	v1 includes patches for below fixes.
> 	- adding clk_out_1, clk_out_2, clk_out_3, blink controls to Tegra PMC
> 	  driver and removing clk-tegra-pmc.
> 	- updated clock provider from tegra_car to pmc in the device tree
> 	  tegra210-smaug.dts that uses clk_out_2.
> 	- Added helper functions in PMC driver for WB0 PLLM overrides and PLLE
> 	  IDDQ programming to use by clock driver and updated clock driver to
> 	  use these helper functions and removed direct PMC access from clock
> 	  driver and all pmc base address references in clock driver.
> 
> 
> Sowjanya Komatineni (15):
>   dt-bindings: soc: tegra-pmc: Add Tegra PMC clock bindings
>   dt-bindings: tegra: Convert Tegra PMC bindings to YAML
>   soc: tegra: Add Tegra PMC clock registrations into PMC driver
>   dt-bindings: soc: tegra-pmc: Add id for Tegra PMC blink control
>   soc: pmc: Add blink output clock registration to Tegra PMC
>   clk: tegra: Remove tegra_pmc_clk_init along with clk ids
>   dt-bindings: clock: tegra: Remove pmc clock ids from clock dt-bindings
>   ASoC: tegra: Add audio mclk control through clk_out_1 and extern1
>   ASoC: tegra: Add fallback for audio mclk
>   clk: tegra: Remove extern1 and cdev1 from clocks inittable
>   ARM: dts: tegra: Add clock-cells property to pmc


>   arm64: tegra: Add clock-cells property to Tegra PMC node
>   ARM: tegra: Update sound node clocks in device tree
>   arm64: tegra: smaug: Change clk_out_2 provider to pmc
>   ASoC: nau8825: change Tegra clk_out_2 provider from tegra_car to pmc

Hello Sowjanya,

Something gone wrong with these patches because I didn't receive them
and don't see them on the ML either.

Also, the list of email correspondents looks a bit too larger. I'm
pretty sure some of the people do not care much about this series. I
tend to use script/get_maintainer.pl and then manually pick the relevant
people for patches.
