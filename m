Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5F3C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E86F20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BQU9Z4FD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfCEDiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:38:05 -0500
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:30382
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbfCEDiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sGnsRBR11as5w8QjMfK7m6wH02zar6x4YDWvQV1bm8=;
 b=BQU9Z4FDi1+isbgVU8JVtvGxzCQx4t9CrXVNARg2ZvlpTRP0l8n8VbfoZ6c6pP+9lzuQT7I1W4d994mqHkn/wNZMwhc6VyCpNAkXkrb/VdYSD7nQh0qc64WBeNgPKcAclxH6/9IjZVvjVYw9y+dOGe3bE0XbPbOYSRd9QOCsKBg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3737.eurprd04.prod.outlook.com (52.134.66.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Tue, 5 Mar 2019 03:38:00 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 03:38:00 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND V6 2/3] arm64: defconfig: add support for i.MX system
 controller watchdog
Thread-Topic: [PATCH RESEND V6 2/3] arm64: defconfig: add support for i.MX
 system controller watchdog
Thread-Index: AQHU0wTUhh6uDaARUUO9iQEawfTzbg==
Date:   Tue, 5 Mar 2019 03:38:00 +0000
Message-ID: <1551756791-31401-2-git-send-email-Anson.Huang@nxp.com>
References: <1551756791-31401-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551756791-31401-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0039.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50c0ce85-53e7-4e20-a6b7-08d6a11bf6cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3737;
x-ms-traffictypediagnostic: DB3PR0402MB3737:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3737;23:AQSWngkNrj/Ojic9RaXPLuokJRN7i3Vk2vqC+?=
 =?iso-8859-1?Q?8W9SByREBIgc9afkEPqK7iUMY6QztfVc6Ahyvjp8dS/MSqKhP6qVrGntIh?=
 =?iso-8859-1?Q?mIcPM+qGa3EdhakUiP0C3vp2XKPo8dM9v3k8YiSoPCp65agGuaysBRHErs?=
 =?iso-8859-1?Q?I+6qRrvMDUA/WLOo55UxFiWPNQDtBXIizepHxWk/TA+bYVCEHpQneN7NrZ?=
 =?iso-8859-1?Q?PkIrCHR/8S8Y7nNdWdbt4Ukb1h8rUhpjvRAqits/vrydNQc//FiQkFL1ZL?=
 =?iso-8859-1?Q?B9eVh9RWPmCnjlqLUiNehKH7X4HEWJDl2u49I4sa4HAkEWm5oj/K2HQOQZ?=
 =?iso-8859-1?Q?Jw7LaMm1Avczs4/gWEfV1lqjVTzu+uTFoGNtg6EpweyRYYNqRZVRvyzMgP?=
 =?iso-8859-1?Q?fiir4xX6eB3wOdXlxxsKF3CffiFlI9ZhVQHHDus/OTvvQ9738/eN+VY2c6?=
 =?iso-8859-1?Q?4aoowsBMa05/SmwkB25TY38qWz2heIusGltJ2D0xht6m/kxmv6fR61Gwuo?=
 =?iso-8859-1?Q?88WfIcp2PjfiNNOL/Bi2k6pEU/WMm3aVFe8SKCxfcO8WAnE9tumns7MTX9?=
 =?iso-8859-1?Q?pmUADqcMk+L0MJKHEr+S6aiebThBZwyrUthpnPcKGGiTvOCY28yrMyG46x?=
 =?iso-8859-1?Q?erCCRFNpZAtBoYxc71wC3EPg5m2cIdT3nnTcdvQOuzYYYBEGWvboFp4dpm?=
 =?iso-8859-1?Q?NVMlC9D6JxP5BFSXF5jcrTuMUdJnoCk+TRGIToUEpGmLk50Cvk9/KWsAoq?=
 =?iso-8859-1?Q?cizdCzot4gifOL1ZUv7ntqodQiMzyb99FpFcDdxpL8zzpBEQuCVO/cWw8h?=
 =?iso-8859-1?Q?WPht0DeAbZf5yXluPPuBiahy5usD74Prj8PfEckc+UKRTTsaz8ogCxUKaD?=
 =?iso-8859-1?Q?Pa4cRCvAri1ALcgbmGLnWJbgTexpFllByOAuDvy0s5ylEumNPISHDeuiUs?=
 =?iso-8859-1?Q?nfbrrEAS5+MWVZEvj65foj9s48TKBSbCkmRkgJtg6670ffuFrPjSxuT5pq?=
 =?iso-8859-1?Q?55r09vyuawBu8G0kz3UaSNi8RxDnk4DtXLbJ9i6b4WYWSb65nq6B4+v5bG?=
 =?iso-8859-1?Q?rWXQw1Piu3MjRqitxeMwVna4xXPzTlENd9jmncQx5Z0zhLIsEj6v11cM8X?=
 =?iso-8859-1?Q?dczSRaKbmnsojrarTmIHZ+wIuqZOOYkdAhvHonmmLvLy4ZgCoTula2B9ne?=
 =?iso-8859-1?Q?an8eXg/0Jt/cUBBEMKbekeLJ+HH24SJTHgnQLUcBVQZABvbKnr9NF/t3TN?=
 =?iso-8859-1?Q?BO0Sivvgq8oA2diEVljXDD7rsdxzCPtG1PhrsAW3irHn71EyiZsaMyizAs?=
 =?iso-8859-1?Q?e0f16Hi5p2sNHxmS0MajsJve1?=
x-microsoft-antispam-prvs: <DB3PR0402MB37372117029FCA7AADA96127F5720@DB3PR0402MB3737.eurprd04.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(52116002)(53936002)(8936002)(81156014)(71190400001)(476003)(2906002)(8676002)(81166006)(97736004)(6506007)(386003)(2616005)(50226002)(6512007)(486006)(106356001)(68736007)(76176011)(66066001)(105586002)(71200400001)(2501003)(7416002)(305945005)(11346002)(110136005)(446003)(99286004)(7736002)(25786009)(4326008)(186003)(26005)(4744005)(3846002)(36756003)(86362001)(5660300002)(6486002)(6436002)(102836004)(316002)(14454004)(478600001)(6116002)(256004)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3737;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bsa7jbv5+9dbvTzSeG8BJX6zKcE/yHnfYiHxwTinepZmXmNnIm8T0LeQTwolU9z+HO7jr8inUk5++vY9sRelB5dKCjqomPqaYEGB9rNqEkng/z0oPztGZoAvvPKUBvObXaLnOtxsfW9ZOR61W2A2QA+Bm+mjGl5CEDrE9s5Vs8lWHD+4WnVwksb3qVZCNrRZ6mTaXK8UUu1aeaEIxpmtH9ewoI6NGGD8hX45/V0tQjwmyei8bhXRM0d3pgK24uXW6e6uz7AoU4P72lQGOIxtUHST/40d5VxuQJ9SkzGHw0OVHp1cXNgDs8SQGauazXUiVkIQZXAv7HX3xRUy9F/FjFsYlA1H0hLFUUCqUy1vKNXaF8gcg5E2ymgQ+17qzb36WfJqQGOoKUULc3WTjf2cLGUFHhoSggNKTYB5RFUB1tQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c0ce85-53e7-4e20-a6b7-08d6a11bf6cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 03:38:00.1418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_IMX_SC_WDT as module to support i.MX system
controller watchdog.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes.
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c390..690f4ba 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -427,6 +427,7 @@ CONFIG_WATCHDOG=3Dy
 CONFIG_ARM_SP805_WATCHDOG=3Dy
 CONFIG_S3C2410_WATCHDOG=3Dy
 CONFIG_IMX2_WDT=3Dy
+CONFIG_IMX_SC_WDT=3Dm
 CONFIG_MESON_GXBB_WATCHDOG=3Dm
 CONFIG_MESON_WATCHDOG=3Dm
 CONFIG_RENESAS_WDT=3Dy
--=20
2.7.4

