Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ACAC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333F821920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="fDnTX3JG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfJBNx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:53:59 -0400
Received: from mail-eopbgr80113.outbound.protection.outlook.com ([40.107.8.113]:30438
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfJBNx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:53:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOi9JffLncAj0QAh8OerJcUSbH7Hd++EJI5Jy39hldGpmISAuxTcUVO95ghapd5UmOcfTIlks0bVFMy9Pkk+UX6c+GGd54+xma3/Fdi7fRe0ldB634qc5wwcI0jccjq5xMsOT4Ze4SooX3OXJdjRAZpzcDLp534d2gcGzduK5lrnDQMatvrIJOgCg2U9xK78VDbl/uIWIIh6M4S5/AjJ/wHRCqF/9R4m6W2Ke7bBOgDdU4bW9BMo6ZS1EUer8VBXpyfAXsyE3Nic8/BwJOK+JoiWKGkKVVPGxFdy4hKckORaHzexaW+OMROXNmXjL6zHUkbUg39LOjtmjCH1GjJD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVDu19wCH2EsMUykgqOKSsKPtIgKYfyxhwrpV6L2lAY=;
 b=D2Tk5T7SSaCtNn2ADNzvXhc1PlDd6xXfeI+4ju4cKbG8RBPspanYKIOJcGD1i8KjkpNBP8JGiM3ZGnlDpFX+9vhAuRFz0uNaPof/NFiqQujmBwjNaH/zlHfY3IYT7ZU2uJxxEJjqwp2ChLsZ54StR5Uau0N69UdMNj4KPeU5MdFG8duMZidMUZS6FhzJ96uKx+qtzBmE/K63QTjL+BNwhsBOEqWS3Ue5hhKWRjLPD/U3iISww9CHa8Ix9sLY1UyJkXcJIDwXX+/4sD6my9Pl07XGV25iezLoBtEo747DcPuKAxtiQLgwrClpJUsNcnfM8lXdY462/SvwFzbRadOn0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVDu19wCH2EsMUykgqOKSsKPtIgKYfyxhwrpV6L2lAY=;
 b=fDnTX3JGp/zXoEkgNGmjyA9m/10ElBj/G/ouKMxi1rxSrt7hQ9phBGzrakoewxkdUtcnERUQmkBPXZTj7a3gx6L+6+ZiySNfqI+jFYbWwBgh9syDr/KvdVpg2F+1hLE07GgAzavALxKxxbADYdPgMkgADyj0/RqmtEDn/wYe7Yk=
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com (10.170.235.155) by
 VI1PR02MB4846.eurprd02.prod.outlook.com (20.177.202.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 13:53:52 +0000
Received: from VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78a3:56d0:8d09:1604]) by VI1PR02MB3054.eurprd02.prod.outlook.com
 ([fe80::78a3:56d0:8d09:1604%6]) with mapi id 15.20.2305.017; Wed, 2 Oct 2019
 13:53:52 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] habanalabs: Fix typos
Thread-Topic: [PATCH] habanalabs: Fix typos
Thread-Index: AQHVeSjTLxrJEM17vEOpR6QZn/4CJw==
Date:   Wed, 2 Oct 2019 13:53:52 +0000
Message-ID: <20191002135345.22677-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::43) To VI1PR02MB3054.eurprd02.prod.outlook.com
 (2603:10a6:802:17::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cde71a42-768a-4ba4-00e9-08d7473ff57d
x-ms-traffictypediagnostic: VI1PR02MB4846:
x-microsoft-antispam-prvs: <VI1PR02MB48465A459D58853AE04EEBA9D29C0@VI1PR02MB4846.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(39840400004)(376002)(189003)(199004)(305945005)(66066001)(4326008)(7736002)(316002)(36756003)(81166006)(14444005)(1361003)(2616005)(476003)(2351001)(2906002)(486006)(5640700003)(256004)(6486002)(2501003)(6436002)(6916009)(1076003)(99286004)(52116002)(6512007)(66556008)(66446008)(66476007)(64756008)(386003)(71200400001)(71190400001)(66946007)(5660300002)(8936002)(3846002)(6116002)(50226002)(26005)(86362001)(102836004)(478600001)(8676002)(14454004)(6506007)(81156014)(186003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4846;H:VI1PR02MB3054.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JJhG81VJ2siow0BagZe31Fdf0MvnG8L/SL7xd7N8nmMWYscJvlqBjqj+HOYS9/1fuI2gM8uoUaxQEV4gzmDp1ZP3X55mapcLMjKGY0zalHFry8RSEkb9InR/jhKLhHSJSZ7bqWx5wRsNBNY0RE5PYKrDFUH3NHRfS5kL/MBjUU6MEwnofZJxTj1sUgQbs71uVBJt6wrGRZm9+Xnn4czb1ghn6g72hr+rs729yHnuq81wTAs3nl1zTuFvfB0qI6SC/SX3vOsub/YiFUTMg8mBtzAb1fw7Qdr94tXaJb7mLJEJOgox8Qb+wUXOYkUi2VnqYVAYHNqP15WuhUZWJiiiSvcobJAlfhBMEXDosEyjE9dguypOfMM//NbZBk686g5zPcy/1dZSfnIsne4BPU8D6eXHiZa9CuOsNlFh/Cjby4o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: cde71a42-768a-4ba4-00e9-08d7473ff57d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 13:53:52.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQbois0a7Aa74rQhr8Jmk8RX5laBNFiXk7DG+/xfaJXJ5enf5YQY/DKQKLMs8FU6gHlqjcQuqpxDV5L5ype3Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/paerser/parser/
s/requeusted/requested/
s/an JOB/a JOB/

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/habanalabs.h | 2 +-
 drivers/misc/habanalabs/hw_queue.c   | 4 ++--
 include/uapi/misc/habanalabs.h       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs=
/habanalabs.h
index 75862be53c60..c3d24ffad9fa 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -774,7 +774,7 @@ struct hl_cs_job {
 };
=20
 /**
- * struct hl_cs_parser - command submission paerser properties.
+ * struct hl_cs_parser - command submission parser properties.
  * @user_cb: the CB we got from the user.
  * @patched_cb: in case of patching, this is internal CB which is submitte=
d on
  *		the queue instead of the CB we got from the IOCTL.
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/h=
w_queue.c
index 55b383b2a116..f733b534f738 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -220,7 +220,7 @@ int hl_hw_queue_send_cb_no_cmpl(struct hl_device *hdev,=
 u32 hw_queue_id,
 }
=20
 /*
- * ext_hw_queue_schedule_job - submit an JOB to an external queue
+ * ext_hw_queue_schedule_job - submit a JOB to an external queue
  *
  * @job: pointer to the job that needs to be submitted to the queue
  *
@@ -278,7 +278,7 @@ static void ext_hw_queue_schedule_job(struct hl_cs_job =
*job)
 }
=20
 /*
- * int_hw_queue_schedule_job - submit an JOB to an internal queue
+ * int_hw_queue_schedule_job - submit a JOB to an internal queue
  *
  * @job: pointer to the job that needs to be submitted to the queue
  *
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.=
h
index 39c4ea51a719..53e4ff73578e 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -589,7 +589,7 @@ struct hl_debug_args {
  *
  * The user can call this IOCTL with a handle it received from the CS IOCT=
L
  * to wait until the handle's CS has finished executing. The user will wai=
t
- * inside the kernel until the CS has finished or until the user-requeuste=
d
+ * inside the kernel until the CS has finished or until the user-requested
  * timeout has expired.
  *
  * The return value of the IOCTL is a standard Linux error code. The possi=
ble
--=20
2.17.1

