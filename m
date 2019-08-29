Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5417C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEBC233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="LY2lBO7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfH2GtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 02:49:22 -0400
Received: from mail-eopbgr800084.outbound.protection.outlook.com ([40.107.80.84]:40853
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfH2GtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:49:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYSBFSHCY69uHVHU8xLWbEZ1eqNI5jJJNp6ak82LyOUFAn0DixBoAHxe20C6v5hknYyneA2ASPax2HVWhUEmoLyOdj6hEaeP9QCBM/aT6aP7pYB71dTax8t+uuu0kh7KA2tmvlvFUAPsnmR5UYRqKd5igfX0o/FNyfqLPqxRH6zNTY+927MNHQ4eFuhh3MPsGtPeq2yY8trxa4BDHDt0txVNgYwYElRMLhm9UwT0F7Wsi7uXOOONc7tLKFOxzBOLl2jPIuZn0/QW3s0wr0lhC6S2RJdRuxP5RZNyjZ/A0psQMnjUDLWmRjGgTGvcDV563sieP8eB35rmtprQoBY2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU0YooFKcoZOyYwCC3FFtMKb9zBGceGhm46W2qMFGyA=;
 b=Iy6p6Wcz9ZSjR5FWS52QXQni/Vli9IxZEuRvTgrFpdOojyHdO/E4OMDoh/GniDD7qhyQv/lQfFQDl9CksDjeqVyjqm6FhfVFTmD9jFn0SIqZ3pCUp4Uo/qo20SlsaJHVg+APasG6I27XEldSBRHOwV+bjDrwuMYXzfrJCfb2pyN0E3ggJn8MVjQflz+OII45LTlxfD8N61PbDLfLK5PANOu838QQRw729wHgbxb0/QZYZuXblXBLA7rv0W6Y2bMyOmnNoA9jJkvzpY0HFopYHxA9dbo4UNMMAaJiS638tMRg7ULblIJ2khd/C5SAl5KJd2weZL+3ZVQ2JRzhEIFkMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU0YooFKcoZOyYwCC3FFtMKb9zBGceGhm46W2qMFGyA=;
 b=LY2lBO7m/vBmNoz6hnveG08lu2Tf+yeSB0jQr6ICliiu8cKFiJFuIxXjfCVpMP8lSldXt6cQtYYSnDZb2ZaR328ahkpijPU91mRr57BhwQ9RgbWXw2eNrbRvnN2n3sVeL/+WYV/WcsRZDNN/hJWP1TTFfTJD5tSLw5eQjNgw2qE=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4824.namprd03.prod.outlook.com (20.179.93.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Thu, 29 Aug 2019 06:49:18 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::391b:4d0f:a377:41c]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::391b:4d0f:a377:41c%4]) with mapi id 15.20.2220.013; Thu, 29 Aug 2019
 06:49:18 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] regulator: sy8824x: use c++style for the comment block near
 SPDX
Thread-Topic: [PATCH] regulator: sy8824x: use c++style for the comment block
 near SPDX
Thread-Index: AQHVXjXh8gPA4ykd4EKAGYEdYQwA6g==
Date:   Thu, 29 Aug 2019 06:49:18 +0000
Message-ID: <20190829143749.4b42bc65@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::27) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d251345-02d0-4298-9975-08d72c4d03b6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4824;
x-ms-traffictypediagnostic: BYAPR03MB4824:
x-microsoft-antispam-prvs: <BYAPR03MB4824AA7C216B6D5A174332E0EDA20@BYAPR03MB4824.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-forefront-prvs: 0144B30E41
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(136003)(396003)(346002)(189003)(199004)(102836004)(386003)(6506007)(476003)(66946007)(64756008)(66556008)(66476007)(186003)(66446008)(1076003)(26005)(14444005)(5660300002)(7736002)(4744005)(2906002)(256004)(305945005)(14454004)(86362001)(71190400001)(71200400001)(3846002)(6116002)(66066001)(81156014)(81166006)(8676002)(8936002)(316002)(110136005)(486006)(478600001)(50226002)(6512007)(53936002)(9686003)(4326008)(25786009)(52116002)(99286004)(6436002)(6486002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4824;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: q7EKYbycBgx3OEWOM5NmCwSHKO0YYtlPlhw9xDugjzPeVvUv12BCzuzPA4MKtZWl3NbucyKjSt6Id8cfxg7isP+TYQbzZDBBax2s52fX2sDz0b2R81QSSx+5xaD5I7Z/bmXZGzdCHjE304KehQH7zqg6b/iYMecF6LIUDaCbY/pcwQSQAxTnPWIa7XfRCi3eTuhxXFwANC6SfymkXrIpjhL4pX8OckDkYhvPzSiIQQcl7GFYHLM/sRP1JhPmChQA7ghieFC7xG0VtpwjPOVbtZbwsybmaE/YS9oKk7kGajg+qjdAjzWewBVjXnjzD3ftCmgvVieybYSFYGLcRHvnNw4HmHlR2DOU4HtSivQ4U1f1A27h0g4xsaYNUSBr1PwpH1CELB52lStPJUWL1nL08YRKuMbkj9ck/zhZbARliCM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <700CB66A8DFCD8459CB339DBB771E1C6@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d251345-02d0-4298-9975-08d72c4d03b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2019 06:49:18.4905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmD+zKf1oLnYYXEaY8nD+jq+JMBvqNBgECpLqBaE+meKC1hl8IftFoaUYb9LQE4EGs4BPINFzZhcz8sn2SU1Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the entire comment block to be C++ style so it looks consistent.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/regulator/sy8824x.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
index 1a7fa4865491..d806fa7020d4 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -1,11 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * SY8824C/SY8824E regulator driver
- *
- * Copyright (C) 2019 Synaptics Incorporated
- *
- * Author: Jisheng Zhang <jszhang@kernel.org>
- */
+//
+// SY8824C/SY8824E regulator driver
+//
+// Copyright (C) 2019 Synaptics Incorporated
+//
+// Author: Jisheng Zhang <jszhang@kernel.org>
=20
 #include <linux/module.h>
 #include <linux/i2c.h>
--=20
2.23.0

