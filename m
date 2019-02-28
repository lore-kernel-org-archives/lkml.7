Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227ADC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D320020850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RMg7Xw+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfB1XjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:39:22 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54844 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfB1XjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:39:22 -0500
Received: by mail-it1-f193.google.com with SMTP id w18so17446478itj.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xl/VHkISQds30MIGHXhz8zWSd8eWLcUqDd8bDu0FSX0=;
        b=RMg7Xw+4t9QRTuf9FotF0lZctWyKUOLgG64u8skhmieVdFpIRZBhQAHZa0m8WsDe9I
         wdVQMuEDw2q3TpdKJvFtRXG4LFDUx/crMpWN5AR9rPPTPtB8nW2yaWD45+WID0UnZmgm
         w68vM1nVxr5cvvwRZriKCqTeOfKSZKaSFUCkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xl/VHkISQds30MIGHXhz8zWSd8eWLcUqDd8bDu0FSX0=;
        b=ZwbBlby/e8rMuLjmQlkSy/cs0R0FEo+RGjmt8Y8sDekrvguD2dOQDd0+BDX+IuoAfF
         EhWbX1AIqGzYXY+03wLOmQmQeXLxyNst2zq08c5VLpOw29Ufk74l8a4kRbjWffEk11+w
         +ZDOSS6T1l2z9gJY/Cbs70Tb7bNCtfSpYe02JA3id/JChv3sBr95Kl7y/d9Y6aEyuwTg
         67P7kizVd4nsVTM2R0PGIewQxZiF4VexHsblYi/Caa89PjLloN34EDO6ExTIkm9vn2WT
         GciW48hCPdjzpkxnXSzwoNwOGIKDpJO6Yk5TRilhD0v8eTIiXdpB3ybKwpxYC1KI0Z2D
         Ffiw==
X-Gm-Message-State: AHQUAubf3tLj4x4eytetwIAzzqP3jotDdCd0meWQDAZxJA9NGIgaJJ6O
        HRUFkx7rAV0Kf0l0XNNycr6/yfOE5Jh2Ekk9pwa+QQ==
X-Google-Smtp-Source: AHgI3Ibl/NifKmtLTTiz2V0lEfdzQgZb1fwjmD/Pc2ndKKjjogcakyM8WJb2ybQ16BCwaYArZp+Y2c3c4sk5FslIlVE=
X-Received: by 2002:a24:328c:: with SMTP id j134mr1698032ita.71.1551397161184;
 Thu, 28 Feb 2019 15:39:21 -0800 (PST)
MIME-Version: 1.0
References: <1550999629-31791-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CABXOdTdprS1OL534XQq8yHTFDzXdWWODq3VGrSEHYe2wmV5zfg@mail.gmail.com>
 <CAK+PMK67rWZarOV31n=yYbRMq3wo9vDyMTQ93PFZ7PRUMS66Ng@mail.gmail.com>
 <CABXOdTdbev2nKNjocqxOyPcGOU8zbWpQ7uALWZdEHL0CXkYDgA@mail.gmail.com>
 <CAK+PMK5U4YRtJNUbsQu3ARJFxwai7W=DjPfjuX_AZMFcUZ-c_A@mail.gmail.com>
 <39dc9be2-808e-4800-b4bb-605d5bf94e12@collabora.com> <CAK+PMK4ov8jJh7wZoTErikuztf=eOruG8xYt6umjt35f9EaGaA@mail.gmail.com>
 <3959820e-cf43-2370-7cea-7afd01b2933c@collabora.com> <CAMHSBOXF_PtSTpcnVcJE7bMRA85TCqZdJL3Md4Z_Cd4Djjkw1A@mail.gmail.com>
 <CAFqH_53CF2rOVt8G=amQXC2_0mNXZw2m8_kvkM2wMjx6GyWSaQ@mail.gmail.com>
 <20190228075656.GA9224@smile.fi.intel.com> <CAFqH_53Ued9vyBZDkpEzdFo=hRQs8J7QSQ-o7XRnDc2meb1GiQ@mail.gmail.com>
In-Reply-To: <CAFqH_53Ued9vyBZDkpEzdFo=hRQs8J7QSQ-o7XRnDc2meb1GiQ@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 28 Feb 2019 15:39:10 -0800
Message-ID: <CAPUE2uubM4cADJL6tr84+M47W74r3btVff3LKB6+ELyzSnP5WA@mail.gmail.com>
Subject: Re: [PATCH] cros_ec: instantiate properly Intel ISH MCU device
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jett Rink <jettrink@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aaron Durbin <adurbin@google.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 4:18 AM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Hi Andy,
> Missatge de Andy Shevchenko <andriy.shevchenko@intel.com> del dia dj.,
> 28 de febr. 2019 a les 8:57:
> >
> > On Thu, Feb 28, 2019 at 12:05:35AM +0100, Enric Balletbo Serra wrote:
> > > Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dc., 27 de
> > > febr. 2019 a les 19:37:
> > > > On Wed, Feb 27, 2019 at 10:08 AM Enric Balletbo i Serra
> > > > <enric.balletbo@collabora.com> wrote:
> > > > > On 27/2/19 16:13, Jett Rink wrote:
> >
> > > > You're right, the cros_ names are based on what the EC provides.
> > > > cros_ec for generic EC, fp, tp for fingerprint, touch pad
> > > > respectively.
> > > > ish is for standalone sensor hub [it does not have to be Intel Sensor Hub].
> > > >
> > >
> > > Thanks for the explanation. I didn't know that and I assumed the 'i'
> > > was for 'intel', maybe would be good call cros_ssh or cros_sh to avoid
> > > confusion?
> >
> > i is for Integrated. There is no confusion.
>
> Ok, thanks for the clarification. Now that is clear to me I'll send
> some reviews of this patch in a minute.
Regarding cros_scp, it may coexist with cros_ec or be standalone. It
is not clear yet.

Gwendal.
>
> Best regards,
> Enric
>
> > It seems you misread what was written in [] above.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
