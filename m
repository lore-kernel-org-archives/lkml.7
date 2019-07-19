Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480E8C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 22:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B87B2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 22:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJ8Zlv4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbfGSWgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 18:36:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42724 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfGSWgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 18:36:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so15038225pgb.9;
        Fri, 19 Jul 2019 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypddKFUJPSx+g8aH7xVUBGH+0NoLzqnJbZasoMteu7U=;
        b=qJ8Zlv4Hrl9/b7uaDbUr4OAD/R96SKPaLPkTd/1o47NioB/CIQ4JKObmKomUG1+4eR
         8cVdJbKImmezfyrZDxalFqvEwC/JuA+pJffbxnUcQ9E1w6J81XFzZiYbDAo571n0dQgg
         rzVDXraDnQT6CfJdXRvHeyTnwkfX8YFdfXWg29bch16nvGtaQYXviFX/rvlQ1JNRrvm8
         KCyQVe6or92iARGhSun/rKK7IhkVyW1WGITOb2kWNU/x0Umr8sRlFqO64KhikAsC18P9
         Oy8h2HUas7ZM9ql7Fu+N/XvXTOZC6o1US8DTaf4MNUkWlH805gCwYPzIbWRnNhdYV+Ph
         Nc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypddKFUJPSx+g8aH7xVUBGH+0NoLzqnJbZasoMteu7U=;
        b=XD9i4I/bs6k1OnMq7+O7jcF7u76OsnkQZyyDoSJrPGaIid+ODXEePT+75xMYxLpujB
         edbZdrBzJx3Z2cbdQYy9zeLIwNEYA8F/lr0RegTgCRbQ31gpGC4L2ZXX/oJnZ3Q+l4PZ
         0JVG0gLWCY1E9zt7vfzfd9zm3pTDBiRPDYtSFz/QnWtCe8AZtDEWkg4M8edv/NuaI6Y0
         g+bE5sD4dUFX0YspS/rstWBn5BFOYeZwMSogZ+rcDuKKlTWFOUuzpZnh9wqhtq9dBGYK
         yOrnue3LQO28BZ/AlvV0Z4twJJhtDpPiaoBEdRXUdaX62LMutkbs+oA2tFVxHKh/pAQ9
         L6CA==
X-Gm-Message-State: APjAAAXFC+wgmTe3b2YeFGXJLMAS53Lt7eUCEkNxgV7dmlfbQnrPv/jK
        SfFrbauzaXziGxD1tkdMfaUhLEMi8/Y+qX9WL8c=
X-Google-Smtp-Source: APXvYqxG0c8/OtW4UytwNDFpf0p+JNeQE1OrFwx/7BkugCdrg3Y+tXmYmjrdSfwVStmHWRRPUiE5KzUnoxwPdBr+NPk=
X-Received: by 2002:a63:e54f:: with SMTP id z15mr56417018pgj.4.1563575763050;
 Fri, 19 Jul 2019 15:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190719181200.25607-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190719181200.25607-1-navid.emamdoost@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Jul 2019 01:35:51 +0300
Message-ID: <CAHp75VcRC0XA87N=cSFJnSZ31max1UxyB=tJmE++A_+-TxGX2Q@mail.gmail.com>
Subject: Re: [PATCH] lpss8250_dma_setup: there is memory leak when second
 allocation fails
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, Kangjie Lu <kjlu@umn.edu>, smccaman@umn.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 20, 2019 at 1:23 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> in lpss8250_dma_setup, we need to release the first dma slave object
> allocated in case of the second allocation failure.
>

This will bring a double free instead of fixing anything.

NAK.

> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_lpss.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
> index d07e431110d9..6e1f86db88b2 100644
> --- a/drivers/tty/serial/8250/8250_lpss.c
> +++ b/drivers/tty/serial/8250/8250_lpss.c
> @@ -259,8 +259,10 @@ static int lpss8250_dma_setup(struct lpss8250 *lpss, struct uart_8250_port *port
>                 return -ENOMEM;
>
>         tx_param = devm_kzalloc(dev, sizeof(*tx_param), GFP_KERNEL);
> -       if (!tx_param)
> +       if (!tx_param) {
> +               kfree(rx_param);
>                 return -ENOMEM;
> +       }
>
>         *rx_param = lpss->dma_param;
>         dma->rxconf.src_maxburst = lpss->dma_maxburst;
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
