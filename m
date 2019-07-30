Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8559EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C7720693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfG3SiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:38:21 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42722 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfG3SiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:38:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 929D2200742;
        Tue, 30 Jul 2019 20:38:19 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 84A1E200735;
        Tue, 30 Jul 2019 20:38:19 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 69572204D6;
        Tue, 30 Jul 2019 20:38:19 +0200 (CEST)
Date:   Tue, 30 Jul 2019 21:38:18 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guido Gunther <agx@sigxcpu.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] clk: imx8mq: Mark AHB clock as critical
Message-ID: <20190730183818.mvoo5q3s4xylrqao@fsr-ub1664-175>
References: <1564471375-6736-1-git-send-email-abel.vesa@nxp.com>
 <20190730175231.B05ED206A2@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730175231.B05ED206A2@mail.kernel.org>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-30 10:52:30, Stephen Boyd wrote:
> Quoting Abel Vesa (2019-07-30 00:22:55)
> > Initially, the TMU_ROOT clock was marked as critical, which automatically
> > made the AHB clock to stay always on. Since the TMU_ROOT clock is not
> > marked as critical anymore, following commit:
> > 
> > 431bdd1df48e ("clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT")
> > 
> > all the clocks that derive from ipg_root clock (and implicitly ahb clock)
> > would also have to enable, along with their own gate, the AHB clock.
> > 
> > But considering that AHB is actually a bus that has to be always on, we mark
> > it as critical in the clock provider driver and then all the clocks that
> > derive from it can be controlled through the dedicated per IP gate which
> > follows after the ipg_root clock.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > Tested-by: Daniel Baluta <daniel.baluta@nxp.com>
> > Fixes: 431bdd1df48e ("clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT")
> > ---
> > 
> 
> Should I just apply this to clk-fixes branch?
> 

Nope. The commit 431bdd1df48e is just in -next for now.
So this has to be taken by Shawn, I think.
