Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5E2C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAFD2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568737702;
	bh=l7quzLRsCIpHwN0A+TZMRT7D5jR/Mzc/7HAgBvrpis4=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=TDdOi/zBrLd8KsqM23mBoUWV5e/Jke6bNRZdITBOu5lWwwuO68zt+62jTxxOmroED
	 VL4VsQ4GtiU4FjMd6vSbF2R2MdV5V5MrvFooKwZodKmcH1mJxb2/ymbBEIdmLLM4af
	 Z8PdY+L0NL5SFWXeFJHtrfBVSPc3vWP9FNjanYsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfIQQ2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbfIQQ2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:28:21 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DC542067B;
        Tue, 17 Sep 2019 16:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568737700;
        bh=l7quzLRsCIpHwN0A+TZMRT7D5jR/Mzc/7HAgBvrpis4=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=UiQmuaoaNC66LbDhnM88aOLclzw05mgzmcHzK8EoL1wkHuzWznYddH5eoLOGqvKQ+
         TJxUYdgObC7SqGNzYoN7JtYKDJ4kEtTuC4GnNDYZPvTgzAv7GU0D6YZABnTaEc1r+e
         GUCSZLYiH/JoN5gzKYnKrHr0sxALVGM0O/J9m59c=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM0PR04MB4481A31DD68C3C3409E95339888F0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1568043491-20680-1-git-send-email-peng.fan@nxp.com> <AM0PR04MB4481A31DD68C3C3409E95339888F0@AM0PR04MB4481.eurprd04.prod.outlook.com>
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
Date:   Tue, 17 Sep 2019 09:28:19 -0700
Message-Id: <20190917162820.8DC542067B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (2019-09-16 23:20:15)
> Hi Stephen, Shawn,
>=20
> > Subject: [PATCH V3 0/4] clk: imx8m: fix glitch/mux
>=20
> Sorry to ping early. Is there a chance to land this patchset in 5.3 relea=
se?
>=20

No, it won't be in 5.3 because that version is released. Shawn already
sent the PR for 5.4 too so this will most likely be in v5.5 at the
earliest.

