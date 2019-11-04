Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C14DCA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A9520848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/cI3U9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfKDPSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:18:38 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41338 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbfKDPSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:18:37 -0500
Received: by mail-lf1-f68.google.com with SMTP id j14so12535017lfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+E7LWzV2qXCNRIBtcAIV+W0ZCP1K/HQKiWB7nT2TOy8=;
        b=D/cI3U9xqryIIgDDI2eBVyrOv6zSDY4Pv+f328Xd9w0FWRKPL9SepMctPo8vzhaaXq
         JKh/YWLF8H8HIBlZDPxh1/vPfUusVLkKj9OZoYWNzerJtUMNPqKhjNTdpnRpyqslruwb
         CegL3eXGFM1VOu/QZKgQ/twCosf0mPtB6Kxb9u42OOC+Ssqzahiso82Zdjw2L1L1kNgH
         IcnrI8vlT9QbPm3Y1rddZ4S8y8GqiWg7CJ4+g2TaNNPSbjKt8VyTvY6valcRjKybX5Vs
         5ePdycM5TguOwltalFWXkyGhlR5maH6n+maZG1hptHww/xI9mWVeSA391hIKB7dsGeTZ
         J89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+E7LWzV2qXCNRIBtcAIV+W0ZCP1K/HQKiWB7nT2TOy8=;
        b=RlCVD2+pOc6F2PNl//wkEH2ScQvbHYtzF78Wv4GA3HD9h6THKMLImufuKpATeW18g6
         HWVceJi62v4h6Y4gYZOW6dWcYPn6s7pBKs68XSKCI0KySXweHAD9Bn1T9jhXx9aepapw
         eJBXKlMExeMgsSZTOhBoh7B0n+dm3uhtkkxTVOX283HVPm8yL9QiUHWZfFYos1gQ2+mk
         Fz40RsxkgbM9GrmL0mks2cL4lU7Kde0PITN8y/UV9b7Vqiip6wxLluIgPaYV9sUVQ8SL
         Vh/J3Z0llOYsa7lIrBagPGl2oRD0Gi6d8PvAS4FECcizTpFMfzQXEYy+MC0ett+Rq5MX
         DopA==
X-Gm-Message-State: APjAAAWi1qa57fj3c3s0C9K3GJbyeNfLzccTowXolxy7lFCkEAZEWHLF
        tWfG4hqFYOKohSgPtY4VcMu88PqiYhbR6OaMFj3vxQ==
X-Google-Smtp-Source: APXvYqzj/twzOpW0JzQapnFO7QVDw82naU/CokfBf0anIa43kxBTcOQzzxx1Ne85jRVyIt1xkLGVqg4MTcpngDB6R7k=
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr16950975lfp.5.1572880715670;
 Mon, 04 Nov 2019 07:18:35 -0800 (PST)
MIME-Version: 1.0
References: <5dbb2acf.1c69fb81.54ce2.2f48@mx.google.com> <9d1a6cba9687f94b2d36a82f42f5d4be2b16e7a6.camel@alliedtelesis.co.nz>
In-Reply-To: <9d1a6cba9687f94b2d36a82f42f5d4be2b16e7a6.camel@alliedtelesis.co.nz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Nov 2019 16:18:23 +0100
Message-ID: <CACRpkdamE_Zyein+6x70noJ5Z6RJpV2qJEHOVwPxysONH+-Rag@mail.gmail.com>
Subject: Re: linusw/devel boot bisection: v5.4-rc1-31-g6a41b6c5fc20 on rk3399-puma-haikou
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "tomeu.vizoso@collabora.com" <tomeu.vizoso@collabora.com>,
        "mgalka@collabora.com" <mgalka@collabora.com>,
        "matthew.hart@linaro.org" <matthew.hart@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "bot@kernelci.org" <bot@kernelci.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "guillaume.tucker@collabora.com" <guillaume.tucker@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 8:35 PM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
> On Thu, 2019-10-31 at 11:41 -0700, kernelci.org bot wrote:

> > Breaking commit found:
> >
> > -------------------------------------------------------------------------------
> > commit 6a41b6c5fc20abced88fa0eed42ae5e5cb70b280
> > Author: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > Date:   Fri Oct 25 09:27:03 2019 +1300
> >
> >     gpio: Add xgs-iproc driver
> >
> >     This driver supports the Chip Common A GPIO controller present on a
> >     number of Broadcom switch ASICs with integrated SoCs. The controller is
> >     similar to the pinctrl-nsp-gpio and pinctrl-iproc-gpio blocks but
> >     different enough that a separate driver is required.
> >
> >     This has been ported from Broadcom's XLDK 5.0.3 retaining only the CCA
> >     support (pinctrl-iproc-gpio covers CCB).
> >
> >     Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >     Link: https://lore.kernel.org/r/20191024202703.8017-3-chris.packham@alliedtelesis.co.nz
> >     Acked-by: Scott Branden <scott.branden@broadcom.com>
> >     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Hmm,
>
> I don't see how this commit would have caused the oops. The new driver
> shouldn't (and doesn't appear to be) run on any platform as nothing
> declares .compatible = "brcm,iproc-gpio-cca" (yet).

I think it looks really bogus as well.

Could it be that these systems are memory constrained such that
the kernel image just exactly right now collides with the upper
memory limit or corrupts its own ramdisk?

I suppose I can't ask the kernel robot to do any more detailed
debugging.

I can't see any problem with this patch.

Yours,
Linus Walleij
