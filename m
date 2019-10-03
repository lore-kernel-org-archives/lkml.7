Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5671C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809822133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="QlleQUGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfJCPWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:22:42 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com ([40.107.0.103]:2274
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727587AbfJCPWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:22:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQAKcfhrOp21RIp7G0oanD3IuUMPWV9ES4btL3RwpsA8lJIBHUbIH2E46Kj8Chp3aOAo0QOhZ3OpgxAN0AEPguD9TN3+vk46tQncFzCfaG5k/A7WN/zgXTmIwnel092ryjtQP81ufyiHQWRjMkxqHGtHaz1G8g+U36/PD8DikEYOYKA14+QAZk/aOf90FkS2VrJLuKc76zSFMiOr2NvAwK0CM7G2h1yF93j8U0HaaBhnQoWvy1FE0shRW4ZuB70AQSeo0rJsfLN8pJPpim7e9NaHyWGYRWIoff+eV5Xtc7XvdMsBN0C+9z7vzqmadopbUwt5u5L079QZBKVpS5VA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmjLsUY5u5Rqqv5jwFookZojTpa7k+AfJoDhoGuLyQI=;
 b=gszHgPA03tw9knXaZIRmbQUB8l+TIUHyjMhM2HuZpstGkUv/fqWhaE1xqqECSykOwZnna8T1RjjxAWwwWaYqK1I7SrJjbSYn3MPwjBC7IEquSBn9JC6jXHcjY1bsnoEf6GhhJh9y1WdrTmPmjMDhRYj82PjhVSgV6Z1uPxIZOw1tPiLRO5NaKXg2tOKUK3trR1DCa42nhI/LLMsx5Gt2X+Bt9iuJhY2eDkfikqTjmyxK+N05nGdIqmBq1uVT6zzrTq+wF5pUG3oAPf8aqKgb51EQ4wV/4L9vTMAwpuEK98SPVD9SQ1eHd6Ffvts8w1e7c3RGufVY5cvX6qTO+fK6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmjLsUY5u5Rqqv5jwFookZojTpa7k+AfJoDhoGuLyQI=;
 b=QlleQUGEHM5dsb4I2XjcXTQaMAtKAl9I8SltSohbQawPWdsx+/hMd2vApDEnvgtF3k1s/3CH8XEOsiStoBj4vmFftUbDRKdNaB5Yuhz1JguJIMhqV7P4Mov41WicyxQSQ0O68JikbVCQUsspW5EkFP0vi9KB+/DLrhN1E8FKgpc=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB4557.eurprd02.prod.outlook.com (20.178.12.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 15:22:35 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78a3:56d0:8d09:1604]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78a3:56d0:8d09:1604%6]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 15:22:35 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] habanalabs: Mark queue as expecting to CB handle or
 address
Thread-Topic: [PATCH v2 1/4] habanalabs: Mark queue as expecting to CB handle
 or address
Thread-Index: AQHVef5i1ZTAuxdJbE6knTO3xmcyLA==
Date:   Thu, 3 Oct 2019 15:22:35 +0000
Message-ID: <20191003152228.28955-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0086.eurprd02.prod.outlook.com
 (2603:10a6:208:154::27) To VI1PR02MB3054.eurprd02.prod.outlook.com
 (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa11b850-bd13-4eed-7d20-08d748158493
x-ms-traffictypediagnostic: VI1PR02MB4557:
x-microsoft-antispam-prvs: <VI1PR02MB455710342D7D038B873D23B8D29F0@VI1PR02MB4557.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39840400004)(346002)(136003)(366004)(199004)(189003)(66446008)(66556008)(66476007)(6916009)(64756008)(316002)(66946007)(14444005)(256004)(5660300002)(6512007)(1361003)(71190400001)(71200400001)(2906002)(36756003)(1076003)(2351001)(6436002)(7736002)(86362001)(5640700003)(6486002)(476003)(2616005)(81166006)(81156014)(99286004)(8676002)(486006)(4326008)(478600001)(305945005)(8936002)(2501003)(3846002)(26005)(102836004)(386003)(6506007)(186003)(6116002)(52116002)(66066001)(25786009)(14454004)(50226002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4557;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: acTmY3DQ2T3mXnfAFe7cTfDf5VyzsUpAWQ+OlE1pjnjwjYH/R1+N1XdqFCNK6XXVeBkkdHNMXTwaoWoCwX8JFePl2KQrMiCGXgMJM/lJ7El9X3ByXf26KT4n1GxlrL+ASiLJb5tpVaSzIz9oKJdsednUJ9XW6pKzOFnB2ga2OfJ93j94Fs+oB66DCTs/ZTWJWIiZcRHhtXtvv7BJpu1GsJT2uvoPnmiU6oLwRspO+CprnyuqeG/QLxOx7UsZ+tj/k+59crTwwmsEqnFrT/0ZAc4MsMU3gEK+F0OWJt13SOZAT94uR5sL1b8Vkwg/uV5cLWx/3FGf6+4UNxFSug8Q3sf+aHg4PqBO5nZ8qnSMtiPGSOoT2RkG9xRSV36aylowC/1gTB9eTbCXvNFvxODCPR15GIY61kgitN7T6F11rz4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: fa11b850-bd13-4eed-7d20-08d748158493
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 15:22:35.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOmHgg7yas1B3N3OSD0OMTDlZkowf1LNCf2q4XS1o1ol5jUFrXdwQWnbmjZry0wdM9n0gqnA9IQhQQolmFEOgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4557
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

