Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F3BC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1B9218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568785999;
	bh=HBh0qOHnVIY+RKDV01ik+wwHQTg6ypDerBR3WXnw6nI=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=1gBAAk0WSK1o77g1GkXBM4nI6xCGmjWUkj1HhsDVXlEKt3uwpXs0luN7QO3GUCh8n
	 e3AX1IvinaDZSmdJo+zKpnMZDBppnNchIMj+4IN+t7JX3p54CVrGaTUgw8Eqf2DP6A
	 MVaC3n1NVLyVU647iRv1ZXApbbE+XpZqJf0FKpXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfIRFxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 01:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfIRFxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 01:53:18 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EF6E214AF;
        Wed, 18 Sep 2019 05:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568785997;
        bh=HBh0qOHnVIY+RKDV01ik+wwHQTg6ypDerBR3WXnw6nI=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=hTHYmX++O88o26Nb3TxPY1SHRqgFZk+yOUfmagmW5DahK+67NNVPcrjrWDo3cCqrh
         I73dLNgd0vuZDvDcjMZjICEnpZBwZnmAyDYp+40NiLla5PXGP9zcF1clA0pbaNiZm/
         bedvjC6jvSL9otTeBIWkw7C864Ztymk1Lz8ww564=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM0PR04MB4481D54C4508152E458BA9BE888E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1568043491-20680-1-git-send-email-peng.fan@nxp.com> <AM0PR04MB4481A31DD68C3C3409E95339888F0@AM0PR04MB4481.eurprd04.prod.outlook.com> <20190917162820.8DC542067B@mail.kernel.org> <AM0PR04MB4481D54C4508152E458BA9BE888E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH V3 0/4] clk: imx8m: fix glitch/mux
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 22:53:16 -0700
Message-Id: <20190918055317.8EF6E214AF@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (2019-09-17 22:45:20)
> Hi Stephen,
>=20
> > Subject: RE: [PATCH V3 0/4] clk: imx8m: fix glitch/mux
> >=20
> > Quoting Peng Fan (2019-09-16 23:20:15)
> > > Hi Stephen, Shawn,
> > >
> > > > Subject: [PATCH V3 0/4] clk: imx8m: fix glitch/mux
> > >
> > > Sorry to ping early. Is there a chance to land this patchset in 5.3 r=
elease?
> > >
> >=20
> > No, it won't be in 5.3 because that version is released. Shawn already =
sent the
> > PR for 5.4 too so this will most likely be in v5.5 at the earliest.
>=20
> Thanks for the info. But this patchset is bugfix, so hope this could be a=
ccepted in 5.4.
>=20

Ok. Then let's throw it into 5.4 PR and see what goes wrong.

