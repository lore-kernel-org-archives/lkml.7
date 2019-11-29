Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE6BC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734C420833
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLGJCHQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfK2MIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 07:08:12 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35882 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2MIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 07:08:12 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so9183467edp.3;
        Fri, 29 Nov 2019 04:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYh4OF7fVecpJQShy7dlLTgKEjADRLBZ2wMKeIZnp+c=;
        b=sLGJCHQh1Ii00vfaWvxz8zLwdfABNxTItE+up4RY4ik3cKyLshn4OlAOTXbemurpTg
         S8xxiFrVKISJPTDbFVqFgE8KyiCPlEFXizAzNK7lrtxtOFyAmG+9OfLl2erO0zijnBCo
         5zWqTsJiz4sOzngC0wSe18Lzn/HMBG+V+c9Sr9b8ZPlIgExtaSxbdw+jcgEAVzwT3tFO
         +bW1uMMRWrHEg4sBhJ582rYkW0GyDfXn0FWn0H2bQseX79SXZbxMe9ZlA+s5mW5EkgUv
         2iyToHoCYRW8uUHFUgRdyR4QBo14hjtJcEbiKDT4i96Y2WIFflnPzYLFwsMad6VsWwdJ
         94YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYh4OF7fVecpJQShy7dlLTgKEjADRLBZ2wMKeIZnp+c=;
        b=fodT1VWHIoAPtAajtEte6OFnuTXhWwZ0SOarQ5TUYnJFby+hNZMyiBSnVpu811g1l1
         OQjUGr6vedqEe9TnNwmgwO5+dxPcrbvO7RljqF51BFlfiMfUQ17GsjXGKTX3TA08m4Oj
         eTIFmu7DlXg0spwbELiziQ02g2/ovOhYQZKcsTV0RTjGoYOV8ExBwJ9qs4hwM+RK/I+r
         HWFZJeV41YLakxhNBVZTs80z+FlKb8280St8iJkqL0kv9DLT4g2ObTNejkvQSX3QyOiR
         VLFJZCXujgL84LaP8qFpl+uZ59Ze90IkdL4M7tF8tKMuJA3yAI39QTbQ5bfLhIuj80vN
         SQuw==
X-Gm-Message-State: APjAAAUactJQSRuiZoBE9TGGo80B9hiJ3KnHC2T28Ld7J4Ccaz5RW+Ig
        oATkbVu8U4DypkzC+dG3PnWidL58g/yqoCEGmZ8=
X-Google-Smtp-Source: APXvYqzfF1cK0U5U4Uai+ex5wb5S/gF/3ZFT9boQhMY2iqy9QLvZz4J6Rmjpttfz4SalMl4mp+5Jg61VsKdLCcxqE78=
X-Received: by 2002:a17:907:2099:: with SMTP id pv25mr40555706ejb.144.1575029289991;
 Fri, 29 Nov 2019 04:08:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574922435.git.shubhrajyoti.datta@xilinx.com>
 <d9277db2692bb77a41dfed927cfb791bdcced17d.1574922435.git.shubhrajyoti.datta@xilinx.com>
 <20191128074505.GC1781@kadam>
In-Reply-To: <20191128074505.GC1781@kadam>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Fri, 29 Nov 2019 17:37:57 +0530
Message-ID: <CAKfKVtHpP4j32CNA8ioET=wqYPWtzrQvH-A+4n-pcvj1KZy=fg@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] clk: clock-wizard: Make the output names unique
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-clk@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 1:15 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Nov 28, 2019 at 12:06:15PM +0530, shubhrajyoti.datta@gmail.com wrote:
> > From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >
> > Incase there are more than one instance of the clocking wizard.
> > And if the output name given is the same then the probe fails.
> > Fix the same by appending the device name to the output name to
> > make it unique.
> >
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > ---
> >  drivers/clk/clk-xlnx-clock-wizard.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/clk/clk-xlnx-clock-wizard.c b/drivers/clk/clk-xlnx-clock-wizard.c
> > index 75ea745..9993543 100644
> > --- a/drivers/clk/clk-xlnx-clock-wizard.c
> > +++ b/drivers/clk/clk-xlnx-clock-wizard.c
> > @@ -555,6 +555,9 @@ static int clk_wzrd_probe(struct platform_device *pdev)
> >               ret = -ENOMEM;
> >               goto err_disable_clk;
> >       }
> > +     outputs = of_property_count_strings(np, "clock-output-names");
> > +     if (outputs == 1)
> > +             flags = CLK_SET_RATE_PARENT;
> >       clk_wzrd->clks_internal[wzrd_clk_mul] = clk_register_fixed_factor
> >                       (&pdev->dev, clk_name,
> >                        __clk_get_name(clk_wzrd->clk_in1),
> > @@ -566,9 +569,6 @@ static int clk_wzrd_probe(struct platform_device *pdev)
> >               goto err_disable_clk;
> >       }
> >
> > -     outputs = of_property_count_strings(np, "clock-output-names");
> > -     if (outputs == 1)
> > -             flags = CLK_SET_RATE_PARENT;
> >       clk_name = kasprintf(GFP_KERNEL, "%s_mul_div", dev_name(&pdev->dev));
> >       if (!clk_name) {
> >               ret = -ENOMEM;
> > @@ -591,6 +591,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
> >       /* register div per output */
> >       for (i = outputs - 1; i >= 0 ; i--) {
> >               const char *clkout_name;
> > +             const char *clkout_name_wiz;
> >
> >               if (of_property_read_string_index(np, "clock-output-names", i,
> >                                                 &clkout_name)) {
> > @@ -599,9 +600,11 @@ static int clk_wzrd_probe(struct platform_device *pdev)
> >                       ret = -EINVAL;
> >                       goto err_rm_int_clks;
> >               }
> > +             clkout_name_wiz = kasprintf(GFP_KERNEL, "%s_%s",
> > +                                         dev_name(&pdev->dev), clkout_name);
>
> If this kasprintf() crashes then clk_wzrd_register_divf() will fail.
> But that was a headache to review.  Just add a check for NULL.  We need
> a kfree() as well.
>
> One alternative would be to just declare a buffer on the stack and use
> snprintf().  We don't need to keep the name around after the call to
> clk_wzrd_register_divf().

Will fix in next version.

>
> regards,
> dan carpenter
>
