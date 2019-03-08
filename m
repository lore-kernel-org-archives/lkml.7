Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06963C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C130F2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 14:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MDSbdybV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfCHOqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 09:46:14 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40155 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCHOqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 09:46:14 -0500
Received: by mail-qk1-f195.google.com with SMTP id h28so11273533qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 06:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zudgGPjYTkagNqp9SUwl9xpMh9Y0w208BiIA8AHKW2I=;
        b=MDSbdybVQWQ1FZ3jmai9YJE8WZmLJKotIeiKt6YB6sT6Cs39WmAurN1WuO9X1Wiz98
         u1ItGZGCNSKVGu9wxjaqaH6R1PvdAPNPHaZq8acLeD0Nq3+j5l4Pim4sRwiUBdrHUCml
         ri4b2mZdZI5kpR3yufslBWDDc3zpDJMR6N0SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zudgGPjYTkagNqp9SUwl9xpMh9Y0w208BiIA8AHKW2I=;
        b=QFjyxTPXzac0xGOXFLd6xIq6LXEt78SiOcMBhEmyhjK8UT5puH/9yg/XOBGPsgUnWi
         FZsDwePw8NywJaS3gRkurpf5NGkj/DnAIUn5Qh1OiSzDlYYVWK9Yu7YfZQ5YJrEJbBXJ
         KkTqc164ARo1lWPMoqVTU83EjNVhubVieI5WynxgLkSR56xIhT7+z1/rwtmHtZCBxiYJ
         mMHnlf7Hoj8YsG/loZmdxdElhcDdi5sbSjCF0P/W0FjqLD4wxsGrAe5ACyTKsmdD4AtD
         rUysBy5Vz03xkVIhHl0aGW1yCai2z+xCaMejkF4pZRO1ogNU7dhtxuqLAA3UrlyMBYgP
         p5DQ==
X-Gm-Message-State: APjAAAVPZsd74+0kQ/E3zSKfzy4+v4s3ZjyLcDH8ZFas+ZqzsZHOzDqs
        zIx1AFHhfF4L1z94y3SZiik+2dsX9pcuz1s2YxLwbw==
X-Google-Smtp-Source: APXvYqzEMwkkGy5B9w5z4GHbJMJ2GNH0i0b1nmC2IhW9Fd71ECOGee7zBumuwtm4yR5TcVHXnHVUbOGFZdMRnjZwfYA=
X-Received: by 2002:ae9:ef05:: with SMTP id d5mr14533524qkg.323.1552056372290;
 Fri, 08 Mar 2019 06:46:12 -0800 (PST)
MIME-Version: 1.0
References: <20190305050546.23431-1-weiyi.lu@mediatek.com> <20190305050546.23431-10-weiyi.lu@mediatek.com>
 <CANMq1KBuTcVis2CyHB+sysp56YJwkzWytMsx8Tzk_SZyC1H=aQ@mail.gmail.com>
In-Reply-To: <CANMq1KBuTcVis2CyHB+sysp56YJwkzWytMsx8Tzk_SZyC1H=aQ@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 8 Mar 2019 22:46:01 +0800
Message-ID: <CANMq1KCFCBfaXff3qdGd7CXmz-rNt+aMVP87J84YNgxojV8TZA@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] clk: mediatek: Add MT8183 clock support
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 2:42 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> )
> On Tue, Mar 5, 2019 at 1:05 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> >
> > Add MT8183 clock support, include topckgen, apmixedsys,
> > infracfg, mcucfg and subsystem clocks.
> >
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
>
> In v1 a while back (https://patchwork.kernel.org/patch/10669765/) I
> was complaining about code duplication between these many files, and
> wondering if we can make simplify a lot of this code.

Okay, we had a discussion on this gerrit:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1510921,
and I didn't know the history that having separate clock domains that
we can enable/disable with config options. And the same pattern
already exists on clk-mt2712-*.c, for example.

So, for now:
Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

Some comment below about how this could be improved, potentially:

> Apart from that:
> Tested-by: Nicolas Boichat <drinkcat@chromium.org>
>
[snip]
> > --- /dev/null
> > +++ b/drivers/clk/mediatek/clk-mt8183-audio.c
> > @@ -0,0 +1,105 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// Copyright (c) 2018 MediaTek Inc.
> > +// Author: Weiyi Lu <weiyi.lu@mediatek.com>
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "clk-mtk.h"
> > +#include "clk-gate.h"
> > +
> > +#include <dt-bindings/clock/mt8183-clk.h>
> > +
> > +static const struct mtk_gate_regs audio0_cg_regs = {
> > +       .set_ofs = 0x0,
> > +       .clr_ofs = 0x0,
> > +       .sta_ofs = 0x0,
> > +};
> > +
> > +static const struct mtk_gate_regs audio1_cg_regs = {
> > +       .set_ofs = 0x4,
> > +       .clr_ofs = 0x4,
> > +       .sta_ofs = 0x4,
> > +};
> > +
> > +#define GATE_AUDIO0(_id, _name, _parent, _shift)               \
> > +       GATE_MTK(_id, _name, _parent, &audio0_cg_regs, _shift,  \
> > +               &mtk_clk_gate_ops_no_setclr)

This macro (or variants that end up being equivalent) is repeated 103
times in drivers/clk/mediatek/*. We can probably do better. My
suggestion is to do something like this:
#define GATE_MTK_CLK(reg, _id, _name, _parent, _shift) \
GATE_MTK(_id, _name, _parent, &reg##_cg_regs, _shift, \
&mtk_clk_gate_ops_setclr_inv)

and use GATE_MTK_CLK(audio0, ...) in the gate clock arrays.

> > +static int clk_mt8183_audio_probe(struct platform_device *pdev)
> > +{
> > +       struct clk_onecell_data *clk_data;
> > +       int r;
> > +       struct device_node *node = pdev->dev.of_node;
> > +
> > +       clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
> > +
> > +       mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
> > +                       clk_data);
> > +
> > +       r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > +       if (r)
> > +               return r;
> > +
> > +       r = devm_of_platform_populate(&pdev->dev);
> > +       if (r)
> > +               of_clk_del_provider(node);
> > +
> > +       return r;
> > +}

This (almost exact) function is now repeated 33 times in
drivers/clk/mediatek, I think it's really time for a cleanup... Maybe
there should be a common helper in clk-gate.c (or another file, not
sure), that fetches the clocks (and number of clocks from .data field
in the structure below).

> > +static const struct of_device_id of_match_clk_mt8183_audio[] = {
> > +       { .compatible = "mediatek,mt8183-audiosys", },
> > +       {}
> > +};
[snip]
