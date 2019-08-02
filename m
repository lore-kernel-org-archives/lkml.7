Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323ABC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA002087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="zrtVrD9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436697AbfHBOkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:40:25 -0400
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:21219
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730713AbfHBOkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:40:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLFB/iS2fVIEt72V6gkZDDDhIv32XMCnv8dyiHw6rjXLksbVdB5UPCirv7AbX1zC9s88yan8TZNfGzsx3Rm1pLMUqBTd4tt4DVfxEBzcYdy4Pg6LPDcmOwtBx/u86/RJoDTnjqAXIjq0P7Lfs0Bm0v6nSLH9qQR2wIaAXsVCYAkvCffkQvjBKdzH+UnxYuZ3tvsj6Em1dkFKWKb4ms6mnvyAYkNQ6aJJC2Qf52x3Db/z8V+06GgYAQC1HBgbmIqhO0S6/MWoPgaBUzhyYy34oqWyGvpAioQsrZClkGQMY0zgOtWZGMjl3GoGwis1rqfUc4tm9X/rF6xNbEsVE/+Xdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKflRdF3ZHOj+Fw+e8VmHrkQct3AZoD+12aEAYJ/TZU=;
 b=eUNMvorqYhmG3GVpdmBy4xQKm6Lb8XRSFlqC0Y9NVFhwu8eRD6K0XyERJixJpE12/3EWLSjz8MMdl29QcA1mH2xMvXbYCYuZ5/Gu2GpIqdKrn/qDuY/AIf6YjGzEweCvcbdYC1ZKWuYK6dWxKlbLe3mzi/M6X8kFYrTz/sRZCpFAxxObt+eJpIqgsSo/4tI/0WFbynTu49n36PVk7s5zer1SnKIsaLDx22rxOYEKEzRljIyVzj8GZYHM/Aow3R+3qzRNzS+o/N0EqdVa+RqHdoiEW75JCYzwQptGjgmOxgMKOPqhLoeqXuwStz/IWyX9/pth2RuatxPNw3ip2r7nAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=arm.com;dmarc=pass action=none header.from=arm.com;dkim=pass
 header.d=arm.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKflRdF3ZHOj+Fw+e8VmHrkQct3AZoD+12aEAYJ/TZU=;
 b=zrtVrD9cNmRY3nO/rJ+Z6IpAPLgak3Hlxg3aN7W1Pc4dMDKWmbw6TQZ6kBqY4EHhHe5I4kHf5bs0VG0WcsoZIPTBo/D6sUCIYf02Q5bYFRqjFXwhR2TlBz6+s+ljaBQyYblH81q6XhST2T4BTKsh6R4O+S4u6CxSRLOuXuO8z6U=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB2878.eurprd08.prod.outlook.com (10.170.239.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Fri, 2 Aug 2019 14:40:19 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::c8dd:d1c6:5044:a888]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::c8dd:d1c6:5044:a888%3]) with mapi id 15.20.2115.005; Fri, 2 Aug 2019
 14:40:19 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/komeda: Add support for 'memory-region' DT node property
Thread-Topic: [PATCH] drm/komeda: Add support for 'memory-region' DT node
 property
Thread-Index: AQHVSUA0/7/jB3Z3jkicHuuMk5vdZA==
Date:   Fri, 2 Aug 2019 14:40:19 +0000
Message-ID: <20190802143951.4436-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LNXP265CA0068.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::32) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.22.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5b891fc-7b5a-413a-aca3-08d71757575c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR08MB2878;
x-ms-traffictypediagnostic: VI1PR08MB2878:
x-microsoft-antispam-prvs: <VI1PR08MB2878110CB4C45BAA212E6EAF8FD90@VI1PR08MB2878.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:357;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(40434004)(189003)(199004)(3846002)(6116002)(68736007)(2906002)(2501003)(256004)(5024004)(86362001)(14444005)(6436002)(6486002)(6916009)(5640700003)(25786009)(1076003)(4326008)(478600001)(5660300002)(44832011)(71190400001)(102836004)(6512007)(305945005)(71200400001)(2616005)(54906003)(2351001)(53936002)(7736002)(386003)(6506007)(476003)(66946007)(66066001)(52116002)(186003)(316002)(50226002)(81156014)(81166006)(8676002)(26005)(66476007)(66556008)(64756008)(66446008)(486006)(36756003)(99286004)(14454004)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2878;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ChCoQwDvNMJhJ2ED1KsDY5J3/XR5CB1OPT4Amn7fOxAOs4CLkzW7zHbreS/VdWOzxTV9U6b0A21eBtP3kGWA4FVNbQSkb2UaIPCaOwk9QedJVdiAGdvxB1rD2JtqtJp2In3xLAc5vXTX1wl5q3lDuPWDFVSuVWkY24D7bx3SmdbL4ByAuf42EfOJ7yZFiWzn1rffr/tClQc1BP4oZaSJT1kP1sxNNDAm+9l/g7/hnIY5Y6EUDTU543QRbRGtNMlgBqpnY4ozkQnMq2vnlud0PwaUs5/APtygdh+ERzOMbzLza9cppRyc9sptwidYh44I/fglMa43ccFKJJCSl/nGdcVwI/ucGCxlMG8ISJSHE9KWpchkFkX7rGAZ0CpoGd1JDevCnwvb7MJrT5MrIni6ZCauoyx43DqLgyxvoCjjEuk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b891fc-7b5a-413a-aca3-08d71757575c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 14:40:19.3438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mihail.Atanassov@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2878
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'memory-region' property of the komeda display driver DT binding
allows the use of a 'reserved-memory' node for buffer allocations. Add
the requisite of_reserved_mem_device_{init,release} calls to actually
make use of the memory if present.

Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_drv.c
index cfa5068d9d1e..2ec877ad260a 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -6,6 +6,7 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/component.h>
 #include <drm/drm_of.h>
@@ -32,6 +33,7 @@ static void komeda_unbind(struct device *dev)
 return;

 komeda_kms_detach(mdrv->kms);
+of_reserved_mem_device_release(dev);
 komeda_dev_destroy(mdrv->mdev);

 dev_set_drvdata(dev, NULL);
@@ -53,6 +55,11 @@ static int komeda_bind(struct device *dev)
 goto free_mdrv;
 }

+/* Get the optional framebuffer memory resource */
+err =3D of_reserved_mem_device_init(dev);
+if (err && err !=3D -ENODEV)
+goto destroy_mdev;
+
 mdrv->kms =3D komeda_kms_attach(mdrv->mdev);
 if (IS_ERR(mdrv->kms)) {
 err =3D PTR_ERR(mdrv->kms);
--
2.22.0

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
