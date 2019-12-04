Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EA2C432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0725206E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575424577;
	bh=JMIovwGkg6BkV85by6dfJ05laRnmJWc/lf3o2OZmB4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fEv8lAlXcQa5Udnffn8ucFSHY2Hh0PigbRGBawtu06DwRLoJAjllXiqu5+APffeRU
	 TvmYQzx0X0lonuwVCWdbgLlcd9+crCQO5NXSrvfpnYFC2+0/bc+LxCqW74h2H27NdA
	 fI54uUaMQI/vb9fLrVnqfgT1GDx3aqhHhhF1KL3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLDB4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 20:56:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfLDB4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 20:56:16 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D486205ED;
        Wed,  4 Dec 2019 01:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575424575;
        bh=JMIovwGkg6BkV85by6dfJ05laRnmJWc/lf3o2OZmB4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPTi0jOL2X/jVyN9vBibhLaI+ju/EaX6koENDUesJUYB3Wp+RK0audVVpyoazZKp0
         O2nEDH9Brf2x7c4gY419nOypEdGmrVTnFnmQ405YoMzTKU5ye+d1dINd5kVDSavJcJ
         KgJk/JFvsYj3Ym89x2eTjJ1f8cnVaRqIk7AeQkyY=
Date:   Wed, 4 Dec 2019 09:56:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] clk: imx: clk-composite-8m: add lock to gate/mux
Message-ID: <20191204015605.GJ9767@dragon>
References: <1572603166-24594-1-git-send-email-peng.fan@nxp.com>
 <20191202081948.GD9767@dragon>
 <20191203090339.A36CA20661@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203090339.A36CA20661@mail.kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 01:03:38AM -0800, Stephen Boyd wrote:
> Quoting Shawn Guo (2019-12-02 00:19:49)
> > On Fri, Nov 01, 2019 at 10:16:19AM +0000, Peng Fan wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > > 
> > > There is a lock to diviver in the composite driver, but that's not
> > 
> > s/diviver/divider
> > 
> > > enought. lock to gate/mux are also needed to provide exclusive access
> > 
> > s/enought/enough
> > 
> > > to the register.
> > > 
> > > Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > 
> > Other than above typos,
> > 
> > Acked-by: Shawn Guo <shawnguo@kernel.org>
> > 
> > Stephen,
> > 
> > I assume you will take it a fix.  Otherwise, please let me know.
> > 
> 
> Is this a critical fix for this merge window? I'm not sure it is
> important so I marked it as "awaiting upstream" and assumed you would
> send it on up later.

Okay.  I queued it up.

Shawn
