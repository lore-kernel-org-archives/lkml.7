Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFFFCA9ED0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 02:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E1C21744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 02:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y+edlDWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfKDCwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 21:52:43 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:6309
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729144AbfKDCwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 21:52:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWHq5KYTgKHOzRJGBGsI5wksr5uxQq6mH+hTzD8EQwwDjAVIQqyf52zC6NEQbLNB2uvm+UpJGlIcQAi/EA4xl4PP5FFhMGAojDbvmDUc9qJDJ9t7ZGkAnVhRMD5abqWyP5DzdNUi+y7/Q5ccw/fO5Tnz259gB7VEv2g7xaipMblQgX/N9NI+g505wQ8TqXfS5xg4kCL/+PCbBW8ekky7+gz6GdHtJQq6ej2Qz6gHnSQfcSbiRNrv+dfey3Xyw/+pCOhSwIbu6jKWOos+UhlizrejItxIWeWHerfvoe71Z7y4Ausy5w8ZAMTktQVa2xSrpVbtPGJWCHWnDeAqj8xa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yizdctDLKKImuyCpcGUN9liYBNf8OPhUvDU9fc97O6I=;
 b=oDLfOdMz19z+pYNGjYcNDGShxjpH+wbIO0NCNzrPrVqiJ8KfnUu+pQ0U1bKS+vJ27ezrPtaPFnIIktg0B0cpwGSQ3+7qEZB8paD39IJUzM1NIFie4aaLRFEuvMtMt/BtuAj+DzFz5n/zcKur/5h9l3UhtZNklyY+xKGLtCQzTuktVTnQQOtLJfEAxQmqHmsilS/aul3LTP3vVeHFI/pyi3Eh8PmvdoqhorD+J6NaSD9U8BMmkybaHqmNkRlMTf3SKqvdK+/a7QA1SfKHSLFuuZkeQgqIJedA72CgzQx51dndeycAkdlX4gl52PM6Xg0qUMxc+r0fmG8h7tvol4/XTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yizdctDLKKImuyCpcGUN9liYBNf8OPhUvDU9fc97O6I=;
 b=Y+edlDWAw+BINoCiMK/pyqYHhdD0/JWEiNFtPMx4m+vwz9c/g4bT4CPWoCzXdWFMtaCm7mn0/eQ/dFUFPAbtd5+3dklqMDq6pEwWnMOZNhw1/GnIk1c0VKG6IzOKYdO6wJsAZbbErmFfGml0s3eqLNOlJ0NG9wdlhxvtAyZ6bmM=
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com (52.135.138.150) by
 DB7PR04MB3964.eurprd04.prod.outlook.com (52.134.107.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 02:52:38 +0000
Received: from DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c]) by DB7PR04MB4490.eurprd04.prod.outlook.com
 ([fe80::115f:1e4f:9ceb:2a2c%7]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 02:52:38 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] clk: imx: imx8m[x]: switch to clk_hw API
Thread-Topic: [PATCH 0/3] clk: imx: imx8m[x]: switch to clk_hw API
Thread-Index: AQHVkrrrq3+6RnKlx0SgOHFznmoebw==
Date:   Mon, 4 Nov 2019 02:52:38 +0000
Message-ID: <1572835730-1625-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::23) To DB7PR04MB4490.eurprd04.prod.outlook.com
 (2603:10a6:5:36::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc6ef916-138b-4095-d19f-08d760d20d4f
x-ms-traffictypediagnostic: DB7PR04MB3964:|DB7PR04MB3964:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB39640544E0F3A47104C5CB03887F0@DB7PR04MB3964.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(189003)(199004)(476003)(52116002)(2616005)(99286004)(6506007)(102836004)(386003)(26005)(6636002)(6116002)(3846002)(81156014)(8676002)(50226002)(8936002)(6486002)(66476007)(66556008)(256004)(186003)(486006)(44832011)(6512007)(6306002)(4326008)(2501003)(71190400001)(71200400001)(7736002)(966005)(36756003)(5660300002)(64756008)(66446008)(66946007)(4744005)(14454004)(6436002)(54906003)(110136005)(81166006)(316002)(86362001)(2201001)(66066001)(478600001)(25786009)(305945005)(2906002)(32563001)(15585785002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB3964;H:DB7PR04MB4490.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+TSyRPZH/27T2NZ1iU9kMWT+iiMI0bHxWjIML67rF3kL6KzSXRmGlnd1v7dmcOBC0WgzcAQrrLq7RNasglz93AEabMw3G1caw4P2H6gAaqk+akF6VqkBl8lrxWXRdXKpXgN/lR75GZnILWoaqtsZ0qIZdUGU7UWzmkI9yt7hORlmKzGK9G7A0kwS2s0i8SkNzPE+J/jGiI255FJ8ES7HU9RdoThtDYCjcMGoJBwEqBOq7K2WaDPbR713s1Qf8ifdRIMSO0oVI2LH+TXmfWOfVPG2Xz6MV9S+UKRBXUReUukn2pnKj63h73T6ew3AM35QuU0QO0W3BqyHcf/EjfeJhnFGCrMdElMAlQZ2uNdfZLXjiiHhraOop7L0O2XF5B5qBOXYxhZ+QJzsux4456ane6NGUu8+VK9/PtYdcM6h3E7zMsYGSR7KWjXyz32ImC9ljzJhn9A5A9uOB0hynKMcQdyFxK6UsJfn4huPi+cu3I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6ef916-138b-4095-d19f-08d760d20d4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 02:52:38.3855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OuTtEE8m54X5UI+vGEFTus12M523Sd/QVodz5FMNRlM4JULmNGTaSLsWXKhhk6GZIZj0Nsby4D+Q0UHVKKU5jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3964
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This patchset is to Switch i.MX8MN/M/Q clk driver to clk_hw
based API.

Based on imx/next branch, with [1][2] applied.

[1]  clk: imx: switch to clk_hw based API
     https://patchwork.kernel.org/cover/11217881/
[2]  clk: imx: imx8mq: fix sys3_pll_out_sels
     https://patchwork.kernel.org/patch/11214551/

Peng Fan (3):
  clk: imx: imx8mn: Switch to clk_hw based API
  clk: imx: imx8mm: Switch to clk_hw based API
  clk: imx: imx8mq: Switch to clk_hw based API

 drivers/clk/imx/clk-imx8mm.c | 550 +++++++++++++++++++++------------------=
--
 drivers/clk/imx/clk-imx8mn.c | 475 ++++++++++++++++++------------------
 drivers/clk/imx/clk-imx8mq.c | 569 ++++++++++++++++++++++-----------------=
----
 3 files changed, 817 insertions(+), 777 deletions(-)

--=20
2.16.4

