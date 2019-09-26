Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F2FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C8E21D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AN9tMr/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfIZQXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 12:23:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44169 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:23:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id i14so1810967pgt.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=5KJXkwykZKMxFzMHYA7DO1LT2mHdYgxlgFlqTK43aSg=;
        b=AN9tMr/xQI6ixjCkoOmGxFdfQQtzy7Olh9LVYyYm42aA6ePb3swjBmTLHJbDhDG9c0
         m5sPVQYWjy4J96xClewSCc6+peXtW96QKUk3yBLYrK31fpIxgabsfI9rRa5cZzLh4cNr
         aVBYR8He61kDNtVrQWRiVcdpVmJMik1lgj+t6QFUnD2C7MbYsC3LJpfhOKW0vF7+AWDr
         ULvseh5sJ3UZ15ccyuqK1N3Vbyz/NxUVWqq8BGpNiRhLS4Ph7LFD26WxlZp2MLcyPk5w
         n5tdImLhl1Jqs1CiX409ZOVDPm2M7503awCd/tQopa4Bs5821cSrOpImfVJoT6cbGuqI
         nKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5KJXkwykZKMxFzMHYA7DO1LT2mHdYgxlgFlqTK43aSg=;
        b=nLaaG30px53lx/tbt/tIAtCJm53BXUgv2ulxI/ZXx++Rhk/tG4VzoIKZ/GX/Yeg8vL
         jjoIU1aHPzxriH0WJdgRqQVQLlxIFJ2MJivmo03lR6lTgwaDVcAoYwwPalvp9A9r2XvJ
         Ij29ODWD6Oy2pofNcG9isIJeqORoCf1oQs60e1Lu3wTC4iOfiOlVccKqFOGj7K+sEOzE
         QvUfWrsxpAT3gzmsdVAiWFWGsD1lV3HZXI7UyPMv0SwdR/OPbOyIDpBBNV9s58rbE0o6
         ToGztmYyNhkor4TqM9W5RLIN/g3wfnAklYBNZaWQBvfKInaF1f31WqPN46Kl8aeR4DfK
         MJmQ==
X-Gm-Message-State: APjAAAVpfPWURjMP7y5uPSVt19WUIltKwsTG0vRq5/Yxm5F4JZlUSxbJ
        U9oy7IDLli/oWYbl4gxTjBnuxw==
X-Google-Smtp-Source: APXvYqyXRYUH9jhldr03tJ4HTnP6NcLAFrGaRJdGlX81M87HTImuFCaOBIrqy502qWA3AiMe4YNO+g==
X-Received: by 2002:a17:90a:8c15:: with SMTP id a21mr4308094pjo.99.1569515023652;
        Thu, 26 Sep 2019 09:23:43 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y144sm3041925pfb.188.2019.09.26.09.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Sep 2019 09:23:42 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org
Cc:     Zhiqiang Liang <zhiqiang.liang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH 2/3] soc: amlogic: Add support for Secure power domains controller
In-Reply-To: <3859c748-01f0-4dbd-05d6-20fff31edf11@amlogic.com>
References: <1568895064-4116-1-git-send-email-jianxin.pan@amlogic.com> <1568895064-4116-3-git-send-email-jianxin.pan@amlogic.com> <7hh850t2wy.fsf@baylibre.com> <3859c748-01f0-4dbd-05d6-20fff31edf11@amlogic.com>
Date:   Thu, 26 Sep 2019 09:23:42 -0700
Message-ID: <7ha7arrppt.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> Hi Kevin,
>
> Thanks for your review. Please see my comments below.
>
>
> On 2019/9/26 6:41, Kevin Hilman wrote:
>> Hi Jianxin,
>> 
>> Jianxin Pan <jianxin.pan@amlogic.com> writes:
>> 
>>> Add support for the Amlogic Secure Power controller. In A1/C1 series, power
>>> control registers are in secure domain, and should be accessed by smc.
>>>
>>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>>> Signed-off-by: Zhiqiang Liang <zhiqiang.liang@amlogic.com>
>> 
>> Thanks for the new power domain driver.
>> 
>>> ---
>>>  drivers/soc/amlogic/Kconfig             |  13 +++
>>>  drivers/soc/amlogic/Makefile            |   1 +
>>>  drivers/soc/amlogic/meson-secure-pwrc.c | 182 ++++++++++++++++++++++++++++++++
>>>  3 files changed, 196 insertions(+)
>>>  create mode 100644 drivers/soc/amlogic/meson-secure-pwrc.c
>>>
>>> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
>>> index bc2c912..6cb06e7 100644
>>> --- a/drivers/soc/amlogic/Kconfig
>>> +++ b/drivers/soc/amlogic/Kconfig
>>> @@ -48,6 +48,19 @@ config MESON_EE_PM_DOMAINS
>>>  	  Say yes to expose Amlogic Meson Everything-Else Power Domains as
>>>  	  Generic Power Domains.
>>>  
>>> +config MESON_SECURE_PM_DOMAINS
>>> +	bool "Amlogic Meson Secure Power Domains driver"
>>> +	depends on ARCH_MESON || COMPILE_TEST
>>> +	depends on PM && OF
>>> +	depends on HAVE_ARM_SMCCC
>>> +	default ARCH_MESON
>>> +	select PM_GENERIC_DOMAINS
>>> +	select PM_GENERIC_DOMAINS_OF
>>> +	help
>>> +	  Support for the power controller on Amlogic A1/C1 series.
>>> +	  Say yes to expose Amlogic Meson Secure Power Domains as Generic
>>> +	  Power Domains.
>>> +
>>>  config MESON_MX_SOCINFO
>>>  	bool "Amlogic Meson MX SoC Information driver"
>>>  	depends on ARCH_MESON || COMPILE_TEST
>>> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
>>> index de79d044..7b8c5d3 100644
>>> --- a/drivers/soc/amlogic/Makefile
>>> +++ b/drivers/soc/amlogic/Makefile
>>> @@ -5,3 +5,4 @@ obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
>>>  obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>>>  obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
>>>  obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
>>> +obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
>>> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
>>> new file mode 100644
>>> index 00000000..00c7232
>>> --- /dev/null
>>> +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
>>> @@ -0,0 +1,182 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> [...]
>>> +
>>> +static bool pwrc_secure_get_power(struct meson_secure_pwrc_domain *pwrc_domain)
>>> +{
>>> +	struct arm_smccc_res res;
>>> +
>>> +	arm_smccc_smc(SMC_PWRC_GET, pwrc_domain->index, 0,
>>> +		      0, 0, 0, 0, 0, &res);
>>> +
>>> +	return res.a0 & 0x1;
>> 
>> Please use a #define with a readable name for this mask.
>> The return type of this smc is bool. I will remove 0x1 mask in next version. 
>
> Another question about smc:
> In this driver, no share memory is needed, and I use arm_smccc_smc() directly.
> Should I add secure-monitor = <&sm> in dtb and use meson_sm_call() from sm driver instead? 

Yes, that would be preferred.

>>> +}
>> 
>> What does the return value for this function mean?  Does true mean
>> "powered off" or "powered on">
> The return vaule for SMC_PWRC_GET :
> 0 -> power on
> 1 -> power off> See the rename I just did on the ee-pwrc driver:
>> https://lore.kernel.org/linux-amlogic/20190925213528.21515-2-khilman@kernel.org/
>> I will follow and rename to _is_off() in the next verson.
>>> +static int meson_secure_pwrc_off(struct generic_pm_domain *domain)
>>> +{
>>> +	struct arm_smccc_res res;
>>> +	struct meson_secure_pwrc_domain *pwrc_domain =
> [...]
>>> +
>>> +#define SEC_PD(__name, __flag)			\
>>> +{						\
>>> +	.name = #__name,			\
>>> +	.index = PWRC_##__name##_ID,		\
>>> +	.get_power = pwrc_secure_get_power,	\
>>> +	.flags = __flag,			\
>>> +}
>>> +
>>> +static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>>> +	SEC_PD(DSPA,	0),
>>> +	SEC_PD(DSPB,	0),
>>> +	SEC_PD(UART,	GENPD_FLAG_ALWAYS_ON),
>> 
>> This flag should only be used for domains where there are no linux
>> drivers.
>> 
>> Rather than using this flag, you need to add a 'power-domain' property
>> to the uart driver in DT, and then update the meson_uart driver to use
>> the runtime PM API so that the domain is enabled whenever the UART is in
>> use.
>
> PM_UART Power domain is shared by uart, msr, jtag and cec.
> Uart should keep working in BL31, after kernel suspend and before kernel resume.

OK.

>> 
>>> +	SEC_PD(DMC,	GENPD_FLAG_ALWAYS_ON),
>> 
>> Please explain the need for ALWAYS_ON.
>> 
> PM_DMC is used for DDR PHY ana/dig and DMC. 
> There is no linux drver for them, and it should be always on. 
>
> I will add comments for all these always on domains.

OK, thank you.


Kevin
