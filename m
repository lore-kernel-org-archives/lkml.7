Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EDCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF4B2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcxtl8g+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfCOJEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:04:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46238 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfCOJEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:04:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id s23so5861617pfe.13;
        Fri, 15 Mar 2019 02:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPoiQV0RRGf1/dW+RIXf3iiaL38X7KkyBkK+7RIVa40=;
        b=dcxtl8g+lrfPLERPW4HkAAo8N0vEmh39tLrGJtUhBXWu1yTN/oHiNP/gu1J9l2QRHg
         CeNvzzJxXKSed/ixjcdJVT2jnPLJNRpmGs9g1GS5zHgOU+s10yiOx0XHI1g2lpiBAJv8
         iL5cQ83mjEMIUhL1urLzrkuhmSKWxQPJphy1Zap861LM3J0PKGfYf5oV7eTxP6An22Yq
         EzO7YMnqgUn9x5bu3/0/QjWjl6INn2s9JHXBcRWodNptc6d/8MzJ5vC+aIosk+qIWoif
         Oa4jLQHWPBkVjC0/07IFloUSUv4TgcpZqM4E2+9z3gXIWV6Dm/pLgPnSSdbTo9cCxlnu
         VKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPoiQV0RRGf1/dW+RIXf3iiaL38X7KkyBkK+7RIVa40=;
        b=Td2FKFtyHITP1H+/yrzNaazkHMOjmv1kHJpnp/21yEjyObOh4jHPpcCbr5Ck1gPGP4
         DfBSyCf9d9ZOhZ4LGwZ5JYsJd22MZNHq/94J/BMMywNB/dJQuThEB1i3RDBx4fXWdzsj
         0/cztdAEnvxH+2qaQEM4w6rjj9XFv03ftJLuxSqMPKAnSZrBdQ6Vwzxl14xpw5z6NHKf
         CxSnococ1EFYiYVVfUpv/96DVVVzFy3DXrFgQ+CPefbpvgHJJDVeTaQGpLsNgIUWLKo5
         gv+gic0uS3OhPTk5OF+7TeQAwIWg6XeCh73Gn83xTopxRWD+nFcedio82dTP9FEjnQKy
         nj+w==
X-Gm-Message-State: APjAAAW9tPvgEUujVd0bc6xRk3iUKtjUOGXJw5Oee7fzbGCypdrESY8r
        lQxSh0TxTfe/UPPedUPxgMg/B3hhICubdFYmqr7kI+Px
X-Google-Smtp-Source: APXvYqzOwi/B7Zkr+Lw3gDbTdHv03frg8D0ZKIR7kpZxhfs335MCtKi3ngN7V8nVoqfXP8mfpPgACfQGguUGbeJR9IE=
X-Received: by 2002:a17:902:7289:: with SMTP id d9mr3048159pll.314.1552640664120;
 Fri, 15 Mar 2019 02:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <1552602855-26086-1-git-send-email-info@metux.net> <1552602855-26086-3-git-send-email-info@metux.net>
In-Reply-To: <1552602855-26086-3-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Mar 2019 11:04:12 +0200
Message-ID: <CAHp75VegzKNhH1Uza9gwQMOAEOdh57WTzsHUx7vPdVs7XvJROQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/45] drivers: tty: serial: 8250_dw: use devm_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        macro@linux-mips.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@gmail.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, baohua@kernel.org,
        Peter Korsgaard <jacmet@sunsite.dk>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 12:41 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Instead of fetching out data from a struct resource for passing
> it to devm_ioremap(), directly use devm_ioremap_resource()

I don't see any advantage of this change.
See also below.

> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -526,7 +526,7 @@ static int dw8250_probe(struct platform_device *pdev)
>         p->set_ldisc    = dw8250_set_ldisc;
>         p->set_termios  = dw8250_set_termios;
>
> -       p->membase = devm_ioremap(dev, regs->start, resource_size(regs));
> +       p->membase = devm_ioremap_resource(dev, regs);
>         if (!p->membase)

And how did you test this? devm_ioremap_resource() returns error
pointer in case of error.

>                 return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko
