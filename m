Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E1CC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A12F233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NeaPl8zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfH2N1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:27:41 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43408 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2N1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:27:40 -0400
Received: by mail-vs1-f65.google.com with SMTP id l63so2372357vsl.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 06:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHPJ2CX8ytGZ59Fh54fNpJL5kK4m1cHIPf+TD22z6+o=;
        b=NeaPl8ztoK8Qgdcm1+9gPoJDy8U3vejd9FkPsydEcY67n3MnWOq+NaObq3ozxUJ5Rk
         DwuiKOIEv1nIHZsB/vk+DkE2/fghIqX3BE2c3KQzYmprvcAaDqLw3Nh+8cwLxYuBrewg
         ylebGR/9Rc/fZ5+HwC9njjO3tJ4KcfsEjQoagoqlXBHQMoD+N2o7klC3HPzUcNiWlpX1
         fm7KsQ/qoQsxBoNSjtRp5kI8h28S4gwjEIZFP5THgEgyanEG0EDd02a9Fx8l7b+ty0I5
         ZtvPoOLmPPKTI3+szjIA8ewjhbuGKx8ae5OyYEAVu3xoguAAqQhIIugSUjLkZuxcFxWy
         NGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHPJ2CX8ytGZ59Fh54fNpJL5kK4m1cHIPf+TD22z6+o=;
        b=HYSA5kMuYQ+3JKNgOirdb5gODBXe1UlQZ+u/shpswpjB1+9vwwvYaHw9/Ma6ztA3RZ
         t9wEd6xJJZW6xx7QdeihQqE6E7XEkMDmNMyI3zxvclgmzjng2GB7+QZcy90o7+Ikefui
         PrUZwMMWXLUctj28LjFcEj58Od5oW/TyB/M+/rDCNBODaz0Io3UHH6+4xxNptUXtyp52
         rizjE/m/Mi93SPBPl8DuR9GIGbrzaqbjdJcB4hsl8ir/TNG2S2/elhTtFSCkifu01icC
         IVfFuKsAX0amt/8YVuzmyF8VqR40zVxIQNjV4pVf2Swc9ZS7+64rGnltJyxso0nyufqE
         5uKQ==
X-Gm-Message-State: APjAAAWb0idbiw9UVlWg/3vgr2PbS+sVBHEEzaeIFMGedk5ryCmsKG1R
        Vq5pFF6PUTvkiw2bEXvPg3fIjwHMwnUvs1hyZgYXdg==
X-Google-Smtp-Source: APXvYqxmdPqLidkuXh1dij1W2bRIM9XWVMRet2NViucbtCc8v+TuYKNJF1B7rF32WXPVTp8r+I+BJd7U8e9e1K/UlRw=
X-Received: by 2002:a67:e287:: with SMTP id g7mr5409930vsf.200.1567085259869;
 Thu, 29 Aug 2019 06:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190829104928.27404-1-yamada.masahiro@socionext.com>
 <CAPDyKFooFQgBgK3N1Ob9rsT_7-5kqC9i7PeMxkkeAbnDP+Fwnw@mail.gmail.com> <CAK7LNASDfJQrMq4jjwDjrQF-4E9A_BZtgh+K-duTAo8zRVZA0g@mail.gmail.com>
In-Reply-To: <CAK7LNASDfJQrMq4jjwDjrQF-4E9A_BZtgh+K-duTAo8zRVZA0g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Aug 2019 15:27:03 +0200
Message-ID: <CAPDyKFpnRbtVpYkpM7CDYfxvdBjqybB4SVWyuSrS1jpYduTbCw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-cadence: enable v4_mode to fix ADMA 64-bit addressing
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Piotr Sroka <piotrs@cadence.com>,
        "# 4.0+" <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 at 14:05, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Thu, Aug 29, 2019 at 8:48 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 29 Aug 2019 at 12:49, Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > The IP datasheet says this controller is compatible with SD Host
> > > Specification Version v4.00.
> > >
> > > As it turned out, the ADMA of this IP does not work with 64-bit mode
> > > when it is in the Version 3.00 compatible mode; it understands the
> > > old 64-bit descriptor table (as defined in SDHCI v2), but the ADMA
> > > System Address Register (SDHCI_ADMA_ADDRESS) cannot point to the
> > > 64-bit address.
> > >
> > > I noticed this issue only after commit bd2e75633c80 ("dma-contiguous:
> > > use fallback alloc_pages for single pages"). Prior to that commit,
> > > dma_set_mask_and_coherent() returned the dma address that fits in
> > > 32-bit range, at least for the default arm64 configuration
> > > (arch/arm64/configs/defconfig). Now the host->adma_addr exceeds the
> > > 32-bit limit, causing the real problem for the Socionext SoCs.
> > > (As a side-note, I was also able to reproduce the issue for older
> > > kernels by turning off CONFIG_DMA_CMA.)
> > >
> > > Call sdhci_enable_v4_mode() to fix this.
> > >
> > > I think it is better to back-port this, but only possible for v4.20+.
> > >
> > > When this driver was merged (v4.10), the v4 mode support did not exist.
> > > It was added by commit b3f80b434f72 ("mmc: sdhci: Add sd host v4 mode")
> > > i.e. v4.20.
> > >
> > > Cc: <stable@vger.kernel.org> # v4.20+
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > Applied for fixes, by adding below tag, thanks!
> >
> > Fixes: b3f80b434f72 ("mmc: sdhci: Add sd host v4 mode")
>
> This is not a bug commit.

Right, but it can't be applied before this commit, hence why I added
it. Not sure that it matters, but I can remove the tag if you
insists!?

Kind regards
Uffe
