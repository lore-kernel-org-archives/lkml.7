Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2261CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED2AB22525
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PkjNRkn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfLFD5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 22:57:42 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39453 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfLFD5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 22:57:42 -0500
Received: by mail-vk1-f196.google.com with SMTP id x199so1875845vke.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 19:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NF2TIgmeiKLc8OSPqrcNIp5mQB/f5dRyqwK9nEPTSP4=;
        b=PkjNRkn02UgTjGBgc5/9D3h2nMrNLq0Cw2A3QAvH1tiwvsR9DE56ThroE6+bNx5gKp
         MWhm4fwGPsQUtPxIqrLGNv4HrZYnwpb+hbMNIgcA26V5pVzgzy8RACNZxIE9MW1FBMZ6
         9bVrspszxnjn3/VI6m7W3PnqMNha3THczuI6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NF2TIgmeiKLc8OSPqrcNIp5mQB/f5dRyqwK9nEPTSP4=;
        b=cjtYDgLacSqC0+lysSxPzMPC/rFeH9kainyF/c/h4wq0GrQ64PqtugXC2A7YdsluQb
         jhzkw1ImGJDfMoYx2vJ6FP5JzNEJbd1K0uicn9QVbGjChBYQbesaGFMsdmHGIVhZvxqi
         Y3WK+QsD4pkGosdxu478b3ZwyhQ4C1DE8nFLV6CnYTC/8ryP4ZwQIeKzqsRUtgTvycz8
         +ufdPIHeDezUOSRYrgKpIhXbNRgWRNfj2wp8puSx3CRQmHt7uS0krlM9VoPME5bx2cYX
         Ut1PABf+N5GDgGq/PDpItABtPeSG9MEzyaKgArHzjmcoZqh5Jy32e63fCvbmkl4V41NN
         9iJA==
X-Gm-Message-State: APjAAAUjM8Q9LRhXhgwucFcf7scZVDtjSRDnOe0obPM3eZhYeC/nAETx
        NBTfjJEKNfCYCNAWc8z6xwkybli8lwMiIA95NEz0Xw==
X-Google-Smtp-Source: APXvYqy0q0ERrB54cSMIMX6GUZG6FZslLzz9ZYmK/HB3EG14/jQcEMhGEy7X6uBZQMf77jeBU8YkZinOn+AqgVb5SRA=
X-Received: by 2002:a1f:d904:: with SMTP id q4mr9338990vkg.13.1575604661175;
 Thu, 05 Dec 2019 19:57:41 -0800 (PST)
MIME-Version: 1.0
References: <20191203101552.199339-1-ikjn@chromium.org> <20191203165301.GH10631@localhost>
 <CAATdQgCqYrd_aXN5GDsso+F3WadNx3DQKK3Efk3tgkrv2VXjyw@mail.gmail.com>
 <20191204075533.GI10631@localhost> <CAATdQgBcuJenS2VSm+y4Yhn5mWE1P0CGJQ3NRdoe68dd2SRPGg@mail.gmail.com>
 <20191205142641.GL10631@localhost>
In-Reply-To: <20191205142641.GL10631@localhost>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 6 Dec 2019 11:57:30 +0800
Message-ID: <CAATdQgBK4gWvR06YJ3Z_y5NeqLKYY7Ajc0KG78rG2deR3Ga11A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] usb: overridable hub bInterval by device node
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        RobHerring <robh+dt@kernel.org>,
        MarkRutland <mark.rutland@arm.com>,
        AlanStern <stern@rowland.harvard.edu>,
        SuwanKim <suwan.kim027@gmail.com>,
        "GustavoA . R . Silva" <gustavo@embeddedor.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 10:26 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, Dec 05, 2019 at 03:32:38PM +0800, Ikjoon Jang wrote:
> > On Wed, Dec 4, 2019 at 3:55 PM Johan Hovold <johan@kernel.org> wrote:
>
> > > But related to my question above, why do you need to do this during
> > > enumeration? Why not just set the lower interval value in the hub
> > > driver?
> >
> > Because I want device tree's bInterval to be checked against the same rules
> > defined in usb_parse_endpoint(). e.g. although hardware says its maximum
> > is 255, but the practical limit is still 0 to 16, so the code can
> > print warnings when bInterval from device node is too weird.
>
> But that could be handled refactoring the code in question or similar.
>

Yes, that should be worked. I can't exactly figure out how to refactor
the code for now, but maybe parsed endpoint descriptors are being
checked with default hard wired bInterval value and after that
an overridden value should be checked again.

Actually I don't care about the details of software policies. I just want
all devices to be handled in the same manner without any further
special treatments.

> The fundamental problem here is that you're using devicetree, which is
> supposed to only describe the hardware, to encode policy which should be
> deferred to user space.

The hub hardware has a default bInterval inside which is actually
adjustable. So I can think setting bInterval is to describe the hardware
rather than policy.

>
> So I think you need to figure out an interface that allows user space to
> set the polling interval for any hub at runtime instead.

Changing the interval at runtime is an another way to solve the
power consumption problem, but it's not so easy. At least xhci needs
to restart an endpoint and no devices are changing the interval after
enumeration stage.

Thanks!

>
> Johan
