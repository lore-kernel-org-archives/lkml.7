Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD00C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417802075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oQnfOhJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732733AbfC0CrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:47:11 -0400
Received: from mail-eopbgr140075.outbound.protection.outlook.com ([40.107.14.75]:52704
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727532AbfC0CrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hbg3foC/yowp2bJcbBIMVtNzDRCCuchdl3PJzaeZjEk=;
 b=oQnfOhJ/4WRiVSMdpv4aH1B+7m6AJK/hM83vKJLvQvJI6ngdJCJcKAJBHW5ryzFQHxPKJcSpEIHRW9oX66AtMxnwk3ddeVoBcLiX053aN9zMVk2tvbKYhGV1CJMeBOfXr6AzJhq6Bw3qnZ0/m3lXfCq2p1fpOMKRTRbiiT19TEU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3643.eurprd04.prod.outlook.com (52.134.66.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 02:47:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 02:47:06 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] input: keyboard: snvs: make sure irq is handled correctly
Thread-Topic: [PATCH] input: keyboard: snvs: make sure irq is handled
 correctly
Thread-Index: AQHU5Edd/2+nSp1pAUqjt9pZVWLgMA==
Date:   Wed, 27 Mar 2019 02:47:06 +0000
Message-ID: <1553654517-7810-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d2af989-8dfa-430e-0dfb-08d6b25e8015
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3643;
x-ms-traffictypediagnostic: DB3PR0402MB3643:
x-microsoft-antispam-prvs: <DB3PR0402MB3643263966DD1CB8F612AA0CF5580@DB3PR0402MB3643.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(366004)(189003)(199004)(99286004)(8676002)(6506007)(6436002)(81156014)(14454004)(102836004)(186003)(478600001)(386003)(5660300002)(305945005)(26005)(2616005)(316002)(81166006)(486006)(97736004)(2501003)(4326008)(71200400001)(71190400001)(52116002)(106356001)(36756003)(7736002)(14444005)(476003)(6512007)(25786009)(2906002)(256004)(3846002)(86362001)(8936002)(6116002)(53936002)(110136005)(50226002)(2201001)(68736007)(66066001)(6486002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3643;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xuwgKWVenKsVeB2VGUjda7+JndVKiPycHhvXDNV7KZEpUfovSPuG6DApFm0fveTd+NfMKebr4yfxrWcot6ofnpNw4AYfn5R7BUssMaMxgopOf4/1bRulyrmjuJ+w+NCxztjoy+tJQ5V8yJyZjLStFpVaMTS2pyRvUoG2+saJSFsUpR9IdBc+qM/cV4jAFL0EcKwAuOTEwMrLmtu7kzhqJFlS1do7v5vhSImxaPoMAaEG3Tfng5qGSxQ7j0xbRWtn9Yircr7bo3grBw/VgUuvVKRZciaWYHOvuRHvgprgnFnX6i1do7slMAdf5ApD4CAjzM8PS6ipS0CoJXqepqBQ1RPKAdX8f3eridueMZa+JGhrry1VyIs01rCQ0fe4OYu7nG/J2tk3K5uRgw50e55CQB8N0puu5937390gO3FqWtc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2af989-8dfa-430e-0dfb-08d6b25e8015
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 02:47:06.8769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3643
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SNVS IRQ is requested before necessary driver data initialized,
if there is a pending IRQ during driver probe phase, kernel
NULL pointer panic will occur in IRQ handler. To avoid such
scenario, need to move the IRQ request to after driver data
initialization done. This patch is inspired by NXP's internal
kernel tree.

Fixes: d3dc6e232215 ("input: keyboard: imx: add snvs power key driver")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/keyboard/snvs_pwrkey.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/=
snvs_pwrkey.c
index effb632..6ff41fd 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -148,15 +148,6 @@ static int imx_snvs_pwrkey_probe(struct platform_devic=
e *pdev)
 		return error;
 	}
=20
-	error =3D devm_request_irq(&pdev->dev, pdata->irq,
-			       imx_snvs_pwrkey_interrupt,
-			       0, pdev->name, pdev);
-
-	if (error) {
-		dev_err(&pdev->dev, "interrupt not available.\n");
-		return error;
-	}
-
 	error =3D input_register_device(input);
 	if (error < 0) {
 		dev_err(&pdev->dev, "failed to register input device\n");
@@ -166,6 +157,14 @@ static int imx_snvs_pwrkey_probe(struct platform_devic=
e *pdev)
 	pdata->input =3D input;
 	platform_set_drvdata(pdev, pdata);
=20
+	error =3D devm_request_irq(&pdev->dev, pdata->irq,
+				 imx_snvs_pwrkey_interrupt,
+				 0, pdev->name, pdev);
+	if (error) {
+		dev_err(&pdev->dev, "interrupt not available.\n");
+		return error;
+	}
+
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
=20
 	return 0;
--=20
2.7.4

