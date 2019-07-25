Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8DBC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CCE22C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564074576;
	bh=rkdM8CWr1A1LMWe/EH04Dnfcj0n7tqCfgrgm7BTi5jQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wMewECVe+88ZSaHzZ1qqhshZ7ckdT3e90kRtdsHcIIC8me2Zs4e1V7Fw0wZ/AnnEc
	 kjCQ25UAft74FFWlKlOf6ClgMOtg14IhtjW4hVXWuqWB5TwwAX3VTZLYPZXAdLKyzJ
	 kNHvalCJ2AzGVSTbqre8reiTYjpVurpvCVZ8PAA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389769AbfGYRJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388559AbfGYRJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:09:35 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64C3822C7B;
        Thu, 25 Jul 2019 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564074573;
        bh=rkdM8CWr1A1LMWe/EH04Dnfcj0n7tqCfgrgm7BTi5jQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V2kS5kGzF++a03Gk5zIP6RZHen6WFgWlfieoKDlrHqhEHPec5TNp/uyFIM1M9uehw
         LnN/eGuu4aLZCbQHXlzK4cEM25XKPTnaNYChzXcEWdoNw9zQyjL+vFPdlyy6PV4aH5
         wyN/g5oynAZo0AxPt7Dvwsws0Sm+M9vkaj0veq4o=
Received: by mail-wr1-f50.google.com with SMTP id n9so51672752wru.0;
        Thu, 25 Jul 2019 10:09:33 -0700 (PDT)
X-Gm-Message-State: APjAAAVchACu9+4DfrJwnByOAiWXS7fa4zbLsTb942psMJLSrWTENUrN
        ls4uYm87r0BqtAcxe5ZdkT9zv+sbF1z9ypuV6dE=
X-Google-Smtp-Source: APXvYqyhMUD0VRm57goMo+umKK9xrgzMe/ILEaoUR4e6spWK6lgrnxam7yAoo2qceAKGdHiCpgWiUDRXhXO1xXYbZ1k=
X-Received: by 2002:adf:c613:: with SMTP id n19mr39171710wrg.109.1564074571943;
 Thu, 25 Jul 2019 10:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190722095425.14193-1-amergnat@baylibre.com> <20190722095425.14193-4-amergnat@baylibre.com>
 <1j5znqxj74.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1j5znqxj74.fsf@starbuckisacylon.baylibre.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Fri, 26 Jul 2019 01:09:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v64AJFMkZQaytYMN+EsLT0sS-3VwzWUfb3g7SdL7kCfu+g@mail.gmail.com>
Message-ID: <CAGb2v64AJFMkZQaytYMN+EsLT0sS-3VwzWUfb3g7SdL7kCfu+g@mail.gmail.com>
Subject: Re: [PATCH 3/8] clk: meson: gxbb: migrate to the new parent
 description method
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        baylibre-upstreaming@groups.io,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 10:50 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Mon 22 Jul 2019 at 11:54, Alexandre Mergnat <amergnat@baylibre.com> wrote:
>
>
> > @@ -1592,13 +1737,29 @@ static struct clk_regmap gxbb_vid_pll_div = {
> >       .hw.init = &(struct clk_init_data) {
> >               .name = "vid_pll_div",
> >               .ops = &meson_vid_pll_div_ro_ops,
> > -             .parent_names = (const char *[]){ "hdmi_pll" },
> > +             .parent_data = &(const struct clk_parent_data) {
> > +                     /*
> > +                      * This clock is declared here for GXL and GXBB SoC, so
> > +                      * we must use string name to set this parent to avoid
> > +                      * pointer issue.
> > +                      */
>
> I don't really get the issue with this comment.
>
> How about:
>
> /*
>  * Note:
>  * gxl and gxbb have different hdmi_plls (with different struct clk_hw).
>  * We fallback to the global naming string mechanism so vid_pll_div picks
>  * up the appropriate one.
>  */

If you're sticking to global names for now, you could just skip converting
this clock altogether. I suspect .parent_names will be around for some time.

On the other hand, if you really want to get rid of global clock name based
parenting, you could use clk_hw pointers, and have the probe function fix
up this one based on the compatible string. That's what I did.

Just my two cents.

ChenYu

> > +                     .name = "hdmi_pll",
> > +                     .index = -1,
> > +             },
> >               .num_parents = 1,
> >               .flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
> >       },
> >  };
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
