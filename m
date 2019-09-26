Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DC8C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2155422466
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 18:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UgV7Uh+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfIZSel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 14:34:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42122 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZSel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 14:34:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id i185so2969930oif.9;
        Thu, 26 Sep 2019 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGmse8tCqZQZ4pc5Rd9nycCZrtTO2C0KKH3W2gH74ZQ=;
        b=UgV7Uh+BjMLCWW04clvdJpCdRfDq+LPqUWtOYblF8YWz4YKYeXATM5GBrymb/Sk+uQ
         S81PNoDJWIh2MnYlFgrJJyqp4nJIPSEnWcQcU9diyD7BzDBQk15Xq03a2s9hdNP2x0Gv
         LycDh6FqujeKrx/3oAaZ1qrF9pDZklAuacpqB1EbUABmeQEyCF3XqGsYD7ya6ukjJAek
         DEZHtXpSpDRBRERpBikNPBMDwlpHgQgE9z6uGXS/Ge9WNOrjEdT4a86+wC0dfksXnAB5
         6wACcrdJIdl5YFIKME8vJ7Blt1qGTY/vzSMBgtbkwKLvPS3zxgplPCWYOS0jKRSfbq/p
         diGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGmse8tCqZQZ4pc5Rd9nycCZrtTO2C0KKH3W2gH74ZQ=;
        b=bqsppv18mbOx6v6HCdH5jZMSKonigt/iB2p+lvyZ7edfUAM9fEEAXcL41SIvcHrcQy
         ZOewdHbPXOehHO1MPWsT3AkQx6CQ7n+Ir3wIwOAgmU2Df218FbuT+hiqj10tbgm9lvVM
         WfkHuSgIEGVfTuZOSe+V5LAMeD9hi0HMavbKvGcLt0WBppBqgM7dslv0rmjSjJk0gcvn
         oDlTNMAJk0oJZo4f2kLThxjmnCWDmd9z/Ya5t+0RLVv16vyLXQthARAjn1mDtQVUR+Qs
         ZpjYdCP6oeW3qDTNX/XDzY1BsmA4IJDKHdXAJ/dZ/6OzVnAmSFjLVnXQDKENQm9nP8wT
         dTsQ==
X-Gm-Message-State: APjAAAXEOkGvc1fKag8Ksp0J8v4GZJ2p1nVHOA5Low2rgZuPzdplfNza
        7FAk/5j5savrn3MS6GFuzc4RBuFWcwfLZcU9Wgnt2g==
X-Google-Smtp-Source: APXvYqxuPwoB6TKSeyJqIwODjZis0k+ZmHBg9WFAB8/8pKYdueaEYWwk2+HM7MX9vjrMpv/LByMTiav/h+fuf+x5A5g=
X-Received: by 2002:aca:4d08:: with SMTP id a8mr3946038oib.39.1569522879867;
 Thu, 26 Sep 2019 11:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190921151223.768842-1-martin.blumenstingl@googlemail.com>
 <1jzhivs6n6.fsf@starbuckisacylon.baylibre.com> <CAFBinCA0NaCJEDfNEg+LRfW3wxfNFGbXmGS+z7D5792TsupVAA@mail.gmail.com>
 <7h7e5wt2m1.fsf@baylibre.com>
In-Reply-To: <7h7e5wt2m1.fsf@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 26 Sep 2019 20:34:28 +0200
Message-ID: <CAFBinCAv=_3vWSanQg1S5EXBVzdgTu2Ub3Hyad_ajF3v6PcbGQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] provide the XTAL clock via OF on Meson8/8b/8m2
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Thu, Sep 26, 2019 at 12:47 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
> > Hi Jerome,
> >
> > On Mon, Sep 23, 2019 at 11:29 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> >>
> >> On Sat 21 Sep 2019 at 17:12, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
> >>
> >> > So far the HHI clock controller has been providing the XTAL clock on
> >> > Amlogic Meson8/Meson8b/Meson8m2 SoCs.
> >> > This is not correct because the XTAL is actually a crystal on the
> >> > boards and the SoC has a dedicated input for it.
> >> >
> >> > This updates the dt-bindings of the HHI clock controller and defines
> >> > a fixed-clock in meson.dtsi (along with switching everything over to
> >> > use this clock).
> >> > The clock driver needs three updates to use this:
> >> > - patch #2 uses clk_hw_set_parent in the CPU clock notifier. This drops
> >> >   the explicit reference to CLKID_XTAL while at the same time making
> >> >   the code much easier (thanks to Neil for providing this new method
> >> >   as part of the G12A CPU clock bringup!)
> >> > - patch #3 ensures that the clock driver doesn't rely on it's internal
> >> >   XTAL clock while not losing support for older .dtbs that don't have
> >> >   the XTAL clock input yet
> >> > - with patch #4 the clock controller's own XTAL clock is not registered
> >> >   anymore when a clock input is provided via OF
> >> >
> >> > This series is a functional no-op. It's main goal is to better represent
> >> > how the actual hardware looks like.
> >>
> >> I'm a bit unsure about this series.
> >>
> >> On one hand, I totally agree with you ... having the xtal in DT is the
> >> right way to do it ... when done from the start
> > yep
> >
> >> On the other hand, things have been this way for years, they are working
> >> and going for xtal in DT does not solve any pending issue. Doing this
> >> means adding complexity in the driver to support both methods. It is
> >> also quite a significant change in DT :/
> > my two main motivations were:
> > - keeping the 32-bit SoCs as similar as possible to the 64-bit ones in
> > terms of "how are the [clock] drivers implemented"
> > - with the DDR clock controller the .dts looked weird: &ddr_clkc took
> > CLKID_XTAL from &clkc as input and &clkc took DDR_CLKID_DDR_PLL as
> > input from &ddr_clkc
> >
> > RE complexity in the driver to support both:
> > I still have a cleanup of the meson8b.c init code on my TODO-list
> > because we're still supporting .dtbs without parent syscon
> > my plan is to drop that code-path along with the newly added fallback
> > for "skip CLKID_XTAL" (assuming this is accepted) together for v5.6 or
> > v5.7
>
> TBH, I'm big(ish) "functional no-op" changes like this are not things I
> get super exicted about, especially for SoCs that have been working well
> for awhile, and are do not have a large (upstream) userbase.
>
> OTOH, since Martin is doing most of the heavy lifting for keeping this
> platform working upstream, I'm happy to take the changes, as long as
> Martin is willing to deal with any fallout.
I agree: it has to work and if it doesn't then I will have to fix it so it is
so I will be taking care of any fallout


Martin
