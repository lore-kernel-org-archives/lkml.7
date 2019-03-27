Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9B3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C5620693
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jjsVZAuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbfC0GHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:07:10 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:27559
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725613AbfC0GHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iJYIbmrnT583ospKU4CTyL/y2D6ddI6TmFpciroNXk=;
 b=jjsVZAuQjksappIjU3bzSvNeRHn6E8zrbrOQhsbM/klJedHURSkNTVIAa2GYrAtOVDR7vgKl3qGem4R+rh2Q3+78BsShWOOtOqNUNxvU8OQR+Uf5LiGQITulY7GVXpBpUvE6W5Jj++mH5x7wa9TjQilAC9eE2JiqYSIXNq7C/q0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3900.eurprd04.prod.outlook.com (52.134.71.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 27 Mar 2019 06:07:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 06:07:06 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2] input: keyboard: snvs: initialize necessary driver data
 before enabling IRQ
Thread-Topic: [PATCH V2] input: keyboard: snvs: initialize necessary driver
 data before enabling IRQ
Thread-Index: AQHU5GNN8W1L9gH3DEapcQ5xt6rW9A==
Date:   Wed, 27 Mar 2019 06:07:06 +0000
Message-ID: <1553666514-21505-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdb7fcb0-325e-4636-922a-08d6b27a700c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3900;
x-ms-traffictypediagnostic: DB3PR0402MB3900:
x-microsoft-antispam-prvs: <DB3PR0402MB3900041ECA85FD064D35BE45F5580@DB3PR0402MB3900.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(39860400002)(376002)(199004)(189003)(7736002)(68736007)(2906002)(8936002)(97736004)(81156014)(305945005)(14454004)(8676002)(81166006)(53936002)(6512007)(478600001)(2501003)(50226002)(6436002)(106356001)(4326008)(25786009)(105586002)(6486002)(36756003)(66066001)(316002)(5660300002)(99286004)(52116002)(6506007)(3846002)(6116002)(2201001)(110136005)(476003)(486006)(14444005)(256004)(186003)(86362001)(71190400001)(71200400001)(102836004)(2616005)(26005)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3900;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +qDcASEaua+8slafwi2hpY0SonZNcnO1MsuT7SQBC9rkeJqCJ1K7DW6eto6PytG72ThWN9Mz46MEhkr4jYbAbUFgTdTgTgK0o0UJHkxR5R+lc2wfidPX6Z32m0YiRiqyz0LdzkVatHiJwNu+0baZOQKRGvup4tb0T6I6K9xjLry0ZBwA5zXCiDv4VKQps1iawwTwlF4xsHnigabu0uZXowIit4ZPX6Sibg5P+c3VNQn0pby2+pl7Xq2+YoMApJRTsyhklcIJSOeG2GefHLluvjGG1zf1eYMO6oG78LwjTzVd9/lyOMKqjhnyJZ2R0Kzxb6fwMjgDTiaXOpUjfn0g/xRcZn1/a4Pqi7CqFUXIgcrH9UL2qwjNoXQ+cjGh7drxWnbFCz0IEE6mjk4zH9tYG1XuENRjwy5OlyNherBFo9o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb7fcb0-325e-4636-922a-08d6b27a700c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 06:07:06.0764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SNVS IRQ is requested before necessary driver data initialized,
if there is a pending IRQ during driver probe phase, kernel
NULL pointer panic will occur in IRQ handler. To avoid such
scenario, just initialize necessary driver data before enabling
IRQ. This patch is inspired by NXP's internal kernel tree.

Fixes: d3dc6e232215 ("input: keyboard: imx: add snvs power key driver")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- move the platform data initialization to before IRQ enable instead of mo=
ving the IRQ enable
	  to the end of probe function.
---
 drivers/input/keyboard/snvs_pwrkey.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/=
snvs_pwrkey.c
index effb632..4c67cf3 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -148,6 +148,9 @@ static int imx_snvs_pwrkey_probe(struct platform_device=
 *pdev)
 		return error;
 	}
=20
+	pdata->input =3D input;
+	platform_set_drvdata(pdev, pdata);
+
 	error =3D devm_request_irq(&pdev->dev, pdata->irq,
 			       imx_snvs_pwrkey_interrupt,
 			       0, pdev->name, pdev);
@@ -163,9 +166,6 @@ static int imx_snvs_pwrkey_probe(struct platform_device=
 *pdev)
 		return error;
 	}
=20
-	pdata->input =3D input;
-	platform_set_drvdata(pdev, pdata);
-
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
=20
 	return 0;
--=20
2.7.4

