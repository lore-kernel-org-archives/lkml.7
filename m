Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0C5C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6D3214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfIRFqu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 01:46:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37085 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfIRFqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 01:46:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4so5453915edy.4;
        Tue, 17 Sep 2019 22:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HottKLgy34W05WWcCdN3jQ7YYM/nB6BpbT/v5aKaaH4=;
        b=iqXe8vyKpdq/K6l4bduorlnnl3lAbacgOmYwi0/FITMXCaYsdU1Hn8n+LQ4eLIyBUr
         E/AuYqp8w83OrWueqzPGk9XUQS9Prii1VCOKfiQTxKCImcJBwGXUWHA7pKUqKsGMuqfp
         GZeFQH9yOYj6AzMNfuk+EG0SJQZwa/4EQAyDwmwyFEsUDIHEvPeaIAhOD10FBxlzmPW1
         VUNVnIrmFGpvMPxpBm9W4lGjJN6YnyFw6OUDLIcuvXhiXU5pXyYoEkclOIMmDUaASzPn
         rzadJU6SRPIdIIrTtbwvHHvAlgAJvhYgkHxMSTSRaBt8k1+CuwbHb62SpW3ddknJ6uGr
         M+Kw==
X-Gm-Message-State: APjAAAVNwCjZOo0nMc/xvco4sHDHjorKfJQFUoCuhW9k5VontCUzeJeM
        JUS+JwnCxjMkWJRIVyg4cLOuo/U4bgg=
X-Google-Smtp-Source: APXvYqzi6m0TTbopCICUoaT3JbGqrn6VFJ51I7dqjiSAXVkhMFTHaGBs7wjlrjOH4Z10wrdCYEWZ1Q==
X-Received: by 2002:a50:aa96:: with SMTP id q22mr8402411edc.179.1568785607571;
        Tue, 17 Sep 2019 22:46:47 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id p4sm833758edc.38.2019.09.17.22.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 22:46:47 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id p7so938141wmp.4;
        Tue, 17 Sep 2019 22:46:46 -0700 (PDT)
X-Received: by 2002:a1c:a54a:: with SMTP id o71mr1236081wme.51.1568785606724;
 Tue, 17 Sep 2019 22:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190914135100.327412-1-jernej.skrabec@siol.net>
 <CAGb2v640R7edA3EJvC=aJQZXGcfqot50O3-PFyrYj767pUEYrQ@mail.gmail.com> <8129141.yvSaxnLE4m@jernej-laptop>
In-Reply-To: <8129141.yvSaxnLE4m@jernej-laptop>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 18 Sep 2019 13:46:34 +0800
X-Gmail-Original-Message-ID: <CAGb2v65KQf_OX1sX9+4DAKKMKHP464cCZKjCRsn3LzTKRGLTcQ@mail.gmail.com>
Message-ID: <CAGb2v65KQf_OX1sX9+4DAKKMKHP464cCZKjCRsn3LzTKRGLTcQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] clk: sunxi-ng: h6: Use sigma-delta
 modulation for audio PLL
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 1:21 PM Jernej Škrabec <jernej.skrabec@siol.net> wrote:
>
> Dne torek, 17. september 2019 ob 08:54:08 CEST je Chen-Yu Tsai napisal(a):
> > On Sat, Sep 14, 2019 at 9:51 PM Jernej Skrabec <jernej.skrabec@siol.net>
> wrote:
> > > Audio devices needs exact clock rates in order to correctly reproduce
> > > the sound. Until now, only integer factors were used to configure H6
> > > audio PLL which resulted in inexact rates. Fix that by adding support
> > > for fractional factors using sigma-delta modulation look-up table. It
> > > contains values for two most commonly used audio base frequencies.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > >
> > >  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 21 +++++++++++++++------
> > >  1 file changed, 15 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c index d89353a3cdec..ed6338d74474
> > > 100644
> > > --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> > > @@ -203,12 +203,21 @@ static struct ccu_nkmp pll_hsic_clk = {
> > >
> > >   * hardcode it to match with the clock names.
> > >   */
> > >
> > >  #define SUN50I_H6_PLL_AUDIO_REG                0x078
> > >
> > > +
> > > +static struct ccu_sdm_setting pll_audio_sdm_table[] = {
> > > +       { .rate = 541900800, .pattern = 0xc001288d, .m = 1, .n = 22 },
> > > +       { .rate = 589824000, .pattern = 0xc00126e9, .m = 1, .n = 24 },
> > > +};
> > > +
> > >
> > >  static struct ccu_nm pll_audio_base_clk = {
> > >
> > >         .enable         = BIT(31),
> > >         .lock           = BIT(28),
> > >         .n              = _SUNXI_CCU_MULT_MIN(8, 8, 12),
> > >         .m              = _SUNXI_CCU_DIV(1, 1), /* input divider */
> > >
> > > +       .sdm            = _SUNXI_CCU_SDM(pll_audio_sdm_table,
> > > +                                        BIT(24), 0x178, BIT(31)),
> > >
> > >         .common         = {
> > >
> > > +               .features       = CCU_FEATURE_SIGMA_DELTA_MOD,
> > >
> > >                 .reg            = 0x078,
> > >                 .hw.init        = CLK_HW_INIT("pll-audio-base", "osc24M",
> > >
> > >                                               &ccu_nm_ops,
> > >
> > > @@ -753,12 +762,12 @@ static const struct clk_hw *clk_parent_pll_audio[] =
> > > {>
> > >  };
> > >
> > >  /*
> > >
> > > - * The divider of pll-audio is fixed to 8 now, as pll-audio-4x has a
> > > - * fixed post-divider 2.
> > > + * The divider of pll-audio is fixed to 24 for now, so 24576000 and
> > > 22579200 + * rates can be set exactly in conjunction with sigma-delta
> > > modulation.>
> > >   */
> > >
> > >  static CLK_FIXED_FACTOR_HWS(pll_audio_clk, "pll-audio",
> > >
> > >                             clk_parent_pll_audio,
> > >
> > > -                           8, 1, CLK_SET_RATE_PARENT);
> > > +                           24, 1, CLK_SET_RATE_PARENT);
> > >
> > >  static CLK_FIXED_FACTOR_HWS(pll_audio_2x_clk, "pll-audio-2x",
> > >
> > >                             clk_parent_pll_audio,
> > >                             4, 1, CLK_SET_RATE_PARENT);
> >
> > You need to fix the factors for the other two outputs as well, since all
> > three are derived from pll-audio-base.
>
> Fix how? pll-audio-2x and pll-audio-4x clocks have fixed divider in regards to
> pll-audio-base, while pll-audio has not. Unless you mean changing their name?

Argh... I got it wrong. It looks good actually.

Acked-by: Chen-Yu Tsai <wens@csie.org>
