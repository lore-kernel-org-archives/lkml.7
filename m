Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F237AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36E32148D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="g9exUhDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfCKXTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:19:54 -0400
Received: from mail-eopbgr680087.outbound.protection.outlook.com ([40.107.68.87]:31459
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbfCKXTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD1nkT8V4e7dLbND8rjNt/U4wHlOjY1/Pagk4T94SwI=;
 b=g9exUhDmBoteH3fLSXIN/vGbMDmophBTqGV1Enak3Ix9KuDCx0zdAj9K4xeK2IeCBBpN+GF/UouX6qundS0XRl97P0G5Wtc7asZ4/1LVnLuTZBiq9csJpFIGPg6oHE2Uh+K24ERLqDBmRlSr9vLxQ8t/JezScmojQiNS17q7KV0=
Received: from BYAPR05MB5048.namprd05.prod.outlook.com (20.177.230.218) by
 BYAPR05MB4981.namprd05.prod.outlook.com (20.177.230.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.8; Mon, 11 Mar 2019 23:19:42 +0000
Received: from BYAPR05MB5048.namprd05.prod.outlook.com
 ([fe80::b542:165c:d3da:244]) by BYAPR05MB5048.namprd05.prod.outlook.com
 ([fe80::b542:165c:d3da:244%6]) with mapi id 15.20.1709.011; Mon, 11 Mar 2019
 23:19:42 +0000
From:   Vishnu DASA <vdasa@vmware.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     Vishnu DASA <vdasa@vmware.com>, Pv-drivers <Pv-drivers@vmware.com>
Subject: [PATCH v2] VMCI: Use BIT() macro for bit definitions
Thread-Topic: [PATCH v2] VMCI: Use BIT() macro for bit definitions
Thread-Index: AQHU2GDoWJhkI29GYU+8unSsHPJZ2g==
Date:   Mon, 11 Mar 2019 23:19:42 +0000
Message-ID: <20190311231925.14014-1-vdasa@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::22) To BYAPR05MB5048.namprd05.prod.outlook.com
 (2603:10b6:a03:9d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdasa@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 975920f5-28a0-4fc0-93f8-08d6a6780a87
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4981;
x-ms-traffictypediagnostic: BYAPR05MB4981:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB498167D8757AC03D523ABCF3CE480@BYAPR05MB4981.namprd05.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(396003)(376002)(189003)(199004)(53936002)(2616005)(256004)(4326008)(2201001)(26005)(476003)(86362001)(14444005)(14454004)(486006)(186003)(478600001)(6116002)(25786009)(6436002)(52116002)(71190400001)(99286004)(81156014)(8676002)(71200400001)(81166006)(386003)(6506007)(6512007)(305945005)(316002)(2906002)(3846002)(106356001)(107886003)(97736004)(7736002)(102836004)(105586002)(54906003)(5660300002)(110136005)(6486002)(68736007)(1076003)(2501003)(36756003)(66066001)(8936002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4981;H:BYAPR05MB5048.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: opsLldaBadLmqALTWb0x97rtNbtgQoZYrau3E0VD2K/EcBhuWEbqqLNaAnlXQ7zgHmjPF9McRGWwQNg0i5e4SgAWx/au2JMpXemHEIcAU3d3AjURK0rcBRVQTg2zo8YDloGKWTcZs0NLyxmUsHSqszx1hTO7Sd/IQS946+GLJ3tzRAyc9Kn9sKlKgVKfLpZYUnyxpaAu55qpL1r8nvWyvQjQFJgXcmtNq8p+usspIPb8xgWOwFyjfF7YWtO0TLWH4NRXYNl7TkBUnbuvNGIFjoIEpAHNnrzy7aWm+40W7WWvVHe3jCG8cIzeQxYFu/osiZGWTfxddzjvt4cwGGG+mXItR+8YsLsGQ304ltgGBCfMYWKUxabKDRck50pRIheyhLesTCBZXSoCBvpKfnYCy5ohxrGjkgS012MYXhFRq4s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975920f5-28a0-4fc0-93f8-08d6a6780a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 23:19:42.5719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4981
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes, cleanup only.

Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
---

v1 -> v2:
- Add #include <linux/bits.h>
---
 include/linux/vmw_vmci_defs.h | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index eaa1e762bf06..0c06178e4985 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -17,6 +17,7 @@
 #define _VMW_VMCI_DEF_H_
=20
 #include <linux/atomic.h>
+#include <linux/bits.h>
=20
 /* Register offsets. */
 #define VMCI_STATUS_ADDR      0x00
@@ -33,27 +34,27 @@
 #define VMCI_MAX_DEVICES 1
=20
 /* Status register bits. */
-#define VMCI_STATUS_INT_ON     0x1
+#define VMCI_STATUS_INT_ON     BIT(0)
=20
 /* Control register bits. */
-#define VMCI_CONTROL_RESET        0x1
-#define VMCI_CONTROL_INT_ENABLE   0x2
-#define VMCI_CONTROL_INT_DISABLE  0x4
+#define VMCI_CONTROL_RESET        BIT(0)
+#define VMCI_CONTROL_INT_ENABLE   BIT(1)
+#define VMCI_CONTROL_INT_DISABLE  BIT(2)
=20
 /* Capabilities register bits. */
-#define VMCI_CAPS_HYPERCALL     0x1
-#define VMCI_CAPS_GUESTCALL     0x2
-#define VMCI_CAPS_DATAGRAM      0x4
-#define VMCI_CAPS_NOTIFICATIONS 0x8
-#define VMCI_CAPS_PPN64         0x10
+#define VMCI_CAPS_HYPERCALL     BIT(0)
+#define VMCI_CAPS_GUESTCALL     BIT(1)
+#define VMCI_CAPS_DATAGRAM      BIT(2)
+#define VMCI_CAPS_NOTIFICATIONS BIT(3)
+#define VMCI_CAPS_PPN64         BIT(4)
=20
 /* Interrupt Cause register bits. */
-#define VMCI_ICR_DATAGRAM      0x1
-#define VMCI_ICR_NOTIFICATION  0x2
+#define VMCI_ICR_DATAGRAM      BIT(0)
+#define VMCI_ICR_NOTIFICATION  BIT(1)
=20
 /* Interrupt Mask register bits. */
-#define VMCI_IMR_DATAGRAM      0x1
-#define VMCI_IMR_NOTIFICATION  0x2
+#define VMCI_IMR_DATAGRAM      BIT(0)
+#define VMCI_IMR_NOTIFICATION  BIT(1)
=20
 /* Maximum MSI/MSI-X interrupt vectors in the device. */
 #define VMCI_MAX_INTRS 2
@@ -463,9 +464,9 @@ struct vmci_datagram {
  * datagram callback is invoked in a delayed context (not interrupt contex=
t).
  */
 #define VMCI_FLAG_DG_NONE          0
-#define VMCI_FLAG_WELLKNOWN_DG_HND 0x1
-#define VMCI_FLAG_ANYCID_DG_HND    0x2
-#define VMCI_FLAG_DG_DELAYED_CB    0x4
+#define VMCI_FLAG_WELLKNOWN_DG_HND BIT(0)
+#define VMCI_FLAG_ANYCID_DG_HND    BIT(1)
+#define VMCI_FLAG_DG_DELAYED_CB    BIT(2)
=20
 /*
  * Maximum supported size of a VMCI datagram for routable datagrams.
@@ -694,7 +695,7 @@ struct vmci_qp_detach_msg {
 };
=20
 /* VMCI Doorbell API. */
-#define VMCI_FLAG_DELAYED_CB 0x01
+#define VMCI_FLAG_DELAYED_CB BIT(0)
=20
 typedef void (*vmci_callback) (void *client_data);
=20
--=20
2.19.1

