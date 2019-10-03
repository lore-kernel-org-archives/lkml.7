Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CBAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75FE2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="vBlM1/op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfJCImV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:42:21 -0400
Received: from mail-eopbgr00116.outbound.protection.outlook.com ([40.107.0.116]:36543
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727382AbfJCImU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:42:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaKZld22af1GbRT79TwuHu7d51hVObHj4VAlJstbdTToe6ZL2/5Urqxt597lhX2141KxeJtV1whklqnWgyYUPvpbr84mZ2PLkRmt2HclrqYIE0VY/wQxpFR5eUrcx3fyRkd/Jum28rVy07i2gPZScXhyDbTcPStTezAvQ5v0WvHZozWB2QBvlMvXswRRiW3Su3q0rd1455bWWNEPXkfugtWkqae6QB0p9HwEsDcIH6lIUl0L2Hw1Xxa3tSNUORfi53puGZfbrg6i75Vqi/biJOgOWnfotvz+VehGTo8HHG2SerLlypQ/968tgElibQ61B2jQ9+fp951db8dwbHqG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmjLsUY5u5Rqqv5jwFookZojTpa7k+AfJoDhoGuLyQI=;
 b=FJKMjtzrfdkcUv5untZWCV85k6vZp3OyfVIBJgPJ1HiKh4OIhA2jKbjd2XVzY7lfMihAx7yh+DNwaNEqnS4a/eHeexXXsqEKO92JA2uHnthhAnyZ5fJxaU3J0hA9yDP44ycG4IsWZXCJp6s+mUkHSwzr5MEQZ59zsTRGYgXsUq0sjWUl/u+kzr2u/evhnNKGYcsXCX/zQhkZ/yHESXFWZnWDBNIkDf5vTKX0TULHEovCWR91NGyl2iPmj4lnoPb8Qhf2X5llXb0Wsnj1PwXjYXC8o0w9hAUE/Du7BJZ/THl/Urrrl0GfrHwHNIVl15oCisdKd0ErtsXPzoQ2+nqEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmjLsUY5u5Rqqv5jwFookZojTpa7k+AfJoDhoGuLyQI=;
 b=vBlM1/opbW2+wCOWbht94lRf5rz58z8wTpeASuASpMk2jYGXtD1Nkui4/n1s5OYgASZ+OwXWc13CS7FcxPbKYLB7KNg3Ct+CJ5SkKUBDErIEz/TZQPR7tHIvfUNH6mwiIHKtYQrfe/Ec5pwvJgwtOzxsJYSUA54tx1vBA313B3E=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB3245.eurprd02.prod.outlook.com (10.170.237.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 08:42:16 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78a3:56d0:8d09:1604]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78a3:56d0:8d09:1604%6]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 08:42:16 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] habanalabs: Mark queue as expecting to CB handle or
 address
Thread-Topic: [PATCH 1/4] habanalabs: Mark queue as expecting to CB handle or
 address
Thread-Index: AQHVecZ19dcrgX15HEKeVVD4EITKaw==
Date:   Thu, 3 Oct 2019 08:42:16 +0000
Message-ID: <20191003084209.9547-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0004.eurprd04.prod.outlook.com
 (2603:10a6:208:15::17) To VI1PR02MB3054.eurprd02.prod.outlook.com
 (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48c780b1-8481-4913-dee8-08d747dd9835
x-ms-traffictypediagnostic: VI1PR02MB3245:
x-microsoft-antispam-prvs: <VI1PR02MB32450C037D1C670567D73130D29F0@VI1PR02MB3245.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39830400003)(366004)(189003)(199004)(5660300002)(8676002)(2351001)(486006)(66476007)(66946007)(66446008)(64756008)(66556008)(6506007)(66066001)(102836004)(25786009)(71190400001)(2616005)(71200400001)(386003)(186003)(36756003)(26005)(6116002)(1076003)(4326008)(3846002)(476003)(8936002)(6436002)(6916009)(305945005)(50226002)(99286004)(5640700003)(2501003)(316002)(478600001)(2906002)(86362001)(6512007)(14444005)(81156014)(7736002)(256004)(14454004)(1361003)(6486002)(52116002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3245;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AETpGMxz4EQSQREb7FziGbG5QruyDDK36WNgPJx+L9A6iWSi1SsjMfgWss5rC3bes6fWkU50Ucj/uuDf8ZtDwNLNRjaBhTzUhJefdBGlt918frNX7iWPNz/Pbcsq352TkC6eO5IpKT7V35aJjfG6MupoXH78fsuW5RPb9b6b7Mg1PdMqHpAkrHO7OUcuRC8B5vGdcl8FAr0GoJcNoL8m8J9ujo84ln5+f0CS7vx5s6Gbru/QJHTcKnq0FF2Ucj5RiqBx0OecYr/EmDkHRo9Vd9kPP4483zvVIyCei0R5a0bVXciCBwPGCHT2dYCSc5s+j0hnluS/Mqyu7F1LPdpZNnAT6ZWtB/POuqHVKseRpLnoGApbY/lF94KZVfZaX22yZpbqjwrQdcWSvo8CLxLT5BMLCXhCpzb+lknO/X7zFuI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c780b1-8481-4913-dee8-08d747dd9835
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 08:42:16.5325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vUuNQfsWg1emMPgWFAaUuWtzVMlELBPSJD5jtK5F9p4d3m40FZThdWbQw3bOky4HT8cZTo0M+85incFriMtnWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jobs on some queues must be provided with a handle to a driver command
buffer object, while for other queues, jobs must be provided with an
address to a command buffer.
Currently the distinction is done based on the queue type, which is less
flexible if the same type of queue behaves differently on different
types of ASIC.
This patch adds a new queue property for this target, which is
configured per queue type per ASIC type.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/command_submission.c | 4 +++-
 drivers/misc/habanalabs/goya/goya.c          | 3 +++
 drivers/misc/habanalabs/habanalabs.h         | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/ha=
banalabs/command_submission.c
index a9ac045dcfde..f44205540520 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -414,7 +414,9 @@ static struct hl_cb *validate_queue_index(struct hl_dev=
ice *hdev,
 			"Queue index %d is restricted for the kernel driver\n",
 			chunk->queue_index);
 		return NULL;
-	} else if (hw_queue_prop->type =3D=3D QUEUE_TYPE_INT) {
+	}
+
+	if (!hw_queue_prop->requires_kernel_cb) {
 		*ext_queue =3D false;
 		return (struct hl_cb *) (uintptr_t) chunk->cb_handle;
 	}
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/=
goya/goya.c
index 09caef7642fd..71693fcffb16 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -337,17 +337,20 @@ void goya_get_fixed_properties(struct hl_device *hdev=
)
 	for (i =3D 0 ; i < NUMBER_OF_EXT_HW_QUEUES ; i++) {
 		prop->hw_queues_props[i].type =3D QUEUE_TYPE_EXT;
 		prop->hw_queues_props[i].driver_only =3D 0;
+		prop->hw_queues_props[i].requires_kernel_cb =3D 1;
 	}
=20
 	for (; i < NUMBER_OF_EXT_HW_QUEUES + NUMBER_OF_CPU_HW_QUEUES ; i++) {
 		prop->hw_queues_props[i].type =3D QUEUE_TYPE_CPU;
 		prop->hw_queues_props[i].driver_only =3D 1;
+		prop->hw_queues_props[i].requires_kernel_cb =3D 0;
 	}
=20
 	for (; i < NUMBER_OF_EXT_HW_QUEUES + NUMBER_OF_CPU_HW_QUEUES +
 			NUMBER_OF_INT_HW_QUEUES; i++) {
 		prop->hw_queues_props[i].type =3D QUEUE_TYPE_INT;
 		prop->hw_queues_props[i].driver_only =3D 0;
+		prop->hw_queues_props[i].requires_kernel_cb =3D 0;
 	}
=20
 	for (; i < HL_MAX_QUEUES; i++)
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs=
/habanalabs.h
index c3d24ffad9fa..f47f4b22cb6b 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -98,10 +98,13 @@ enum hl_queue_type {
  * @type: queue type.
  * @driver_only: true if only the driver is allowed to send a job to this =
queue,
  *               false otherwise.
+ * @requires_kernel_cb: true if a CB handle must be provided for jobs on t=
his
+ *                      queue, false otherwise (a CB address must be provi=
ded).
  */
 struct hw_queue_properties {
 	enum hl_queue_type	type;
 	u8			driver_only;
+	u8			requires_kernel_cb;
 };
=20
 /**
--=20
2.17.1

