Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E22CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A9720643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rGggi2b0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390146AbfDRTuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:50:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42546 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRTug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:50:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id w139so2518910oie.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 12:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRvT1PEVseMZAP2ynkS/SS5qFXKObpz+RcLF5TwvBXk=;
        b=rGggi2b0m/5WpygkewyHZhqZ4YCrnifo4SxyC67gS7vCldse0rBXEw94uSd1GhrKQ7
         DLJ5DhGEZxg9bK6XF3rM9I2+fydi+9m6PM5m38JgF3wg9KUlnqS0fRUPgkcG2MCcQ+pE
         Lla3gh3OMUDOEvvgL+8uBI5RBxKEnyTboGvstoU4myq94OyeGkyI2frTmri+bboM9wTd
         MrAdvlDSo3PtyPU74/S+7AN0sGHKQxeGHdu0e7fmlrR8uRi3WklIPMewSQw9gBQFXiLF
         u2Ik+/CCPE94yHTbX3T2cPMzz4b7OyIOBGtjdAIxErbT7v4pPCVuPT7a59GggwD76INX
         Boaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRvT1PEVseMZAP2ynkS/SS5qFXKObpz+RcLF5TwvBXk=;
        b=SXDj6ife4iS15J3zwmTeraqlLu7NDafrH42nfwpWpnXFJpJSAXwRqbpl0sOIpR82ie
         1yID+ukwKGcLZiF4ba5ybonNUgNxwpjF4zVoHObLt40KTSrVzsZMSd4hyEdNSOVumGp1
         Ju7DPs1EcueUy1u4RqHDKNLtGDADoghYD29MBrVmFm40GAXqX7ojbFo8eGXU3qxZCIzX
         vhk7ZglHBCR7WpVxESZHAWZT+VC1LU/XrmNyy+GRZmFWP00n90W7Ll0GaKQVNh5T2l0v
         zSoNahwx/vwOCRHk9X3GWFeDEjLH88P3DrZE1rFdezfwy3C9SW9Bi/6RzsV8pnamohdJ
         c0gw==
X-Gm-Message-State: APjAAAW5OQcA6yhJhlqjx+PwF8JqTd0P6ggANt+EjkXmIU5MiXS21yBU
        /qLzPzfJna7syVMc3pAzNyqz+QO8FyH+c+kRTRJbccWx
X-Google-Smtp-Source: APXvYqxJGLZyK9SBJ5gTvhX4LITdBpL+VDqbCCkvMoR7TiLp2bOwDBC3yJnUSiSepeDpi6ZM3ELU54+1/aBp6t95PdI=
X-Received: by 2002:aca:ecd1:: with SMTP id k200mr3126007oih.15.1555617036093;
 Thu, 18 Apr 2019 12:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190413171532.25967-1-martin.blumenstingl@googlemail.com> <CAHStOZ5Pe9LvDk4cKAVB4SS5wgFcK-bweFTqU_mnEhOAyZKHuA@mail.gmail.com>
In-Reply-To: <CAHStOZ5Pe9LvDk4cKAVB4SS5wgFcK-bweFTqU_mnEhOAyZKHuA@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 18 Apr 2019 21:50:25 +0200
Message-ID: <CAFBinCD4OnBbU0YR5P5cAhut==XXUxdHSxHQkBVm28DHZWkbAw@mail.gmail.com>
Subject: Re: [PATCH 0/3] 32-bit Meson: add the canvas module
To:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Cc:     linux-amlogic <linux-amlogic@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>, mjourdan@baylibre.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Sat, Apr 13, 2019 at 8:54 PM Maxime Jourdan <maxi.jourdan@wanadoo.fr> wrote:
>
> Hi Martin,
> On Sat, Apr 13, 2019 at 7:15 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > This adds the canvas module on Meson8, Meson8b and Meson8m2. The canvas
> > IP is used by the video decoder hardware as well as the VPU (video
> > output) hardware.
> >
> > Neither the VPU nor the video decoder driver support the 32-bit SoCs
> > yet. However, we can still add the canvas module to have it available
> > once these drivers gain support for the older SoCs.
> >
> > I have tested this on my Meson8m2 board by hacking the VPU driver to
> > not re-initialize the VPU (and to use the configuration set by u-boot).
> > With that hack I could get some image out of the CVBS connector. No
> > changes to the canvas driver were required.
> >
> > Due to lack of hardware I could not test Meson8, but I'm following (as
> > always) what the Amlogic 3.10 vendor kernel uses.
> > Meson8b is also not tested because u-boot of my EC-100 doesn't have
> > video output enabled (so I couldn't use the same hack I used on my
> > Meson8m2 board).
> >
> > This series meant to be applied on top of "Meson8b: add support for the
> > RTC on EC-100 and Odroid-C1" from [0]
> >
> >
>
> The series looks good to me, however I wonder if we should maybe add a
> new compatible ?
>
> The canvas IP before the GX* generation does not handle what Amlogic
> calls "endianness", the field that allows doing some byte-switching to
> get proper NV12/NV21. So the following defines are unusable:
>
> #define MESON_CANVAS_ENDIAN_SWAP16 0x1
> #define MESON_CANVAS_ENDIAN_SWAP32 0x3
> #define MESON_CANVAS_ENDIAN_SWAP64 0x7
> #define MESON_CANVAS_ENDIAN_SWAP128 0xf
I didn't know about this - thank you for pointing this out.

your suggestions to add new compatible strings is a good idea for that case.
Amlogic uses different defines for Meson8 and Meson8m2 in their vendor
kernel and they keep Meson8b different.
I will add three new compatibles, one for each SoC (Meson8, Meson8b,
Meson8m2) just to be on the safe side if we discover differences in
the canvas IP on these SoCs.

what do you think?

> It wouldn't change much functionally, but we could have e.g a warning
> if a m8 canvas user tries to set endianness even though it does
> nothing.
this is a good idea, that will make it easier to spot why something
doesn't work.
we can also return -EINVAL, like you already do for the case where the
canvas ID is already used.


Martin
