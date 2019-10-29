Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C974CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D102087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dsZ1ez2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbfJ2Nky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:40:54 -0400
Received: from mail-eopbgr40071.outbound.protection.outlook.com ([40.107.4.71]:19011
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726858AbfJ2Nkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:40:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vwkp0kWexsk0rXV7sJ0RNHEZDJ8gZ2vqVB0NuhLgOI9VqcOt5JccqEbLvY5tunzXKEm3MxSlnpmtQmWZ84BWQZEBKB0wJYWcLDqNswqSzJ6WokFXjSBNCp6eOmGmsnIrSZLqbXrCejZzGGhqrrZUPB+hYR4BPmJ4hwE0i7ypUHSf3j1c4xihGL7Hy6WRJ4/dcUg8cjO3EA3y9BYNYmaNggc3aIqbnbYr/jGaKdPptq0RZR892QZPkNBRb641/JW9NyUQrvoVTF8JY4cUFcMST0sJHhBZr4lX9kZVMo4ohKHk3jgmM7HbZMDBX2HkGlEyTX+k6q1u3gVUI765utC7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2rz1NoxA4+vOCtGEPejcq68LGCio5FWgTSW2U7aAC0=;
 b=QccjyHg1ft3wS5d64XPhRpfaVmyQSJqER7zMu+S7xqHSb1s4PEwHPJPri/RkHYjkhyS1OvabdpDBnNh/yPklLVF8P91x/Xj92CrPMwQ91MLj/p/9zFYgp+L34bKGpoeJffgleeJZ2lmC2Ah14SSe+l3tjaYK+VRfBMUSodoiB+5b5j/NPRIRqDBae98vBmXaieUAAK231L/3iQ6+5on/8VMWxMO8bnhB92+TwBPdZXk/JEsAwXrtxfLCrWGxmXZMX0rH6DvsyquyE3r6koBo8B7vUAB1BKwd/lXw8GU/+Tb4xw5+CITxyvQaAtXyIudwvEpX5Mq4hHN6b3IKWJ0KcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2rz1NoxA4+vOCtGEPejcq68LGCio5FWgTSW2U7aAC0=;
 b=dsZ1ez2rKyqbg35my8LEcGdsTnZNwTEnWeRUSaNfTZ+VAXbJi4uow7aassoWN5WtERtm1CJeL8dLe5ijqHF6xpYaKSzSPrAhmf1PLtHF76M8O+lyljFzGVF5Mk09LYi/wFVO1pIjT38SOik3PL0eyz8T2gu6kEOFxYJ/vYDs5dg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4177.eurprd04.prod.outlook.com (52.134.92.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Tue, 29 Oct 2019 13:40:49 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.023; Tue, 29 Oct 2019
 13:40:49 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
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
Subject: [PATCH 0/7] clk: imx: switch to clk_hw based API
Thread-Topic: [PATCH 0/7] clk: imx: switch to clk_hw based API
Thread-Index: AQHVjl55CLrCj3Q1sEiGZunySWSfBA==
Date:   Tue, 29 Oct 2019 13:40:49 +0000
Message-ID: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2bf4c910-9903-4817-8e0b-08d75c759b81
x-ms-traffictypediagnostic: AM0PR04MB4177:|AM0PR04MB4177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB41777AB555F4A9FE22CC326188610@AM0PR04MB4177.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(2501003)(6436002)(5660300002)(8676002)(25786009)(6116002)(44832011)(486006)(3846002)(81166006)(81156014)(476003)(256004)(71190400001)(6512007)(2201001)(86362001)(71200400001)(6486002)(36756003)(478600001)(14454004)(186003)(8936002)(66556008)(4744005)(66476007)(66066001)(6636002)(50226002)(316002)(66446008)(64756008)(66946007)(102836004)(6506007)(386003)(110136005)(4326008)(54906003)(305945005)(2616005)(52116002)(99286004)(2906002)(7736002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4177;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +mhsKYlmta4QC/ac2SWssjktwbNIzTxTm0pDKaE1s+Fov6KJ7f1F7k5QHVQi7kriJhS8npL2Z4cOzIrUNiPtXp77sqMvDjZebH0hisYhlKJGIG5wz3FHZtYX0yK11BwieJLI7215hBPuHjQ7kAtPLxOEhuDLBGmLs4HePhjI3CU+BipcbSFnr2wuTJSSnjTcv4Dk4yzKbrlQnlKwdQV+QZ0gzlrMJ1u8n9H1/UNX5uWpDaIJKofIATPPi4lbMnswh9WMFSMJK/7hmUJ6z1ld4jApmxJJU7jqEelG/n8XScCg9Ef1oCpVsdaj/Q4wE5pNmiLdXSame2iqERSZBchYoeo+T95Jc2g2kq6MsH2R0VBj5Hm/2V1o+OUk16PaN51rpu88FElahuhR6ZIO6wrTK5g3CCLdK9KehdQVFAZJXZVQo1RbhCr8Gl3K8GVh5KIG
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf4c910-9903-4817-8e0b-08d75c759b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 13:40:49.4957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VEs2sCABgvsBfnMNSPDUL+cpTwcHJ5+CyZMrlhxKDvakCw+mU17XMHxUairyv1SmnTBesKi73ocC4+3E3XmyKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

This is a preparation patch set to switch i.MX8MM/N/Q clk
driver to clk_hw based API.

There are some patches under reviewing for i.MX8M clk driver,
to avoid conflicts, so not include i.MX8M clk_hw patches in this
pach set.

The patch set covers the APIs used by i.MX8M clk driver.

Peng Fan (7):
  clk: imx: clk-pll14xx: Switch to clk_hw based API
  clk: imx: clk-composite-8m: Switch to clk_hw based API
  clk: imx: add imx_unregister_hw_clocks
  clk: imx: add hw API imx_clk_hw_mux2_flags
  clk: imx: frac-pll: Switch to clk_hw based API
  clk: imx: sccg-pll: Switch to clk_hw based API
  clk: imx: gate3: Switch to clk_hw based API

 drivers/clk/imx/clk-composite-8m.c |  4 +--
 drivers/clk/imx/clk-frac-pll.c     |  4 +--
 drivers/clk/imx/clk-pll14xx.c      | 22 ++++++++-----
 drivers/clk/imx/clk-sccg-pll.c     |  4 +--
 drivers/clk/imx/clk.c              |  8 +++++
 drivers/clk/imx/clk.h              | 67 ++++++++++++++++++++++++++++++----=
----
 6 files changed, 80 insertions(+), 29 deletions(-)

--=20
2.16.4

