Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7A8C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAD920838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Bqb7sEze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfHAN5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:57:41 -0400
Received: from mail-eopbgr130092.outbound.protection.outlook.com ([40.107.13.92]:50181
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730502AbfHAN5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:57:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjZLm3tneFPk+CTiR6oorPrFIILDF9G2R2xBOCaapFRXEt+cBEqERGElIZIULuzl/D0bZm/5JjQ0zPrUi0INfVIlcyYduPJJUaYguq8pDRsB0/r2GhCy5a/7oXnLFN3S4TZyCXk3D34va8z8ynxVm4uj2AbJpDQVTB+OqTpL7h0aaWhmDgt5Ct4x5ds93MqVo9Z1NaK4fIW5ng8oIFuLY1NuXe8Tw8/FvIi1YcssS5MTTbj+KzhQMGxtS8Xamc3y88RGVdB/oqZNAusE077bbAMc8OFpsOG1sTD7xl1j6fYVq8U/qtooV2RG2pwVFdzofFiYU61fhzPF5RK/7QK5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uacPuwfD4D0vwYGwIzPR2xUjPsBFEdjTOpLg33XsvS0=;
 b=R2bveurXWu6qbxBzj1TYp7OfWiSUhwBQc/QHdvmN5g6JiuvVT4U/suCO8vmGxpjKHDAz/WWS4ZBDUrD/+omK/C+vSTiqyMBVVeZx1+3KiW2/mNqU6AG1zadGk9g3K8I1wpewSn7IWEoJ9yXCRDH6K3QajgSQQpgzmqe1khDGw8q8bKaqC/0ykbmRoiyFMwr2/ORUppQWvXfh1+IknXt+ASfYbNmz0e35t3VB3N7dXHwqC5zVvf4ShZnh3uRL9C/2DNMr4g/0WwqeeD80ZjKEU2xsbpNXcmhgqm6OdgFgbfPx0AgYVwAibf2aqI5+r/atBEj7YiqgSLXJToQa6Xw7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=habana.ai;dmarc=pass action=none
 header.from=habana.ai;dkim=pass header.d=habana.ai;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uacPuwfD4D0vwYGwIzPR2xUjPsBFEdjTOpLg33XsvS0=;
 b=Bqb7sEzeLqfgti05V1Ep5KroMq0D4xvQe5sBeDSnpVqBd5eqOyZYrz6uQkqCJKnn5M8LtszWIHHegfP2j+C+X9otTMHJEZ/SWaqiTXrTzDNf3WSz7YUNJroBa5yOfJRjVRbFjJblG0G/TBTnfCyAqUdl+f7LmKHWsFWpHUWQWMM=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB5296.eurprd02.prod.outlook.com (20.178.81.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Thu, 1 Aug 2019 13:57:36 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::30b7:2c9a:9b15:f88f]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::30b7:2c9a:9b15:f88f%4]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 13:57:36 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] habanalabs: Avoid double free in error flow
Thread-Topic: [PATCH] habanalabs: Avoid double free in error flow
Thread-Index: AQHVSHESnMF5xI6k90aQZDGOYR1fbw==
Date:   Thu, 1 Aug 2019 13:57:36 +0000
Message-ID: <20190801135721.13211-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0009.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::21)
 To VI1PR02MB3054.eurprd02.prod.outlook.com (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4316656-4aa8-40ac-486e-08d716883527
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR02MB5296;
x-ms-traffictypediagnostic: VI1PR02MB5296:
x-microsoft-antispam-prvs: <VI1PR02MB529677C2D246ED8F84DC350AD2DE0@VI1PR02MB5296.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39840400004)(199004)(189003)(66446008)(66066001)(86362001)(14444005)(256004)(6486002)(66946007)(66476007)(66556008)(64756008)(186003)(305945005)(476003)(6916009)(6436002)(50226002)(6506007)(486006)(2351001)(386003)(2906002)(81166006)(81156014)(2616005)(7736002)(6116002)(3846002)(4326008)(478600001)(25786009)(8676002)(8936002)(68736007)(316002)(1361003)(6512007)(26005)(5660300002)(102836004)(53936002)(36756003)(52116002)(2501003)(1076003)(71200400001)(99286004)(5640700003)(14454004)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB5296;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VNaPGcxSnR1G7q0LPUAQiXqMuQm6kLvZxjGCAhXGSRHU25kghOHveB24kO/uJLussFdQtGj5dwCmW9/bEXvlfkTHfVe+VugiTwy2Kcobkn65/oiNx9WGWAg2Of1czhIihSPQvsh00Xcw076WEIBxJykRwZSjGvwvbLiB5sZXmIf1wMLfB/ITlv7L5LSrSUgzAdMPk9XK5mtB4PBXILVYg5HJ57EkxCVw3EjnRL00NaAXj9/H/HjmVn2GaTdCZZc7XKSgmpomopDZjlRly5+rF324m6Q38ykX2ontV5+8WcERw6ZCZemC9nRDJe2yvR5Mf2GmuRnqkzUcI/ZTJozEYV/NylAMguNZrLe+sjD5TReYAkbqaqJtOFd+Ix1VBDyOc+YWcUkLWAskIM/KxMmorQ7Z4ACOZSk9iiWNZXwlyP8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: e4316656-4aa8-40ac-486e-08d716883527
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 13:57:36.1723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttayar@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case kernel context init fails during device initialization, both
hl_ctx_put() and kfree() are called, ending with a double free of the
kernel context.
Calling kfree() is needed only when a failure happens between the
allocation of the kernel context and its initialization, so move it to
there and remove it from the error flow.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/device.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/dev=
ice.c
index 0c4894dd9c02..7a8f9d0b71b5 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -970,7 +970,8 @@ int hl_device_init(struct hl_device *hdev, struct class=
 *hclass)
 	rc =3D hl_ctx_init(hdev, hdev->kernel_ctx, true);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize kernel context\n");
-		goto free_ctx;
+		kfree(hdev->kernel_ctx);
+		goto mmu_fini;
 	}
=20
 	rc =3D hl_cb_pool_init(hdev);
@@ -1053,8 +1054,6 @@ int hl_device_init(struct hl_device *hdev, struct cla=
ss *hclass)
 	if (hl_ctx_put(hdev->kernel_ctx) !=3D 1)
 		dev_err(hdev->dev,
 			"kernel ctx is still alive on initialization failure\n");
-free_ctx:
-	kfree(hdev->kernel_ctx);
 mmu_fini:
 	hl_mmu_fini(hdev);
 eq_fini:
--=20
2.17.1

