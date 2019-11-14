Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264BAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E9A206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="mIBcVnZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfKNSYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:24:08 -0500
Received: from mail-eopbgr150108.outbound.protection.outlook.com ([40.107.15.108]:50913
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726996AbfKNSX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:23:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUaRw0fSaq/HsKdC/eZhGVPlTGjCKGi8+86BsbN3h/DYkqyXDb5JHk7KreyghscBgejczg11aJ9nVe6g0CBzGvkXKy4Y8NCaJFcKQAJ75nQ+JYQG6lLJZpj6fBdE9GVWTLA70GVS6exgt8XZ+nE8SZBqviS5XMw3wzd1OTbkw2lPVlZr4RJc77BvP0vmpBtz4wd5K2PP52o09404vvMdCrhvVUuLDYnB7GIGn5BbbCA8TztC7TG8v5W1gr01wx4udkKB0ecZq9ELw6De+8h+aXWFZJHzoeQiENWeywg3XfWAeOTK1Z57K7sV60qoQsO9G8i9uY5vIC/cMpx2iZUzbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99R95hvRQRdKQJv8bforTAiN5WBIuAmNoLuMs02Lvw0=;
 b=HGh+oEVD/ceV3MyqBfNhNIauV0sgADZYmXFa828yRE9YndomNnPJd8d2RgikyTLr5K47w/gyaJuZ5O7vszLVq8iwegT0MsAgDNaPIksQpjXty9PAuD6+i01080CmLMYQnD2ox+JRGdXvM+NvbJKpVAsC96j5e0h8Jk42AkXZgJ7rTFoowICUuQ/7td5IgKf2M+qSrrN8In7xgq5xHTmdnx8b1fUmtgz3U6ks8Vsm0QJm10glfM4t2yukLMyWThgksG0v9v6nUceJnnlqWcQKIFlk7zy72hXKZeK/sCCvqPbGyAC/ejJLbn8mEZ+UUjnDilxRuiuaVdzoOAxDqej3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99R95hvRQRdKQJv8bforTAiN5WBIuAmNoLuMs02Lvw0=;
 b=mIBcVnZBUtye11mnVLgASOHTBolYzh1hjEkMTFjJ93JtPM/9dvEKPO4UcePeJQrVhR34F2+zdC4ReBWgaUfsFfoohfM0Yc7yTtsk6Nxkm1i9cXJ5tWPd7b+s4cljpR7VTwW/FBfXDG0K51hAeKrygXBgSwAzLr1rDoZH05WcJn0=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3383.eurprd02.prod.outlook.com (52.133.29.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Thu, 14 Nov 2019 18:23:54 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::240e:7545:887b:939e%4]) with mapi id 15.20.2430.028; Thu, 14 Nov 2019
 18:23:54 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] habanalabs: refactor MMU masks and documentation
Thread-Topic: [PATCH 2/8] habanalabs: refactor MMU masks and documentation
Thread-Index: AQHVmxirOXPVeg//4Uq3wnjFATMj8A==
Date:   Thu, 14 Nov 2019 18:23:54 +0000
Message-ID: <20191114182346.22675-2-oshpigelman@habana.ai>
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
x-ms-office365-filtering-correlation-id: aad18204-eeec-4406-b7cf-08d7692fce13
x-ms-traffictypediagnostic: AM6PR0202MB3383:
x-microsoft-antispam-prvs: <AM6PR0202MB338370F4CFFD34AAD7AF54B1B8710@AM6PR0202MB3383.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39840400004)(136003)(366004)(189003)(199004)(71200400001)(6436002)(5640700003)(81166006)(26005)(478600001)(81156014)(186003)(386003)(25786009)(8936002)(50226002)(14454004)(256004)(76176011)(6486002)(71190400001)(8676002)(102836004)(2906002)(52116002)(316002)(5660300002)(36756003)(86362001)(4326008)(66556008)(66476007)(66446008)(1361003)(6506007)(64756008)(99286004)(6512007)(7736002)(305945005)(2501003)(66946007)(446003)(1076003)(486006)(2616005)(476003)(6116002)(3846002)(11346002)(2351001)(66066001)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3383;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hz4Ejcfsbizi34rgT0xeHVVlc6POuFVuV0AGXqRkAdkW0GooUDM7SwXxCWENG7juXfOu9n7Brk7FvNldy1qKG7XUhSWgVejVxuQVtTQ5gYvMeoGADk9+iSSaJzoHnwfAtP7UvrnxSZ6LAp+YCHV8zgZ6WRf61t0pQNNZMaevhVRcTqzmCBWO99gwlurFbM3fmvwceGrdwDSfBSn5J+xGnqnwTXq8fl4SUUHBC6P9KQlTYIJsv2lsZ/xPL4RN2rTkw5zsuRpMiOeHIkibU1PkcKmBTziZOuzkOGtP5Eh1j+o+LkGYEpRLnViFd5EsD07+vJpnHFXErZoRuAA4ivgcNZ/kiIZ/Z8/03/fPMK6SygcBsiISyP11+GtmPH3KZM+c43a7WwzFHTh4IC/qX/ksbHbyMi4oKbuNEh9/aEeTnXGSSYuij+8Hv4+e6+dCp/lV
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: aad18204-eeec-4406-b7cf-08d7692fce13
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 18:23:54.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsuxVeDhXhI1Xk6rgVmzaPxWnR8k+XVDLPi8QDoGUT2sUeLWo4qR3d41kTiTm/dRVQXncv/KjOcRuE8mwW9YEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cosmetics around the MMU code to make it more self-explanatory.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/debugfs.c             |  6 ++--
 .../include/hw_ip/mmu/mmu_general.h           |  6 ++--
 drivers/misc/habanalabs/mmu.c                 | 36 +++++++++----------
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/de=
bugfs.c
index 87f37ac31ccd..1e1fa619a225 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -345,7 +345,7 @@ static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx,=
 u64 hop_addr,
 static inline u64 get_next_hop_addr(u64 curr_pte)
 {
 	if (curr_pte & PAGE_PRESENT_MASK)
-		return curr_pte & PHYS_ADDR_MASK;
+		return curr_pte & HOP_PHYS_ADDR_MASK;
 	else
 		return ULLONG_MAX;
 }
@@ -535,7 +535,7 @@ static int device_va_to_pa(struct hl_device *hdev, u64 =
virt_addr,
 {
 	struct hl_ctx *ctx =3D hdev->compute_ctx;
 	u64 hop_addr, hop_pte_addr, hop_pte;
-	u64 offset_mask =3D HOP4_MASK | OFFSET_MASK;
+	u64 offset_mask =3D HOP4_MASK | FLAGS_MASK;
 	int rc =3D 0;
=20
 	if (!ctx) {
@@ -579,7 +579,7 @@ static int device_va_to_pa(struct hl_device *hdev, u64 =
virt_addr,
 		hop_pte_addr =3D get_hop4_pte_addr(ctx, hop_addr, virt_addr);
 		hop_pte =3D hdev->asic_funcs->read_pte(hdev, hop_pte_addr);
=20
-		offset_mask =3D OFFSET_MASK;
+		offset_mask =3D FLAGS_MASK;
 	}
=20
 	if (!(hop_pte & PAGE_PRESENT_MASK))
diff --git a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h b/driv=
ers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
index 71ea3c3e8ba3..74a5502b8c4e 100644
--- a/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
+++ b/drivers/misc/habanalabs/include/hw_ip/mmu/mmu_general.h
@@ -17,13 +17,12 @@
 #define PAGE_PRESENT_MASK		0x0000000000001ull
 #define SWAP_OUT_MASK			0x0000000000004ull
 #define LAST_MASK			0x0000000000800ull
-#define PHYS_ADDR_MASK			0xFFFFFFFFFFFFF000ull
 #define HOP0_MASK			0x3000000000000ull
 #define HOP1_MASK			0x0FF8000000000ull
 #define HOP2_MASK			0x0007FC0000000ull
 #define HOP3_MASK			0x000003FE00000ull
 #define HOP4_MASK			0x00000001FF000ull
-#define OFFSET_MASK			0x0000000000FFFull
+#define FLAGS_MASK			0x0000000000FFFull
=20
 #define HOP0_SHIFT			48
 #define HOP1_SHIFT			39
@@ -31,8 +30,7 @@
 #define HOP3_SHIFT			21
 #define HOP4_SHIFT			12
=20
-#define PTE_PHYS_ADDR_SHIFT		12
-#define PTE_PHYS_ADDR_MASK		~OFFSET_MASK
+#define HOP_PHYS_ADDR_MASK		(~FLAGS_MASK)
=20
 #define HL_PTE_SIZE			sizeof(u64)
 #define HOP_TABLE_SIZE			PAGE_SIZE_4KB
diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index 176c315836f1..21b4e3281b3e 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -105,8 +105,8 @@ static inline void write_pte(struct hl_ctx *ctx, u64 sh=
adow_pte_addr, u64 val)
 	 * clear the 12 LSBs and translate the shadow hop to its associated
 	 * physical hop, and add back the original 12 LSBs.
 	 */
-	u64 phys_val =3D get_phys_addr(ctx, val & PTE_PHYS_ADDR_MASK) |
-				(val & OFFSET_MASK);
+	u64 phys_val =3D get_phys_addr(ctx, val & HOP_PHYS_ADDR_MASK) |
+				(val & FLAGS_MASK);
=20
 	ctx->hdev->asic_funcs->write_pte(ctx->hdev,
 					get_phys_addr(ctx, shadow_pte_addr),
@@ -199,7 +199,7 @@ static inline u64 get_hop4_pte_addr(struct hl_ctx *ctx,=
 u64 hop_addr, u64 vaddr)
 static inline u64 get_next_hop_addr(struct hl_ctx *ctx, u64 curr_pte)
 {
 	if (curr_pte & PAGE_PRESENT_MASK)
-		return curr_pte & PHYS_ADDR_MASK;
+		return curr_pte & HOP_PHYS_ADDR_MASK;
 	else
 		return ULLONG_MAX;
 }
@@ -288,23 +288,23 @@ static int dram_default_mapping_init(struct hl_ctx *c=
tx)
 	}
=20
 	/* need only pte 0 in hops 0 and 1 */
-	pte_val =3D (hop1_addr & PTE_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
+	pte_val =3D (hop1_addr & HOP_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
 	write_pte(ctx, hop0_addr, pte_val);
=20
-	pte_val =3D (hop2_addr & PTE_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
+	pte_val =3D (hop2_addr & HOP_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
 	write_pte(ctx, hop1_addr, pte_val);
 	get_pte(ctx, hop1_addr);
=20
 	hop2_pte_addr =3D hop2_addr;
 	for (i =3D 0 ; i < num_of_hop3 ; i++) {
-		pte_val =3D (ctx->dram_default_hops[i] & PTE_PHYS_ADDR_MASK) |
+		pte_val =3D (ctx->dram_default_hops[i] & HOP_PHYS_ADDR_MASK) |
 				PAGE_PRESENT_MASK;
 		write_pte(ctx, hop2_pte_addr, pte_val);
 		get_pte(ctx, hop2_addr);
 		hop2_pte_addr +=3D HL_PTE_SIZE;
 	}
=20
-	pte_val =3D (prop->mmu_dram_default_page_addr & PTE_PHYS_ADDR_MASK) |
+	pte_val =3D (prop->mmu_dram_default_page_addr & HOP_PHYS_ADDR_MASK) |
 			LAST_MASK | PAGE_PRESENT_MASK;
=20
 	for (i =3D 0 ; i < num_of_hop3 ; i++) {
@@ -400,8 +400,6 @@ int hl_mmu_init(struct hl_device *hdev)
 	if (!hdev->mmu_enable)
 		return 0;
=20
-	/* MMU H/W init was already done in device hw_init() */
-
 	hdev->mmu_pgt_pool =3D
 			gen_pool_create(__ffs(prop->mmu_hop_table_size), -1);
=20
@@ -427,6 +425,8 @@ int hl_mmu_init(struct hl_device *hdev)
 		goto err_pool_add;
 	}
=20
+	/* MMU H/W init will be done in device hw_init() */
+
 	return 0;
=20
 err_pool_add:
@@ -450,10 +450,10 @@ void hl_mmu_fini(struct hl_device *hdev)
 	if (!hdev->mmu_enable)
 		return;
=20
+	/* MMU H/W fini was already done in device hw_fini() */
+
 	kvfree(hdev->mmu_shadow_hop0);
 	gen_pool_destroy(hdev->mmu_pgt_pool);
-
-	/* MMU H/W fini will be done in device hw_fini() */
 }
=20
 /**
@@ -584,7 +584,7 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_a=
ddr)
=20
 	if (hdev->dram_default_page_mapping && is_dram_addr) {
 		u64 default_pte =3D (prop->mmu_dram_default_page_addr &
-				PTE_PHYS_ADDR_MASK) | LAST_MASK |
+				HOP_PHYS_ADDR_MASK) | LAST_MASK |
 					PAGE_PRESENT_MASK;
 		if (curr_pte =3D=3D default_pte) {
 			dev_err(hdev->dev,
@@ -773,7 +773,7 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_add=
r, u64 phys_addr,
=20
 	if (hdev->dram_default_page_mapping && is_dram_addr) {
 		u64 default_pte =3D (prop->mmu_dram_default_page_addr &
-					PTE_PHYS_ADDR_MASK) | LAST_MASK |
+					HOP_PHYS_ADDR_MASK) | LAST_MASK |
 						PAGE_PRESENT_MASK;
=20
 		if (curr_pte !=3D default_pte) {
@@ -813,7 +813,7 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_add=
r, u64 phys_addr,
 		goto err;
 	}
=20
-	curr_pte =3D (phys_addr & PTE_PHYS_ADDR_MASK) | LAST_MASK
+	curr_pte =3D (phys_addr & HOP_PHYS_ADDR_MASK) | LAST_MASK
 			| PAGE_PRESENT_MASK;
=20
 	if (is_huge)
@@ -823,25 +823,25 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_a=
ddr, u64 phys_addr,
=20
 	if (hop1_new) {
 		curr_pte =3D
-			(hop1_addr & PTE_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
+			(hop1_addr & HOP_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
 		write_pte(ctx, hop0_pte_addr, curr_pte);
 	}
 	if (hop2_new) {
 		curr_pte =3D
-			(hop2_addr & PTE_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
+			(hop2_addr & HOP_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
 		write_pte(ctx, hop1_pte_addr, curr_pte);
 		get_pte(ctx, hop1_addr);
 	}
 	if (hop3_new) {
 		curr_pte =3D
-			(hop3_addr & PTE_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
+			(hop3_addr & HOP_PHYS_ADDR_MASK) | PAGE_PRESENT_MASK;
 		write_pte(ctx, hop2_pte_addr, curr_pte);
 		get_pte(ctx, hop2_addr);
 	}
=20
 	if (!is_huge) {
 		if (hop4_new) {
-			curr_pte =3D (hop4_addr & PTE_PHYS_ADDR_MASK) |
+			curr_pte =3D (hop4_addr & HOP_PHYS_ADDR_MASK) |
 					PAGE_PRESENT_MASK;
 			write_pte(ctx, hop3_pte_addr, curr_pte);
 			get_pte(ctx, hop3_addr);
--=20
2.17.1

