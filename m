Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566B5C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269CC208CC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HX+z1mR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfKSQpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:45:21 -0500
Received: from mail-eopbgr30086.outbound.protection.outlook.com ([40.107.3.86]:9798
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727560AbfKSQpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:45:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW0FjHjSXmmhDlkoShLdOoVNk5WzsBJZvESCS+qM7u1H7EMIkI3q3EYamrIIL+aJFsdDduplMraVKDU4sFviP+Co3mdrkvqrbP3dCWGAf8gz30MpSzraaK2GpduaaghD/B8CO5+Xg0XbXFqHkbcwsKgfqTVGg2ly9a2r8L7iKuMIxthr+KVaqQDZg0vqewpy1yNCs5LC1cNCHn5ef6SY9hHUKc0ZrNOFPzaTPF/hGTpQCRyCxoqfJ+Y/7xfjdjUYPW4QLf61EYgRgHaPS8YtcgybdJs/QRyhYQ2h5lvDZNh6zyjQBoMFSoupRKeR0ZATREZ4NgUgK6n95PPUFQ1B9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyLJsJu95tbbKGa3xk+HzRtM4IoVJOhm1KLwhuHReUw=;
 b=OrSDAqOpvwMOD81aPL8266CoeHE3hu/E+TU7sqdRSKGBTc1VUHceUUMVzIleMhcZWz9KhnFtV+rtCAN3FlmjNdyKYNrcl2Kat3HI19qAMMHyjCywxPzTp4ja/oqDk5VCK59aL48pH8c4E0WcfhcqXVuzV9baHP+61ie/4zvp44Uwefu8vPLok7b7CqmA7laHY+TxjWIBVbxo/SVHBCjbA8V+fGyTWoaj6bHhyfXPd/0YJUIAdZ1RsAyfg94BEXl4CBKDY5V+HtfVNicazPuQ98ntNstkK9QCN699NAplx9z9/qPkM1/JWs+cNGLcjsHnwWIX9adGQoCUOyoJjvrbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyLJsJu95tbbKGa3xk+HzRtM4IoVJOhm1KLwhuHReUw=;
 b=HX+z1mR/wmYpeBd3DZjiwtRpRRVYeFfxQKQTkKHjscgfc69TiawMqT16a2I+74VNEETdJRy+OFljIJlJ60yks9zdTNtDjlKXZDS0YcG1SVli+5TtAm89aMdNrneKVqAkntNROlVvP9IWVid4EZlcGoRbT6fe2tD+E4kWP9vGAhI=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4432.eurprd04.prod.outlook.com (20.177.54.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 16:45:11 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 16:45:11 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH V3 0/4] clk: imx: imx8m[x]: switch to clk_hw API
Thread-Topic: [PATCH V3 0/4] clk: imx: imx8m[x]: switch to clk_hw API
Thread-Index: AQHVnrhjSBoXgoVf/UaxtVvL2YWuSA==
Date:   Tue, 19 Nov 2019 16:45:11 +0000
Message-ID: <VI1PR04MB702313D66C0C6212FDCD9AF5EE4C0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1574154146-8818-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 875090e2-133c-4919-bb7e-08d76d0fd819
x-ms-traffictypediagnostic: VI1PR04MB4432:|VI1PR04MB4432:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB443279DB15662733FB1D2CBAEE4C0@VI1PR04MB4432.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(189003)(199004)(9686003)(6436002)(966005)(476003)(446003)(478600001)(26005)(76116006)(14454004)(33656002)(102836004)(316002)(256004)(52536014)(14444005)(2501003)(7736002)(305945005)(186003)(44832011)(486006)(6246003)(54906003)(6306002)(55016002)(229853002)(81156014)(64756008)(66556008)(66476007)(66946007)(8676002)(66066001)(25786009)(53546011)(91956017)(110136005)(86362001)(74316002)(4001150100001)(8936002)(71200400001)(6506007)(71190400001)(5660300002)(6636002)(3846002)(6116002)(4326008)(2906002)(99286004)(76176011)(66446008)(81166006)(7696005)(32563001)(15585785002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4432;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aw+7j6QHRsAFaOqBANzFCGfU4Obn0ftICSkjq6WCzNzgXr7xQHp0cLsSBWnrAuTSuf1jYmN9zlNRwlVuipZIAG64+CV5dSvw1z8CJemgYBxNWz4jmHNOkRzuw0EFAu9E9oMgGHk3pRnPZjCKUc6qonWwyVNAnpuWXg/JiT7K7T3uCXIoLhSGebc14W+GafySF2I/LX4XfguH9UrqfT8g4kBx08ZYKWT3pMnMVkHOxgq28GBNJVDk3ZrGmIliG0kcT4f4uphNYNIlWodM2ghALD81Van5v0CQnB7407sq8TfVW1eT5vRmaFjMUhENnq49gL1F0pbsq8WtTSTS5+p0slvIB7IAEUrK2ZKbtrM3ZEg4Q+HXJYMcuJAjJHUBpLX2IfsY0DH1CtCYjD02q/df7/IKIE3V6+I9Z50IuVx9lfGhQ9phmaKXItQbMffqMUWWb/3XQTs8XfBk+2hcX4SXz9Q3jHr/AlBJ3R97PyCfIX8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875090e2-133c-4919-bb7e-08d76d0fd819
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 16:45:11.2083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ww5mNdvvhPvI0CEuOVeaB6NNEmmz61Afo+g3v0UXKffsNs4bTFzhCsZ5fL3uar7UixS1OSjLHGR2leDjJYlzpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4432
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-19 11:04 AM, Peng Fan wrote:=0A=
> From: Peng Fan <peng.fan@nxp.com>=0A=
> =0A=
> V3:=0A=
>   Rebased to linux-next to avoid conflict, not based on shawn's clk/imx=
=0A=
>   correct a few pll of imx8mn to imx_pll1443x_pll per Leonard's comments=
=0A=
>   add Abel's R-b tag=0A=
> =0A=
> V2:=0A=
>   Add a new patch patch 1/4 to avoid build warning for arm64=0A=
>   clk: imx: Remove __init for imx_obtain_fixed_clk_hw() API=0A=
>   https://patchwork.kernel.org/cover/11224933/=0A=
> =0A=
> This patchset is to Switch i.MX8MN/M/Q clk driver to clk_hw=0A=
> based API.=0A=
> =0A=
> Based on linux-next branch, with [1] applied.=0A=
> =0A=
> [1]  clk: imx: switch to clk_hw based API=0A=
>       https://patchwork.kernel.org/cover/11217881/=0A=
=0A=
For imx6/7 the big clks array was renamed to "hws" during the switch, =0A=
maybe do this here as well as for consistency? Several non-imx drivers =0A=
use the "hws" name as well.=0A=
=0A=
It would be nice to avoid another patch in the future that rewrites most =
=0A=
of the file, that kind of stuff makes it difficult to read history.=0A=
=0A=
> Peng Fan (4):=0A=
>    clk: imx: Remove __init for imx_obtain_fixed_clk_hw() API=0A=
>    clk: imx: imx8mn: Switch to clk_hw based API=0A=
>    clk: imx: imx8mm: Switch to clk_hw based API=0A=
>    clk: imx: imx8mq: Switch to clk_hw based API=0A=
> =0A=
>   drivers/clk/imx/clk-imx8mm.c | 550 +++++++++++++++++++++---------------=
-----=0A=
>   drivers/clk/imx/clk-imx8mn.c | 475 ++++++++++++++++++------------------=
=0A=
>   drivers/clk/imx/clk-imx8mq.c | 569 ++++++++++++++++++++++--------------=
-------=0A=
>   drivers/clk/imx/clk.c        |   4 +-=0A=
>   4 files changed, 819 insertions(+), 779 deletions(-)=0A=
> =0A=
=0A=
