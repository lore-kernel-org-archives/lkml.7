Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E09C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5D42175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n1g+pOne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCTIwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:52:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46349 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfCTIwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:52:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id s81so848438qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gWBPcwOnfWWuBR5OofoHlrqEgTajsV+x6Nz+bAPtyeg=;
        b=n1g+pOne0DPQv4LJN76JQbnfDdE5WfN0c1+BV+rlpoie7BlhWZYI9BuzVu6g/yjIsp
         Euedj4bh+EqetlOtsBmjO0+piumidbB4LIDhrXUD71szPAV/N0QztK+53hX3uoEhpA1L
         TBmLtig6h1AWHJ0g9FpelIqvVd2cXeAXa+08A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWBPcwOnfWWuBR5OofoHlrqEgTajsV+x6Nz+bAPtyeg=;
        b=dLhBZCA8v1eQQdYNP7RH+RSdjy7Qxd38TWHZVYaRYljSA/ORzKEv3e0qdW0v/oENr0
         1K5JsXVDLz9lDr+EtlFbo4jZT1Z7+DRf6dwconc0OBMoj02k8RsMgmcuFD902yAjXP91
         KlI3JXdeYAuZocEaxDpcZ9rDqqqDpumINYhwjDBhtPr5eO9LAVRoM84iiDF3pKIzqyaT
         jWIM28D2Ez42+2WEmQ5gwXe0PDCpKENLuH/PVLrV0GR4swuG6NOgz0kimxnKJkoweHCx
         cOwTafSj09x6dUrc4qKnZyOLLRfOX1yQ0uh7iILiku+i5bZ81Ur45LL8zxH4rPQrUW85
         cjQA==
X-Gm-Message-State: APjAAAWvbK2mK1Qpi1zqB8k3xXNqqbsQtdwII8j70LyEqUkjpfCWpA0P
        EVPrqd+sen1V2LsKusEEve3pu46JKU8EprXUrK9/gQ==
X-Google-Smtp-Source: APXvYqylXM56WgsBo21ZVZsD3atuJKMt5BGaVYA/K0heFd9D0t+sss4GVGdVS1keUgIybZavdih0dK8pLVvEvYd0QDo=
X-Received: by 2002:a05:620a:1428:: with SMTP id k8mr5302410qkj.185.1553071934366;
 Wed, 20 Mar 2019 01:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-2-git-send-email-henryc.chen@mediatek.com>
 <20190111160918.GA20480@bogus> <1550465732.32365.6.camel@mtksdaap41>
In-Reply-To: <1550465732.32365.6.camel@mtksdaap41>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 20 Mar 2019 16:52:03 +0800
Message-ID: <CANMq1KDWZssSmvfMDZq5joFuhZx5+x1=wHiuw7Tki4+7MmdN8g@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH 1/7] dt-bindings: soc: Add DVFSRC driver bindings
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Derek Basehore <dbasehore@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 12:55 PM Henry Chen <henryc.chen@mediatek.com> wrote:
>
> Hi Rob,
>
> Sorry for late reply. I missed this mail before.
>
> On Fri, 2019-01-11 at 10:09 -0600, Rob Herring wrote:
> > On Wed, Jan 02, 2019 at 10:09:52PM +0800, Henry Chen wrote:
> > > Document the binding for enabling DVFSRC on MediaTek SoC.
> > >
> > > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > > ---
> > >  .../devicetree/bindings/soc/mediatek/dvfsrc.txt    | 26 ++++++++++++++++++++++
> > >  include/dt-bindings/soc/mtk,dvfsrc.h               | 18 +++++++++++++++
> > >  2 files changed, 44 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> > >  create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> > > new file mode 100644
> > > index 0000000..402c885
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> > > @@ -0,0 +1,26 @@
> > > +MediaTek DVFSRC Driver
> >
> > Bindings are for h/w blocks, not drivers.
> ok.
> >
> > > +The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
> > > +HW module which is used to collect all the requests from both software and
> > > +hardware and turn into the decision of minimum operating voltage and minimum
> > > +DRAM frequency to fulfill those requests.
> >
> > Seems like the OPP table should be a child of this instead of where you
> > currently have it?
> Do you means the opp table that I put on scpsys likes below?
> I think this opp table is used for mapping the performance state of
> power domain, so I put it on scpsys device tree document.
>
>                 dvfsrc_opp_table: opp-table {
>                         compatible = "operating-points-v2-level";
>
>                         dvfsrc_vol_min: opp1 {
>                                 opp,level = <MT8183_DVFSRC_LEVEL_1>;
>                         };
>
>                         dvfsrc_freq_medium: opp2 {
>                                 opp,level = <MT8183_DVFSRC_LEVEL_2>;
>                         };
>
>                         dvfsrc_freq_max: opp3 {
>                                 opp,level = <MT8183_DVFSRC_LEVEL_3>;
>                         };
>
>                         dvfsrc_vol_max: opp4 {
>                                 opp,level = <MT8183_DVFSRC_LEVEL_4>;
>                         };
>                 };
>
> >
> > > +
> > > +Required Properties:
> > > +- compatible: Should be one of the following
> > > +   - "mediatek,mt8183-dvfsrc": For MT8183 SoC
> > > +- reg: Address range of the DVFSRC unit
> > > +- dram_type: Refer to <include/dt-bindings/soc/mtk,dvfsrc.h> for the
> > > +   different dram type support.
> >
> > This information should come from the DDR controller or memory nodes
> > probably. And we already have some properties related to DDR type.
> Sorry, I don't know that before, could you give some hint or example for
> that?

So, I'm really not sure either... One example I could find is
Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt, but it still
doesn't specify memory type (it just passes parameters to ATF). You
can also look at
Documentation/devicetree/bindings/memory-controllers/ti/emif.txt (but
that only supports lpddr2 nodes, I guess we could add more types?).

Some ideas:
 1. DDR controller: Maybe you can probe at runtime, what memory type
is being used? After all the FW will have configured the memory
controller properly, so you could read back that information, somehow.
 2. memory node: Either add a new lpddr3/4/4x node in device tree
(like TI's emif), or add something to the memory node?
memory@40000000 {
device_type = "memory";
reg = <0 0x40000000 0 0x80000000>;
};
I don't see a binding document for memory though, and no one ever
seems to add anything but basic size information.



> >
> > > +- clock-names: Must include the following entries:
> > > +   "dvfsrc": DVFSRC module clock
> > > +- clocks: Must contain an entry for each entry in clock-names.
> > > +
> > > +Example:
> > > +
> > > +   dvfsrc_top@10012000 {
> >
> > Drop the '_top'. (Don't use '_' in node and property names)..
> ok
> >
> > > +           compatible = "mediatek,mt8183-dvfsrc";
> > > +           reg = <0 0x10012000 0 0x1000>;
> > > +           clocks = <&infracfg CLK_INFRA_DVFSRC>;
> > > +           clock-names = "dvfsrc";
> > > +           dram_type = <MT8183_DVFSRC_OPP_LP4>;
> > > +   };
> > > diff --git a/include/dt-bindings/soc/mtk,dvfsrc.h b/include/dt-bindings/soc/mtk,dvfsrc.h
> > > new file mode 100644
> > > index 0000000..60b3497
> > > --- /dev/null
> > > +++ b/include/dt-bindings/soc/mtk,dvfsrc.h
> > > @@ -0,0 +1,18 @@
> > > +/* SPDX-License-Identifier: GPL-2.0
> > > + *
> > > + * Copyright (c) 2018 MediaTek Inc.
> > > + */
> > > +
> > > +#ifndef _DT_BINDINGS_POWER_MTK_DVFSRC_H
> > > +#define _DT_BINDINGS_POWER_MTK_DVFSRC_H
> > > +
> > > +#define MT8183_DVFSRC_OPP_LP4      0
> > > +#define MT8183_DVFSRC_OPP_LP4X     1
> > > +#define MT8183_DVFSRC_OPP_LP3      2
> > > +
> > > +#define MT8183_DVFSRC_LEVEL_1      1
> > > +#define MT8183_DVFSRC_LEVEL_2      2
> > > +#define MT8183_DVFSRC_LEVEL_3      3
> > > +#define MT8183_DVFSRC_LEVEL_4      4
> > > +
> > > +#endif /* _DT_BINDINGS_POWER_MTK_DVFSRC_H */
> > > --
> > > 1.9.1
> > >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
>
