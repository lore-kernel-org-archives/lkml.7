Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51D9C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848792073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mke22prz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfDPIAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:00:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36054 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfDPIA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:00:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so9936921pgc.3;
        Tue, 16 Apr 2019 01:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLnmt0mZbLKsmcjKUpjuysHSXH+MWcKyj9d0CotwbKc=;
        b=Mke22przq9P7oR0xou7qQigFVw00kIgxySwWqZ0nCzXXbU58bKb6uL4TGhEc2hF1Vm
         ZOh4EDqMNiz7xl6uTqobv+GaA1msNpWc7FQuG+i/FPo0psG7K/T1nZd+ZsdSnzS7NA0B
         /PZaVkAlqGvVOJWjDs53oqgTs3vv72B0MXylFxtw1P3Pf90bMbPzRUc6iix1x0Yu2XZK
         dy4ZE48rq03zklKoNliGo3hv3SX4fOt198wpqK8QHQryyqCWZKRLavSViqOt1mZLOp0A
         2tyeaqe9cFW1xwMjGN/wvgkXZU1RXGhBrw8cjK0gSSMSk8aVQku1vymRoKGF7vpUeM8Y
         E4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLnmt0mZbLKsmcjKUpjuysHSXH+MWcKyj9d0CotwbKc=;
        b=TeI5ogg43OqwhASS4LCJCvraYwmDKto+8/Ur23P1yhGdcKE5K/qpsdg1EPy5VJG5lu
         UvYTd0kV8iuSoSgWwG8hgugAF5CHt3ut5h5ZBzQKHiyyDhXa8x+F31QQVGdJqzsZhdXJ
         V+J4FJFbSdEv20OTbU4rCKSjYKFIAkcL8JVNeGOhMCvvvug890TH1BbZ4JiglRP1ldyn
         zK+KbfriQ6RL8WRr0fkc8evUbj3kHKYdG/VxnB+Bncsj4dXUWoXnDEvqM8amIWW7PvkF
         78e52QTmvY7qF/RfA+JOn2wtW8EjmnY3BUDszM4HMRo/q9/a61JwhPv1HZf9hYr0AKFH
         0Qhw==
X-Gm-Message-State: APjAAAW2d/YqTm/Rqy882DKApTBpxh3XD9OY+JE4bWjDj/bifoMDSgUJ
        GkPTP8FxhckommAZNEww3VvAgrlZSk18m13ZVsA=
X-Google-Smtp-Source: APXvYqxg13Y4LEKgzEOV4jHJJ7vai44JZHyhTe4Sz9BMRBXEb7sSnzxPeXMc8P+WYyAK8sv2Zn8q2tKLVg8cR2uIlf8=
X-Received: by 2002:a65:4302:: with SMTP id j2mr71462682pgq.291.1555401628111;
 Tue, 16 Apr 2019 01:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190416032743.180517-1-evgreen@chromium.org>
In-Reply-To: <20190416032743.180517-1-evgreen@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Apr 2019 11:00:17 +0300
Message-ID: <CAHp75VcPYu1APhcqcu-Df5ucpW-q597OCKHwne1dgqQsMM9+Fg@mail.gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: Add support for Intel Comet Lake
To:     Evan Green <evgreen@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rajat Jain <rajatja@chromium.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 6:28 AM Evan Green <evgreen@chromium.org> wrote:
>
> Add PCI IDs for SPI on Comet Lake.
>

I didn't check IDs, perhaps Jarkko can do it.
From other prospectives looks good.
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Evan Green <evgreen@chromium.org>
>
> ---
>
>  drivers/spi/spi-pxa2xx.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index b6ddba833d021..493223e1d032d 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1451,6 +1451,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
>         { PCI_VDEVICE(INTEL, 0xa32a), LPSS_CNL_SSP },
>         { PCI_VDEVICE(INTEL, 0xa32b), LPSS_CNL_SSP },
>         { PCI_VDEVICE(INTEL, 0xa37b), LPSS_CNL_SSP },
> +       /* CML-LP */
> +       { PCI_VDEVICE(INTEL, 0x02aa), LPSS_CNL_SSP },
> +       { PCI_VDEVICE(INTEL, 0x02ab), LPSS_CNL_SSP },
> +       { PCI_VDEVICE(INTEL, 0x02fb), LPSS_CNL_SSP },
>         { },
>  };
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
