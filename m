Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7426CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424CD2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AXL1qX5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfCVJyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:54:52 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36603 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfCVJyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:54:50 -0400
Received: by mail-it1-f193.google.com with SMTP id h9so2479414itl.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uqQ1QR9cPSugYENMXoC832SxCxRtaPZgWWjO1GeRsGY=;
        b=AXL1qX5AETPk3J1B9+VjrkmR+U4zwcnDWMC/31+bX438cIrmceQQX2DzayKHhfytNQ
         K6aPIpfXU+4dIYaP8/JyKQ/4+Ddvg7iipiDvihOXqlfRCIoj48zxe5D7CdyhEkvqmwYX
         QAI1ks+mVEYvVredwscaZQjRgztb7Hrir7dI6Eci2hK5XqjfcQiWu/QoBn2sjhxmidhM
         hP2QJCrpBCX91oFOWzAof47Kf3V9rOSqNpialZpdvlctM9Opq3uzQsl5G/rgVujKVD7q
         uQhn2msJFj3p3jUqYNRgM3fjKbIs9hcedYK64a0LWTQhd7jknzpI+MfOQ2YihYh2yTmF
         Xovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uqQ1QR9cPSugYENMXoC832SxCxRtaPZgWWjO1GeRsGY=;
        b=ODTbgINnP7Udt6vbAoRdHfc/JeYpCPdI81KkWu/MDLayqV1TeKfOraEzIRvVMJR4Iu
         Ct/SujqxrNCqVqywg1Xc3cG089KhRFl4PoJaYoSpXZLWDRZj+dxIb+kOwMAN0RbG7N9y
         n+qvN3a+t6SwJxh2bEgTnqmHBqx/33Is/0KyIzoROAwWNJ0xhki11yPtgH7slK9sYuNy
         uqC6mKji4Qu9sSvU7+LOaqb8ejpUQ26u3e1gOZ1rZiR5CvI5aVyIQxYPm1iAUm7fpFrc
         K14cwdxm3AFMJA97MmAm5UM8wLGhfC+MYOqQhVSaODSHuJtpY1MVlqJU8SOG/1dhA6Ce
         8SKA==
X-Gm-Message-State: APjAAAULRYNSrYpd8Y3niXQFOQbCeRlLb+7WcEYClugTW07uHUOWteLl
        ihIN+GarvNEe1kIa9wpa3lNzciiOsPhT5br0K/7fvrEH
X-Google-Smtp-Source: APXvYqx5sKHYN6Ty0kEohveyQKbA8w0QbvFPmnc0Kb7IBsx5Y0q/VNXbDYZVhqW/MGzkzWK5qzGVTAr6q5Qr4EriY0o=
X-Received: by 2002:a24:3d8f:: with SMTP id n137mr664172itn.96.1553248489115;
 Fri, 22 Mar 2019 02:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190318174040.17899-1-brgl@bgdev.pl> <20190318174040.17899-4-brgl@bgdev.pl>
 <20190322090208.GF27015@amd>
In-Reply-To: <20190322090208.GF27015@amd>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 22 Mar 2019 10:54:38 +0100
Message-ID: <CAMRc=Mfa2bFTNRfiCOzryjcvfWHR3hjYgOpkjX4LaSpf_QJXkA@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 03/11] dt-bindings: leds: add DT bindings for max77650
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

pt., 22 mar 2019 o 10:02 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> On Mon 2019-03-18 18:40:32, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add the DT binding document for the LEDs module of max77650.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>
> > +             led@0 {
> > +                     reg =3D <0>;
> > +                     label =3D "blue:usr0";
> > +             };
>
> I'd rather not see these "usrX" things... Does it have some kind of
> real function?

Not really. In the design we're using it for, it's unused and on the
development kit from MAXIM it's simple three colored leds.

Bart

>                                                                         P=
avel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
