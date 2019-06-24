Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA62C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C7520673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 16:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u6cxO6MM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbfFXQNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 12:13:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33046 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbfFXQNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:13:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so14602881wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 09:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=x3N/ysYfWNdsqldPdfjo7f2rGgVDaUPKFUtfQyAjzbM=;
        b=u6cxO6MMeTnfmah0ExozWFj2X6DtoQBPQ4Q82xVLKy46YIoLsf+9xO9fNikXmcPErl
         XnfPvPdvmNrvBWf4u3RU4ytzBF0Q+YRd1XVjOidkjgXGNvXOL/ZYBiS0qeqjUCT3UOzY
         CqeXBFvHxdsaCug9UKAQqxYgxlcT2ZZu7bYwCpcQ4tACIa0Jkia1EGTkFgF1M9aUqzzY
         lDJScDMFcqgHvVygsrMeqRPQ9N/xO5tcRBdaTZV1Iyw/GMjjjZ0wNySwlFpIMzalAyy+
         U3598ioI960wQX0SV3ohv8tg6d+7mYyuOnAebc9C0Y+uV3+bQ8EX5k0yZNXSsSKWAda/
         mNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x3N/ysYfWNdsqldPdfjo7f2rGgVDaUPKFUtfQyAjzbM=;
        b=HGVqMMIlLGFmBM6s5bccbGMYetd319FB2lWx1eRyYlDOFZ9Q8xTlg6NbTEXipnqa9I
         HQkEpn9JTU9o0RZcwZaJPag/55+LxFjYbyS5b5Bx1ZPk8B/aMyFPCZpxReNO7miQaUCh
         WGh+x57ZxXLhOk/th+LkMRoDwKBoXk+qQllcPacsUMrC6YizdNG9OXY17f/xWeJta9H4
         8udnsJTGVuz3Oi0pEa1cwpo9jLnnzCLoMnMBn9pNb2EOSDCxW5AxVnF0NXz9RxgrdjOl
         kue/JOeyeSkuXUVS14Rs95wECHfXUJaWv+vR4ZosKDaWPVCKMJeZd8if8ad6ohyBf6p9
         oMLw==
X-Gm-Message-State: APjAAAVIiloIokzsOnGbb2WZac25yrDLkhQrqezvgmAlqnRSBBKFrALh
        30mIG73/FZPKPlB+LV1vxM3ZM902fVI=
X-Google-Smtp-Source: APXvYqyGGbSUdis/Rgi4SXUmyNBkT9ftrXk0giC4B6sl+YaX1HzACfCuF0cmjpOlQW2xfVoUcSmHyg==
X-Received: by 2002:a05:6000:114b:: with SMTP id d11mr43424137wrx.167.1561392830975;
        Mon, 24 Jun 2019 09:13:50 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id p3sm8377867wrd.47.2019.06.24.09.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 09:13:50 -0700 (PDT)
Date:   Mon, 24 Jun 2019 17:13:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mfd: Add support for Merrifield Basin Cove PMIC
Message-ID: <20190624161348.GB21119@dell>
References: <20190612101945.55065-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190612101945.55065-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019, Andy Shevchenko wrote:

> Add an MFD driver for Intel Merrifield Basin Cove PMIC.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> - updated copyright year to be 2019
> - rebased on top of latest vanilla rc
> 
>  drivers/mfd/Kconfig                      |  11 ++
>  drivers/mfd/Makefile                     |   1 +
>  drivers/mfd/intel_soc_pmic_mrfld.c       | 157 +++++++++++++++++++++++
>  include/linux/mfd/intel_soc_pmic_mrfld.h |  81 ++++++++++++
>  4 files changed, 250 insertions(+)
>  create mode 100644 drivers/mfd/intel_soc_pmic_mrfld.c
>  create mode 100644 include/linux/mfd/intel_soc_pmic_mrfld.h

[...]

> +static int bcove_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct intel_soc_pmic *pmic;
> +	unsigned int i;
> +	int ret;
> +
> +	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
> +	if (!pmic)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pmic);
> +	pmic->dev = &pdev->dev;
> +
> +	pmic->regmap = devm_regmap_init(dev, NULL, pmic, &bcove_regmap_config);
> +	if (IS_ERR(pmic->regmap))
> +		return PTR_ERR(pmic->regmap);
> +
> +	for (i = 0; i < ARRAY_SIZE(irq_level2_resources); i++) {
> +		ret = platform_get_irq(pdev, i);

If you already know the order, define the children's device IDs in the
parent's shared header ('intel_soc_pmic_mrfld.h'?) and retreive them
like:

  platform_get_irq(pdev->parent, <SUITABLE_DEFINED_ID>);

Then you can skip all of this platform device -> platform device hoop
jumping.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
