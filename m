Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EB3C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0000E20859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGOZzIJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbfFJKUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:20:45 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50598 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389214AbfFJKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:20:44 -0400
Received: by mail-it1-f194.google.com with SMTP id j194so5408160ite.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 03:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TD9nldu+Dkg66DtJL22FIFPPAtJrtLwLTy4JIGvUcQ0=;
        b=xGOZzIJLwgDnCGn+KlPHKMf5rhw1h6HPB+95GrnYpcFyME3d6inxxLyUdmnkUq34J+
         zIomGN+MLBR/oBWOe0ulrBE7Z4E32pfkipA+UvLZ1HSdKDy8GC6l8Mp9wJ803ogYGbAJ
         XkKTMgVLsEwE6FpWaaDwbvNxWnbiruke6qUOyB0ejNsZuBRBi3b43yVy4fvDCb91ewO2
         Zjef6VagFWfnsI0m34DKo41NNnLdVP9/Dyh1VbdA8PowiwZdyPE/WzmPhq03ic8Wi1/B
         bsA1uFFW4PNjaH9sgcjjZ0hpbNNQwDPdUAJ2P909ro09PZSJ1gys4wpgtKshS4+ctbrH
         zTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TD9nldu+Dkg66DtJL22FIFPPAtJrtLwLTy4JIGvUcQ0=;
        b=iwmTXN49+lSBAtNJS8f3xmys9qrMCJUDIEusRkE6uWaTWDrsAYtOUefWirTEifq1Rz
         Wwb4VFOixo/toT3MkZ1Om9aiY8ihVk0qcgLsrsVx7xe25FSTge62OoCNqWqrK5DWKBZr
         WdTohm+XO6hvEgmXfDVeCbDoZdWm9dcwKXX1Xj6idLpllc2PBQ1jmcq8bq3qYGvJ1Yun
         HimYA+/a3BXQWkxFKle0Lwai/mk/7NmVxGJ/HkKpm2NYMaDmferwErkq3bTQVKlalAIQ
         e6/M1e0qKJpH+RQgg4AL1cdaw4hVlhG/Wt2uFh3pnoZb5XaJdUSpjkbsLMaEKRjHhLfF
         uB1g==
X-Gm-Message-State: APjAAAWR2pGzxsD4ZHnXQvDKt7v3vlzleZg6nXpT/QF9oHRaOcGjL8Mv
        ca//58iqxTk1M/ddNfoO72LClC3W7tYqw4fOQGVB3vzg8yk=
X-Google-Smtp-Source: APXvYqz8+9gsk4GZjuP3WNO3dIJxKVqLA91XwEqoIRkCKyS++7skP/Y8F+BITEkNQ+1mKDd2q8VehsdTmYGSs98dr0s=
X-Received: by 2002:a05:660c:44a:: with SMTP id d10mr12222840itl.153.1560162043688;
 Mon, 10 Jun 2019 03:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190610084213.1052-1-lee.jones@linaro.org> <20190610084213.1052-4-lee.jones@linaro.org>
 <CAKv+Gu_s7i8JC4cv-dJMvm1_0cGzzhzf+Dxu0rxcF7iugF=vHg@mail.gmail.com>
 <20190610085542.GL4797@dell> <CAKv+Gu8rhxciy1cOG3B3pda9+p4R_COGrrqa7S_Rj9y2HeBxYw@mail.gmail.com>
 <20190610092245.GN4797@dell>
In-Reply-To: <20190610092245.GN4797@dell>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 10 Jun 2019 12:20:30 +0200
Message-ID: <CAKv+Gu94ES4_SjkmAMaAgwCtsx_YmOn0=yaeM9GFjPCCxrANoQ@mail.gmail.com>
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

On Mon, 10 Jun 2019 at 11:22, Lee Jones <lee.jones@linaro.org> wrote:
>
> On Mon, 10 Jun 2019, Ard Biesheuvel wrote:
>
> > On Mon, 10 Jun 2019 at 10:55, Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Mon, 10 Jun 2019, Ard Biesheuvel wrote:
> > >
> > > > On Mon, 10 Jun 2019 at 10:42, Lee Jones <lee.jones@linaro.org> wrote:
> > > > >
> > > > > This patch provides basic support for booting with ACPI instead
> > > > > of the currently supported Device Tree.  When doing so there are a
> > > > > couple of differences which we need to taken into consideration.
> > > > >
> > > > > Firstly, the SDM850 ACPI tables omit information pertaining to the
> > > > > 4 reserved GPIOs on the platform.  If Linux attempts to touch/
> > > > > initialise any of these lines, the firmware will restart the
> > > > > platform.
> > > > >
> > > > > Secondly, when booting with ACPI, it is expected that the firmware
> > > > > will set-up things like; Regulators, Clocks, Pin Functions, etc in
> > > > > their ideal configuration.  Thus, the possible Pin Functions
> > > > > available to this platform are not advertised when providing the
> > > > > higher GPIOD/Pinctrl APIs with pin information.
> > > > >
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > >
> > > > For the ACPI probing boilerplate:
> > > > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > >
> > > > *However*, I really don't like hardcoding reserved GPIOs like this.
> > > > What guarantee do we have that each and every ACPI system
> > > > incorporating the QCOM0217 device has the exact same list of reserved
> > > > GPIOs?
> > >
> > > This is SDM845 specific, so the chances are reduced.
> >
> > You don't know that.
>
> All the evidence I have to hand tells me that this is the case.  Even
> on very closely related variants Qualcomm uses different H/W blocks
> for GPIO.
>
> > > However, if another SDM845 variant does crop up, also lacking the
> > > "gpios" property, we will have to find another differentiating factor
> > > between them and conduct some matching.  What else can you do with
> > > platforms supporting non-complete/non-forthcoming ACPI tables?
> > >
> >
> > Either we don't touch any pins at all if they are not referenced
> > explicitly anywhere
>
> I guess this would require an API change, which is out of scope of
> this patch-set.  Happy to change this implementation later if the
> subsystem allows for it though.
>
> > or we parse the PEP tables, which seem to cover
> > some of this information (if Bjorn's analysis is correct)
>
> Maybe someone can conduct some further work on this when we start to
> enable or write a driver for the PEP (Windows-compatible System Power
> Management Controller).  The tables for the PEP look pretty complex,
> so this task would be extremely difficult if not impossible without
> Qualcomm's help.  I wouldn't even know how to extrapolate this
> information from the tables.
>
> > (if Bjorn's analysis is correct)
>
> Bjorn is about to provide his Reviewed-by for this implementation.
>

If Bjorn can live with it, then so can I.
