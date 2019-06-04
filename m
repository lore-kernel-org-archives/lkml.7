Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA25C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BC924A6F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guyP1Ic3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfFDHO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:14:26 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43748 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfFDHO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:14:26 -0400
Received: by mail-vs1-f68.google.com with SMTP id d128so12846371vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TnMW2xOiYTMGq6n1rvseC+0+GnmccYvlmBV45K6GnFE=;
        b=guyP1Ic33rzxwrhngOpfHAFw46fSxkXZTsOpnQcnQi8rL7kDEYs13LTpQAny7DL/GR
         DHtVUMI3kSzio17wFCwrwbi6b/NkkNnZzyMQ/E2RwDTK1yklEVRjfK10bIpFH5urkV3b
         ZO6TrmRkaqcq3tt9OTh7DgC86Y7d1obVoHr+EqmRjWv1FKRK1t67AmoJDKYLagENgb/r
         Ph0NrraeOE0tj/4iB0hs3LkArePb9xcYrpR0ricbgWgjA6gAQRy+qh++zo45pXxZAkCR
         mcTG3BoHmwK2QzQoOVhPFCCpOadqTzopWCKMDisUQvi51u/7+XMyZhwwvjCC0ZEbEl+9
         LIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TnMW2xOiYTMGq6n1rvseC+0+GnmccYvlmBV45K6GnFE=;
        b=j5p1WSy7joHveXgLa9G4lXGKsJsTo+lAz5mXZMADRJU3W25GvF89tf41EeXO82NFid
         k6Y1leDOBII26EXTBHBPifJQy469+eme1S85UIlruUFjjm3NirQht9951c7G+QRtEVNb
         KFXH/TFWXMC3K3eetzvJf7DJL2M0H+549uik8fljdbradESp5b79xUTLqnqikZyFTZ3i
         yeG/yCsuzosBgosnERXFM6d8dwJXILtB5VgWugTLx8RK3Ykf+/gOmAO76KqsN4C9KA7A
         BvdAK9NypYBMroTJJ/5ljplAm5Y2TJuXTKXGbS5RamS6vfK8A4xWJX1GNRPoNocuTVuC
         18sw==
X-Gm-Message-State: APjAAAXD708MhnmoiwPP/9H3OlUfB/3o21KslLwUq9XhShzS/Tx/94uD
        aSHMLinANuFVItrq1VqvfpHfXE1FypdLte7C9AnqIg==
X-Google-Smtp-Source: APXvYqzEmHz0ELqyBrB8KiqIDFXLaBDsyB3HX8ZlxIChRrzbOz09ochCdoanorD9Bt/q0a4QnR+rkxHL0yo/JxSfNe8=
X-Received: by 2002:a67:f485:: with SMTP id o5mr15183717vsn.165.1559632465380;
 Tue, 04 Jun 2019 00:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558346019.git.baolin.wang@linaro.org> <CAMz4ku+E=kFgWrvm_wzM2XQQUyYZhc5uokcGEAEbEKpNAYZQ7g@mail.gmail.com>
In-Reply-To: <CAMz4ku+E=kFgWrvm_wzM2XQQUyYZhc5uokcGEAEbEKpNAYZQ7g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Jun 2019 09:13:48 +0200
Message-ID: <CAPDyKFoZmxmRYwL_m60=DK9J5+beshEsLw5D=FySzRfYFdsb3Q@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add SD host controller support for SC9860 platform
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2019 at 10:42, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Hi Adrian & Ulf,
>
> On Mon, 20 May 2019 at 18:12, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > This patch set adds optional clock support, HS400 enhanced strobe mode support,
> > PHY DLL configuration and other optimization to make the SD host controller
> > can work well on the Spreadtrum SC9860 platform.
>
> Do you have any comments for this patch set? Thanks.
>

Seems like the series is almost ready to go. However, due to a few the
minor comments/questions from Adrian, I am expecting a new version
from you before applying.

Kind regards
Uffe

> >
> > Baolin Wang (9):
> >   mmc: sdhci-sprd: Check the enable clock's return value correctly
> >   dt-bindings: mmc: sprd: Add another optional clock documentation
> >   mmc: sdhci-sprd: Add optional gate clock support
> >   mmc: sdhci-sprd: Implement the get_max_timeout_count() interface
> >   mmc: sdhci-sprd: Add HS400 enhanced strobe mode
> >   mmc: sdhci-sprd: Enable PHY DLL to make clock stable
> >   dt-bindings: mmc: sprd: Add PHY DLL delay documentation
> >   mmc: sdhci-sprd: Add PHY DLL delay configuration
> >   arm64: dts: sprd: Add Spreadtrum SD host controller support
> >
> >  .../devicetree/bindings/mmc/sdhci-sprd.txt         |   19 +++
> >  arch/arm64/boot/dts/sprd/whale2.dtsi               |   35 ++++
> >  drivers/mmc/host/sdhci-sprd.c                      |  171 +++++++++++++++++++-
> >  3 files changed, 217 insertions(+), 8 deletions(-)
> >
> > --
> > 1.7.9.5
> >
>
>
> --
> Baolin Wang
> Best Regards
