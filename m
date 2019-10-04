Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0383C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD60222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="PbGcC81U";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="PbGcC81U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389217AbfJDOgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:36:40 -0400
Received: from mail-eopbgr50043.outbound.protection.outlook.com ([40.107.5.43]:48850
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389043AbfJDOgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK4ZcTaWUSRAjX0xe8+6lEgAOWI0bkyan77WyvE7Nwo=;
 b=PbGcC81UIqnELOaGaoq5oTb9ucYR3XFbFBAuz7SnVXkVisFMTqMTGEjPFn4TD6CAP0JUV0v9Dpqyvhq4iqfykfJb87uOTy6Tyt6axXq76+ZQUerRGss+tpseBuOh0VFQKUKdnRmc9dYTXbU2HEGrbum5v7iHkyW+8rL3b6YQhN0=
Received: from VI1PR08CA0170.eurprd08.prod.outlook.com (2603:10a6:800:d1::24)
 by AM5PR0801MB1891.eurprd08.prod.outlook.com (2603:10a6:203:4a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23; Fri, 4 Oct
 2019 14:34:54 +0000
Received: from VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by VI1PR08CA0170.outlook.office365.com
 (2603:10a6:800:d1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.20 via Frontend
 Transport; Fri, 4 Oct 2019 14:34:54 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT042.mail.protection.outlook.com (10.152.19.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Fri, 4 Oct 2019 14:34:53 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Fri, 04 Oct 2019 14:34:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0798540fbde5b4ef
X-CR-MTA-TID: 64aa7808
Received: from e28735ce9d3a.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.0.55])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 14D801F9-9CE1-413F-9B1E-3C7D8327D8A5.1;
        Fri, 04 Oct 2019 14:34:42 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01lp2055.outbound.protection.outlook.com [104.47.0.55])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e28735ce9d3a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 04 Oct 2019 14:34:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eoh65+Yw/SOSHXFMB0nANtTj7X7phw/0a7R+UGIul1Y3voyG1q1ItIfNhasUQH+Z3tjOAejREGt3HdR6lvvEC5dbDJTyL/SCDfjKXH651XDBfHhykOvPeJf7E4SIlYJdWKqQDS5ZBhhOwTp2g7d8uS3JLpNAZTMOaZfz58KemUkfLs2bCo/ug2NQ6VGHJryRVxrqEp+o/8z1sjzaBzUh/vCjDLQ/pK0KvHfEFhG26b5r8UhWNUgc9ot91D1vsx5UPdIDiSOwtERUI4NAgRAkB3SKbZlRtuabrtjVmCeIo2M40T7rNPdFh4ojIXzgUat36NTv/BsBWJGrt7ED5ss/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK4ZcTaWUSRAjX0xe8+6lEgAOWI0bkyan77WyvE7Nwo=;
 b=huCNw23ZqbBUP1lLa9cpb/ARdt/lRKwtvRXsElOd5cV3ZaIGPojsh6TDG6dyNybFh0ojUiP46EWKG+eDv+8YXmhRRvfUaFvdtJ3/FBntieAFwOqfFtwdytYOBCodrSLaZN8jkPlofvNfZkmS6I2EITkve7GVOgH7kJeYDvJigqdXIw4xNwhWb0dRFiZ22uaedAuJBJiEpOmmznw1NteX6lE1pnDrkBKW8vszVzf/xSH6sFyk3ifZ/PxDtlrq/NsDnkJ6aEZMAfLIHEPCKULOQbpaJpXPGr74KmKtlncMfFwgI+iOGBLInWPCDq1EWwWCYXv0WEbbqePO422kZsOcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK4ZcTaWUSRAjX0xe8+6lEgAOWI0bkyan77WyvE7Nwo=;
 b=PbGcC81UIqnELOaGaoq5oTb9ucYR3XFbFBAuz7SnVXkVisFMTqMTGEjPFn4TD6CAP0JUV0v9Dpqyvhq4iqfykfJb87uOTy6Tyt6axXq76+ZQUerRGss+tpseBuOh0VFQKUKdnRmc9dYTXbU2HEGrbum5v7iHkyW+8rL3b6YQhN0=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4288.eurprd08.prod.outlook.com (20.179.25.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 14:34:39 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 14:34:39 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] drm/komeda: Memory manage struct komeda_drv in
 probe/remove
Thread-Topic: [PATCH 2/3] drm/komeda: Memory manage struct komeda_drv in
 probe/remove
Thread-Index: AQHVesDatT7fIDs+C0WcvAQ2c1lXGQ==
Date:   Fri, 4 Oct 2019 14:34:39 +0000
Message-ID: <20191004143418.53039-3-mihail.atanassov@arm.com>
References: <20191004143418.53039-1-mihail.atanassov@arm.com>
In-Reply-To: <20191004143418.53039-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LNXP265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::13) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 4e7ab124-5362-47a5-12c4-08d748d80522
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB4288:|VI1PR08MB4288:|AM5PR0801MB1891:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB18911591A84DD7D7CBB082CD8F9E0@AM5PR0801MB1891.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:296;OLM:296;
x-forefront-prvs: 018093A9B5
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(199004)(189003)(1076003)(66066001)(14454004)(66556008)(102836004)(2906002)(5660300002)(478600001)(36756003)(76176011)(26005)(50226002)(3846002)(2501003)(6116002)(11346002)(66446008)(386003)(186003)(64756008)(6506007)(66476007)(8936002)(66946007)(2616005)(4326008)(256004)(44832011)(81166006)(6512007)(99286004)(486006)(6436002)(5640700003)(8676002)(6486002)(86362001)(25786009)(71190400001)(476003)(6916009)(7736002)(305945005)(71200400001)(446003)(2351001)(54906003)(316002)(52116002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4288;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: b5k7dmFBQ7V2Gg0Eey0+UbOOxONeoXqgpT9bskVPXBKYyGlTf6AOjsutW+4i0dA9AM2RB9vbzcj6Kss4zMaSaqRfhYV+/Pt2Ir+0yfqD2hAv14nTx2Rw0upHV0PMY9AwL6YjzgbjD13F28yiiBJflgIvKdeGhh0YctHag3xnXHWLugYW6MK7ZTx0a+LGD73VUMC9kCbrurz/fAQGZfQXMqpdbAn/H0QZYKFHq3kFCNO5MqCMFkOKXYdqGTkHGwPU19EAVyvg4QM1cIMnBtdnVDlk8gBmHofmTiJ67d88PBjZ2vOcnJwFl8vy5Kkbp04VefXz5Qyzhwirn5B9hSO3L8trJioPffQH8+IY6P8BUdN7bV0IbVNHkDT/QY5avgLWfGOsQhhXf8DiNKi6ABWltURNuFPzqO/AOh9h1D3Eb7g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4288
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(8746002)(2351001)(99286004)(76176011)(356004)(336012)(47776003)(86362001)(14454004)(66066001)(3846002)(2616005)(25786009)(4326008)(81156014)(8676002)(81166006)(476003)(126002)(486006)(2501003)(50226002)(8936002)(11346002)(76130400001)(2906002)(26826003)(63350400001)(1076003)(50466002)(6862004)(5660300002)(36756003)(446003)(305945005)(6116002)(478600001)(70206006)(7736002)(386003)(70586007)(36906005)(6506007)(6486002)(26005)(6512007)(5640700003)(54906003)(102836004)(23756003)(316002)(22756006)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1891;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8d42af8c-9711-46bb-beec-08d748d7fcc7
NoDisclaimer: True
X-Forefront-PRVS: 018093A9B5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q92jy7t+tv3jq2r7xjXYidlnkPkqjWwvkPuOK3NGt3mQLbe+U5xZZpabpPsDSmKJWz0yFmDPhj8QPSwEMcaPiChr9m2y2mT5Deo1D4PW4xLIY/2CbwKxZ5jSVSkeQ3pXS/AFAlYS27EuN43i2HjZlSXox050c2jaNMnoScO3fgyJqaet7/RbrQvQV9krmkhTbj/D1+6aPJ0MV83V0HBfKoOAPeMd7otTvuNkXUbKnWzTKMdy9Uy42n23+mXr6lDdosbqgVw/m/pfUAZTqE5141qsSFgQz5wwTyNcUetR31Aqhf1+2f+69sSp2s6QgZRRnwHohS4PQEiYwTvV9juB0W0HsTJG8z/TDk7tNwXIH/eEMKnoIrUP/PDnazGpL2a5uWLCaKqWG1WPA3ZP1KxVke896vvGWsLN+2Bf7Q0baGg=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2019 14:34:53.1348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7ab124-5362-47a5-12c4-08d748d80522
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1891
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fields of komeda_drv members will be useful very early
in probe code, so make sure an instance is available.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_drv.c   | 30 +++++++++++--------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index 660181bdc008..9ed25ffe0e22 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -32,22 +32,15 @@ static void komeda_unbind(struct device *dev)
 	if (!mdrv)
 		return;
=20
-	komeda_kms_fini(mdrv->kms);
-	komeda_dev_fini(mdrv->mdev);
-
-	dev_set_drvdata(dev, NULL);
-	devm_kfree(dev, mdrv);
+	komeda_kms_fini(&mdrv->kms);
+	komeda_dev_fini(&mdrv->mdev);
 }
=20
 static int komeda_bind(struct device *dev)
 {
-	struct komeda_drv *mdrv;
+	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
 	int err;
=20
-	mdrv =3D devm_kzalloc(dev, sizeof(*mdrv), GFP_KERNEL);
-	if (!mdrv)
-		return -ENOMEM;
-
 	err =3D komeda_dev_init(&mdrv->mdev, dev);
 	if (err)
 		goto free_mdrv;
@@ -56,8 +49,6 @@ static int komeda_bind(struct device *dev)
 	if (err)
 		goto fini_mdev;
=20
-	dev_set_drvdata(dev, mdrv);
-
 	return 0;
=20
 fini_mdev:
@@ -97,10 +88,15 @@ static int komeda_platform_probe(struct platform_device=
 *pdev)
 	struct device *dev =3D &pdev->dev;
 	struct component_match *match =3D NULL;
 	struct device_node *child;
+	struct komeda_drv *mdrv;
=20
 	if (!dev->of_node)
 		return -ENODEV;
=20
+	mdrv =3D devm_kzalloc(dev, sizeof(*mdrv), GFP_KERNEL);
+	if (!mdrv)
+		return -ENOMEM;
+
 	for_each_available_child_of_node(dev->of_node, child) {
 		if (of_node_cmp(child->name, "pipeline") !=3D 0)
 			continue;
@@ -110,12 +106,20 @@ static int komeda_platform_probe(struct platform_devi=
ce *pdev)
 		komeda_add_slave(dev, &match, child, KOMEDA_OF_PORT_OUTPUT, 1);
 	}
=20
+	dev_set_drvdata(dev, mdrv);
+
 	return component_master_add_with_match(dev, &komeda_master_ops, match);
 }
=20
 static int komeda_platform_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &komeda_master_ops);
+	struct device *dev =3D &pdev->dev;
+	struct komeda_drv *mdrv =3D dev_get_drvdata(dev);
+
+	component_master_del(dev, &komeda_master_ops);
+
+	dev_set_drvdata(dev, NULL);
+	devm_kfree(dev, mdrv);
 	return 0;
 }
=20
--=20
2.23.0

