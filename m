Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74272C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40459206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vVCcpBZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfK0Obl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:31:41 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34877 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfK0Obk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:31:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id j6so15715962lja.2;
        Wed, 27 Nov 2019 06:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M9v+QKFBceM7UwSZzBuiBDdbBA4xp8eGHt5HTP5gbgc=;
        b=vVCcpBZx/CT6V3mo1xdBB8U2Q1ZK2bCaI/XYtKfEZ4VTlW+dQgL1REcBAn77EYEvDD
         UzkT+RGgQ7H2BtBsTJCIaYl3OVLiZoxJog1A38U2jayp38t4ojIo5QJX0iLTeeRG/CyM
         9JTtfCsLwnf4kusN1K7g2+xPFPZqkWQwKAsQEU/lz2njFMy5Ion/4tboLXx851wG9nZj
         6EBEUskGO5TFTC417ZX8NTvIA4Ev6bhH1SVT6sicv4ywU7XWwkZZbzc10gXs14Yu+UgK
         8nb05ofRWMGqaT6LBKDpa8ok8+mKjwPtBl+ntaPv6MqI1yRkdjyryXv0iA7wNCrnSCus
         PQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M9v+QKFBceM7UwSZzBuiBDdbBA4xp8eGHt5HTP5gbgc=;
        b=Lcbdnhqh86WvhIF6cOYveTE6HOvPShfEx06kwD4DXDUpFkliXxgPXiLYrZprmfDnCX
         +jj+6jS0PXXdXHXVRnCwTKU34IsELLu1eNS09py8xEFGUgtKUcnkre1yaAnVnUda/Zxr
         zzcGrEGUkGqIWvwgZaxze1CthqHM92RLj+bvJutThfKB4tKZERkfo3ZAB9TN7PRoZb3p
         hJaxzHfmlqq9c0cgMsnXwhlA0p4qLCYX2AZUdlErj2OEa/JyAri0g69Y9Q3CN83rUkPa
         HyIQ22BuuaFJkG/+knyrxwY0z8bs3S3hnd3B3J8GdrosGsJ2HPNYmccYlr/2Q+VBHpHv
         hWjA==
X-Gm-Message-State: APjAAAW/FwjIfG1fCipwXrJ/Xv0CTX6khRxjCGZPTUg20WeFEekACa/Z
        ssk9bCZNXHPs/ItRYthUO/CQ8DTI
X-Google-Smtp-Source: APXvYqxT5TbAMagvxoPwkEO7AKeUttwQ+IV1OURSX9UINaImynpi/CEn3C9r2cPJkgzpd9Fl1wrvsA==
X-Received: by 2002:a2e:9699:: with SMTP id q25mr31094007lji.251.1574865096813;
        Wed, 27 Nov 2019 06:31:36 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id v21sm6993461lfe.68.2019.11.27.06.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 06:31:35 -0800 (PST)
Subject: Re: [PATCH v2 00/11] Move PMC clocks into Tegra PMC driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, sboyd@kernel.org
Cc:     gregkh@linuxfoundation.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, allison@lohutok.net, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, mturquette@baylibre.com,
        horms+renesas@verge.net.au, Jisheng.Zhang@synaptics.com,
        krzk@kernel.org, arnd@arndb.de, spujar@nvidia.com,
        josephl@nvidia.com, vidyas@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <79e7bd6a-f138-1e7d-6e0b-435adde3b3e5@gmail.com>
Date:   Wed, 27 Nov 2019 17:31:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

27.11.2019 07:59, Sowjanya Komatineni пишет:
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
> This series also includes patch to update clock provider from tegra_car
> to pmc in the device tree tegra210-smaug.dts that uses clk_out_2 from PMC.
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

Hello Sowjanya,

Could you please clarify what do you mean by "PLLM Override not enabled
in bootloader"?

There is T124 Nyan Big Chromebook which is supported in upstream kernel,
it has PLLM Override set by bootloader. I also have T30 Nexus 7 tablet
which has the PLLM Override set by bootloader as well. It's not clear to
me whether this patch series is supposed to break these devices. If the
breakage is the case here, then I'm afraid you can't postpone supporting
the PLLM Override and a full-featured implementation is needed.

I briefly tried to test this series on T30 and this time it doesn't hang
on boot, but somehow WiFi MMC card detection is broken. AFAIK, the WiFi
chip uses the Blink clock source and the clock should be enabled by the
MMC core because this is how DT part looks like:

brcm_wifi_pwrseq: wifi-pwrseq {
	compatible = "mmc-pwrseq-simple";
	clocks = <&pmc TEGRA_PMC_CLK_BLINK>;
	clock-names = "ext_clock";
	reset-gpios =  <&gpio TEGRA_GPIO(D, 3) GPIO_ACTIVE_LOW>;
	post-power-on-delay-ms = <300>;
	power-off-delay-us = <300>;
};

BTW, I  tried this series on a T20 device which also uses the Blink
clock for WiFi card and it works. So looks like this patchset has some
problem in regards to the T30 PMC clocks implementation.

[snip]
