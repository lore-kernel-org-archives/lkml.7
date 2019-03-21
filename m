Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51008C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E62C21873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSFfe50m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfCUJcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:32:03 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40874 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUJcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:32:03 -0400
Received: by mail-yw1-f65.google.com with SMTP id p64so3431023ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=tsT6cHti1AlaZnmUeQoYVeuvfMR1EJIl4KQ/GShxNfY=;
        b=uSFfe50miuZGqrZkkTVU/5CCPFuGPSDBY3HTZD/XHfc6SxFFXA2MV//BxSYsrtshzn
         cALatMGNrjrGhAnl3O6e/Ijlkyg4EiqyAimoaDa2A+OYvot0MjGtHJm7q7thYaW4YgRy
         ws3AW/qYhz0gF709oo2lFuFlEE+LL14JDiEspfVcTI7YxHq2kCeGtVofObwg7Bl6UZgK
         tFmnL2ykq4wBonPt8TTRGvqg8vlVHD99/J0IYhl17B7vrvekdfZjAaYMbCVmfPiw5kpe
         WrT2Uh5U9U+dSM62fHrScgcvgILN2mmBAUZofwZPSXNKVnPA+6IS2RaDNxfkmgK60GcY
         wQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=tsT6cHti1AlaZnmUeQoYVeuvfMR1EJIl4KQ/GShxNfY=;
        b=P8fsq5X0AgdI8IWrFoq7Yk1o19ZwITxlGv8NZ9dkBgdX6FJDfJN2PyNIiUP4teKBvz
         A2HYQ4K1jBQCxjVHQRe8Uk2y5w7zuye66ajlis8T0TV9d3TPDwJaExbjwaDHw/vLxyyr
         e018QOkE9I0cnuF89vPzx+4sKIqEs/calu1cuqTldqdC6Fb49tGApLNCZ8n+BbQBFN30
         84heuZt2UlkEf1w2RgFSgf5zJ4qt8WKp2FLJt2QUSlME+rBMcYy7Z2xaTavpZOzkuKvp
         ZgISSPj0KFRC2adCLS8+7iGCqmDHVXh0wK8CyV6eGyzH+q91Q4eUv+xgJbm70RXgEP5O
         MSxw==
X-Gm-Message-State: APjAAAUTKhRIYBUCibFiLEer31UT5kgstMiP9YbIf97HJdP5H7zHuoXq
        kbBweHYUVJHFThnEn5VIjclSihLGA37WBiWIvYElUaJM
X-Google-Smtp-Source: APXvYqyNdFiEKmnY8XF29Dk+uN7whEM3niEj3DBnWrcB+ibeN4kNPq7RhRSz/arg5YiKZe8KpvoOUgn07OwpwLloVFM=
X-Received: by 2002:a81:6d51:: with SMTP id i78mr2098730ywc.273.1553160722452;
 Thu, 21 Mar 2019 02:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190319020519.15209-1-tsu.yubo@gmail.com>
In-Reply-To: <20190319020519.15209-1-tsu.yubo@gmail.com>
From:   Bo YU <tsu.yubo@gmail.com>
Date:   Thu, 21 Mar 2019 17:31:51 +0800
Message-ID: <CAKq8=3K26Vbg4Vk4+C4F6vjB5mv8SiSxe7mBxLrtph3MHGdi+A@mail.gmail.com>
Subject: Re: [PATCH] misc/fastrpc: add checked value for dma_set_mask
To:     Arnd Bergmann <arnd@arndb.de>,
        Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5LqO5rOi?= <yuzibode@126.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:05 AM Bo YU <tsu.yubo@gmail.com> wrote:
>
> There be should check return value from dma_set_mask to throw some infos
> if fail to set dma mask.
>
> Detected by CoverityScan, CID# 1443983:  Error handling issues (CHECKED_RETURN)
>
> Fixes:f6f9279f2bf0 (misc: fastrpc: Add Qualcomm fastrpc basic driver model)
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
>  drivers/misc/fastrpc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 39f832d27288..36d0d5c9cfba 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1184,6 +1184,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>         struct fastrpc_session_ctx *sess;
>         struct device *dev = &pdev->dev;
>         int i, sessions = 0;
> +       int rc;
>
>         cctx = dev_get_drvdata(dev->parent);
>         if (!cctx)
> @@ -1213,7 +1214,11 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>         }
>         cctx->sesscount++;
>         spin_unlock(&cctx->lock);
> -       dma_set_mask(dev, DMA_BIT_MASK(32));
> +       rc = dma_set_mask(dev, DMA_BIT_MASK(32));
> +       if (rc) {
> +               dev_err(dev, "32-bit DMA enable failed\n");
> +               return rc;
> +       }
>
Ping?
Do me need resend it?
>         return 0;
>  }
> --
> 2.11.0
>
