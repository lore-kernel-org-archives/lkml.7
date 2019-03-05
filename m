Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59174C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECCD2084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iyG6L1eE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfCEDia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:38:30 -0500
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:43527
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727110AbfCEDi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdpzLt4MNXzmXJjBIeMcWz5LgkvkuJb4eEeafpsDLR4=;
 b=iyG6L1eE0WcJiqC/pw6LsqvR9DPfYZ7mSFSzNCsLRCjZifiwTTspOLe4TaHFE1KupKNbuFtZ1fD/TX+XNvsJhLt//ImExgCELXrrA2ayO62v+ros0H0ib3lHJjk95jUM7Ap61Q1qBdrBGCy9BdOwV6zFdwUex4kugWO/iRWJvpA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3737.eurprd04.prod.outlook.com (52.134.66.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Tue, 5 Mar 2019 03:38:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 03:38:08 +0000
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
Subject: [PATCH RESEND V6 3/3] firmware: imx: imx-scu: register build-in child
 devices
Thread-Topic: [PATCH RESEND V6 3/3] firmware: imx: imx-scu: register build-in
 child devices
Thread-Index: AQHU0wTZDKVhNNFDtEeMtm93MUsCsw==
Date:   Tue, 5 Mar 2019 03:38:08 +0000
Message-ID: <1551756791-31401-3-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 5b249b9d-c1c8-456e-c0e0-08d6a11bfba4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3737;
x-ms-traffictypediagnostic: DB3PR0402MB3737:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3737;23:ZCMlhKUaBla1TStKIT4qb9UPMk8D606uAR3Q8?=
 =?iso-8859-1?Q?opKQ8huafca2JN3ZIba2oVLR7fzcyQ6Iwy1driBp/PdVYOP584jDEGV5OP?=
 =?iso-8859-1?Q?+vQO1TuXRmWiZsrf7KDnXaDfPfoIkv4FkYte3CiqeauoDDnDrDAlU3pByB?=
 =?iso-8859-1?Q?ZYj7vcVfs/9HcBiYMl0BUTyy9uQNHa4SCB67JUzrVWSNNBq5f1BVRHQvLj?=
 =?iso-8859-1?Q?aoCe+kjXbYxfGpMBnaLkN+LuGuaBAE/edNkeLppXI50ha+laaQO2088xMU?=
 =?iso-8859-1?Q?ZBDyeyTFfh3St6lX7IQZD9O7a4/qRlNgN23dkwh95XvTWeWHHecYUdJNMu?=
 =?iso-8859-1?Q?nzqtDtB+utGRaww/fJISNftX4czPNPALBcl9WUi7Gz877bRx+SGWqtuV/l?=
 =?iso-8859-1?Q?wM+jFnTfbGtRUQgVrilnxr1ZAq/vgrmIQ/bQ/anaMJWrucLRnTjvVzs34a?=
 =?iso-8859-1?Q?9RnY0o7XZfT0TcFXpRwqoYEtX7o2U7jyzUVwpsIAPlkTE2XnntQozDYGLH?=
 =?iso-8859-1?Q?sqfUX+WvK23ZQS4WEfcI2zBIDvH2UZHbYY7Hoqunv5s/xpXD3CbLXK0vES?=
 =?iso-8859-1?Q?uDzBmv3eF3pht15q2CphN2XsS6a30OkyWiQWfPDdAvzzeh16D+pXsu42Gk?=
 =?iso-8859-1?Q?UxlPmhhZ2bGUTDRSPC4NzSbNcCC4A2ESWAsxqQAgLg8YDh16z1QdlOpmEk?=
 =?iso-8859-1?Q?pNSD6eF41HQ+ab4tMgXFMW05Ts4FpPsVc9NJAizhwKM6oJOEwJFUny9sU8?=
 =?iso-8859-1?Q?bJ0Ioqr1R4E7rPfrwe4IY5UQktsSRyjbWwOhu63X2t5buw6ZbY9kquI6Qb?=
 =?iso-8859-1?Q?2WAZ7agq80agZnnJr+/SqdyCx+VnEovvwXPeAI1GO/Rcnp3LHyW+L5cSmg?=
 =?iso-8859-1?Q?McLaiSo4GhRqXAMqsLPD1GBn/rtcZQRumFZ0oej9U8Cug8MUHGqJC45roY?=
 =?iso-8859-1?Q?h0/8tAzfqDjLu9LHJThEpKPalRxAf9eQgYY/C/QZHuxgABKykg9KcXkipB?=
 =?iso-8859-1?Q?EyVNxpyIFzSeIc+D6FXS7TSCcssRmZrvN9mZl6QvXfa/YwB1TZFDtodxpt?=
 =?iso-8859-1?Q?s76PnpYgiuL9UmfISI97lgG3Mx3IWPF1lPnUTMIF1h6zjNcAMGLmpPpdfG?=
 =?iso-8859-1?Q?mwYTrVLLwzxfPczRC25IMgY9vEf7YHyBlxhs5jorGSP71jyqckDnTXBWzK?=
 =?iso-8859-1?Q?3IwWD8gIvTzs3KFZ4ov+AEFAy2PoptOuVkZJ6JTtEEU2tFEV0YDpspWy2d?=
 =?iso-8859-1?Q?WwNfbKD1+S6or5kRMBIy6YB2Fwdiq2r3Db9/4kyzs61pWFGoKXLksDBksK?=
 =?iso-8859-1?Q?kuZ4=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3737CB45016ACE9B98FA3977F5720@DB3PR0402MB3737.eurprd04.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(52116002)(53936002)(8936002)(81156014)(71190400001)(476003)(2906002)(8676002)(81166006)(97736004)(6506007)(386003)(2616005)(50226002)(6512007)(486006)(106356001)(68736007)(76176011)(66066001)(105586002)(71200400001)(2501003)(7416002)(305945005)(11346002)(110136005)(446003)(99286004)(7736002)(25786009)(4326008)(186003)(26005)(3846002)(36756003)(86362001)(5660300002)(6486002)(6436002)(102836004)(316002)(14454004)(478600001)(6116002)(256004)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3737;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: plk3j7ambsJAhd/1TR53mrUee34u4L5Gd0zvL0L1mvMnoA9yCjg8EZ5nMWcPWlW1Sb5NXt33j060BI3DxRPdnWnlmoA4QQ799fbh7+AjQCvJqHf5DnfyKB2u1Z/0vKNh7yKg6VBFP0h4Rhhbd6k74a8PDn503Rk90F+Qz1rE5zqi0VOcWkRioV9r3mq8MONjJaU3D/gtM+eNzA675N20YkNp0/sH//swaS8ef+kOaQe7jg9iFrmtKF7YOqoASdBKmg6HthEu4vVszLPWdcCheGmwZCh81gutcm7jgv64GLz476YsD6AWVPwqul6KcrWAx8Mqc9vESLI9YfcadT3cER5Fq4/lCLWB6trCq4JUQCTL5kJTdTSQ7kkNONHFjhX8K4qkVVGGyheOVHgF+CPs3WiVdVn1CVO53xvekDvaptQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b249b9d-c1c8-456e-c0e0-08d6a11bfba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 03:38:08.0183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some devices which are controlled by system controller,
they are NOT present in device tree since no hardware info
needed, just register these devices as children of SCU device.
This patch registers i.MX system controller watchdog platform
device as child device of SCU.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
New added patch, it is to register SCU build-in child devices what are NOT =
in device tree.
---
 drivers/firmware/imx/imx-scu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.=
c
index 2bb1a19..df75ead 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -196,6 +196,7 @@ EXPORT_SYMBOL(imx_scu_call_rpc);
=20
 static int imx_scu_probe(struct platform_device *pdev)
 {
+	struct platform_device *child_pdev;
 	struct device *dev =3D &pdev->dev;
 	struct imx_sc_ipc *sc_ipc;
 	struct imx_sc_chan *sc_chan;
@@ -248,6 +249,13 @@ static int imx_scu_probe(struct platform_device *pdev)
=20
 	dev_info(dev, "NXP i.MX SCU Initialized\n");
=20
+	/* register SCU child devices which are NOT in device tree */
+	child_pdev =3D platform_device_register_data(dev, "imx-sc-wdt",
+				PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(child_pdev))
+		dev_warn(dev, "failed to register scu watchdog device %ld!\n",
+			 PTR_ERR(child_pdev));
+
 	return devm_of_platform_populate(dev);
 }
=20
--=20
2.7.4

