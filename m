Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7734FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469DF206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rpvHv/fB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbfFMPmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:42:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35268 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388172AbfFMPmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:42:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so11179074pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VoBG7EvsIVm5+yftt03AuO+h2ih774Rur7eHPugMCPE=;
        b=rpvHv/fBzd4sMNXyIgGYerZQOpsD9jAG/DOme7ThtwnqDI9UXAsAfUHozuiAg5od3U
         J/aNPDRSbdveut1aCJ3Ik+kt+dJbzM47IGKByZtujQYJQJfR2NswYMdFBQfZDuKAqtjK
         MvnnfFKzqoySJLfmupAR1cRKEnSfDNOtaRsEKWeM8fCHfTFZxMB/DPUMxiOrqut2RIzB
         2T51dHcW3ABriXZnWIN87pnzFUrrWns4xwsOrvRN9ur1EhiBlAfzyIY5QHKJZuIqyLWN
         prJQG4rTJxPahMUYuALhyrXG0beDMjSe6JDgBp7UI08bzmyJCGgKNQtB70vzx1uz+jlj
         Cd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VoBG7EvsIVm5+yftt03AuO+h2ih774Rur7eHPugMCPE=;
        b=HCey77vEKNUgmGcx4eDzjMlvNruycIUoGPqrFrHS0cBjMka9H/dHD32Qs5idbY0SSa
         vv0HPff1hHr2F/9WvIowQ+kdfP46AnT+OwH3aymISJ7WTlFAnDqk9r99dcqb2qTG0tzG
         INI5FEF4rAoLLxFd4PgV34u6hjo9g99UldbIATX1iwmL7nufiVciq48rO+Vwzy68i8XX
         kfbg/o8LzgAk3sAwWPyINhdieT/QFSiKVEGS5NokEGniDNwNE+tEgG6KiJC9vJOTgITg
         pU8IU7Npa5YSJJ4d7AdfLWuu0FL9SFTdTwDRgb59aPdeUzP4wwm2sJPscuH2rwSlGqAW
         zX4w==
X-Gm-Message-State: APjAAAUTHrfhLSF7tp//tZ5itxUyyrznSS8R4q062wGRSkn9AVqhi9JK
        BmLz3XEaK4cVcGxfeYjBSgW4uA==
X-Google-Smtp-Source: APXvYqwvE+odGG2bln3nrcnepEbyxebL00NHFK12JuNezcpaBNkl5y20OvUBwxdcRA3V29N+WHJQSw==
X-Received: by 2002:a63:26c6:: with SMTP id m189mr7797730pgm.2.1560440537098;
        Thu, 13 Jun 2019 08:42:17 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g8sm194210pgd.29.2019.06.13.08.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 08:42:16 -0700 (PDT)
Date:   Thu, 13 Jun 2019 08:42:14 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     robh+dt@kernel.org, agross@kernel.org, vkoul@kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 3/5] interconnect: qcom: Add interconnect SMD over SMD
 driver
Message-ID: <20190613154214.GI6792@builder>
References: <20190613151323.10850-1-georgi.djakov@linaro.org>
 <20190613151323.10850-4-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613151323.10850-4-georgi.djakov@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13 Jun 08:13 PDT 2019, Georgi Djakov wrote:

> On some Qualcomm SoCs, there is a remote processor, which controls some of
> the Network-On-Chip interconnect resources. Other CPUs express their needs
> by communicating with this processor. Add a driver to handle communication
> with this remote processor.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> 
> v4:
> - Hide the driver from config menu. It will be selected by other driver.
> - Add remove() function to zero out the rpm handle.
> 
> v3:
> - New patch.
> 
>  drivers/interconnect/qcom/Kconfig   |  3 ++
>  drivers/interconnect/qcom/Makefile  |  2 +
>  drivers/interconnect/qcom/smd-rpm.c | 80 +++++++++++++++++++++++++++++
>  drivers/interconnect/qcom/smd-rpm.h | 15 ++++++
>  4 files changed, 100 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/smd-rpm.c
>  create mode 100644 drivers/interconnect/qcom/smd-rpm.h
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index d5e70ebc2410..03fd67173494 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -12,3 +12,6 @@ config INTERCONNECT_QCOM_SDM845
>  	help
>  	  This is a driver for the Qualcomm Network-on-Chip on sdm845-based
>  	  platforms.
> +
> +config INTERCONNECT_QCOM_SMD_RPM
> +	tristate
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index 1c1cea690f92..a600cf6cc272 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  qnoc-sdm845-objs			:= sdm845.o
> +icc-smd-rpm-objs			:= smd-rpm.o
>  
>  obj-$(CONFIG_INTERCONNECT_QCOM_SDM845) += qnoc-sdm845.o
> +obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += icc-smd-rpm.o
> diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
> new file mode 100644
> index 000000000000..0a8c9547bd29
> --- /dev/null
> +++ b/drivers/interconnect/qcom/smd-rpm.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RPM over SMD communication wrapper for interconnects
> + *
> + * Copyright (C) 2019 Linaro Ltd
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/qcom/smd-rpm.h>
> +
> +#include "smd-rpm.h"
> +
> +#define RPM_KEY_BW		0x00007762
> +
> +static struct qcom_smd_rpm *icc_smd_rpm;
> +
> +struct icc_rpm_smd_req {
> +	__le32 key;
> +	__le32 nbytes;
> +	__le32 value;
> +};
> +
> +bool qcom_icc_rpm_smd_available(void)
> +{
> +	if (!icc_smd_rpm)
> +		return false;
> +
> +	return true;

A more succinct form would have been:

	return !!icc_smd_rpm;


Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> +}
> +EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_available);
> +
> +int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
> +{
> +	struct icc_rpm_smd_req req = {
> +		.key = cpu_to_le32(RPM_KEY_BW),
> +		.nbytes = cpu_to_le32(sizeof(u32)),
> +		.value = cpu_to_le32(val),
> +	};
> +
> +	return qcom_rpm_smd_write(icc_smd_rpm, ctx, rsc_type, id, &req,
> +				  sizeof(req));
> +}
> +EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
> +
> +static int qcom_icc_rpm_smd_remove(struct platform_device *pdev)
> +{
> +	icc_smd_rpm = NULL;
> +
> +	return 0;
> +}
> +
> +static int qcom_icc_rpm_smd_probe(struct platform_device *pdev)
> +{
> +	icc_smd_rpm = dev_get_drvdata(pdev->dev.parent);
> +
> +	if (!icc_smd_rpm) {
> +		dev_err(&pdev->dev, "unable to retrieve handle to RPM\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver qcom_interconnect_rpm_smd_driver = {
> +	.driver = {
> +		.name		= "icc_smd_rpm",
> +	},
> +	.probe = qcom_icc_rpm_smd_probe,
> +	.remove = qcom_icc_rpm_smd_remove,
> +};
> +module_platform_driver(qcom_interconnect_rpm_smd_driver);
> +MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
> +MODULE_DESCRIPTION("Qualcomm SMD RPM interconnect proxy driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:icc_smd_rpm");
> diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
> new file mode 100644
> index 000000000000..ca9d0327b8ac
> --- /dev/null
> +++ b/drivers/interconnect/qcom/smd-rpm.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019, Linaro Ltd.
> + * Author: Georgi Djakov <georgi.djakov@linaro.org>
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H
> +#define __DRIVERS_INTERCONNECT_QCOM_SMD_RPM_H
> +
> +#include <linux/soc/qcom/smd-rpm.h>
> +
> +bool qcom_icc_rpm_smd_available(void);
> +int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
> +
> +#endif
