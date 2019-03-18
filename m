Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E390C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218EB2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHDf5aT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfCRKwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:52:31 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44678 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfCRKwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:52:30 -0400
Received: by mail-vs1-f65.google.com with SMTP id b8so9134421vsq.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMGLx+XnQCwq3JDW1LJu67KVkTGjDODmGRosoQaGcBs=;
        b=uHDf5aT58Hd6jknm8JWZWmU6V+lDmYJ3uBMyokXPWYYjktZd2mI8d/GwAdQYUzoUDp
         oTDy3BesMtPN8PmmaWDfELHJddp+wvbF882MN4HW2pgl0iUO6yAzxJ/rfm+0COsmhF4r
         2fuoSNQqN5/ae2TdA9IOFIhnmEI/vqSMpLi1y222VBKdHOInbzcc2F2zbwrK6ywVH0cx
         zyH5O+LWYtBuAhk2zRe7ZOFdiUnk0B4V3qA0i7M8aOBf3llGfnnJpHBRJAl9wpdd9Wij
         N2EPuLiovAZ416xTJhMN65y/hcvvdvOUp2osaVm+Dz3tLzhQN+pO0o5THhew5cHnikZL
         6c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMGLx+XnQCwq3JDW1LJu67KVkTGjDODmGRosoQaGcBs=;
        b=ttrGzsPiOmozktIBIFDMtaddCD/PBhnrltjcjP4sT/+0hDsqNZs3eGics/H57hvWw8
         0dUdp9HueH15dlvW7Xf/gYzfa4VviMQfZcB0NTGR1H/QeCrB+WCrexYoMwybasNMvx2u
         APblSBcvpEVPoRfpjeg1X7eyPEddYjlE4H3gVYL+ENm5Q/S0yLcePNO3fTi3VS0J7fdr
         P7T2BBKhLr5FgXy3WzaZrcc7RM81lAIExe8dbkRQBTHyVpXFPHpGVnLBBI8dISf1di2L
         jwVeV9PhIJovp5T60dr0Kns4JVpxJ1yN7lWbW8BPOpq/P7AiJ9MkUOVowbDtU9zDHpen
         kvfA==
X-Gm-Message-State: APjAAAWpndD6scoO0T+oRWmG8x1dhFnlsMRSWuUBmQ32wzSMT1CHdi4K
        NGuDFFamFN+haxLvZGxGdOLbzq3ZBX1A5V5DgXdQ3g==
X-Google-Smtp-Source: APXvYqzWM6CQx6z/nEGkapi+ilEsu4pWfStGxsB3RnzL7MzaqSMC/OUvvgAvzc88bMXZYWe3TlOLoYHPaOImubUO5rQ=
X-Received: by 2002:a67:fd17:: with SMTP id f23mr8667443vsr.35.1552906349751;
 Mon, 18 Mar 2019 03:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190311055334.13670-1-kjlu@umn.edu>
In-Reply-To: <20190311055334.13670-1-kjlu@umn.edu>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Mar 2019 11:51:53 +0100
Message-ID: <CAPDyKFojFP=vrd6+bC6t1qwRgesGvci3U9cQnUWwtcN4Ya2aZA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc_spi: add a status check for spi_sync_locked
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 at 06:53, Kangjie Lu <kjlu@umn.edu> wrote:
>
> In case spi_sync_locked fails, the fix reports the error and
> returns the error code upstream.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 1b1498805972..a3533935e282 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -819,6 +819,10 @@ mmc_spi_readblock(struct mmc_spi_host *host, struct spi_transfer *t,
>         }
>
>         status = spi_sync_locked(spi, &host->m);
> +       if (status < 0) {
> +               dev_dbg(&spi->dev, "read error %d\n", status);
> +               return status;
> +       }
>
>         if (host->dma_dev) {
>                 dma_sync_single_for_cpu(host->dma_dev,
> --
> 2.17.1
>
