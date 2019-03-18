Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290BEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E688F2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DM1QWjIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfCRKwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:52:08 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39554 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfCRKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:52:06 -0400
Received: by mail-vs1-f67.google.com with SMTP id g127so2072144vsd.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVuSGUYdtpkK18asX48WwKR5v7JHAbgLC86VlSQYuzs=;
        b=DM1QWjIJICXdTJH2MY72WblxsOBLXIQS5Ufzfq8W84LWlEfUlrTLXd10cqE+13hrM6
         QQYMXdgX/1H/XUpiLXw5ISVpsO91rmVPcy10Xnvrmw6kqy4dc9F7RciqR3vD5AHfQmxi
         d0KV7lKv1XO075sidMrwcSfgdOZYvwP6z+sHZzPfn1zR4ZhGYu5BZL8ZRn61WYztsjpm
         PzZZAte+Cimh9+xMXJLpCajmXlFf8Bpcym69pu5gqGPt7CJ6uQM3Akf2X1qVZJfw1SQB
         CifbaDVmMa7miZNLl4vvNdyiK+9KWovxLHYVU1Q7uNP++mzpKvQ4mwLFLjkfGMy1hrwq
         QA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVuSGUYdtpkK18asX48WwKR5v7JHAbgLC86VlSQYuzs=;
        b=C8ywhWalUYUPId0YjGBdg0/wbU+Nzx3TjXcgDq2I4zfa+6Fv1mRWQGaCHQN2KrvoxZ
         lniIvBZR5k1FnoGxKz0ZJAoa97NfEUUiaG0+SvLVuvG3QDx8u3rrIaC24U+5jgabDKHB
         8vH0k9OZicfn5FNOHqGqQpAoZ9rYXSKzeIFSQfzYXRJsQrVNdilFnfTOwHw99LKWo5+9
         9xrwNm0O5mvJ25TqpMTbVYn9hDZxSc7CUqk+0UiyOlei6oRHRncJGAXpf2gL3+OKZ0S2
         Ij3o4pqlWTzo1qX1C8cuwK4dFZ/nfc/gTi4rAzHqqG6YuHG1CmoQJKWzHmSlRBnavrKI
         nruA==
X-Gm-Message-State: APjAAAW9wTfxex+q+LgOhLUTK1HiqMLDaBZ9Aby5rIGsNSCOVWrnubYR
        7TtRVZPKh5oL3x4O3dxDS/XjA6eeNbIPVzyCd1eZ+A==
X-Google-Smtp-Source: APXvYqwtuuIHA05WlMsM3fakhU6fJYClg2oPx3tINNpyw57GmjZsApwePIQGvU7+z5wCuHUmeSYZw4LNVTBhNSGyedo=
X-Received: by 2002:a67:c902:: with SMTP id w2mr8707335vsk.191.1552906325627;
 Mon, 18 Mar 2019 03:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190307101024.594587-1-arnd@arndb.de>
In-Reply-To: <20190307101024.594587-1-arnd@arndb.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Mar 2019 11:51:29 +0100
Message-ID: <CAPDyKFpod7t4T46Ag6SzLgzRPr3T_XDhrDfRGTuJ0Ru5_0MQ2Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci: remove extraneous __init annotation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2019 at 11:10, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Building with clang finds a mistaken __init tag:
>
> WARNING: vmlinux.o(.text+0x5e4250): Section mismatch in reference from the function davinci_mmcsd_probe() to the function .init.text:init_mmcsd_host()
> The function davinci_mmcsd_probe() references
> the function __init init_mmcsd_host().
> This is often because davinci_mmcsd_probe lacks a __init
> annotation or the annotation of init_mmcsd_host is wrong.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 49e0daf2ef5e..f37003df1e01 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1117,7 +1117,7 @@ static inline void mmc_davinci_cpufreq_deregister(struct mmc_davinci_host *host)
>  {
>  }
>  #endif
> -static void __init init_mmcsd_host(struct mmc_davinci_host *host)
> +static void init_mmcsd_host(struct mmc_davinci_host *host)
>  {
>
>         mmc_davinci_reset_ctrl(host, 1);
> --
> 2.20.0
>
