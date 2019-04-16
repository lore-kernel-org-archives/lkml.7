Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E05EC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FD42073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="A1I5fIfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfDPIiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:38:07 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53743 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPIiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:38:05 -0400
Received: by mail-it1-f196.google.com with SMTP id y204so31694639itf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jQxvUWSwtK7zYPTwcaXDUPb2AnwQG7E875BQ+couwhM=;
        b=A1I5fIfx+jKxT0eIe+fNoCuJaJz6ehEfIweuKyRJiFOpZ9kfVYr9DBwDDNZgIGZTVy
         n22zPVNoM14g2jd0KNybdHTUDpN2YtApc9RkJRMchu/b8FNkXXEMtH25HMOOqxkmAjJT
         P83fAXWU5cOSWdHzQR30/XyJ1uqaCUJg9tTq4OrYaV9/ADNQfirgaCtLjVcdDOzmisdp
         oc31KDY4+MkY+KPQ82FAxpRYOHizpOnQ3VZGN2+98uDHN3Y1Zdkf4Az1kqeZM2ldIycV
         w4P0U1gH8CsOGxw5Yv53eLPPvVC8QG1zS85g4L3g365nuMJ9+B9Sd5bKs/e06jAqlDK0
         YyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jQxvUWSwtK7zYPTwcaXDUPb2AnwQG7E875BQ+couwhM=;
        b=kL5asCDthQMh7IGs/WxFyQmKiB6N5wx4hXUqy6AgvUrq5Yi9nSAiq2oXqjCNObkYX5
         44jjYFJvfLgOHIPi98xK0FCsLplYiAAVy8oZi+g0yKSYTwq1/zYWy8EMwW4ANGOqeNge
         N/4UgDn/yKwpZpW4HCjcXjK5+8PvgUv8gMreYNeSZLVpj3JiCPYS0nQbT9j2DVdjAoHc
         9hi5DFRKZ4EhQSE7PDDl7KrZRKrU0Xi23Esys12hCBNYRPLG3OQ0obtLldF5Y0WKy76y
         lXJ6p3tzuDdT3xZJkaXrQQovsGU2WopsWdiY8/EuKiO3fLtqfXJ/EAtrYS1WLrYDaNUv
         gWWw==
X-Gm-Message-State: APjAAAXTlLjS2oh6bw5nhIBBkwexExLLu7HoI7JJuD+fvvlCN3+JBipA
        rIlmFSa5GFSqhe+9IsbaRy3XZt7BuA5qasSVE5u/0A==
X-Google-Smtp-Source: APXvYqyl04Z6bUCRh2Kmq/a24ZwaqGXZ6x0DFDbuogSRdKLd3mPVNEELQRC7GRoNNpnylgSwXNeKR9MdCnNXwrlihBY=
X-Received: by 2002:a24:351:: with SMTP id e78mr26134284ite.160.1555403884243;
 Tue, 16 Apr 2019 01:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075924.2284-1-brgl@bgdev.pl> <20190408075924.2284-2-brgl@bgdev.pl>
 <5f72a26b-428a-c50e-cb6a-7c888ea22329@ti.com> <CAMRc=McGwGh9RKhxxCDnz3aMG_EVjjXzN+pmMZVtE7aChdU3jw@mail.gmail.com>
 <3f6c906b-53b0-8284-bf4d-9b404f341e7b@ti.com> <CAMRc=Me8vppb9vEmKOUcU28YKVR9jJ64sBSn-KwNyNnZA=VB9Q@mail.gmail.com>
 <6ff5711c-b607-1f3a-e362-709b53762179@ti.com>
In-Reply-To: <6ff5711c-b607-1f3a-e362-709b53762179@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 16 Apr 2019 10:37:53 +0200
Message-ID: <CAMRc=Mfb4xrpLkJoX0SyoCPU6Au1TPxCtr29EhvU=VsKkSt2xQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points
 to DT
To:     Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

I've been trying different things, like suspending the device before
the transition, resetting the controller or playing with the clock
during transitions but it always results in the same kind of error:

ohci-da8xx 1e25000.usb: frame counter not updating; disabled
ohci-da8xx 1e25000.usb: HC died; cleaning up
usb 1-1: USB disconnect, device number 2

If you have any idea - let me know, otherwise I'll give up.

If we agree on the direction of these patches, then I can go with a
single enabled OPP for lcdk (456 MHz) and all OPPs up to 375 MHz
enabled for da850-evm.

David - do you want to keep the lego board as is?

Bart

> How do you feel about keeping all OPPs disabled by default in da850.dtsi
> and enabling only the ones that make sense for a board in <board>.dts?
>
> Empty OPP table is illegal, so this does mean that every board must
> enable at least one OPP.
>
> Thanks,
> Sekhar
