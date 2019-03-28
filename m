Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1412AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF949206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="HkADOGq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfC1O3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:29:54 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:32844 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfC1O3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:29:53 -0400
Received: by mail-it1-f196.google.com with SMTP id v8so8506028itf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3S36uN06t6hu4ob7QvMwmkwpcM+ZIMDH9rbyzhpEx4w=;
        b=HkADOGq1Ia+BRnLgB/khPXUqjMX+JUC/yKnFzJ3kztx45IwMNrRmtvV7G9NCOS1zHb
         SLMySb59DwH45WGbuUrhmEb06flZdz6HchUVBz5z7Bpk8CDxKR/zehOwOMi0y8Kci3n5
         egPjkpIwV6VL0TAkwNKffi1zDNd+xYVaTvOOBxtgoXW/XMBqDQbuA44s4bDJkkEKEcK1
         VeRyPlfiAUBJ2uetuGidgnMcD0lyzaT2WaqJnoQ2ZYhkB9YjH+cqBnuSYjJVCuwmBFgW
         x3dtDPKp4P0D1n5eCvkbGXk9dOv5pjLzodBzuauSiXdAB/zGnvshyLAsoZEzE9XaTpiq
         YnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3S36uN06t6hu4ob7QvMwmkwpcM+ZIMDH9rbyzhpEx4w=;
        b=lPqposouzj55gwULZnYOcT7dFU8N4wljhxiAOnXdToZqwyIELFBKlPMGNF7Wb+spMu
         bx040WozH5CK3PzgjVkQ9qMGKXPXtyt2U6n1ixpZZPMn/1C8T8PZIFnq9Pu8HIyM9ofq
         TTPQ2gB/qSlBmB3u8bfC0r5OueiXML0lDUydprQ/4pybUoinrHBgwgiMtt1H1j7OPA1V
         xcDg1cc89at5LdCRc8Mf7fgH3ywGOJXFzVzaRsm9ra6ZgOvlL5MPfjI1ypyJZlvSbKyS
         RwUAiNGKocUFZU6WupSDqram1A+BuAVVmD5orEZPecvJNhPUK3U1dBbPZ/JQSkMstd42
         ZtoA==
X-Gm-Message-State: APjAAAVbGikdLDVPxZPR71Sbmx90JeG63SLnq7ThtW++4xUPzZ5cFAFU
        FVFOcBX0DoBGgZeUpMoHMqyoE+1mBQVlLSObz6sjPA==
X-Google-Smtp-Source: APXvYqzUdSDDFW+Tc6IDmebiIFNGcUJ9el422bWv3TlXcRBggyS9V+A9b2pn/dT8fhzkipZD3z9MEgZS/w/A2r8VnxM=
X-Received: by 2002:a02:5341:: with SMTP id n62mr30460530jab.57.1553783393099;
 Thu, 28 Mar 2019 07:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <3d7f7814-6184-96c6-8087-6373a489ebc0@ti.com> <Pine.LNX.4.44L0.1903281009430.1448-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1903281009430.1448-100000@iolanthe.rowland.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 28 Mar 2019 15:29:42 +0100
Message-ID: <CAMRc=Memgo9LwgmZqGcDZpGz02qSLst2xdMhED6_fxJkLDBowg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARM: davinci: ohci-da8xx: model the vbus GPIO as a
 fixed regulator
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 28 mar 2019 o 15:11 Alan Stern <stern@rowland.harvard.edu> napisa=C5=
=82(a):
>
> On Thu, 28 Mar 2019, Sekhar Nori wrote:
>
> > >> Can you document why the current solution is not optimal? Is it to m=
ake
> > >> future device-tree conversion for these boards easier? Or?
> > >>
> > >
> > > It's sub-optimal from the HW modeling in SW PoV - it is in fact a
> > > regulator enabled/disabled by a GPIO. Also: it's code duplication as
> > > currently we check if the vbus GPIO exists and then use it or check i=
f
> > > the regulator exists and use this as the second choice. The third
> > > patch actually shrinks the driver.
> >
> > I see now that the driver supports controlling the VBUS gpio as
> > regulator already. Something I should have caught in review last time
> > around.
> >
> > I agree this patch is an improvement. Lets see what Alan feels.
>
> I'm not an expert on this stuff, but the patch looks reasonable.
> However, I do wish that in the devm_request_threaded_irq() call, the
> indentation of the continuation lines was left unchanged.
>

I don't think it's possible - the function name is longer and the
first line exceeds the 80 characters limit. I can put all the
parameters below the function name if you prefer that?

Bart

> Alan Stern
>
> > Also, reg_enabled member of da8xx_ohci_hcd structure seems to be pretty
> > useless considering regulator API already has use counting. Can you tak=
e
> > a look and remove that too as an added bonus.
> >
> > Thanks,
> > Sekhar
>
>
