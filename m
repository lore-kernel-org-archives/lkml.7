Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93433C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545092086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 00:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/LFxbrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390783AbfFKABi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 20:01:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35573 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390647AbfFKABi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:01:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id x25so5088084ljh.2;
        Mon, 10 Jun 2019 17:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ml73Kr2VziKROWSuyXgL+Ty4Irk7/WJ5+ykuDE3N0mw=;
        b=I/LFxbrXGYfpcNHxrBVjycKepERrVEp783/i/UzEWgFNMRjqYXe0djS66zBugx5DX2
         mhDGWelUWZEFUbswawHfpSH4D0UwEx3kDCBqDwwGcc9t/yALjM3xxX6mP5wTEgqRIZAj
         Akj8GH3VDmASdxmJkd6pChBd7Xg/jgGgpD/KnSmth5le/ZTv8XvSE/LnseRPEWrHxXq5
         PyQH6LwNK4EABSTPlj1OJbfF/RUS6iKma2V0WE998dnyJidMVYRIxtGhgyWzMD2cse/c
         Myppm3RQLdaly+Ed4IQWrOvzx0r4HebCJNE2fKutoteGg7IoqY2fUTt2oTNUIMPFoCz4
         s+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ml73Kr2VziKROWSuyXgL+Ty4Irk7/WJ5+ykuDE3N0mw=;
        b=oiCfPDmf0KPL1jeDh8ldhpS5Da3geS9KTUnIDw1U+ELS673EuPL9d20O8h3axP50kY
         Ss+Bdu6SOq+61sB7S9UDgkKM9b7ck2J8RVyVSaV2JeavwMKsBPz+rvLbeXuepGWoy6R3
         DMQbG6sWE+x7b2ClfaWxVTC/6Tj/cp+KnBcbx9o8BBS3PPomL8usZdJ8KB9QnZnIDI8+
         B9oezsGdv9SodpiCo3oDBK8v+eFeQFWUBR76GSRX9Dfc4NgK5gd6dayqgAFp11HqU2qq
         8MEp2gd0ZD87cMkpNIG03cXa7QNu8JeSCfBIKFbw1iINf1xY4lXw8OGVXrLRq9eVdmvt
         TZLw==
X-Gm-Message-State: APjAAAXByZFJhg8qPwrzlYi45kCSZQQBTclFEyKEsywDTk+d8Kz2zTwZ
        YG1ftP9kxR4rKdH9I4u89XVmEeEH
X-Google-Smtp-Source: APXvYqy/5sHIjAbRTHEeDlyxlg3CMA/rPQ0LREVE4ANJxVyLEUwvYAvp2Oc1ysij0n8O37kBgwqdVA==
X-Received: by 2002:a2e:1510:: with SMTP id s16mr9449302ljd.19.1560211294559;
        Mon, 10 Jun 2019 17:01:34 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id v7sm2272996ljj.3.2019.06.10.17.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 17:01:33 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] memory: tegra: Introduce Tegra30 EMC driver
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190524172353.29087-1-digetx@gmail.com>
Message-ID: <ba4c6423-0a20-daad-4b04-e990aec4c4e6@gmail.com>
Date:   Tue, 11 Jun 2019 03:01:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524172353.29087-1-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.05.2019 20:23, Dmitry Osipenko пишет:
> Hello,
> 
> This series introduces driver for the External Memory Controller (EMC)
> found on Tegra30 chips, it controls the external DRAM on the board. The
> purpose of this driver is to program memory timing for external memory on
> the EMC clock rate change. The driver was tested using the ACTMON devfreq
> driver that performs memory frequency scaling based on memory-usage load.
> 
> Changelog:
> 
> v3: - Addressed review comments that were made by Stephen Boyd to v2 by
>       adding explicit typing for the callback variable, by including
>       "clk-provider.h" directly in the code and by dropping __clk_lookup
>       usage where possible.
> 
>       Added more patches into this series:
> 
>         memory: tegra20-emc: Drop setting EMC rate to max on probe
>         memory: tegra20-emc: Adapt for clock driver changes
>         memory: tegra20-emc: Include io.h instead of iopoll.h
>         memory: tegra20-emc: Replace clk_get_sys with devm_clk_get
> 
>       Initially I was going to include these patches into other patchset,
>       but changed my mind after rearranging things a tad. The "Adapt for
>       clock driver changes" patch is directly related to the clock changes
>       done in the first patch of this series, the rest are minor cleanups
>       that are fine to include here as well.
> 
>       Added some more words to the commit message of "Add binding for NVIDIA
>       Tegra30 External Memory Controller" patch, clarifying why common DDR
>       timing device-tree form isn't suitable for Tegra30.
> 
>       The Tegra30 EMC driver now explicitly selects the registers access
>       mode (EMC_DBG mux), not relying on the setting left from bootloader.
> 
> v2: - Added support for changing MC clock diver configuration based on
>       Memory Controller (MC) configuration which is part of the memory
>       timing.
> 
>     - Merged the "Add custom EMC clock implementation" patch into this
>       series because the "Introduce Tegra30 EMC driver" patch directly
>       depends on it. Please note that Tegra20 EMC driver will need to be
>       adapted for the clock changes as well, I'll send out the Tegra20
>       patches after this series will be applied because of some other
>       dependencies (devfreq) and because the temporary breakage won't
>       be critical (driver will just error out on probe).
> 
>     - EMC driver now performs MC configuration validation by checking
>       that the number of MC / EMC timings matches and that the timings
>       rate is the same.
> 
>     - EMC driver now supports timings that want to change the MC clock
>       configuration.
> 
>     - Other minor prettifying changes of the code.
> 
> Dmitry Osipenko (8):
>   clk: tegra20/30: Add custom EMC clock implementation
>   memory: tegra20-emc: Drop setting EMC rate to max on probe
>   memory: tegra20-emc: Adapt for clock driver changes
>   memory: tegra20-emc: Include io.h instead of iopoll.h
>   memory: tegra20-emc: Replace clk_get_sys with devm_clk_get
>   dt-bindings: memory: Add binding for NVIDIA Tegra30 External Memory
>     Controller
>   memory: tegra: Introduce Tegra30 EMC driver
>   ARM: dts: tegra30: Add External Memory Controller node
> 
>  .../memory-controllers/nvidia,tegra30-emc.txt |  249 ++++
>  arch/arm/boot/dts/tegra30.dtsi                |   11 +
>  drivers/clk/tegra/Makefile                    |    2 +
>  drivers/clk/tegra/clk-tegra20-emc.c           |  299 +++++
>  drivers/clk/tegra/clk-tegra20.c               |   55 +-
>  drivers/clk/tegra/clk-tegra30.c               |   38 +-
>  drivers/clk/tegra/clk.h                       |    6 +
>  drivers/memory/tegra/Kconfig                  |   10 +
>  drivers/memory/tegra/Makefile                 |    1 +
>  drivers/memory/tegra/mc.c                     |    3 -
>  drivers/memory/tegra/mc.h                     |   30 +-
>  drivers/memory/tegra/tegra20-emc.c            |   94 +-
>  drivers/memory/tegra/tegra30-emc.c            | 1165 +++++++++++++++++
>  drivers/memory/tegra/tegra30.c                |   44 +
>  include/linux/clk/tegra.h                     |   14 +
>  15 files changed, 1903 insertions(+), 118 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.txt
>  create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
>  create mode 100644 drivers/memory/tegra/tegra30-emc.c
> 

Hello Peter,

Do you have any comments on the clk/emc bits? It looks to me that this
series basically needs yours, Stephen's and Rob's acks, after which
Thierry could pick it up once everything is arranged. Stephen and Rob
already made some comments to the previous versions of the series that
hopefully are addressed now. Maybe you also have something to say?
Otherwise just an ack will be also very appreciated. Thanks in advance!

Actually just noticed that I accidentally missed to CC Stephen directly
for this series, but hopefully it's not a problem since he is reading
the CLK ML. Stephen, please let me know otherwise, I could re-send it
all if needed.
