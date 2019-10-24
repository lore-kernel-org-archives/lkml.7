Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66405CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3232A20679
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JcSLQqua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437217AbfJXC7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:59:31 -0400
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:56194
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390589AbfJXC7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:59:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cy9i2600yu0UxDre7zlEohnyQwcq5QFxuOAXAzVn5+UYuUlEVv6D0PYAImbMl1k1lBcNd8rmakwoO2M9bsEPMwQ5VS82jFi341dmblk85eAGLAu4htz8vYmOl8080BKbkxirAbi9gL3ux9lNVUXidqHPDXdW0dAZ7TxHL0dWAmYYEKvddf1USotqnQXg9K6GXBNgJvWU252QmQZxXzs/T4fiOfVhxebMboPiRqWKeQBWBulSfa8+k0UH9hp6iFi/wWZBOPu7lbuoydva3VLovhFHtWouytbuhuDThliQxF8Zo169IQlT++8QXxqhNqdr37Mqqm19Hx2wfF/IF48i8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cKfJ4NB//dX5j9IX+aiNdydpw0vImDIASWHDiZjjO0=;
 b=Mn2EWTG6p5/rKmTiN6ijQc4UEvdYTiUx03sMywq89wTqUV+jBfuaEdrwsUEnBryYjGTCNB6BPAt9cUkbDea5ohH8FCilfUd3C1jQePDx1s1K4lkpMfi1AeNtrS/RO0PZlibdKzmRMVPJ76eqzqkP4hK/MtMk00ji//TLC4Upx+OMlkYvLslcXUMQeUD7CkVmfWz0UZJ83ZGp5AJFAfba8HgHl6uzSG2m5aSEUyQ4ryIVO6vnL11T+PkNucxTmgH19BUtPT7f8mKrhViUWXiMmNF3MPs9Tt2rYlMoHgZNzV+X3Y9eaFp/kMODqOPzYakK59LPFUYvvg1mUXF8eFylNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cKfJ4NB//dX5j9IX+aiNdydpw0vImDIASWHDiZjjO0=;
 b=JcSLQqua8fGhxosmQO7lPLmvW5MEGrZnF2W7ziji+QYdbvWJhh39vewymuJXzoXLr7+yZyl984riNijTYfYahHhC5v4wDiF06RuDjdw//YPQ3bR48vdtrQCDCn/AAjui4WgW1eB9UTwZYy38yHYryBKvDMhZF20AJXpIW092r2s=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6609.eurprd04.prod.outlook.com (20.179.252.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Thu, 24 Oct 2019 02:59:27 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 02:59:27 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/3] clk: imx: imx6x: use imx_obtain_fixed_clk_hw
Thread-Topic: [PATCH V2 0/3] clk: imx: imx6x: use imx_obtain_fixed_clk_hw
Thread-Index: AQHVihcMCyVyBO8P90OFvE9yw3nYaA==
Date:   Thu, 24 Oct 2019 02:59:27 +0000
Message-ID: <1571885777-21662-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0081.apcprd04.prod.outlook.com
 (2603:1096:202:15::25) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68fb0353-7f99-4abc-ca2c-08d7582e2e7d
x-ms-traffictypediagnostic: AM0PR04MB6609:|AM0PR04MB6609:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB660926BD0CE1FA1ADA5B904F886A0@AM0PR04MB6609.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(199004)(189003)(305945005)(486006)(26005)(476003)(102836004)(2616005)(44832011)(52116002)(7736002)(6506007)(386003)(71190400001)(64756008)(71200400001)(66556008)(66446008)(66476007)(66946007)(316002)(186003)(54906003)(5660300002)(256004)(110136005)(86362001)(478600001)(99286004)(25786009)(14454004)(2501003)(4744005)(50226002)(2201001)(6436002)(6486002)(2906002)(8676002)(81156014)(81166006)(66066001)(6512007)(36756003)(8936002)(4326008)(6116002)(3846002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6609;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: llX0PxsWsIw5VvHnELZYPiBcEMlm6dF2qELCdoIF7VCXGXfbA/oAlfBdOIa0C31vSVw+2jV8vi5VUsuuK18ktBIWckDtX1UE+dJ9MEEkUvv3hvf/8/C5HIfemF+/CnhJ8R6UO1833oZJrsWSfWmaKu2TOrG5Ujruh0nHCEPmWnxtkz+p93KxmdKIjbmsLpPB6ypUIbCACMHOdzTPYbfwn9ER/D4w3zgYaYGZkUyH9dGsfYthummwgC/gwqkCn9YqJbKEU9oDF02ogrFMxRIXHJiTu8TNAUOPr9Uojy4FoQ8O2tv7o/08KdIGeTLEzGVYIsOvIJqNeMlF2LTKBB99ZKn8xccLOFPzNkbsOBV1FcetUcfAcMLWz6kow6akgugZKjBTeobl0wfsIpkINQllLMWTsjvhDg0waI2HPAjKwG/TSUvYvyX3hC0VGdwdL1TM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fb0353-7f99-4abc-ca2c-08d7582e2e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 02:59:27.1647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mhy7KhrBGIUYwwQalqj55WIsMuYrptiBTiYIW+03j0xegjQrTwavmun3EXTaggB5Zh+uh9/SaqVaO23w8hFxBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>


V2:
 Fix imx6ul build
 push botton early and forgot to add this fix.

This is to use imx_obtain_fixed_clk_hw to replace
__clk_get_hw(of_clk_get_by_name(node, "name")) to simplify code.

Peng Fan (3):
  clk: imx: imx6sll: use imx_obtain_fixed_clk_hw to simplify code
  clk: imx: imx6sx: use imx_obtain_fixed_clk_hw to simplify code
  clk: imx: imx6ul: use imx_obtain_fixed_clk_hw to simplify code

 drivers/clk/imx/clk-imx6sll.c |  8 ++++----
 drivers/clk/imx/clk-imx6sx.c  | 12 ++++++------
 drivers/clk/imx/clk-imx6ul.c  |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

--=20
2.16.4

