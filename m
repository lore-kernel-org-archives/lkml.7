Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4859C46470
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7AB21670
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T6C7rqkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfE2M0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:26:42 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:5830
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbfE2M0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEm8vd9qbgi3G+kfZFeysPFqBpQPa5ugi6q1nbqYcc8=;
 b=T6C7rqkB0r7z4I2fJkPFxvcQUwCplk3W2DY2lmv91LnWb3vE1E8wFS91PK4edczSrHYJb0WeAHHlXMMtsjMSQq7ev5Kqhg9a70SGODJWzNBB83ZmVxbq1qkEmaVFLI/li+JS5o5Blj/viz36EKDfUcgLt5nxtgdU+cd9fP6V/UU=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6049.eurprd04.prod.outlook.com (20.179.32.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 12:26:39 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 12:26:39 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND v2 00/18] clk: imx: Switch the imx6 and imx7 to clk_hw based
 API
Thread-Topic: [RESEND v2 00/18] clk: imx: Switch the imx6 and imx7 to clk_hw
 based API
Thread-Index: AQHVFhnD3RH0i/2Cgk+sGoC+IpMb+g==
Date:   Wed, 29 May 2019 12:26:38 +0000
Message-ID: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3b61161-3443-419e-d6a9-08d6e430e62c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6049;
x-ms-traffictypediagnostic: AM0PR04MB6049:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB6049D7ADC92066999155BD4EF61F0@AM0PR04MB6049.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(6436002)(476003)(73956011)(53936002)(486006)(76116006)(186003)(5660300002)(102836004)(66446008)(66476007)(66946007)(26005)(44832011)(64756008)(36756003)(91956017)(66556008)(8936002)(966005)(2616005)(66066001)(99286004)(256004)(6116002)(6512007)(498600001)(3846002)(6306002)(68736007)(305945005)(81156014)(81166006)(6486002)(6506007)(54906003)(110136005)(2906002)(7736002)(8676002)(14454004)(86362001)(71190400001)(71200400001)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6049;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C5P12dYUaQXQkWvxkwqWYLRx8Hpg/f5tHM1t8iKtU2yz2pmY+ly08AiIca7D582oOPOlSrZXgeGvGdMJL1qTTj8OjSDllVIzBmnk5wZETrYfo5WzDma6RevvHWSsAX3VodNHYmRBO87VetsuGd2V0nuuL1sax5k2E39vR8AKt1p0i3u4YiNmdQtBU8NzeTiQ9VxRXUqZUtPhwYtA3/tWq8NSRXV2KQLqgFOPtodLPZyTm7abr6JnTjJap41mU04Qs/URXLiHO9yzIgSKsB0/TDlIoN1yswT4o5WlHOsuyi6tCNmjyUFiSdvU/lre3Eh/Y67+XQgcVFP+5oYq1SGVls+whslqgq8pNMtOtc1NKLEVqytQGdRnBG7mNbyI7s+P8CeleqXJwwplsDH8CLOAuOdZZI2EeOZWiJKlG5L9Ebk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b61161-3443-419e-d6a9-08d6e430e62c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:26:38.9925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend for the following:

https://lkml.org/lkml/2019/5/2/170

Abel Vesa (18):
  clk: imx: Add imx_obtain_fixed_clock clk_hw based variant
  clk: imx6sx: Do not reparent to unregistered IMX6SX_CLK_AXI
  clk: imx6q: Do not reparent uninitialized IMX6QDL_CLK_PERIPH2 clock
  clk: imx: clk-busy: Switch to clk_hw based API
  clk: imx: clk-cpu: Switch to clk_hw based API
  clk: imx: clk-gate2: Switch to clk_hw based API
  clk: imx: clk-pllv3: Switch to clk_hw based API
  clk: imx: clk-pfd: Switch to clk_hw based API
  clk: imx: clk-gate-exclusive: Switch to clk_hw based API
  clk: imx: clk-fixup-div: Switch to clk_hw based API
  clk: imx: clk-fixup-mux: Switch to clk_hw based API
  clk: imx: Switch wrappers to clk_hw based API
  clk: imx6q: Switch to clk_hw based API
  clk: imx6sl: Switch to clk_hw based API
  clk: imx6sx: Switch to clk_hw based API
  clk: imx6ul: Switch to clk_hw based API
  clk: imx7d: Switch to clk_hw based API
  clk: imx6sll: Switch to clk_hw based API

 drivers/clk/imx/clk-busy.c           |  30 +-
 drivers/clk/imx/clk-cpu.c            |  14 +-
 drivers/clk/imx/clk-fixup-div.c      |  15 +-
 drivers/clk/imx/clk-fixup-mux.c      |  15 +-
 drivers/clk/imx/clk-gate-exclusive.c |  17 +-
 drivers/clk/imx/clk-gate2.c          |  14 +-
 drivers/clk/imx/clk-imx6q.c          | 767 ++++++++++++++-------------
 drivers/clk/imx/clk-imx6sl.c         | 404 +++++++-------
 drivers/clk/imx/clk-imx6sll.c        | 430 +++++++--------
 drivers/clk/imx/clk-imx6sx.c         | 656 +++++++++++------------
 drivers/clk/imx/clk-imx6ul.c         | 574 ++++++++++----------
 drivers/clk/imx/clk-imx7d.c          | 983 ++++++++++++++++++-------------=
----
 drivers/clk/imx/clk-pfd.c            |  14 +-
 drivers/clk/imx/clk-pllv3.c          |  14 +-
 drivers/clk/imx/clk.c                |  11 +
 drivers/clk/imx/clk.h                | 142 +++--
 16 files changed, 2151 insertions(+), 1949 deletions(-)

--=20
2.7.4
