Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DDFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D8120823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="0P0VnC2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbfCZRfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:35:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34309 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731997AbfCZRe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:34:59 -0400
Received: by mail-io1-f65.google.com with SMTP id n11so11578326ioh.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7gohIs6rfljN6fjuxZC/flrKEOxYj0TMU6fRR/Fc6qo=;
        b=0P0VnC2omSLS0+8HRv8jF2XTdSdb7Xnq7EJ36UPcYlw1wV/m1zj0owLIpuX60RPj7I
         JC2y7nZcfR9evt9saTvz847bEZx+alxjjU8uMW/c3Zt1DhXxLkcUnVzR03QVB2wzL0oG
         tEyCmZL167FozXtvTgewtEEbOrjaRTmarQN6Ddeh/IbxGlK/460Ubqkq+p8J8JkavRwo
         EHkw8f7xHKni6/jUbkxLGJ9j72eshbEXwpKRqI628+445mpzkCFyIJ2Y7a4pwheK6wLQ
         m5w7vhycPkxHj35uC6iKhCiXv6HeP/d5eOqE87CUNgblB8ssOihnNXs4PXJ+/KXOCZN/
         faPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7gohIs6rfljN6fjuxZC/flrKEOxYj0TMU6fRR/Fc6qo=;
        b=eT7Y914zXcjzzU6JKNiE1CAhsKNa7Fcpi7E0wHjjby4XIozpvXwXJFdASYpw6xgV9N
         k28hb5+mVU3TvY6f2Mh+u01DWbb9aIofbhnQn4YN/G90fLbJj64cx/G+z64iPaK+wFYu
         QXh8caAM5+xtr6McHtkdVAwNDRSrKjf/8bn4LwZHM9JJluEm3B6GAlCA1zR58G3gG4Sq
         P8ruakoCQOfo5g3lsboNo1NugCwE2MUNQLyN7E6GvPx5S/rHoyuJCAu7eVJPEJQY6zIH
         6y2xf7Kq0G6/RrLVs+Nmfuaxu9X6SHh+YkBqxVdUVRuLYXU/Yn0wRY0Rk8rLvYSNqVvM
         p2ZA==
X-Gm-Message-State: APjAAAVgJX0drt/D4BdSy86qdOmfyPcKqblxk0m6aFUzytN2sfx/1E/l
        AT21QWbpyc0HYrWai5EiupAYqnW4UHgoFinIwXARJA==
X-Google-Smtp-Source: APXvYqz3XybVs8c0sA5rVvt5l0QCw1vCfzXkLLE2lu5BHI8vqb4H2E32lZD7DBGKBLcY8Q3bA7+Q/my2y4EqQnL2f4U=
X-Received: by 2002:a5d:91d3:: with SMTP id k19mr731051ior.258.1553621698943;
 Tue, 26 Mar 2019 10:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190318174040.17899-1-brgl@bgdev.pl> <20190318174040.17899-3-brgl@bgdev.pl>
 <20190322090038.GE27015@amd>
In-Reply-To: <20190322090038.GE27015@amd>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 26 Mar 2019 18:34:48 +0100
Message-ID: <CAMRc=MdMqjZtQkWXaK3-5myXUZMd_tNirQGE5wKpA6uoCsGhaw@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 02/11] dt-bindings: power: supply: add DT
 bindings for max77650
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 22 mar 2019 o 10:00 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> On Mon 2019-03-18 18:40:31, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add the DT binding document for the battery charger module of max77650.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/max7=
7650-charger.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/max77650-ch=
arger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger=
.txt
> > new file mode 100644
> > index 000000000000..d25c95369616
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.t=
xt
> > @@ -0,0 +1,27 @@
> > +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> > +
> > +This module is part of the MAX77650 MFD device. For more details
> > +see Documentation/devicetree/bindings/mfd/max77650.txt.
> > +
> > +The charger is represented as a sub-node of the PMIC node on the devic=
e tree.
> > +
> > +Required properties:
> > +--------------------
> > +- compatible:                Must be "maxim,max77650-charger"
> > +
> > +Optional properties:
> > +--------------------
> > +- min-microvolt:     Minimum CHGIN regulation voltage (in microvolts).=
 Must be
> > +                     one of: 4000000, 4100000, 4200000, 4300000, 44000=
00,
> > +                     4500000, 4600000, 4700000.
>
> Probably needs "max," prefix. And .. what does this mean? Will charger
> shutdown if input is less than this?
>

The charger will enter the undervoltage lockout state and stop
charging, this is explained in the manual, so I don't think the
bindings are the right place to add this information.

Bart

> > +- curr-lim-microamp: CHGIN input current limit (in microamps). Must be=
 one of:
> > +                     95000, 190000, 285000, 380000, 475000.
>
> "current-limit-microamp", I guess. And probably "max,current-limit-microa=
mp".
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
