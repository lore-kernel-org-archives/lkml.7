Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7BFC3A5A7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74BA21744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yt5Kk70Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfIBNgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:36:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41807 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfIBNgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:36:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id m24so12899509ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 06:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8LhD/sF/NTN0NjoFAgiiHQ7UUs0ybG0eLJoGIh+N4ts=;
        b=yt5Kk70QvcaLMsgSVuGuAG4SWM+BIcLIE5gou9GHOehJB4r9b6weJu+L7oHTmKWf1G
         fX/yXW2q6/k6BNw8YAh51Jz1YplyVXmpWkzRX/rbuKi1zIv8GcZA3hbylkT11Dc7iaf2
         UGWvbJ0bU+abLpXT6JPE+sKYsFDh14BO9haw58yB5Jesu632ftsPtb7jEp+yQsLtBeua
         h6bewrNUmYJldinBXbVXilFKl05GC6gWO8jL+Ees9sIZ+roT2Xq6s4iZF1aIs4QqX4Va
         fNgWF6FpKWU72uZOR1YsWCa5OnA/ZEmxIr5AAA9nCB5JlphyvX/FIT4W0Oxgn0gPqATz
         CsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8LhD/sF/NTN0NjoFAgiiHQ7UUs0ybG0eLJoGIh+N4ts=;
        b=BH45fdXfHJF/GH5XCL0HzEAhCRXXq/L8XCYFo63d40n83cojJhg4ZDjQGR+WbFGLLn
         tH2fxawFGMbpvUNDGK0enG8VHgAFWP5IHEvNVbgnKZmAkfZmOVngarwPuDtpT6aMYQGM
         1+nox3+0RbCqm1DDT1PH8QPfiFAs26bJcHTpD6lbYx2hrRk6/uv3bbRGxkZwt0E89rzO
         CzfGBnOUki1pmX91CLgYTcLTV7Ihu2pNchifyLsNzAdC3V1zRKPmipdzFR2kC/jbSGSD
         I/0pcZLjg6iuz8wOV6abxk2937cCNtWBVyETFLnPWldMTwsik8KoNTmQg1VoLUAHp1sU
         9zkg==
X-Gm-Message-State: APjAAAUFRiGMWJlY+TiWwWKmEIqKxCt9HsdknlX3B6cX8xv3qVgwPKtD
        Bk1Mt1QR8Qdomop+NH2Vy6SEexeL+YqBGMGMgaNu1Q==
X-Google-Smtp-Source: APXvYqy/56/JZhH9u5h/dgz83LrB1WA4WlE3a52G84UNe7DNmvw7eo78678HYTfzEBqzkAB8w0uR5xAG6bAC2llAAJg=
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr16425420lja.180.1567431395793;
 Mon, 02 Sep 2019 06:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190831030916.13172-1-peter@typeblog.net> <20190902100141.GW2680@smile.fi.intel.com>
In-Reply-To: <20190902100141.GW2680@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Sep 2019 15:36:24 +0200
Message-ID: <CACRpkdaY_TT_m3XEh_J9TqMQijzUieQDBn+t4=uGUyfP+V0Hzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: acpi: add quirk to override GpioInt polarity
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Cai <peter@typeblog.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 12:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Sat, Aug 31, 2019 at 11:09:14AM +0800, Peter Cai wrote:
> > On GPD P2 Max, the firmware could not reset the touch panel correctly.
> > The kernel needs to take on the job instead, but the GpioInt definition
> > in DSDT specifies ActiveHigh while the GPIO pin should actually be
> > ActiveLow.
> >
> > We need to override the polarity defined by DSDT. The GPIO driver
> > already allows defining polarity in acpi_gpio_params, but the option is
> > not applied to GpioInt.
> >
> > This patch adds a new quirk that enables the polarity specified in
> > acpi_gpio_params to also be applied to GpioInt.
>
> Thank you for an update!
>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> on the condition that Dmitry and other input / Goodix developers are okay with
> the approach in general.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
In case Dmitry needs to merge this.

Or should I simply merge this patch to the GPIO tree?

Yours,
Linus Walleij
