Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E653C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 03:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E1E206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 03:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bbhYumCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKNDiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 22:38:11 -0500
Received: from mail-eopbgr20074.outbound.protection.outlook.com ([40.107.2.74]:51039
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfKNDiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 22:38:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHH9/hi+I1gG81OJdl9dABpMhHow0E3Pkr9XlYebJ6c7oXDoEhcd4bfSWM4CU5QUFKqWUcD006pnSdqybAxLV7KlkNcQTBvRIipDI9Y7N4PdwdzX/Ods8rjb+AgEBn5N+S8mCZqh4cMqYDy3MfYyCWkU6lFQX5EuBJEVeudge6qb/iOZA3ITcMY9dWiTwHnCDaEqtfuCVECA2TOahfulHWFX+sv99Yc/GwenBcovsFGMvTAa1EsipOs1PVQ60n9+uEyoylTvrXhZrnbR6CYkKOFvlFJo8qhpyxKCF1AkivAd76mjyixwAaT/aPZ0+QBx4th0Y1zzBuSSGmu5PBb0gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVomEozqSvqXZnWTSTwyTSROuIgPQ59+N2d2854drf0=;
 b=nPr9P2Sw2DaFQ9unobpK9f78Fkmealk+xmtbrDMhYUYEWSkp22YTfJceGkvCIQbj3tlhQFwT+1teBshazGfmFSH6pzHOgnAQz+Uavv1P4DMzcrTPoBaZQ5dJCPDGYVYkpQFFOjZXV1M57FdCWuSQpepyA2x6z/d8do+GhZNVi7Apie81NupUKtU0emQ5cvzEZnBSilDv9b4jymVccy2L13VfU24k0tYpGpQij5esfBDdMsd5buv968Nl/TEA5a3yIr8ZZKwbO9XeUiBwZ3SM9lp2SyQPqvR+ScAxq8w1giOK3sT7qNZ2TN7gL8tSflw6y6l6CpYxPA0QgX9c1Sgx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVomEozqSvqXZnWTSTwyTSROuIgPQ59+N2d2854drf0=;
 b=bbhYumCF2dPwiPUkEqpZwgJn7yxasonSImNDxxyJ35lX2mfdj3tkCFVRQUFfZYqg3gWuq5w8vPkiWM/ECRxep7x/nL5iqugdKTQXB8QqseBWJFJ/Bfsmdp0BfxM1g7akrLtrWEeRDy9kht44tXom6KN96j16rCwOTWDvWN9EU/Q=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4994.eurprd04.prod.outlook.com (20.176.215.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Thu, 14 Nov 2019 03:38:07 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.024; Thu, 14 Nov 2019
 03:38:07 +0000
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
        "will@kernel.org" <will@kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/4] clk: imx: pll14/sccg use relaxed API
Thread-Topic: [PATCH V2 0/4] clk: imx: pll14/sccg use relaxed API
Thread-Index: AQHVmpztVPwy+EJUrkWokuVEwk9sYg==
Date:   Thu, 14 Nov 2019 03:38:07 +0000
Message-ID: <1573702559-2744-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0a0f223-7bbb-4f2b-2a04-08d768b40ff8
x-ms-traffictypediagnostic: AM0PR04MB4994:|AM0PR04MB4994:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4994A648A3A4B28ABBD23F0C88710@AM0PR04MB4994.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:247;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(66066001)(305945005)(14454004)(36756003)(71200400001)(71190400001)(4744005)(7736002)(2501003)(99286004)(4326008)(486006)(81156014)(81166006)(25786009)(86362001)(44832011)(2616005)(476003)(50226002)(8676002)(8936002)(52116002)(966005)(186003)(6306002)(478600001)(6506007)(386003)(6486002)(6512007)(6436002)(2201001)(102836004)(26005)(316002)(5660300002)(54906003)(110136005)(256004)(14444005)(3846002)(6116002)(66556008)(6636002)(66446008)(66946007)(64756008)(66476007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4994;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1AvxGqmLxWJNW8BjrbqgI86G5FtNm2+MvyyKZk1JuPVJA34pas35U1vVVgrwJwF6vmH6zv+FHaeOyfGNekVXwosVX/LnfJY6evvhPJBUJEHejp3crkCjykEkMEhCv8WqtneNlcbEbiNopUgScyCrrBiIXGvd4zprxvCJF3xrxIunm8kg24eWs4Q25EnqiZQL5dp+fQYFBUMwPrkUYG2WdPTtP+42X6bTjh0Fo3xpLglY5p2JU6xdaKtROB7K2AieK4KnfaL9lK+4ywXReh6uVrCeB8x359hO16i07Iuz77u3qJ1AjlrDBCc2v8W73f6vtzXX/v7lHfPpQWYWYv10Xet3vJzNo0W9bI2kwwzj3FNFAlJnAlm+fdtXkLh8c9Le7sw0GoCztx8fuNLQYt85WVZkQHkV8GE/UVJ47/PlY95BFHKiaBjld014Neb7JAZE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a0f223-7bbb-4f2b-2a04-08d768b40ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 03:38:07.1376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYaRJPDZDst1nUs5WxSrZcgyyI+fSJcV5BJh2/j7Mn5X16IIgLoyG0XArXyXpjC4UKRKK36RdpU60WiYkGAyxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4994
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 update commit message to reflect the change
 Merged sccg/composite-8m into one patchset

This patchset is insipred from Will Deacon's slide/video:
https://elinux.org/images/a/a8/Uh-oh-Its-IO-Ordering-Will-Deacon-Arm.pdf
https://www.youtube.com/watch?v=3Di6DayghhA8Q

Peng Fan (4):
  clk: imx: pll14xx: use writel_relaxed
  clk: imx: pll14xx: use readl to force write completed
  clk: imx: sccg: use relaxed io api
  clk: imx: composite-8m: use relaxed io api

 drivers/clk/imx/clk-composite-8m.c |  8 ++++----
 drivers/clk/imx/clk-pll14xx.c      |  8 +++++++-
 drivers/clk/imx/clk-sccg-pll.c     | 17 +++++++++--------
 3 files changed, 20 insertions(+), 13 deletions(-)

--=20
2.16.4

