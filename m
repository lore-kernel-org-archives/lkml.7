Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE150CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 05:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51CC222CA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 05:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mvDTFO+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfKDFqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 00:46:06 -0500
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:2885
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726391AbfKDFqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 00:46:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/+ZXY2BDiIT4qN1EJkeIyeuOCqduoIi+xgGzMsSWlurN4zuSYFubthywXZLFcynwe77cnwVURlTjMtyJccDtW0yCouUpwAc5yvedSlWtJlBcdNhl00nC9jjCIAxbfFb+/uxfJ0BlG9YYSUjNT8ev58rovMQEXyo/rwsvyRjIXNyeXSkwauNyHz4az/LTdnUD55JFghi2Pg+ayxzbGL5GpLtWubOQEJ4atE2xa3jd/oYZMJFvkA0W1V8sbRCeALd2zLGlUkWbhHxsg3G259Mbq5ZjFOQaebKcwLaee+SbrRR+gYRG31Zy4JSGTo6j5k1+elA//zYKmc1Q+w94/iUFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIrWcMx7RwRi1aHg6dnGuGuh7s3vtfQuUXell/JUxHM=;
 b=dp/o0rd05nuNvkciMY76yxLQ5HyhWWDhuZeokWz0q+Q2wywgANLwbxj1QrCvyi8kpePoFz4DOoHexJHSSPRtWGy21jV6x3Y31DXLb0zC0VtlsVhAkQ6ny6XZWrW3d1TaaoQoAZ2+Y1Eux675h3KuQTE/zQfJJ2tIAbHJl04rFXRnIGJOCXNW5Sj1ZJTwTV+GXZ+LwL5stsy2iKSYpnWpjGgcCxu9tNANBbTW1I/g9WURxcjQa4KSxeWcPFn+iCM8VDdcAvytYK2fN3iUyHupkeaZ9cA8+3pHqZrvhMREezV/+ZS7ZrRApmj2yU0y4983JT/H4J4ZJRd5BddHJiMX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIrWcMx7RwRi1aHg6dnGuGuh7s3vtfQuUXell/JUxHM=;
 b=mvDTFO+/eMwz4rNnokrDV3sHPCK416vT8eXa/uOlQabCEA3fEBo4BnuVxyDW8W392ol3HtiN7Cnh/hMbHKZdzmkhMtjZ+JUEwCHkwgoUajtw0jrqElMr1ZXhAJbMNx2F2YI4h9zjXF2x88VAUXq3xOC3tzA2cB88NsVvLkB2xyw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6451.eurprd04.prod.outlook.com (20.179.252.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 05:46:02 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 05:46:02 +0000
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
Subject: [PATCH V2 0/4] clk: imx: imx8m[x]: switch to clk_hw API
Thread-Topic: [PATCH V2 0/4] clk: imx: imx8m[x]: switch to clk_hw API
Thread-Index: AQHVktMk8ePu9WQHCE2BNQEucqhFbw==
Date:   Mon, 4 Nov 2019 05:46:02 +0000
Message-ID: <1572846270-24375-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:203:b0::26) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf1a5e37-45b3-4556-8da7-08d760ea466e
x-ms-traffictypediagnostic: AM0PR04MB6451:|AM0PR04MB6451:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB645128D6F458C30FF41C8769887F0@AM0PR04MB6451.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(189003)(199004)(386003)(4744005)(6486002)(36756003)(66446008)(476003)(6512007)(2501003)(8676002)(2616005)(256004)(26005)(50226002)(316002)(6306002)(2201001)(6116002)(6636002)(3846002)(14454004)(6436002)(64756008)(66946007)(14444005)(71190400001)(71200400001)(66556008)(66476007)(478600001)(4326008)(966005)(2906002)(102836004)(86362001)(186003)(305945005)(7736002)(8936002)(25786009)(54906003)(66066001)(99286004)(486006)(44832011)(5660300002)(81156014)(81166006)(52116002)(110136005)(6506007)(32563001)(15585785002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6451;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x/ni+s8d/K0BoOAhxKjmp1HRtWIoyv7HwYaFK6V46B7umJovipA2JC3PQQUOS1N57+FSS4cGlq0JvFHefmBQE5R437HVcxO7qBQq7Doy6w14uzg6UPtng4J5IYzc4Ll6omg9o/yj80jhClJ5i0YHgDd5kkP+GJzyvAkQQcmGTUzbwEe+T/m0Jd7PYruL4XcNJOUVuuayrEcH0rRSnZITW9PEjM9+y8v9GK6d7KpHefDl3tIrFOHw6jUNRfZfRU3GWsYVXkS725YDaVJfgX9IRwQCFfRZ5s3oLyZjntGGMxG3wuIjYX/61R4uwP1P/5yZGQPKzRRtfOLr8o/o2aG2ngrdixO+s6qREBAIBjNkLnMx8BUVBtF4HSlCkVVkfilqvaV7OvTNXbDP6WmX/k21N8u6Bd7XaDC2queyGH1E9HKaLcsFxZss5L0JfjAVM5RAazOGYy65bbGE9lpNOjsnHXqCZYZkT6CCiEwzuUURpiI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1a5e37-45b3-4556-8da7-08d760ea466e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 05:46:02.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXXDZ9VBetRnbwOFIMpds/EhGC3GTD9JAbAwbPGUmqWDNH9C+4IuQs/1UTnw1K4wE4CUCTNhmFYeULfkCO8GSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>


V2:
 Add a new patch patch 1/4 to avoid build warning for arm64
 clk: imx: Remove __init for imx_obtain_fixed_clk_hw() API

This patchset is to Switch i.MX8MN/M/Q clk driver to clk_hw
based API.

Based on imx/next branch, with [1][2] applied.

[1]  clk: imx: switch to clk_hw based API
     https://patchwork.kernel.org/cover/11217881/
[2]  clk: imx: imx8mq: fix sys3_pll_out_sels
     https://patchwork.kernel.org/patch/11214551/

Peng Fan (4):
  clk: imx: Remove __init for imx_obtain_fixed_clk_hw() API
  clk: imx: imx8mn: Switch to clk_hw based API
  clk: imx: imx8mm: Switch to clk_hw based API
  clk: imx: imx8mq: Switch to clk_hw based API

 drivers/clk/imx/clk-imx8mm.c | 550 +++++++++++++++++++++------------------=
--
 drivers/clk/imx/clk-imx8mn.c | 475 ++++++++++++++++++------------------
 drivers/clk/imx/clk-imx8mq.c | 569 ++++++++++++++++++++++-----------------=
----
 drivers/clk/imx/clk.c        |   4 +-
 4 files changed, 819 insertions(+), 779 deletions(-)

--=20
2.16.4

