Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF3EC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1EE204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="la6ziIdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbfHHMa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:30:26 -0400
Received: from mail-eopbgr30095.outbound.protection.outlook.com ([40.107.3.95]:59536
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbfHHMa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:30:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJr2MONo7ASxlrVUD1YyRHVhq/fXxGSYFNdTRh6cnVY7ufkfYwR6TXi7PHmvvSObSvwcjbP2ldGA/mhi746qv0HxtFdHvHWuR8377vYmn/Tu0fORG0YVGWdhvbGKvPwJjRiFXs2mlitpbYalZ/z0pjQnOdDLaUnMuV4NOiUtojUZfhcxhZTwYrRIXs9nUUHsvfXxpyaxlKIG1MB0lMDZnu0n5TnwJ4LrQOBJL5ta9rcZKdpXzAh04w5IQUi/nXQDhd9sXWz0U+43S9InPkzE1daelam8aGWj/yq+p8gbN8vSUKgaNW9maRXzaeZ+3mKPXYfv4y3IDMgqLOjxvBqm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VN3VEmc5tQWsuVGObqaqaDcvC9v5YM8hDCb0atTWg4=;
 b=bWi+mOtmGMKT4cI4YdRJwPGdlXYHRY+0oxXwTdhq7lU4e6ezoXaAMuLe8hNfxk5Na8Nb0Jf6znpduXk3PE6C/zN+IbWqhdn+eDOmqXKQRu3ERdECsSmQeDHC+zKGQXNDmf3ycD+TdEcEzOLIHnu8BdYrdgCXXWgS2r0Sg3ynW4qU4MgxBQgw/RYyeOtF8ZtlN9mY9AujxcMifo0A/8rOHJPmJhErXOIrWeqQ/BfZ9Ah5xPftkfXxMRdzEeCt6CeLrvBmqRkNnxcrep4VvlYtorMW1ZTMBnXblIYj7jO2nAD4CigAOU/ZSw3kryniaK1R1TOsYGHMWZu2smUGhNddRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VN3VEmc5tQWsuVGObqaqaDcvC9v5YM8hDCb0atTWg4=;
 b=la6ziIdvgbQ8rl3D003EYou0d0J006kqi35eWbaloZoc2fGXvdmqyRCWzlhjz+Io0h9BrFsPfhPeJ5SJfJCRiq2hGcaalUR0Jfsljlxo9Ja+Yt6zfdVw40YuMqO7+IPM6Ok1Ppp/dY4yw6ZW7whL2dZ+xF5qqGogg6rLOwQS4Dk=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB3936.eurprd02.prod.outlook.com (20.177.58.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Thu, 8 Aug 2019 12:30:22 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::30b7:2c9a:9b15:f88f]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::30b7:2c9a:9b15:f88f%4]) with mapi id 15.20.2136.018; Thu, 8 Aug 2019
 12:30:22 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] habanalabs: Handle HW_IP_INFO if device disabled or in reset
Thread-Topic: [PATCH] habanalabs: Handle HW_IP_INFO if device disabled or in
 reset
Thread-Index: AQHVTeUMWSFAnG+tZE+ecGB9yO7osg==
Date:   Thu, 8 Aug 2019 12:30:22 +0000
Message-ID: <20190808122956.12789-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR2PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:101:16::30) To VI1PR02MB3054.eurprd02.prod.outlook.com
 (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb6afa63-19df-4266-d066-08d71bfc2e74
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR02MB3936;
x-ms-traffictypediagnostic: VI1PR02MB3936:
x-microsoft-antispam-prvs: <VI1PR02MB39360D3EE67FD5D5533532E7D2D70@VI1PR02MB3936.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(39840400004)(366004)(189003)(199004)(71200400001)(316002)(102836004)(5640700003)(2351001)(2906002)(3846002)(6916009)(6116002)(1361003)(53936002)(2501003)(81156014)(36756003)(476003)(6512007)(2616005)(486006)(7736002)(8936002)(81166006)(5660300002)(186003)(50226002)(66476007)(26005)(66556008)(66946007)(14444005)(64756008)(6506007)(256004)(6486002)(99286004)(86362001)(6436002)(66446008)(8676002)(66066001)(25786009)(305945005)(52116002)(386003)(14454004)(1076003)(71190400001)(4326008)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3936;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y9/aHOCkGlyzambMrrib6cVArJKtf7LuO3dKWUy3iDVJiOydO9A1qbyEpmwgpaX46eK5GKyOrkOEmlqHJR4U7mCEsTU6dswMDGiy3VjE5hgK7UYVfhXBNUS/6n5HPqbWmA4DlSr+oe8wvNAaOJ48RiZq8+T8YtWXdmvbUO1jb2wbHy771/+p/E45ivIQFQJRY14Gad/ClE/59/jSKR8cRw+FrcBnZOvwLQY+54VQjcF5Y2X1iU5oQoyhpEC4X7sHOo71UNaSoU1D86+C7HMfqrg6UK2DfVNgemq5DdHRBP9IdtsA0jat4v7qb2LpcUU95oSjhVQWPlPv4IEQZEEMy0MHI6qqtos9uYZgvMUDPq+/y6kg6j7cNBqp9pdrTJnTHnQRB8TJ2H65+CotQ5z8bWwMYbEd6xaWOKdo4dG5TLM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6afa63-19df-4266-d066-08d71bfc2e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 12:30:22.3329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttayar@habana.ai
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HW IP information is relevant even if the device is disabled or in
reset, so always handle the corresponding INFO IOCTL opcode.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/habanalabs_ioctl.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/haba=
nalabs/habanalabs_ioctl.c
index 3ce65459b01c..589324ac19d0 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -204,10 +204,21 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, voi=
d *data,
 	struct hl_device *hdev =3D hpriv->hdev;
 	int rc;
=20
-	/* We want to return device status even if it disabled or in reset */
-	if (args->op =3D=3D HL_INFO_DEVICE_STATUS)
+	/*
+	 * Information is returned for the following opcodes even if the device
+	 * is disabled or in reset.
+	 */
+	switch (args->op) {
+	case HL_INFO_HW_IP_INFO:
+		return hw_ip_info(hdev, args);
+
+	case HL_INFO_DEVICE_STATUS:
 		return device_status_info(hdev, args);
=20
+	default:
+		break;
+	}
+
 	if (hl_device_disabled_or_in_reset(hdev)) {
 		dev_warn_ratelimited(dev,
 			"Device is %s. Can't execute INFO IOCTL\n",
@@ -216,10 +227,6 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void=
 *data,
 	}
=20
 	switch (args->op) {
-	case HL_INFO_HW_IP_INFO:
-		rc =3D hw_ip_info(hdev, args);
-		break;
-
 	case HL_INFO_HW_EVENTS:
 		rc =3D hw_events_info(hdev, args);
 		break;
--=20
2.17.1

