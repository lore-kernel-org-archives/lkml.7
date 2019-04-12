Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6A1C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB7E72171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="b3OWzac4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfDLPbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:31:24 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38010 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfDLPbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:31:24 -0400
Received: by mail-it1-f193.google.com with SMTP id f22so16192203ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 08:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6qNz5Eb0sAHZK0rMj4FoBevon1ueumNJnBLLXCKm9Eg=;
        b=b3OWzac4ZfpvutCax0hKE9hzZiBKEhOypO2tNLYv29f3+gchpQgchpRPbksX4iWQoQ
         fD7uW2kotnAbkwgJqVNILpQGHUdX8indKazynzEl7Z4VKbmmexxg8DZdWBm5GKXOogyJ
         cinZz577vm1Wg/KvOajDd3dahVsQLoSnL7AYHcqANNZA/469PO9xYKtLdlvfTeDL47Rz
         axbo6bCELSTqP71Mnepf7WpnSCCCwGpFtc4lFU7+iHM4PQl5JLBNavSQ8RyPduiu7ehD
         UBmHj0kTAJ6SBTqA6IDvD0BGxK1UfRwMSkJPt+tFsQWhQuDSlbGYCp3BZTHDyBTbR4GM
         Z9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6qNz5Eb0sAHZK0rMj4FoBevon1ueumNJnBLLXCKm9Eg=;
        b=F9evVJ4C6yC/byY4hS8eP2mjZ2L6CwGoJ0nj6VkicV6vEkK9CNGJ9VRxx0IJAskZY7
         W49N8sMR74HyWa1zalIsJ+3hZgho4kAJx6crScGifTXRaykUi3kGpe80YigyXDymWsLb
         m+QOu1w3E/zN+2bREjSUel1Sw+Jr8LjrmBg3FfOb5AmsAdEiT3vnzcuHeB2+rqsEqVmM
         QFkASH50pYWitTSe1hKGKf9800ompoJ9vP5yadSEWaWgZOqkm0Wv2PQtPo/03cX1RhM9
         ZRFmFdGBNqmuQ1RNWE6IHhggZ5dpq/5nJlPsSJs0zZ7Hz8mR17ydEhKbIE1bQ7e8ZSrK
         YeJg==
X-Gm-Message-State: APjAAAUXvlPP0RaVfqke812oXUf0yrdTLyHbZpPlFccJL+mBFeYB+6re
        mk7DNBlR3KKDV0L5BZBYwcS3jpaV8aRTMLAx/X/F+w==
X-Google-Smtp-Source: APXvYqz6lj8DwqaP9tDqwZnZ7cBTM2PGLmSHEp+M+qm795bQ8vs3hxrFv5Wk/VP8h5H8iRGOOMkutPRe5pAqItXbLrg=
X-Received: by 2002:a24:ad2:: with SMTP id 201mr13045636itw.26.1555083083575;
 Fri, 12 Apr 2019 08:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075924.2284-1-brgl@bgdev.pl> <20190408075924.2284-2-brgl@bgdev.pl>
 <5f72a26b-428a-c50e-cb6a-7c888ea22329@ti.com> <CAMRc=McGwGh9RKhxxCDnz3aMG_EVjjXzN+pmMZVtE7aChdU3jw@mail.gmail.com>
 <3f6c906b-53b0-8284-bf4d-9b404f341e7b@ti.com>
In-Reply-To: <3f6c906b-53b0-8284-bf4d-9b404f341e7b@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 12 Apr 2019 17:31:12 +0200
Message-ID: <CAMRc=Me8vppb9vEmKOUcU28YKVR9jJ64sBSn-KwNyNnZA=VB9Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points
 to DT
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        Adam Ford <aford173@gmail.com>,
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

pt., 12 kwi 2019 o 15:53 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 12/04/19 5:41 PM, Bartosz Golaszewski wrote:
> > pt., 12 kwi 2019 o 13:26 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
> >>
> >> Hi Bartosz,
> >>
> >> On 08/04/19 1:29 PM, Bartosz Golaszewski wrote:
> >>> From: David Lechner <david@lechnology.com>
> >>>
> >>> This adds a cpu node and operating points to the common da850.dtsi fi=
le.
> >>>
> >>> Additionally, a regulator is added to the LEGO EV3 board along with
> >>> some board-specific CPU configuration.
> >>>
> >>> Regulators need to be hooked up on other boards to get them working.
> >>>
> >>> Signed-off-by: David Lechner <david@lechnology.com>
> >>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> I remember you mentioning about some problems using OCHI and cpufreq
> >> together. Are those resolved now? CPU PLL on DA850 can affect other
> >> peripheral clock frequencies too. So enabling it should really be a
> >> per-board decision.
> >>
> >
> > The problems are still there. I've never been able to find the
> > culprit, but it also occurs on TI BSP in the same way (a couple
> > cpufreq transitions will make the controller unresponsive).
>
> Is that on LCDK as well? As I recall cpufreq was never enabled on LCDK
> in TI BSP.
>

Yes, I just verified that the bug occurs on LCDK with patches from this ser=
ies.

> If the OHCI problem is present on LCDK, then there is a user visible
> regression on mainline after this patch. Lets enable cpufreq in LCDK
> only if all working peripherals keep working afterwards.
>

The OHCI driver doesn't register any cpufreq transition notifier
callbacks. I can't really find anything in the datasheet, but I'm
wondering if we shouldn't do something similar to what the driver for
davinci i2c controller does. I'll try a couple things tomorrow.

Bart
