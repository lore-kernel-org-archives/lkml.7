Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED03BCA9EC1
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF2D21479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jomxKuQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfJ2Bjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:39:43 -0400
Received: from mail-eopbgr10058.outbound.protection.outlook.com ([40.107.1.58]:30262
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729462AbfJ2Bjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:39:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAJ3PMih2+pcSD95z1pW/7CBb+ZEwfahTBVw3UOGQZF8vWZoNrp7LxNnShUtt4+/Ry+8aArDDebIMYJtAEY31tkNVGE/jJDna2cbmoFrpF5N4nRkayv59bJ2xIx06uQcO2DUo62eFljMNX+D6N0/rL2/WiAHIf6jG82eetAPZISrVnGgrBKLEN7IC6DsZnM3VlEX0l9O0fGVnu6Y50USdCzFUtlIbcgW4MDcZBOAwoVzza3zDPM1wtemPtyLZHjmg0+oqG5oot5IJaAhmTuG8z95HDLuFrikf/uXRNu1XHgpKOkoKzzVaPxZ1TBMikB8hyIpnnTpnhuvzPwlJPSFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrXpW/plVWEitWgxxteKuKm/Or2uLWtw9JrtoYJsV2k=;
 b=fL2TC5Nf4+kW20/Jgox7s0nF2s70KlUC4oY1TYLcRjM98Yo94yJ8IidDtb16SP6SoZMfHPx/vfRe/ZjZ4qgU7dUZCMcqeVSu/0+nmOv0kAftRza2/GNAP1wu5CxP4KgDG3lnumeG9vYOyK0YBfeRUbkgYrqsWvFIvGclNZgWFsMV9EnjNKP0xw0Gei7TjAVqxCKPlt3DOtRtUFbXiVIPCfA8t5vplmR4v/cDBCla5FIhYXOw9oOc8tysCLYefdz7Jg5ZFG4YPeFjmrSbvyaj6mk7vb6jlKProtcNDU9QbEYp6t99mNMYxH+zA1Ods0A9A1nu7pgNdu4bZi+JPgihXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrXpW/plVWEitWgxxteKuKm/Or2uLWtw9JrtoYJsV2k=;
 b=jomxKuQbCgcjw1EweWOojxsL66uv9xhjwluyMMgAIoj7XjiffO094vIQKfTEey5/lXaxPMvM0nR2gbj9k7yY4aZt1+6lwMeQLDJP43uTzAOVqJ9cIpeKPJ5eZq162xL1DCzyounasAilsU8k5C7xoymOWNoCbZ/S/J43R61dzBE=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.232.225) by
 VE1PR04MB6608.eurprd04.prod.outlook.com (20.179.235.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Tue, 29 Oct 2019 01:39:38 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::e052:9278:76a3:27c]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::e052:9278:76a3:27c%6]) with mapi id 15.20.2387.025; Tue, 29 Oct 2019
 01:39:38 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM64: imx8mn: Change compatible string for sdma
Thread-Topic: [PATCH] ARM64: imx8mn: Change compatible string for sdma
Thread-Index: AdWN+a8BcHtcOb+lQK62IHYWavsiDw==
Date:   Tue, 29 Oct 2019 01:39:38 +0000
Message-ID: <VE1PR04MB64796EA8BCD1D957AE030964E3610@VE1PR04MB6479.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 125939cd-df22-42d2-3ecc-08d75c10dc79
x-ms-traffictypediagnostic: VE1PR04MB6608:|VE1PR04MB6608:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6608E89EF496FC43FB74163AE3610@VE1PR04MB6608.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(199004)(189003)(76116006)(305945005)(7736002)(229853002)(66946007)(66476007)(7416002)(6436002)(66556008)(6246003)(64756008)(66066001)(25786009)(52536014)(486006)(9686003)(8676002)(81156014)(4744005)(5660300002)(102836004)(256004)(4326008)(71190400001)(71200400001)(478600001)(81166006)(55016002)(99286004)(8936002)(54906003)(7696005)(26005)(316002)(2906002)(74316002)(86362001)(33656002)(3846002)(6116002)(186003)(6916009)(6506007)(66446008)(476003)(14454004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6608;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +LuHBioGV/P131iZ3XFaYWyBAhldTSbIglESAp8ghAJGmFwlvxFKM0pp8oa74NOrE71ekK2qzRuXaVNHDT44luQh2BXWrdF/47ii1bjvggS1KLcIdwA1KMyD+skVopfp+qJh/lIn7gg8tbp+OoLKbo97fJ+79muBSsx53neWzap+Xh0Hshim690K1qKeznF5OdhITvZDz1cWZ1RdSLYibwtDBsmje69NooyF/+MHtMAW4uZw3TEq0iTYd84I+EDY0DsXs+sGJDlWcqce66I4EYTJmiBP7aSZ4i/Lhy33DzJ70vG3YmJs0KJKSfxFZHkLMtuAE6cC70nKnKURUhOrVmtU0DJTqyuN/+iS6Eizi5DEjQDmTeDzaeNsq6l699AqmLfDBQ0kb2f9URdC6jgsRw0zuf0wy+CImBkcSPsluxhl+W0FH9MCOvw9cj7G50uo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125939cd-df22-42d2-3ecc-08d75c10dc79
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 01:39:38.3110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnq0AjuXVUGyP3xiMBfo39NoNQD9knWqGX3Afhs7WNAnF55Mpc7h12D0+R4bRkErOjkEhfRZcL/NSR2bmjJJRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
>=20
> On Fri, Oct 25, 2019 at 04:40:07PM +0800, Shengjiu Wang wrote:
> > SDMA in i.MX8MN should use same configuration as i.MX8MQ So need to
> > change compatible string to be "fsl,imx8mq-sdma".
> >
> > Fixes: 6c3debcbae47 ("arm64: dts: freescale: Add i.MX8MN dtsi
> > support")
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>=20
> Updated subject like below, and applied the patch.
>=20
>   arm64: dts: imx8mn: fix compatible string for sdma
>=20
> Shawn

Thanks, Shawn.
