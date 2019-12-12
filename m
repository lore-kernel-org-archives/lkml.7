Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36233C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0661921655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UgSFsogu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfLLFgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 00:36:04 -0500
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:4999
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725980AbfLLFgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 00:36:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=br+nu2HVVvkUh7FWlAh2nK/l4j9X/XTVPh3u1QMaQHEZ0eRT+l9NpFDXb+fliooskTmbCl4UwGRrwUdnOizMkdtItdWkaeG2aSIVXPCRiSrgBW4ZsDc9Me2hbGo2WHOv6R6PDLNQ6z/mHoWUIrx/FC6slf1bo6Scrz0RdHw5vIuKLf64CyfehUaAdtyp9BG/JInjKifoLAyw5j8w8OyZfXrVOE91fJ/nCnssR+6o/A7qBejo8IksIea+xnGAjdip2M84Ru3Jfk3P1A+/6tbkTW+YIuVMx0UhVBkdET2oFgigAg6ph68DgkNPmJSGM9sWDECoSJ8MDYyUqRJdWZlDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrOP2xl/OOHMnMUw7f8pvAFkUwV6MITF9fBcrWYWdJE=;
 b=MjAq7Ecihl6LpjkglkOyQGnSpvqebwqRLE0AaPh4SrWrnxwi7/GmN3hq+9bpmPB24Gx+vyjAz2wW9hnXPNCuU51J+uF3hHB966e5/VHZTxoDIM/+Vnxd3ljKZCoakPRU0SDo9hD5fnP0dKsmrApEAZQxPcY6HZhyJZI2bXBXpdlmXJV+Pd9vMs/EJRtoMd+8BlnuCq8Do+Vpjgyx7IC3Zl7hQkw+8Qqq9L1+f2YbvjvEpswUQpQpgDgN/38dRCffAlnjeHxVNvjfcFw9hn1AjGWeL30oZHW/uPKbkMWsQ07pWj0ObVUmEsN9K4x+8Wpt94yEDFodEu75794WVcC8jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrOP2xl/OOHMnMUw7f8pvAFkUwV6MITF9fBcrWYWdJE=;
 b=UgSFsoguWXYNNHDtVggMghLF8YT4ixTW7Hj05zI2Nn/Hn7MjK5I98r29hhhjZ2VBLyl64Gu2amj4shuvdyuiXcvogoumV2p0anPDub5p3ttVp7llH1/a0cYmWzZ9cJkdou73g60jUhK5D7EGkslT84xG4+OKdLeMZR5+iMu7BnM=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6580.eurprd04.prod.outlook.com (20.179.254.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.14; Thu, 12 Dec 2019 05:36:00 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 05:36:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Alice Guo <alice.guo@nxp.com>,
        "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH V2 0/4] clk: imx: pll14/sccg use relaxed API
Thread-Topic: [PATCH V2 0/4] clk: imx: pll14/sccg use relaxed API
Thread-Index: AQHVmpztVPwy+EJUrkWokuVEwk9sYqe2Jr0A
Date:   Thu, 12 Dec 2019 05:36:00 +0000
Message-ID: <AM0PR04MB4481542A5D1DE3B2144712AE88550@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1573702559-2744-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1573702559-2744-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1f417fd-64bc-4e2c-2760-08d77ec52ba7
x-ms-traffictypediagnostic: AM0PR04MB6580:|AM0PR04MB6580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB65800415725C61B4D83ECB2F88550@AM0PR04MB6580.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:357;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(199004)(189003)(9686003)(71200400001)(7696005)(44832011)(52536014)(8936002)(478600001)(8676002)(81166006)(81156014)(4744005)(2906002)(33656002)(76116006)(5660300002)(66446008)(64756008)(54906003)(26005)(6636002)(55016002)(4326008)(110136005)(316002)(6506007)(66556008)(66476007)(966005)(186003)(86362001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6580;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XD2yRd1O1lAjnGEH8YCHCtP4ZjkqRtNjssgso4iLg1RgqiqbylSprw6vNmd26ODo3uXJPDQaHO7WEr4o9RFvO14vNVfyO2cArmzjneygqVrvEjFXs9+3uNvcq5wYGRBBdWJfm4OXnq0/9IAetyFUOKz1p2KVsQfH92YEgZu7tgkAS2zGWaIq9AzBH30m6IqRwV/pGUA5NwXQBrrdmZEaiR6jEsV0SxjDDhADn7wBbfPJnhdHxQ7b+Lem++LL+gzTbT7KYIG+bpxjExC4pzpO+HwgIv74pafKZ+6Wc8c89Sp2JwGQZvz8iyLtXGz0JKPctOI0MfbmjlGYMF28oGwDDWg28HXJHbj3FozElRSC0UpebCzLsbh5Cs52z+deXGnW+Yjl4mT60TE3BvriTGH7NwpnTzZQ3H4LrKBPRC0QozIdFIeI1O5xD7pqPIvzBxiQePMgcXPJVTFSBddk4Rvy2hMr9BVZ68DEKCpXK6Wlv+A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f417fd-64bc-4e2c-2760-08d77ec52ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 05:36:00.1257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uwl+cN25AvnJcPJcGlA73JMORufG9dh5DUx4s583ZLlwLOr5QL7qAl5TxCAQMvRpO/3msakS/0DCFWShL4VxOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH V2 0/4] clk: imx: pll14/sccg use relaxed API

Any comments?

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> V2:
>  update commit message to reflect the change  Merged sccg/composite-8m
> into one patchset
>=20
> This patchset is insipred from Will Deacon's slide/video:
> https://elinux.org/images/a/a8/Uh-oh-Its-IO-Ordering-Will-Deacon-Arm.pdf
> https://www.youtube.com/watch?v=3Di6DayghhA8Q
>=20
> Peng Fan (4):
>   clk: imx: pll14xx: use writel_relaxed
>   clk: imx: pll14xx: use readl to force write completed
>   clk: imx: sccg: use relaxed io api
>   clk: imx: composite-8m: use relaxed io api
>=20
>  drivers/clk/imx/clk-composite-8m.c |  8 ++++----
>  drivers/clk/imx/clk-pll14xx.c      |  8 +++++++-
>  drivers/clk/imx/clk-sccg-pll.c     | 17 +++++++++--------
>  3 files changed, 20 insertions(+), 13 deletions(-)
>=20
> --
> 2.16.4

