Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E07AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E64E233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Joha3CS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbfHVMOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:14:00 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42113 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388392AbfHVMNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:13:53 -0400
Received: by mail-vs1-f66.google.com with SMTP id b187so3661023vsc.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6/IjtBPVj0Oz4iJYzEDbuqonF1ZiM27DpCa69vmHwc=;
        b=Joha3CS+69v3l15rP/aCLwahlRT79HSR53vcRKRD19ch/SeKqLtDd14wSG9/aPbfRd
         l9rvapek5GoET3eH7i+sCraqajqS0AOAb/FrIkoTuWuqRXn+serk9ID311WqWdd8Bk6x
         tDXnI12KtaeMX/1o5YVOEHferPVRaYlZiyjR3iT3NmG+oV9d0BcbGbSKl2T2/JcVNOAa
         ahUcQjDD47ueJ6dTeLrwVNbO2Cb5Ch5uLv4yntlMu6llx6RUNFlnmnzvZ7J46SIsjn6Q
         y7Ar31OGKqMSh3EABmGu6BAYK29iqImtdlriR64YSTPXyfwqjiWdixjl6vTr5eJZ5/6v
         furQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6/IjtBPVj0Oz4iJYzEDbuqonF1ZiM27DpCa69vmHwc=;
        b=D3zLY/UUm/jrLEMmMJRwn0X+aa15V57HlhDmX3tYVkj0vCDd7LfdAhramV6nYQ93gI
         RKh7fvShKdFb7Yq4an0CQZrPN1Ysxtcc5qCskPB51iRMthkz//JezTroxxl4YbG5Cj6q
         LR5QqEhA5QTp+CqKGxVSZT+rXLgqtMlJBfBUovsPwX/2XEYltuVfP1vj3WlxCNh7jjRf
         HmwVn4FB77uP3olHICQSHPqDcJgxpJjQMw9uXWLc7nBgn3l2uUKqEg7MLsG2aE1Gxz3g
         Q/9ilZHS5BgyQccMD7WWTNMdSM5UO0sDDgl+/EkmV5uYv4q5c6xMAk0LoBsWSHThU8xf
         r4Hw==
X-Gm-Message-State: APjAAAUbKKxketBkdH+OsKNyxH8o6diqu7VubzE9XT65ZxXKPGBoJfYT
        Gx8DMvwIxxbyo5Ch+R3lo/rfhxG154UY5Djpi6UmeQ==
X-Google-Smtp-Source: APXvYqyhQ/ujxJj+dVFADP98FB6B+BRSrIpjyWbp9YXdhDJfkng0dqPjtRh6NyZiqzTkyemUxcsWScmqEbs0yEb9oAY=
X-Received: by 2002:a67:347:: with SMTP id 68mr18766574vsd.35.1566476031413;
 Thu, 22 Aug 2019 05:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190810121608.24145-1-paul@crapouillou.net> <20190810121608.24145-2-paul@crapouillou.net>
In-Reply-To: <20190810121608.24145-2-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 14:13:15 +0200
Message-ID: <CAPDyKFqMmCcsJi9r9j24wW9gOPsYr+t5TrryqpJ3=EH0ANwi9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: jz4740: Drop dependency on arch header
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Aug 2019 at 14:16, Paul Cercueil <paul@crapouillou.net> wrote:
>
> We don't need to set the 'slave_id' anymore - that field is never read
> by the DMA driver.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 59f81e8afcce..7ff2034d739a 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -25,8 +25,6 @@
>
>  #include <asm/cacheflush.h>
>
> -#include <asm/mach-jz4740/dma.h>
> -
>  #define JZ_REG_MMC_STRPCL      0x00
>  #define JZ_REG_MMC_STATUS      0x04
>  #define JZ_REG_MMC_CLKRT       0x08
> @@ -292,11 +290,9 @@ static int jz4740_mmc_start_dma_transfer(struct jz4740_mmc_host *host,
>         if (data->flags & MMC_DATA_WRITE) {
>                 conf.direction = DMA_MEM_TO_DEV;
>                 conf.dst_addr = host->mem_res->start + JZ_REG_MMC_TXFIFO;
> -               conf.slave_id = JZ4740_DMA_TYPE_MMC_TRANSMIT;
>         } else {
>                 conf.direction = DMA_DEV_TO_MEM;
>                 conf.src_addr = host->mem_res->start + JZ_REG_MMC_RXFIFO;
> -               conf.slave_id = JZ4740_DMA_TYPE_MMC_RECEIVE;
>         }
>
>         sg_count = jz4740_mmc_prepare_dma_data(host, data, COOKIE_MAPPED);
> --
> 2.21.0.593.g511ec345e18
>
