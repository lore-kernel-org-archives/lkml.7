Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F30C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD7C2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="m6EHyBNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfDAIkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:40:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39997 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfDAIkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:40:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so10359606wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 01:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SP6dtRR4XnBdiX6pYVY4GbOIbGYL0lpRYejuQl03xJ8=;
        b=m6EHyBNnSSUkYUtR23/XjZmIic9axelIbgMEk7IPl1hIbkV9FQZ/yRv+ujdwe64VXV
         NWvSW+OkMcwo+RgYHZkX6fdW9Dwq+P9opHQPelu/0G1OSXQYow+9Iss4nE9YdjSQh/Hj
         dGgPbqUOVarFCKsC8as7jsb10XVg79B4AN+r+Hc35/pzX/7aIS7RKL2PasM2YWotg0Ag
         m2kV5xsWsJ/v1Pjxk57uFur8CQAqK+EsZJNM5zYg6Hp9l80wCol+FclIM0YepAK0S/Ua
         aeEkLxmNTUTZ7seOujwOjmQQxWO1W2xhlJ0h7HdrZzHWHMT8iu6uiLbtiOXyENy7pn+A
         YJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SP6dtRR4XnBdiX6pYVY4GbOIbGYL0lpRYejuQl03xJ8=;
        b=rkwn8ajEixGS6XWphikid+zzzAga8feJU0i0SATSmvN2bc2g+sGj90d7b6Gd4sb4nk
         kBB/wMYQ61nDr5DTamggZRvDDh6Y937JDz0iLGbH+kXVL1bihOicYye5dR2Ezcl9dz0u
         g4yWWW0dCN2fM0prFqT0Rdq5nPUromxlY7ykJ7R5rQiRYAOtuvYdgZLmXgnFMhrQI5CS
         9ex/aalErALKE8jw6lza7caxuF3vrPZJfExP58Qa77OOaMFkxMq094KorR/Qy4GPyi1j
         2+qT3WX2iruxqnlMl8I3XBZj0RnN3xjGZu/UUlDXbWfq80Ex590wZkoyaqDdE44/ThvN
         DJ+w==
X-Gm-Message-State: APjAAAVoCVY645PnzoIQgUjwmOx1pLv1T8jDgpr7gpGw7X0Pgc4yCatC
        mrKXrljBijHM/HN+B2ujG4gsNg==
X-Google-Smtp-Source: APXvYqzftgbkDH5aDIC8sGZWKMCqOeiwTPMCcCUD4KUuV+cSOmuE4MG/C9OqHLfULsPow1H1Ple08w==
X-Received: by 2002:a7b:c769:: with SMTP id x9mr11364300wmk.103.1554108023014;
        Mon, 01 Apr 2019 01:40:23 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id q17sm7746726wrw.70.2019.04.01.01.40.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Apr 2019 01:40:22 -0700 (PDT)
Message-ID: <63fc525faf2d82cb2436a17ab2206293aeef6c31.camel@baylibre.com>
Subject: Re: [PATCH 1/3] clk: meson: mpll: properly handle spread spectrum
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 01 Apr 2019 10:40:20 +0200
In-Reply-To: <CAFBinCCUrKGPWpTu_u3okaHVfMY4CN5F5qaRcKdTRbg35xrMEQ@mail.gmail.com>
References: <20190329153325.23869-1-jbrunet@baylibre.com>
         <20190329153325.23869-2-jbrunet@baylibre.com>
         <CAFBinCDnoY41ZcoHqsngR4WTeczkmOu93R=2G_JOXbdUmHSjMw@mail.gmail.com>
         <3bef1bb26e9eff0cfc20cd4bb78a5d7cea4c5076.camel@baylibre.com>
         <CAFBinCCUrKGPWpTu_u3okaHVfMY4CN5F5qaRcKdTRbg35xrMEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-30 at 16:56 +0100, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Sat, Mar 30, 2019 at 12:07 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > On Fri, 2019-03-29 at 20:39 +0100, Martin Blumenstingl wrote:
> > > Hi Jerome,
> > > 
> > > On Fri, Mar 29, 2019 at 4:34 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > > > The bit 'SSEN' available on some MPLL DSS outputs is not related to the
> > > > fractional part of the divider but to the function called
> > > > 'Spread Spectrum'.
> > > > 
> > > > This function might be used to solve EM issues by adding a jitter on
> > > > clock signal. This widens the signal spectrum and weakens the peaks in it.
> > > > 
> > > > While spread spectrum might be useful for some application, it is
> > > > problematic for others, such as audio.
> > > > 
> > > > This patch introduce a new flag to the MPLL driver to enable (or not) the
> > > > spread spectrum function.
> > > > 
> > > > Fixes: 1f737ffa13ef ("clk: meson: mpll: fix mpll0 fractional part ignored")
> > > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > > > ---
> > > >  drivers/clk/meson/clk-mpll.c | 9 ++++++---
> > > >  drivers/clk/meson/clk-mpll.h | 1 +
> > > >  2 files changed, 7 insertions(+), 3 deletions(-)
> > > > 

[...]

> > 
> > Yes, none of our application require spread spectrum
> thank you for the explanation. can you please add it to the patch description?

I think I described spread spectrum already in the commit description.

> 
> > The fact is that only 2 MPLL had this bit, mpll0 on gx (without effect) and
> > mpll0 on axg: actually spread spectrum impacts mpll2, making it unusable, as
> > explained in the related patch
> > 
> > > based on the original commit 1f737ffa13ef ("clk: meson: mpll: fix
> > > mpll0 fractional part ignored") it seems that
> > > CLK_MESON_MPLL_SPREAD_SPECTRUM should be set for mpll0 (at least on
> > > GXBB and Meson8b)
> > > 
> > 
> > There a patch specifically targeting gxbb.
> I missed that, sorry for the noise
> 
> > I have checked on GXL and this bit had no effect (fractional part still on, no
> > spread spectrum)
> > 
> > So either we fixed something since then or I messed up when doing the patch
> > initially.
> > 
> > Feel free to cross check
> I tried it on Meson8b and it seems that there's no difference. I've
> done a bit of software archaeology:
> $ grep -R mpll_cntl uboot-2015-01-15-23a3562521/ | grep "=" | head -n3
> uboot-2015-01-15-23a3562521/board/amlogic/m8_k100_1G/firmware/timming.c:
>        .mpll_cntl = 0x600009A9,        //2.5G, fixed
> uboot-2015-01-15-23a3562521/board/amlogic/m8_k100_2G/firmware/timming.c:
>        .mpll_cntl = 0x600009A9,        //2.5G, fixed
> uboot-2015-01-15-23a3562521/board/amlogic/m8b_ft_v1/firmware/timming.c:
> .mpll_cntl = 0x600009A9,        //2.5G, fixed
> 
> Ethernet is still working on my Odroid-C1, so you can add my:
> Tested-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>
> 
> 
> Regards
> Martin


