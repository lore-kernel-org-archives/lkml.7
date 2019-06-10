Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418CFC468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF7D2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiBmuh4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388785AbfFJJEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:04:07 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51305 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388190AbfFJJEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:04:07 -0400
Received: by mail-it1-f194.google.com with SMTP id m3so12103112itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 02:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fT90yBCfvgHH/USr4Fa6t7Hb/A6wLFnh4q0k27VLHoA=;
        b=MiBmuh4HcFCHNwSDfo1tTNQ7oVKa6r6w1uW/9apFsiPxN4cBNnJOAkrD9G9NcYbBz0
         eDV76xl/95MZ78MKpWkJ5xVCZpS6Ia7dwF2Cz6M4m4Iu3mB5a20AXD/HjJC4pYaVzMO7
         firn3hGYSYxkMc577jeK/u5pGhEs+AQOsyxGOiuVYB41BLhCRXEgB5slWh/gsZN+/lAA
         Bf3OAVrpWFjdZFLYduRzO+I2SE5pQK867tkKniEgqfkJEEW6xQHZFnM8ygi73IJI4EW9
         J79NCgY1YVRqSBhBymYFPGfyzTrD2ooEB9Uw0nv22rHBC/gwyvYx98yO6JEcJ5gKeClL
         jKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fT90yBCfvgHH/USr4Fa6t7Hb/A6wLFnh4q0k27VLHoA=;
        b=HluLoxmlL515iDIDmJAFE/nhHUwPkwQeAOSHTv9d4/nOvotl4bR8BLpJQmMTelUkcG
         wP+7lv/zL+RBGMMhRNCpnX3aWoLBYUUAtTklynsHoVi3G1F3sLLGQTKenSkDi/LpJtlH
         vieuWMUCpn0HwAcjaWwQvUHPaWImhonhJEbaMqER8uSlDv1NkvmjCZ6s+dK3yelUdKhy
         GG3kgrMNxhj7oc4fyAw54UapdDSdtw0RL1llcjOCWeoU7yaD43sYRJCeBKIkbH8gnQjb
         Gc72haAM3ns6mvANzpAGHNjrIyH4sead0qpsXQZww4dbczuc2aNRNurJbk7WMsZzBmtT
         ywpw==
X-Gm-Message-State: APjAAAUd+K6umZeEbWcOO1LDYzVCM9vOXUWMVeC4O7Bt5rb7tcpMAxJG
        MwPyeCJSj8+qqoZ0aRHglHiVJbY6nyq/Hra0eendvQ==
X-Google-Smtp-Source: APXvYqwkUy8NJlaVC3ZLeQiyK4NjB0jc9Voa3XoI7Z3nR5vGUM1XyHPJFdz9nE7zh9z+pHwwmOgMLp1ZWxUKgEuZmJs=
X-Received: by 2002:a24:740f:: with SMTP id o15mr14362252itc.76.1560157446438;
 Mon, 10 Jun 2019 02:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190610084213.1052-1-lee.jones@linaro.org> <20190610084213.1052-4-lee.jones@linaro.org>
 <CAKv+Gu_s7i8JC4cv-dJMvm1_0cGzzhzf+Dxu0rxcF7iugF=vHg@mail.gmail.com> <20190610085542.GL4797@dell>
In-Reply-To: <20190610085542.GL4797@dell>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 10 Jun 2019 11:03:46 +0200
Message-ID: <CAKv+Gu8rhxciy1cOG3B3pda9+p4R_COGrrqa7S_Rj9y2HeBxYw@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] pinctrl: qcom: sdm845: Provide ACPI support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     alokc@codeaurora.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        wsa+renesas@sang-engineering.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, balbi@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <jlhugo@gmail.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2019 at 10:55, Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 10 Jun 2019, Ard Biesheuvel wrote:
>
> > On Mon, 10 Jun 2019 at 10:42, Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > This patch provides basic support for booting with ACPI instead
> > > of the currently supported Device Tree.  When doing so there are a
> > > couple of differences which we need to taken into consideration.
> > >
> > > Firstly, the SDM850 ACPI tables omit information pertaining to the
> > > 4 reserved GPIOs on the platform.  If Linux attempts to touch/
> > > initialise any of these lines, the firmware will restart the
> > > platform.
> > >
> > > Secondly, when booting with ACPI, it is expected that the firmware
> > > will set-up things like; Regulators, Clocks, Pin Functions, etc in
> > > their ideal configuration.  Thus, the possible Pin Functions
> > > available to this platform are not advertised when providing the
> > > higher GPIOD/Pinctrl APIs with pin information.
> > >
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >
> > For the ACPI probing boilerplate:
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > *However*, I really don't like hardcoding reserved GPIOs like this.
> > What guarantee do we have that each and every ACPI system
> > incorporating the QCOM0217 device has the exact same list of reserved
> > GPIOs?
>
> This is SDM845 specific, so the chances are reduced.
>

You don't know that.

> However, if another SDM845 variant does crop up, also lacking the
> "gpios" property, we will have to find another differentiating factor
> between them and conduct some matching.  What else can you do with
> platforms supporting non-complete/non-forthcoming ACPI tables?
>

Either we don't touch any pins at all if they are not referenced
explicitly anywhere, or we parse the PEP tables, which seem to cover
some of this information (if Bjorn's analysis is correct)
