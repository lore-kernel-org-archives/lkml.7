Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6BAC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A302082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 09:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VY7p79J4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKSJEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 04:04:51 -0500
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:34368
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbfKSJEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 04:04:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9QzmFn8LMtgOiqWC7c4pyq+ES0GRtkpGZDOXxGUhzzAZvsk4IctZPaGHnnDCQJwOCnbl5BSxsjeDSt5+QjLXZfH2zJOefHX8qnhzz8z0A32fxigbw56s5kux8drKN8eZFnDKTecIelzX52ZZKvhev6Ouz0Oh82Iw56KxopuG5ilBeXzBSXJfecRj2zzFOGQ9BvhkG8R4Visju2Sg4NyteGioIeKa7ROW3OMWArGA1dgjTWI0oP+Ju2SEc87qGzq5O4jo767qqNv256XqRPH4/PsdwAuPiAysXqLeezB7MTC1Ba4dXLcdReITPwzM+yyIWy8F73JNkx4B4UG7+6f8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m24kf1mk+kO/yaNIo1CPGxMbwLKja/PQeg67t1Y05P4=;
 b=fYcfbhnoW10GS9EanJF7z7G+ShLMNGrXKhTbeN8P39L176WEULWw155cMTmfXiGmwGNiYC7UQMxFiPFjKOPp6d3yIr5wVO3ZagLQyvPyl1UgatTYvk/ebDVNMIvinmDIpsfqf0m71rTtpNmPHGLkcBMJ3Wd98rQMmWb7fPyConOY9FmE/cTw5zkH9MtsaST/dYJOeig+r7ACU/JpT902MI97Iy2cV+v5XOXczBUHP+Wri18hSwmLO/M20mDk9mkccZzlVkqvHqKly6tw4tTbbq3vRl4gXCXdC45XhNGBJhjjmWSj26yjxgH/Ud1c/PFI6ddCbvjxJ0AwIOTaCnZEBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m24kf1mk+kO/yaNIo1CPGxMbwLKja/PQeg67t1Y05P4=;
 b=VY7p79J4CmDPH1g+QeWaD2XwBi0p4FGzLUCNfAZdn02zDAYKgn0XqGmQz2Uv5l4tdvF0lg/DbAfgNut9+gNXE2qqGB/srcgmE4WMIlZSzR8kHU1/UrzFMKhgUvqTVdPRs5LgsVSbxB9WBqFQx/Z3AuzWSuKrOIThaCAkZuIidwI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4259.eurprd04.prod.outlook.com (52.134.126.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Tue, 19 Nov 2019 09:04:46 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 09:04:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/4] clk: imx: imx8m[x]: switch to clk_hw API
Thread-Topic: [PATCH V3 0/4] clk: imx: imx8m[x]: switch to clk_hw API
Thread-Index: AQHVnrhjSBoXgoVf/UaxtVvL2YWuSA==
Date:   Tue, 19 Nov 2019 09:04:46 +0000
Message-ID: <1574154146-8818-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:203:52::16) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd68e53c-5f5d-4dab-4b6c-08d76ccf8635
x-ms-traffictypediagnostic: AM0PR04MB4259:|AM0PR04MB4259:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB42593B47D8219A6C5E12DCDA884C0@AM0PR04MB4259.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(486006)(54906003)(6306002)(36756003)(6512007)(6486002)(52116002)(6506007)(2201001)(64756008)(66556008)(66476007)(476003)(66446008)(386003)(25786009)(50226002)(2501003)(110136005)(4326008)(2906002)(316002)(6116002)(3846002)(44832011)(8936002)(6436002)(66066001)(71190400001)(71200400001)(99286004)(256004)(14444005)(186003)(14454004)(305945005)(86362001)(966005)(7736002)(2616005)(478600001)(5660300002)(8676002)(81166006)(81156014)(6636002)(102836004)(66946007)(26005)(32563001)(15585785002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4259;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y3FEvRdQunUd1hBmF5RuvVWFx5kuty2ZhTOlrZqMilzqJtK4Uc1V1+y/yUAaJT/r0HEVMTke2XHtMkFbCF2HWxWTz8oZKq49eR6iU+xJDPFDiaOiKBLjzOeixEtCjTkH7+5peu14w9f8DkDy7xpPG6o71AdJa5md/ySrwtQuARzYXC6vonYL0elJLCLGp5QAcKLs15HO0ggAJRg07EQalaTJNpk7GAYhiTQS9SW2dDrO9ygFTlEYSmIEMEW7+VKc7hj45OBupkXg8xxaWNkwknW/N9HN5wxC0yy1wrFi1N9dOoSNWQW3rbcOq7GnRMl03ag4fQ2SSKBkU2rsCtAfD9Bmt2/5QGWh91FEYtaSdNKbSsdieXU09l0U8rHCdFT+Cjkgfk0fJgBebeDIv8PU6snSxzyHRW08dIUH6Y+C8WzkP4Yrf1siKxBMPsbxA+JYnQBQBcY3aD8bVTqIlX7TAO+E9O5EltCLlvCWrPod6xA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd68e53c-5f5d-4dab-4b6c-08d76ccf8635
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 09:04:46.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M54m28aseHK4A9VmCBGd1HkWFiTcakxkofmT9mmc0fK7NmXQA41fKMHqIzLXgG/tFjqRswYfJoTf/pACILkRYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 Rebased to linux-next to avoid conflict, not based on shawn's clk/imx
 correct a few pll of imx8mn to imx_pll1443x_pll per Leonard's comments
 add Abel's R-b tag

V2:
 Add a new patch patch 1/4 to avoid build warning for arm64
 clk: imx: Remove __init for imx_obtain_fixed_clk_hw() API
 https://patchwork.kernel.org/cover/11224933/

This patchset is to Switch i.MX8MN/M/Q clk driver to clk_hw
based API.

Based on linux-next branch, with [1] applied.

[1]  clk: imx: switch to clk_hw based API
     https://patchwork.kernel.org/cover/11217881/

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

