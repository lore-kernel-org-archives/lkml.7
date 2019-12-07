Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DEDC2BBE2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E1D2176D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FdznrPU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLGTWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 14:22:09 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3341 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfLGTWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 14:22:08 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5debfbd90000>; Sat, 07 Dec 2019 11:22:01 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 07 Dec 2019 11:22:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 07 Dec 2019 11:22:06 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Dec
 2019 19:22:06 +0000
Received: from [10.2.171.190] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 7 Dec 2019
 19:22:02 +0000
Subject: Re: [PATCH v3 00/15] Move PMC clocks into Tegra PMC driver
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <allison@lohutok.net>,
        <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <mturquette@baylibre.com>, <horms+renesas@verge.net.au>,
        <Jisheng.Zhang@synaptics.com>, <krzk@kernel.org>, <arnd@arndb.de>,
        <spujar@nvidia.com>, <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alexios.zavras@intel.com>, <alsa-devel@alsa-project.org>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <dfda896d-27f3-7185-146e-4f697d823471@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <051e4583-2339-1686-302c-9cd50361dea7@nvidia.com>
Date:   Sat, 7 Dec 2019 11:22:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <dfda896d-27f3-7185-146e-4f697d823471@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575746521; bh=JNjkxIeCHLbThMXypdXAOKwNfRMRolpyxtkBVxaf8bE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=FdznrPU0yseir7g5UJM1GXkstLcCZvRNhuThXdlM1i8v/sJraKGwJwX/BrDL5elz2
         Otd3jFx/QoNxsI47wdb/BZTiEbN6A76YIkuDJ1nzuXme/9pJZrEbR/atwLlNJGq2nY
         geWdaYXGVJG+Gg3G7CS7pOAMmAMSxqs3sk5Kx1kqGkAjVa87q28m7teTgfgUVYdb1e
         B1q0LCzDEQ0JFFbF7ucSXQ8ytlmx3rhZo5GJR3MWyz8mXFGYiapU0xot+OLR/DxSDD
         YZq8mYzLO91LpboZpI+K36nmbX6tIhaCiBngK1ijmvcF0iR2jsg8EDipPa/jKspint
         FqFxm9h6u364w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/7/19 6:26 AM, Dmitry Osipenko wrote:
> 06.12.2019 05:48, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls which
>> are currently registered by Tegra clock driver using clk_regiser_mux and
>> clk_register_gate which performs direct Tegra PMC register access.
>>
>> When Tegra PMC is in secure mode, any access from non-secure world will
>> not go through.
>>
>> This patch series adds these Tegra PMC clocks and blink controls to Tegr=
a
>> PMC driver with PMC as clock provider and removed them from Tegra clock
>> driver. This also adds PMC specific clock id's to use in device tree and
>> removed clock ids of PMC clock from Tegra clock driver.
>>
>> clk_out_1 is dedicated for audio mclk and current ASoC driver does not
>> setting extern1 as parent for clk_out_1 and enabling clk_out_1 and
>> currently this is taken care by Tegra clock driver during clock inits
>> and there is no need to enable this during clock init.
>>
>> So, this series also includes patch that updates ASoC driver to take
>> care of configuring parent of mclk and enabling mclk using both extern1
>> and clk_out_1 and updates all device trees to use clk_out_1 from pmc as
>> mclk incase if device tree don't specify assigned-clock-parents.
>>
>> This series also includes a patch for mclk fallback to use extern1
>> when retrieving mclk fails with new device tree which uses pmc provider
>> to have this backward compatible of new DT with old kernels.
>>
>> This series also includes a patch to remove clock ids for these clocks
>> from clock dt-binding as these clocks are not used in any of the existin=
g
>> device tree except in tegra210-smaug.dts and this series includes a patc=
h
>> to update clock provider from tegra_car to pmc in tegra210-smaug.dts for
>> clk_out_2.
>>
>> [v3]:	Changes between v2 and v3 are
>> 	- Removes set parent of clk_out_1_mux to extern1 and enabling
>> 	  extern1 from the clock driver.
>> 	- Doesn't enable clk_out_1 and blink by default in pmc driver
>> 	- Updates ASoC driver to take care of audio mclk parent
>> 	  configuration incase if device tree don't specify assigned
>> 	  clock parent properties and enables mclk using both clk_out_1
>> 	  and extern1.
>> 	- updates all device trees using extern1 as mclk in sound node
>> 	  to use clk_out_1 from pmc.
>> 	- patch for YAML format pmc dt-binding
>> 	- Includes v2 feedback
>>
>> [v2]:	Changes between v1 and v2 are
>> 	- v2 includes patches for adding clk_out_1, clk_out_2, clk_out_3,
>> 	  blink controls to Tegra PMC driver and removing clk-tegra-pmc.
>> 	- feedback related to pmc clocks in Tegra PMC driver from v1
>> 	- Removed patches for WB0 PLLM overrides and PLLE IDDQ PMC programming
>> 	  by the clock driver using helper functions from Tegra PMC.
>>
>>   	  Note:
>> 	  To use helper functions from PMC driver, PMC early init need to
>> 	  happen prior to using helper functions and these helper functions are
>> 	  for PLLM Override and PLLE IDDQ programming in PMC during PLLM/PLLE
>> 	  clock registration which happen in clock_init prior to Tegra PMC
>> 	  probe.
>> 	  Moving PLLM/PLLE clocks registration to happen after Tegra PMC
>> 	  impacts other clocks EMC, MC and corresponding tegra_emc_init and
>> 	  tegra_mc_init.
>> 	  This implementation of configuring PMC registers thru helper
>> 	  functions in clock driver needs proper changes across PMC, Clock,
>> 	  EMC and MC inits to have it work across all Tegra platforms.
>>
>> 	  Currently PLLM Override is not enabled in the bootloader so proper
>> 	  patches for this fix will be taken care separately.
>>
>> [v1]:	v1 includes patches for below fixes.
>> 	- adding clk_out_1, clk_out_2, clk_out_3, blink controls to Tegra PMC
>> 	  driver and removing clk-tegra-pmc.
>> 	- updated clock provider from tegra_car to pmc in the device tree
>> 	  tegra210-smaug.dts that uses clk_out_2.
>> 	- Added helper functions in PMC driver for WB0 PLLM overrides and PLLE
>> 	  IDDQ programming to use by clock driver and updated clock driver to
>> 	  use these helper functions and removed direct PMC access from clock
>> 	  driver and all pmc base address references in clock driver.
>>
>>
>> Sowjanya Komatineni (15):
>>    dt-bindings: soc: tegra-pmc: Add Tegra PMC clock bindings
>>    dt-bindings: tegra: Convert Tegra PMC bindings to YAML
>>    soc: tegra: Add Tegra PMC clock registrations into PMC driver
>>    dt-bindings: soc: tegra-pmc: Add id for Tegra PMC blink control
>>    soc: pmc: Add blink output clock registration to Tegra PMC
>>    clk: tegra: Remove tegra_pmc_clk_init along with clk ids
>>    dt-bindings: clock: tegra: Remove pmc clock ids from clock dt-binding=
s
>>    ASoC: tegra: Add audio mclk control through clk_out_1 and extern1
>>    ASoC: tegra: Add fallback for audio mclk
>>    clk: tegra: Remove extern1 and cdev1 from clocks inittable
>>    ARM: dts: tegra: Add clock-cells property to pmc
>
>>    arm64: tegra: Add clock-cells property to Tegra PMC node
>>    ARM: tegra: Update sound node clocks in device tree
>>    arm64: tegra: smaug: Change clk_out_2 provider to pmc
>>    ASoC: nau8825: change Tegra clk_out_2 provider from tegra_car to pmc
> Hello Sowjanya,
>
> Something gone wrong with these patches because I didn't receive them
> and don't see them on the ML either.
>
> Also, the list of email correspondents looks a bit too larger. I'm
> pretty sure some of the people do not care much about this series. I
> tend to use script/get_maintainer.pl and then manually pick the relevant
> people for patches.

Not sure what went wrong. I sent this series to all previous mailing=20
list and inaddition added based on get_maintainers scripts for ASoC and=20
device tree related.

Will manually pick and reduce mailing list for next series..

