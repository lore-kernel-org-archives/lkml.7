Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F3620828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="djsngroH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfCYDwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:52:42 -0400
Received: from mail-eopbgr20049.outbound.protection.outlook.com ([40.107.2.49]:28993
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729399AbfCYDwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GSfSCkAyEBJYAmp8lZ5Qn98Bh+kS/ZfRcmGqb712YU=;
 b=djsngroHtQhvM/jqg6JGy2Z9nBSdKjhIoWryKqJArf72UnP5Fke5H4tWBY5LbkT+VuwPcgs7B1HPbv+25iNJbZ5bi8OIFb5mk+dVCG0DbxUA6xZApR4TpMyjzNytVGlbCnDXMVHxZzIv49kdyHMzAyHR7J9HDtwoI7f3DWp24Z4=
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com (10.170.232.160) by
 VI1PR04MB6304.eurprd04.prod.outlook.com (20.179.28.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Mon, 25 Mar 2019 03:52:38 +0000
Received: from VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d]) by VI1PR04MB3247.eurprd04.prod.outlook.com
 ([fe80::8d98:21a4:2a84:3c1d%5]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 03:52:38 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>
Subject: [PATCH 0/4] This patchset is to remove PPCisms for QEIC
Thread-Topic: [PATCH 0/4] This patchset is to remove PPCisms for QEIC
Thread-Index: AQHU4r4wNeMNcba45kmDlEi7S+DdtQ==
Date:   Mon, 25 Mar 2019 03:52:38 +0000
Message-ID: <20190325035418.19065-1-qiang.zhao@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::36) To VI1PR04MB3247.eurprd04.prod.outlook.com
 (2603:10a6:802:11::32)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiang.zhao@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfd1f6de-a9df-40de-2906-08d6b0d5527b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6304;
x-ms-traffictypediagnostic: VI1PR04MB6304:
x-microsoft-antispam-prvs: <VI1PR04MB6304BDC295E94D9C588E27FE915E0@VI1PR04MB6304.eurprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(54534003)(6436002)(8676002)(2501003)(6486002)(81156014)(8936002)(81166006)(50226002)(316002)(4326008)(478600001)(305945005)(5660300002)(7736002)(3846002)(14454004)(6116002)(86362001)(2616005)(476003)(1076003)(110136005)(54906003)(66066001)(97736004)(256004)(14444005)(102836004)(53936002)(6506007)(486006)(386003)(71200400001)(26005)(2201001)(36756003)(6512007)(71190400001)(68736007)(25786009)(105586002)(99286004)(106356001)(44832011)(2906002)(52116002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6304;H:VI1PR04MB3247.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IXIzNTITqbtMguJPv383bRbnXH5Uz9FDTF+Ke9GlJJz1piGndoRl/5r8jC+qeU4eJhiYyXzU0G4Aq8vkBJ7mCf2OiymV4yeCvpfAv3SWOX+Rmmd7jXsJd2iuyS99r04gZik9ZNsnMlgrXfxFaGVXOberbv0WqycDigrV5iZV/3o70BN53dM2uGqgmwBNCTr9lf93MHARCRp32d+KSXeEdXl6QqQ+b7q1OFuSdn8AjBGxSoB7UM8rBu8tPN8L3Wa+1inBUFlbuzbLpQGdZz1s6Ux0kF3fqgVyuW4TTYPmJhyyNdRne3zNC8HF7ccyLOeWWbTOo1mXToTqU09Vp93WnG6VhAVC+pqV/BExg/FbxASTiD1rSpedxSbi/jUVd71Y0Gdp90AAf7pSk5H3g5VIBYiW1w5ZsdBCMj4B32xe+kQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd1f6de-a9df-40de-2906-08d6b0d5527b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 03:52:38.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6304
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QE is an IP block included in SoC of fsl PowerPC series and layerscape seri=
es,
its interrupt contoller was put under drivers/soc/fsl/qe, now move to drive=
r/irqchip.
And QEIC is supported more than just powerpc boards, so remove PPCisms.

changelog:
	Changes for v2:
		- modify the subject and commit msg
	Changes for v3:
		- merge .h file to .c, rename it with irq-qeic.c
	Changes for v4:
		- modify comments
	Changes for v5:
		- disable rename detection
	Changes for v6:
		- rebase
	Changes for v7:
		- na
	Changes for v8:
	- use IRQCHIP_DECLARE() instead of subsys_initcall in qeic driver
	- remove include/soc/fsl/qe/qe_ic.h
	Changes for v9:
	- rebase=20
	- fix the compile issue when apply the second patch, in fact, there was no=
 compile issue=20
	  when apply all the patches of this patchset
	Changes for v10:
	- simplify codes, remove duplicated codes=20
	Changes for v11:
	- rebase
	Changes for v12:
	Changes for v13:
	- rewrite single-bit constants to BIT(x) to make the code more readable
	Changes for v14:
	- rebase

Zhao Qiang (4):
  irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
  irqchip/qeic: merge qeic init code from platforms to a common
    function
  irqchip/qeic: merge qeic_of_init into qe_ic_init
  irqchip/qeic: remove PPCisms for QEIC

 MAINTAINERS                                        |    6 +
 arch/powerpc/platforms/83xx/km83xx.c               |    1 -
 arch/powerpc/platforms/83xx/misc.c                 |   16 -
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |    1 -
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |    1 -
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |    1 -
 arch/powerpc/platforms/83xx/mpc836x_rdk.c          |    1 -
 arch/powerpc/platforms/85xx/corenet_generic.c      |   10 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   15 -
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |   17 -
 arch/powerpc/platforms/85xx/twr_p102x.c            |   15 -
 drivers/irqchip/Makefile                           |    1 +
 drivers/{soc/fsl/qe/qe_ic.c =3D> irqchip/irq-qeic.c} |  423 ++++++++++----=
-----
 drivers/soc/fsl/qe/Makefile                        |    2 +-
 drivers/soc/fsl/qe/qe_ic.h                         |  103 -----
 include/soc/fsl/qe/qe_ic.h                         |  139 -------
 16 files changed, 231 insertions(+), 521 deletions(-)
 rename drivers/{soc/fsl/qe/qe_ic.c =3D> irqchip/irq-qeic.c} (53%)
 delete mode 100644 drivers/soc/fsl/qe/qe_ic.h
 delete mode 100644 include/soc/fsl/qe/qe_ic.h

