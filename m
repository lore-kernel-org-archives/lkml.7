Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF31C46476
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55186208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CuYYBsFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfFGIBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:01:11 -0400
Received: from mail-eopbgr40074.outbound.protection.outlook.com ([40.107.4.74]:59854
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726607AbfFGIBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhD6KAfmENVKs1I8m7GnQJtBJvxtKUEqLS/wTVNu5D4=;
 b=CuYYBsFBAY+Lmu3xNFET7PHvA01T/wUVQntHFhjTUCyuL07ArM5yyEc7asadC4OksCDQsrJZmkRCSTSvboi1H6oCcK8x4Ax6vJp8oMRYzDdZgmi31GWFwa009q6iUE/hXZjFIRmCCrN6aEIseyOU2OHfscb1LiEPHAjrHqOmZxc=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6177.eurprd04.prod.outlook.com (20.179.34.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Fri, 7 Jun 2019 08:01:06 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::5c91:9215:bcd9:49cc]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::5c91:9215:bcd9:49cc%5]) with mapi id 15.20.1943.023; Fri, 7 Jun 2019
 08:01:06 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND v2 00/18] clk: imx: Switch the imx6 and imx7 to clk_hw
 based API
Thread-Topic: [RESEND v2 00/18] clk: imx: Switch the imx6 and imx7 to clk_hw
 based API
Thread-Index: AQHVFhnD3RH0i/2Cgk+sGoC+IpMb+qaO/2cAgADitAA=
Date:   Fri, 7 Jun 2019 08:01:06 +0000
Message-ID: <20190607080104.72e2bigis56pb3e4@fsr-ub1664-175>
References: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
 <20190606182940.F0D8C20872@mail.kernel.org>
In-Reply-To: <20190606182940.F0D8C20872@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1264e552-48cf-4623-fefa-08d6eb1e4b77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6177;
x-ms-traffictypediagnostic: AM0PR04MB6177:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB6177535F52A88B382D3DA067F6100@AM0PR04MB6177.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(396003)(376002)(346002)(136003)(39860400002)(43544003)(189003)(199004)(478600001)(76116006)(91956017)(3846002)(45080400002)(476003)(186003)(76176011)(11346002)(316002)(33716001)(446003)(229853002)(66066001)(6506007)(5660300002)(86362001)(1076003)(4744005)(26005)(102836004)(66446008)(66476007)(66556008)(73956011)(64756008)(25786009)(53546011)(6116002)(66946007)(6916009)(99286004)(68736007)(256004)(53936002)(44832011)(4326008)(54906003)(14454004)(14444005)(966005)(6246003)(81166006)(81156014)(8676002)(8936002)(486006)(7736002)(305945005)(6306002)(9686003)(6436002)(2906002)(71200400001)(71190400001)(6486002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6177;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xEHeio7DfhAnbiTTXDq0m8yuFYDwU5xZMZY5DdL/ojEfzY8NiFpaO4zFzkMRNpV3RyRPJJeDNJ7f1KYidF0xxUKfQIDExUNt6MLDKSXBq2p6o2VJgPf+B0cfyvxjF66+iOve/ItAw8O/fVsGocfMz5FEpL4AQfG+mXE/R+p0xONi3ViaVoooBBMq3/Zo25Z45OPyQJPuZ0o6tGM/A+yQQIDEbImsDigI51hE+PzQpw5BfKvECrW6+3dxV+OmG8AkKQn91QN0xsIEI1Azy49LzN0fkXXZe13AQzqY9x5Y+QFJky/9+e/pOL8ffpZfua+ajzFEx/JcK8SUxWE1TRTL1OGrZEXoepSwCmi8AXH1oKxsmiIrEWoW6ghVoLByTcb3+UcMH1pF5pXvJuInIY316VNG2E5lj/JWpezL2u141SI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A2E6D7678CFF744B8E5EF3AADAB3A22@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1264e552-48cf-4623-fefa-08d6eb1e4b77
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 08:01:06.5766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-06 11:29:40, Stephen Boyd wrote:
> Quoting Abel Vesa (2019-05-29 05:26:38)
> > Resend for the following:
> >=20
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkm=
l.org%2Flkml%2F2019%2F5%2F2%2F170&amp;data=3D02%7C01%7Cabel.vesa%40nxp.com%=
7Ccd18ca91df204bd6f99408d6eaacf258%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7=
C0%7C636954425864592743&amp;sdata=3D12O60IgeI2yxb2hJ5NmYyYxkE4o7VwH7rh1Zye%=
2BkT8E%3D&amp;reserved=3D0
>=20
> What's left after this series to convert over to clk_hw based APIs? I'm
> happy to see this merge as long as we eventually delete the clk based
> versions of the code in the imx driver so that we can complete the task.
>=20

The clk based defines will go away once there is no clk provider that needs=
 it.
The left clk providers are: all imx1 through imx5 and imx8.

I will take care of this cleanup myself.

> I took a look over everything and nothing stuck out, so:
>=20
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>=20
> for the series.
> =
