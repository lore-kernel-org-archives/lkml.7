Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED636C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59FA2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564522810;
	bh=SZSfxS8OeqC//cyK+U9fS3g64U6+kM4axmL/pZ6RfQw=;
	h=In-Reply-To:References:Cc:From:To:Subject:Date:List-ID:From;
	b=HWnzL3joPr3ReHLv3iDtBSpdEvbm2KFuB5STL0ybEfIja3PHvDJyouj7VLArXwrjJ
	 TsMuqm2FxHl8nxQNxPk+BBkpnWxL5BEW5hvjf+cWv9oMGHvr7yHQCilGS1UBq4pssz
	 fFqqQaCYw7sdXJU//i9o60NuQXmDvNYK3yyYahOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfG3VkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbfG3VkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:40:09 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F8E206E0;
        Tue, 30 Jul 2019 21:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564522808;
        bh=SZSfxS8OeqC//cyK+U9fS3g64U6+kM4axmL/pZ6RfQw=;
        h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
        b=g2dt8aQ+Yd3kdmtz5hTDZ9LA/BBYXzSQFMux+T09KThIbnXDTvVW1qbY54VZtsGnx
         Pl9jrFUCO9Kyh6vZl6eCa78fNWgAZZj+vux1D5urvuW2yiKaoFV5mqgoDAcpfjxhPm
         6F8yhHn3zqnRCPiNGI2XjzYk+yksCuNJY+p5CvmY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190730183818.mvoo5q3s4xylrqao@fsr-ub1664-175>
References: <1564471375-6736-1-git-send-email-abel.vesa@nxp.com> <20190730175231.B05ED206A2@mail.kernel.org> <20190730183818.mvoo5q3s4xylrqao@fsr-ub1664-175>
Cc:     Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Guido Gunther <agx@sigxcpu.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH v3] clk: imx8mq: Mark AHB clock as critical
User-Agent: alot/0.8.1
Date:   Tue, 30 Jul 2019 14:40:07 -0700
Message-Id: <20190730214008.22F8E206E0@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-07-30 11:38:18)
> On 19-07-30 10:52:30, Stephen Boyd wrote:
> > Quoting Abel Vesa (2019-07-30 00:22:55)
> > > Initially, the TMU_ROOT clock was marked as critical, which automatic=
ally
> > > made the AHB clock to stay always on. Since the TMU_ROOT clock is not
> > > marked as critical anymore, following commit:
> > >=20
> > > 431bdd1df48e ("clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CL=
K_TMU_ROOT")
> > >=20
> > > all the clocks that derive from ipg_root clock (and implicitly ahb cl=
ock)
> > > would also have to enable, along with their own gate, the AHB clock.
> > >=20
> > > But considering that AHB is actually a bus that has to be always on, =
we mark
> > > it as critical in the clock provider driver and then all the clocks t=
hat
> > > derive from it can be controlled through the dedicated per IP gate wh=
ich
> > > follows after the ipg_root clock.
> > >=20
> > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > Tested-by: Daniel Baluta <daniel.baluta@nxp.com>
> > > Fixes: 431bdd1df48e ("clk: imx8mq: Remove CLK_IS_CRITICAL flag for IM=
X8MQ_CLK_TMU_ROOT")
> > > ---
> > >=20
> >=20
> > Should I just apply this to clk-fixes branch?
> >=20
>=20
> Nope. The commit 431bdd1df48e is just in -next for now.
> So this has to be taken by Shawn, I think.

Ah ok. I thought it was related to some other problem someone was seeing
in the rc series but you're right, it was just linux-next for them.

