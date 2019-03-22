Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DBAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082D82190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="vgcm9mzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfCVJzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:55:39 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55025 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfCVJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:55:38 -0400
Received: by mail-it1-f194.google.com with SMTP id w18so2710093itj.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VyAhjxOComuG9IsCWFPdu22H/msZWK7oeVQLtPB9SVA=;
        b=vgcm9mzd5xWfROAmHcisddqMg8to/WRYyWZWL1YDowh8tBoFqU6sqv72gvkOH/iotC
         Oin37wADvj2yuv4c/X1mKZuZe/RFeFp7Y+6SYWjusmekANbs4j22kEyV0LqhuVgpZf4H
         0hvgJgGmA5GUHd0DkiRklY6nWOTlUhXmxNqPhw8xwEzWWA2QL+/rdIdgfdFcjmxV+8IU
         czoRg0qYBtqK5m80qXJRG6vnRMndDD6H80L9Q9cklZEWKX9saz4A3tnqoyk+MeEQZRXG
         cEirtZPBEYWLZs0POQ4UiaSklT0PXOA38/JMzfubuw2eZZk+zbZ/emE46oqnjOngcq7v
         iiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VyAhjxOComuG9IsCWFPdu22H/msZWK7oeVQLtPB9SVA=;
        b=jvsG4dh7PS5EVi2HVLN8TN1is/N1G4NNye+l51WwrjiO6wNeiV22G4ok0diDK+Ii9k
         0qwC4ZDWDOJEy5hfxR3ul2dzH4jVuKQ/auJoI5QVBiOV1rYU+JPg5A20yRR52i8ObSNx
         XZc4IcN4pEnllVjOd6KihyjqfQ6We58X4A2eLOl4GW2FBq3Bro7Yr7XRcMbddhXyAw5J
         p/mEPnBfj0a4dLXa6/e7vEVQcVbx3DChPz1UWu9oLtrNwZurFsYCLuRupROC3piKa8aa
         ego8IDX+VZlM8XHc1OV3AUaphDZmBLBVZFZDazq4yOtrODXmOzF+iUQhoKt3P4qXeJGN
         qeQg==
X-Gm-Message-State: APjAAAVvqhOOI9fNRRG/8cmCq1vCFBlDZ0BneMIdjoQ6D7U3Y7CS9HK6
        HELuXr/1+w3/FWKhPIOb9xXAOHJVfKzAHyNFF5t5bA==
X-Google-Smtp-Source: APXvYqw1vn9NK7rgO5zZE+3lbjndj5FLQd5iPr3jg2aJSJaSqxdUxWqcvEye7Or9Hpao9SBmxEbn82/K3IcPL38OBgU=
X-Received: by 2002:a24:79d1:: with SMTP id z200mr672160itc.53.1553248537212;
 Fri, 22 Mar 2019 02:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190318174228.18194-1-brgl@bgdev.pl> <20190318174228.18194-5-brgl@bgdev.pl>
 <20190322090927.GG27015@amd>
In-Reply-To: <20190322090927.GG27015@amd>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 22 Mar 2019 10:55:26 +0100
Message-ID: <CAMRc=Md0-UkY07vkf+irqUKwHFSj=Nq3fBYKFRqNG9nzWv9YRw@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 04/11] dt-bindings: input: add DT bindings for max77650
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 22 mar 2019 o 10:09 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> On Mon 2019-03-18 18:42:21, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add the DT binding document for the onkey module of max77650.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> > +     onkey {
> > +             compatible =3D "maxim,max77650-onkey";
> > +             linux,code =3D <KEY_END>;
> > +             maxim,onkey-slide;
> > +     };
>
> This is certainly wrong.
>
> "End" key is normal key on a keyboard, certainly not some kind of
> slider.
>
> And this controller is likely to be used for power key, not end key,
> right?

But this is just an example of available properties, not a real use-case.

Bart

>
>                                                                         P=
avel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
