Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A620C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E3520828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yMfP04Gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfCZHxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:53:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35374 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfCZHxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:53:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so11737415wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+P/pDctBzgqNCJzJAj22Bp6Ulq3f13aqe+jh+b1hejk=;
        b=yMfP04GbVCy1OCXi8Zh/Js4WKcX3FrUxZsa3NAiI7gwT7049iS6cPNwX+FGCuvPp7g
         rxJCzPMmuJZXf7IRPUfdm3acMrIcEFZ5OUjOUcwVi8Wh/XsSevMXoLWew3UA/pPeXWYg
         0ENNnYZJ+crDmYQunPgI2U6KbiB9o7r0KJGBKPUgp5m4VYO3GbrdlBIjgebVbWtx5BeW
         /2j0KqaiktKTH1sW4oET6+rA1OynfpaPPGnhZX5YPKZ/38lLlcS+Ssm9HEsGc2s/L0Of
         pyXsEPI+loD+cDcmq/8mNWBmFWDaDH1bJtJHNmQD864pzbeC+9ODIqTEWTlJQ3p1zJuv
         DS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+P/pDctBzgqNCJzJAj22Bp6Ulq3f13aqe+jh+b1hejk=;
        b=Qm5ea3694XMfHIr7BLoASspnN0XfFW+/t5HxL+xq7zLCbSMCjfNHQvjGO3xorDF9pP
         gDMT361RgkjAUUnpx1kZZszETuyEBIQne1Vild21f3YTZtK4AXOoTtDWEkXIcDlLxpn6
         4oDo8LW2lKNymL0L8+xIeD68EEx80Zi0cubZiUdgmkSImDLK3PrMMbOC7cx2EU1uIPun
         xugvpsq2TE31nbHDJk8V3wZ7K6OIhTDqcfuAh1zWaPXSmLOvl7Ncdh0yYGwim73GvxAM
         gqwxwouRVupajoebGVgT7plvg0Jfak4phD4kUcvHekFP3ywyLvd5jZSig5nhv6Eb/Tik
         penA==
X-Gm-Message-State: APjAAAWI9+ia99f8kOQDlBTheeLDZjuT7aTC6MVlqPt3QcF8a3t1gRGG
        2ojXyJjNZaIWe4PhkZ3F/hUeHw==
X-Google-Smtp-Source: APXvYqyUOqJoh6ug291ipn/WEnZewgLcDELTWekaeWiEDLB0t9vPsF9eDBRiqM7vm7QU70dAASQyBQ==
X-Received: by 2002:a1c:67c2:: with SMTP id b185mr14139004wmc.68.1553586798375;
        Tue, 26 Mar 2019 00:53:18 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id j11sm22170116wrw.85.2019.03.26.00.53.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 00:53:17 -0700 (PDT)
Message-ID: <8b6f0bc6210834af2aff2de7dc95692dd87db539.camel@baylibre.com>
Subject: Re: [PATCH 1/4] clk: meson: mpll: add init callback and regs
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Mar 2019 08:53:15 +0100
In-Reply-To: <155353381842.20095.17915880223118004926@swboyd.mtv.corp.google.com>
References: <20190325111200.15940-1-jbrunet@baylibre.com>
         <20190325111200.15940-2-jbrunet@baylibre.com>
         <155353381842.20095.17915880223118004926@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 10:10 -0700, Stephen Boyd wrote:
> Quoting Jerome Brunet (2019-03-25 04:11:57)
> > @@ -138,6 +129,27 @@ static int mpll_set_rate(struct clk_hw *hw,
> >         return 0;
> >  }
> >  
> > +static void mpll_init(struct clk_hw *hw)
> > +{
> > +       struct clk_regmap *clk = to_clk_regmap(hw);
> > +       struct meson_clk_mpll_data *mpll = meson_clk_mpll_data(clk);
> > +
> > +       if (mpll->init_count)
> > +               regmap_multi_reg_write(clk->map, mpll->init_regs,
> > +                                      mpll->init_count);
> > +
> > +       /* Enable the fractional part */
> > +       meson_parm_write(clk->map, &mpll->sdm_en, 1);
> > +
> > +       /* Set additional fractional part enable if required */
> > +       if (MESON_PARM_APPLICABLE(&mpll->ssen))
> > +               meson_parm_write(clk->map, &mpll->ssen, 1);
> > +
> > +       /* Set the magic misc bit if required */
> > +       if (MESON_PARM_APPLICABLE(&mpll->misc))
> > +               meson_parm_write(clk->map, &mpll->misc, 1);
> > +}
> > +
> >  const struct clk_ops meson_clk_mpll_ro_ops = {
> >         .recalc_rate    = mpll_recalc_rate,
> >         .round_rate     = mpll_round_rate,
> > @@ -148,6 +160,7 @@ const struct clk_ops meson_clk_mpll_ops = {
> >         .recalc_rate    = mpll_recalc_rate,
> >         .round_rate     = mpll_round_rate,
> >         .set_rate       = mpll_set_rate,
> > +       .init           = mpll_init,
> 
> We actively discourage using init callbacks. Can you do this some other
> way?

Yes I'm aware of that but init it the right place to do this.
To be clear, this is not initializing the clock to some particular rate, the
rate is preserved.

It just applies the necessary settings that needs to be done only once to make
sure the clock is in working order and that the rate calculated is actually
accurate. 

> 
> >  };
> >  EXPORT_SYMBOL_GPL(meson_clk_mpll_ops);
> >  


