Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB025C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D740214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5qvt9nG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbfB1Oe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:34:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46354 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732252AbfB1Oe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:34:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so22165692wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 06:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bWVcawIsRD6PzcQsGjb+7q0bWjeHb8YLP0VjksGnjbc=;
        b=n5qvt9nG541fmTx/ocnMNatW2vMsbr6zTVjFrGXmGQAZL2m9wDr9tSEUbE0BB94hDU
         +fp+3V6Arkuv5vTdjCJZs4cZ0/1tM6JHmFeBwq8V6q4ZSEwiD7bIzhVGsVch/0Dw6IQi
         i98mNfLwWdnLFOXonYA48dCz5he8//tr3U+ndYBy8b9ASRomyblm76A5AqUcWkc95qJ2
         D5+8u3h4giBE+ytYS5dtBsQwor8gogeR+HA0KjKzlf9fSwbTdQHrM2T49TauM4uoJOw6
         c2JUf9YAATByMCyUEHmpyNP5jbtiGXJhbR0r2Ogns6CAOVCK65OtZgrvtqi9fLvgzayp
         FXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bWVcawIsRD6PzcQsGjb+7q0bWjeHb8YLP0VjksGnjbc=;
        b=c9fI/UVVw+7oPxivWn1JKu6K7rT1orsCLMDeFrZB8abSi9V8rqSGKp1EPEumZlZLT2
         G7tFBQwCLjhMYlWNK7qybya6hpEoPZXdUHVntw4YaUltPDUb0R9CDUJoq8z9SCVhvMqf
         PwLG8fx0u2mcaMMvdTRYAZjtmIgORsTJBBd1MjKv0O69mrFvisVWuNyfQNjYjpN8Vh/b
         vuEUzaZgKlyAJ2z3jNnl7z1PA3cGDEwXu7NB0iVBolxKFbAMGp7D5/KyD8qKev7hJzom
         mas00VexHiZzMHBuNlyq3SGrsXxiWgZYixuJcgfj2xKWGko4MVCI1PL/HMlPNi8NP/yo
         4BlQ==
X-Gm-Message-State: APjAAAWjtQfaqxnB8VNZO+iXBZyNjWGvXSI/EPMjfD259OfahXCQlfS/
        /BEBTbwQatIQLwKfHPBswiFAdT2hqhY=
X-Google-Smtp-Source: APXvYqyiETuKnCihJzak4W+6LmIF8utHqfNvUr1M2yQwxNxcwxDWS23hovowUSNPciFmXJKYrCwvTA==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr6590765wrs.3.1551364464087;
        Thu, 28 Feb 2019 06:34:24 -0800 (PST)
Received: from [192.168.0.41] (244.150.136.77.rev.sfr.net. [77.136.150.244])
        by smtp.googlemail.com with ESMTPSA id y5sm5940033wmg.31.2019.02.28.06.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 06:34:23 -0800 (PST)
Subject: Re: [PATCH 1/7] drivers: firmware: psci: Move psci to separate
 directory
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-2-ulf.hansson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3e5d2953-3a14-fdea-d02b-6ed7bc4e7882@linaro.org>
Date:   Thu, 28 Feb 2019 15:34:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190228135919.3747-2-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 14:59, Ulf Hansson wrote:
> Some following changes extends the PSCI driver with some additional new
> files.  Let's avoid to continue cluttering the toplevel firmware directory
> and first move the PSCI files into a PSCI sub-directory.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
>  drivers/firmware/Kconfig                   | 15 +--------------
>  drivers/firmware/Makefile                  |  3 +--
>  drivers/firmware/psci/Kconfig              | 13 +++++++++++++
>  drivers/firmware/psci/Makefile             |  4 ++++
>  drivers/firmware/{ => psci}/psci.c         |  0
>  drivers/firmware/{ => psci}/psci_checker.c |  0
>  6 files changed, 19 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/firmware/psci/Kconfig
>  create mode 100644 drivers/firmware/psci/Makefile
>  rename drivers/firmware/{ => psci}/psci.c (100%)
>  rename drivers/firmware/{ => psci}/psci_checker.c (100%)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index f754578414f0..e1385f47d4ac 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -5,20 +5,6 @@
>  
>  menu "Firmware Drivers"
>  
> -config ARM_PSCI_FW
> -	bool
> -
> -config ARM_PSCI_CHECKER
> -	bool "ARM PSCI checker"
> -	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
> -	help
> -	  Run the PSCI checker during startup. This checks that hotplug and
> -	  suspend operations work correctly when using PSCI.
> -
> -	  The torture tests may interfere with the PSCI checker by turning CPUs
> -	  on and off through hotplug, so for now torture tests and PSCI checker
> -	  are mutually exclusive.
> -
>  config ARM_SCMI_PROTOCOL
>  	bool "ARM System Control and Management Interface (SCMI) Message Protocol"
>  	depends on ARM || ARM64 || COMPILE_TEST
> @@ -270,6 +256,7 @@ config TI_SCI_PROTOCOL
>  config HAVE_ARM_SMCCC
>  	bool
>  
> +source "drivers/firmware/psci/Kconfig"
>  source "drivers/firmware/broadcom/Kconfig"
>  source "drivers/firmware/google/Kconfig"
>  source "drivers/firmware/efi/Kconfig"
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 80feb635120f..9a3909a22682 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -2,8 +2,6 @@
>  #
>  # Makefile for the linux kernel.
>  #
> -obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
> -obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
>  obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= arm_scpi.o
>  obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pm_domain.o
>  obj-$(CONFIG_ARM_SDE_INTERFACE)	+= arm_sdei.o
> @@ -25,6 +23,7 @@ CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch armv7-a\n.arch_extension sec,-DREQU
>  obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
>  
>  obj-$(CONFIG_ARM_SCMI_PROTOCOL)	+= arm_scmi/
> +obj-y				+= psci/
>  obj-y				+= broadcom/
>  obj-y				+= meson/
>  obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
> diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
> new file mode 100644
> index 000000000000..26a3b32bf7ab
> --- /dev/null
> +++ b/drivers/firmware/psci/Kconfig
> @@ -0,0 +1,13 @@
> +config ARM_PSCI_FW
> +	bool
> +
> +config ARM_PSCI_CHECKER
> +	bool "ARM PSCI checker"
> +	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
> +	help
> +	  Run the PSCI checker during startup. This checks that hotplug and
> +	  suspend operations work correctly when using PSCI.
> +
> +	  The torture tests may interfere with the PSCI checker by turning CPUs
> +	  on and off through hotplug, so for now torture tests and PSCI checker
> +	  are mutually exclusive.
> diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
> new file mode 100644
> index 000000000000..1956b882470f
> --- /dev/null
> +++ b/drivers/firmware/psci/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
> +obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci/psci.c
> similarity index 100%
> rename from drivers/firmware/psci.c
> rename to drivers/firmware/psci/psci.c
> diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci/psci_checker.c
> similarity index 100%
> rename from drivers/firmware/psci_checker.c
> rename to drivers/firmware/psci/psci_checker.c
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

