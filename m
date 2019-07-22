Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7FEC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4049820449
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYgsjNrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfGVLyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:54:39 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46093 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbfGVLyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:54:38 -0400
Received: by mail-ua1-f65.google.com with SMTP id o19so15177508uap.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 04:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c+jcqREf0y9aZZyOwn61TZepULbNlwtiLvYl1u1X4h0=;
        b=jYgsjNrm5DLwDRKga2G6kbcDqPs0WqeGaCaUJTW71luxttK/AKH8nd1s3ahL10ppLc
         fOeSvqncdR7y5Zkoz03hM5q5wLRrTfRijStSrb2iKT0btXaqEkkkX2hbuiLV+qwbFE81
         Ezs30ZYWr3O8Hdy2HZZobySjUci7JPRa+7P8ccen9AI982wZSqGfQJVzoiNbhje0z7o9
         eP1htrnKA5GUIuym0D5NhwEP9Vt45b1t4sKWVXDB2mzKb+BMCyQnQ1KIJvMmsG7Y7IP8
         C8B3+6b+v4OiIGMR7Pz8eDZp12559FVVBADFYIsc/0mwjyyEZctgDkf8g1IaCNU8iM8M
         amvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+jcqREf0y9aZZyOwn61TZepULbNlwtiLvYl1u1X4h0=;
        b=BRaslM/Kxm6RePeEqsgBNEBCR7fWgkYPXTFhFaozQdR13/DEN8LD3RxuZ55bGTYeXU
         GKJmf3SFSxpmToxFy5QHIAD6oGiPBtjzYBwEOrk1gOuQujgLOyoXRJBSPJW0q6wTWttx
         u6/WDT/Gvs3S7PGEAwfkQ7R3AvpCc3f8ihLioqqtfdjk7IUnC6aJglVJjOu9ezv7VGJw
         imEh5w6VyW6uRNBHW1ybpBXaL+GS3pumV24xu7xLGMqLT/15BGWTyiI4Y7eD53LQTqvI
         jYo7LN5PCUeQOzfq5a9nG9bFsXsABzNGCNZStpUsiCoLUtd2A2STPAzAoODP5Ql4U0Qv
         6tRw==
X-Gm-Message-State: APjAAAUp3wE/62ruL8/Wvm5EMb6AHY2w5/vcIgXqKvKPDGvU6EY4vmer
        3JEbmu3JXSgsK0tzmc+THp0cDBT7SIGtyXBKsDOC7A==
X-Google-Smtp-Source: APXvYqyER+QheiF65Y24ygl+OAmEAkNJ0+BDjyOfafxC+aFcXzqZpZP/NHU00/dvkHkEZnPUIEUhDuaRlU44tBGPerU=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr41180854uad.15.1563796477559;
 Mon, 22 Jul 2019 04:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
In-Reply-To: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 22 Jul 2019 13:54:01 +0200
Message-ID: <CAPDyKFq1y6xVfA=b1ybWvA1+e9h9aSteHAHjBbXvXGVJx95FQA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2019 at 04:29, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> In sdhci_runtime_resume_host() function, we will always do software reset
> for all, which will cause Spreadtrum host controller work abnormally after
> resuming.

What does "software reset for all" means?

>
> Thus for Spreadtrum platform that will not power down the SD/eMMC card during
> runtime suspend, we should not do software reset for all.

Normally, sdhci hosts that enters runtime suspend doesn't power off
the card (there are some exceptions like PCI variants).

So, what's so special here and how does the reset come into play? I
don't see sdhci doing a reset in sdhci_runtime_suspend|resume_host()
and nor doesn the callback from the sdhci-sprd.c variant doing it.

> To fix this
> issue, adding a specific reset operation that adds one condition to validate
> the power mode to decide if we can do software reset for all or just reset
> command and data lines.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changess from v3:
>  - Use ios.power_mode to validate if the card is power down or not.
>
> Changes from v2:
>  - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().
>
> Changes from v1:
>  - Add a specific reset operation instead of changing the core to avoid
>  affecting other hardware.
> ---
>  drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 603a5d9..94f9726 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
>         return 1 << 31;
>  }
>
> +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> +{
> +       struct mmc_host *mmc = host->mmc;
> +
> +       /*
> +        * When try to reset controller after runtime suspend, we should not
> +        * reset for all if the SD/eMMC card is not power down, just reset
> +        * command and data lines instead. Otherwise will meet some strange
> +        * behaviors for Spreadtrum host controller.
> +        */
> +       if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
> +           mmc->ios.power_mode == MMC_POWER_ON)
> +               mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;

Can sdhci_sprd_reset() be called when the host is runtime suspended?
That sounds like a bug to me, no?

> +
> +       sdhci_reset(host, mask);
> +}
> +
>  static struct sdhci_ops sdhci_sprd_ops = {
>         .read_l = sdhci_sprd_readl,
>         .write_l = sdhci_sprd_writel,
> @@ -381,7 +398,7 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
>         .get_max_clock = sdhci_sprd_get_max_clock,
>         .get_min_clock = sdhci_sprd_get_min_clock,
>         .set_bus_width = sdhci_set_bus_width,
> -       .reset = sdhci_reset,
> +       .reset = sdhci_sprd_reset,
>         .set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
>         .hw_reset = sdhci_sprd_hw_reset,
>         .get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
> --
> 1.7.9.5
>

Kind regards
Uffe
