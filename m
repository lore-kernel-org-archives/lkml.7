Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479C3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0AFC206DC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 02:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s2eFMdhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfLCCcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 21:32:32 -0500
Received: from mail-eopbgr60078.outbound.protection.outlook.com ([40.107.6.78]:62368
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfLCCcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 21:32:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LamP8MiNuJHH/a2uAHdHgseyfFplV8AKjU6HAkvShZ3sF1PMx+KmPKl9eQ7BWVEg7kZwVE0CnVRoQSJWE7XkZRxFJP0cD7batjO2Xx9/vCjU7bXFfX1JrbUxM1aKWSGNyVoI0YgmxN/eV1zYwwh9R80tUpPR6uhchURO1oRFFfmTeO2hL75A+VIHxVjyB5kMwpgBpZwY00iazkbCA6sofitpDgYR+vvmQz5FVE9twYqFDSSSrVdJTAgU1E58l//hoxnZCjQ4M5sHp7BOvsRuOh2vD5ijdRxAcyLxkkry1r9j3Ymowt7b8seAdjoarViKXy7SuYywXDUup15NmKDs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3D1TW5QcPIxfp6193c5nZsIwl84BW5u/Jdq9abmPRMo=;
 b=d5WHUdo/yFrNONKghe3Hg+NVeaitgG4iCocJub9G/uX8BNiLEwT7uY4z723dJrjGcYMafJXxlL8n5HmhMfEEo6SCMsx6OQJBAd6JqvOI2DXzJLt2IHslAbZTPoZ7GodUrNf+F6QZNdyh1N/2UFhePTLnwN8+DRbqVYgHuLpd3QhJ+xrUi/v06rXLpmZmmJeP5STQNZvPGEcsczU69IxvGviXcpggiX8vHzcp6v+jeCTl0Vm4NSEOaBd3xARyhWeObYRl5itoSpRy79ahyimpPKRezq7aikWIQN5vJwRPac+hpnbSbaP1FvmN4VSfCecKRjCnkCHLJk9n8CmqiMvvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3D1TW5QcPIxfp6193c5nZsIwl84BW5u/Jdq9abmPRMo=;
 b=s2eFMdhy07WCq/9x3DSdw401MysS8Y+SMU4NeQVP9XSK4LUadXJEbniID/9a8A8QPZ4F1tjFCNt4WsEUQ39HrO9p5ikDtEojfDxDjEe6pqLlY1o9jZjPIfTYRb210Dqmdm+Q+RuMKmGmLfhuHXYzuDWfBh23A8FVX0Mm4qgONSo=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4691.eurprd04.prod.outlook.com (20.176.214.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Tue, 3 Dec 2019 02:32:29 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 02:32:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] nvmem: imx: scu: fix write SIP
Thread-Topic: [PATCH] nvmem: imx: scu: fix write SIP
Thread-Index: AQHVqYHoZrnIZ3I0wkeIFm0IrQxq7g==
Date:   Tue, 3 Dec 2019 02:32:29 +0000
Message-ID: <1575340217-1402-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7336d812-9b3e-4a04-9e5d-08d777990a9d
x-ms-traffictypediagnostic: AM0PR04MB4691:|AM0PR04MB4691:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB469181E92F20FB7659EC6B7E88420@AM0PR04MB4691.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(102836004)(81166006)(81156014)(6512007)(71190400001)(71200400001)(86362001)(50226002)(5660300002)(6436002)(4744005)(14454004)(6486002)(99286004)(66446008)(64756008)(66556008)(66476007)(66946007)(26005)(8676002)(2501003)(2906002)(6506007)(386003)(44832011)(25786009)(66066001)(2201001)(478600001)(305945005)(316002)(7736002)(4326008)(2616005)(36756003)(6116002)(110136005)(3846002)(54906003)(8936002)(256004)(52116002)(186003)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4691;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MyJJmHmLtksq/5Sy0KP40smkJHhI5CFO/G8WzcUJRf4aGEQLqBEYVuTe/2FXegoLJ6tKouPO19Sgg3LvxIDZuNWt2IbNk5GFWLtVCZGtYqNtiGBFKL5bANgnP2itmt0FyICzXuOWbMm7yXtdV4lo4VDwl/iODyDjpv1AJxitlB6uvYIfDFYAgrGBMflv/vrsoFca+NZyxNuGHSCOb8uqgObnRBdxULS5uuP7XH+4l7C7gM35DNtyf1EJ4hnfq4ZXcMVk1KR7qdCZzkavfQSBgjVgX1/N+AmS1dqgLS500cjAs2msurVBrJT4LJ+gdWMOa46vZ5YOZ+Ycl4ibysImn5WeFmx1i94Kq0+p3G5SEBKLCdsHIdE7/er7ATe9DrO5WzBKf/viFGXaSKQEl0qGl9uRMwcC0w9OSVh2mwByTVq0RjCj2NmgUGnT3pbhVqE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7336d812-9b3e-4a04-9e5d-08d777990a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 02:32:29.2075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IaZFc2/s9ICoS2TrzjtvPjRdH0cdk000/I4//YvXCYGa5PgcEzCzVsSAqp298Z/+yIGgGJBsN/j/BW9T8IRkUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4691
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

SIP number 0xC200000A is for reading, 0xC200000B is for writing.
And the following two args for write are word index, data to write.

Fixes: 885ce72a09d0 ("nvmem: imx: scu: support write")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/imx-ocotp-scu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 03f1ab23ad51..455675dd8efe 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -15,8 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
=20
-#define IMX_SIP_OTP			0xC200000A
-#define IMX_SIP_OTP_WRITE		0x2
+#define IMX_SIP_OTP_WRITE		0xc200000B
=20
 enum ocotp_devtype {
 	IMX8QXP,
@@ -212,8 +211,7 @@ static int imx_scu_ocotp_write(void *context, unsigned =
int offset,
=20
 	mutex_lock(&scu_ocotp_mutex);
=20
-	arm_smccc_smc(IMX_SIP_OTP, IMX_SIP_OTP_WRITE, index, *buf,
-		      0, 0, 0, 0, &res);
+	arm_smccc_smc(IMX_SIP_OTP_WRITE, index, *buf, 0, 0, 0, 0, 0, &res);
=20
 	mutex_unlock(&scu_ocotp_mutex);
=20
--=20
2.16.4

