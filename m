Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5628C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 04:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF48222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 04:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flUVars/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgAFERa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 23:17:30 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43622 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbgAFER3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 23:17:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so46368540edb.10;
        Sun, 05 Jan 2020 20:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NM4cO7yx6XHdWkikFjcDmehOMtjxSh2FAaet+Jaova8=;
        b=flUVars/F3OZbs1fd3Xo4NX+NdYi1GzRjlkAfssV8o73ZLfhUhSAFWX7ic15uGaFSK
         1/iw1VTwqJhgM6Ze6NYcH/2chJJKw4SEDpqwhX8tW4dEkG5hO9YtP1cjNj0khmkvf3ow
         ia3j4yquQawETubpeFmIXil8yekYP1yQmHAgiMEdN4PI2TvyXMxDFfe/r0Jhzub/txkq
         BFEISeSvPO2RQ5PJhmyHKIRa7ZFlyD6f8GzxGl1AsLU9TgxgKx96jCgwFXzvx3xXaflJ
         GxEvkE7HpOD+72FF6cFjh0BhzPWZ2DyXjw4FftC61WR62E3TRSt1l7FdAjtu11ipXO6o
         W+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NM4cO7yx6XHdWkikFjcDmehOMtjxSh2FAaet+Jaova8=;
        b=fTcfXfYZDE5hPphO+uXhCRncVfgCPbD61bG9y+8R+0pkvt48gkvpZYFZKdYJlEBgYi
         iuYNJ1Ls/wJqgs23rN4vLVM1q19JHA4XSRzbMhu8SblqjwDYCeawuC1/phr71lc6IgK6
         zvQEBa1Tw0PpLGEeY8xaIx9C39B7QKjgc4RIhVLnmdFOdi9xwjQw2DJPFVWXwP3gHB9T
         HrXNMkToRPzkU4UQ+oSaPYN9TZk0HeFXznnM3qhTsO+T12mB4YX7IYmumJJRXAAcEPpS
         M36uyFusTNpB7u5kENTx71RpKztHlBSrpqFJHBlzQEK7A+A69QS47YNu3tJvIvPigXKU
         9Zaw==
X-Gm-Message-State: APjAAAVDwWTfqec3RBy4FYjvjStYQ0SIHt3PTYejx/2QJxTcnDbpJVvb
        PrQvkaM4HCINjbTbWYCfgZFfQrSlyU1eklsj+OM=
X-Google-Smtp-Source: APXvYqyL0u361qZHtYP5NXawXdgFVviSEzFvt2t+iyc4L3etqBxubixvgUGBf2C08rJKMqTlkvE+MGfhYtfKGSUrSwE=
X-Received: by 2002:a05:6402:12d1:: with SMTP id k17mr105414587edx.291.1578284247470;
 Sun, 05 Jan 2020 20:17:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
 <55183b0a7c466528361802fabef65a57f969d07b.1574922435.git.shubhrajyoti.datta@xilinx.com>
 <20200105200014.4904320678@mail.kernel.org>
In-Reply-To: <20200105200014.4904320678@mail.kernel.org>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Mon, 6 Jan 2020 09:47:16 +0530
Message-ID: <CAKfKVtGZGw7FydE+3PJxbYW_JHB3hi_Mr144A+gvUfX24ffaDg@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] clk: clock-wizard: Update the fixed factor divisors
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     devel@driverdev.osuosl.org, linux-clk@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 1:30 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting shubhrajyoti.datta@gmail.com (2019-11-27 22:36:14)
> > From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >
> > Update the fixed factor clock registration to register the divisors.
> >
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > ---
> >  drivers/clk/clk-xlnx-clock-wizard.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
> > index 4c6155b..75ea745 100644
> > --- a/drivers/clk/clk-xlnx-clock-wizard.c
> > +++ b/drivers/clk/clk-xlnx-clock-wizard.c
> > @@ -491,9 +491,11 @@ static int clk_wzrd_probe(struct platform_device *pdev)
> >         u32 reg, reg_f, mult;
> >         unsigned long rate;
> >         const char *clk_name;
> > +       void __iomem *ctrl_reg;
> >         struct clk_wzrd *clk_wzrd;
> >         struct resource *mem;
> >         int outputs;
> > +       unsigned long flags = 0;
> >         struct device_node *np = pdev->dev.of_node;
> >
> >         clk_wzrd = devm_kzalloc(&pdev->dev, sizeof(*clk_wzrd), GFP_KERNEL);
> > @@ -564,19 +566,22 @@ static int clk_wzrd_probe(struct platform_device *pdev)
> >                 goto err_disable_clk;
> >         }
> >
> > -       /* register div */
> > -       reg = (readl(clk_wzrd->base + WZRD_CLK_CFG_REG(0)) &
> > -                       WZRD_DIVCLK_DIVIDE_MASK) >> WZRD_DIVCLK_DIVIDE_SHIFT;
> > +       outputs = of_property_count_strings(np, "clock-output-names");
> > +       if (outputs == 1)
> > +               flags = CLK_SET_RATE_PARENT;
>
> What does the number of clk outputs have to do with the ability to
> change the rate of a parent clk? The commit text doesn't inform me of
> what this is for either. Please help us understand.

If there are multiple clocks then changing the rate of the parent
changes the rate of all the
outputs so we donot allow changing the rate of the parent if there are
multiple clocks.
If there is only one output then that is not an issue.

I will update the description in the next version.
>
> >         clk_name = kasprintf(GFP_KERNEL, "%s_mul_div", dev_name(&pdev->dev));
> >         if (!clk_name) {
> >                 ret = -ENOMEM;
> >                 goto err_rm_int_clk;
> >         }
> >
