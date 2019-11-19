Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D17C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED3B22304
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RjmkYfaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfKSOIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:08:42 -0500
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:54881
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfKSOIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:08:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfDwNtAlEW0KERsdbA9yVd3mLbcw/NOZ+s4l8YjQE8/RYPH59Sc8PgHXs7UckiEMjA0HKTL3eBeZNmml7TFKsSC1ATHokWn+H22223Vva7/BEvAd7XEBqO8A5gunzDtEa8iaVnshNCimjvJVgOLRGT1VuGc8X6s9u26gfLDaFrbOMpMm1ioiQWnNCYG45fkwXdS1FgPKoeVNR8bCL8zwEbOka2u1kDiOdWBb2Ed69oDeUPXPPGbFh6tDId1h+B4hgWxz0HmTgFbiaX39dTH1kSsYZwsk51+hOrsPvZ4NjbF3L68E0CbRIIjj4cCjPp/hUcaOf0FIypVvBCn0FzvVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqfRX6RY0z9UsmuVpXOfE2+tikp/DfpE2xdLYXBhwAg=;
 b=nLBqYsZ+AI+IuzokB3CZUGE4zBeP0PCUT4qjk7FXR7N3EZZ8L0kjPsrn4ppHCKlvdpIPIGVjH7egRMTMUxGeaz7UMsrKh/ZLEaeO0y91Sij3dHox67UiLXcvSLtFpB2dqsvfHbkEq6AeOmuGTysH7PN8mfmgp/C/7sfHb0Pe5OJSFqSPHUsTky6x6oddg6X9IX6X3lckB7hWlFPLqlQPE4kwP35GWqKX9nLn+5HyDr6RKINl1EDob4+3U4oDTZUjJ4xa3UPHd/8vqEeo62gY7f5TuKiuHM/wdyiwtyV9GjbSy4Xa7vR+hRrcBZ5hAOXT4Hg7RImOCBOOmstVz7LPGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqfRX6RY0z9UsmuVpXOfE2+tikp/DfpE2xdLYXBhwAg=;
 b=RjmkYfaEr1hUODhS4BvJZD/6j9tt4BXnddK8ujokQIbSvb+2QS+LH/FM9KcuXFqkVMOYlDcj1J6d8R2YcXoSRzCJTBxQZHFWZfG4DsZdTnBeVhB8oOa8qatW2xETxJ0MIvFCtcHuxoXtn+9JPUl5ykT8tQqqig68y2iZkkDqyus=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB7044.eurprd04.prod.outlook.com (10.186.128.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 14:08:38 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 14:08:38 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Peng Fan <peng.fan@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 0/9] clk: imx: Trivial cleanups for clk_hw based API
Thread-Topic: [PATCH 0/9] clk: imx: Trivial cleanups for clk_hw based API
Thread-Index: AQHVnuLWT6CchFdcV0y5WK5bSM6Nyg==
Date:   Tue, 19 Nov 2019 14:08:38 +0000
Message-ID: <1574172496-12987-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:208:122::39) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bb83b43a-2109-4748-5e10-08d76cf9f92f
x-ms-traffictypediagnostic: AM0PR04MB7044:|AM0PR04MB7044:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB7044FE4898978834B74BBC2AF64C0@AM0PR04MB7044.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(86362001)(66066001)(50226002)(386003)(486006)(102836004)(6506007)(26005)(66946007)(2906002)(6116002)(3846002)(6512007)(6486002)(4326008)(5660300002)(6436002)(7736002)(25786009)(14454004)(71200400001)(305945005)(8936002)(6636002)(478600001)(44832011)(476003)(71190400001)(2616005)(36756003)(256004)(316002)(66476007)(81156014)(81166006)(186003)(54906003)(110136005)(99286004)(8676002)(66446008)(52116002)(64756008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7044;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t6Ipbn/Tq+kKaMw4nTF3OI/dJiDlyz9iXa8g9DQfOe7pUbeQ8FiudTGXN+vHBOQmefp5brgVv2GuChNNLkH0WhbWLnckAMS+phGpj3A61kWgcddSmr9cQTginwfP2xeRVK8DcJUySTYlkTbQD8gcTcFOZuolE1h5mvoOQMfzkRNrQSz79NjLKXEi84vmh8vgeMMBz3LX91Rd2zBe2f4Ki/JalCnNN0VsrE91MCNQnzEpjgZdvwbA49RGS6oX2z9ZUjJjpc0BsxcvknNnLaco+a39r/oT3c7R/W/7knih2BikUD3AdBPKZJKejQ/WT7GJ0H+xo4fyoZ2XiQ7kmYJ5xjJw+M28cYba+39hXb6m5yYCQsy+XV1dp/yx5ROAWpZcw5nKb660d7Tj/NX3jLuXKmdV8dctm6TklnOXE+igMpeRUoBtE7L0L4F/+t6rW0qD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb83b43a-2109-4748-5e10-08d76cf9f92f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 14:08:38.1031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYS709/n5yxZbFsZO8QAHquwgMG1aumTlBR3JrLSn6hdx3aj9bWISGQPOUDwfIulnxfmVhMqayPZgWefMHS5Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes are cleanups for the clk_hw based API i.MX clock drivers swit=
ch
longterm effort. As mentioned in the commit messages, the end goal here is =
to
have all the i.MX drivers use clk_hw based API only.

I've put these all in a single patchset since they do not impact in any way
the expected behavior of the drivers and they are quite obvious trivial one=
s.
More patches to follow for the older i.MX platforms but those might not be =
as
harmless (and trivial) as these ones.

Abel Vesa (9):
  clk: imx: Replace all the clk based helpers with macros
  clk: imx: pllv1: Switch to clk_hw based API
  clk: imx: pllv2: Switch to clk_hw based API
  clk: imx: imx7ulp composite: Rename to show is clk_hw based
  clk: imx: Rename sccg and frac pll register to suggest clk_hw
  clk: imx: Rename the imx_clk_pllv4 to imply it's clk_hw based
  clk: imx: Rename the imx_clk_pfdv2 to imply it's clk_hw based
  clk: imx: Rename the imx_clk_divider_gate to imply it's clk_hw based
  clk: imx7up: Rename the clks to hws

 drivers/clk/imx/clk-composite-7ulp.c |   2 +-
 drivers/clk/imx/clk-divider-gate.c   |   2 +-
 drivers/clk/imx/clk-frac-pll.c       |   7 +-
 drivers/clk/imx/clk-imx7ulp.c        | 182 +++++++++++++++++--------------=
----
 drivers/clk/imx/clk-pfdv2.c          |   2 +-
 drivers/clk/imx/clk-pllv1.c          |  14 ++-
 drivers/clk/imx/clk-pllv2.c          |  14 ++-
 drivers/clk/imx/clk-pllv4.c          |   2 +-
 drivers/clk/imx/clk-sccg-pll.c       |   4 +-
 drivers/clk/imx/clk.h                |  69 +++++++------
 10 files changed, 153 insertions(+), 145 deletions(-)

--=20
2.7.4

