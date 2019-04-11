Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9B1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E5620652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hb4srh7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDKKtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:49:04 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:37456 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKKtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:49:04 -0400
Received: by mail-vs1-f65.google.com with SMTP id w13so3200588vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 03:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdJb3J+3464vEBIz8aXygUOjNioqmlD/HqfKBPBaO0Q=;
        b=Hb4srh7aUD4mQ+uFrVytIlQ8NwYi87UX8yj7fezJ7tfMhDarp61FUlLyT27qjCQb7d
         6nFoC/YRHCqwDsdtoYxC/ctfHfQJKQubbu6fhZUhJF7JB9VpSm9xaufYSgiciXSoTFtK
         xOchP4BdWBAbXzUEYaC98615VyEk8FvivHVCVbXY6oSelvjcnsbtBvOzyMX47YlR1WZu
         iJPmQew7i7nfRBq32oGHG6w676DXtH2btvKjzFXOFzGXaehgGMnvDq7Gs7yr/Q9xv9wl
         ShLtRrzLnnkX48c37qFMhrh+Aq+uaww+V5Yp8bDRIciz+8RI1V+Q85pfzPJwiuraSGAA
         p5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdJb3J+3464vEBIz8aXygUOjNioqmlD/HqfKBPBaO0Q=;
        b=Zu282KYXoNL45yZBlGW5T1Y3xwWmVYedMDH9NDvcqUcZYY8N/j/zE69R8FLal36iBB
         LXmU0I1PT3QDWawybU0kuqdRV8lW4W7u7wKls1Dn9q/0ptcOzesSRzxC3yitKnT6Biyn
         17El+X4pnwe8n0c5fd2kq2e854DxAot7NIfzCtknjweb8NlC/gUSJFLazzz4zwUHgxEk
         uLtxCiJd0iQmJsCTKYD+VOX+6G+U5EIVKgekKPVK7rvnbn0wyRcwd3h1gNXuvzegFbKq
         rNDnpiLlklBBLWVBCvrXy9okS2fjVvP1p6k8Y/OcWXirz9qM1Xk1HPSSYPePKtNbliTy
         Y+8g==
X-Gm-Message-State: APjAAAWjrKCgIc7EVV1tbHt54xSZ3bIivdlsLCZMvmeKOuPyB+F57Ht5
        1zmJcNtB//LypjeSXOlUX0RvjQdVXXVv3wY4U6oRFg==
X-Google-Smtp-Source: APXvYqx+GdyQQiADyCYiQTk1PinB8u0+Rt0oLYblmhqVhAmnTlm1l5kGJGqcWgrOJyriX+jEpmHPxEwi/4CXbYitm68=
X-Received: by 2002:a67:7c8a:: with SMTP id x132mr26955363vsc.172.1554979742797;
 Thu, 11 Apr 2019 03:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190325122442.30644-1-ulf.hansson@linaro.org>
 <CAPDyKFqNih3kEuRM9HHkmcVOzaT2RZLRjb=0ifq6hGB+OCxUug@mail.gmail.com> <1554979352.18628.0.camel@mhfsdcap03>
In-Reply-To: <1554979352.18628.0.camel@mhfsdcap03>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Apr 2019 12:48:26 +0200
Message-ID: <CAPDyKFoZS+CL7zXGkNmVfbLo48+oi-pA9jEXGMTEi=qN0d+Z9Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add section for MediaTek MMC/SD/SDIO driver
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 at 12:42, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> On Thu, 2019-04-11 at 11:49 +0200, Ulf Hansson wrote:
> > Chaotian,
> >
> > On Mon, 25 Mar 2019 at 13:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Cc: Chaotian Jing <chaotian.jing@mediatek.com>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  MAINTAINERS | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 3e5a5d263f29..b43e563b4c95 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9775,6 +9775,12 @@ F:       drivers/media/platform/mtk-vpu/
> > >  F:     Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > >  F:     Documentation/devicetree/bindings/media/mediatek-vpu.txt
> > >
> > > +MEDIATEK MMC/SD/SDIO DRIVER
> > > +M:     Chaotian Jing <chaotian.jing@mediatek.com>
> > > +S:     Maintained
> > > +F:     drivers/mmc/host/mtk-sd.c
> > > +F:     Documentation/devicetree/bindings/mmc/mtk-sd.txt
> > > +
> >
> > Are you fine with this, or do you have any other guys at your side
> > that can help with reviewing patches for the mtk-sd driver?
> >
> Yes, It's fine for me.
> Thx!

Great! I consider that as ack and have applied the patch.

Thanks and kind regards
Uffe
