Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA5CC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3783F2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOgaur2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfFQPDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:03:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34830 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQPDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:03:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so9500078wml.0;
        Mon, 17 Jun 2019 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LR24wm1rNjfsPVoVHtV4Ol9fNPWJ0zAe8J/iodtwGIM=;
        b=ZOgaur2AYEGXc61u1bFiDqVmPeqptj73/HdOBo0MqCJ6LSA2N6QyyCwdMkP4I34zPW
         yRgORf9gOlePdG66nj+YVy6mv8x15VGtfUADl5OyapKTA4/uIbSUG1Icsrq2kSyeJzdE
         Xz9C1bawy18CnJt3tZh0PeXMwikyoQt0b91lk/VF/o8vJUvyM1HzHV1OMvbcn5UwxIlZ
         Q3JwE54+Bjcf07EGZqA5WY2L4UP1g+EFDUsPmD5lv+EP30GQmY29HM6tkONNuulnpJmM
         juM3oGenk8AXPYrzsmVnQnpDyUGPIedKZF76hzLZtVROMq5+ltVmy+Z1JSTDcFVxWslZ
         R+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LR24wm1rNjfsPVoVHtV4Ol9fNPWJ0zAe8J/iodtwGIM=;
        b=T+631+Nzb2m/o7Fvm2iTjORetjcaqBya3SVDPNwxFsK44W0WnHo1JGe0AvqleFp9EJ
         DsVrYZbO64c6mzIz4GKJ9HZS/Vo6SlfSY38JUAqc7TfUob5rQqKdH8r1ecvdxjrKdNuM
         VH1Az6GETCo5PWzl/3HVb9xPHzOFZG4oMGkA4ksY9je++88Paqv1PzNtG38e0+G0PKLR
         2wSxFg6OEiY7DRO9DW7uEMnF2Le76kMyx+Ali3f4Vlu34ITNhVjcH2L1xpyvMmADxR4d
         J7f3XwFz76kUKoZm2Q+gxtig7lnLayi3jEvPfUm8EZQQyA1xEEiu6ARt6hgZXL6lxJ/o
         YESQ==
X-Gm-Message-State: APjAAAUKvLKbj+HOeLWOvRy5+lqraygXj+Jb2B4ThzDTydFkSvCNaq8B
        kIXaU7CpQ5tUUsP++BAvyIPiAQv+
X-Google-Smtp-Source: APXvYqx9PSdhUwEy3SQiThix21TFPnn60hA9ABJdkBxgXUrQ8Ht3yZTOoAIO87wRJ+sDmMhE0Pu9TQ==
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr18576955wma.107.1560783784307;
        Mon, 17 Jun 2019 08:03:04 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id a7sm10321430wrs.94.2019.06.17.08.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:03:03 -0700 (PDT)
Subject: Re: [PATCH v4 07/10] memory: tegra: Introduce Tegra30 EMC driver
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
 <20190616233551.6838-8-digetx@gmail.com> <20190617095048.GD508@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1d36d1a4-9d1e-576e-336a-1ea990f92725@gmail.com>
Date:   Mon, 17 Jun 2019 18:03:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617095048.GD508@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2019 12:50, Thierry Reding пишет:
> On Mon, Jun 17, 2019 at 02:35:48AM +0300, Dmitry Osipenko wrote:
>> Introduce driver for the External Memory Controller (EMC) found on Tegra30
>> chips, it controls the external DRAM on the board. The purpose of this
>> driver is to program memory timing for external memory on the EMC clock
>> rate change.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/memory/tegra/Kconfig       |   10 +
>>  drivers/memory/tegra/Makefile      |    1 +
>>  drivers/memory/tegra/mc.c          |    9 +-
>>  drivers/memory/tegra/mc.h          |   30 +-
>>  drivers/memory/tegra/tegra30-emc.c | 1197 ++++++++++++++++++++++++++++
>>  drivers/memory/tegra/tegra30.c     |   44 +
>>  include/soc/tegra/mc.h             |    2 +-
>>  7 files changed, 1278 insertions(+), 15 deletions(-)
>>  create mode 100644 drivers/memory/tegra/tegra30-emc.c
>>
>> diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
>> index 4680124ddcab..fbfbaada61a2 100644
>> --- a/drivers/memory/tegra/Kconfig
>> +++ b/drivers/memory/tegra/Kconfig
>> @@ -17,6 +17,16 @@ config TEGRA20_EMC
>>  	  This driver is required to change memory timings / clock rate for
>>  	  external memory.
>>  
>> +config TEGRA30_EMC
>> +	bool "NVIDIA Tegra30 External Memory Controller driver"
>> +	default y
>> +	depends on TEGRA_MC && ARCH_TEGRA_3x_SOC
>> +	help
>> +	  This driver is for the External Memory Controller (EMC) found on
>> +	  Tegra30 chips. The EMC controls the external DRAM on the board.
>> +	  This driver is required to change memory timings / clock rate for
>> +	  external memory.
>> +
>>  config TEGRA124_EMC
>>  	bool "NVIDIA Tegra124 External Memory Controller driver"
>>  	default y
>> diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
>> index 3971a6b7c487..3d23c4261104 100644
>> --- a/drivers/memory/tegra/Makefile
>> +++ b/drivers/memory/tegra/Makefile
>> @@ -11,5 +11,6 @@ tegra-mc-$(CONFIG_ARCH_TEGRA_210_SOC) += tegra210.o
>>  obj-$(CONFIG_TEGRA_MC) += tegra-mc.o
>>  
>>  obj-$(CONFIG_TEGRA20_EMC)  += tegra20-emc.o
>> +obj-$(CONFIG_TEGRA30_EMC)  += tegra30-emc.o
>>  obj-$(CONFIG_TEGRA124_EMC) += tegra124-emc.o
>>  obj-$(CONFIG_ARCH_TEGRA_186_SOC) += tegra186.o
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index 163b6c69e651..eaebe371625c 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -51,9 +51,6 @@
>>  #define MC_EMEM_ADR_CFG 0x54
>>  #define MC_EMEM_ADR_CFG_EMEM_NUMDEV BIT(0)
>>  
>> -#define MC_TIMING_CONTROL		0xfc
>> -#define MC_TIMING_UPDATE		BIT(0)
>> -
>>  static const struct of_device_id tegra_mc_of_match[] = {
>>  #ifdef CONFIG_ARCH_TEGRA_2x_SOC
>>  	{ .compatible = "nvidia,tegra20-mc-gart", .data = &tegra20_mc_soc },
>> @@ -310,7 +307,7 @@ static int tegra_mc_setup_latency_allowance(struct tegra_mc *mc)
>>  	return 0;
>>  }
>>  
>> -void tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate)
>> +int tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate)
>>  {
>>  	unsigned int i;
>>  	struct tegra_mc_timing *timing = NULL;
>> @@ -325,11 +322,13 @@ void tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate)
>>  	if (!timing) {
>>  		dev_err(mc->dev, "no memory timing registered for rate %lu\n",
>>  			rate);
>> -		return;
>> +		return -EINVAL;
>>  	}
>>  
>>  	for (i = 0; i < mc->soc->num_emem_regs; ++i)
>>  		mc_writel(mc, timing->emem_data[i], mc->soc->emem_regs[i]);
>> +
>> +	return 0;
>>  }
>>  
>>  unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc)
>> diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
>> index 392993955c93..0720a1d2023e 100644
>> --- a/drivers/memory/tegra/mc.h
>> +++ b/drivers/memory/tegra/mc.h
>> @@ -9,20 +9,32 @@
>>  #ifndef MEMORY_TEGRA_MC_H
>>  #define MEMORY_TEGRA_MC_H
>>  
>> +#include <linux/bits.h>
>>  #include <linux/io.h>
>>  #include <linux/types.h>
>>  
>>  #include <soc/tegra/mc.h>
>>  
>> -#define MC_INT_DECERR_MTS (1 << 16)
>> -#define MC_INT_SECERR_SEC (1 << 13)
>> -#define MC_INT_DECERR_VPR (1 << 12)
>> -#define MC_INT_INVALID_APB_ASID_UPDATE (1 << 11)
>> -#define MC_INT_INVALID_SMMU_PAGE (1 << 10)
>> -#define MC_INT_ARBITRATION_EMEM (1 << 9)
>> -#define MC_INT_SECURITY_VIOLATION (1 << 8)
>> -#define MC_INT_INVALID_GART_PAGE (1 << 7)
>> -#define MC_INT_DECERR_EMEM (1 << 6)
>> +#define MC_INT_DECERR_MTS				BIT(16)
>> +#define MC_INT_SECERR_SEC				BIT(13)
>> +#define MC_INT_DECERR_VPR				BIT(12)
>> +#define MC_INT_INVALID_APB_ASID_UPDATE			BIT(11)
>> +#define MC_INT_INVALID_SMMU_PAGE			BIT(10)
>> +#define MC_INT_ARBITRATION_EMEM				BIT(9)
>> +#define MC_INT_SECURITY_VIOLATION			BIT(8)
>> +#define MC_INT_INVALID_GART_PAGE			BIT(7)
>> +#define MC_INT_DECERR_EMEM				BIT(6)
> 
> This /could/ be a separate patch, with it being unrelated to the EMC
> support, but probably not worth it.

I had the same feeling about this change and decided that it's not really worth it.

>> +#define MC_EMEM_ARB_OUTSTANDING_REQ			0x94
>> +#define MC_EMEM_ARB_OUTSTANDING_REQ_MAX_MASK		0x1ff
>> +#define MC_EMEM_ARB_OUTSTANDING_REQ_HOLDOFF_OVERRIDE	BIT(30)
>> +#define MC_EMEM_ARB_OUTSTANDING_REQ_LIMIT_ENABLE	BIT(31)
>> +
>> +#define MC_EMEM_ARB_OVERRIDE				0xe8
>> +#define MC_EMEM_ARB_OVERRIDE_EACK_MASK			0x3
>> +
>> +#define MC_TIMING_CONTROL				0xfc
>> +#define MC_TIMING_UPDATE				BIT(0)
>>  
>>  static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
>>  {
>> diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
>> new file mode 100644
>> index 000000000000..4700f7c8022e
>> --- /dev/null
>> +++ b/drivers/memory/tegra/tegra30-emc.c
>> @@ -0,0 +1,1197 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Tegra30 External Memory Controller driver
>> + *
>> + * Author: Dmitry Osipenko <digetx@gmail.com>
>> + */
> 
> Copyright?
> 
> Otherwise looks good to me.

Okay!
