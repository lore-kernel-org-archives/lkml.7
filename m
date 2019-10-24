Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01341CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F3A2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HW+p14ZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437015AbfJXCap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:30:45 -0400
Received: from mail-eopbgr10058.outbound.protection.outlook.com ([40.107.1.58]:19429
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437004AbfJXCap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:30:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxcWD94SnfCYVf/CgR26cioo8LjmXfS/hRH7+OfxegMSkDmOPJbDY5Ol13i/EPASE2XeFJGzjGMAlqSWt54f0tlyr5K2Swos+sihnkHrZRWz9Ojs8PDLpVwSPc6JXt4OWazGB8FUiL2JUCwyuydIJzx2xo26xEvG51Oi7mVQT1WmcSfEthb3bhwcfS1cIDTTVOKb8LqecFv1driBPiOxwAREkj8fmlhsGjoCQAU3xel4/0P4kHPmuyX7XBPxZG+d8lFZ68/j1ed1Zz8wpx2SDA+h6nbyHAmgfEwqhLCDV99aHIVjRyKk4JdDDekfAJjZeQqv5vc3vKaWJ4TTXZ+DPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpUR/TJpA8vH0BJaKgkubRVaTuVale/Vr419kvfeZ9c=;
 b=DTvq6ZdTgIGiotxHNfLqsUad5nmbYHu+nVPkhw/W6D1d/2RiMYK70TXwhPfe8XXbLanlaMREo4afdSomy6EYm33bGhMmucg9XVcbjzJ7UENHDCJ1CpmAPDM3bmQvWdz7OPlkgKZ97D1y7R4iqW7oaWh9l7dlG1LZAEuasN46biDgSc0HJhiYb9BB5idIzNTGOPnYCQ0yZgba9uIlu/4SZL+tQyf81bh16Vf+3x5oXMlyJ03KGWqtORfLzrrn5XJ7l/4QP+P2PuJcHVr7mcT/uuoHVUTxFsU8p2lR8Oqj4FYPftWlOJGYMwFUK+yQIWd06bz4utmoQwMzWQE091eR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpUR/TJpA8vH0BJaKgkubRVaTuVale/Vr419kvfeZ9c=;
 b=HW+p14ZXu+JFbd1kFhnBOsz2pqY08OsdWS9+ziPVE4ShPC+Q3M5vzX98AS+3mL4j1ghOfTEncXpQle6Slagq4hR6M4LT3P6qF76H3TxbsszrgzpTACpJfY42wmr1UvDL+FIdv0UKhCMZGkyqdpo1Ok0R2YIh3P2h8ez3YIp11HY=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5315.eurprd04.prod.outlook.com (20.176.215.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Thu, 24 Oct 2019 02:30:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 02:30:41 +0000
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
Subject: [PATCH 0/3] clk: imx: imx6x: use imx_obtain_fixed_clk_hw
Thread-Topic: [PATCH 0/3] clk: imx: imx6x: use imx_obtain_fixed_clk_hw
Thread-Index: AQHVihMHWm1jS7cCrE+ghlbtE9L0Lw==
Date:   Thu, 24 Oct 2019 02:30:41 +0000
Message-ID: <1571884049-29263-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5865d33-ab57-4681-a5e6-08d7582a2a0d
x-ms-traffictypediagnostic: AM0PR04MB5315:|AM0PR04MB5315:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5315DA74AF9E822EDC134FA6886A0@AM0PR04MB5315.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(256004)(99286004)(6512007)(52116002)(3846002)(4326008)(476003)(8936002)(2906002)(5660300002)(6436002)(50226002)(6116002)(6506007)(486006)(7736002)(71190400001)(71200400001)(386003)(305945005)(4744005)(86362001)(81166006)(81156014)(2201001)(8676002)(66066001)(110136005)(26005)(6486002)(54906003)(2616005)(102836004)(478600001)(316002)(66446008)(2501003)(66556008)(66476007)(64756008)(44832011)(186003)(66946007)(25786009)(36756003)(14454004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5315;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tEhVrAMk2YTDH32Hqq8YV5zv47S/fMiofaIa/EiqoJ84qBJ0HTG4NE6N+Fn5F2LD5k71YA8MdAtgpSW+R3I7mxLUutM+XZuSAJyrBslbtpH3XlFcnaMYV5jRvAPv6gCS2KozOkx/k6xQB703aSdlZ50+rVXY8vb21IgfzBFD3avnBPlnbHKoEEEKy0zJT9Gn//BqeNaBsByqbz8Ou8X977EiTGVFyGScIRQlUC/t5acamz0LyqAbgGZXpkmfAPQ7mJOlwb/84hjKt80GcNmcHpaj/ArAcuIpXuku26lQdBu8JltIx4+uhCITsx8IJLfsurYdE80w06ZI4h7R+AmI3X2m5c9Sk5as760vamaPYi7zGCMmV1pHDmZFc82rHYQOYiU2jkry/YkUbP+20CsQO7FrgtjN47DnbC9hg/KhzWiOoMUukfNBTn+655l07Yyg
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5865d33-ab57-4681-a5e6-08d7582a2a0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 02:30:41.7470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ye0ujWp2WZJNmsRyna+wL+xBppzx+JOFFNXnnDisAF4grsPNmJSat3V48C8WbE1VofezWO4hVReM0Sd/BJNTgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

