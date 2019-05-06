Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EFDC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2904520830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAVnErwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfEFJwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:52:05 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44848 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfEFJwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:52:04 -0400
Received: by mail-vs1-f66.google.com with SMTP id j184so7715829vsd.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7C32BeOHi9LlRGL93zM+s3d37K7QLJgWYcD/cg/m730=;
        b=WAVnErwg95cnCiNw0y6zznM4fvgLh7l68dLRoZbgubinUlPRWgiC+/XUFsSyNJnTGT
         Q+RPCsIDipnQPUJ42zP1mpgMiNYV8QAH5uaDDCr1s+Li8fgs6WvAX8547WiFeKgk+wXd
         OxhFlKeAzGVAvXQ3GF/vQmqDK5FnRHIebU3CRxm5zihi4RowEO+oxFCRoLK7QiA/aErz
         cUnabnVL5Qdfryy7G12bx+hl3Ff2zqQNyo1sqEMnvjjTZn4ycOAN8GohojGPHOrG0H2+
         aq0zZB9cbQojqHgdoVyyke44LBUdY9iQ1skFc1ALs++BhyHFh7kQvmVI3/4ziZqzCS7n
         x2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7C32BeOHi9LlRGL93zM+s3d37K7QLJgWYcD/cg/m730=;
        b=bMP5hvX+LvcQ2ebtHdWhXLawQ/kpbJtoRQ3RURHBY+Tda2zGnvIVVIyo0fyOG7Uk5E
         rUB8jDt+6oeiXO5QxBrsRIMg1QHNN3QbvmvK7lMIq2Ve1cLYR6Vymgc1rQsZIOHsWjtd
         F5Lh1Ifnu7iyZBm1wHZ1WeF+7d8aHURS+mC2hWb1NzKrvovnNMmRL3jSMwrQyHCxcoC4
         L1+enYI8uqvlWErVOSEXETMH8nRo2QbZpqwvkSw27s/20BKNJg+ChFs0WqhHIT6VotuN
         Tmo9Ejo368R6b1eIjg+ukdX074JXIzuc7CDy0xpNP0jzyE4kHFi8lhIxdRAk3L8YzugW
         W32w==
X-Gm-Message-State: APjAAAVCsfve1AnDmz7bHQPF3x4WB0aSmyQk5jcs7H4BeW447c4b2pcE
        uqqf7yP0V8zba7XoGRkI+Dp92Vcva8cq27LXF8tvjz/5
X-Google-Smtp-Source: APXvYqxQZg82DMpOHtEW6+isQCwvotsf12luWRxUuyajrE9L/ZsE+FdkaijYnoYJjgC/VCLKuPejcDnXweOSYoTcMUQ=
X-Received: by 2002:a67:cb12:: with SMTP id b18mr12583624vsl.191.1557136323580;
 Mon, 06 May 2019 02:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <1556776696-19300-1-git-send-email-kamlesh.gurudasani@gmail.com>
In-Reply-To: <1556776696-19300-1-git-send-email-kamlesh.gurudasani@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 May 2019 11:51:27 +0200
Message-ID: <CAPDyKFr9kVT-GO75bQxQ4viFtno1fpWes5MWR5XdSHUrFwtUpw@mail.gmail.com>
Subject: Re: [PATCH] mmc: alcor: Drop pointer to mmc_host from alcor_sdmmc_host
To:     Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
Cc:     Oleksij Rempel <linux@rempel-privat.de>,
        Lukas Wunner <lukas@wunner.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2019 at 07:59, Kamlesh Gurudasani
<kamlesh.gurudasani@gmail.com> wrote:
>
> The driver for Alcor Micro AU6601 and AU6621 controllers uses a pointer to
> get from the private alcor_sdmmc_host structure to the generic mmc_host
> structure. However the latter is always immediately preceding the former in
> memory, so compute its address with a subtraction (which is cheaper than a
> dereference) and drop the superfluous pointer.
>
> No functional change intended.
>
> Signed-off-by: Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/alcor.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
> index 7c8f203..5bba6ee 100644
> --- a/drivers/mmc/host/alcor.c
> +++ b/drivers/mmc/host/alcor.c
> @@ -43,7 +43,6 @@ struct alcor_sdmmc_host {
>         struct  device *dev;
>         struct alcor_pci_priv *alcor_pci;
>
> -       struct mmc_host *mmc;
>         struct mmc_request *mrq;
>         struct mmc_command *cmd;
>         struct mmc_data *data;
> @@ -276,7 +275,7 @@ static void alcor_send_cmd(struct alcor_sdmmc_host *host,
>                 break;
>         default:
>                 dev_err(host->dev, "%s: cmd->flag (0x%02x) is not valid\n",
> -                       mmc_hostname(host->mmc), mmc_resp_type(cmd));
> +                       mmc_hostname(mmc_from_priv(host)), mmc_resp_type(cmd));
>                 break;
>         }
>
> @@ -317,7 +316,7 @@ static void alcor_request_complete(struct alcor_sdmmc_host *host,
>         host->data = NULL;
>         host->dma_on = 0;
>
> -       mmc_request_done(host->mmc, mrq);
> +       mmc_request_done(mmc_from_priv(host), mrq);
>  }
>
>  static void alcor_finish_data(struct alcor_sdmmc_host *host)
> @@ -547,7 +546,7 @@ static void alcor_cd_irq(struct alcor_sdmmc_host *host, u32 intmask)
>                 alcor_request_complete(host, 1);
>         }
>
> -       mmc_detect_change(host->mmc, msecs_to_jiffies(1));
> +       mmc_detect_change(mmc_from_priv(host), msecs_to_jiffies(1));
>  }
>
>  static irqreturn_t alcor_irq_thread(int irq, void *d)
> @@ -1025,7 +1024,7 @@ static void alcor_hw_uninit(struct alcor_sdmmc_host *host)
>
>  static void alcor_init_mmc(struct alcor_sdmmc_host *host)
>  {
> -       struct mmc_host *mmc = host->mmc;
> +       struct mmc_host *mmc = mmc_from_priv(host);
>
>         mmc->f_min = AU6601_MIN_CLOCK;
>         mmc->f_max = AU6601_MAX_CLOCK;
> @@ -1073,7 +1072,6 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
>         }
>
>         host = mmc_priv(mmc);
> -       host->mmc = mmc;
>         host->dev = &pdev->dev;
>         host->cur_power_mode = MMC_POWER_UNDEFINED;
>         host->alcor_pci = priv;
> @@ -1105,13 +1103,14 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
>  static int alcor_pci_sdmmc_drv_remove(struct platform_device *pdev)
>  {
>         struct alcor_sdmmc_host *host = dev_get_drvdata(&pdev->dev);
> +       struct mmc_host *mmc = mmc_from_priv(host);
>
>         if (cancel_delayed_work_sync(&host->timeout_work))
>                 alcor_request_complete(host, 0);
>
>         alcor_hw_uninit(host);
> -       mmc_remove_host(host->mmc);
> -       mmc_free_host(host->mmc);
> +       mmc_remove_host(mmc);
> +       mmc_free_host(mmc);
>
>         return 0;
>  }
> --
> 2.7.4
>
