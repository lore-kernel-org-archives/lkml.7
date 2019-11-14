Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEFEC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A57020709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="ee2z3g1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfKNSYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:24:11 -0500
Received: from mail-eopbgr150108.outbound.protection.outlook.com ([40.107.15.108]:50913
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727508AbfKNSYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:24:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X95E6oy0s5VU5AvWWDjVcqa5HCltOw7jCZRF0j02cKKYoXY/oqJLMOKaQJWfMTdYWV/g5FMYWOTjpGSha9D9V+P7gGTmY+wdvBcPvs39ZUad6FXDfppm7MvlSvDmB6hRxF4S7VWQksYeQfvug+cwGWn9GFB4yNun8/ph5eTTuX74rL7oZdK85v+byGprZ6SwsDG03gPM2kGDq8YQjy0aLGo5e2X8q1aDDuzvyivF0QeOxl/oiMtQIfpFKSq4w9zrVMshMeTJen5LRjiAziaV//K2bdcGQHmFO8RzFZbDWQ3J+PnDFMnRpGg/174jQ9PTct/J+j2gMf1Tk3xmkrbITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ47dfDJ71VJHFbB/kzHM41YHUKDScPOeFigEs+ZHlU=;
 b=G1FdniOO/ZvWPMek9rqgHvejCEKSibh5NLKcQs1xk/tFeUZlCy74npztsNLH1VLxuCkmcq5FBAFbbC0B6tUlsZo1ZeOi5RAblD/HyooqlmftvFGSZb+CONvdXTSF8QMzBsuHCpr7r71VPWfRqTPyXEEEyIS1WKPL1IG/07+3R9iPdv0Iu5xa/ENSRv/6HDgkviH5LoN4GiLZYeuVAG82cIMi/z1i36bHA8p5tYAM9qft8uTxVgXAhrikxGjkEr+MonpkDZ7Ct4pL9ZzssLjyteZ4vs2o9ToXxVMg3A9FvdxWj23zvfxNRw3ZlPGBd0Y6z/SKYiVskmGGEO5GhUkYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ47dfDJ71VJHFbB/kzHM41YHUKDScPOeFigEs+ZHlU=;
 b=ee2z3g1nOpU/JqdRTPTWtEOeZEcIfMinOqqnwdV8aKG423eAStFCTBSO2JELkGmLQZiG4MewE2pLdBFOZDfNL0pAh1lFHnUIleATG6Miizu/E9qyOnO6S70z8W7eiecRtJWvrfFBO47U5eNwtFNIy3YendSrDY+B4iq6wkhN6lM=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3383.eurprd02.prod.outlook.com (52.133.29.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Thu, 14 Nov 2019 18:23:55 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 18:23:55 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] habanalabs: split MMU properties to PCI/DRAM
Thread-Topic: [PATCH 3/8] habanalabs: split MMU properties to PCI/DRAM
Thread-Index: AQHVmxisHtjx6lADRUqgukZ6AM8u9g==
Date:   Thu, 14 Nov 2019 18:23:55 +0000
Message-ID: <20191114182346.22675-3-oshpigelman@habana.ai>
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
x-ms-office365-filtering-correlation-id: 56369ca8-1068-40c8-eda6-08d7692fceef
x-ms-traffictypediagnostic: AM6PR0202MB3383:
x-microsoft-antispam-prvs: <AM6PR0202MB3383E7BEEE550A1B4A8EE9F1B8710@AM6PR0202MB3383.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:230;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39840400004)(136003)(366004)(189003)(199004)(71200400001)(6436002)(5640700003)(81166006)(26005)(478600001)(81156014)(186003)(386003)(25786009)(8936002)(14444005)(50226002)(14454004)(256004)(76176011)(6486002)(71190400001)(8676002)(102836004)(2906002)(52116002)(316002)(5660300002)(36756003)(86362001)(4326008)(66556008)(66476007)(66446008)(1361003)(6506007)(64756008)(99286004)(6512007)(7736002)(305945005)(2501003)(66946007)(30864003)(446003)(1076003)(486006)(2616005)(476003)(6116002)(3846002)(11346002)(2351001)(66066001)(6916009)(569006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3383;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uNV+tQgmxKev4OIpLPOav4YLMTWWaUT8/iiF9r4cTq0FA2xO6j99Fn04Xg4zmi9n2W+/0sfmf7hR9R37IsZmtDNsnYQoLDS9hKkGTeZ1C96PRTMlJSwgdf5iinuwDTAo8m2m8H8SncKoyV9/MaBtoMnMmOTq3j/VQ+hqtBCQjk/IUO/ZJX6zIAX+ANci9szuGXzEYn6t6TEaK/aOMUewp3iBZMxQyhBZjVIz/eXxjkBwtNcE8frPwzU5aD8o62Mm/V9aCRA63pv5Nqi6SFlgCPukACkFIwHpZtOD9Vy506XJTGaAaQ6CsQAKVJQ7PcpbHOkSZzKvDoKFOEQ29760ug2X8/rVQRb6uib/QDc8T20cAm9oI0NRRNW2vv3I5v5sBip5RpClnygMjP2x9Ol7Dt7fL8IcckPfEOIyGujDVOtK5qYwatVDRbVALFVRprCn
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 56369ca8-1068-40c8-eda6-08d7692fceef
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 18:23:55.7041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hOovT9fub6VU3nmQN3G387ewDLfLadAmkMBh0aufwUSJ1f707ATAqZmB+1ftVWkt7LKZE50Gs4cH5EpnnHdHaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the properties used for MMU mappings to DRAM and PCI (host) types.
This is a prerequisite for future ASICs support.
Note that in Goya ASIC, the PMMU and DMMU are the same (except of page
sizes) as only one MMU mechanism is used for both of the mapping types.
Hence this patch should not have any effect on current behaviour.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/debugfs.c             |  90 +++++++----
 drivers/misc/habanalabs/goya/goya.c           |  17 ++
 drivers/misc/habanalabs/habanalabs.h          | 112 ++++++++-----
 .../include/hw_ip/mmu/mmu_general.h           |   1 -
 drivers/misc/habanalabs/memory.c              |  40 ++---
 drivers/misc/habanalabs/mmu.c                 | 149 +++++++++++-------
 6 files changed, 265 insertions(+), 144 deletions(-)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/de=
bugfs.c
index 1e1fa619a225..1cf75010a379 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -307,39 +307,51 @@ static inline u64 get_hop0_addr(struct hl_ctx *ctx)
 			(ctx->asid * ctx->hdev->asic_prop.mmu_hop_table_size);
 }
=20
-static inline u64 get_hop0_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
-		u64 virt_addr)
+static inline u64 get_hopN_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
+					u64 virt_addr, u64 mask, u64 shift)
 {
 	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
-			((virt_addr & HOP0_MASK) >> HOP0_SHIFT);
+			((virt_addr & mask) >> shift);
 }
=20
-static inline u64 get_hop1_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
-		u64 virt_addr)
+static inline u64 get_hop0_pte_addr(struct hl_ctx *ctx,
+					struct hl_mmu_properties *mmu_specs,
+					u64 hop_addr, u64 vaddr)
 {
-	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
-			((virt_addr & HOP1_MASK) >> HOP1_SHIFT);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_specs->hop0_mask,
+					mmu_specs->hop0_shift);
 }
=20
-static inline u64 get_hop2_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
-		u64 virt_addr)
+static inline u64 get_hop1_pte_addr(struct hl_ctx *ctx,
+					struct hl_mmu_properties *mmu_specs,
+					u64 hop_addr, u64 vaddr)
 {
-	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
-			((virt_addr & HOP2_MASK) >> HOP2_SHIFT);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_specs->hop1_mask,
+					mmu_specs->hop1_shift);
 }
=20
-static inline u64 get_hop3_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
-		u64 virt_addr)
+static inline u64 get_hop2_pte_addr(struct hl_ctx *ctx,
+					struct hl_mmu_properties *mmu_specs,
+					u64 hop_addr, u64 vaddr)
 {
-	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
-			((virt_addr & HOP3_MASK) >> HOP3_SHIFT);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_specs->hop2_mask,
+					mmu_specs->hop2_shift);
 }
=20
-static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx, u64 hop_addr,
-		u64 virt_addr)
+static inline u64 get_hop3_pte_addr(struct hl_ctx *ctx,
+					struct hl_mmu_properties *mmu_specs,
+					u64 hop_addr, u64 vaddr)
 {
-	return hop_addr + ctx->hdev->asic_prop.mmu_pte_size *
-			((virt_addr & HOP4_MASK) >> HOP4_SHIFT);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_specs->hop3_mask,
+					mmu_specs->hop3_shift);
+}
+
+static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx,
+					struct hl_mmu_properties *mmu_specs,
+					u64 hop_addr, u64 vaddr)
+{
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_specs->hop4_mask,
+					mmu_specs->hop4_shift);
 }
=20
 static inline u64 get_next_hop_addr(u64 curr_pte)
@@ -355,7 +367,10 @@ static int mmu_show(struct seq_file *s, void *data)
 	struct hl_debugfs_entry *entry =3D s->private;
 	struct hl_dbg_device_entry *dev_entry =3D entry->dev_entry;
 	struct hl_device *hdev =3D dev_entry->hdev;
+	struct asic_fixed_properties *prop =3D &hdev->asic_prop;
+	struct hl_mmu_properties *mmu_prop;
 	struct hl_ctx *ctx;
+	bool is_dram_addr;
=20
 	u64 hop0_addr =3D 0, hop0_pte_addr =3D 0, hop0_pte =3D 0,
 		hop1_addr =3D 0, hop1_pte_addr =3D 0, hop1_pte =3D 0,
@@ -377,33 +392,39 @@ static int mmu_show(struct seq_file *s, void *data)
 		return 0;
 	}
=20
+	is_dram_addr =3D hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size=
,
+				prop->va_space_dram_start_address,
+				prop->va_space_dram_end_address);
+
+	mmu_prop =3D is_dram_addr ? &prop->dmmu : &prop->pmmu;
+
 	mutex_lock(&ctx->mmu_lock);
=20
 	/* the following lookup is copied from unmap() in mmu.c */
=20
 	hop0_addr =3D get_hop0_addr(ctx);
-	hop0_pte_addr =3D get_hop0_pte_addr(ctx, hop0_addr, virt_addr);
+	hop0_pte_addr =3D get_hop0_pte_addr(ctx, mmu_prop, hop0_addr, virt_addr);
 	hop0_pte =3D hdev->asic_funcs->read_pte(hdev, hop0_pte_addr);
 	hop1_addr =3D get_next_hop_addr(hop0_pte);
=20
 	if (hop1_addr =3D=3D ULLONG_MAX)
 		goto not_mapped;
=20
-	hop1_pte_addr =3D get_hop1_pte_addr(ctx, hop1_addr, virt_addr);
+	hop1_pte_addr =3D get_hop1_pte_addr(ctx, mmu_prop, hop1_addr, virt_addr);
 	hop1_pte =3D hdev->asic_funcs->read_pte(hdev, hop1_pte_addr);
 	hop2_addr =3D get_next_hop_addr(hop1_pte);
=20
 	if (hop2_addr =3D=3D ULLONG_MAX)
 		goto not_mapped;
=20
-	hop2_pte_addr =3D get_hop2_pte_addr(ctx, hop2_addr, virt_addr);
+	hop2_pte_addr =3D get_hop2_pte_addr(ctx, mmu_prop, hop2_addr, virt_addr);
 	hop2_pte =3D hdev->asic_funcs->read_pte(hdev, hop2_pte_addr);
 	hop3_addr =3D get_next_hop_addr(hop2_pte);
=20
 	if (hop3_addr =3D=3D ULLONG_MAX)
 		goto not_mapped;
=20
-	hop3_pte_addr =3D get_hop3_pte_addr(ctx, hop3_addr, virt_addr);
+	hop3_pte_addr =3D get_hop3_pte_addr(ctx, mmu_prop, hop3_addr, virt_addr);
 	hop3_pte =3D hdev->asic_funcs->read_pte(hdev, hop3_pte_addr);
=20
 	if (!(hop3_pte & LAST_MASK)) {
@@ -412,7 +433,8 @@ static int mmu_show(struct seq_file *s, void *data)
 		if (hop4_addr =3D=3D ULLONG_MAX)
 			goto not_mapped;
=20
-		hop4_pte_addr =3D get_hop4_pte_addr(ctx, hop4_addr, virt_addr);
+		hop4_pte_addr =3D get_hop4_pte_addr(ctx, mmu_prop, hop4_addr,
+							virt_addr);
 		hop4_pte =3D hdev->asic_funcs->read_pte(hdev, hop4_pte_addr);
 		if (!(hop4_pte & PAGE_PRESENT_MASK))
 			goto not_mapped;
@@ -534,41 +556,50 @@ static int device_va_to_pa(struct hl_device *hdev, u6=
4 virt_addr,
 				u64 *phys_addr)
 {
 	struct hl_ctx *ctx =3D hdev->compute_ctx;
+	struct asic_fixed_properties *prop =3D &hdev->asic_prop;
+	struct hl_mmu_properties *mmu_prop;
 	u64 hop_addr, hop_pte_addr, hop_pte;
 	u64 offset_mask =3D HOP4_MASK | FLAGS_MASK;
 	int rc =3D 0;
+	bool is_dram_addr;
=20
 	if (!ctx) {
 		dev_err(hdev->dev, "no ctx available\n");
 		return -EINVAL;
 	}
=20
+	is_dram_addr =3D hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size=
,
+				prop->va_space_dram_start_address,
+				prop->va_space_dram_end_address);
+
+	mmu_prop =3D is_dram_addr ? &prop->dmmu : &prop->pmmu;
+
 	mutex_lock(&ctx->mmu_lock);
=20
 	/* hop 0 */
 	hop_addr =3D get_hop0_addr(ctx);
-	hop_pte_addr =3D get_hop0_pte_addr(ctx, hop_addr, virt_addr);
+	hop_pte_addr =3D get_hop0_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
 	hop_pte =3D hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
=20
 	/* hop 1 */
 	hop_addr =3D get_next_hop_addr(hop_pte);
 	if (hop_addr =3D=3D ULLONG_MAX)
 		goto not_mapped;
-	hop_pte_addr =3D get_hop1_pte_addr(ctx, hop_addr, virt_addr);
+	hop_pte_addr =3D get_hop1_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
 	hop_pte =3D hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
=20
 	/* hop 2 */
 	hop_addr =3D get_next_hop_addr(hop_pte);
 	if (hop_addr =3D=3D ULLONG_MAX)
 		goto not_mapped;
-	hop_pte_addr =3D get_hop2_pte_addr(ctx, hop_addr, virt_addr);
+	hop_pte_addr =3D get_hop2_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
 	hop_pte =3D hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
=20
 	/* hop 3 */
 	hop_addr =3D get_next_hop_addr(hop_pte);
 	if (hop_addr =3D=3D ULLONG_MAX)
 		goto not_mapped;
-	hop_pte_addr =3D get_hop3_pte_addr(ctx, hop_addr, virt_addr);
+	hop_pte_addr =3D get_hop3_pte_addr(ctx, mmu_prop, hop_addr, virt_addr);
 	hop_pte =3D hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
=20
 	if (!(hop_pte & LAST_MASK)) {
@@ -576,7 +607,8 @@ static int device_va_to_pa(struct hl_device *hdev, u64 =
virt_addr,
 		hop_addr =3D get_next_hop_addr(hop_pte);
 		if (hop_addr =3D=3D ULLONG_MAX)
 			goto not_mapped;
-		hop_pte_addr =3D get_hop4_pte_addr(ctx, hop_addr, virt_addr);
+		hop_pte_addr =3D get_hop4_pte_addr(ctx, mmu_prop, hop_addr,
+							virt_addr);
 		hop_pte =3D hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
=20
 		offset_mask =3D FLAGS_MASK;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/=
goya/goya.c
index 3c22fb96a26f..3294a6a92f75 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -380,6 +380,23 @@ void goya_get_fixed_properties(struct hl_device *hdev)
 	prop->mmu_hop0_tables_total_size =3D HOP0_TABLES_TOTAL_SIZE;
 	prop->dram_page_size =3D PAGE_SIZE_2MB;
=20
+	prop->dmmu.hop0_shift =3D HOP0_SHIFT;
+	prop->dmmu.hop1_shift =3D HOP1_SHIFT;
+	prop->dmmu.hop2_shift =3D HOP2_SHIFT;
+	prop->dmmu.hop3_shift =3D HOP3_SHIFT;
+	prop->dmmu.hop4_shift =3D HOP4_SHIFT;
+	prop->dmmu.hop0_mask =3D HOP0_MASK;
+	prop->dmmu.hop1_mask =3D HOP1_MASK;
+	prop->dmmu.hop2_mask =3D HOP2_MASK;
+	prop->dmmu.hop3_mask =3D HOP3_MASK;
+	prop->dmmu.hop4_mask =3D HOP4_MASK;
+	prop->dmmu.huge_page_size =3D PAGE_SIZE_2MB;
+
+	/* No difference between PMMU and DMMU except of page size */
+	memcpy(&prop->pmmu, &prop->dmmu, sizeof(prop->dmmu));
+	prop->dmmu.page_size =3D PAGE_SIZE_2MB;
+	prop->pmmu.page_size =3D PAGE_SIZE_4KB;
+
 	prop->va_space_host_start_address =3D VA_HOST_SPACE_START;
 	prop->va_space_host_end_address =3D VA_HOST_SPACE_END;
 	prop->va_space_dram_start_address =3D VA_DDR_SPACE_START;
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs=
/habanalabs.h
index 36d05c32f7ec..5080fbcfabfd 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -130,6 +130,36 @@ enum hl_device_hw_state {
 	HL_DEVICE_HW_STATE_DIRTY
 };
=20
+/**
+ * struct hl_mmu_properties - ASIC specific MMU address translation proper=
ties.
+ * @hop0_shift: shift of hop 0 mask.
+ * @hop1_shift: shift of hop 1 mask.
+ * @hop2_shift: shift of hop 2 mask.
+ * @hop3_shift: shift of hop 3 mask.
+ * @hop4_shift: shift of hop 4 mask.
+ * @hop0_mask: mask to get the PTE address in hop 0.
+ * @hop1_mask: mask to get the PTE address in hop 1.
+ * @hop2_mask: mask to get the PTE address in hop 2.
+ * @hop3_mask: mask to get the PTE address in hop 3.
+ * @hop4_mask: mask to get the PTE address in hop 4.
+ * @page_size: default page size used to allocate memory.
+ * @huge_page_size: page size used to allocate memory with huge pages.
+ */
+struct hl_mmu_properties {
+	u64	hop0_shift;
+	u64	hop1_shift;
+	u64	hop2_shift;
+	u64	hop3_shift;
+	u64	hop4_shift;
+	u64	hop0_mask;
+	u64	hop1_mask;
+	u64	hop2_mask;
+	u64	hop3_mask;
+	u64	hop4_mask;
+	u32	page_size;
+	u32	huge_page_size;
+};
+
 /**
  * struct asic_fixed_properties - ASIC specific immutable properties.
  * @hw_queues_props: H/W queues properties.
@@ -137,6 +167,8 @@ enum hl_device_hw_state {
  *		available sensors.
  * @uboot_ver: F/W U-boot version.
  * @preboot_ver: F/W Preboot version.
+ * @dmmu: DRAM MMU address translation properties.
+ * @pmmu: PCI (host) MMU address translation properties.
  * @sram_base_address: SRAM physical start address.
  * @sram_end_address: SRAM physical end address.
  * @sram_user_base_address - SRAM physical start address for user access.
@@ -181,45 +213,47 @@ enum hl_device_hw_state {
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	hw_queues_props[HL_MAX_QUEUES];
-	struct armcp_info	armcp_info;
-	char			uboot_ver[VERSION_MAX_LEN];
-	char			preboot_ver[VERSION_MAX_LEN];
-	u64			sram_base_address;
-	u64			sram_end_address;
-	u64			sram_user_base_address;
-	u64			dram_base_address;
-	u64			dram_end_address;
-	u64			dram_user_base_address;
-	u64			dram_size;
-	u64			dram_pci_bar_size;
-	u64			max_power_default;
-	u64			va_space_host_start_address;
-	u64			va_space_host_end_address;
-	u64			va_space_dram_start_address;
-	u64			va_space_dram_end_address;
-	u64			dram_size_for_default_page_mapping;
-	u64			pcie_dbi_base_address;
-	u64			pcie_aux_dbi_reg_addr;
-	u64			mmu_pgt_addr;
-	u64			mmu_dram_default_page_addr;
-	u32			mmu_pgt_size;
-	u32			mmu_pte_size;
-	u32			mmu_hop_table_size;
-	u32			mmu_hop0_tables_total_size;
-	u32			dram_page_size;
-	u32			cfg_size;
-	u32			sram_size;
-	u32			max_asid;
-	u32			num_of_events;
-	u32			psoc_pci_pll_nr;
-	u32			psoc_pci_pll_nf;
-	u32			psoc_pci_pll_od;
-	u32			psoc_pci_pll_div_factor;
-	u32			high_pll;
-	u32			cb_pool_cb_cnt;
-	u32			cb_pool_cb_size;
-	u8			completion_queues_count;
-	u8			tpc_enabled_mask;
+	struct armcp_info		armcp_info;
+	char				uboot_ver[VERSION_MAX_LEN];
+	char				preboot_ver[VERSION_MAX_LEN];
+	struct hl_mmu_properties	dmmu;
+	struct hl_mmu_properties	pmmu;
+	u64				sram_base_address;
+	u64				sram_end_address;
+	u64				sram_user_base_address;
+	u64				dram_base_address;
+	u64				dram_end_address;
+	u64				dram_user_base_address;
+	u64				dram_size;
+	u64				dram_pci_bar_size;
+	u64				max_power_default;
+	u64				va_space_host_start_address;
+	u64				va_space_host_end_address;
+	u64				va_space_dram_start_address;
+	u64				va_space_dram_end_address;
+	u64				dram_size_for_default_page_mapping;
+	u64				pcie_dbi_base_address;
+	u64				pcie_aux_dbi_reg_addr;
+	u64				mmu_pgt_addr;
+	u64				mmu_dram_default_page_addr;
+	u32				mmu_pgt_size;
+	u32				mmu_pte_size;
+	u32				mmu_hop_table_size;
+	u32				mmu_hop0_tables_total_size;
+	u32				dram_page_size;
+	u32				cfg_size;
+	u32				sram_size;
+	u32				max_asid;
+	u32				num_of_events;
+	u32				psoc_pci_pll_nr;
+	u32				psoc_pci_pll_nf;
+	u32				psoc_pci_pll_od;
+	u32				psoc_pci_pll_div_factor;
+	u32				high_pll;
+	u32				cb_pool_cb_cnt;
+	u32				cb_pool_cb_size;
+	u8				completion_queues_count;
+	u8				tpc_enabled_mask;
 };
=20
 /**
diff --git a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h b/driv=
ers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
index 74a5502b8c4e..a6851a9d3f03 100644
--- a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
+++ b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
@@ -12,7 +12,6 @@
 #define PAGE_SHIFT_2MB			21
 #define PAGE_SIZE_2MB			(_AC(1, UL) << PAGE_SHIFT_2MB)
 #define PAGE_SIZE_4KB			(_AC(1, UL) << PAGE_SHIFT_4KB)
-#define PAGE_MASK_2MB			(~(PAGE_SIZE_2MB - 1))
=20
 #define PAGE_PRESENT_MASK		0x0000000000001ull
 #define SWAP_OUT_MASK			0x0000000000004ull
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/mem=
ory.c
index 12db6609da27..1e0ebd3f6e36 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/genalloc.h>
=20
-#define PGS_IN_2MB_PAGE	(PAGE_SIZE_2MB >> PAGE_SHIFT)
 #define HL_MMU_DEBUG	0
=20
 /*
@@ -525,18 +524,17 @@ static u64 get_va_block(struct hl_device *hdev,
 	u32 page_size;
 	bool add_prev =3D false;
=20
-	if (is_userptr) {
+	if (is_userptr)
 		/*
 		 * We cannot know if the user allocated memory with huge pages
 		 * or not, hence we continue with the biggest possible
 		 * granularity.
 		 */
-		page_size =3D PAGE_SIZE_2MB;
-		page_mask =3D PAGE_MASK_2MB;
-	} else {
-		page_size =3D hdev->asic_prop.dram_page_size;
-		page_mask =3D ~((u64)page_size - 1);
-	}
+		page_size =3D hdev->asic_prop.pmmu.huge_page_size;
+	else
+		page_size =3D hdev->asic_prop.dmmu.page_size;
+
+	page_mask =3D ~((u64)page_size - 1);
=20
 	mutex_lock(&va_range->lock);
=20
@@ -629,7 +627,7 @@ static u32 get_sg_info(struct scatterlist *sg, dma_addr=
_t *dma_addr)
 /*
  * init_phys_pg_pack_from_userptr - initialize physical page pack from hos=
t
  *                                  memory
- * @asid: current context ASID
+ * @ctx: current context
  * @userptr: userptr to initialize from
  * @pphys_pg_pack: result pointer
  *
@@ -638,16 +636,20 @@ static u32 get_sg_info(struct scatterlist *sg, dma_ad=
dr_t *dma_addr)
  * - Create a physical page pack from the physical pages related to the gi=
ven
  *   virtual block
  */
-static int init_phys_pg_pack_from_userptr(u32 asid, struct hl_userptr *use=
rptr,
+static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
+				struct hl_userptr *userptr,
 				struct hl_vm_phys_pg_pack **pphys_pg_pack)
 {
+	struct hl_mmu_properties *mmu_prop =3D &ctx->hdev->asic_prop.pmmu;
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
 	struct scatterlist *sg;
 	dma_addr_t dma_addr;
 	u64 page_mask, total_npages;
-	u32 npages, page_size =3D PAGE_SIZE;
+	u32 npages, page_size =3D PAGE_SIZE,
+		huge_page_size =3D mmu_prop->huge_page_size;
 	bool first =3D true, is_huge_page_opt =3D true;
 	int rc, i, j;
+	u32 pgs_in_huge_page =3D huge_page_size >> __ffs(page_size);
=20
 	phys_pg_pack =3D kzalloc(sizeof(*phys_pg_pack), GFP_KERNEL);
 	if (!phys_pg_pack)
@@ -655,7 +657,7 @@ static int init_phys_pg_pack_from_userptr(u32 asid, str=
uct hl_userptr *userptr,
=20
 	phys_pg_pack->vm_type =3D userptr->vm_type;
 	phys_pg_pack->created_from_userptr =3D true;
-	phys_pg_pack->asid =3D asid;
+	phys_pg_pack->asid =3D ctx->asid;
 	atomic_set(&phys_pg_pack->mapping_cnt, 1);
=20
 	/* Only if all dma_addrs are aligned to 2MB and their
@@ -670,14 +672,14 @@ static int init_phys_pg_pack_from_userptr(u32 asid, s=
truct hl_userptr *userptr,
=20
 		total_npages +=3D npages;
=20
-		if ((npages % PGS_IN_2MB_PAGE) ||
-					(dma_addr & (PAGE_SIZE_2MB - 1)))
+		if ((npages % pgs_in_huge_page) ||
+					(dma_addr & (huge_page_size - 1)))
 			is_huge_page_opt =3D false;
 	}
=20
 	if (is_huge_page_opt) {
-		page_size =3D PAGE_SIZE_2MB;
-		total_npages /=3D PGS_IN_2MB_PAGE;
+		page_size =3D huge_page_size;
+		total_npages /=3D pgs_in_huge_page;
 	}
=20
 	page_mask =3D ~(((u64) page_size) - 1);
@@ -709,7 +711,7 @@ static int init_phys_pg_pack_from_userptr(u32 asid, str=
uct hl_userptr *userptr,
 			dma_addr +=3D page_size;
=20
 			if (is_huge_page_opt)
-				npages -=3D PGS_IN_2MB_PAGE;
+				npages -=3D pgs_in_huge_page;
 			else
 				npages--;
 		}
@@ -872,7 +874,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_=
mem_in *args,
 			return rc;
 		}
=20
-		rc =3D init_phys_pg_pack_from_userptr(ctx->asid, userptr,
+		rc =3D init_phys_pg_pack_from_userptr(ctx, userptr,
 				&phys_pg_pack);
 		if (rc) {
 			dev_err(hdev->dev,
@@ -1029,7 +1031,7 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 va=
ddr)
 	if (*vm_type =3D=3D VM_TYPE_USERPTR) {
 		is_userptr =3D true;
 		userptr =3D hnode->ptr;
-		rc =3D init_phys_pg_pack_from_userptr(ctx->asid, userptr,
+		rc =3D init_phys_pg_pack_from_userptr(ctx, userptr,
 							&phys_pg_pack);
 		if (rc) {
 			dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index 21b4e3281b3e..3a7f8ff19eb2 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -171,29 +171,44 @@ static inline u64 get_hopN_pte_addr(struct hl_ctx *ct=
x, u64 hop_addr,
 			((virt_addr & mask) >> shift);
 }
=20
-static inline u64 get_hop0_pte_addr(struct hl_ctx *ctx, u64 hop_addr, u64 =
vaddr)
+static inline u64 get_hop0_pte_addr(struct hl_ctx *ctx,
+					struct hl_mmu_properties *mmu_prop,
+					u64 hop_addr, u64 vaddr)
 {
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, HOP0_MASK, HOP0_SHIFT);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop0_mask,
+					mmu_prop->hop0_shift);
 }
=20
-static inline u64 get_hop1_pte_addr(struct hl_ctx *ctx, u64 hop_addr, u64 =
vaddr)
+static inline u64 get_hop1_pte_addr(struct hl_ctx *ctx,
+					struct hl_mmu_properties *mmu_prop,
+					u64 hop_addr, u64 vaddr)
 {
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, HOP1_MASK, HOP1_SHIFT);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop1_mask,
+					mmu_prop->hop1_shift);
 }
=20
-static inline u64 get_hop2_pte_addr(struct hl_ctx *ctx, u64 hop_addr, u64 =
vaddr)
+static inline u64 get_hop2_pte_addr(struct hl_ctx *ctx,
+					struct hl_mmu_properties *mmu_prop,
+					u64 hop_addr, u64 vaddr)
 {
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, HOP2_MASK, HOP2_SHIFT);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop2_mask,
+					mmu_prop->hop2_shift);
 }
=20
-static inline u64 get_hop3_pte_addr(struct hl_ctx *ctx, u64 hop_addr, u64 =
vaddr)
+static inline u64 get_hop3_pte_addr(struct hl_ctx *ctx,
+					struct hl_mmu_properties *mmu_prop,
+					u64 hop_addr, u64 vaddr)
 {
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, HOP3_MASK, HOP3_SHIFT);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop3_mask,
+					mmu_prop->hop3_shift);
 }
=20
-static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx, u64 hop_addr, u64 =
vaddr)
+static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx,
+					struct hl_mmu_properties *mmu_prop,
+					u64 hop_addr, u64 vaddr)
 {
-	return get_hopN_pte_addr(ctx, hop_addr, vaddr, HOP4_MASK, HOP4_SHIFT);
+	return get_hopN_pte_addr(ctx, hop_addr, vaddr, mmu_prop->hop4_mask,
+					mmu_prop->hop4_shift);
 }
=20
 static inline u64 get_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte)
@@ -513,24 +528,23 @@ void hl_mmu_ctx_fini(struct hl_ctx *ctx)
 	mutex_destroy(&ctx->mmu_lock);
 }
=20
-static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr)
+static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, bool is_dram_a=
ddr)
 {
 	struct hl_device *hdev =3D ctx->hdev;
 	struct asic_fixed_properties *prop =3D &hdev->asic_prop;
+	struct hl_mmu_properties *mmu_prop;
 	u64 hop0_addr =3D 0, hop0_pte_addr =3D 0,
 		hop1_addr =3D 0, hop1_pte_addr =3D 0,
 		hop2_addr =3D 0, hop2_pte_addr =3D 0,
 		hop3_addr =3D 0, hop3_pte_addr =3D 0,
 		hop4_addr =3D 0, hop4_pte_addr =3D 0,
 		curr_pte;
-	bool is_dram_addr, is_huge, clear_hop3 =3D true;
+	bool is_huge, clear_hop3 =3D true;
=20
-	is_dram_addr =3D hl_mem_area_inside_range(virt_addr, PAGE_SIZE_2MB,
-				prop->va_space_dram_start_address,
-				prop->va_space_dram_end_address);
+	mmu_prop =3D is_dram_addr ? &prop->dmmu : &prop->pmmu;
=20
 	hop0_addr =3D get_hop0_addr(ctx);
-	hop0_pte_addr =3D get_hop0_pte_addr(ctx, hop0_addr, virt_addr);
+	hop0_pte_addr =3D get_hop0_pte_addr(ctx, mmu_prop, hop0_addr, virt_addr);
=20
 	curr_pte =3D *(u64 *) (uintptr_t) hop0_pte_addr;
=20
@@ -539,7 +553,7 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_a=
ddr)
 	if (hop1_addr =3D=3D ULLONG_MAX)
 		goto not_mapped;
=20
-	hop1_pte_addr =3D get_hop1_pte_addr(ctx, hop1_addr, virt_addr);
+	hop1_pte_addr =3D get_hop1_pte_addr(ctx, mmu_prop, hop1_addr, virt_addr);
=20
 	curr_pte =3D *(u64 *) (uintptr_t) hop1_pte_addr;
=20
@@ -548,7 +562,7 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_a=
ddr)
 	if (hop2_addr =3D=3D ULLONG_MAX)
 		goto not_mapped;
=20
-	hop2_pte_addr =3D get_hop2_pte_addr(ctx, hop2_addr, virt_addr);
+	hop2_pte_addr =3D get_hop2_pte_addr(ctx, mmu_prop, hop2_addr, virt_addr);
=20
 	curr_pte =3D *(u64 *) (uintptr_t) hop2_pte_addr;
=20
@@ -557,7 +571,7 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_a=
ddr)
 	if (hop3_addr =3D=3D ULLONG_MAX)
 		goto not_mapped;
=20
-	hop3_pte_addr =3D get_hop3_pte_addr(ctx, hop3_addr, virt_addr);
+	hop3_pte_addr =3D get_hop3_pte_addr(ctx, mmu_prop, hop3_addr, virt_addr);
=20
 	curr_pte =3D *(u64 *) (uintptr_t) hop3_pte_addr;
=20
@@ -575,7 +589,8 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_a=
ddr)
 		if (hop4_addr =3D=3D ULLONG_MAX)
 			goto not_mapped;
=20
-		hop4_pte_addr =3D get_hop4_pte_addr(ctx, hop4_addr, virt_addr);
+		hop4_pte_addr =3D get_hop4_pte_addr(ctx, mmu_prop, hop4_addr,
+							virt_addr);
=20
 		curr_pte =3D *(u64 *) (uintptr_t) hop4_pte_addr;
=20
@@ -667,25 +682,36 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt=
_addr)
 int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32 page_size)
 {
 	struct hl_device *hdev =3D ctx->hdev;
+	struct asic_fixed_properties *prop =3D &hdev->asic_prop;
+	struct hl_mmu_properties *mmu_prop;
 	u64 real_virt_addr;
 	u32 real_page_size, npages;
 	int i, rc;
+	bool is_dram_addr;
=20
 	if (!hdev->mmu_enable)
 		return 0;
=20
+	is_dram_addr =3D hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size=
,
+				prop->va_space_dram_start_address,
+				prop->va_space_dram_end_address);
+
+	mmu_prop =3D is_dram_addr ? &prop->dmmu : &prop->pmmu;
+
 	/*
-	 * The H/W handles mapping of 4KB/2MB page. Hence if the host page size
-	 * is bigger, we break it to sub-pages and unmap them separately.
+	 * The H/W handles mapping of specific page sizes. Hence if the page
+	 * size is bigger, we break it to sub-pages and unmap them separately.
 	 */
-	if ((page_size % PAGE_SIZE_2MB) =3D=3D 0) {
-		real_page_size =3D PAGE_SIZE_2MB;
-	} else if ((page_size % PAGE_SIZE_4KB) =3D=3D 0) {
-		real_page_size =3D PAGE_SIZE_4KB;
+	if ((page_size % mmu_prop->huge_page_size) =3D=3D 0) {
+		real_page_size =3D mmu_prop->huge_page_size;
+	} else if ((page_size % mmu_prop->page_size) =3D=3D 0) {
+		real_page_size =3D mmu_prop->page_size;
 	} else {
 		dev_err(hdev->dev,
-			"page size of %u is not 4KB nor 2MB aligned, can't unmap\n",
-				page_size);
+			"page size of %u is not %uKB nor %uMB aligned, can't unmap\n",
+			page_size,
+			mmu_prop->page_size >> 10,
+			mmu_prop->huge_page_size >> 20);
=20
 		return -EFAULT;
 	}
@@ -694,7 +720,7 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u32=
 page_size)
 	real_virt_addr =3D virt_addr;
=20
 	for (i =3D 0 ; i < npages ; i++) {
-		rc =3D _hl_mmu_unmap(ctx, real_virt_addr);
+		rc =3D _hl_mmu_unmap(ctx, real_virt_addr, is_dram_addr);
 		if (rc)
 			return rc;
=20
@@ -705,10 +731,11 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u=
32 page_size)
 }
=20
 static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
-		u32 page_size)
+			u32 page_size, bool is_dram_addr)
 {
 	struct hl_device *hdev =3D ctx->hdev;
 	struct asic_fixed_properties *prop =3D &hdev->asic_prop;
+	struct hl_mmu_properties *mmu_prop;
 	u64 hop0_addr =3D 0, hop0_pte_addr =3D 0,
 		hop1_addr =3D 0, hop1_pte_addr =3D 0,
 		hop2_addr =3D 0, hop2_pte_addr =3D 0,
@@ -716,21 +743,19 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_a=
ddr, u64 phys_addr,
 		hop4_addr =3D 0, hop4_pte_addr =3D 0,
 		curr_pte =3D 0;
 	bool hop1_new =3D false, hop2_new =3D false, hop3_new =3D false,
-		hop4_new =3D false, is_huge, is_dram_addr;
+		hop4_new =3D false, is_huge;
 	int rc =3D -ENOMEM;
=20
+	mmu_prop =3D is_dram_addr ? &prop->dmmu : &prop->pmmu;
+
 	/*
-	 * This mapping function can map a 4KB/2MB page. For 2MB page there are
-	 * only 3 hops rather than 4. Currently the DRAM allocation uses 2MB
-	 * pages only but user memory could have been allocated with one of the
-	 * two page sizes. Since this is a common code for all the three cases,
-	 * we need this hugs page check.
+	 * This mapping function can map a page or a huge page. For huge page
+	 * there are only 3 hops rather than 4. Currently the DRAM allocation
+	 * uses huge pages only but user memory could have been allocated with
+	 * one of the two page sizes. Since this is a common code for all the
+	 * three cases, we need this hugs page check.
 	 */
-	is_huge =3D page_size =3D=3D PAGE_SIZE_2MB;
-
-	is_dram_addr =3D hl_mem_area_inside_range(virt_addr, page_size,
-				prop->va_space_dram_start_address,
-				prop->va_space_dram_end_address);
+	is_huge =3D page_size =3D=3D mmu_prop->huge_page_size;
=20
 	if (is_dram_addr && !is_huge) {
 		dev_err(hdev->dev, "DRAM mapping should use huge pages only\n");
@@ -738,28 +763,28 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_a=
ddr, u64 phys_addr,
 	}
=20
 	hop0_addr =3D get_hop0_addr(ctx);
-	hop0_pte_addr =3D get_hop0_pte_addr(ctx, hop0_addr, virt_addr);
+	hop0_pte_addr =3D get_hop0_pte_addr(ctx, mmu_prop, hop0_addr, virt_addr);
 	curr_pte =3D *(u64 *) (uintptr_t) hop0_pte_addr;
=20
 	hop1_addr =3D get_alloc_next_hop_addr(ctx, curr_pte, &hop1_new);
 	if (hop1_addr =3D=3D ULLONG_MAX)
 		goto err;
=20
-	hop1_pte_addr =3D get_hop1_pte_addr(ctx, hop1_addr, virt_addr);
+	hop1_pte_addr =3D get_hop1_pte_addr(ctx, mmu_prop, hop1_addr, virt_addr);
 	curr_pte =3D *(u64 *) (uintptr_t) hop1_pte_addr;
=20
 	hop2_addr =3D get_alloc_next_hop_addr(ctx, curr_pte, &hop2_new);
 	if (hop2_addr =3D=3D ULLONG_MAX)
 		goto err;
=20
-	hop2_pte_addr =3D get_hop2_pte_addr(ctx, hop2_addr, virt_addr);
+	hop2_pte_addr =3D get_hop2_pte_addr(ctx, mmu_prop, hop2_addr, virt_addr);
 	curr_pte =3D *(u64 *) (uintptr_t) hop2_pte_addr;
=20
 	hop3_addr =3D get_alloc_next_hop_addr(ctx, curr_pte, &hop3_new);
 	if (hop3_addr =3D=3D ULLONG_MAX)
 		goto err;
=20
-	hop3_pte_addr =3D get_hop3_pte_addr(ctx, hop3_addr, virt_addr);
+	hop3_pte_addr =3D get_hop3_pte_addr(ctx, mmu_prop, hop3_addr, virt_addr);
 	curr_pte =3D *(u64 *) (uintptr_t) hop3_pte_addr;
=20
 	if (!is_huge) {
@@ -767,7 +792,8 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_add=
r, u64 phys_addr,
 		if (hop4_addr =3D=3D ULLONG_MAX)
 			goto err;
=20
-		hop4_pte_addr =3D get_hop4_pte_addr(ctx, hop4_addr, virt_addr);
+		hop4_pte_addr =3D get_hop4_pte_addr(ctx, mmu_prop, hop4_addr,
+							virt_addr);
 		curr_pte =3D *(u64 *) (uintptr_t) hop4_pte_addr;
 	}
=20
@@ -890,25 +916,36 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_a=
ddr, u64 phys_addr,
 int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_=
size)
 {
 	struct hl_device *hdev =3D ctx->hdev;
+	struct asic_fixed_properties *prop =3D &hdev->asic_prop;
+	struct hl_mmu_properties *mmu_prop;
 	u64 real_virt_addr, real_phys_addr;
 	u32 real_page_size, npages;
 	int i, rc, mapped_cnt =3D 0;
+	bool is_dram_addr;
=20
 	if (!hdev->mmu_enable)
 		return 0;
=20
+	is_dram_addr =3D hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size=
,
+				prop->va_space_dram_start_address,
+				prop->va_space_dram_end_address);
+
+	mmu_prop =3D is_dram_addr ? &prop->dmmu : &prop->pmmu;
+
 	/*
-	 * The H/W handles mapping of 4KB/2MB page. Hence if the host page size
-	 * is bigger, we break it to sub-pages and map them separately.
+	 * The H/W handles mapping of specific page sizes. Hence if the page
+	 * size is bigger, we break it to sub-pages and map them separately.
 	 */
-	if ((page_size % PAGE_SIZE_2MB) =3D=3D 0) {
-		real_page_size =3D PAGE_SIZE_2MB;
-	} else if ((page_size % PAGE_SIZE_4KB) =3D=3D 0) {
-		real_page_size =3D PAGE_SIZE_4KB;
+	if ((page_size % mmu_prop->huge_page_size) =3D=3D 0) {
+		real_page_size =3D mmu_prop->huge_page_size;
+	} else if ((page_size % mmu_prop->page_size) =3D=3D 0) {
+		real_page_size =3D mmu_prop->page_size;
 	} else {
 		dev_err(hdev->dev,
-			"page size of %u is not 4KB nor 2MB aligned, can't map\n",
-				page_size);
+			"page size of %u is not %dKB nor %dMB aligned, can't unmap\n",
+			page_size,
+			mmu_prop->page_size >> 10,
+			mmu_prop->huge_page_size >> 20);
=20
 		return -EFAULT;
 	}
@@ -923,7 +960,7 @@ int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 p=
hys_addr, u32 page_size)
=20
 	for (i =3D 0 ; i < npages ; i++) {
 		rc =3D _hl_mmu_map(ctx, real_virt_addr, real_phys_addr,
-				real_page_size);
+				real_page_size, is_dram_addr);
 		if (rc)
 			goto err;
=20
@@ -937,7 +974,7 @@ int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 p=
hys_addr, u32 page_size)
 err:
 	real_virt_addr =3D virt_addr;
 	for (i =3D 0 ; i < mapped_cnt ; i++) {
-		if (_hl_mmu_unmap(ctx, real_virt_addr))
+		if (_hl_mmu_unmap(ctx, real_virt_addr, is_dram_addr))
 			dev_warn_ratelimited(hdev->dev,
 				"failed to unmap va: 0x%llx\n", real_virt_addr);
=20
--=20
2.17.1

