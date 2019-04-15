Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD6AC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8232077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fc6Erbs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfDOMpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:45:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37500 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDOMpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:45:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so8536099pgc.4;
        Mon, 15 Apr 2019 05:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2Jbk+XA0OWjgXCKKQtMT9pUcI5jesaoAegi8Sx+lEQ=;
        b=fc6Erbs9Y5DyxddYgwY58UwwzLc5ZzUNN8Sr8k7iCEiFzjmFS2GSX4KJPAbKBEQM/J
         sAcbusbZEKPj+1/6BaFJICColzz9Jw7HQcqHkxM/lFnAEeO8CBMfBN3QX1h6gYAqO/sI
         RSVorg+ud1lylvgFYOl1LtU1BQsuvMWzxzNF5lXA5UlpX4eftrEhhUBdUdH61LTlh2oz
         QnMsIyj9LDsjtjimJRN5fiJ47vaqtqCBIxa+kpyaDRG8BMaOK0uK3b9eaLB+pnc+7+nw
         E1CEvDYyL5A2iKPXcx2FVLlyct7dDR6+GLoU4N0vL1MBeEyXxxMgdU05RKpON25ml5Ye
         YZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2Jbk+XA0OWjgXCKKQtMT9pUcI5jesaoAegi8Sx+lEQ=;
        b=EjpDb1CO1e+HFd/3IbiZIRNM3NyodkuGxWvuubp7Dlodo6XlTZ77nLArCbC2xauzUd
         vkyMUct3/s6kOXiGTVciIqfDnYneKDVuz73odT7/a9iwaJ55DgC2dbzLfiCuC/gIVHNG
         /7MYBBeSwCNrDLxlVVfJ/pblBWfIdy/xnneuchXKGb4gVFP1JYUh4hk6BjDD6L2kz0KT
         5gPSYVxY8Zu2f/KqHP9hp31uRhjvfe7GAEtqaAUKdHTBW5YhsBALAmQdor1a4HAQiMaE
         +0ibFkPmKKtc61FtMU2ttuWniYW2D/lIBtqCNXfHBs8lDPmGWuXAFv1sg3f7t6mW33dX
         2w2g==
X-Gm-Message-State: APjAAAVQ1SNVhMfdJtFS08CdFowEqta0n8j2Z5iV5gQ6Pyo9wZ/1rGek
        QgieZ9vZ+FI1ZwSGSucTKn7A6YaPKnKgOplrXYQ=
X-Google-Smtp-Source: APXvYqzKWmdgMxkzRSfGD+9ho2+CpaMZP3G+svhEOce4rzr315M0JBKyY0wKP8Wqwf1/MAiAEultZoehgVlG81SX8qU=
X-Received: by 2002:a62:448d:: with SMTP id m13mr75740560pfi.182.1555332301258;
 Mon, 15 Apr 2019 05:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com> <20190403124019.8947-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190403124019.8947-5-wsa+renesas@sang-engineering.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Apr 2019 15:44:50 +0300
Message-ID: <CAHp75Vfp_1g-DuTx1mR3bF21qxj47d-+N-JhQyBaXD9cumPB6Q@mail.gmail.com>
Subject: Re: [PATCH 04/12] i2c: mux: populate the new *_atomic callbacks
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Peter Rosin <peda@axentia.se>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 3:42 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> If the parent adapter has atomic_xfer callbacks, populate them for the
> mux adapter as well. We can use the same translation function as for the
> non-atomic xfer callback.
>

Reviewed-by Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/i2c-mux.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index f330690b4125..603252fa1284 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -310,12 +310,18 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>                 else
>                         priv->algo.master_xfer = __i2c_mux_master_xfer;
>         }
> +       if (parent->algo->master_xfer_atomic)
> +               priv->algo.master_xfer_atomic = priv->algo.master_xfer;
> +
>         if (parent->algo->smbus_xfer) {
>                 if (muxc->mux_locked)
>                         priv->algo.smbus_xfer = i2c_mux_smbus_xfer;
>                 else
>                         priv->algo.smbus_xfer = __i2c_mux_smbus_xfer;
>         }
> +       if (parent->algo->smbus_xfer_atomic)
> +               priv->algo.smbus_xfer_atomic = priv->algo.smbus_xfer;
> +
>         priv->algo.functionality = i2c_mux_functionality;
>
>         /* Now fill out new adapter structure */
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
