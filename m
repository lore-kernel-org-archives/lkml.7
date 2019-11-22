Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E34C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9571E20718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i4PvG4gS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbfKVKsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:48:20 -0500
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:16594
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729863AbfKVKsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:48:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STO0tRsDuDOJPhTR6LvDfpqyFGZ2S/9OpVyd0s4xYTkoUsRypkE+MOxxI/baPT6Worw7iub4855JVBuwiD6w9Pw4oyC9ROoTZ9pgvFcYxT0Mciwm98Ou34djUA+1VLN/Jf+ie5Uq3WN0DhzAmEBX0UT0N8R8mpX0Wq9nTU6gQO6N+rqZzqL2I6gktdMHVCqaxy3Soiz6b+2uER60Y4ibzBLtCNlykr1doHD2z3+rs2vaBmWiibTFLuD5nH5M5h40Fh+1G1HDt8AvGzuqmZHRF/GnYnSCPOlgsLAtUz6bHQUug/SV6Rr+6Pt6GRHhaWdrYg+WRmbFjZ0SKe94woWhgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=983v1Zvm0xIoi5pWYq0lCXT5tWHWKWUDSkM4VBAy0x0=;
 b=QmCobsPe1du6KkfDAzP9y3Qre7CXXOtLkkRnvWICn14ju+pmxS7jF/mkYjayLdWGPNiFObWRIP3HdjM/1boZM2qeVa7ms81WNJpZ2nSo6702QmPyJInwR+/w5tTdFPOgE5FBdvBClBedWSqBk8JsdtkOiwoIlzxPfMVV8Ieu01oCTaA9GCkxKDZBTVG/lC1LVEr+CvM6uqVZRt26EYCGloqFV7MfYvunF9zM454NbDBxmrbQVKHQ3tol84nixLcaY0meiFszdKR8/FKOHUs0D17EPnxGZp+8c2rk9WhkDpdtzH0oQ//AD2NZcIafGlgVenUayqEyycD/SlG/58yoFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=983v1Zvm0xIoi5pWYq0lCXT5tWHWKWUDSkM4VBAy0x0=;
 b=i4PvG4gS/nMqTL1KnWVOESSa4WIUxuO/4UC+MBJd9teA/DUy09CB/O4pNI4unXzQljeEtbjNqGqV60hKsCD/nVADtA31zmG7naHFWkNv5DmjsWDBbIy/NNXK9lz8iA8XIKTeY9R/d2KhDp95knezkXVbE2lQMKzr/Qrbx/++KvQ=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6961.eurprd04.prod.outlook.com (52.132.212.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 10:48:10 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 10:48:10 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Peng Fan <peng.fan@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 00/11] clk: imx: Trivial cleanups for clk_hw based API
Thread-Topic: [PATCH v2 00/11] clk: imx: Trivial cleanups for clk_hw based API
Thread-Index: AQHVoSJU0t6T90cIEU++/WtFksK10Q==
Date:   Fri, 22 Nov 2019 10:48:09 +0000
Message-ID: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0020.eurprd04.prod.outlook.com
 (2603:10a6:208:15::33) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b43db444-bb4a-400c-7669-08d76f397703
x-ms-traffictypediagnostic: AM0PR04MB6961:|AM0PR04MB6961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6961F0C7943283B3D39E7A34F6490@AM0PR04MB6961.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(186003)(44832011)(2616005)(52116002)(66446008)(64756008)(66556008)(66476007)(7736002)(478600001)(6636002)(36756003)(14444005)(5660300002)(6506007)(26005)(2906002)(86362001)(14454004)(102836004)(386003)(305945005)(25786009)(66946007)(256004)(110136005)(8936002)(50226002)(6116002)(316002)(99286004)(54906003)(81166006)(81156014)(8676002)(6436002)(6512007)(4326008)(71190400001)(3846002)(71200400001)(66066001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6961;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BETWZ7KmSdCP6blPgffWB9ULmR/RDFYLSW3KYQy6ZpXLprsF4aOBTHNF5VpDJ27bQC5VL2Vod1//z7+t6+LQQMRPxT5SMIgvI2+7NGL7EjbY2fixgDfX07d6JDSLIa4AZw0ozZY30+PDfQyDXr90fM6CvPs8VHPtBskg2x+HmoChzpnSsTSANjW6tJ7aZ7tkphpC0MgL4fD8UjRD7zt0wbyzQLvF/fn2xO6ps5daPVJJ4niFS8V0uO7Ocx4f6l1fFv/gMJESg59qWv6Wuzg91lRNjazfUMZruCqscoSa13oRSu8rOIXgBQy6aowQ/QW+cA33cnsIJRaW9vtasXzWr5mHhrB0p4z1ICLORvkdUkguLYewi91rxJaqYWUp+kIVsr3sIevfs3TLFVnqUPBqRVoFQs/5j1AUmxdfC4MOJIH9zeaWgt1dGT18riu3MDXd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43db444-bb4a-400c-7669-08d76f397703
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 10:48:09.9327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Sr1eouUP4uSqhf0WViNnDP/ZRje6FeD6ewf8iR8FYV6kF/1r+0q9qXoujdGIm4OHL7WU9AqT0gdu8o7H2Fn5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6961
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

Changes since v1:
 - added a patch that takes care of the register function handling when the
   clk based API helpers are used, as suggested by Leonard Crestez.
 - Renamed the SCCG to SSCG, as suggested by Leonard Crestez.

Abel Vesa (11):
  clk: imx: Add correct failure handling for clk based helpers
  clk: imx: Rename the SCCG to SSCG
  clk: imx: Replace all the clk based helpers with macros
  clk: imx: pllv1: Switch to clk_hw based API
  clk: imx: pllv2: Switch to clk_hw based API
  clk: imx: imx7ulp composite: Rename to show is clk_hw based
  clk: imx: Rename sccg and frac pll register to suggest clk_hw
  clk: imx: Rename the imx_clk_pllv4 to imply it's clk_hw based
  clk: imx: Rename the imx_clk_pfdv2 to imply it's clk_hw based
  clk: imx: Rename the imx_clk_divider_gate to imply it's clk_hw based
  clk: imx7up: Rename the clks to hws

 drivers/clk/imx/Makefile             |   2 +-
 drivers/clk/imx/clk-composite-7ulp.c |   2 +-
 drivers/clk/imx/clk-divider-gate.c   |   2 +-
 drivers/clk/imx/clk-frac-pll.c       |   7 +-
 drivers/clk/imx/clk-imx7ulp.c        | 182 ++++++------
 drivers/clk/imx/clk-imx8mq.c         |   6 +-
 drivers/clk/imx/clk-pfdv2.c          |   2 +-
 drivers/clk/imx/clk-pllv1.c          |  14 +-
 drivers/clk/imx/clk-pllv2.c          |  14 +-
 drivers/clk/imx/clk-pllv4.c          |   2 +-
 drivers/clk/imx/clk-sccg-pll.c       | 549 -------------------------------=
----
 drivers/clk/imx/clk-sscg-pll.c       | 549 +++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h                | 102 ++++---
 13 files changed, 724 insertions(+), 709 deletions(-)
 delete mode 100644 drivers/clk/imx/clk-sccg-pll.c
 create mode 100644 drivers/clk/imx/clk-sscg-pll.c

--=20
2.7.4

