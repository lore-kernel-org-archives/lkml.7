Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC7BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBEE20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FoRnldgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfDOLzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:55:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43194 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfDOLzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:55:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id t81so13481055oig.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 04:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OJeGfagnzu7sHS6lzKrlFuG5rtL+zOcGoyAKvxG7Ty4=;
        b=FoRnldgZjLl3J9I10P6T2NeNh3n0hkgUdOu1e/NFiidEHY+qKLWsBY7YNdOHs8wn17
         mABhoCs9OXDmZTmYTDQLMDq7ukZ64+h2lO4veRG4SsLufGZLU/jMy2ziuR2KfxBPDPdV
         y+VrraPcuEBeTclGCaRyObfOgmnF1tTAI9+IaoLnoy1srLo9rGbChQvcKj6bPXxZbG18
         XBOBrIO/EYSMQn0i+3Hpi8eq4ha55ko4p0ijRY4dgro5iJ/2O8V3SwFwHPg8IO4dCp/4
         JagJ13OS6o9taRz+b+KFkk3NONdQDzj4VY/qz1O0ZCSo8sh6IFH5bibNFTG1XXVB3L8S
         mJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OJeGfagnzu7sHS6lzKrlFuG5rtL+zOcGoyAKvxG7Ty4=;
        b=Ze6QFdYfGDotAc0sUzYzlBWkSvmx1X4QvcYUIsujKv15Ge0PAJ7YMPNxMLRLKDv3hM
         xp7ZPmTqyo4VXMUjxg8q1MtLICugOj6fVQGNucz0c8cPkNE5U64NzXZjxBA8uRmBcjMf
         4GPrFwuiG7uXsGB1glOpX2PGIFdZvW7M2aSTA3vAzvCVa02OazgsSOZyBiihWYkyCSHR
         c9mbudLFsE1GHAutQbpwml+vvRZfwv3+wVXSiVvELNjZ+d4rx5KARjm6R9fXeeYOQpLk
         k57Vtw0zpU4sf/RkkJ+j+9/jUraJwQvrzxoPamn9stn3luIc3H9UC4UUnO9XXwE7q6kE
         FLwg==
X-Gm-Message-State: APjAAAXqVyiRXwH15wgrHP+w0iBCchu76Uw6u62C05DMM6ak37SpSzmk
        GQih3d9QsgLF/1WYqXHVeKn2bsT0U9dwD4GdBIoA3Q==
X-Google-Smtp-Source: APXvYqzTBlOkus2TSxPt5/3q1kFrELesaQt6aOV30tCUfQYfvCdsJD6KDQSbFNssW/+3SiNuoRHQ+GwNx3nvF1KHBnE=
X-Received: by 2002:aca:f2c2:: with SMTP id q185mr19624994oih.147.1555329309135;
 Mon, 15 Apr 2019 04:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075924.2284-1-brgl@bgdev.pl> <20190408075924.2284-2-brgl@bgdev.pl>
 <5f72a26b-428a-c50e-cb6a-7c888ea22329@ti.com> <CAMRc=McGwGh9RKhxxCDnz3aMG_EVjjXzN+pmMZVtE7aChdU3jw@mail.gmail.com>
 <3f6c906b-53b0-8284-bf4d-9b404f341e7b@ti.com> <CAMRc=Me8vppb9vEmKOUcU28YKVR9jJ64sBSn-KwNyNnZA=VB9Q@mail.gmail.com>
 <6ff5711c-b607-1f3a-e362-709b53762179@ti.com>
In-Reply-To: <6ff5711c-b607-1f3a-e362-709b53762179@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 15 Apr 2019 13:54:58 +0200
Message-ID: <CAMpxmJUG+7ENUCnooexWKMwoq+zCuRsV_Y54un7omumk9nJguA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points
 to DT
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 15 kwi 2019 o 12:21 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 12/04/19 9:01 PM, Bartosz Golaszewski wrote:
> > pt., 12 kwi 2019 o 15:53 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
> >>
> >> On 12/04/19 5:41 PM, Bartosz Golaszewski wrote:
> >>> pt., 12 kwi 2019 o 13:26 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a)=
:
> >>>>
> >>>> Hi Bartosz,
> >>>>
> >>>> On 08/04/19 1:29 PM, Bartosz Golaszewski wrote:
> >>>>> From: David Lechner <david@lechnology.com>
> >>>>>
> >>>>> This adds a cpu node and operating points to the common da850.dtsi =
file.
> >>>>>
> >>>>> Additionally, a regulator is added to the LEGO EV3 board along with
> >>>>> some board-specific CPU configuration.
> >>>>>
> >>>>> Regulators need to be hooked up on other boards to get them working=
.
> >>>>>
> >>>>> Signed-off-by: David Lechner <david@lechnology.com>
> >>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>>
> >>>> I remember you mentioning about some problems using OCHI and cpufreq
> >>>> together. Are those resolved now? CPU PLL on DA850 can affect other
> >>>> peripheral clock frequencies too. So enabling it should really be a
> >>>> per-board decision.
> >>>>
> >>>
> >>> The problems are still there. I've never been able to find the
> >>> culprit, but it also occurs on TI BSP in the same way (a couple
> >>> cpufreq transitions will make the controller unresponsive).
> >>
> >> Is that on LCDK as well? As I recall cpufreq was never enabled on LCDK
> >> in TI BSP.
> >>
> >
> > Yes, I just verified that the bug occurs on LCDK with patches from this=
 series.
> >
> >> If the OHCI problem is present on LCDK, then there is a user visible
> >> regression on mainline after this patch. Lets enable cpufreq in LCDK
> >> only if all working peripherals keep working afterwards.
> >>
> >
> > The OHCI driver doesn't register any cpufreq transition notifier
> > callbacks. I can't really find anything in the datasheet, but I'm
> > wondering if we shouldn't do something similar to what the driver for
> > davinci i2c controller does. I'll try a couple things tomorrow.
>
> Even if OHCI issue is fixed, with a fixed regulator like on LCDK, I am
> not sure the benefits of just frequency scaling will be justifiable enoug=
h.
>
> Fixing the OHCI issue may help in other boards like da850-evm use it
> though. So that will be a good thing.
>
> How do you feel about keeping all OPPs disabled by default in da850.dtsi
> and enabling only the ones that make sense for a board in <board>.dts?
>
> Empty OPP table is illegal, so this does mean that every board must
> enable at least one OPP.
>

I guess in that case we'd need to make 300 MHz the default for
da850-evm, but on da850-lcdk I'd go for 456 MHz (due to the regulator
being fixed anyway).

Bart
