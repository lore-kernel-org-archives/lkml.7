Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D55C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9DF2339D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="towNl5GI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfHTTTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:19:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45208 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbfHTTTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:19:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so3235629plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=d3xEwsHTmPgqbdVb+zyY04Un4P6jiiCiFWweN/mQiKY=;
        b=towNl5GIX0HZUlEZQQPSdcqGKLHxu01ak6wG6m4xqV0MF6uZFhmtTj6oYHA+gHS/pn
         kPhnZhBjLjY8R/uXQhJbGdHUFfD7YYwOAfidXa8TmMoH5rknmzlBXHCf3hQlUyr5uS7C
         iYG1Bj8YXV+ZifjuoObVGhusuQbtGLbHs8e07tDxtMxCct58Nj3zcUGOrmsm/q8201Id
         V8MePkSYOPEPC208zQ4euGywwLdtgjNM6iji1pXXQdGrcfblp8+GELLaWksCKSB/p0UC
         TtiVWvaJkxdwMIw4U81blOVXv6HR+XZ8KTMQVqgIgioLgLkh6CxCzgMbvqCzIkN8ZaMf
         TNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=d3xEwsHTmPgqbdVb+zyY04Un4P6jiiCiFWweN/mQiKY=;
        b=P9oHfC91EwtVPBmJWjvhZC4lHWZYE4VeU44ofrUnjEpPUb9PSYpnjfB61J1O05dmEf
         chmxfvERVOU8F+Jxn4u2wpI8hZ2kic87eFyFd65ayV1+ggQZzWuPtkpmYKentKLopGv1
         27SIpHvehWG0WUBUvoZT0+Yz0gwQj1xt7y+nnrJINgMX0nFueZhJdU4KzCsbmkHapwnH
         WK2TC46Xv3lEmnT3jK6Qw82C3M3p0ZBHvOt1HyGS61umwFe1s5BFl2oUbspx8QmsM3GO
         kuQEaksofrcHF/V74e2EHVfPL0G8xIkAl0paYJwkyOHVxJRl3IsB6b0Y2+vr/tykYuBC
         t4WA==
X-Gm-Message-State: APjAAAWntizo42c1NsgyPLr5BkzpElkAUPJrl3ig+I9J/YulJNqIfnCj
        oeW915RvQvQlFh+TAnVB9W4m4g==
X-Google-Smtp-Source: APXvYqxkiZWI81IrAJlJc85yafLr/6GYWcmOU3ISRGRFq6Opi4QDH2DCpoiFyPamN/inoEReBVqNKQ==
X-Received: by 2002:a17:902:e489:: with SMTP id cj9mr24496481plb.327.1566328752258;
        Tue, 20 Aug 2019 12:19:12 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id t70sm676845pjb.2.2019.08.20.12.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Aug 2019 12:19:11 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 04/11] soc: amlogic: Add support for SM1 power controller
In-Reply-To: <98bda35e-1b4c-404c-fdbd-eaef9ecf38a6@baylibre.com>
References: <20190701104705.18271-1-narmstrong@baylibre.com> <20190701104705.18271-5-narmstrong@baylibre.com> <7hftlwvhdk.fsf@baylibre.com> <98bda35e-1b4c-404c-fdbd-eaef9ecf38a6@baylibre.com>
Date:   Tue, 20 Aug 2019 12:19:11 -0700
Message-ID: <7hd0gzejbk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 20/08/2019 01:56, Kevin Hilman wrote:
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>> 
>>> Add support for the General Purpose Amlogic SM1 Power controller,
>>> dedicated to the PCIe, USB, NNA and GE2D Power Domains.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> 
>> I like this driver in general, but as I look at all the EE power domains
>> for GX, G12 and SM1 they are really very similar.  I had started to
>> generalize the gx-pwrc-vpu driver and it ends up looking just like this.
>
> Yes I developed it to be generic, but when starting to fill up the GXBB/GXL/G12A
> domains, except the VPU, they only need the PD parts.
>
>> 
>> I think this driver could be generalized just a little bit more and then
>> replace the the GX-specific VPU one, and AFAICT, then be used across all
>> the 64-bit SoCs, and be called "meson-pwrc-ee" or something like that...
>> 
>>> ---
>>>  drivers/soc/amlogic/Kconfig          |  11 ++
>>>  drivers/soc/amlogic/Makefile         |   1 +
>>>  drivers/soc/amlogic/meson-sm1-pwrc.c | 245 +++++++++++++++++++++++++++
>>>  3 files changed, 257 insertions(+)
>>>  create mode 100644 drivers/soc/amlogic/meson-sm1-pwrc.c
>>>
>>> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
>>> index 5501ad5650b2..596f1afef1a7 100644
>>> --- a/drivers/soc/amlogic/Kconfig
>>> +++ b/drivers/soc/amlogic/Kconfig
>>> @@ -36,6 +36,17 @@ config MESON_GX_PM_DOMAINS
>>>  	  Say yes to expose Amlogic Meson GX Power Domains as
>>>  	  Generic Power Domains.
>>>  
>>> +config MESON_SM1_PM_DOMAINS
>>> +	bool "Amlogic Meson SM1 Power Domains driver"
>>> +	depends on ARCH_MESON || COMPILE_TEST
>>> +	depends on PM && OF
>>> +	default ARCH_MESON
>>> +	select PM_GENERIC_DOMAINS
>>> +	select PM_GENERIC_DOMAINS_OF
>>> +	help
>>> +	  Say yes to expose Amlogic Meson SM1 Power Domains as
>>> +	  Generic Power Domains.
>>> +
>>>  config MESON_MX_SOCINFO
>>>  	bool "Amlogic Meson MX SoC Information driver"
>>>  	depends on ARCH_MESON || COMPILE_TEST
>>> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
>>> index bf2d109f61e9..f99935499ee6 100644
>>> --- a/drivers/soc/amlogic/Makefile
>>> +++ b/drivers/soc/amlogic/Makefile
>>> @@ -3,3 +3,4 @@ obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
>>>  obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>>>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>>>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
>>> +obj-$(CONFIG_MESON_SM1_PM_DOMAINS) += meson-sm1-pwrc.o
>>> diff --git a/drivers/soc/amlogic/meson-sm1-pwrc.c b/drivers/soc/amlogic/meson-sm1-pwrc.c
>>> new file mode 100644
>>> index 000000000000..9ece1d06f417
>>> --- /dev/null
>>> +++ b/drivers/soc/amlogic/meson-sm1-pwrc.c
>>> @@ -0,0 +1,245 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright (c) 2017 BayLibre, SAS
>>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>>> + */
>>> +
>>> +#include <linux/of_address.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pm_domain.h>
>>> +#include <linux/bitfield.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/of_device.h>
>>> +#include <dt-bindings/power/meson-sm1-power.h>
>>> +
>>> +/* AO Offsets */
>>> +
>>> +#define AO_RTI_GEN_PWR_SLEEP0		(0x3a << 2)
>>> +#define AO_RTI_GEN_PWR_ISO0		(0x3b << 2)
>>> +
>>> +/* HHI Offsets */
>>> +
>>> +#define HHI_MEM_PD_REG0			(0x40 << 2)
>>> +#define HHI_NANOQ_MEM_PD_REG0		(0x46 << 2)
>>> +#define HHI_NANOQ_MEM_PD_REG1		(0x47 << 2)
>>> +
>>> +struct meson_sm1_pwrc;
>>> +
>>> +struct meson_sm1_pwrc_mem_domain {
>>> +	unsigned int reg;
>>> +	unsigned int mask;
>>> +};
>>> +
>>> +struct meson_sm1_pwrc_domain_desc {
>>> +	char *name;
>>> +	unsigned int sleep_reg;
>>> +	unsigned int sleep_bit;
>>> +	unsigned int iso_reg;
>>> +	unsigned int iso_bit;
>>> +	unsigned int mem_pd_count;
>>> +	struct meson_sm1_pwrc_mem_domain *mem_pd;
>>> +};
>> 
>> If you add resets and clocks (using clk bulk like my other proposed
>> patch to gx-pwrc-vpu) then this could be used for VPU also.  We could
>> ignore my clk bulk patch and then just deprecate the old driver and use
>> this one for everything.
>> 
>> We would just need SoC-specific tables selected by compatible-string to
>> select the memory pds, and the clocks and resets could (optionaly) come
>> from the DT.
>
> Could you elaborate ?
>
> Do you mean I should slit out the memory PDs as different compatible ?

You currently create all these SoC-specific `mem_domain` tables.  We'll
need more of those for the other SoCs, so my suggestion was that, in
order to use this across multiple SoCs, you select the set of mem_domain
tables based on compatible string.

That was just my first idea.  If you have a better idea, I'm open to
that too.

> Let me try to fit the VPU stuff in it.

Great, thanks!

Kevin
