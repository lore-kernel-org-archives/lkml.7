Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4440AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D862084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xVO7Z3aJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfCATW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:22:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33428 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCATWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:22:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id y10so11952922plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 11:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E9SsEWRUK18L145Ocpi6wtvc2y3vGmZ7+ioXZrJ5Dr8=;
        b=xVO7Z3aJH7QkizAhnLu5gQO/9gZQwdo1j9aExsCUGMPubho8mTfdw6GvQw53WyUqyC
         OvcA/xJhcO1fw7BoR/eayGTD+YCn0SP+RfGFlYs8NdwAXwmxlJmRfWiDkYKV4TfvHpaA
         KJ1JzsHT4uQaMyhoBOaV4QhTKQpps9A2A7F0OEnXjat9YqI9pPluE2kOOjJ7FmA9dWrn
         YTOkKxRS8d23WZtiDA/c+8lbsZco9Q80EY5gYLgE/9uqIrG9pYUWUylTKPQjO7X51oeW
         AwBhlaZQzkpCG1Cd3r6m9eJZGQ5y07YDDgE+3Lz8B+h1ffjQ459qYLyoLNLoGwjyCtJ7
         iNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E9SsEWRUK18L145Ocpi6wtvc2y3vGmZ7+ioXZrJ5Dr8=;
        b=e8Hs2hyaHRttb4o0BDO7+GOe83uvRqlAKQ8YPz0E86gT2B1fr320JYhNbNBWbeDY8v
         9TD7rvsZvwloLmz20g0ibD3W92GCWn6nxgLji0ZEXnIjx2DfhQCZQ3T+V4NO95tnhl1G
         dI54ibOeSqlzcCbPT7Q5MR9+4Z7Y87QL4UNsSSWJ6wzwfKhu+sJzYdIFLXe1pRASHGo5
         ijaRY4/XMpP51hLXQPq+vFKDg/ooacmprwFwhFC9S62DQGAILagjDSGYXLj5E1nOIRy/
         iaND1xo6zeGbWaBC6BUpRp4jNbgBVemP56BZMUT67EIm1ZkxYCO4A3XAVxMBhZRPx6cG
         /SXg==
X-Gm-Message-State: APjAAAXm+9u4K6TXMF+XIFnaVvfazcRLrWVKggw1YQ6zHrVCv9JdRkt0
        sFId/QyxJV7mkISP/lh+zmU1AQ==
X-Google-Smtp-Source: APXvYqy3YgEGYNhvzV2fa3KpYv6sww5FB75A7hS4/yorTjFwpuvqAyYj1hUxwU0K6WcuDE2JMRA78g==
X-Received: by 2002:a17:902:e512:: with SMTP id ck18mr6998606plb.46.1551468174770;
        Fri, 01 Mar 2019 11:22:54 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h10sm12060374pfo.128.2019.03.01.11.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 11:22:53 -0800 (PST)
Date:   Fri, 1 Mar 2019 11:23:33 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org, vkoul@kernel.org,
        Imran Khan <kimran@codeaurora.org>
Subject: Re: [PATCH v4 3/5] soc: qcom: Add socinfo driver
Message-ID: <20190301192333.GC27005@builder>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org>
 <20190225065044.11023-4-vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225065044.11023-4-vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 24 Feb 22:50 PST 2019, Vaishali Thakkar wrote:

[..]
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index f25b54cd6cf8..c817da4f4140 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -14,6 +14,7 @@ qcom_rpmh-y			+= rpmh-rsc.o
>  qcom_rpmh-y			+= rpmh.o
>  obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
>  obj-$(CONFIG_QCOM_SMEM) +=	smem.o
> +obj-$(CONFIG_QCOM_SOCINFO)     += socinfo.o

Try to keep these sorted by moving this entry down a few steps.

>  obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
>  obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
>  obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index f80d040601fd..efe0b053ef82 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -276,6 +276,7 @@ struct qcom_smem {
>  	struct smem_partition_header *partitions[SMEM_HOST_COUNT];
>  	size_t cacheline[SMEM_HOST_COUNT];
>  	u32 item_count;
> +	struct platform_device *socinfo;
>  
>  	unsigned num_regions;
>  	struct smem_region regions[];
> @@ -971,11 +972,18 @@ static int qcom_smem_probe(struct platform_device *pdev)
>  
>  	__smem = smem;
>  
> +	smem->socinfo = platform_device_register_data(&pdev->dev, "qcom-socinfo",
> +						      PLATFORM_DEVID_NONE, NULL,
> +						      0);
> +	if (IS_ERR(smem->socinfo))
> +		dev_err(&pdev->dev, "failed to register socinfo device\n");
> +
>  	return 0;
>  }
>  
>  static int qcom_smem_remove(struct platform_device *pdev)
>  {
> +

Let's platform_device_unregister(smem->socinfo) here.

Note that it will handle being passed a ERR_PTR, so no need to make the
call conditional on socinfo being valid.

>  	hwspin_lock_free(__smem->hwlock);
>  	__smem = NULL;
>  
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> new file mode 100644
> index 000000000000..02078049fac7
> --- /dev/null
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2009-2017, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2017-2019, Linaro Ltd.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/random.h>
> +#include <linux/slab.h>
> +#include <linux/soc/qcom/smem.h>
> +#include <linux/string.h>
> +#include <linux/sys_soc.h>
> +#include <linux/types.h>
> +
> +/*
> + * SoC version type with major number in the upper 16 bits and minor
> + * number in the lower 16 bits.
> + */
> +#define SOCINFO_MAJOR(ver) (((ver) >> 16) & 0xffff)
> +#define SOCINFO_MINOR(ver) ((ver) & 0xffff)
> +
> +#define SMEM_SOCINFO_BUILD_ID_LENGTH           32
> +
> +/*
> + * SMEM item ids, used to acquire handles to respective
> + * SMEM region.

There's only one socinfo SMEM item, so this sentence should be turned
singular.

> + */
> +#define SMEM_HW_SW_BUILD_ID            137
> +
> +/* Socinfo SMEM item structure */
> +struct socinfo {
> +	__le32 fmt;
> +	__le32 id;
> +	__le32 ver;
> +	char build_id[SMEM_SOCINFO_BUILD_ID_LENGTH];
> +	/* Version 2 */
> +	__le32 raw_id;
> +	__le32 raw_ver;
> +	/* Version 3 */
> +	__le32 hw_plat;
> +	/* Version 4 */
> +	__le32 plat_ver;
> +	/* Version 5 */
> +	__le32 accessory_chip;
> +	/* Version 6 */
> +	__le32 hw_plat_subtype;
> +	/* Version 7 */
> +	__le32 pmic_model;
> +	__le32 pmic_die_rev;
> +	/* Version 8 */
> +	__le32 pmic_model_1;
> +	__le32 pmic_die_rev_1;
> +	__le32 pmic_model_2;
> +	__le32 pmic_die_rev_2;
> +	/* Version 9 */
> +	__le32 foundry_id;
> +	/* Version 10 */
> +	__le32 serial_num;
> +	/* Version 11 */
> +	__le32 num_pmics;
> +	__le32 pmic_array_offset;
> +	/* Version 12 */
> +	__le32 chip_family;
> +	__le32 raw_device_family;
> +	__le32 raw_device_num;
> +};
> +
> +struct qcom_socinfo {
> +	struct soc_device *soc_dev;
> +	struct soc_device_attribute attr;
> +};
> +
> +struct soc_of_id {
> +	unsigned int id;
> +	const char *name;
> +};
> +
> +static const struct soc_of_id soc_of_id[] = {
> +	{87, "MSM8960"},
> +	{109, "APQ8064"},
> +	{122, "MSM8660A"},
> +	{123, "MSM8260A"},
> +	{124, "APQ8060A"},
> +	{126, "MSM8974"},
> +	{130, "MPQ8064"},
> +	{138, "MSM8960AB"},
> +	{139, "APQ8060AB"},
> +	{140, "MSM8260AB"},
> +	{141, "MSM8660AB"},
> +	{178, "APQ8084"},
> +	{184, "APQ8074"},
> +	{185, "MSM8274"},
> +	{186, "MSM8674"},
> +	{194, "MSM8974PRO"},
> +	{206, "MSM8916"},
> +	{208, "APQ8074-AA"},
> +	{209, "APQ8074-AB"},
> +	{210, "APQ8074PRO"},
> +	{211, "MSM8274-AA"},
> +	{212, "MSM8274-AB"},
> +	{213, "MSM8274PRO"},
> +	{214, "MSM8674-AA"},
> +	{215, "MSM8674-AB"},
> +	{216, "MSM8674PRO"},
> +	{217, "MSM8974-AA"},
> +	{218, "MSM8974-AB"},
> +	{246, "MSM8996"},
> +	{247, "APQ8016"},
> +	{248, "MSM8216"},
> +	{249, "MSM8116"},
> +	{250, "MSM8616"},
> +	{291, "APQ8096"},
> +	{305, "MSM8996SG"},
> +	{310, "MSM8996AU"},
> +	{311, "APQ8096AU"},
> +	{312, "APQ8096SG"},
> +};
> +
> +static const char *socinfo_machine(struct device *dev, unsigned int id)
> +{
> +	int idx;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(soc_of_id); idx++) {
> +		if (soc_of_id[idx].id == id)
> +			return soc_of_id[idx].name;
> +	}
> +
> +	if (IS_ERR(soc_of_id[idx].name))

idx will be == ARRAY_SIZE(soc_of_id) here, so you're reading outside the
array. You can write your error unconditionally here, because you didn't
find a match - or just skip the error message completely.

If you decide to keep it, that would be to facilitate adding new entries
to the list, so include the value of "id".

> +		dev_err(dev, "Unknown soc id\n");
> +
> +	return NULL;
> +}
> +
> +static int qcom_socinfo_probe(struct platform_device *pdev)
> +{
> +	struct qcom_socinfo *qs;
> +	struct socinfo *info;
> +	size_t item_size;
> +
> +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID,
> +			      &item_size);
> +	if (IS_ERR(info)) {
> +		dev_err(&pdev->dev, "Couldn't find socinfo\n");
> +		return -EINVAL;
> +	}
> +
> +	qs = devm_kzalloc(&pdev->dev, sizeof(*qs), GFP_KERNEL);
> +	if (!qs)
> +		return -ENOMEM;
> +
> +	qs->attr.family = "Snapdragon";
> +	qs->attr.machine = socinfo_machine(&pdev->dev,
> +					   le32_to_cpu(info->id));
> +	qs->attr.revision = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%u.%u",
> +					   SOCINFO_MAJOR(le32_to_cpu(info->ver)),
> +					   SOCINFO_MINOR(le32_to_cpu(info->ver)));
> +	if (le32_to_cpu(info->fmt) >= 10)
> +		qs->attr.serial_number = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +							"%u",
> +							le32_to_cpu(info->serial_num));
> +
> +	qs->soc_dev = soc_device_register(&qs->attr);
> +	if (IS_ERR(qs->soc_dev))
> +		return PTR_ERR(qs->soc_dev);
> +
> +	/* Feed the soc specific unique data into entropy pool */
> +	add_device_randomness(info, item_size);
> +
> +	platform_set_drvdata(pdev, qs->soc_dev);
> +
> +	return 0;
> +}

Regards,
Bjorn
