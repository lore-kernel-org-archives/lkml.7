Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3294C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7815220643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="um9UbIA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgAHVNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:13:41 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41205 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAHVNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:13:40 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so4781484ioo.8;
        Wed, 08 Jan 2020 13:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NF2iAzKqLye3p4CHVHM567AecN0C/BH8Y1Ur9sjobCA=;
        b=um9UbIA80csKtHl8AeihiuTfvTRvK8bOX1bT/8+/0wl++bihWaQfWo1G8wMJFArwx4
         YevDL5p7ZfnAK/P73p/WZwWcJC8Ys+c0LQ9KWWN+BB6/nLWLEaXKFhXvla3hoRNeXGuQ
         NvwhZ9TT2hBH0ZrCTKUG5V67AE4q46nUdeybv8OUA8tyOtGB9jBXKhvlyz9Zg6Hk5X21
         lDPnpx/fNPqwxWOk5+vb23q/fBeC0VTzEYRp9ZvBZl93YF+PLvhXS7hRQrx+fpsXNLqh
         ZycS6JVTrsnZEps9g/F9JckEfo3QinEvzucC0jnXVUNBuk2zojPpJFp4Lfgk29QGg2Wj
         +Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NF2iAzKqLye3p4CHVHM567AecN0C/BH8Y1Ur9sjobCA=;
        b=VF8+P3ds3Wge3++lXvXM9iSIhvS+ZjZOrEtH8K6eK3COWsyOfZ9Ge2rPKNweqV/0jT
         5CJRGRdah6MMp4ReOaeDYyRR8c0tgADbP/njuQYnxF7UJ6NMHto2amXASEucbE2OOj3u
         E0pl4V4nnrxWxLejHSIkuSJmLU+4QVqDfCIfF2eS8qpfuhdUxA4p+iy+9Jcy6yV8RPgf
         /76QqnpEuw/W9CuoUIebrgZH3prPcRrBh2xwPW38Agv4twzdeEDh5sZL+LlXmESK987A
         uG1XzW/BqrDcxbC9vz6eoerou/xxGld12zAV+ai5ivIKllx4e7GdMEmSuy5TcRgn7mre
         E16A==
X-Gm-Message-State: APjAAAWIfO+eh3iQYUARTwmcRXBMLzbgXTFZS4H5P2SvfcJnGN25I6g6
        G8zPkBIPKkBW1nT57VMeWeWaAfcsZP/Xrpd5OHw=
X-Google-Smtp-Source: APXvYqwJtdhvSfSSES4KVqbmZ0C6eMdcEeC3zEc9ASOXYCYC03N6gzLGtw0eroyLCJWVv732eVK+WCvk5qR89rY4sYA=
X-Received: by 2002:a5e:8d06:: with SMTP id m6mr4926187ioj.69.1578518019790;
 Wed, 08 Jan 2020 13:13:39 -0800 (PST)
MIME-Version: 1.0
References: <20200105225509.21590-1-jassisinghbrar@gmail.com>
 <20200105225557.21729-1-jassisinghbrar@gmail.com> <20200108164159.GA2494836@kroah.com>
In-Reply-To: <20200108164159.GA2494836@kroah.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 8 Jan 2020 15:13:29 -0600
Message-ID: <CABb+yY1cSGZRZJEenweRFNPVfkMKiMwowTdnURuFoXnB5+FKGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: gadget: add udc driver for max3420
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 10:42 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jan 05, 2020 at 04:55:57PM -0600, jassisinghbrar@gmail.com wrote:
> > --- /dev/null
> > +++ b/drivers/usb/gadget/udc/max3420_udc.c
> > @@ -0,0 +1,1333 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * MAX3420 Device Controller driver for USB.
> > + *
> > + * Author: Jaswinder Singh Brar <jaswinder.singh@linaro.org>
> > + * (C) Copyright 2019 Linaro Ltd
> > + *
> > + * Based on:
> > + *   o MAX3420E datasheet
> > + *           http://datasheets.maximintegrated.com/en/ds/MAX3420E.pdf
> > + *   o MAX342{0,1}E Programming Guides
> > + *           https://pdfserv.maximintegrated.com/en/an/AN3598.pdf
> > + *           https://pdfserv.maximintegrated.com/en/an/AN3785.pdf
> > + *
> > + * This file is licenced under the GPL v2.
>
> This line says that the SPDX line above is a lie :(
>
> Please fix this.
>
Sorry, that is a relic from forward porting the driver. I updated the
copyright year (guess need to again) but missed that line.

> As pennance, please re-read Documentation/process/license-rules.rst.
>
I will take a dozen lines each day before bed.

Cheers still !
