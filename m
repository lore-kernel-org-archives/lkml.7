Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DF5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6709B22DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tposMaif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfHTOzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:55:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36156 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfHTOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:55:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id r3so12751215wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 07:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zZepwu9ueKEOx+fYqmSpoK5g7HYyUbH4KWMECFWOdXU=;
        b=tposMaifZ4yckMr/uXwvNYEb9viI167UgXc0+QSJe2vsGZAvXR1PxA9xww65M68zhx
         nHjdM9vFnE/DID1v81OAp5In+uv2Naq++AGPMeH6tsl4YTslwn3fOcETdugZM4JrimEf
         YtjFXRHHvve29I9zGlYvxuemmLH0KYGHF/tSWNNomgleo8DD26+rTf3nvlW4s+d1bqyt
         E4RnqLDCNwAgKUOG+Z6KcMJxEIIGhG9pR3BU3M2j1LQacqnsfjX8aQaTn3qmALCv6hqu
         f7nTUbFsGfJhcYWvmC++KN4P36F80mCnH+gZUtN7anaZhVms1QTF6A2Fcd1FPZ15wmfs
         7g0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zZepwu9ueKEOx+fYqmSpoK5g7HYyUbH4KWMECFWOdXU=;
        b=F8gIZAjAyVk5cZ2gzK2p53Y2Ijmid6SJEWLthP0hdiQTW3PdPl+IqLEceWoR/TsTUH
         aSqCmhCdff8YoRcY7eViwVV6qM+FlPgCeMZC9+MaxOhhg2OwUCxIwMBRWWPPEZAxRni0
         rGr6a/dfp95U48xT6DPmQt4V5cUe9wNbBJnZLQplMjwI9OMfYv0xWC/sUPBw95YEiPIH
         h+f9FcTT8kELLh1s4sQVcr+uH3/aRjO07Va/i+GYLcRVHn/AXgqw84ZUceeRJQzWTWJd
         pnPoopon2tVwO2k6GbD8w4YgzjWzBmZxmZzpSLPMi241wczI9SL267HeUb91/6bRVnXP
         f4hg==
X-Gm-Message-State: APjAAAVLfpyYIGfgUdQrXplkJ1PjZBeNt6MqpLsb3M8YlRoOACmx+V7Y
        wpuGy0PqmsJldKjmraKg1iRWfmkuD7Pa1A==
X-Google-Smtp-Source: APXvYqyVV9STfrHmB0MpI1nYhPbNbC/FZfvcSzifiQ4xXgnsgfCDp6k+ftvdfOZh9QaJIyxRu2Up1g==
X-Received: by 2002:adf:fc51:: with SMTP id e17mr34586492wrs.348.1566312946192;
        Tue, 20 Aug 2019 07:55:46 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 24sm151066wmf.10.2019.08.20.07.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 07:55:45 -0700 (PDT)
Subject: Re: [RFC 04/11] soc: amlogic: Add support for SM1 power controller
To:     Kevin Hilman <khilman@baylibre.com>, jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190701104705.18271-1-narmstrong@baylibre.com>
 <20190701104705.18271-5-narmstrong@baylibre.com>
 <7hftlwvhdk.fsf@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <98bda35e-1b4c-404c-fdbd-eaef9ecf38a6@baylibre.com>
Date:   Tue, 20 Aug 2019 16:55:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7hftlwvhdk.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2019 01:56, Kevin Hilman wrote:
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> Add support for the General Purpose Amlogic SM1 Power controller,
>> dedicated to the PCIe, USB, NNA and GE2D Power Domains.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> I like this driver in general, but as I look at all the EE power domains
> for GX, G12 and SM1 they are really very similar.  I had started to
> generalize the gx-pwrc-vpu driver and it ends up looking just like this.

Yes I developed it to be generic, but when starting to fill up the GXBB/GXL/G12A
domains, except the VPU, they only need the PD parts.

> 
> I think this driver could be generalized just a little bit more and then
> replace the the GX-specific VPU one, and AFAICT, then be used across all
> the 64-bit SoCs, and be called "meson-pwrc-ee" or something like that...
> 
>> ---
>>  drivers/soc/amlogic/Kconfig          |  11 ++
>>  drivers/soc/amlogic/Makefile         |   1 +
>>  drivers/soc/amlogic/meson-sm1-pwrc.c | 245 +++++++++++++++++++++++++++
>>  3 files changed, 257 insertions(+)
>>  create mode 100644 drivers/soc/amlogic/meson-sm1-pwrc.c
>>
>> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
>> index 5501ad5650b2..596f1afef1a7 100644
>> --- a/drivers/soc/amlogic/Kconfig
>> +++ b/drivers/soc/amlogic/Kconfig
>> @@ -36,6 +36,17 @@ config MESON_GX_PM_DOMAINS
>>  	  Say yes to expose Amlogic Meson GX Power Domains as
>>  	  Generic Power Domains.
>>  
>> +config MESON_SM1_PM_DOMAINS
>> +	bool "Amlogic Meson SM1 Power Domains driver"
>> +	depends on ARCH_MESON || COMPILE_TEST
>> +	depends on PM && OF
>> +	default ARCH_MESON
>> +	select PM_GENERIC_DOMAINS
>> +	select PM_GENERIC_DOMAINS_OF
>> +	help
>> +	  Say yes to expose Amlogic Meson SM1 Power Domains as
>> +	  Generic Power Domains.
>> +
>>  config MESON_MX_SOCINFO
>>  	bool "Amlogic Meson MX SoC Information driver"
>>  	depends on ARCH_MESON || COMPILE_TEST
>> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
>> index bf2d109f61e9..f99935499ee6 100644
>> --- a/drivers/soc/amlogic/Makefile
>> +++ b/drivers/soc/amlogic/Makefile
>> @@ -3,3 +3,4 @@ obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
>>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
>> +obj-$(CONFIG_MESON_SM1_PM_DOMAINS) += meson-sm1-pwrc.o
>> diff --git a/drivers/soc/amlogic/meson-sm1-pwrc.c b/drivers/soc/amlogic/meson-sm1-pwrc.c
>> new file mode 100644
>> index 000000000000..9ece1d06f417
>> --- /dev/null
>> +++ b/drivers/soc/amlogic/meson-sm1-pwrc.c
>> @@ -0,0 +1,245 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (c) 2017 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/regmap.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/of_device.h>
>> +#include <dt-bindings/power/meson-sm1-power.h>
>> +
>> +/* AO Offsets */
>> +
>> +#define AO_RTI_GEN_PWR_SLEEP0		(0x3a << 2)
>> +#define AO_RTI_GEN_PWR_ISO0		(0x3b << 2)
>> +
>> +/* HHI Offsets */
>> +
>> +#define HHI_MEM_PD_REG0			(0x40 << 2)
>> +#define HHI_NANOQ_MEM_PD_REG0		(0x46 << 2)
>> +#define HHI_NANOQ_MEM_PD_REG1		(0x47 << 2)
>> +
>> +struct meson_sm1_pwrc;
>> +
>> +struct meson_sm1_pwrc_mem_domain {
>> +	unsigned int reg;
>> +	unsigned int mask;
>> +};
>> +
>> +struct meson_sm1_pwrc_domain_desc {
>> +	char *name;
>> +	unsigned int sleep_reg;
>> +	unsigned int sleep_bit;
>> +	unsigned int iso_reg;
>> +	unsigned int iso_bit;
>> +	unsigned int mem_pd_count;
>> +	struct meson_sm1_pwrc_mem_domain *mem_pd;
>> +};
> 
> If you add resets and clocks (using clk bulk like my other proposed
> patch to gx-pwrc-vpu) then this could be used for VPU also.  We could
> ignore my clk bulk patch and then just deprecate the old driver and use
> this one for everything.
> 
> We would just need SoC-specific tables selected by compatible-string to
> select the memory pds, and the clocks and resets could (optionaly) come
> from the DT.

Could you elaborate ?

Do you mean I should slit out the memory PDs as different compatible ?

Let me try to fit the VPU stuff in it.

Neil

> 
> Kevin
> 

