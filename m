Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71CFC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B3E218E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iMdfx5CE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbfDAE7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:59:35 -0400
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:24453
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731389AbfDAE7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzgsqGrATEADI5EwdUemVXE8tc3Nrh7wpxFyCPmLvvM=;
 b=iMdfx5CEUkXoF+ztBailKK0unaB9FEoaygIl5yazBapEk/PMuURfFFZXNsBV9mlkDy0Viu+Je7prJmaQh6xGr0xb2HklV0Hj8rnNxMYTvx++2JSXSAkMoNE6TkVwfrYvCL52ooWabCX1sxHyOgWKMnuDDFlDljZn+9yhJ/2KM38=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 04:59:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 04:59:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 3/3] nvmem: imx-iim: use devm_platform_ioremap_resource() to
 simplify code
Thread-Topic: [PATCH 3/3] nvmem: imx-iim: use devm_platform_ioremap_resource()
 to simplify code
Thread-Index: AQHU6EevII7fUUvJ3Uyk5OFLeKX0pA==
Date:   Mon, 1 Apr 2019 04:59:28 +0000
Message-ID: <1554094479-14596-3-git-send-email-Anson.Huang@nxp.com>
References: <1554094479-14596-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554094479-14596-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:203:72::36) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c260fee-62a2-4ec4-8566-08d6b65ed1e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-microsoft-antispam-prvs: <DB3PR0402MB3850EE6A07E7F2E6C5587F93F5550@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(386003)(6506007)(86362001)(476003)(256004)(25786009)(81166006)(7736002)(305945005)(106356001)(66066001)(486006)(97736004)(68736007)(81156014)(36756003)(8936002)(4326008)(6512007)(50226002)(3846002)(53936002)(105586002)(8676002)(6116002)(52116002)(316002)(5660300002)(6486002)(99286004)(2906002)(2201001)(110136005)(6436002)(71200400001)(71190400001)(102836004)(2616005)(26005)(4744005)(2501003)(446003)(11346002)(14454004)(76176011)(186003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +7YT66b6mAlE2W+JOgEderexqjQLl2xGrXCWlcL56Wat7+80Kp+p+80IT1wEDtBT4+0Tn+9Jb+oYj+pu/ri+lj6tMezrx+ckw79hou56/P7CrHxFMT+fgpt3gdICIK5qB8gMoENbo7fRSW3Zm6Q/RB3sJgqA+sC6jhA8Gh44XnasNzKMlMltsadAu0YpTAkDpUiACBzjVfQZRXhgXdqHVqIm3AP8dJTKOBQIfqmDRxWohpe0R8HJomf8+PW0/vLqTqT4ma41vAcDGOSLN+0KMazcEYwKnMYQdmmWO+d6PHw1ViX9AoLiNbky7abKYT+RDpXDACjaFzREsRFqcbVawClrWIc3LMXhd1JQ62sc5EZrSAAbW+03GSG3BpF68ChaszzK2qJuajZxHeGIhbpZhit86vX+8AHUiUGurQDzGS4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c260fee-62a2-4ec4-8566-08d6b65ed1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 04:59:28.7890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/nvmem/imx-iim.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
index 6651e4c..3458229 100644
--- a/drivers/nvmem/imx-iim.c
+++ b/drivers/nvmem/imx-iim.c
@@ -104,7 +104,6 @@ static int imx_iim_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
 	struct device *dev =3D &pdev->dev;
-	struct resource *res;
 	struct iim_priv *iim;
 	struct nvmem_device *nvmem;
 	struct nvmem_config cfg =3D {};
@@ -114,8 +113,7 @@ static int imx_iim_probe(struct platform_device *pdev)
 	if (!iim)
 		return -ENOMEM;
=20
-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	iim->base =3D devm_ioremap_resource(dev, res);
+	iim->base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(iim->base))
 		return PTR_ERR(iim->base);
=20
--=20
2.7.4

