Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BFDC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F67E206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Fj5VxCgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfKNSX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:23:58 -0500
Received: from mail-eopbgr150108.outbound.protection.outlook.com ([40.107.15.108]:50913
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbfKNSX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:23:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS0olvynBl6b8UZjksNCxozVr24nm6QQAoOqikJ0faK+oR8a7g+7GuqiHfuTPqck6ETa9dXKZYJnKZadKXFoLgudAQyNb0LRlJgtBEDeX1o3UBKIdDBjm4VGRkHGUHW/t0NxwCMCz8avR4z0F+it91U3qZnG/CI317nWjhU5PPWs31t/0uaF3k2INUnZpL7lHluHZnKWm9BSNcMQgIhWBJIeYnpwuWBvvEw6KuKaaK3pCqUHtWPoolqfVFMpRPNI31LrsTQ0E2+CkRKG27GmrLs3KiTYId8QsCyxz2Z3uEddM8yDm/uPr52H10+5Cgp6aI2dMg6orjfU2XzgW/T28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqKithcaQtA0h6gvEJBJFIY+GkmlJQz1Rod237OHAoY=;
 b=HmKqUUabyIOfXuGAYnLvG/Srjh327m72n4l1tZ5W0WDZnSIwaDmDgDExfRTFi9He/5s9l3ZVnisjtS8mOXyZhcHK3gEY0/2gNvIOuYZKbGL9gG+cSQckBmH0CDrlSHJ8LEWhFTehfwBVSbbGGGcLR9aPs3d1U+nEYiS1OXIoz5iP77QQPKPzabt6OfSgFakFY+hku/AUQdIm2dGJoOA+FWav8FDEpNzUVqT/GE3WGWaHy1I7vh5Eo3MosUm48QKTZSjseEQ7+08DtWGY2eCLgaEHwLcbEByiHPpiZNnn/lu3y4OPu38oK0YEZ78TGditu6XXSY2msX/L9hpjp8LtjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqKithcaQtA0h6gvEJBJFIY+GkmlJQz1Rod237OHAoY=;
 b=Fj5VxCgOP6Zzld5m07kqeiYzO1AbWIW9x2FLJYwj+bc6Hwb5MANXnwCg848dQIvyVnmNoHaAwv64LhLCTsAEI+SpGQUekef//w8mN6LWZk0BomXU2wrbFzDQAh6Unei9cVJVgDJpRz9BiIMSGbSl8H46ccSXcuxI7dFJRGmt/2s=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3383.eurprd02.prod.outlook.com (52.133.29.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Thu, 14 Nov 2019 18:23:53 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 18:23:53 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] habanalabs: type specific MMU cache invalidation
Thread-Topic: [PATCH 1/8] habanalabs: type specific MMU cache invalidation
Thread-Index: AQHVmxirDVSYxw1jikyfisTruXA+CQ==
Date:   Thu, 14 Nov 2019 18:23:53 +0000
Message-ID: <20191114182346.22675-1-oshpigelman@habana.ai>
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
x-ms-office365-filtering-correlation-id: 90ef8ef3-cd5b-41e0-fec4-08d7692fcd82
x-ms-traffictypediagnostic: AM6PR0202MB3383:
x-microsoft-antispam-prvs: <AM6PR0202MB33831DEB64639482B10C4780B8710@AM6PR0202MB3383.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39840400004)(136003)(366004)(189003)(199004)(71200400001)(6436002)(5640700003)(81166006)(26005)(478600001)(81156014)(186003)(386003)(25786009)(8936002)(14444005)(50226002)(14454004)(256004)(6486002)(71190400001)(8676002)(102836004)(2906002)(52116002)(316002)(5660300002)(36756003)(86362001)(4326008)(66556008)(66476007)(66446008)(1361003)(6506007)(64756008)(99286004)(6512007)(7736002)(305945005)(2501003)(66946007)(1076003)(486006)(2616005)(476003)(6116002)(3846002)(2351001)(66066001)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3383;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mdDppRx9euP9lLc0NhFxHantHgw+G4DwPkFnG8iLh/EcFZtCuntARuxKC+tJWjoShCp7Fs1PvJvcftVJBE6FWODt/ATj8qKptJkcMRgbhyOdGlBqdrHzCNrDxjyPuO509IuFv0dg6PDYYpuC4jm6gTWo1MswQfhligIRZWohcGcg/J6/Y61V1YH0IAXR6iLyZygI1e3Wq/wQsK6szqeGk1Fem+SwC1GRrofKoEnoleOLgt3g3t1p8iTXQH537wc5/qFqJqQ+V2oJd4WZWM8xkZlLUD9/TQlh6cM1bmBiD+e4P+Tq1Te8JZqK9JdTr9UBCFao3zzJH2j9o8CepK+nnE11NJ8KRlCXYZxGt+BqKiZDfffvls6EAjb3W9Uyy9WiiGRmOqaMIOMREjZqX377AxOAn3EXNAzYwSA2urJWNrKPKeR32eOOmL/4/pFIOwvG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ef8ef3-cd5b-41e0-fec4-08d7692fcd82
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 18:23:53.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIZcjAQSZJo3YoiBB0dskCj3qLKIXy1IpCSZJew+MmVf1CYQrazFH0wMeniCpUg/NgXoZjoNrfGU/asiO8BMAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to invalidate the necessary MMU cache only.
This ability is a prerequisite for future ASICs support.
Note that in Goya ASIC, a single cache is used for both host/DRAM
mapppings and hence this patch should not have any effect on current
behaviour.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/goya/goya.c  |  6 ++++--
 drivers/misc/habanalabs/habanalabs.h | 11 ++++++-----
 drivers/misc/habanalabs/memory.c     |  4 ++--
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/=
goya/goya.c
index 9712122d6cb1..3c22fb96a26f 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2463,7 +2463,8 @@ int goya_mmu_init(struct hl_device *hdev)
 	WREG32_AND(mmSTLB_STLB_FEATURE_EN,
 			(~STLB_STLB_FEATURE_EN_FOLLOWER_EN_MASK));
=20
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true,
+					VM_TYPE_USERPTR | VM_TYPE_PHYS_PACK);
=20
 	WREG32(mmMMU_MMU_ENABLE, 1);
 	WREG32(mmMMU_SPI_MASK, 0xF);
@@ -4845,7 +4846,8 @@ static void goya_mmu_prepare(struct hl_device *hdev, =
u32 asid)
 		goya_mmu_prepare_reg(hdev, goya_mmu_regs[i], asid);
 }
=20
-static void goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard=
)
+static void goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard=
,
+					u32 flags)
 {
 	struct goya_device *goya =3D hdev->asic_specific;
 	u32 status, timeout_usec;
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs=
/habanalabs.h
index 78aef59e690b..36d05c32f7ec 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -114,8 +114,8 @@ struct hw_queue_properties {
  * @VM_TYPE_PHYS_PACK: mapping of DRAM memory to device virtual address.
  */
 enum vm_type_t {
-	VM_TYPE_USERPTR,
-	VM_TYPE_PHYS_PACK
+	VM_TYPE_USERPTR =3D 0x1,
+	VM_TYPE_PHYS_PACK =3D 0x2
 };
=20
 /**
@@ -483,8 +483,8 @@ enum hl_pll_frequency {
  * @get_events_stat: retrieve event queue entries histogram.
  * @read_pte: read MMU page table entry from DRAM.
  * @write_pte: write MMU page table entry to DRAM.
- * @mmu_invalidate_cache: flush MMU STLB cache, either with soft (L1 only)=
 or
- *                        hard (L0 & L1) flush.
+ * @mmu_invalidate_cache: flush MMU STLB host/DRAM cache, either with soft
+ *                        (L1 only) or hard (L0 & L1) flush.
  * @mmu_invalidate_cache_range: flush specific MMU STLB cache lines with
  *                              ASID-VA-size mask.
  * @send_heartbeat: send is-alive packet to ArmCP and verify response.
@@ -565,7 +565,8 @@ struct hl_asic_funcs {
 				u32 *size);
 	u64 (*read_pte)(struct hl_device *hdev, u64 addr);
 	void (*write_pte)(struct hl_device *hdev, u64 addr, u64 val);
-	void (*mmu_invalidate_cache)(struct hl_device *hdev, bool is_hard);
+	void (*mmu_invalidate_cache)(struct hl_device *hdev, bool is_hard,
+					u32 flags);
 	void (*mmu_invalidate_cache_range)(struct hl_device *hdev, bool is_hard,
 			u32 asid, u64 va, u64 size);
 	int (*send_heartbeat)(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/mem=
ory.c
index 8ade9886a5a7..12db6609da27 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -944,7 +944,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_=
mem_in *args,
 		goto map_err;
 	}
=20
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, false);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, false, *vm_type);
=20
 	mutex_unlock(&ctx->mmu_lock);
=20
@@ -1060,7 +1060,7 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 va=
ddr)
=20
 	unmap_phys_pg_pack(ctx, vaddr, phys_pg_pack);
=20
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true);
+	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, *vm_type);
=20
 	mutex_unlock(&ctx->mmu_lock);
=20
--=20
2.17.1

