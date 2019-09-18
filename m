Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1567C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2BC218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568786845;
	bh=AIGreTLnb6bk3q8joO9XO69tVeABHA7b5VsQxkJP7Qk=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=pxqozZ2m+E/3QNV1Ovl0p8Iimzl3KUPO3eluLbZut+JucbUjQMlV3vXxZ2b/45qWi
	 drpjK5YKwWGHKUzWYgth9X4ND/RXzj92BC6tMearstmo/0K1dfk8F8xYRPGR6qxnTA
	 Uh5HVmbYWG7c97h4/xhlCchmRf8jsTjVWnJscXig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfIRGHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfIRGHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:07:24 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61E0120856;
        Wed, 18 Sep 2019 06:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568786843;
        bh=AIGreTLnb6bk3q8joO9XO69tVeABHA7b5VsQxkJP7Qk=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=PZgRV9uH68lZF9Yfar4tWWII27pZcPdHXgBuaRNuQVd1Cv+QPz6URLR2rzD/j6SpE
         IT0b6IeHE4Dt5kthLM1AdLZ6iqgtXwu+HeYlILr/7u2q79rZUMs3zXR+e6qMGvBQyB
         iGn39550ZKs89ndUK4QihxjtMXYMfKqoVkUshgB4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1568043491-20680-2-git-send-email-peng.fan@nxp.com>
References: <1568043491-20680-1-git-send-email-peng.fan@nxp.com> <1568043491-20680-2-git-send-email-peng.fan@nxp.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH V3 1/4] clk: imx: pll14xx: avoid glitch when set rate
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 23:07:22 -0700
Message-Id: <20190918060723.61E0120856@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (2019-09-08 20:39:34)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> According to PLL1443XA and PLL1416X spec,
> "When BYPASS is 0 and RESETB is changed from 0 to 1, FOUT starts to
> output unstable clock until lock time passes. PLL1416X/PLL1443XA may
> generate a glitch at FOUT."
>=20
> So set BYPASS when RESETB is changed from 0 to 1 to avoid glitch.
> In the end of set rate, BYPASS will be cleared.
>=20
> When prepare clock, also need to take care to avoid glitch. So
> we also follow Spec to set BYPASS before RESETB changed from 0 to 1.
> And add a check if the RESETB is already 0, directly return 0;
>=20
> Fixes: 8646d4dcc7fb ("clk: imx: Add PLLs driver for imx8mm soc")
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Applied to clk-next

