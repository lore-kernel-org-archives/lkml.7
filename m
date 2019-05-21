Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48816C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111EE2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JqEn9Ind"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfEUJSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:18:51 -0400
Received: from mail-eopbgr70042.outbound.protection.outlook.com ([40.107.7.42]:11170
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbfEUJSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDXV9sd1Djn5Bn22Jgk3MQhJQzKn/iBzT41zZiefFs4=;
 b=JqEn9IndEqUJm5kH91/1OE6VyI2ZNoJBdZcvYacGQa02POMcWk8Eyd89Svzxhmy/lITl3aBQLZMmL8zuSMj1dOsJUKRMlJUAFn1tv5olBfQSBAuYFeWng2cxfyP8EB3nGXqumUIDwfottiOK5AxZcUemwpljWEqYhvsmCoh96kA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3836.eurprd04.prod.outlook.com (52.134.71.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 21 May 2019 09:18:46 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 09:18:46 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 2/2] soc: imx: soc-imx8: Correct return value of error handle
Thread-Topic: [PATCH 2/2] soc: imx: soc-imx8: Correct return value of error
 handle
Thread-Index: AQHVD7YxLwkXfUp5nUSx1qNWKadvJQ==
Date:   Tue, 21 May 2019 09:18:46 +0000
Message-ID: <1558430013-18346-2-git-send-email-Anson.Huang@nxp.com>
References: <1558430013-18346-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1558430013-18346-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:202:2::15) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b6409a7-796d-4d19-ba5d-08d6ddcd53ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3836;
x-ms-traffictypediagnostic: DB3PR0402MB3836:
x-microsoft-antispam-prvs: <DB3PR0402MB3836D7AFA6732262BD0F9A37F5070@DB3PR0402MB3836.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(4326008)(486006)(256004)(14454004)(26005)(81156014)(8676002)(81166006)(8936002)(6486002)(2201001)(2501003)(6436002)(6512007)(7736002)(86362001)(53936002)(3846002)(36756003)(25786009)(6116002)(71200400001)(71190400001)(5660300002)(66066001)(64756008)(66446008)(102836004)(50226002)(52116002)(76176011)(99286004)(2616005)(66556008)(66476007)(73956011)(66946007)(186003)(476003)(386003)(6506007)(478600001)(2906002)(305945005)(316002)(68736007)(446003)(110136005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3836;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z9jKLa+tBdDHKIBB8k6M/mKoU2nwYeLtEBMk7oaxflRAOyhSODIYHDqjnfCvjDnH/EwFcuVzWuU7fUv6/Te4/8xFAJz8hTP9Lda2VS1QcZu/Q9DjnQ5HWfuHeXekWyVXal9i5vdl+ECbuENypGnlR4SfQBfyn8MBadLHLh0zUQG/xfzE33Au5jerrMx9x4jbB9kd8O8e/xo6Enq0kH/Ij+SnISCp/pFcomH016tm/hmUlbTOZOB8VNHb1mrwVxC7T7WFTtX7cJq5qpqY4BKloqmm+I12e1LCFKXEDgKdrr9ZjIkb2Ho3GvE9T5C78iV6Ga+SfVZ11xPZ4z89xCYXIbOqVWkIZlS4uUm6tvbbNL3BJP9qwjT1HPlvSHclDwc625f8OL65Fgr4T7Rnp4xVnNqHszwBXp7cCNAfjAlYxPw=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4B919C90F1B2E04AA40C3C8EF9061E36@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6409a7-796d-4d19-ba5d-08d6ddcd53ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 09:18:46.8369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3836
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation of i.MX8 SoC driver returns -ENODEV
for all cases of error during initialization, this is incorrect.
This patch fixes them using correct return value according
to different errors.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/soc-imx8.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
index 944add2..9dd088f 100644
--- a/drivers/soc/imx/soc-imx8.c
+++ b/drivers/soc/imx/soc-imx8.c
@@ -73,7 +73,7 @@ static int __init imx8_soc_init(void)
=20
 	soc_dev_attr =3D kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
-		return -ENODEV;
+		return -ENOMEM;
=20
 	soc_dev_attr->family =3D "Freescale i.MX";
=20
@@ -83,8 +83,10 @@ static int __init imx8_soc_init(void)
 		goto free_soc;
=20
 	id =3D of_match_node(imx8_soc_match, root);
-	if (!id)
+	if (!id) {
+		ret =3D -ENODEV;
 		goto free_soc;
+	}
=20
 	data =3D id->data;
 	if (data) {
@@ -94,12 +96,16 @@ static int __init imx8_soc_init(void)
 	}
=20
 	soc_dev_attr->revision =3D imx8_revision(soc_rev);
-	if (!soc_dev_attr->revision)
+	if (!soc_dev_attr->revision) {
+		ret =3D -ENOMEM;
 		goto free_soc;
+	}
=20
 	soc_dev =3D soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev))
+	if (IS_ERR(soc_dev)) {
+		ret =3D PTR_ERR(soc_dev);
 		goto free_rev;
+	}
=20
 	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
 		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
@@ -113,6 +119,6 @@ static int __init imx8_soc_init(void)
 free_soc:
 	kfree(soc_dev_attr);
 	of_node_put(root);
-	return -ENODEV;
+	return ret;
 }
 device_initcall(imx8_soc_init);
--=20
2.7.4

