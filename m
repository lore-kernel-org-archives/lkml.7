Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F50FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA722071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="wOhybaTP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfKNSYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:24:15 -0500
Received: from mail-eopbgr150108.outbound.protection.outlook.com ([40.107.15.108]:50913
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727569AbfKNSYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:24:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG0fkJu5C71PIB0S3ncasEKZhuSa20MK5Gp8XG8fcyGOHgNxDEINTkklAqzBvjhHELreR8NAHak4HRGoeWItuopGGicp6sc3mQBTNyQsXXU0q2qPK6wtZ/QXdcms+P5w1D7WhVGDrMBPj2hL7d0cXueU4cpdHaB8IAy+Xf18Sl2SXS+cg3sRmgEdYMRgrozBczMGuXmeF4Fy2JBq/HHcSBBCgVZwoH8Agtmqr0dZILrYrNdswasSR9WmWEejrWwk/3mxYhotO/QygvrLJ0i59ojaA0sgbeFaBtdcOB3ivnAdjCQxKr1RL/JW8emZEj9yON5otTriP3ULnvP6srWXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzF198WKgmFCrAOY0jzsb4nvo14L+m8qKz5fhMWxlq8=;
 b=CUmWJopL8LSOyTU13MpNbjIwbMLFftBGSioq3CoxRoll8sPmybxKsut5oelPMpeKSOlyE/Gpu1KpZ5rgVWjteMJ0ECTqCSCi+q2DYey2vIIV5SOSyie0PHj+2XNmoryrbFKB3FWaWyWlDfiggWg6pdlhKf4CqdErbvCEzXalWLDoTC+r4JrDLAcC8WisNVk2OrxTIteXUdzvRuLP3MUceB+Z4i/R9T0WqYq4X8AhNr/Jr7gtooYRXEHIduC6zxIClQLaQAKSsDZ+tr9vWAKaXMuHX7rLKLnXkkrPLVlAOjrz1HLZljF6yIxHRRrZPPRVswn4k+3MaqjSezcOSa0gqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzF198WKgmFCrAOY0jzsb4nvo14L+m8qKz5fhMWxlq8=;
 b=wOhybaTPXObKCxHfh9PlIAyFHE1Tl+fenLFlfw7ENaO6nY/VV7tg0Nc8PFTAo2e0AbCNp7Th9W5N8KCCV+bYU1lP7D1FRIq4LZ7DK2fQ1VnSa8zM16rw4E4TduRVn1582KYKdiK6zLDInqMOFAPihS7eOsObUPOohvAVpm3v3JE=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3383.eurprd02.prod.outlook.com (52.133.29.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Thu, 14 Nov 2019 18:23:58 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 18:23:58 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8] habanalabs: skip VA block list update in reset flow
Thread-Topic: [PATCH 6/8] habanalabs: skip VA block list update in reset flow
Thread-Index: AQHVmxiuq1Q1DSwBjU6NpKINytksvQ==
Date:   Thu, 14 Nov 2019 18:23:57 +0000
Message-ID: <20191114182346.22675-6-oshpigelman@habana.ai>
References: <20191114182346.22675-1-oshpigelman@habana.ai>
In-Reply-To: <20191114182346.22675-1-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0007.eurprd04.prod.outlook.com
 (2603:10a6:208:15::20) To AM6PR0202MB3382.eurprd02.prod.outlook.com
 (2603:10a6:209:20::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8adfa9a-b80e-4955-c576-08d7692fd06f
x-ms-traffictypediagnostic: AM6PR0202MB3383:
x-microsoft-antispam-prvs: <AM6PR0202MB33835FEFDAFD32BAE05DDE71B8710@AM6PR0202MB3383.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39840400004)(136003)(366004)(189003)(199004)(71200400001)(6436002)(5640700003)(81166006)(26005)(478600001)(81156014)(186003)(386003)(25786009)(8936002)(14444005)(50226002)(14454004)(256004)(76176011)(6486002)(71190400001)(8676002)(102836004)(2906002)(52116002)(316002)(5660300002)(36756003)(86362001)(4326008)(66556008)(66476007)(66446008)(1361003)(6506007)(15650500001)(64756008)(99286004)(6512007)(7736002)(305945005)(2501003)(66946007)(446003)(1076003)(486006)(2616005)(476003)(6116002)(3846002)(11346002)(2351001)(66066001)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3383;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8lakoL5zqYwckb/tEMUgTIe1xy0MVmPbAvugcmC2RXwgPFsuacQ9Hw2KJSR5pbYC1biYjUK4ZaelnzAnSPuLMq9I3kiDB1V0jMPlF8G6JIzX+tFH/39ogrDz6V0AnreXFy8W6o5oif3CyXuG1aihESIBKnqF5HR24FvZ3FybdXDlCCpaY6kKAygGjHsDAimq2wvvzIoBHiVdRHPI+kFwnb0Wg08R9D+yBq0/M28SxQY1nrGeaC1KofmRbEij2Jj6CMv1v1TvbeZlTF/GJh5zT07/yxJaeV5QjhLVlSomoFZAQFtB+pNnp97a5MJRWV8FErwjCCZOpPKuUO3vHHO3xTnZuOyrmVgrr8wXDDXydzmWWGaGWtoIwraS3XiOlJ7mBTjquDcRqxzlJxn0euDm8nH4HPAG/waDWKZhWua4oHTNPU3QcaDCPANpLNzJyA8N
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: a8adfa9a-b80e-4955-c576-08d7692fd06f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 18:23:57.9568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQANbnHuGds9mKa8NxQMXC+2pFMoEGNmSMbMlOKH8kgfj2KUks6EG6pAcFRqmuzn4C0Dx4kis/nvPE1hsj0Xbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce context close time by skipping the VA block free list update in
order to avoid hard reset with open contexts.
Reset with open contexts can potentially lead to a kernel crash as the
generic pool of the MMU hops is destroyed while it is not empty because
some unmap operations are not done.
The commit affect mainly when running on simulator.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/memory.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/mem=
ory.c
index 1e0ebd3f6e36..be6f42749a61 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -994,17 +994,19 @@ static int map_device_va(struct hl_ctx *ctx, struct h=
l_mem_in *args,
  *
  * @ctx                 : current context
  * @vaddr               : device virtual address to unmap
+ * @ctx_free            : true if in context free flow, false otherwise.
  *
  * This function does the following:
  * - Unmap the physical pages related to the given virtual address
  * - return the device virtual block to the virtual block list
  */
-static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
+static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr, bool ctx_free)
 {
 	struct hl_device *hdev =3D ctx->hdev;
 	struct hl_vm_phys_pg_pack *phys_pg_pack =3D NULL;
 	struct hl_vm_hash_node *hnode =3D NULL;
 	struct hl_userptr *userptr =3D NULL;
+	struct hl_va_range *va_range;
 	enum vm_type_t *vm_type;
 	bool is_userptr;
 	int rc;
@@ -1030,6 +1032,7 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 va=
ddr)
=20
 	if (*vm_type =3D=3D VM_TYPE_USERPTR) {
 		is_userptr =3D true;
+		va_range =3D &ctx->host_va_range;
 		userptr =3D hnode->ptr;
 		rc =3D init_phys_pg_pack_from_userptr(ctx, userptr,
 							&phys_pg_pack);
@@ -1041,6 +1044,7 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 va=
ddr)
 		}
 	} else if (*vm_type =3D=3D VM_TYPE_PHYS_PACK) {
 		is_userptr =3D false;
+		va_range =3D &ctx->dram_va_range;
 		phys_pg_pack =3D hnode->ptr;
 	} else {
 		dev_warn(hdev->dev,
@@ -1066,12 +1070,18 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 =
vaddr)
=20
 	mutex_unlock(&ctx->mmu_lock);
=20
-	if (add_va_block(hdev,
-			is_userptr ? &ctx->host_va_range : &ctx->dram_va_range,
-			vaddr,
-			vaddr + phys_pg_pack->total_size - 1))
-		dev_warn(hdev->dev, "add va block failed for vaddr: 0x%llx\n",
-				vaddr);
+	/*
+	 * No point in maintaining the free VA block list if the context is
+	 * closing as the list will be freed anyway
+	 */
+	if (!ctx_free) {
+		rc =3D add_va_block(hdev, va_range, vaddr,
+					vaddr + phys_pg_pack->total_size - 1);
+		if (rc)
+			dev_warn(hdev->dev,
+					"add va block failed for vaddr: 0x%llx\n",
+					vaddr);
+	}
=20
 	atomic_dec(&phys_pg_pack->mapping_cnt);
 	kfree(hnode);
@@ -1203,8 +1213,8 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 		break;
=20
 	case HL_MEM_OP_UNMAP:
-		rc =3D unmap_device_va(ctx,
-				args->in.unmap.device_virt_addr);
+		rc =3D unmap_device_va(ctx, args->in.unmap.device_virt_addr,
+					false);
 		break;
=20
 	default:
@@ -1651,7 +1661,7 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 		dev_dbg(hdev->dev,
 			"hl_mem_hash_node of vaddr 0x%llx of asid %d is still alive\n",
 			hnode->vaddr, ctx->asid);
-		unmap_device_va(ctx, hnode->vaddr);
+		unmap_device_va(ctx, hnode->vaddr, true);
 	}
=20
 	spin_lock(&vm->idr_lock);
--=20
2.17.1

