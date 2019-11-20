Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1810C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E1220855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 21:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/zwNnaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKTVmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:42:03 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41849 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTVmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 16:42:03 -0500
Received: by mail-ot1-f68.google.com with SMTP id 94so984016oty.8;
        Wed, 20 Nov 2019 13:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mKo0P/Q8cmzwBALgYywH4B3hP8VLlyfhnZgOVR39oBI=;
        b=a/zwNnaMubLKzewBw2D1TLt2p4FhSF2Rf/Xxj8+z/s8AZMEsUpJtokRYUugEZpyHXb
         GSKhIM/5/lVyO59y3/zyg5TobGRnaumHd6dZWbjwKIixSAVnURIPldxfnpQaDNY7ZU6G
         n/weKwsSPJWwOxP+Rc1Y2kJpPFt+XNsl+0+SU5FJH9dCUX95B+TebBeEsvhug8O7iWqI
         E00h/14iR0x04Hs+t8Umbb7G/IL3iep8ZtcUsILxU8BI9Svw4if1o1ouvPUJ1fMQ5rbG
         hjdQ8jo3bYoI2OHDM9f+m1GgL42baajj086F7H5ek9y/U4suPlUltegDJvkKakcL+6w7
         KNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKo0P/Q8cmzwBALgYywH4B3hP8VLlyfhnZgOVR39oBI=;
        b=bp43/iuYqdgbfiw0Ov0qQo6u//s6PP7PgVWGsQe5vUq7DZAhaUMZtKod6RP5h33Eck
         oytXMek/965s6ocwwKrswiaeVHYZS/B7SEbq9iKFgApMuVYXLvI8/Wkf/hYJx8uGXp8W
         2f8bbk02X1f6/Sv0lkuyYFe+cxZXDyh9h0ZcoWQhRGUCKsuxag/pfOsEhImrR63ofwW1
         RtUXVp0HkPzwaxY7X0fCd44l1AkW2ARxSg/xn96R4pMFpOEOBY3VGOIMpW+1y4ILGDO0
         2WgJ322t8OfDEENbRpIY3DvvTilDaGV4F0PctsD6G0WJmfbHIgKC7zAzVGsEXZD0Yuno
         ACBg==
X-Gm-Message-State: APjAAAWaGgb9BpOVoed4MIKYWgxaPpwsJbGCt2IfCSMcqTK8gh28K7ZT
        LA4rkOZLrqxgA95ygksTfvuzFTeZTY+H94PnanYdaA==
X-Google-Smtp-Source: APXvYqy9L+Joni3bAd/IyZ3c53EJbvYUO5unhgvQurFQPN1kkKJ3Sy4AOlwOlGEQ3FdmL/DxPrjjBemK7bTB9rGrw0Q=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr3938582otg.232.1574286122164;
 Wed, 20 Nov 2019 13:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20191120144401.30452-1-TheSven73@gmail.com> <20191120144401.30452-3-TheSven73@gmail.com>
 <07b85f68-3668-e354-3379-13d32e84466f@gmail.com>
In-Reply-To: <07b85f68-3668-e354-3379-13d32e84466f@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 20 Nov 2019 16:41:51 -0500
Message-ID: <CAGngYiXP8xu3UQTZxEqSXNkic3iNU43hD-KBJQkAmduXPp8zhQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] leds: tps6105x: add driver for mfd chip led mode
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Grigoryev Denis <grigoryev@fastwel.ru>,
        Axel Lin <axel.lin@ingics.com>, Dan Murphy <dmurphy@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek,

On Wed, Nov 20, 2019 at 4:33 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
> This is covered in DT bindings, it is redundant in the commit message.

Ok, I will remove it from the commit message.

> > +     priv->cdev.name = "tps6105x::torch";
>
> Please remove above line.
>
> And use new LED registration API like below:
>
> struct led_init_data init_data = {
>         .devicename = "tps6105x",
>         .default_label = ":torch" };
>
> return devm_led_classdev_register_ext(&pdev->dev, &priv->cdev, &init_data);

I would love to do that, but my platform (with a tps6105x) can only boot a lts
vendor kernel (4.14). classdev_register_ext() is not available there.

I can make the change you suggest, but cannot test to check if it will actually
work. Is that ok for you?
