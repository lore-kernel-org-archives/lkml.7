Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83159C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5E82087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556899063;
	bh=AUKU07ZUFBcme7h7KpoCXxRbhp++Lt8tHdh+MTSYDRU=;
	h=In-Reply-To:References:To:Cc:From:Subject:Date:List-ID:From;
	b=JRPzXELTW0Ng/Lv1+zJYQq2JetBNrx2nFcECUtwJHnjDH023ST8TB+u5gB5kN7JJD
	 R3jUIsG9eysubp0QRIaA1PBEJkKIFAUXFBXnZmagCaA6oIrsTvp5mrdFAGaNbwAocd
	 272AmTM+/8TSpGfMtEXpCvKfSQYwNcKgJz1IoVY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfECP5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728282AbfECP5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:57:41 -0400
Received: from localhost (unknown [104.132.0.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E136A2075C;
        Fri,  3 May 2019 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556899061;
        bh=AUKU07ZUFBcme7h7KpoCXxRbhp++Lt8tHdh+MTSYDRU=;
        h=In-Reply-To:References:To:Cc:From:Subject:Date:From;
        b=iI/v3AxYZ3PJnJf9fEElJ2Nayg2jbyzgtTKyeB6wlFN+K94YWkHAx/BRhkDtU21h9
         PgnpcxZOLaP0pqK/8Zixe3GJVBZwSih16RDfnV+iabXZLPjyUNmtVPxruD55BWUB3d
         BuTjUxT025pMKA56mDZaoNKJObKLJYbIfOkqv0rw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM0PR04MB4211B63333AB7C50497AE17680350@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1556585557-28795-1-git-send-email-Anson.Huang@nxp.com> <155674445915.200842.2835083854881674143@swboyd.mtv.corp.google.com> <AM0PR04MB4211B63333AB7C50497AE17680350@AM0PR04MB4211.eurprd04.prod.outlook.com>
To:     "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH V2] clk: imx: pllv4: add fractional-N pll support
Message-ID: <155689906009.200842.4702575036187120025@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 03 May 2019 08:57:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aisheng Dong (2019-05-02 19:38:34)
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > Sent: Thursday, May 2, 2019 5:01 AM
> >=20
> > The Content-transfer-encoding header is still base64. I guess it can't =
be fixed.
> >=20
>=20
> How can we know it's base64?
> As I saw from the 'Headers' in patchwork, it's:
> "Content-Type: text/plain; charset=3D"us-ascii"
> Content-Transfer-Encoding: 7bit"
> https://patchwork.kernel.org/patch/10922657/
>=20
> We'd like to fix it this.
>=20

I see:

Content-Type                                      text/plain; charset=3D"ut=
f-8"                                                                       =
                                =20
Content-Transfer-Encoding                         base64              =20

Maybe that's because I'm getting the mail directly instead of from the
mailing list?

