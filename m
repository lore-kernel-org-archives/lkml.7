Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3334DC00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ABD208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567790507;
	bh=ADje3siOrKc3kc72eJWckxUuVI+/07TKsbTBTdCEemg=;
	h=In-Reply-To:References:To:From:Cc:Subject:Date:List-ID:From;
	b=je6OAxiOP/ffUmOS/TPPLIxRGCpfoAnThxwZQxpF8Su7Ap1kwjWeYVU/91rBL17IE
	 7qQx7IM2V0/3NIs1nEaZIq1E5O7giqHF2VCmDxDrgCOoOKCnUEL4YjwNiwPUlTKhJD
	 orS1oaf2eFGyveFK2pvoBWT/IVA28/7IR/jA5OU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391160AbfIFRVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbfIFRVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:21:46 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAD3C20838;
        Fri,  6 Sep 2019 17:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567790505;
        bh=ADje3siOrKc3kc72eJWckxUuVI+/07TKsbTBTdCEemg=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=F6Gg7R7VzPr/ErhXep+secgJOYEBq4w1EPvGI9pGvgXLJyGo8svrm/oW7drg/3L4u
         l3sPzoyhGbENPNLTSVFQLrEjB5xpS/XsulalWsinGBLJ2kG5JvxneKC7kQS/BDAewx
         9I6tlGM8NyofUoWppoluz4rzEsTAz6npxf9yJ2Fk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1566855676-11510-1-git-send-email-peng.fan@nxp.com>
References: <1566855676-11510-1-git-send-email-peng.fan@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
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
Subject: Re: [PATCH V2 1/4] clk: imx: pll14xx: avoid glitch when set rate
User-Agent: alot/0.8.1
Date:   Fri, 06 Sep 2019 10:21:45 -0700
Message-Id: <20190906172145.CAD3C20838@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (2019-08-26 02:42:14)
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

Please make cover letters for multi-patch series.

