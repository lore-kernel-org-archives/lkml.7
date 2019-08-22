Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77702C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426292339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 09:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mlAWoQoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbfHVJSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 05:18:20 -0400
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:52967
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727953AbfHVJSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 05:18:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTndjeFcQ0eZQeezqsKILsR0QTTfxcEQrG5ddbLvF8vS0lgtgX+hP3ACHsmPdQA3H2VpOcGXhotkGiKQxyteArsGchqhKUdwTllGW7wwfqpx4rOARznxCfI1PC+eNXxD1xBcDfubeJ+MMY0ov8EP9X8c47qXIcJur/Bn19OwtfvGEO76JG9yM1G4+4SQxkKPWNOVmkVsYv4ob6eTcwvppM706pyk2Z+MG1yiTjryEGGfTLPsTfatYMpLNT9J0GiA2YBApUwj5844yELh+nfGBKarRxFFzp/sU2s7W3ibvgr8dwtyUpiEtNkAiBFpbUvpt5t1zMUdw2fnFmZ2sAgaCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVT0gUx3Fqe2TbZrfkmz6yw944elCJkr3rPeAXl4ZgQ=;
 b=lYRJf/3Tx4Z//znVcALoHYBXlLJUD/r5bwrqfffsI5NITZWW8BFL6Oltg9DSq8+2BBP6rJw7KImeJXM3XFuuWJZpy0v/Ut1CjmVXq2fD7CT4X1TBnaE/LEWBPeSRCJltbXov92Jm+4kYohePMfR3lUtFjnD+OD4JsgMbz2QdzPcgvCffcH+h512qoL/EV6due+B6PLmHBxxVEf6IssNZYbXKlbQkEmBUF2/EgMElVRLwFAAoFm9P3LrbIoggh51dmUFi+ERnRVOUIy9xmULw4BK8SdUHG8JU+749emyUuVf+aabfgVPaHRTti9P1sZkSWkQmafGY45ihaqA6D08jsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVT0gUx3Fqe2TbZrfkmz6yw944elCJkr3rPeAXl4ZgQ=;
 b=mlAWoQoRUQPsy49uYCcAZCU9QiTKmY+sVbbOwDDMSvlRuLLnhnl4c/BbBJQqAuB+EJBz9speO8xuCyqRtbuqaag03bMEa+7C8z64vzip7JkFGJI9T6p7CYcGbpWHLqm1K68n6gJwUHNI73xfNiNsIRb1YsQX6a0cOHNuxOLS6dc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6596.eurprd04.prod.outlook.com (20.179.254.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 09:18:11 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.018; Thu, 22 Aug 2019
 09:18:11 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Jacky Bai <ping.bai@nxp.com>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: pll14xx: avoid glitch when set rate
Thread-Topic: [PATCH] clk: imx: pll14xx: avoid glitch when set rate
Thread-Index: AQHVVv10E+OF2Euht0ilryFWSAJw86cG43qQ
Date:   Thu, 22 Aug 2019 09:18:10 +0000
Message-ID: <AM0PR04MB44818E133AD735E3EB2789E288A50@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1566266337-21597-1-git-send-email-peng.fan@nxp.com>
 <VI1PR04MB7023C1017F60BF132B6A3F8CEEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023C1017F60BF132B6A3F8CEEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80333c8c-728a-4789-7fcf-08d726e1a74c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB6596;
x-ms-traffictypediagnostic: AM0PR04MB6596:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6596AB2F2714496CE32D4C2D88A50@AM0PR04MB6596.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(199004)(189003)(54906003)(71190400001)(7736002)(53936002)(66446008)(71200400001)(2501003)(6246003)(64756008)(66556008)(66946007)(8936002)(76116006)(110136005)(52536014)(8676002)(81156014)(2906002)(81166006)(76176011)(66476007)(305945005)(7696005)(33656002)(9686003)(4326008)(316002)(6436002)(3846002)(102836004)(6116002)(44832011)(55016002)(486006)(86362001)(186003)(25786009)(14444005)(5660300002)(99286004)(6636002)(476003)(14454004)(478600001)(446003)(11346002)(66066001)(6506007)(229853002)(26005)(74316002)(256004)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6596;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WACzGWd6i4ckQp76mZrMSaiyknYX6/e4cDZfzYnwAPkKplLTRRjN5PwSnIAPl1tyDQGnYzQnKU/7h/NMH8Zx9oHYU64Cg4lMpx0OPesBwT0XhmYtsj572OhNqOOWqtTBgMEYs8cXcCKtKLuBYAQU3+CYWb5XtFWjgQdKnlTpOUDfw2TbdlzEvk0egNt9Tqhf5CgQW9yZScGky81/o6q2K5a7blYT501QkUBGDAULExVTF/0JmxmGOvbRQuzgnh27USfC4AXVFdFziDSnCU7aFqhgfvH1oKCr/T+SpYGlOjZ2mQ7Eu4zC3umssh/QChV9+Sb8CM2hi68b3CdOukn15+5BUlXaLr7Qhs1GHCU7jUmw8nAJJNlt4A7gt6eX0JQKo1cEHtDE2wrEaqe8ZDJka3vSKxOjBeKgwfUFMcOEOj0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80333c8c-728a-4789-7fcf-08d726e1a74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 09:18:10.9751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Znd45MTmOmMYfOM2U4f9D9eqfGjteoQfwNzJqZP2J81qkY57E1cXAfe3BumKF/8+2zwyzoYfKJVfkJ1LpmUl3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6596
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] clk: imx: pll14xx: avoid glitch when set rate
>=20
> On 20.08.2019 05:17, Peng Fan wrote:
> > According to PLL1443XA and PLL1416X spec, "When BYPASS is 0 and RESETB
> > is changed from 0 to 1, FOUT starts to output unstable clock until
> > lock time passes. PLL1416X/PLL1443XA may generate a glitch at FOUT."
> >
> > So set BYPASS when RESETB is changed from 0 to 1 to avoid glitch.
> > In the end of set rate, BYPASS will be cleared.
> >
> > @@ -191,6 +191,10 @@ static int clk_pll1416x_set_rate(struct clk_hw *hw=
,
> unsigned long drate,
> >   	tmp &=3D ~RST_MASK;
> >   	writel_relaxed(tmp, pll->base);
> >
> > +	/* Enable BYPASS */
> > +	tmp |=3D BYPASS_MASK;
> > +	writel(tmp, pll->base);
> > +
>=20
> Shouldn't BYPASS be set before reset?

No. the glitch happens when RESET changes from 0 to 1, not from 1 to 0.

>=20
> Also, isn't a similar bypass/unbypass dance also needed in
> clk_pll14xx_prepare? As far as I understand that could also output glitch=
es
> until the PLL is locked. It could be a separate patch.

Yes, that might also output glitch. Fix in v2.

>=20
> It's strange that this BYPASS bit is also handled by muxes like
> audio_pll1_bypass in clk-imx8mm.c but that's a separate issue not strictl=
y
> related to the glitches you're trying to fix here.

Yes, need use EXT_BYPASS for the mux usage.

Regards,
Peng.

>=20
> --
> Regards,
> Leonard
