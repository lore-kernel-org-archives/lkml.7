Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAC3C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6340D20718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dXniKX0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfKVLWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:22:32 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35104 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfKVKnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:43:06 -0500
Received: by mail-yb1-f194.google.com with SMTP id h23so2554155ybg.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 02:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xeRsX7uk9JInuVpTCDPgVQn8I9ef6lPqe1vjPRu+FZ4=;
        b=dXniKX0oSrn32S3I6viPYhCnrkW5RC8QBhQ+HnveJ64PajVPXNOf6lWs8ikK324gHX
         W5zx9Tu2PGSqkOTKyD9lBTdsqXTEYDL2EDfYXLSdCRtQj0BA+edOiLDI+Oz5ahHfHH+P
         Ct5z1ckAZpNAdyMglpBVfcW80kIpyOYzncubHxLg2MUPO6B5Qqfn8rsLwaDOd4TJo+1K
         t67LvMmDtCEo7luM9hVrPY9V7lwnxxOO2n4xP+to4SlvZB8PcqMP8lm1ADf08yPC/eAp
         GuV3wIpXTu/csvMN6i2NgalTtPhebuqATZGQF5uTW3ujHIkstYVxKWS5Mw4Han+9ONCu
         QGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xeRsX7uk9JInuVpTCDPgVQn8I9ef6lPqe1vjPRu+FZ4=;
        b=aO9Z0Tsuzg+NLUrAL4HtnliluCv7h+lAU8CoNEbIMvWV3hxh0AFeGDPtEqNYkppl1Y
         LMZ8GPW33CPzIViR/YDeESO5Mvz6Gzp/vBv8VtlhndyXjsnuSY8+kpdfe9I01g3MCsvg
         Y/+xEHWHJJKEeO/Hh7gqkG0wQQ1TYbOOgbIKPhyshrf+Tury9bIiBEkQk1pHK5DQiNM6
         DtuNOWm+VZq/LPJ7F9DrKn1YuzKb3zBWX/z6gr4Xz8dx42Y7H3oRYskcuTndBOLWixty
         QKIqNurYh4d7iz0nCjelUif6DKNJSi8R09jERyY8/FyAg1yFHsF+ZI9eBtx65Rnkxzlh
         aYYQ==
X-Gm-Message-State: APjAAAXrtT6XxJLJpV93jR+NXX7m00xeVd8Qb8xPKi7caz3kCVfdkZpw
        YyhY9QBw4+G39XZZ9wbxP/F/+17Mt0R/Sh5jc5yMuzVJ
X-Google-Smtp-Source: APXvYqzrSydT9kPhL0fBk9JVUeZL09XbeO2dliY/MqyRSLQJtWLGL/kGjDfz5exxikigzDAwFPNI8DVjsPStCJhu+go=
X-Received: by 2002:a25:50c9:: with SMTP id e192mr9535860ybb.208.1574419384804;
 Fri, 22 Nov 2019 02:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20191121211053.48861-1-rrangel@chromium.org> <20191121140830.4.Iddc7dd74f893297cb932e9825d413e7890633b3d@changeid>
 <CABXOdTeotUnO_7k9UycJ0vJEKV8pdZOjRrepDv5WVo5RmOLnEA@mail.gmail.com> <20191122080319.GC3296@dell>
In-Reply-To: <20191122080319.GC3296@dell>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 22 Nov 2019 02:42:53 -0800
Message-ID: <CABXOdTf7Oo-qPSnC040Tgxhn3mCogKo=WCsxo_Kj+C+f9DOCyw@mail.gmail.com>
Subject: Re: [PATCH 4/4] platform/chrome: i2c: i2c-cros-ec-tunnel: Convert i2c
 tunnel to MFD Cell
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Raul E Rangel <rrangel@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Wolfram Sang <wsa@the-dreams.de>, Akshu.Agrawal@amd.com,
        Guenter Roeck <groeck@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 12:03 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 21 Nov 2019, Guenter Roeck wrote:
>
> > On Thu, Nov 21, 2019 at 1:11 PM Raul E Rangel <rrangel@chromium.org> wr=
ote:
> > >
> > > If the i2c-cros-ec-tunnel driver is compiled into the kernel, it is
> > > possible that i2c-cros-ec-tunnel could be probed before cros_ec_XXX
> > > has finished initializing and setting the drvdata. This would cause a
> > > NULL pointer panic.
> > >
> > > Converting this driver over to an MFD solves the problem and aligns w=
ith
> > > where the cros_ec is going.
> > >
> >
> > I thought the mfd maintainer objects to the use of the mfd API outside
> > drivers/mfd. Did that change recently ?
>
> It hasn't changed, although I don't see that here?
>
Sorry, I was confused.

Guenter

> > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > > ---
> > > You can now see the device node lives under the mfd device.
> > >
> > > $ find /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunne=
l.12.auto/ -iname firmware_node -exec ls -l '{}' \;
> > > /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.au=
to/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/de=
vice:1c/PNP0C09:00/GOOG0004:00/GOOG0012:00
> > > /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.au=
to/i2c-9/firmware_node -> ../../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0=
A08:00/device:1c/PNP0C09:00/GOOG0004:00/GOOG0012:00
> > > /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.au=
to/i2c-9/i2c-10EC5682:00/firmware_node -> ../../../../../../../../LNXSYSTM:=
00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00/GOOG0012:00/10EC=
5682:00
> > >
> > >  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 36 +++++++++--------------=
--
> > >  drivers/mfd/cros_ec_dev.c               | 19 +++++++++++++
> > >  2 files changed, 32 insertions(+), 23 deletions(-)
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
