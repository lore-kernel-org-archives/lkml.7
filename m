Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F68821904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EksZhBlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfCVJxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:53:45 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54682 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfCVJxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:53:45 -0400
Received: by mail-it1-f193.google.com with SMTP id w18so2701670itj.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 02:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ukHOVEzrQV0Zkm2kaC7hyjsRBbIBNUTyELt4PdnzcDQ=;
        b=EksZhBlxkYp9ZwsHNP8zoJOrj7HPwn+61xfuHjpX+SE/YILD2NyI+ahXVR1olw3vUP
         odoBls5bfkprh6Q2GrKmSM3gwF4ea/D6iwULHDlf8GwKwBqgABh5C985F7WU+zVu1Tw4
         6YTfWs+p2Ke8hVR4t1iRXIxNZour8KH4IH9MXfVhZFUSq/pojzgf5V27PmzlFDsbts6C
         jM7dL6mOzRnEOkqGLryX7MlvfDcqbNf64p/DQbIO0Ib9AdhhQog1orDaxKC+v8WAat5a
         wk55JtGXU/jPPVHWlxk4iJLQ3ZJAzdSaStdt8ohGJcqw7iMobxxEW5dHBXDxq1hD6as0
         jdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ukHOVEzrQV0Zkm2kaC7hyjsRBbIBNUTyELt4PdnzcDQ=;
        b=BoMGR2AzhR89jltksn43XnvX3ikOr8q5Pw0v7f9mahiQZY4RIHbz31Lp5DJ/ZuLvdU
         TKOKj5e3QT7xrujDJPLJT9kqTH4Ah/Xs4fR2Fz0LTG8wfR3yH+SrTOy5AYUTqIr2BMVR
         QD+z1WDugz7qY/JDBcOYymJ4DQbrCabsbw9ozDlE7NxZUvRWcUItpsCYPA6+adLP+DZd
         mFdDgoE7A7zK2NCeFDmGIMKqv/BkjNkZ6bqehnmonIViMZn9dFyOYIvXZsZd7pMEYpn9
         FU5meubKQs3hHaorlAJWy+W8Bu+wx0efKcQpThoEaGrh9xDA+A8MQNBeftaKWlrD1/n1
         0+4w==
X-Gm-Message-State: APjAAAVYjSoiOO/vKAuQWdxlHY/cXIjgtPiYaoeVJoITLaTJWME4ujKR
        Ps4YpCCm9+wjQaWGgmYLJdakjt2TTq5m4I5C2TSp3Q==
X-Google-Smtp-Source: APXvYqySa/Beqz5/G8UoGTd5daMDkzmrmVNd6uhz2aCL1HU/WjKPD+Cn2BwUA8SUcE/Qp5zNcPLNmWdYwIUcNuVLcBw=
X-Received: by 2002:a24:3ac8:: with SMTP id m191mr599528itm.74.1553248423969;
 Fri, 22 Mar 2019 02:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190318174228.18194-1-brgl@bgdev.pl> <20190318174228.18194-10-brgl@bgdev.pl>
 <20190322092124.GK27015@amd>
In-Reply-To: <20190322092124.GK27015@amd>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 22 Mar 2019 10:53:32 +0100
Message-ID: <CAMRc=Mf1DxF1e63y+HsXtCFxZW8R0XWDLUXGy+4cp3zBS0_qhw@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 09/11] leds: max77650: add LEDs support
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

pt., 22 mar 2019 o 10:21 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> On Mon 2019-03-18 18:42:26, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This adds basic support for LEDs for the max77650 PMIC. The device has
> > three current sinks for driving LEDs.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>
> > +             label =3D of_get_property(child, "label", NULL);
> > +             if (!label) {
> > +                     led->cdev.name =3D "max77650::";
> > +             } else {
> > +                     led->cdev.name =3D devm_kasprintf(dev, GFP_KERNEL=
,
> > +                                                     "max77650:%s", la=
bel);
> > +                     if (!led->cdev.name)
> > +                             return -ENOMEM;
> > +             }
>
> I'd rather not have the "max77650:" prefix in the LED name (as it is
> useless).
>

I was instructed to do so by the LED subsystem maintainer.

Bart

> Best regards,
>                                                                         P=
avel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
