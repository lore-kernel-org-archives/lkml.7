Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89719C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581EE20850
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Usy0fXtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfCVPhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:37:05 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:48507
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfCVPhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt5BlXPXoSYc+V4PDT+huR3wbEl90X2gGeir8yNeOe0=;
 b=Usy0fXtjF9ZQ/p9gr4Lqsmtono9IeGY4OLZ+ra5PIvdt1LVXoRL4UsbUxhGAdQwPMBaBzswJZ/CbqWWifrKGMhbZkennAEaYkl2fOGosYI6W55wESkCa5QRpGvL20Fa6pAO6vleLyMlX+PS13aHFP5cMznjhhc2vhv6wZbAT9Ng=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5636.eurprd04.prod.outlook.com (20.178.202.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Fri, 22 Mar 2019 15:37:00 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:00 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 00/19] clk: imx: Switch the imx6 and imx7 to clk_hw based API
Thread-Topic: [RFC 00/19] clk: imx: Switch the imx6 and imx7 to clk_hw based
 API
Thread-Index: AQHU4MUXcPbU/vcAG02E7jK3YSvT1Q==
Date:   Fri, 22 Mar 2019 15:37:00 +0000
Message-ID: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0170.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::24) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca05dcb3-206f-4ea8-bc24-08d6aedc3978
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5636;
x-ms-traffictypediagnostic: AM0PR04MB5636:
x-microsoft-antispam-prvs: <AM0PR04MB5636D78388D9B5FA71505348F6430@AM0PR04MB5636.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(106356001)(105586002)(54906003)(110136005)(316002)(52116002)(6512007)(81156014)(97736004)(53936002)(86362001)(81166006)(478600001)(8676002)(2906002)(14454004)(486006)(99286004)(36756003)(7736002)(71200400001)(44832011)(71190400001)(3846002)(5660300002)(386003)(4326008)(6116002)(6486002)(50226002)(14444005)(6506007)(66066001)(256004)(186003)(25786009)(68736007)(26005)(476003)(6436002)(2616005)(8936002)(102836004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5636;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rmlAg0NyCeeEb5xfr9HkhbZdjtyhF8YbdcY1IAwnIwJt8mGVVyWFvXANQQWYsAQcmBk9KNp3IQSpwwo7v8clycbvD1Kc7p5plK2jD/ZNCkXuYz0ioNAnnyhCeZqQJMcOJmGt8ZrH0qlJPK3TPQJ8TuWms54AdAnY2XGVgpWRVRBq3MF9fkDt419rOH1m71LMKJn1Y718POIOJyzgwf1r6aCEnCmA4mVAIS7XS7yfL69Z9iHVfrRuwQdx4X2Gro4tEeUCbgkL9xccvCjF3s5WDt4r9wcvOv8md1yptw86uo4cAWkV3aORTBNG4gOZEVzmwc4d8CugEP8Bnrpg5s7rAbdSJIS8CqdC6UlO0kGS53mbDr+H+Nlo5CNhjUAqkHWK64eK2eWa5/LzYz6vRaBwikLvMSu199RuY6tUlXgg0rc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca05dcb3-206f-4ea8-bc24-08d6aedc3978
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:00.2567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This work is part of the effort of switching the entire imx clock drivers
towards clk_hw based API. In order to do that, we have to keep the old
clk based API around in order not to break the older imx platforms.
For that, macros have been added that actually take the clk_hw based
registration functions and return a pointer to the clk rather
than the hw. These macros will go away once there are no more
users that need them.

I can't say I like the way the uart clocks prepare_enable/disable_unprepare
is done, but there is hardly another way around this without changing the
behavior, which is really the intention right here.

Abel Vesa (19):
  clk: imx: Remove unused imx_get_clk_hw_fixed
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
 drivers/clk/imx/clk-imx6sll.c        | 398 +++++++-------
 drivers/clk/imx/clk-imx6sx.c         | 656 +++++++++++------------
 drivers/clk/imx/clk-imx6ul.c         | 574 ++++++++++----------
 drivers/clk/imx/clk-imx7d.c          | 983 ++++++++++++++++++-------------=
----
 drivers/clk/imx/clk-pfd.c            |  14 +-
 drivers/clk/imx/clk-pllv3.c          |  14 +-
 drivers/clk/imx/clk.c                |  11 +
 drivers/clk/imx/clk.h                | 147 ++++--
 16 files changed, 2131 insertions(+), 1942 deletions(-)

--=20
2.7.4

