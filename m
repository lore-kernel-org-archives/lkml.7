Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E57C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427C6214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Yu8KfOF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfCKWKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:10:03 -0400
Received: from mail-eopbgr740055.outbound.protection.outlook.com ([40.107.74.55]:7728
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727138AbfCKWKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2iKpN8uFDCMyMnY/++1zj2+mhKMGq0jwvD8fD6TCOQ=;
 b=Yu8KfOF7fGeHXyERPegEZ6PhIRuior8OBuTj0WoYWfTbaFnuOUk3gadrF8Ox3HNRaJWOB6EZ7qfX6zgorKRlF9tsqZSjfLcWIetP87rqNLD7xrc+OaG9i9KmgfSbsNgrllJZV2znSxfmHw2iDff7H8jxHUZ/EE4W3R4kx2Npwio=
Received: from BYAPR05MB5048.namprd05.prod.outlook.com (20.177.230.218) by
 BYAPR05MB5719.namprd05.prod.outlook.com (20.177.187.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.11; Mon, 11 Mar 2019 22:09:56 +0000
Received: from BYAPR05MB5048.namprd05.prod.outlook.com
 ([fe80::b542:165c:d3da:244]) by BYAPR05MB5048.namprd05.prod.outlook.com
 ([fe80::b542:165c:d3da:244%6]) with mapi id 15.20.1709.011; Mon, 11 Mar 2019
 22:09:56 +0000
From:   Vishnu DASA <vdasa@vmware.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
CC:     Vishnu DASA <vdasa@vmware.com>, Pv-drivers <Pv-drivers@vmware.com>
Subject: [PATCH] VMCI: Use BIT() macro for bit definitions
Thread-Topic: [PATCH] VMCI: Use BIT() macro for bit definitions
Thread-Index: AQHU2Fco7mvuWBzPrk2iev2EOu8NqA==
Date:   Mon, 11 Mar 2019 22:09:56 +0000
Message-ID: <20190311220928.4560-1-vdasa@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To BYAPR05MB5048.namprd05.prod.outlook.com
 (2603:10b6:a03:9d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdasa@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf129130-739c-454d-c8b3-08d6a66e4b30
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5719;
x-ms-traffictypediagnostic: BYAPR05MB5719:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB571982F6EFECFA2DF42401F7CE480@BYAPR05MB5719.namprd05.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(136003)(396003)(346002)(189003)(199004)(4326008)(97736004)(14454004)(25786009)(476003)(106356001)(486006)(2616005)(71190400001)(105586002)(71200400001)(2906002)(1076003)(36756003)(478600001)(107886003)(305945005)(86362001)(2201001)(50226002)(386003)(53936002)(102836004)(6506007)(316002)(52116002)(256004)(26005)(99286004)(14444005)(3846002)(54906003)(110136005)(6116002)(6436002)(5660300002)(81156014)(81166006)(6512007)(68736007)(6486002)(8676002)(186003)(66066001)(2501003)(8936002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5719;H:BYAPR05MB5048.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bBmk24bi17/w9kS7h5rs3fJuS00a3ipAvBjBsi5Nb61ESfCQ8TJM9t0QEiFLZt1F1dVJdkusPXepRKup0/qb+VSbb8CWAielYTyFpXIe2Tathppj9FyrCM6vHK3BSl6YdyNZ5xRTgYHGdBKydEVY6Zuhu+j0UNb8IjDKP5ZcfiGyCQb8B2aZ24Zg2RQXPtEVkQ6gTc70t+EMlY8PxfSzAdku6kjQq4OOnpWo1ocME8N1+W13mFwU+494c4TI4NOwFt5/4B1mEluTbgFiCbh3J374elMOr7K/Qz3N9OzJ1/xUFqCPzB/2tU1RxRaGpjGrgd773MSOk2Tp0E+N5kZpMY25pB2dBYr5VvCNB9Bq51gsBP6CvUHy4nI9J2+zYLNN20AXQHkc6zdgh3t8ZXBO57rR7lMT0fdaTgYi3n25jzU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf129130-739c-454d-c8b3-08d6a66e4b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 22:09:56.2639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5719
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes, cleanup only.

Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
---
 include/linux/vmw_vmci_defs.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index eaa1e762bf06..007e28053da8 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -33,27 +33,27 @@
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
@@ -463,9 +463,9 @@ struct vmci_datagram {
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
@@ -694,7 +694,7 @@ struct vmci_qp_detach_msg {
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

