Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3CBC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205CF22ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyYI649c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfGXOJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:09:08 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44373 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfGXOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:09:06 -0400
Received: by mail-vk1-f195.google.com with SMTP id w186so993328vkd.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMM/fuc3WiNrMsYpxO4sLYGg6mIGpBm3nkr4euaECOE=;
        b=YyYI649c5rtIY3S/Tov9vJAujEz+ZdfPE1Sit+Zb1USS0ZxO7aYR7HJ7I9gsd7v19n
         fTt5OgOfV9kUpe24n/+4iPaReqQNOfwmyuDlt2QW61jbKZXYd0SLicAkXYEJYpEx+UkO
         e3XlsQ6fZwccPrmcgC7+7UGawS353Gbq6bmEGW8XIeFpSmdu6I2VhWWSZvUF8KaKAxRu
         PgH6adCiv6dA1bkKiWhKX4sIqv6WS9gNNZnYQkgHN7+Uvs7oU8huJ874QLnULSSbYg10
         6RNSmHPLESgkGYtTBdIHaUI0MS0MlG5vP5cYYwhztolUv5drWuE2peVkQw2dAavzIVAb
         QFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMM/fuc3WiNrMsYpxO4sLYGg6mIGpBm3nkr4euaECOE=;
        b=EToY6unZUGC1L0D/8TlrH+xJgjr322EHJ8P4JQn15SN+g3uTTGiZUeThC0lXUUhw76
         lFbQWx9pemnXoNS86wuRGg3NrPI0xSKLc2o/h3fkWD0+ZNTed8kBmKO+5I2r6EdaAqFA
         5kuT1alkfHKo+gTYz9YxMpHk5pRTAppIaEH+W0SYT9zHFaL7v+/ZpCIk5lfmKettz2mR
         5eU/vz58cYSaXUGQQxJ//UcM7S7372sZidBCqIuzorZkNJzNwWKRqzW5HwZ4/PDjGHed
         Ezgit9ysfxe4EaDUORcR1Jh56zvsUCln4Ec37Q0jbI8PsAjBLRyLgM3TEz+8wDWnWYvE
         Q9Qw==
X-Gm-Message-State: APjAAAXB1KtxdyUucX60cHexau9B3ENWayODUQb7DDA9P1A/fSJH+izo
        gFVloUqxbYXy0VaDb7OYiG2imZoAJPoJsHOwpbYDjQ==
X-Google-Smtp-Source: APXvYqz6aI9mhe4o48eiASnSqHgsrfHpOq8U3P2uy9ecuXBVqcQYD4NERo0xNJEZjBwrmITSdbMQzAo+udkAzdaIUZU=
X-Received: by 2002:a1f:f282:: with SMTP id q124mr32103246vkh.4.1563977344697;
 Wed, 24 Jul 2019 07:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190723124707.24782-1-hslester96@gmail.com>
In-Reply-To: <20190723124707.24782-1-hslester96@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Jul 2019 16:08:28 +0200
Message-ID: <CAPDyKFpo3P_e1ufxyOLLxdeRLe-z1-1Yx5xERD2Hkf0OQbBh8w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Use dev_get_drvdata
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 at 14:47, Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 4041878eb0f3..d10aceed5bb7 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1759,8 +1759,7 @@ static const struct sdhci_ops sdhci_pci_ops = {
>  #ifdef CONFIG_PM_SLEEP
>  static int sdhci_pci_suspend(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
> +       struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
>
>         if (!chip)
>                 return 0;
> @@ -1773,8 +1772,7 @@ static int sdhci_pci_suspend(struct device *dev)
>
>  static int sdhci_pci_resume(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
> +       struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
>
>         if (!chip)
>                 return 0;
> @@ -1789,8 +1787,7 @@ static int sdhci_pci_resume(struct device *dev)
>  #ifdef CONFIG_PM
>  static int sdhci_pci_runtime_suspend(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
> +       struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
>
>         if (!chip)
>                 return 0;
> @@ -1803,8 +1800,7 @@ static int sdhci_pci_runtime_suspend(struct device *dev)
>
>  static int sdhci_pci_runtime_resume(struct device *dev)
>  {
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct sdhci_pci_chip *chip = pci_get_drvdata(pdev);
> +       struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
>
>         if (!chip)
>                 return 0;
> --
> 2.20.1
>
