Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1304AC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA94B214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 07:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2/dCYSvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfCRHpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:45:30 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:22513 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfCRHp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 03:45:29 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x2I7j3QV016263;
        Mon, 18 Mar 2019 16:45:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2I7j3QV016263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552895104;
        bh=3ix53cwSg7wpTPsOZzwByaZewljMUWKcbgwMN//A5Q4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2/dCYSvNbG8BcJy5jWvlnRIDp3UI6fkUf+TZGQWfUSB0hxFfy6qAwdbVQQQk9tU7j
         fc/h19uzr/tLU/+0AypOqvvAvAyS1qCUMnA+gqXczR3z2M2bpxTHMRAujbkUtjbRcN
         5cDunN2XFJuSchtjq9BADODw0CbUleroYuZuGL/+YI5NCX8TbKxZG8+FB0OaQ0QBKw
         LOVTiwBswPREHMsU6HyAE5H87EFgW8FXfRdn5GRUlU/w3mRuu9WUgzZJ5PONaoGn2c
         W5xyi99VyO5IfhzRiipRULjnNQNdNEVVw0of/hzU39JB0TsIk+SdLV9k/Vn+Iu8FJs
         8N3xLn5TXpkVw==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id g127so1798264vsd.6;
        Mon, 18 Mar 2019 00:45:03 -0700 (PDT)
X-Gm-Message-State: APjAAAVS0Cw2l92O9U5O1Rqd4mZuN/7PKMETrX+IpCnhNkp6QKVfvdzN
        /WFV4wZqziRKkjK4JxSQiPBduNEWYCWmGeXskVU=
X-Google-Smtp-Source: APXvYqyNijpqNVoW+bWF9eEp2LsjyfAuO7SHhsoKO0R2rUk+XQQSybYzte9XvRxtwUk8OvStMi0b8nTnqgwbUoIR9Oo=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr4107181vsc.54.1552895102473;
 Mon, 18 Mar 2019 00:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <1552602855-26086-1-git-send-email-info@metux.net> <1552602855-26086-8-git-send-email-info@metux.net>
In-Reply-To: <1552602855-26086-8-git-send-email-info@metux.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 18 Mar 2019 16:44:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT6p41J+voYdrOtPkiq92sRDNv6nbrBdVKsWZYGENxsWw@mail.gmail.com>
Message-ID: <CAK7LNAT6p41J+voYdrOtPkiq92sRDNv6nbrBdVKsWZYGENxsWw@mail.gmail.com>
Subject: Re: [PATCH v2 07/45] drivers: tty: serial: 8250_uniphier: use devm_ioremap_resource()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
        Barry Song <baohua@kernel.org>, jacmet@sunsite.dk,
        linux-serial@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 7:35 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Instead of fetching out data from a struct resource for passing
> it to devm_ioremap(), directly use devm_ioremap_resource()
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---


NACK.


This patch would break my driver.

Probably, all the 8250* drivers would be broken in the same way.


For 8250 drivers, request_mem_region() is called
from 8250_port.c


Let's not touch around the code you do not
understand how it works.


Thanks.

Masahiro Yamada



>  drivers/tty/serial/8250/8250_uniphier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
> index 164ba13..9c1244e 100644
> --- a/drivers/tty/serial/8250/8250_uniphier.c
> +++ b/drivers/tty/serial/8250/8250_uniphier.c
> @@ -171,7 +171,7 @@ static int uniphier_uart_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> -       membase = devm_ioremap(dev, regs->start, resource_size(regs));
> +       membase = devm_ioremap_resource(dev, regs);
>         if (!membase)
>                 return -ENOMEM;
>
> --
> 1.9.1
>
