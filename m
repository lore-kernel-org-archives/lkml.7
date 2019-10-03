Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA66C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C1620659
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vs5jTZo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfJCILH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:11:07 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39669 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfJCILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:11:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id y3so1618700ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZavFxLBzGEeyG9QWkLSKjn8gSqENhIGofh7Iddum7w=;
        b=vs5jTZo2SJ1QezACbFB+MYWl6lzIcQJDbU3KafKeM1cG5GfhiBzYm7ycjiGVhEvy5b
         W5KjFnuzBUIDutLjtYBLAeeOfvjjDNNlPy7qI+5XsJx/uTKxfK8ZJdM5CVr7vVZ8bfFF
         taOIN/8x8fLJI8JOBi/iD2GSCusTzhP1j+JKxmu+VUYJjevgDn7FtEyh56laYh8VBVnT
         Fcj/IbpdyPZGOkYQxx2LBM2c87ZL5vlXvasAqVzmAwo6wAxNbDoz6eqYOtMjz6IfYB16
         DEeLUKaIUGvpxvkbRWRUStHDhv/h97ja7D6vAgWwGj5hvwug9Ueh6Zak4AdU7lC28wrC
         6Jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZavFxLBzGEeyG9QWkLSKjn8gSqENhIGofh7Iddum7w=;
        b=SXVDWv491mBOUTb9F/C6dYw4IrXpbsdCEu0vuz8kCwlg/gJ62ut7UtU3ksG7Yv9RBl
         /x+aVDRTR1+ooOJqAhABwMXPhqm+YrkeLS/awMq/C7d5/cf9Qg5vwQbnkk0APTP74snZ
         UbOD/4fIMsVz29ON1revJMpoAgfQzPSe2Z+nvQ5NzwrThJjs0MwNPJomfRvuLamgsu97
         M7DO/KtnarJxCeFyQTaX2V6PmHQBXx9ixM0xVnSBNBz5N8yzO1B9AL3lBzPN6xGYBmnL
         0tMCFoamh40S/XKn3YV9I52H8EBmsSTzL0AuJB7asHA9Q+oh9evlCpjj9JJ2QFAyBuf6
         lCwA==
X-Gm-Message-State: APjAAAW1bM/FrDr+ydvq1HKtMuRD0UVQUPQ68Nvd+5rWZzD+I7ci/Hct
        Ivi3RlS31YLCPohXS5TFzAU1xpzUoNqo+etCD7OCkA==
X-Google-Smtp-Source: APXvYqyyIBjvuD6lRw79lIY6+d2agVW7esb+jyStei9FEmReZAWYVbSNWa9Dw2DroFLkIXlHmm2vvNdX0lW+VJjmvOY=
X-Received: by 2002:a2e:63da:: with SMTP id s87mr5167256lje.79.1570090263168;
 Thu, 03 Oct 2019 01:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190918113657.25998-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190918113657.25998-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Oct 2019 10:10:51 +0200
Message-ID: <CACRpkdaWtppOpbGb4Fj8cpgUkVw7ncyjiN1E1ytxUF3Zp_CfUA@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: at91-pio4: implement .get_multiple and .set_multiple
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 1:37 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Implement .get_multiple and .set_multiple to allow reading or setting
> multiple pins simultaneously. Pins in the same bank will all be switched at
> the same time, improving synchronization and performances.
>
> Keep the driver future proof by allowing its use on 64bits platforms if
> they ever appear with this IP and we end up with a mismatch between
> ATMEL_PIO_NPINS_PER_BANK and BITS_PER_LONG.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>
> Changes in v3:
>  - Add ack from ludovic
>  - add comment and amend commit message to explain the ifdefd

Patch applied, sorry for the delay, merge window and stuff.

Yours,
Linus Walleij
