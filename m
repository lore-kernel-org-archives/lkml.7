Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085C1C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452BC2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556207619;
	bh=QfVP/tIgKcO1dC2YfnIFEr1yLlGdnMnH+hkipPKTe6I=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=pmVCEAJFZj+sdCgDhygNOzyisCWXcXvVjGOn+6unTqPQJfc/iEzY3Wtk5Fpsx37YD
	 9F/UETJk6TNUmT9RQ6PXyh8AXcaGg4P3HNz4/S2rk6ztmEGW11TMgufGuZ0M159LJt
	 U7+c3jB1DnlnWSwhP+2oEJdWZknd4bz82kDav1+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfDYPxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbfDYPxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:53:35 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E35522067D;
        Thu, 25 Apr 2019 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556207615;
        bh=QfVP/tIgKcO1dC2YfnIFEr1yLlGdnMnH+hkipPKTe6I=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=Zy0hFfMTDldJMGCGnNkeB5nXxkgW8Cf+0nO0fyWPT54XBX1l//se3WQvezjsDb8ge
         FEo35dmgr9B7cbYnyUlqtDwg689t+Dq6EB0eGKqURjURaevmWMlPb4WJ+pqH4xU43N
         PaJ31s4TBHp1o8tr0l0HPpr1HEFUnxZ6p1cdmJDE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190424071347.73xbynv5jqipqkgx@fsr-ub1664-175>
References: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com> <CAOMZO5DWpu9irOWR3rux-vV1sihfsDkTs5SJ7XXy8MgRBCd-Gw@mail.gmail.com> <155493360763.20095.6174028293897341109@swboyd.mtv.corp.google.com> <155605619927.15276.90300312265075245@swboyd.mtv.corp.google.com> <20190424071347.73xbynv5jqipqkgx@fsr-ub1664-175>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [EXT] Re: [RFC 00/19] clk: imx: Switch the imx6 and imx7 to clk_hw based API
To:     Abel Vesa <abel.vesa@nxp.com>
Message-ID: <155620761362.15276.4197988939287759775@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 08:53:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-04-24 00:13:48)
>=20
> Can you please be more specific and point out exactly which one isn't ?

Is this a question for me?

>=20
> >=20
> > FYI, I'm dropping this from my review queue under the assumption it will
> > be sent again. Also, it would be nice to not have the wrappers at all in
> > the next series so that everything is clk_hw based instead of clk based.
> > Otherwise, it looks good to me and I'd like to see this work completed.
> > Thanks!
> >=20
>=20
> I'll try to resend this before the end of next week.
>=20
> As for the wrappers, they need to stay in until the last user of the clk
> based API is switched to clk_hw based. That means all the remaining imx
> platforms (1 through 5, and then 8). I chosed to do the imx6 and imx7
> first because these are easier to find. Once this is in, I'll move on
> with the imx8 and then the imx1 through imx5 (which are harder to find
> nowadays).
>=20

Ok. I'm not thrilled to keep around legacy code because nobody is
testing out new kernels on these devices. If we can, we should try to
delete old drivers that don't get used anymore, but if we can't then
we should be able to modify and compile those drivers and wait for the
bug reports to come in if something is broken.


