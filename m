Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB6EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCDF22CED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iRPeBdYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfICSxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:53:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40987 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfICSxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:53:24 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so17848636ota.8;
        Tue, 03 Sep 2019 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHRE5vwiRsQmfIKzNfU8ikSjk1aL5KFpLsPpGNJVAMg=;
        b=iRPeBdYh0u1hlAXI6cf1aRo0DL72wMxf0NTwByNR0SRvyQUUCZW/x1+QTsCy8vh/nX
         WdgsNz5AC6hJqB2nZMaIekK7xPqoi5ElXT+YoEDaZ5G4hJflH52yGEH00RguaBZ0urRj
         B93DQ3WOzAMprr7o2KzVOI/5h7bHuYDd2wNZhrev9T88jTlOpzmEvuHFrMrjet5Gh5+F
         dLk7MvET3X9puld8m6nXR+RPYcWhf+eiuoBXRbUWjYjBGIdjJokN8iGTIYTEBoJj7pra
         14AUXji/y7updF9ppREQnOCF0opidQ39Zdtw0YWU+240gIilSHOlf+txWrb4HWFQK01G
         aHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHRE5vwiRsQmfIKzNfU8ikSjk1aL5KFpLsPpGNJVAMg=;
        b=bYKYpAJrAPpWtZS+HY27IYzhsjdHE/qV4eISOjVmSuL7dXRAQr/FpmI9pKfT3Bncy5
         Xwhgx8o7pk1BW8dD/8TrkPSrA/u/17DNPgk0Qz/FpitSxq3E/5eS1gMmy9XOzMWnRfbb
         bSBPcjjnKYu45ZsQ/HJiZ6Fp51/whoYtjB9uXbMfjA+RW4czjAnoJRL0eI+c42FdmUbP
         Qbd3xf+54yyp4Ugqp9Sp27yAtsQiec4sJ2jeEEj+Xrp28x/GzmC0XUdEnXw7t66wg25V
         ih7rqArCCRbzqwTKBqNEB/DrEcDg2bAr/ys45iu2mBwl2wt+KTlBHbFz+lr9jyu7IwCr
         Dauw==
X-Gm-Message-State: APjAAAUBrTF76h7w+O4BhjMIg+2gbiOwGvvrVjoxCQMz4+qVUKcpnRur
        aw4u4Vd6pWyPFI/QNjWAnduqRA/cRGGjlkEaybY=
X-Google-Smtp-Source: APXvYqzzjGs3iGz+R+DZYmk5mp9DxKA0s/DLw1QQfhoyZhzXDHQBhZZhHuNr7gIxErH1dwH24+7E1JiR4fWTAsVzxQ0=
X-Received: by 2002:a9d:5c0f:: with SMTP id o15mr30653969otk.81.1567536803307;
 Tue, 03 Sep 2019 11:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
 <20190902222015.11360-1-martin.blumenstingl@googlemail.com> <d9e96dab-96be-0c14-b7af-e1f2dc07ebd2@linux.intel.com>
In-Reply-To: <d9e96dab-96be-0c14-b7af-e1f2dc07ebd2@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 3 Sep 2019 20:53:12 +0200
Message-ID: <CAFBinCARQJ7q9q3r6c6Yr2SD0Oo_Drah-kxss3Obs-g=B1M28A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        qi-ming.wu@intel.com, rahul.tanwar@intel.com, robh+dt@kernel.org,
        robh@kernel.org, sboyd@kernel.org, yixin.zhu@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

On Tue, Sep 3, 2019 at 11:54 AM Tanwar, Rahul
<rahul.tanwar@linux.intel.com> wrote:
>
>
> Hi Martin,
>
> On 3/9/2019 6:20 AM, Martin Blumenstingl wrote:
> > Hello,
> >
> > I only noticed this patchset today and I don't have much time left.
> > Here's my initial impressions without going through the code in detail.
> > I'll continue my review in the next days (as time permits).
> >
> > As with all other Intel LGM patches: I don't have access to the
> > datasheets, so it's possible that I don't understand <insert topic here>
> > feel free to correct me in this case (I appreciate an explanation where
> > I was wrong, so I can learn from it)
> >
> >
> > [...]
> > --- /dev/null
> > +++ b/drivers/clk/intel/Kconfig
> > @@ -0,0 +1,13 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +config INTEL_LGM_CGU_CLK
> > +     depends on COMMON_CLK
> > +     select MFD_SYSCON
> > can you please explain the reason why you need to use syscon?
> > also please see [0] for a comment from Rob on another LGM dt-binding
> > regarding syscon
>
>
> Actually, there is no need to use syscon for CGU in LGM. It got carried
> over from older SoCs (Falcon Mountain) where CGU was a MFD device
> because it included PHY registers as well. And PHY drivers were using
> syscon node to access CGU regmap. But for LGM, this is not the case.
I see, to me it seems like LGM got a nice set of register cleanups!
so I'm all for dropping the syscon compatible

> My understanding is that if we do not use syscon, then there is no
> point in using regmap because this driver uses simple 32 bit register
> access. Can directly read/write registers using readl() & writel().
>
> Would you agree ?
if there was only the LGM SoC then I would say: drop regmap

however, last year a driver for the GRX350/GRX550 SoCs was proposed: [0]
this was never updated but it seems to use the same "framework" as the
LGM driver
with this in mind I am for keeping regmap support because.
I think it will be easier to add support for old SoCs like
GRX350/GRX550 (but also VRX200), because the PLL sub-driver (I am
assuming that it is similar on all SoCs) or some other helpers can be
re-used across various SoCs instead of "duplicating" code (where one
variant would use regmap and the other readl/writel).

[...]
> > +     select OF_EARLY_FLATTREE
> > there's not a single other "select OF_EARLY_FLATTREE" in driver/clk
> > I'm not saying this is wrong but it makes me curious why you need this
>
>
> We need OF_EARLY_FLATTREE for LGM. But adding a new x86
> platform for LGM is discouraged because that would lead to too
> many platforms. Only differentiating factor for LGM is CPU model
> ID but it can differentiate only at run time. So i had no option
> other then enabling it with some LGM specific core system module
> driver and CGU seemed perfect for this purpose.
so when my x86 kernel maintainer enables CONFIG_INTEL_LGM_CGU_CLK then
OF_EARLY_FLATTREE is enabled as well.
does this hurt any existing x86 platform? if not: why can't we enable
it for x86 unconditionally?

[...]
> > diff --git a/drivers/clk/intel/clk-cgu.h b/drivers/clk/intel/clk-cgu.h
> > new file mode 100644
> > index 000000000000..e44396b4aad7
> > --- /dev/null
> > +++ b/drivers/clk/intel/clk-cgu.h
> > @@ -0,0 +1,278 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + *  Copyright(c) 2018 Intel Corporation.
> > + *  Zhu YiXin <Yixin.zhu@intel.com>
> > + */
> > +
> > +#ifndef __INTEL_CLK_H
> > +#define __INTEL_CLK_H
> > +
> > +struct intel_clk_mux {
> > +     struct clk_hw hw;
> > +     struct device *dev;
> > +     struct regmap *map;
> > +     unsigned int reg;
> > +     u8 shift;
> > +     u8 width;
> > +     unsigned long flags;
> > +};
> > +
> > +struct intel_clk_divider {
> > +     struct clk_hw hw;
> > +     struct device *dev;
> > +     struct regmap *map;
> > +     unsigned int reg;
> > +     u8 shift;
> > +     u8 width;
> > +     unsigned long flags;
> > +     const struct clk_div_table *table;
> > +};
> > +
> > +struct intel_clk_ddiv {
> > +     struct clk_hw hw;
> > +     struct device *dev;
> > +     struct regmap *map;
> > +     unsigned int reg;
> > +     u8 shift0;
> > +     u8 width0;
> > +     u8 shift1;
> > +     u8 width1;
> > +     u8 shift2;
> > +     u8 width2;
> > +     unsigned int mult;
> > +     unsigned int div;
> > +     unsigned long flags;
> > +};
> > +
> > +struct intel_clk_gate {
> > +     struct clk_hw hw;
> > +     struct device *dev;
> > +     struct regmap *map;
> > +     unsigned int reg;
> > +     u8 shift;
> > +     unsigned long flags;
> > +};
> > I know at least two existing regmap clock implementations:
> > - drivers/clk/qcom/clk-regmap*
> > - drivers/clk/meson/clk-regmap*
> >
> > it would be great if we could decide to re-use one of those for the
> > "generic" clock types (mux, divider and gate).
> > Stephen, do you have any preference here?
> > personally I like the meson one, but I'm biased because I've used it
> > a lot in the past and I haven't used the qcom one at all.
>
>
> I went through meson & qcom regmap clock code. Agree, it can be
> reused for mux, divider and gate. But as mentioned above, i am now
> considering to move away from using regmap.
thank you for evaluating them. let's continue the discussion above
whether regmap should be used - after that we decide (if needed) which
regmap implementation to use


Martin


[0] https://patchwork.kernel.org/patch/10554401/
