Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA62EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABABF2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387902AbfG2PHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:07:15 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37338 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387402AbfG2PHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:07:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 08FEF1A0241;
        Mon, 29 Jul 2019 17:07:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F084F1A0157;
        Mon, 29 Jul 2019 17:07:12 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D19D52060A;
        Mon, 29 Jul 2019 17:07:12 +0200 (CEST)
Date:   Mon, 29 Jul 2019 18:07:12 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Guido Gunther <agx@sigxcpu.org>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] clk: imx8mq: Mark AHB clock as critical
Message-ID: <20190729150712.3ah2ayeonhdfrt5n@fsr-ub1664-175>
References: <1564384997-16775-1-git-send-email-abel.vesa@nxp.com>
 <CAOMZO5C0WbaDzFcjeXeS1PivWUme=bzPur6Hj_xNz1oVzvpW2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5C0WbaDzFcjeXeS1PivWUme=bzPur6Hj_xNz1oVzvpW2Q@mail.gmail.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 19-07-29 09:19:01, Fabio Estevam wrote:
> Hi Abel,
> 
> On Mon, Jul 29, 2019 at 4:23 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> >
> > Keep the AHB clock always on since there is no driver to control it and
> > all the other clocks that use it as parent rely on it being always enabled.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > Tested-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >
> > Changes since v1:
> >  * added comment in code why this clock is critical
> >  * added T-b by Daniel
> >
> > This needs to go in ASAP to fix the boot hang.
> 
> Which boot hang exactly? Are you referring to the TMU clock hang?
> 
> On the TMU clock hang, the issue was that the qoriq_thermal needs to
> enable the TMU clock.
> 
> Please always provide a detailed description in the commit log.
> 
> Also, if this fixes a hang it should contain a Fixes tag.

Please have a the explanation here:

https://lkml.org/lkml/2019/7/28/306
