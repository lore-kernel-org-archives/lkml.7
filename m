Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7014C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736B820409
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mdXTCrtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfKSNmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:42:16 -0500
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:50180
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfKSNmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:42:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZWBUXRRYqDleBMrt1Mc48yU8jD4XY7Kix463Co2WrCAw/bAJBrrF5CtCAeZdPNcU/0wHDjxyKEBHCLyHCsrvw8+vZUjcGYYuWIJA5gXZWucRdxxy78n0oiPqUZTH2J1ULIyZQDUJ/5cFHRgptvZzg606fm6jOnsjfW0OOVIWtO/HLWW/gnT2hfYUcmz3APRqLjdDoxe9uakYvOA8x4i7yEsvjIYvA6naU9OrM9qEHcltKB1JSyBkD6VPeGRYPPV7tm8tFB+fHleVtU6As8WNVly7iwdud3y6C9uNeqqwx7utm31vQCXlH4g7sa80xhy3BQnT6Eg1fRBfiB5Qyro3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrcA4FocLholhOcDCTRyJy7X5KnYvEgUiUvLfJrq0gQ=;
 b=CZBRWY3hO13iv/CAO5CHc1ZH3xcqlM9RijPmW/dM0C/08T40eJ5C2b/lV5o29/7Kkz76tPjCoF5AaLqNn2mHkSZSpdvBQ/H2F433ykWCSFtc9P41ab1LOE0tqabEHNNQlTNvOzmJNtLZLIcZPfDy3EZNmQ/OYeeiIPBWxphp9JFfZFYABNimGM/oEmQ8pc71Zqu71e6B+4ZMfNapQzGQD1BIMZLvWLe6am+5jUsIMV/0W0B/jaQbsAObu5YkBaLN/K5evtrwXATsL1r6dcK8y45y5IIU9W/WGDUDcuGkEL4RTXSZUxb27CXXK4/GkJXORBHwaDT3GQyMkAzNbriiOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrcA4FocLholhOcDCTRyJy7X5KnYvEgUiUvLfJrq0gQ=;
 b=mdXTCrtqa8RY6YugOQtIqa2WrJWAUTCjqLd1hbmSDGdxXkg0EwkA7tfhT+qiR1Pf7gNOiiH+5NTq9Rynq28dYLcGDh4lyzc11ay2xCiM4XONwczxMm9QBli+iNXB6rGZ9dWqqrGNV/WWnbJfGKstvEcaocfK355EJGyG2EF13Vg=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5587.eurprd04.prod.outlook.com (20.178.117.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Tue, 19 Nov 2019 13:42:07 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 13:42:07 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
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
Thread-Index: AQHVnrhjSBoXgoVf/UaxtVvL2YWuSKeSgNGA
Date:   Tue, 19 Nov 2019 13:42:06 +0000
Message-ID: <20191119134205.yxylwjfv27dxtt4o@fsr-ub1664-175>
References: <1574154146-8818-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1574154146-8818-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR03CA0071.eurprd03.prod.outlook.com
 (2603:10a6:207:5::29) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c75200f-4139-4471-6807-08d76cf644c3
x-ms-traffictypediagnostic: AM0PR04MB5587:|AM0PR04MB5587:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB55879998836CF7C65E308BF1F64C0@AM0PR04MB5587.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(199004)(189003)(99286004)(446003)(11346002)(44832011)(486006)(6506007)(76176011)(476003)(66446008)(5660300002)(71200400001)(8936002)(186003)(81166006)(81156014)(9686003)(966005)(14454004)(8676002)(66066001)(33716001)(3846002)(6116002)(2906002)(6512007)(498600001)(25786009)(6306002)(4326008)(64756008)(66556008)(86362001)(102836004)(66946007)(66476007)(53546011)(229853002)(52116002)(386003)(54906003)(7736002)(305945005)(6436002)(6862004)(1076003)(256004)(6486002)(6636002)(6246003)(71190400001)(26005)(14444005)(32563001)(15585785002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5587;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RGbPUwkGIonwVa8V4qG9cv9W1i2t+g8fQcBtMdsSw8SxkhOq7D98kQuxgTL6zDxR3+zoxePuuNF+1zLcz1C/ZXKfh98uUI5OoXASxWD9rJWjCK4euhTrIHpxuh4qc2iFC1+b+++UDMDsFf1C5+D4uMkK9tfySH4+mwSfgc4ay5gyUG/ttpgZtSauSB9+ME0r0D3QpkzYvCUV5o7Yj3pb2AlTE91C0CZNu4bNUKPChgU1OMKpS1JiwRVQwpmmo2GOMQsxCCGRq20+wgri3jsoM+vj7LIG4SrrF7PW/Yd1ElTG1dUorRsWbk0PmRc56nthBibZSFzZf1Oc8gyLInaZdN0M2LUn3Puotm3B+/Sp9ZNzYyKgDj3wDG+z5jXmB1qrlampmB31As6fo2sLhh5s2Gd5UW+UzNJu71VsCZOMR4up75AtkxA1wnkbItYmUUYQ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8473AC6E9198EC45AB658BB8F970F4A4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c75200f-4139-4471-6807-08d76cf644c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 13:42:06.9854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SebeVTzmxsVnW9bCk+mbuJCo8fS1UO6AklNx2nbeXt/aC6ia1wh/2tDqdxducXDqkgOVnBcX+lHJOZNSk9zj1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5587
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-19 09:04:46, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> V3:
>  Rebased to linux-next to avoid conflict, not based on shawn's clk/imx
>  correct a few pll of imx8mn to imx_pll1443x_pll per Leonard's comments
>  add Abel's R-b tag
>=20

Adding the R-b tag again here:

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> V2:
>  Add a new patch patch 1/4 to avoid build warning for arm64
>  clk: imx: Remove __init for imx_obtain_fixed_clk_hw() API
>  https://patchwork.kernel.org/cover/11224933/
>=20
> This patchset is to Switch i.MX8MN/M/Q clk driver to clk_hw
> based API.
>=20
> Based on linux-next branch, with [1] applied.
>=20
> [1]  clk: imx: switch to clk_hw based API
>      https://patchwork.kernel.org/cover/11217881/
>=20
> Peng Fan (4):
>   clk: imx: Remove __init for imx_obtain_fixed_clk_hw() API
>   clk: imx: imx8mn: Switch to clk_hw based API
>   clk: imx: imx8mm: Switch to clk_hw based API
>   clk: imx: imx8mq: Switch to clk_hw based API
>=20
>  drivers/clk/imx/clk-imx8mm.c | 550 +++++++++++++++++++++----------------=
----
>  drivers/clk/imx/clk-imx8mn.c | 475 ++++++++++++++++++------------------
>  drivers/clk/imx/clk-imx8mq.c | 569 ++++++++++++++++++++++---------------=
------
>  drivers/clk/imx/clk.c        |   4 +-
>  4 files changed, 819 insertions(+), 779 deletions(-)
>=20
> --=20
> 2.16.4
>=20
