Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5C1C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A6A22B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="exAsROwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfLLC6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:58:42 -0500
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:33042
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbfLLC6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:58:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUMMHYMKuk6H++TE2++I66yJ9yuYzDe8LYQzqGWG/JRkHTsbif9IEHP/2RNzu+P/C3Z8Bz/2Nx33/XQt2q3lrieMfDhWXtLbTe9awjTmATANvXpYjXobC7Pi5jVfDWKoM5hv+vhjhjEcCVbEQ22VkkP900km5TrMdzwZ5uUPZ2zl7bOUt+KnfHLLscPpmIvBNpKEiX1memU8z1IoX2NISDhYA0m9uKa9yga9/Hnzv5Oj8HsYO2yJMZIyexwbymbLJEmRVR518rtW89kW7SBnjjtSrGlHauDTs4Rger2RY2+mDGWQTpXy2YVdeKXWmiKCP2ls3ASmoi4E2j9ohN+1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H80ueDAI1BZaVY7PtEth1+meRWE6eRsxYMoFkbRFGk=;
 b=Q/6oG4qohYvFhNioJ0YuyxH+fQOgJ+P4o9ORgJKpGYqzoEnGou2l50gdsDCrC4OQXgSOFfiRA6oiZ1gEji1ICDTOG6Pgy/2AHfelgiM3dBpw6iuyAVJ+fn8wyH/jU2P8b38+kpGmSYh1un6yLkuV1Ldf0G0TmodwI7RSuCD89VdHLHS6jpZNjv3/uJO3+1dzQg0JbFVZFEPA3+OIYiObZCgwPAYDv1jwdpRWITOMaFXKOtd/ulUcyq3fV4ZNbPR2AvTokVpHvlFhnH+oCsp8zY4tVVE2t/oAPYpXewNrkACjobtBoypkSvVJY/9GBhxJL1nGeBB4A7E+B5uPHwPzYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H80ueDAI1BZaVY7PtEth1+meRWE6eRsxYMoFkbRFGk=;
 b=exAsROwNX/NesGwjaO6VCJc2V+PtrnPglurNKXQcz8e9aVCDa1w6OTifZIxJechIQ+oo4574RRxqRVO0AO6zANqZGIZm+uCq7q6oJjYfXnAb+KC+BLRTo7colRMW4Pc4wMgR7VWe7Hs/na+blzoDs6KVpNR/ylCjAY4AwHLNEf8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6369.eurprd04.prod.outlook.com (20.179.252.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 12 Dec 2019 02:58:38 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 02:58:38 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/9] clk: imx8m: switch to clk_hw based API
Thread-Topic: [PATCH V2 0/9] clk: imx8m: switch to clk_hw based API
Thread-Index: AQHVsJgNGbvwO6VVu0SKbjsMmkP7iw==
Date:   Thu, 12 Dec 2019 02:58:38 +0000
Message-ID: <1576119353-26679-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:202:2::32) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aae20718-2039-48d5-26b8-08d77eaf2f71
x-ms-traffictypediagnostic: AM0PR04MB6369:|AM0PR04MB6369:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6369EA324F1B4BBAEE57663D88550@AM0PR04MB6369.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(6512007)(71200400001)(44832011)(4326008)(2906002)(6636002)(26005)(186003)(478600001)(6486002)(966005)(5660300002)(2616005)(86362001)(8936002)(36756003)(110136005)(316002)(8676002)(6506007)(66476007)(66556008)(64756008)(66946007)(66446008)(81156014)(54906003)(52116002)(81166006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6369;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KvnnWTtXq+eRCabnFgCLVrAWyFlIrkKma1aqy98fwC2AMVfUjmU41Fvt6thaRaMO6WzWEO/5H7heDEE4lkHJOaeMJ3GJKf/aA3zFzt3iruYId9UNP5GtQxrYLqr+OCzXLnCIsvKlRR/6ruHva1xyZ06E4ZZ12juDBAiArim2qia67YHvnTqGVV1s9WFNcIA9KVWjJvsUZe3obFik/BS2NslHweoQi4kSlf7ekVaDkCaDh5CSsMzp/YM88XkPtELPN5aHeMqF52FEA4KiBcz8BV4DVE1ujICBadoMbRgeBtivW+xVFfZaHz9gwkhk7tBtLb1pbLBluq7aezK6wvWCAOqnuhMe+KfFFE3TB9tLwTylZ5EDWMNMG4uCTN3qTgLDyS1N6uAypeFs1L6pU0cBL1qninmooiidSrCim4KzehXVD0KXqeTc8dU+s+BB2r+7E6DEKnjGvIsk2ZIefv50xNIpwTrQSsHYMkfMY0I5nuv9vZRjtZLS9yh9Fy/zooKpx6vgfu033R3MHjeOXB8aVw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae20718-2039-48d5-26b8-08d77eaf2f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 02:58:38.0773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0jyZjvJg4qRqlw/llt6Xy/oO24ohPrvez2HeR6DbzHSsnqJw6kou0qppVO9KGwdRb4hh5fqvb6IAcK79Oqe4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6369
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This covers v1 https://patchwork.kernel.org/cover/11217881/ and
v3 https://patchwork.kernel.org/cover/11251585/

V2:
Per Leonard's comments, use to_clk helpers
Add Abel's R-b tag
Rebased on Shawn's next branch

This patchset is to convert i.MX8M clk driver to clk_hw based API,
and add clk_hw helpers that will be used by i.MX8M clk driver.

Peng Fan (9):
  clk: imx: clk-pll14xx: Switch to clk_hw based API
  clk: imx: clk-composite-8m: Switch to clk_hw based API
  clk: imx: add imx_unregister_hw_clocks
  clk: imx: add hw API imx_clk_hw_mux2_flags
  clk: imx: gate3: Switch to clk_hw based API
  clk: imx: Remove __init for imx_obtain_fixed_clk_hw() API
  clk: imx: imx8mn: Switch to clk_hw based API
  clk: imx: imx8mm: Switch to clk_hw based API
  clk: imx: imx8mq: Switch to clk_hw based API

 drivers/clk/imx/clk-composite-8m.c |   4 +-
 drivers/clk/imx/clk-imx8mm.c       | 555 +++++++++++++++++----------------=
--
 drivers/clk/imx/clk-imx8mn.c       | 489 ++++++++++++++++---------------
 drivers/clk/imx/clk-imx8mq.c       | 573 +++++++++++++++++++--------------=
----
 drivers/clk/imx/clk-pll14xx.c      |  22 +-
 drivers/clk/imx/clk.c              |  12 +-
 drivers/clk/imx/clk.h              |  52 +++-
 7 files changed, 896 insertions(+), 811 deletions(-)

--=20
2.16.4

