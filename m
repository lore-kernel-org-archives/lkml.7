Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4BEC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCD520850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555014254;
	bh=gpogGmmjDMsYMAnr0syGisErvEABGcnbj3Zuests78o=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=OUHDqRTO7OlG4tzGtns/c36/H6dGGAF6yi+TWlgBROGtUwoih8b37g3ehARvOaFCS
	 3TdXwCcp3b4gj3QS30J+JgFAv0l+6YC6p35aA4xNo+585IP1xbgqUYvMN1mW99KWdw
	 K2rhXeuSlJpQo3e1q5IYL2ZVfcxT3wNn0D0LCUOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfDKUYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfDKUYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:24:13 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1441C206B7;
        Thu, 11 Apr 2019 20:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555014252;
        bh=gpogGmmjDMsYMAnr0syGisErvEABGcnbj3Zuests78o=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=jXpd0l71cWiHhH/ePeTTKlHRfqVSxeBZGJM6K8dDgf6FCc+90ZQeA5zfD4mm6SQk0
         V8g25CeQNqaMotjxQy0cXPNmCPLJ6BajjPGLiXPzSXJ1eGDhY14d9Ae8alx4GHvAO2
         zAnQW1nxmLmywZ9vSE7sOpetDCJFtmZe9XWxj2UY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANMq1KCFCBfaXff3qdGd7CXmz-rNt+aMVP87J84YNgxojV8TZA@mail.gmail.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com> <20190305050546.23431-10-weiyi.lu@mediatek.com> <CANMq1KBuTcVis2CyHB+sysp56YJwkzWytMsx8Tzk_SZyC1H=aQ@mail.gmail.com> <CANMq1KCFCBfaXff3qdGd7CXmz-rNt+aMVP87J84YNgxojV8TZA@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 8/9] clk: mediatek: Add MT8183 clock support
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
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Message-ID: <155501425125.20095.3209997665406275606@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 13:24:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas Boichat (2019-03-08 06:46:01)
>=20
> > > +
> > > +#define GATE_AUDIO0(_id, _name, _parent, _shift)               \
> > > +       GATE_MTK(_id, _name, _parent, &audio0_cg_regs, _shift,  \
> > > +               &mtk_clk_gate_ops_no_setclr)
>=20
> This macro (or variants that end up being equivalent) is repeated 103
> times in drivers/clk/mediatek/*. We can probably do better. My
> suggestion is to do something like this:
> #define GATE_MTK_CLK(reg, _id, _name, _parent, _shift) \
> GATE_MTK(_id, _name, _parent, &reg##_cg_regs, _shift, \
> &mtk_clk_gate_ops_setclr_inv)
>=20
> and use GATE_MTK_CLK(audio0, ...) in the gate clock arrays.

Feel free to send patches.

>=20
> > > +static int clk_mt8183_audio_probe(struct platform_device *pdev)
> > > +{
> > > +       struct clk_onecell_data *clk_data;
> > > +       int r;
> > > +       struct device_node *node =3D pdev->dev.of_node;
> > > +
> > > +       clk_data =3D mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
> > > +
> > > +       mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clk=
s),
> > > +                       clk_data);
> > > +
> > > +       r =3D of_clk_add_provider(node, of_clk_src_onecell_get, clk_d=
ata);
> > > +       if (r)
> > > +               return r;
> > > +
> > > +       r =3D devm_of_platform_populate(&pdev->dev);
> > > +       if (r)
> > > +               of_clk_del_provider(node);
> > > +
> > > +       return r;
> > > +}
>=20
> This (almost exact) function is now repeated 33 times in
> drivers/clk/mediatek, I think it's really time for a cleanup... Maybe
> there should be a common helper in clk-gate.c (or another file, not
> sure), that fetches the clocks (and number of clocks from .data field
> in the structure below).
>=20

Yeah that would be great. I only tried to fix the problem where mtk
has this duplicate code that probes platform drivers and finds things
from it. See my branch on clk.git

 https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-mtk-of-p=
lat-probe

