Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402C2C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F1E2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTx5iUnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfE1IxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:53:17 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:32867 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE1IxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:53:16 -0400
Received: by mail-vs1-f68.google.com with SMTP id y6so12298310vsb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6DOKZZBuQ4FIK7BFhI7zXJDJCYNb+EAsV49etM5Qw9E=;
        b=dTx5iUnHM/CY9J8aWugKpVrabCL/wQnfT4iMvXtQvLqdukV5bMttr04yeu8LBwLeWt
         WezYDrZAWZKOkwhj05aQ7cZdjzEkItKVpPpW09nsvEgl7gVfv3Oa/zDrGAMUqloDAtuL
         aISBEVB2/kZjuUrikfpL7wjqqvROQ45cXGcJEAJLH8oXMO/brzwkk9lJO0SUNDPi/yPp
         OK6Y25R3e3t4KlQEXl15ODbujKaLkxSQUQeGt6UIluKXCOKz/rKberoFA7swcNT0fkFf
         c2f8q1nktBqGEYHP3UVoJGm8Yc8mMcSZIXXlB06UE0chLRK0DC3NYWG/RSZr4QjtW+xo
         1TYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6DOKZZBuQ4FIK7BFhI7zXJDJCYNb+EAsV49etM5Qw9E=;
        b=HeWppA298EXgXTTvdALN7+JQb4bQKbQkH3HYgjwDWhMiT2ay3pONceOJEaya7dABNR
         RpD7AFWhQphOrHUWeRRw4ciT17aCxqO746M0S79iGGHlhc2uXQeIXQW0XrEHxcWVKVXW
         y/gYHxwDnlYFzqG+sRInxIT8kkMnMDD/pjHjtKZujW7hXo5CocGEgUiTKBBX+aG0jJee
         8IFT7K6TC+/5eY7IbgrLq0Rm6aZjjP6hgLQUXYIOss+xAIJIviHJaan0WMxZnYNua8Cf
         ic6RO7rl1WIVmC1v4vvnrdjx3MujxLkqSThD7eDn5HiQL/dIZdrzt9KtfdlB7CIdDGfp
         31/g==
X-Gm-Message-State: APjAAAVmvdXeqHYpQQe5lYDJI/jmDphz72tNmPrSLpURGjkBQi2/o7Fh
        gGaqHQJTvvhSWenMB1rUyNyWDiZHHrIEjn8y/mM98Q==
X-Google-Smtp-Source: APXvYqyt1Oz/elOHJJHAbCdWazjC8Ws+luiU4VvF3+goqXkou1XWl5bSM5jGjiPpsuYuWWGfyOR4xd5YGC++/cob+z0=
X-Received: by 2002:a67:7c58:: with SMTP id x85mr37939407vsc.191.1559033595375;
 Tue, 28 May 2019 01:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <1557258749-29009-1-git-send-email-kamlesh.gurudasani@gmail.com>
In-Reply-To: <1557258749-29009-1-git-send-email-kamlesh.gurudasani@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 May 2019 10:52:39 +0200
Message-ID: <CAPDyKFpbYWdLfecru4+Y9zRrdpnzgwwMmCbqDZUwaXoei5o28Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: android-goldfish: Drop pointer to mmc_host from goldfish_mmc_host
To:     Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Lockwood <lockwood@android.com>,
        Christoph Hellwig <hch@lst.de>,
        "Gustavo A . R . Silva" <garsilva@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2019 at 21:53, Kamlesh Gurudasani
<kamlesh.gurudasani@gmail.com> wrote:
>
> The driver for android-goldfish uses a pointer to get from the private
> goldfish_mmc_host structure to the generic mmc_host structure.
> However the latter is always immediately preceding the former in
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
>  drivers/mmc/host/android-goldfish.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
> index 61e4e2a..f6334c2 100644
> --- a/drivers/mmc/host/android-goldfish.c
> +++ b/drivers/mmc/host/android-goldfish.c
> @@ -113,7 +113,6 @@ struct goldfish_mmc_host {
>         struct mmc_request      *mrq;
>         struct mmc_command      *cmd;
>         struct mmc_data         *data;
> -       struct mmc_host         *mmc;
>         struct device           *dev;
>         unsigned char           id; /* 16xx chips have 2 MMC blocks */
>         void                    *virt_base;
> @@ -175,7 +174,7 @@ goldfish_mmc_start_command(struct goldfish_mmc_host *host, struct mmc_command *c
>                 resptype = 3;
>                 break;
>         default:
> -               dev_err(mmc_dev(host->mmc),
> +               dev_err(mmc_dev(mmc_from_priv(host)),
>                         "Invalid response type: %04x\n", mmc_resp_type(cmd));
>                 break;
>         }
> @@ -221,8 +220,8 @@ static void goldfish_mmc_xfer_done(struct goldfish_mmc_host *host,
>                                         data->sg->length);
>                 }
>                 host->data->bytes_xfered += data->sg->length;
> -               dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_len,
> -                            dma_data_dir);
> +               dma_unmap_sg(mmc_dev(mmc_from_priv(host)), data->sg,
> +                            host->sg_len, dma_data_dir);
>         }
>
>         host->data = NULL;
> @@ -236,7 +235,7 @@ static void goldfish_mmc_xfer_done(struct goldfish_mmc_host *host,
>
>         if (!data->stop) {
>                 host->mrq = NULL;
> -               mmc_request_done(host->mmc, data->mrq);
> +               mmc_request_done(mmc_from_priv(host), data->mrq);
>                 return;
>         }
>
> @@ -278,7 +277,7 @@ static void goldfish_mmc_cmd_done(struct goldfish_mmc_host *host,
>
>         if (host->data == NULL || cmd->error) {
>                 host->mrq = NULL;
> -               mmc_request_done(host->mmc, cmd->mrq);
> +               mmc_request_done(mmc_from_priv(host), cmd->mrq);
>         }
>  }
>
> @@ -313,7 +312,7 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
>                 struct mmc_request *mrq = host->mrq;
>                 mrq->cmd->error = -ETIMEDOUT;
>                 host->mrq = NULL;
> -               mmc_request_done(host->mmc, mrq);
> +               mmc_request_done(mmc_from_priv(host), mrq);
>         }
>
>         if (end_command)
> @@ -339,12 +338,13 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
>                 u32 state = GOLDFISH_MMC_READ(host, MMC_STATE);
>                 pr_info("%s: Card detect now %d\n", __func__,
>                         (state & MMC_STATE_INSERTED));
> -               mmc_detect_change(host->mmc, 0);
> +               mmc_detect_change(mmc_from_priv(host), 0);
>         }
>
>         if (!end_command && !end_transfer && !state_changed && !cmd_timeout) {
>                 status = GOLDFISH_MMC_READ(host, MMC_INT_STATUS);
> -               dev_info(mmc_dev(host->mmc),"spurious irq 0x%04x\n", status);
> +               dev_info(mmc_dev(mmc_from_priv(host)), "spurious irq 0x%04x\n",
> +                        status);
>                 if (status != 0) {
>                         GOLDFISH_MMC_WRITE(host, MMC_INT_STATUS, status);
>                         GOLDFISH_MMC_WRITE(host, MMC_INT_ENABLE, 0);
> @@ -383,7 +383,7 @@ static void goldfish_mmc_prepare_data(struct goldfish_mmc_host *host,
>
>         dma_data_dir = mmc_get_dma_dir(data);
>
> -       host->sg_len = dma_map_sg(mmc_dev(host->mmc), data->sg,
> +       host->sg_len = dma_map_sg(mmc_dev(mmc_from_priv(host)), data->sg,
>                                   sg_len, dma_data_dir);
>         host->dma_done = 0;
>         host->dma_in_use = 1;
> @@ -461,7 +461,6 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
>         }
>
>         host = mmc_priv(mmc);
> -       host->mmc = mmc;
>
>         pr_err("mmc: Mapping %lX to %lX\n", (long)res->start, (long)res->end);
>         host->reg_base = ioremap(res->start, resource_size(res));
> @@ -508,8 +507,7 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
>
>         ret = device_create_file(&pdev->dev, &dev_attr_cover_switch);
>         if (ret)
> -               dev_warn(mmc_dev(host->mmc),
> -                        "Unable to create sysfs attributes\n");
> +               dev_warn(mmc_dev(mmc), "Unable to create sysfs attributes\n");
>
>         GOLDFISH_MMC_WRITE(host, MMC_SET_BUFFER, host->phys_base);
>         GOLDFISH_MMC_WRITE(host, MMC_INT_ENABLE,
> @@ -525,7 +523,7 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
>  dma_alloc_failed:
>         iounmap(host->reg_base);
>  ioremap_failed:
> -       mmc_free_host(host->mmc);
> +       mmc_free_host(mmc);
>  err_alloc_host_failed:
>         return ret;
>  }
> @@ -533,14 +531,15 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
>  static int goldfish_mmc_remove(struct platform_device *pdev)
>  {
>         struct goldfish_mmc_host *host = platform_get_drvdata(pdev);
> +       struct mmc_host *mmc = mmc_from_priv(host);
>
>         BUG_ON(host == NULL);
>
> -       mmc_remove_host(host->mmc);
> +       mmc_remove_host(mmc);
>         free_irq(host->irq, host);
>         dma_free_coherent(&pdev->dev, BUFFER_SIZE, host->virt_base, host->phys_base);
>         iounmap(host->reg_base);
> -       mmc_free_host(host->mmc);
> +       mmc_free_host(mmc);
>         return 0;
>  }
>
> --
> 2.7.4
>
