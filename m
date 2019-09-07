Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE3BC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8014218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEOcjr7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406324AbfIGRpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:45:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38618 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbfIGRpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:45:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id w11so4686675plp.5;
        Sat, 07 Sep 2019 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dcg38ZTiMrbxT3AvbPS3tOl5wkZh4p2pcA3bffhrVNk=;
        b=bEOcjr7FFB3y9addvHDX1u+EPWhTG5fD6au4RfmqTKvtXselpGmjl2BUIqlnr6N/Qp
         qLW7db1mV/dSommLrKeAJo/uKUZqH57RG6FtWG6f0oTHMpMrwmIcxFO/8KJmSoTeVjLF
         Dp4DZXgmltmiMAhiCnAPwLV80hrf2bmMKFtCGqbsT4Ej1TZ7aOzOk61HI/35rPlB0qcc
         qXIxR/RheLLysuBRv6iM+cxZc2Rkc6e/WsWh/L6Q6FEuX0Cno9G4pb2mPXKdC8iOF7Ah
         yt5HGwHwar30N7+CVUP8hGjghGCprrcWxZornrFahTyp6o78AcwmKeXWcvp6+jF67iqg
         JuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcg38ZTiMrbxT3AvbPS3tOl5wkZh4p2pcA3bffhrVNk=;
        b=I3H8dik33A+ExBtDLELLjfX4GEEiFoVH3AwkSFabbxU6v/M+z19hS6G5aJlsFXaoqq
         SuBh8+xGWMKMIJ7hZlbtarZE55S/m9fqk/lR1/HBkjoNXfrcQb46va/XSudXFik6RG8x
         6ySOq2uB2wNLbonuKj7z1wxqoRSDW5TkzUc3gbE9oQ42p/7gRapNTtFpRL0aan/oCZUL
         P5/nOZ3Vw+ArjvuSm2LCu8EE8jFTF8a4DSKGfJan6Bau3MWF8MPQPqm7TUaFHyZinLR1
         3JagrN0vTLEX7COF5dO7u+3NUWoN5A56nWpHYhLo4iJVyD/+It7DWDihY7Ypd+Nj0vTe
         ckHg==
X-Gm-Message-State: APjAAAXO8TAe44htElLUM/eV0yUCFiV874no3uRYTNN5ORXAB+QNDvAk
        XPrSYb3Oc9g4oDiLIYvd/r74FFURXHMRy16KD9w=
X-Google-Smtp-Source: APXvYqxZC4NL5fRb6BMOtqUaWq/8HnctZgYXCTqd1vOY3IlF9NFrVol7pLk+j6hJOWUWQdXrglEnwuB+BgmViCHVVjA=
X-Received: by 2002:a17:902:9895:: with SMTP id s21mr15436348plp.255.1567878318332;
 Sat, 07 Sep 2019 10:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190823174815.27861-1-hdegoede@redhat.com> <20190823174815.27861-2-hdegoede@redhat.com>
In-Reply-To: <20190823174815.27861-2-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Sep 2019 20:45:07 +0300
Message-ID: <CAHp75VeJ9Ur9Z4o-pxNApdkb22Zb4sj2AJYRxWO6UFjN292DiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86: intel_int0002_vgpio: Use device_init_wakeup
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 8:48 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Use device_init_wakeup and pm_wakeup_hard_event instead of directly
> calling pm_system_wakeup(). This is the preferred way to do this and
> this will allow the user to disable wakeup through INT0002 events
> through sysfs.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/intel_int0002_vgpio.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
> index 9ea1a2a19f86..f9fee682a8a2 100644
> --- a/drivers/platform/x86/intel_int0002_vgpio.c
> +++ b/drivers/platform/x86/intel_int0002_vgpio.c
> @@ -122,7 +122,7 @@ static irqreturn_t int0002_irq(int irq, void *data)
>         generic_handle_irq(irq_find_mapping(chip->irq.domain,
>                                             GPE0A_PME_B0_VIRT_GPIO_PIN));
>
> -       pm_system_wakeup();
> +       pm_wakeup_hard_event(chip->parent);
>
>         return IRQ_HANDLED;
>  }
> @@ -217,6 +217,13 @@ static int int0002_probe(struct platform_device *pdev)
>
>         gpiochip_set_chained_irqchip(chip, irq_chip, irq, NULL);
>
> +       device_init_wakeup(dev, true);
> +       return 0;
> +}
> +
> +static int int0002_remove(struct platform_device *pdev)
> +{
> +       device_init_wakeup(&pdev->dev, false);
>         return 0;
>  }
>
> @@ -232,6 +239,7 @@ static struct platform_driver int0002_driver = {
>                 .acpi_match_table       = int0002_acpi_ids,
>         },
>         .probe  = int0002_probe,
> +       .remove = int0002_remove,
>  };
>
>  module_platform_driver(int0002_driver);
> --
> 2.22.0
>


--
With Best Regards,
Andy Shevchenko
