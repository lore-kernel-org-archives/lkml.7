Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E71C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D222171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEwJVVZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfDLPTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:19:31 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53204 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLPTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:19:30 -0400
Received: by mail-it1-f196.google.com with SMTP id x132so16295480itf.2;
        Fri, 12 Apr 2019 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZLFg354EJIlWaVX65q4goZaguwUVcySJyrgSwtdrOFw=;
        b=YEwJVVZAF34covn+jRPIDQfXfqcNze69tN/ozHxR0+iu7ijr3kQKt+gCuEpmkdSZ9J
         0Mm3uVnc/McBILIkQEgeTpjTXrfwkBWUTVyMqwf4qJLyDf7gHSE+xTGk9ejGE67jd4W3
         hZeu1W2qN8hHYLUCrpkf3JzprtGB6+W8xKkTFlNkNsRDb1sUXuJHar2K5IqDoN3R88rW
         KnkG9yCrlBorn9enpMzIwoXcCTaSFzuzq1uZ/FRSDZcnX2Cn4nMKIClRCtPXHs8xbJnS
         w8DUtWv3VTloGS/ErGAk5LtZ5elzpOkiUSz34OQ1g8hvevl9qTV3h6t0u2Q4RZfPhZct
         iDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZLFg354EJIlWaVX65q4goZaguwUVcySJyrgSwtdrOFw=;
        b=Dgcs9t6H+z/m4ickqffc2OTziNjPc+HHCSoCvxMu5ZW3odpbtJxgnckYdMpOMfOTsV
         M/FYo7lsoabSDa+POWLY7asF/5+MziHjan5b9zrtp+S6Yz5QNuqzr3mNDZ86WhCl7/DB
         wkpQ3pNeWdpGOaFyuwoaNlDwZJ23cRGxSo/XpA5rgESEe9e/I19ovo74TJvSw/Nm09cY
         h/hcGa9SO2sIUpDMOOdg/mH/kRWkePa+iO7BcJs2npKG79cNjgON9/t3kcavVqrAZ5/8
         X65VxSGxsPO3N91aCedx+bGcuX3+prl2MOt2ELWG5MXIhjrecAZ0wro1bL1xIQvGJRdZ
         ingg==
X-Gm-Message-State: APjAAAVual1yI3YliLcHlud8VbuMF6/iKcAvgrUnYQiahaewEhCK9Wmr
        WPzf+bzoJ5gLWgtGXizW3LU9itk5c806USMnmJ4=
X-Google-Smtp-Source: APXvYqzHgB1iwIfgsDK5seZWRXyAlBq5C+DcP1CJ4hMmRhLI1vkiIb/t4L7hJnDYgMPbpoSk4viaN2HBeVKKXFMqR3I=
X-Received: by 2002:a02:a916:: with SMTP id n22mr40211038jam.40.1555082369205;
 Fri, 12 Apr 2019 08:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190411205144.43557-1-jeffrey.l.hugo@gmail.com> <20190412144712.GA7481@lakrids.cambridge.arm.com>
In-Reply-To: <20190412144712.GA7481@lakrids.cambridge.arm.com>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Fri, 12 Apr 2019 09:19:18 -0600
Message-ID: <CAOCk7Np+WTMuoRZOrQzbt1H6xENW2OhRFgpOc-vWn+9daBBqbg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: Add Lenovo Miix 630
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        David Brown <david.brown@linaro.org>, robh+dt@kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry, I had completely missed your reply to v1.

To answer your previous question, why do we need a DT?

DT is the quick path to support for these systems.  There is already a
fair amount of support in mainline to support the core SoC (msm8998)
which is/was heavily used in top tier phone products.  All of that
support is DT based, which is expected to also be leveraged to other
products beyond these laptops, and the existing phones on the market.
As far as I am aware, the ACPI for the laptops was developed only with
Windows in mind, and it is expected, from initial investigations, that
supporting the ACPI is going to be painful.  Its on the road map, but
getting full functionality, quickly, is what what we'd like to do to
meet the demand for these systems.

On Fri, Apr 12, 2019 at 8:47 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Apr 11, 2019 at 01:51:44PM -0700, Jeffrey Hugo wrote:
> > This adds the initial DT for the Lenovo Miix 630 laptop.  Supported
> > functionality includes USB (host), microSD-card, keyboard, and trackpad.
> >
> > Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> > ---
> >
> > v2:
> > -Changed "cls" to "clam" since feedback indicated "cls" is too opaque, but
> > "clamshell" is a mouthfull.  "clam" seems to be a happy medium.
>
> Please use "clamshell". The extra 5 characters aren't going to hurt
> anyone, and it avoids having yet another short name just confuses
> matters further.

Sure.  Will queue this for the next rev.

>
> [...]
>
> > +     keyboard@3a {
> > +             /* QTEC0001 is the ACPI HID, which could be used for quirks */
> > +             compatible = "QTEC0001", "hid-over-i2c";
>
> As mentioned last time, please drop the ACPI HID, and allocate a real
> compatible string.

So, I'm in a quandary with this device.  As far as I can tell, its an
off the shelf component, the device adheres to the "PNP0C50" spec (HID
over I2C), and can be driven by the full "hid-over-i2c" driver (which
is just a DT shim over the PNP0C50 ACPI driver).  However, the device
itself identifies itself as an ELAN 400 device, which is an ID that is
also used for standalone touchpad devices.  Per my understanding of
the Linux drivers, there is a separate ELAN driver for the standalone
touchpad devices as its been discovered though trial and error that
the Linux PNP0C50 driver cannot drive those devices.  To handle this,
there is a quirk in hid-quirks which rejects ELAN 400 devices, except
those which are "QTEC0001".

We need that quirk bypass for this device because the ELAN driver
cannot handle this device.

I'd much rather have a single identifier to quirk on, rather than
having one for DT and one for ACPI, and its not looking feasible to
get the vendor to update the ACPI, so it seems like using the ACPI
identifier is just simpler.

So, if you want a different compatible string, I'll need to go put DT
in a driver that is primarily ACPI.  I'm not sure what the HID folks
will think of that.  I'll propose it, but what do you view is a
"proper" compatible string?  "ELAN0400-msm8998-clamshell"?
