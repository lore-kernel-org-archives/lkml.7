Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B33FC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C6A208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551788540;
	bh=mo9coxyfWJ6WLVfSYj7HJVXN7kMW6N/KSIu3WhVfFI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2ge+NfhWftTRubJjhu1yWhaVZmiPTsyiMzwfJZ6ROl6oaUvBX7ole1kgG7J3Of0rb
	 ZJinsGO1qYuYKz7jIxT3IFjOtpW2tIv1v69r+zHTH/vuuttNLe2J+Shk+OW4LbLE7/
	 pYZ168oECEigWCChzU+KQEUEokakk5gRHpBpp458=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfCEMWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:22:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37111 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfCEMWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:22:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so2334333wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 04:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GYPxp6u1D1QZwBid4C/JPtT5g0XjCT5SYJrttwN+Ybc=;
        b=MuRXCgVZQazZYy9vBbq0A5z0TNmWfS7NomqhOKvQoGF7DpvSTR5xmeOFhNzTf3GiKg
         yXdwlbjN7aZM/4gP3vJ7MC0z+DWZrbwGiaMR1QJyElw/ZrlrEAB3nLbOK4/mqpVqQjY7
         6pJaQ5qqsSjxly+IruDsVdkIKfTKWRBj0PpjhHKEgdETkR/BxuFmI4y1HxOnKxODuLsQ
         Xo/zbTcTrpELfmirV8jAeTq4cNIQ3EI6IygEOe+cUTsFeCwg4759lKMKvL3RZJOu0aO6
         OlwHRZ2ZMYTXqHOBn86689ppta81uzG8kdi56Uf/4D6ow2p8B1270PSV8JUqLWPaxAr/
         E9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GYPxp6u1D1QZwBid4C/JPtT5g0XjCT5SYJrttwN+Ybc=;
        b=HZAapy82d2/OWHawvlpAe9W8mkZpDO9Xls6GCE1zzV+EQ3v+gLzsS3tuD9nh62qLhW
         tBJnAX2jZAAi0wY9A+EbSdMZuikRcpgpbAeYImQXOuUNNrZaTQyt04qIYkghubR5OePy
         NOfRK5OjAhqQ6CMNcrDnN3iss9a5i6/oRzKyc71q64U5+S8vQdsMOHJaozZaDa0opsEe
         pJkH9WXW+nc8SekMsXh3WW3XLhu8ixfgsr+jFKlNMdQWGW+XCTTJMtqzNTzlgPeo0sRZ
         77xlNOtmy/Y73doOkChw/lrzMJhdOjVW4KP0eOvkLyuT4vHS7r7km9n1AKuWAxv1N9QM
         LnnQ==
X-Gm-Message-State: APjAAAU9FGNy5N/GWlhuYOvmEjMVHOAegiXq0XtnpXoxsHmw5iaBFfsj
        qNY4atufLcyibe+DWeg5feY=
X-Google-Smtp-Source: APXvYqxEV306pFm/lHXY1jVYnfws+jN9VMzfjs+y7JAH4KclkxJbhxhYLdOm6rcD+iN4JoXB8y0lEQ==
X-Received: by 2002:a1c:df07:: with SMTP id w7mr2596554wmg.23.1551788531686;
        Tue, 05 Mar 2019 04:22:11 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id a131sm6012852wmh.34.2019.03.05.04.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 04:22:10 -0800 (PST)
Date:   Tue, 5 Mar 2019 13:22:08 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: timer updates for v5.1
Message-ID: <20190305122208.GA847@gmail.com>
References: <155178637782.3906.3253567963332039739.tglx@nanos.tec.linutronix.de>
 <155178637782.3906.17214330411527609903.tglx@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155178637782.3906.17214330411527609903.tglx@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+Subject line.

* Thomas Gleixner <tglx@linutronix.de> wrote:

> Linus,
> 
> please pull the latest timers-core-for-linus git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-for-linus
> 
> The time(r) core and clockevent updates are mostly boring this time:
> 
>   - A new driver for the Tegra210 timer
> 
>   - Small fixes and improvements alll over the place
> 
>   - Documentation updates and cleanups
> 
> Thanks,
> 
> 	tglx
> 
> ------------------>
> Anson Huang (1):
>       dt-bindings: timer: gpt: update binding doc
> 
> Atish Patra (1):
>       clocksource/drivers/riscv: Add required checks during clock source init
> 
> Biju Das (2):
>       dt-bindings: timer: renesas, cmt: Document r8a774c0 CMT support
>       dt-bindings: timer: renesas: tmu: Document r8a774c0 bindings
> 
> Chen-Yu Tsai (1):
>       clocksource/drivers/sun5i: Fail gracefully when clock rate is unavailable
> 
> Daniel Lezcano (3):
>       clocksource/drivers/tango-xtal: Rename the file for consistency
>       clocksource/drivers/timer-pxa: Rename the file for consistency
>       clocksource/drivers/timer-cs5535: Rename the file for consistency
> 
> Greg Kroah-Hartman (1):
>       timekeeping/debug: No need to check return value of debugfs_create functions
> 
> Gustavo A. R. Silva (1):
>       timers: Mark expected switch fall-throughs
> 
> Joseph Lo (3):
>       dt-bindings: timer: add Tegra210 timer
>       clocksource/drivers/tegra: Add Tegra210 timer support
>       soc/tegra: default select TEGRA_TIMER for Tegra210
> 
> Krzysztof Kozlowski (1):
>       clocksource/drivers/exynos_mct: Remove unused header includes
> 
> Marek Szyprowski (2):
>       clocksource/drivers/exynos_mct: Remove dead code
>       clocksource/drivers/exynos_mct: Fix error path in timer resources initialization
> 
> Paul E. McKenney (1):
>       time: Move CONTEXT_TRACKING to kernel/time/Kconfig
> 
> Ryder Lee (1):
>       dt-bindings: timer: mediatek: update bindings for MT7629 SoC
> 
> Samuel Holland (1):
>       clocksource/drivers/arch_timer: Workaround for Allwinner A64 timer instability
> 
> Stuart Menefy (2):
>       clocksource/drivers/exynos_mct: Move one-shot check from tick clear to ISR
>       clocksource/drivers/exynos_mct: Clear timer interrupt when shutdown
> 
> Thomas Gleixner (1):
>       posix-cpu-timers: Remove private interval storage
> 
> 
>  Documentation/arm64/silicon-errata.txt             |   2 +
>  .../devicetree/bindings/timer/fsl,imxgpt.txt       |  39 ++-
>  .../bindings/timer/mediatek,mtk-timer.txt          |  11 +-
>  .../bindings/timer/nvidia,tegra210-timer.txt       |  36 ++
>  .../devicetree/bindings/timer/renesas,cmt.txt      |   2 +
>  .../devicetree/bindings/timer/renesas,tmu.txt      |   1 +
>  drivers/clocksource/Kconfig                        |  13 +-
>  drivers/clocksource/Makefile                       |   6 +-
>  drivers/clocksource/arm_arch_timer.c               |  55 +++
>  drivers/clocksource/exynos_mct.c                   |  48 +--
>  .../{cs5535-clockevt.c => timer-cs5535.c}          |   0
>  drivers/clocksource/{pxa_timer.c => timer-pxa.c}   |   0
>  drivers/clocksource/timer-riscv.c                  |  23 +-
>  drivers/clocksource/timer-sun5i.c                  |  10 +
>  .../{tango_xtal.c => timer-tango-xtal.c}           |   0
>  drivers/clocksource/timer-tegra20.c                | 370 ++++++++++++++-------
>  drivers/soc/tegra/Kconfig                          |   1 +
>  include/linux/cpuhotplug.h                         |   1 +
>  include/linux/posix-timers.h                       |   2 +-
>  kernel/rcu/Kconfig                                 |  30 --
>  kernel/time/Kconfig                                |  29 ++
>  kernel/time/hrtimer.c                              |   2 +-
>  kernel/time/posix-cpu-timers.c                     |  13 +-
>  kernel/time/tick-broadcast.c                       |   1 +
>  kernel/time/timekeeping_debug.c                    |  11 +-
>  kernel/time/timer.c                                |   2 +-
>  26 files changed, 511 insertions(+), 197 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
>  rename drivers/clocksource/{cs5535-clockevt.c => timer-cs5535.c} (100%)
>  rename drivers/clocksource/{pxa_timer.c => timer-pxa.c} (100%)
>  rename drivers/clocksource/{tango_xtal.c => timer-tango-xtal.c} (100%)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 1f09d043d086..ddb8ce5333ba 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -44,6 +44,8 @@ stable kernels.
>  
>  | Implementor    | Component       | Erratum ID      | Kconfig                     |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| Allwinner      | A64/R18         | UNKNOWN1        | SUN50I_ERRATUM_UNKNOWN1     |
> +|                |                 |                 |                             |
>  | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
>  | ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319        |
>  | ARM            | Cortex-A53      | #824069         | ARM64_ERRATUM_824069        |
> diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> index 9809b11f7180..5d8fd5b52598 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> +++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
> @@ -2,17 +2,44 @@ Freescale i.MX General Purpose Timer (GPT)
>  
>  Required properties:
>  
> -- compatible : should be "fsl,<soc>-gpt"
> -- reg : Specifies base physical address and size of the registers.
> -- interrupts : A list of 4 interrupts; one per timer channel.
> -- clocks : The clocks provided by the SoC to drive the timer.
> +- compatible : should be one of following:
> +  for i.MX1:
> +  - "fsl,imx1-gpt";
> +  for i.MX21:
> +  - "fsl,imx21-gpt";
> +  for i.MX27:
> +  - "fsl,imx27-gpt", "fsl,imx21-gpt";
> +  for i.MX31:
> +  - "fsl,imx31-gpt";
> +  for i.MX25:
> +  - "fsl,imx25-gpt", "fsl,imx31-gpt";
> +  for i.MX50:
> +  - "fsl,imx50-gpt", "fsl,imx31-gpt";
> +  for i.MX51:
> +  - "fsl,imx51-gpt", "fsl,imx31-gpt";
> +  for i.MX53:
> +  - "fsl,imx53-gpt", "fsl,imx31-gpt";
> +  for i.MX6Q:
> +  - "fsl,imx6q-gpt", "fsl,imx31-gpt";
> +  for i.MX6DL:
> +  - "fsl,imx6dl-gpt";
> +  for i.MX6SL:
> +  - "fsl,imx6sl-gpt", "fsl,imx6dl-gpt";
> +  for i.MX6SX:
> +  - "fsl,imx6sx-gpt", "fsl,imx6dl-gpt";
> +- reg : specifies base physical address and size of the registers.
> +- interrupts : should be the gpt interrupt.
> +- clocks : the clocks provided by the SoC to drive the timer, must contain
> +           an entry for each entry in clock-names.
> +- clock-names : must include "ipg" entry first, then "per" entry.
>  
>  Example:
>  
>  gpt1: timer@10003000 {
> -	compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
> +	compatible = "fsl,imx27-gpt", "fsl,imx21-gpt";
>  	reg = <0x10003000 0x1000>;
>  	interrupts = <26>;
> -	clocks = <&clks 46>, <&clks 61>;
> +	clocks = <&clks IMX27_CLK_GPT1_IPG_GATE>,
> +		 <&clks IMX27_CLK_PER1_GATE>;
>  	clock-names = "ipg", "per";
>  };
> diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> index 18d4d0166c76..ff7c567a7972 100644
> --- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> +++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
> @@ -1,7 +1,7 @@
> -Mediatek Timers
> +MediaTek Timers
>  ---------------
>  
> -Mediatek SoCs have two different timers on different platforms,
> +MediaTek SoCs have two different timers on different platforms,
>  - GPT (General Purpose Timer)
>  - SYST (System Timer)
>  
> @@ -9,6 +9,7 @@ The proper timer will be selected automatically by driver.
>  
>  Required properties:
>  - compatible should contain:
> +	For those SoCs that use GPT
>  	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
>  	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
>  	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
> @@ -17,7 +18,11 @@ Required properties:
>  	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
>  	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
>  	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
> -	* "mediatek,mt6765-timer" for MT6765 compatible timers (SYST)
> +
> +	For those SoCs that use SYST
> +	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
> +	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
> +
>  - reg: Should contain location and length for timer register.
>  - clocks: Should contain system clock.
>  
> diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
> new file mode 100644
> index 000000000000..032cda96fe0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
> @@ -0,0 +1,36 @@
> +NVIDIA Tegra210 timer
> +
> +The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
> +timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
> +from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
> +(TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
> +or watchdog interrupts.
> +
> +Required properties:
> +- compatible : "nvidia,tegra210-timer".
> +- reg : Specifies base physical address and size of the registers.
> +- interrupts : A list of 14 interrupts; one per each timer channels 0 through
> +  13.
> +- clocks : Must contain one entry, for the module clock.
> +  See ../clocks/clock-bindings.txt for details.
> +
> +timer@60005000 {
> +	compatible = "nvidia,tegra210-timer";
> +	reg = <0x0 0x60005000 0x0 0x400>;
> +	interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&tegra_car TEGRA210_CLK_TIMER>;
> +	clock-names = "timer";
> +};
> diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> index 862a80f0380a..c0594450e9ef 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> +++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> @@ -32,6 +32,8 @@ Required Properties:
>      - "renesas,r8a77470-cmt1" for the 48-bit CMT1 device included in r8a77470.
>      - "renesas,r8a774a1-cmt0" for the 32-bit CMT0 device included in r8a774a1.
>      - "renesas,r8a774a1-cmt1" for the 48-bit CMT1 device included in r8a774a1.
> +    - "renesas,r8a774c0-cmt0" for the 32-bit CMT0 device included in r8a774c0.
> +    - "renesas,r8a774c0-cmt1" for the 48-bit CMT1 device included in r8a774c0.
>      - "renesas,r8a7790-cmt0" for the 32-bit CMT0 device included in r8a7790.
>      - "renesas,r8a7790-cmt1" for the 48-bit CMT1 device included in r8a7790.
>      - "renesas,r8a7791-cmt0" for the 32-bit CMT0 device included in r8a7791.
> diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
> index 4ddff85837da..13ad07416bdd 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
> +++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
> @@ -10,6 +10,7 @@ Required Properties:
>  
>    - compatible: must contain one or more of the following:
>      - "renesas,tmu-r8a7740" for the r8a7740 TMU
> +    - "renesas,tmu-r8a774c0" for the r8a774C0 TMU
>      - "renesas,tmu-r8a7778" for the r8a7778 TMU
>      - "renesas,tmu-r8a7779" for the r8a7779 TMU
>      - "renesas,tmu-r8a77970" for the r8a77970 TMU
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a9e26f6a81a1..5d93e580e5dc 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -131,7 +131,8 @@ config SUN5I_HSTIMER
>  config TEGRA_TIMER
>  	bool "Tegra timer driver" if COMPILE_TEST
>  	select CLKSRC_MMIO
> -	depends on ARM
> +	select TIMER_OF
> +	depends on ARM || ARM64
>  	help
>  	  Enables support for the Tegra driver.
>  
> @@ -360,6 +361,16 @@ config ARM64_ERRATUM_858921
>  	  The workaround will be dynamically enabled when an affected
>  	  core is detected.
>  
> +config SUN50I_ERRATUM_UNKNOWN1
> +	bool "Workaround for Allwinner A64 erratum UNKNOWN1"
> +	default y
> +	depends on ARM_ARCH_TIMER && ARM64 && ARCH_SUNXI
> +	select ARM_ARCH_TIMER_OOL_WORKAROUND
> +	help
> +	  This option enables a workaround for instability in the timer on
> +	  the Allwinner A64 SoC. The workaround will only be active if the
> +	  allwinner,erratum-unknown1 property is found in the timer node.
> +
>  config ARM_GLOBAL_TIMER
>  	bool "Support for the ARM global timer" if COMPILE_TEST
>  	select TIMER_OF if OF
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index cdd210ff89ea..c4a8e9ef932a 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -6,7 +6,7 @@ obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
>  obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
>  obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
>  obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
> -obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= cs5535-clockevt.o
> +obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= timer-cs5535.o
>  obj-$(CONFIG_CLKSRC_JCORE_PIT)		+= jcore-pit.o
>  obj-$(CONFIG_SH_TIMER_CMT)	+= sh_cmt.o
>  obj-$(CONFIG_SH_TIMER_MTU2)	+= sh_mtu2.o
> @@ -29,7 +29,7 @@ obj-$(CONFIG_BCM2835_TIMER)	+= bcm2835_timer.o
>  obj-$(CONFIG_CLPS711X_TIMER)	+= clps711x-timer.o
>  obj-$(CONFIG_ATLAS7_TIMER)	+= timer-atlas7.o
>  obj-$(CONFIG_MXS_TIMER)		+= mxs_timer.o
> -obj-$(CONFIG_CLKSRC_PXA)	+= pxa_timer.o
> +obj-$(CONFIG_CLKSRC_PXA)	+= timer-pxa.o
>  obj-$(CONFIG_PRIMA2_TIMER)	+= timer-prima2.o
>  obj-$(CONFIG_U300_TIMER)	+= timer-u300.o
>  obj-$(CONFIG_SUN4I_TIMER)	+= timer-sun4i.o
> @@ -69,7 +69,7 @@ obj-$(CONFIG_KEYSTONE_TIMER)		+= timer-keystone.o
>  obj-$(CONFIG_INTEGRATOR_AP_TIMER)	+= timer-integrator-ap.o
>  obj-$(CONFIG_CLKSRC_VERSATILE)		+= timer-versatile.o
>  obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
> -obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= tango_xtal.o
> +obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= timer-tango-xtal.o
>  obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
>  obj-$(CONFIG_CLKSRC_IMX_TPM)		+= timer-imx-tpm.o
>  obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index 9a7d4dc00b6e..a8b20b65bd4b 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -326,6 +326,48 @@ static u64 notrace arm64_1188873_read_cntvct_el0(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_SUN50I_ERRATUM_UNKNOWN1
> +/*
> + * The low bits of the counter registers are indeterminate while bit 10 or
> + * greater is rolling over. Since the counter value can jump both backward
> + * (7ff -> 000 -> 800) and forward (7ff -> fff -> 800), ignore register values
> + * with all ones or all zeros in the low bits. Bound the loop by the maximum
> + * number of CPU cycles in 3 consecutive 24 MHz counter periods.
> + */
> +#define __sun50i_a64_read_reg(reg) ({					\
> +	u64 _val;							\
> +	int _retries = 150;						\
> +									\
> +	do {								\
> +		_val = read_sysreg(reg);				\
> +		_retries--;						\
> +	} while (((_val + 1) & GENMASK(9, 0)) <= 1 && _retries);	\
> +									\
> +	WARN_ON_ONCE(!_retries);					\
> +	_val;								\
> +})
> +
> +static u64 notrace sun50i_a64_read_cntpct_el0(void)
> +{
> +	return __sun50i_a64_read_reg(cntpct_el0);
> +}
> +
> +static u64 notrace sun50i_a64_read_cntvct_el0(void)
> +{
> +	return __sun50i_a64_read_reg(cntvct_el0);
> +}
> +
> +static u32 notrace sun50i_a64_read_cntp_tval_el0(void)
> +{
> +	return read_sysreg(cntp_cval_el0) - sun50i_a64_read_cntpct_el0();
> +}
> +
> +static u32 notrace sun50i_a64_read_cntv_tval_el0(void)
> +{
> +	return read_sysreg(cntv_cval_el0) - sun50i_a64_read_cntvct_el0();
> +}
> +#endif
> +
>  #ifdef CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND
>  DEFINE_PER_CPU(const struct arch_timer_erratum_workaround *, timer_unstable_counter_workaround);
>  EXPORT_SYMBOL_GPL(timer_unstable_counter_workaround);
> @@ -423,6 +465,19 @@ static const struct arch_timer_erratum_workaround ool_workarounds[] = {
>  		.read_cntvct_el0 = arm64_1188873_read_cntvct_el0,
>  	},
>  #endif
> +#ifdef CONFIG_SUN50I_ERRATUM_UNKNOWN1
> +	{
> +		.match_type = ate_match_dt,
> +		.id = "allwinner,erratum-unknown1",
> +		.desc = "Allwinner erratum UNKNOWN1",
> +		.read_cntp_tval_el0 = sun50i_a64_read_cntp_tval_el0,
> +		.read_cntv_tval_el0 = sun50i_a64_read_cntv_tval_el0,
> +		.read_cntpct_el0 = sun50i_a64_read_cntpct_el0,
> +		.read_cntvct_el0 = sun50i_a64_read_cntvct_el0,
> +		.set_next_event_phys = erratum_set_next_event_tval_phys,
> +		.set_next_event_virt = erratum_set_next_event_tval_virt,
> +	},
> +#endif
>  };
>  
>  typedef bool (*ate_match_fn_t)(const struct arch_timer_erratum_workaround *,
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 7a244b681876..34bd250d46c6 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -10,14 +10,12 @@
>   * published by the Free Software Foundation.
>  */
>  
> -#include <linux/sched.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/clockchips.h>
>  #include <linux/cpu.h>
> -#include <linux/platform_device.h>
>  #include <linux/delay.h>
>  #include <linux/percpu.h>
>  #include <linux/of.h>
> @@ -388,6 +386,13 @@ static void exynos4_mct_tick_start(unsigned long cycles,
>  	exynos4_mct_write(tmp, mevt->base + MCT_L_TCON_OFFSET);
>  }
>  
> +static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
> +{
> +	/* Clear the MCT tick interrupt */
> +	if (readl_relaxed(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1)
> +		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
> +}
> +
>  static int exynos4_tick_set_next_event(unsigned long cycles,
>  				       struct clock_event_device *evt)
>  {
> @@ -404,6 +409,7 @@ static int set_state_shutdown(struct clock_event_device *evt)
>  
>  	mevt = container_of(evt, struct mct_clock_event_device, evt);
>  	exynos4_mct_tick_stop(mevt);
> +	exynos4_mct_tick_clear(mevt);
>  	return 0;
>  }
>  
> @@ -420,8 +426,11 @@ static int set_state_periodic(struct clock_event_device *evt)
>  	return 0;
>  }
>  
> -static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
> +static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
>  {
> +	struct mct_clock_event_device *mevt = dev_id;
> +	struct clock_event_device *evt = &mevt->evt;
> +
>  	/*
>  	 * This is for supporting oneshot mode.
>  	 * Mct would generate interrupt periodically
> @@ -430,16 +439,6 @@ static void exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
>  	if (!clockevent_state_periodic(&mevt->evt))
>  		exynos4_mct_tick_stop(mevt);
>  
> -	/* Clear the MCT tick interrupt */
> -	if (readl_relaxed(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1)
> -		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
> -}
> -
> -static irqreturn_t exynos4_mct_tick_isr(int irq, void *dev_id)
> -{
> -	struct mct_clock_event_device *mevt = dev_id;
> -	struct clock_event_device *evt = &mevt->evt;
> -
>  	exynos4_mct_tick_clear(mevt);
>  
>  	evt->event_handler(evt);
> @@ -507,13 +506,12 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>  	int err, cpu;
>  	struct clk *mct_clk, *tick_clk;
>  
> -	tick_clk = np ? of_clk_get_by_name(np, "fin_pll") :
> -				clk_get(NULL, "fin_pll");
> +	tick_clk = of_clk_get_by_name(np, "fin_pll");
>  	if (IS_ERR(tick_clk))
>  		panic("%s: unable to determine tick clock rate\n", __func__);
>  	clk_rate = clk_get_rate(tick_clk);
>  
> -	mct_clk = np ? of_clk_get_by_name(np, "mct") : clk_get(NULL, "mct");
> +	mct_clk = of_clk_get_by_name(np, "mct");
>  	if (IS_ERR(mct_clk))
>  		panic("%s: unable to retrieve mct clock instance\n", __func__);
>  	clk_prepare_enable(mct_clk);
> @@ -562,7 +560,19 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
>  	return 0;
>  
>  out_irq:
> -	free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
> +	if (mct_int_type == MCT_INT_PPI) {
> +		free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
> +	} else {
> +		for_each_possible_cpu(cpu) {
> +			struct mct_clock_event_device *pcpu_mevt =
> +				per_cpu_ptr(&percpu_mct_tick, cpu);
> +
> +			if (pcpu_mevt->evt.irq != -1) {
> +				free_irq(pcpu_mevt->evt.irq, pcpu_mevt);
> +				pcpu_mevt->evt.irq = -1;
> +			}
> +		}
> +	}
>  	return err;
>  }
>  
> @@ -581,11 +591,7 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
>  	 * timer irqs are specified after the four global timer
>  	 * irqs are specified.
>  	 */
> -#ifdef CONFIG_OF
>  	nr_irqs = of_irq_count(np);
> -#else
> -	nr_irqs = 0;
> -#endif
>  	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
>  		mct_irqs[i] = irq_of_parse_and_map(np, i);
>  
> diff --git a/drivers/clocksource/cs5535-clockevt.c b/drivers/clocksource/timer-cs5535.c
> similarity index 100%
> rename from drivers/clocksource/cs5535-clockevt.c
> rename to drivers/clocksource/timer-cs5535.c
> diff --git a/drivers/clocksource/pxa_timer.c b/drivers/clocksource/timer-pxa.c
> similarity index 100%
> rename from drivers/clocksource/pxa_timer.c
> rename to drivers/clocksource/timer-pxa.c
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 431892200a08..e8163693e936 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -95,13 +95,30 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  	struct clocksource *cs;
>  
>  	hartid = riscv_of_processor_hartid(n);
> +	if (hartid < 0) {
> +		pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
> +			n, hartid);
> +		return hartid;
> +	}
> +
>  	cpuid = riscv_hartid_to_cpuid(hartid);
> +	if (cpuid < 0) {
> +		pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
> +		return cpuid;
> +	}
>  
>  	if (cpuid != smp_processor_id())
>  		return 0;
>  
> +	pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
> +	       __func__, cpuid, hartid);
>  	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
> -	clocksource_register_hz(cs, riscv_timebase);
> +	error = clocksource_register_hz(cs, riscv_timebase);
> +	if (error) {
> +		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
> +		       error, cpuid);
> +		return error;
> +	}
>  
>  	sched_clock_register(riscv_sched_clock,
>  			BITS_PER_LONG, riscv_timebase);
> @@ -110,8 +127,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  			 "clockevents/riscv/timer:starting",
>  			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
>  	if (error)
> -		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
> -		       error, cpuid);
> +		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
> +		       error);
>  	return error;
>  }
>  
> diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
> index 3b56ea3f52af..552c5254390c 100644
> --- a/drivers/clocksource/timer-sun5i.c
> +++ b/drivers/clocksource/timer-sun5i.c
> @@ -202,6 +202,11 @@ static int __init sun5i_setup_clocksource(struct device_node *node,
>  	}
>  
>  	rate = clk_get_rate(clk);
> +	if (!rate) {
> +		pr_err("Couldn't get parent clock rate\n");
> +		ret = -EINVAL;
> +		goto err_disable_clk;
> +	}
>  
>  	cs->timer.base = base;
>  	cs->timer.clk = clk;
> @@ -275,6 +280,11 @@ static int __init sun5i_setup_clockevent(struct device_node *node, void __iomem
>  	}
>  
>  	rate = clk_get_rate(clk);
> +	if (!rate) {
> +		pr_err("Couldn't get parent clock rate\n");
> +		ret = -EINVAL;
> +		goto err_disable_clk;
> +	}
>  
>  	ce->timer.base = base;
>  	ce->timer.ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
> diff --git a/drivers/clocksource/tango_xtal.c b/drivers/clocksource/timer-tango-xtal.c
> similarity index 100%
> rename from drivers/clocksource/tango_xtal.c
> rename to drivers/clocksource/timer-tango-xtal.c
> diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
> index 4293943f4e2b..fdb3d795a409 100644
> --- a/drivers/clocksource/timer-tegra20.c
> +++ b/drivers/clocksource/timer-tegra20.c
> @@ -15,21 +15,24 @@
>   *
>   */
>  
> -#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/time.h>
>  #include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/clockchips.h>
> -#include <linux/clocksource.h>
> -#include <linux/clk.h>
> -#include <linux/io.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/percpu.h>
>  #include <linux/sched_clock.h>
> -#include <linux/delay.h>
> +#include <linux/time.h>
> +
> +#include "timer-of.h"
>  
> +#ifdef CONFIG_ARM
>  #include <asm/mach/time.h>
> +#endif
>  
>  #define RTC_SECONDS            0x08
>  #define RTC_SHADOW_SECONDS     0x0c
> @@ -39,74 +42,161 @@
>  #define TIMERUS_USEC_CFG 0x14
>  #define TIMERUS_CNTR_FREEZE 0x4c
>  
> -#define TIMER1_BASE 0x0
> -#define TIMER2_BASE 0x8
> -#define TIMER3_BASE 0x50
> -#define TIMER4_BASE 0x58
> -
> -#define TIMER_PTV 0x0
> -#define TIMER_PCR 0x4
> -
> +#define TIMER_PTV		0x0
> +#define TIMER_PTV_EN		BIT(31)
> +#define TIMER_PTV_PER		BIT(30)
> +#define TIMER_PCR		0x4
> +#define TIMER_PCR_INTR_CLR	BIT(30)
> +
> +#ifdef CONFIG_ARM
> +#define TIMER_CPU0		0x50 /* TIMER3 */
> +#else
> +#define TIMER_CPU0		0x90 /* TIMER10 */
> +#define TIMER10_IRQ_IDX		10
> +#define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
> +#endif
> +#define TIMER_BASE_FOR_CPU(cpu) (TIMER_CPU0 + (cpu) * 8)
> +
> +static u32 usec_config;
>  static void __iomem *timer_reg_base;
> +#ifdef CONFIG_ARM
>  static void __iomem *rtc_base;
> -
>  static struct timespec64 persistent_ts;
>  static u64 persistent_ms, last_persistent_ms;
> -
>  static struct delay_timer tegra_delay_timer;
> -
> -#define timer_writel(value, reg) \
> -	writel_relaxed(value, timer_reg_base + (reg))
> -#define timer_readl(reg) \
> -	readl_relaxed(timer_reg_base + (reg))
> +#endif
>  
>  static int tegra_timer_set_next_event(unsigned long cycles,
>  					 struct clock_event_device *evt)
>  {
> -	u32 reg;
> +	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
>  
> -	reg = 0x80000000 | ((cycles > 1) ? (cycles-1) : 0);
> -	timer_writel(reg, TIMER3_BASE + TIMER_PTV);
> +	writel(TIMER_PTV_EN |
> +	       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
> +	       reg_base + TIMER_PTV);
>  
>  	return 0;
>  }
>  
> -static inline void timer_shutdown(struct clock_event_device *evt)
> +static int tegra_timer_shutdown(struct clock_event_device *evt)
>  {
> -	timer_writel(0, TIMER3_BASE + TIMER_PTV);
> +	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
> +
> +	writel(0, reg_base + TIMER_PTV);
> +
> +	return 0;
>  }
>  
> -static int tegra_timer_shutdown(struct clock_event_device *evt)
> +static int tegra_timer_set_periodic(struct clock_event_device *evt)
>  {
> -	timer_shutdown(evt);
> +	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
> +
> +	writel(TIMER_PTV_EN | TIMER_PTV_PER |
> +	       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
> +	       reg_base + TIMER_PTV);
> +
>  	return 0;
>  }
>  
> -static int tegra_timer_set_periodic(struct clock_event_device *evt)
> +static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
> +{
> +	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
> +	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
> +
> +	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
> +	evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void tegra_timer_suspend(struct clock_event_device *evt)
> +{
> +	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
> +
> +	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
> +}
> +
> +static void tegra_timer_resume(struct clock_event_device *evt)
> +{
> +	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
> +}
> +
> +#ifdef CONFIG_ARM64
> +static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
> +	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE,
> +
> +	.clkevt = {
> +		.name = "tegra_timer",
> +		.rating = 460,
> +		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
> +		.set_next_event = tegra_timer_set_next_event,
> +		.set_state_shutdown = tegra_timer_shutdown,
> +		.set_state_periodic = tegra_timer_set_periodic,
> +		.set_state_oneshot = tegra_timer_shutdown,
> +		.tick_resume = tegra_timer_shutdown,
> +		.suspend = tegra_timer_suspend,
> +		.resume = tegra_timer_resume,
> +	},
> +};
> +
> +static int tegra_timer_setup(unsigned int cpu)
>  {
> -	u32 reg = 0xC0000000 | ((1000000 / HZ) - 1);
> +	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
> +
> +	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
> +	enable_irq(to->clkevt.irq);
> +
> +	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
> +					1, /* min */
> +					0x1fffffff); /* 29 bits */
>  
> -	timer_shutdown(evt);
> -	timer_writel(reg, TIMER3_BASE + TIMER_PTV);
>  	return 0;
>  }
>  
> -static struct clock_event_device tegra_clockevent = {
> -	.name			= "timer0",
> -	.rating			= 300,
> -	.features		= CLOCK_EVT_FEAT_ONESHOT |
> -				  CLOCK_EVT_FEAT_PERIODIC |
> -				  CLOCK_EVT_FEAT_DYNIRQ,
> -	.set_next_event		= tegra_timer_set_next_event,
> -	.set_state_shutdown	= tegra_timer_shutdown,
> -	.set_state_periodic	= tegra_timer_set_periodic,
> -	.set_state_oneshot	= tegra_timer_shutdown,
> -	.tick_resume		= tegra_timer_shutdown,
> +static int tegra_timer_stop(unsigned int cpu)
> +{
> +	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
> +
> +	to->clkevt.set_state_shutdown(&to->clkevt);
> +	disable_irq_nosync(to->clkevt.irq);
> +
> +	return 0;
> +}
> +#else /* CONFIG_ARM */
> +static struct timer_of tegra_to = {
> +	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE | TIMER_OF_IRQ,
> +
> +	.clkevt = {
> +		.name = "tegra_timer",
> +		.rating	= 300,
> +		.features = CLOCK_EVT_FEAT_ONESHOT |
> +			    CLOCK_EVT_FEAT_PERIODIC |
> +			    CLOCK_EVT_FEAT_DYNIRQ,
> +		.set_next_event	= tegra_timer_set_next_event,
> +		.set_state_shutdown = tegra_timer_shutdown,
> +		.set_state_periodic = tegra_timer_set_periodic,
> +		.set_state_oneshot = tegra_timer_shutdown,
> +		.tick_resume = tegra_timer_shutdown,
> +		.suspend = tegra_timer_suspend,
> +		.resume = tegra_timer_resume,
> +		.cpumask = cpu_possible_mask,
> +	},
> +
> +	.of_irq = {
> +		.index = 2,
> +		.flags = IRQF_TIMER | IRQF_TRIGGER_HIGH,
> +		.handler = tegra_timer_isr,
> +	},
>  };
>  
>  static u64 notrace tegra_read_sched_clock(void)
>  {
> -	return timer_readl(TIMERUS_CNTR_1US);
> +	return readl(timer_reg_base + TIMERUS_CNTR_1US);
> +}
> +
> +static unsigned long tegra_delay_timer_read_counter_long(void)
> +{
> +	return readl(timer_reg_base + TIMERUS_CNTR_1US);
>  }
>  
>  /*
> @@ -143,100 +233,155 @@ static void tegra_read_persistent_clock64(struct timespec64 *ts)
>  	timespec64_add_ns(&persistent_ts, delta * NSEC_PER_MSEC);
>  	*ts = persistent_ts;
>  }
> +#endif
>  
> -static unsigned long tegra_delay_timer_read_counter_long(void)
> -{
> -	return readl(timer_reg_base + TIMERUS_CNTR_1US);
> -}
> -
> -static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id)
> -{
> -	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
> -	timer_writel(1<<30, TIMER3_BASE + TIMER_PCR);
> -	evt->event_handler(evt);
> -	return IRQ_HANDLED;
> -}
> -
> -static struct irqaction tegra_timer_irq = {
> -	.name		= "timer0",
> -	.flags		= IRQF_TIMER | IRQF_TRIGGER_HIGH,
> -	.handler	= tegra_timer_interrupt,
> -	.dev_id		= &tegra_clockevent,
> -};
> -
> -static int __init tegra20_init_timer(struct device_node *np)
> +static int tegra_timer_common_init(struct device_node *np, struct timer_of *to)
>  {
> -	struct clk *clk;
> -	unsigned long rate;
> -	int ret;
> -
> -	timer_reg_base = of_iomap(np, 0);
> -	if (!timer_reg_base) {
> -		pr_err("Can't map timer registers\n");
> -		return -ENXIO;
> -	}
> +	int ret = 0;
>  
> -	tegra_timer_irq.irq = irq_of_parse_and_map(np, 2);
> -	if (tegra_timer_irq.irq <= 0) {
> -		pr_err("Failed to map timer IRQ\n");
> -		return -EINVAL;
> -	}
> +	ret = timer_of_init(np, to);
> +	if (ret < 0)
> +		goto out;
>  
> -	clk = of_clk_get(np, 0);
> -	if (IS_ERR(clk)) {
> -		pr_warn("Unable to get timer clock. Assuming 12Mhz input clock.\n");
> -		rate = 12000000;
> -	} else {
> -		clk_prepare_enable(clk);
> -		rate = clk_get_rate(clk);
> -	}
> +	timer_reg_base = timer_of_base(to);
>  
> -	switch (rate) {
> +	/*
> +	 * Configure microsecond timers to have 1MHz clock
> +	 * Config register is 0xqqww, where qq is "dividend", ww is "divisor"
> +	 * Uses n+1 scheme
> +	 */
> +	switch (timer_of_rate(to)) {
>  	case 12000000:
> -		timer_writel(0x000b, TIMERUS_USEC_CFG);
> +		usec_config = 0x000b; /* (11+1)/(0+1) */
> +		break;
> +	case 12800000:
> +		usec_config = 0x043f; /* (63+1)/(4+1) */
>  		break;
>  	case 13000000:
> -		timer_writel(0x000c, TIMERUS_USEC_CFG);
> +		usec_config = 0x000c; /* (12+1)/(0+1) */
> +		break;
> +	case 16800000:
> +		usec_config = 0x0453; /* (83+1)/(4+1) */
>  		break;
>  	case 19200000:
> -		timer_writel(0x045f, TIMERUS_USEC_CFG);
> +		usec_config = 0x045f; /* (95+1)/(4+1) */
>  		break;
>  	case 26000000:
> -		timer_writel(0x0019, TIMERUS_USEC_CFG);
> +		usec_config = 0x0019; /* (25+1)/(0+1) */
> +		break;
> +	case 38400000:
> +		usec_config = 0x04bf; /* (191+1)/(4+1) */
> +		break;
> +	case 48000000:
> +		usec_config = 0x002f; /* (47+1)/(0+1) */
>  		break;
>  	default:
> -		WARN(1, "Unknown clock rate");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	writel(usec_config, timer_of_base(to) + TIMERUS_USEC_CFG);
> +
> +out:
> +	return ret;
> +}
> +
> +#ifdef CONFIG_ARM64
> +static int __init tegra_init_timer(struct device_node *np)
> +{
> +	int cpu, ret = 0;
> +	struct timer_of *to;
> +
> +	to = this_cpu_ptr(&tegra_to);
> +	ret = tegra_timer_common_init(np, to);
> +	if (ret < 0)
> +		goto out;
> +
> +	for_each_possible_cpu(cpu) {
> +		struct timer_of *cpu_to;
> +
> +		cpu_to = per_cpu_ptr(&tegra_to, cpu);
> +		cpu_to->of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(cpu);
> +		cpu_to->of_clk.rate = timer_of_rate(to);
> +		cpu_to->clkevt.cpumask = cpumask_of(cpu);
> +		cpu_to->clkevt.irq =
> +			irq_of_parse_and_map(np, IRQ_IDX_FOR_CPU(cpu));
> +		if (!cpu_to->clkevt.irq) {
> +			pr_err("%s: can't map IRQ for CPU%d\n",
> +			       __func__, cpu);
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
> +		ret = request_irq(cpu_to->clkevt.irq, tegra_timer_isr,
> +				  IRQF_TIMER | IRQF_NOBALANCING,
> +				  cpu_to->clkevt.name, &cpu_to->clkevt);
> +		if (ret) {
> +			pr_err("%s: cannot setup irq %d for CPU%d\n",
> +				__func__, cpu_to->clkevt.irq, cpu);
> +			ret = -EINVAL;
> +			goto out_irq;
> +		}
> +	}
> +
> +	cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
> +			  "AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
> +			  tegra_timer_stop);
> +
> +	return ret;
> +out_irq:
> +	for_each_possible_cpu(cpu) {
> +		struct timer_of *cpu_to;
> +
> +		cpu_to = per_cpu_ptr(&tegra_to, cpu);
> +		if (cpu_to->clkevt.irq) {
> +			free_irq(cpu_to->clkevt.irq, &cpu_to->clkevt);
> +			irq_dispose_mapping(cpu_to->clkevt.irq);
> +		}
>  	}
> +out:
> +	timer_of_cleanup(to);
> +	return ret;
> +}
> +#else /* CONFIG_ARM */
> +static int __init tegra_init_timer(struct device_node *np)
> +{
> +	int ret = 0;
> +
> +	ret = tegra_timer_common_init(np, &tegra_to);
> +	if (ret < 0)
> +		goto out;
>  
> -	sched_clock_register(tegra_read_sched_clock, 32, 1000000);
> +	tegra_to.of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(0);
> +	tegra_to.of_clk.rate = 1000000; /* microsecond timer */
>  
> +	sched_clock_register(tegra_read_sched_clock, 32,
> +			     timer_of_rate(&tegra_to));
>  	ret = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
> -				    "timer_us", 1000000, 300, 32,
> -				    clocksource_mmio_readl_up);
> +				    "timer_us", timer_of_rate(&tegra_to),
> +				    300, 32, clocksource_mmio_readl_up);
>  	if (ret) {
>  		pr_err("Failed to register clocksource\n");
> -		return ret;
> +		goto out;
>  	}
>  
>  	tegra_delay_timer.read_current_timer =
>  			tegra_delay_timer_read_counter_long;
> -	tegra_delay_timer.freq = 1000000;
> +	tegra_delay_timer.freq = timer_of_rate(&tegra_to);
>  	register_current_timer_delay(&tegra_delay_timer);
>  
> -	ret = setup_irq(tegra_timer_irq.irq, &tegra_timer_irq);
> -	if (ret) {
> -		pr_err("Failed to register timer IRQ: %d\n", ret);
> -		return ret;
> -	}
> +	clockevents_config_and_register(&tegra_to.clkevt,
> +					timer_of_rate(&tegra_to),
> +					0x1,
> +					0x1fffffff);
>  
> -	tegra_clockevent.cpumask = cpu_possible_mask;
> -	tegra_clockevent.irq = tegra_timer_irq.irq;
> -	clockevents_config_and_register(&tegra_clockevent, 1000000,
> -					0x1, 0x1fffffff);
> +	return ret;
> +out:
> +	timer_of_cleanup(&tegra_to);
>  
> -	return 0;
> +	return ret;
>  }
> -TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
>  
>  static int __init tegra20_init_rtc(struct device_node *np)
>  {
> @@ -261,3 +406,6 @@ static int __init tegra20_init_rtc(struct device_node *np)
>  	return register_persistent_clock(tegra_read_persistent_clock64);
>  }
>  TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
> +#endif
> +TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra_init_timer);
> +TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra_init_timer);
> diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
> index fe4481676da6..a0b03443d8c1 100644
> --- a/drivers/soc/tegra/Kconfig
> +++ b/drivers/soc/tegra/Kconfig
> @@ -76,6 +76,7 @@ config ARCH_TEGRA_210_SOC
>  	select PINCTRL_TEGRA210
>  	select SOC_TEGRA_FLOWCTRL
>  	select SOC_TEGRA_PMC
> +	select TEGRA_TIMER
>  	help
>  	  Enable support for the NVIDIA Tegra210 SoC. Also known as Tegra X1,
>  	  the Tegra210 has four Cortex-A57 cores paired with four Cortex-A53
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index fd586d0301e7..e78281d07b70 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -121,6 +121,7 @@ enum cpuhp_state {
>  	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>  	CPUHP_AP_ARM_TWD_STARTING,
>  	CPUHP_AP_QCOM_TIMER_STARTING,
> +	CPUHP_AP_TEGRA_TIMER_STARTING,
>  	CPUHP_AP_ARMADA_TIMER_STARTING,
>  	CPUHP_AP_MARCO_TIMER_STARTING,
>  	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
> diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
> index e96581ca7c9d..b20798fc5191 100644
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -12,7 +12,7 @@ struct siginfo;
>  
>  struct cpu_timer_list {
>  	struct list_head entry;
> -	u64 expires, incr;
> +	u64 expires;
>  	struct task_struct *task;
>  	int firing;
>  };
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 939a2056c87a..37301430970e 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -87,36 +87,6 @@ config RCU_STALL_COMMON
>  config RCU_NEED_SEGCBLIST
>  	def_bool ( TREE_RCU || PREEMPT_RCU || TREE_SRCU )
>  
> -config CONTEXT_TRACKING
> -       bool
> -
> -config CONTEXT_TRACKING_FORCE
> -	bool "Force context tracking"
> -	depends on CONTEXT_TRACKING
> -	default y if !NO_HZ_FULL
> -	help
> -	  The major pre-requirement for full dynticks to work is to
> -	  support the context tracking subsystem. But there are also
> -	  other dependencies to provide in order to make the full
> -	  dynticks working.
> -
> -	  This option stands for testing when an arch implements the
> -	  context tracking backend but doesn't yet fullfill all the
> -	  requirements to make the full dynticks feature working.
> -	  Without the full dynticks, there is no way to test the support
> -	  for context tracking and the subsystems that rely on it: RCU
> -	  userspace extended quiescent state and tickless cputime
> -	  accounting. This option copes with the absence of the full
> -	  dynticks subsystem by forcing the context tracking on all
> -	  CPUs in the system.
> -
> -	  Say Y only if you're working on the development of an
> -	  architecture backend for the context tracking.
> -
> -	  Say N otherwise, this option brings an overhead that you
> -	  don't want in production.
> -
> -
>  config RCU_FANOUT
>  	int "Tree-based hierarchical RCU fanout value"
>  	range 2 64 if 64BIT
> diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
> index 58b981f4bb5d..e2c038d6c13c 100644
> --- a/kernel/time/Kconfig
> +++ b/kernel/time/Kconfig
> @@ -117,6 +117,35 @@ config NO_HZ_FULL
>  
>  endchoice
>  
> +config CONTEXT_TRACKING
> +       bool
> +
> +config CONTEXT_TRACKING_FORCE
> +	bool "Force context tracking"
> +	depends on CONTEXT_TRACKING
> +	default y if !NO_HZ_FULL
> +	help
> +	  The major pre-requirement for full dynticks to work is to
> +	  support the context tracking subsystem. But there are also
> +	  other dependencies to provide in order to make the full
> +	  dynticks working.
> +
> +	  This option stands for testing when an arch implements the
> +	  context tracking backend but doesn't yet fullfill all the
> +	  requirements to make the full dynticks feature working.
> +	  Without the full dynticks, there is no way to test the support
> +	  for context tracking and the subsystems that rely on it: RCU
> +	  userspace extended quiescent state and tickless cputime
> +	  accounting. This option copes with the absence of the full
> +	  dynticks subsystem by forcing the context tracking on all
> +	  CPUs in the system.
> +
> +	  Say Y only if you're working on the development of an
> +	  architecture backend for the context tracking.
> +
> +	  Say N otherwise, this option brings an overhead that you
> +	  don't want in production.
> +
>  config NO_HZ
>  	bool "Old Idle dynticks config"
>  	depends on !ARCH_USES_GETTIMEOFFSET && GENERIC_CLOCKEVENTS
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index f5cfa1b73d6f..6418e1bdc549 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -364,7 +364,7 @@ static bool hrtimer_fixup_activate(void *addr, enum debug_obj_state state)
>  	switch (state) {
>  	case ODEBUG_STATE_ACTIVE:
>  		WARN_ON(1);
> -
> +		/* fall through */
>  	default:
>  		return false;
>  	}
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index 80f955210861..0a426f4e3125 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -67,13 +67,13 @@ static void bump_cpu_timer(struct k_itimer *timer, u64 now)
>  	int i;
>  	u64 delta, incr;
>  
> -	if (timer->it.cpu.incr == 0)
> +	if (!timer->it_interval)
>  		return;
>  
>  	if (now < timer->it.cpu.expires)
>  		return;
>  
> -	incr = timer->it.cpu.incr;
> +	incr = timer->it_interval;
>  	delta = now + incr - timer->it.cpu.expires;
>  
>  	/* Don't use (incr*2 < delta), incr*2 might overflow. */
> @@ -520,7 +520,7 @@ static void cpu_timer_fire(struct k_itimer *timer)
>  		 */
>  		wake_up_process(timer->it_process);
>  		timer->it.cpu.expires = 0;
> -	} else if (timer->it.cpu.incr == 0) {
> +	} else if (!timer->it_interval) {
>  		/*
>  		 * One-shot timer.  Clear it as soon as it's fired.
>  		 */
> @@ -606,7 +606,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
>  	 */
>  
>  	ret = 0;
> -	old_incr = timer->it.cpu.incr;
> +	old_incr = timer->it_interval;
>  	old_expires = timer->it.cpu.expires;
>  	if (unlikely(timer->it.cpu.firing)) {
>  		timer->it.cpu.firing = -1;
> @@ -684,8 +684,7 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
>  	 * Install the new reload setting, and
>  	 * set up the signal and overrun bookkeeping.
>  	 */
> -	timer->it.cpu.incr = timespec64_to_ns(&new->it_interval);
> -	timer->it_interval = ns_to_ktime(timer->it.cpu.incr);
> +	timer->it_interval = timespec64_to_ktime(new->it_interval);
>  
>  	/*
>  	 * This acts as a modification timestamp for the timer,
> @@ -724,7 +723,7 @@ static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp
>  	/*
>  	 * Easy part: convert the reload time.
>  	 */
> -	itp->it_interval = ns_to_timespec64(timer->it.cpu.incr);
> +	itp->it_interval = ktime_to_timespec64(timer->it_interval);
>  
>  	if (!timer->it.cpu.expires)
>  		return;
> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> index 803fa67aace9..ee834d4fb814 100644
> --- a/kernel/time/tick-broadcast.c
> +++ b/kernel/time/tick-broadcast.c
> @@ -375,6 +375,7 @@ void tick_broadcast_control(enum tick_broadcast_mode mode)
>  	switch (mode) {
>  	case TICK_BROADCAST_FORCE:
>  		tick_broadcast_forced = 1;
> +		/* fall through */
>  	case TICK_BROADCAST_ON:
>  		cpumask_set_cpu(cpu, tick_broadcast_on);
>  		if (!cpumask_test_and_set_cpu(cpu, tick_broadcast_mask)) {
> diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
> index 86489950d690..b73e8850e58d 100644
> --- a/kernel/time/timekeeping_debug.c
> +++ b/kernel/time/timekeeping_debug.c
> @@ -37,15 +37,8 @@ DEFINE_SHOW_ATTRIBUTE(tk_debug_sleep_time);
>  
>  static int __init tk_debug_sleep_time_init(void)
>  {
> -	struct dentry *d;
> -
> -	d = debugfs_create_file("sleep_time", 0444, NULL, NULL,
> -		&tk_debug_sleep_time_fops);
> -	if (!d) {
> -		pr_err("Failed to create sleep_time debug file\n");
> -		return -ENOMEM;
> -	}
> -
> +	debugfs_create_file("sleep_time", 0444, NULL, NULL,
> +			    &tk_debug_sleep_time_fops);
>  	return 0;
>  }
>  late_initcall(tk_debug_sleep_time_init);
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 444156debfa0..167e71f9ed3c 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -647,7 +647,7 @@ static bool timer_fixup_activate(void *addr, enum debug_obj_state state)
>  
>  	case ODEBUG_STATE_ACTIVE:
>  		WARN_ON(1);
> -
> +		/* fall through */
>  	default:
>  		return false;
>  	}
> 
