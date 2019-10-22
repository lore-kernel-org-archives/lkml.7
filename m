Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F07CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791352089E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 06:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="Qwoa3TV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbfJVGao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 02:30:44 -0400
Received: from mail-eopbgr130098.outbound.protection.outlook.com ([40.107.13.98]:50144
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730863AbfJVGao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 02:30:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgER7eMW8VOtVcSbNgIN7OiTRb699H8hkzJTvRB7f+SrDrCEc834N/Oq/W09LlwZqd/mW1VJtdm022PimS0isD5JOu9nfCvWXn0MNOi36TauGLH3XDywAHFogVwchnoJVxDPfxNkUmJ/GbtS3cIr4nMovykXY6X7Kyna7UlLuLvkAYb7wZT4jvfzjRh39BQ+NexlC9SdPNiKQ+05wpKdTsEyXHOSm32ZM25jYf/vlMiPBdEv4DysOkpp/VAgmp3XugBJp2stFQX/cKaGkE3BupcqSsERQcbzJXbgdIHrrvTpXIFSgMlbmgMt9PBeGYz6KZflyPJ5NLF4aFjKVrJueg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwm46PpH2Ujjq5jcvIjn/h5CTARvRELq7deBjAJN3Ro=;
 b=OxBjkPE3Jflabj27+Bwnwn5uhIuWC2ZJoSEMim6n4xE0I/JmZxps/vwlN3jCy4kz7s3eHeYQ23v+kZzzKgj788FKJULbs0tPlgD2YWiVDnBpmXRosd0ihtPOCKusWC2quDgqBryNw09IbnX8Iu2zCIvPdPHLaMctroQKJIeO57hbO+Ud61aD/ii2ohyRZzm/bcJDG5u68BJaMs1LtOVhHh3dPAf0a2Iw1MOmMHYt1hqdVLWhGLzb4t+Kbfqw++FFkY5y/Ta91nSUS74cbPrlEBBLPFKvNrbOL/xSxjULyx/58xQc7vbGRXNJqFICNtzYrNr98RM8U2zFrs5X9VcKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwm46PpH2Ujjq5jcvIjn/h5CTARvRELq7deBjAJN3Ro=;
 b=Qwoa3TV1u+TmvmPFjErttjNNDKmJU1J9c5OZRbIOmKfa5IFxLxzXbEZZYJolJt33cJVraayEAUwwyxxgdV0h/xzNE8ksYpc5WXuIOFV+2cHYj1vj2loEXqGhYPg0skXRpLV8RXdi+SCAOg7Pve67qcffriW/Qf4b5+0nukWkDlM=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3349.eurprd02.prod.outlook.com (52.133.28.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Tue, 22 Oct 2019 06:30:35 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251%5]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 06:30:35 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] habanalabs: support kernel memory mapping
Thread-Topic: [PATCH v2 1/2] habanalabs: support kernel memory mapping
Thread-Index: AQHViKI2kzFSWJT/Dk6DGcovF5gSdw==
Date:   Tue, 22 Oct 2019 06:30:35 +0000
Message-ID: <20191022063028.9030-1-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0501CA0054.eurprd05.prod.outlook.com
 (2603:10a6:200:68::22) To AM6PR0202MB3382.eurprd02.prod.outlook.com
 (2603:10a6:209:20::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d9af108-7670-47cf-15e5-08d756b958b4
x-ms-traffictypediagnostic: AM6PR0202MB3349:
x-microsoft-antispam-prvs: <AM6PR0202MB3349CDDFD7E221D4C694211AB8680@AM6PR0202MB3349.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39840400004)(136003)(396003)(199004)(189003)(476003)(102836004)(52116002)(26005)(486006)(186003)(66446008)(64756008)(36756003)(66476007)(66556008)(99286004)(71200400001)(71190400001)(4326008)(2616005)(2351001)(30864003)(1076003)(5660300002)(6506007)(66066001)(66946007)(386003)(5640700003)(6916009)(86362001)(6512007)(2906002)(7736002)(305945005)(8676002)(316002)(14444005)(1361003)(3846002)(478600001)(25786009)(6436002)(14454004)(8936002)(81166006)(50226002)(81156014)(6116002)(2501003)(6486002)(256004)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3349;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HiwPkOpkkZSn3+D/bljDOS0PYzveVMkg0l5j7JYhr0Cbfxj+ghaSxdDc4+/DK3Tsa+tyVgBU/fKhQalD77jJJe5HvdldTKYTlyvUDF2NJWQG2LGcZ3akSJwbuIHVh4eSq2jLzboJWCBU6KUONtHRInnjO4fKzkIJqhorM2ht0iyXw9evlRH1nXRB6d/lzV8HEIBO5d8q3cAP6a9LpHDc6rHMmawQxugVhFITV/c72o+cy+ZEKghLvKNr9kSJl+bOMqw0mbPRrVI3TQPd2pqA+9UZgk0vzBtBC9mTuE50d9EKLEXExOosb8L21V/V0nYhk29q0v+BvcC6ZXmyGCZEwvJTT9jWAXha090s0rbwg0s95oIzNpUNdLPfDAplf/Iij8iybuTSDqyuSuowPq23nC/eRcBFudq/EVtEz+OlBqs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9af108-7670-47cf-15e5-08d756b958b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 06:30:35.6878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4c4vizdJLBxJcyK8nQp58DeiwR7Nb4m5lzfYpZxnp95g6vVEkf6RF0GmpoOQuyeXAcE0hsVJLgauRgOTOysnQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3349
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In contrary to user memory, kernel memory is already pinned and has no
vm_area structure. Therefore we need a new code path to map this memory.
This is a pre-requisite patch for upstreaming future ASIC support

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
Changes in v2:
 - use a boolean parameter to indicate for kernel address rather than
   calling is_vmalloc_addr, as kernel and user addresses can overlap on
   some architectures.
=20
 drivers/misc/habanalabs/goya/goya.c  |   2 +-
 drivers/misc/habanalabs/habanalabs.h |  18 +-
 drivers/misc/habanalabs/memory.c     | 409 +++++++++++++++++----------
 3 files changed, 269 insertions(+), 160 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/=
goya/goya.c
index e8812154343f..4acc6aeb5b3f 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3932,7 +3932,7 @@ static int goya_parse_cb_no_ext_queue(struct hl_devic=
e *hdev,
 		return 0;
=20
 	dev_err(hdev->dev,
-		"Internal CB address %px + 0x%x is not in SRAM nor in DRAM\n",
+		"Internal CB address 0x%px + 0x%x is not in SRAM nor in DRAM\n",
 		parser->user_cb, parser->user_cb_size);
=20
 	return -EFAULT;
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs=
/habanalabs.h
index 4ff2da859653..7eb1cfa49c5d 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -696,9 +696,11 @@ struct hl_ctx_mgr {
  * @sgt: pointer to the scatter-gather table that holds the pages.
  * @dir: for DMA unmapping, the direction must be supplied, so save it.
  * @debugfs_list: node in debugfs list of command submissions.
- * @addr: user-space virtual pointer to the start of the memory area.
+ * @addr: virtual address of the start of the memory area.
  * @size: size of the memory area to pin & map.
  * @dma_mapped: true if the SG was mapped to DMA addresses, false otherwis=
e.
+ * @kernel_address: true if the host address is in the kernel address-spac=
e.
+ *                  i.e. allocated by the kernel driver. false otherwise.
  */
 struct hl_userptr {
 	enum vm_type_t		vm_type; /* must be first */
@@ -710,6 +712,7 @@ struct hl_userptr {
 	u64			addr;
 	u32			size;
 	u8			dma_mapped;
+	u8			kernel_address;
 };
=20
 /**
@@ -1529,9 +1532,20 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx);
 int hl_vm_init(struct hl_device *hdev);
 void hl_vm_fini(struct hl_device *hdev);
=20
+int hl_dma_map_host_va(struct hl_device *hdev, u64 addr, u64 size,
+			bool is_kernel_addr, struct hl_userptr **p_userptr);
+void hl_dma_unmap_host_va(struct hl_device *hdev, struct hl_userptr *userp=
tr);
+int hl_init_phys_pg_pack_from_userptr(u32 asid, struct hl_userptr *userptr=
,
+				struct hl_vm_phys_pg_pack **pphys_pg_pack);
+void hl_free_phys_pg_pack(struct hl_device *hdev,
+				struct hl_vm_phys_pg_pack *phys_pg_pack);
+int hl_map_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
+				struct hl_vm_phys_pg_pack *phys_pg_pack);
+void hl_unmap_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
+				struct hl_vm_phys_pg_pack *phys_pg_pack);
 int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
 			struct hl_userptr *userptr);
-int hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userpt=
r);
+void hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userp=
tr);
 void hl_userptr_delete_list(struct hl_device *hdev,
 				struct list_head *userptr_list);
 bool hl_userptr_is_pinned(struct hl_device *hdev, u64 addr, u32 size,
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/mem=
ory.c
index 365fb0cb8dff..552a47126567 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -159,20 +159,22 @@ static int alloc_device_memory(struct hl_ctx *ctx, st=
ruct hl_mem_in *args,
 }
=20
 /*
- * get_userptr_from_host_va - initialize userptr structure from given host
- *                            virtual address
- *
- * @hdev                : habanalabs device structure
- * @args                : parameters containing the virtual address and si=
ze
- * @p_userptr           : pointer to result userptr structure
+ * hl_dma_map_host_va() - DMA mapping of the given host virtual address.
+ * @hdev: habanalabs device structure.
+ * @addr: the host virtual address of the memory area.
+ * @size: the size of the memory area.
+ * @is_kernel_addr: true if the host address is in the kernel address-spac=
e.
+ *                  i.e. allocated by the kernel driver. false otherwise.
+ * @p_userptr: pointer to result userptr structure.
  *
  * This function does the following:
- * - Allocate userptr structure
- * - Pin the given host memory using the userptr structure
- * - Perform DMA mapping to have the DMA addresses of the pages
+ * - Allocate userptr structure.
+ * - Pin the given host memory using the userptr structure - for user memo=
ry
+ *   only.
+ * - Perform DMA mapping to have the DMA addresses of the pages.
  */
-static int get_userptr_from_host_va(struct hl_device *hdev,
-		struct hl_mem_in *args, struct hl_userptr **p_userptr)
+int hl_dma_map_host_va(struct hl_device *hdev, u64 addr, u64 size,
+			bool is_kernel_addr, struct hl_userptr **p_userptr)
 {
 	struct hl_userptr *userptr;
 	int rc;
@@ -183,8 +185,9 @@ static int get_userptr_from_host_va(struct hl_device *h=
dev,
 		goto userptr_err;
 	}
=20
-	rc =3D hl_pin_host_memory(hdev, args->map_host.host_virt_addr,
-			args->map_host.mem_size, userptr);
+	userptr->kernel_address =3D is_kernel_addr;
+
+	rc =3D hl_pin_host_memory(hdev, addr, size, userptr);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to pin host memory\n");
 		goto pin_err;
@@ -215,16 +218,15 @@ static int get_userptr_from_host_va(struct hl_device =
*hdev,
 }
=20
 /*
- * free_userptr - free userptr structure
- *
- * @hdev                : habanalabs device structure
- * @userptr             : userptr to free
+ * hl_dma_unmap_host_va() - DMA unmapping of the given host virtual addres=
s.
+ * @hdev: habanalabs device structure.
+ * @userptr: userptr to free.
  *
  * This function does the following:
- * - Unpins the physical pages
- * - Frees the userptr structure
+ * - Unpins the physical pages.
+ * - Frees the userptr structure.
  */
-static void free_userptr(struct hl_device *hdev, struct hl_userptr *userpt=
r)
+void hl_dma_unmap_host_va(struct hl_device *hdev, struct hl_userptr *userp=
tr)
 {
 	hl_unpin_host_memory(hdev, userptr);
 	kfree(userptr);
@@ -253,18 +255,17 @@ static void dram_pg_pool_do_release(struct kref *ref)
 }
=20
 /*
- * free_phys_pg_pack   - free physical page pack
- *
- * @hdev               : habanalabs device structure
- * @phys_pg_pack       : physical page pack to free
+ * hl_free_phys_pg_pack() - free physical page pack.
+ * @hdev: habanalabs device structure.
+ * @phys_pg_pack: physical page pack to free.
  *
  * This function does the following:
- * - For DRAM memory only, iterate over the pack and free each physical bl=
ock
- *   structure by returning it to the general pool
- * - Free the hl_vm_phys_pg_pack structure
+ * - For DRAM memory only, iterate over the pack and free each physical bl=
ock.
+ *   structure by returning it to the general pool.
+ * - Free the hl_vm_phys_pg_pack structure.
  */
-static void free_phys_pg_pack(struct hl_device *hdev,
-		struct hl_vm_phys_pg_pack *phys_pg_pack)
+void hl_free_phys_pg_pack(struct hl_device *hdev,
+				struct hl_vm_phys_pg_pack *phys_pg_pack)
 {
 	struct hl_vm *vm =3D &hdev->vm;
 	u64 i;
@@ -328,7 +329,7 @@ static int free_device_memory(struct hl_ctx *ctx, u32 h=
andle)
 		atomic64_sub(phys_pg_pack->total_size, &ctx->dram_phys_mem);
 		atomic64_sub(phys_pg_pack->total_size, &hdev->dram_used_mem);
=20
-		free_phys_pg_pack(hdev, phys_pg_pack);
+		hl_free_phys_pg_pack(hdev, phys_pg_pack);
 	} else {
 		spin_unlock(&vm->idr_lock);
 		dev_err(hdev->dev,
@@ -630,21 +631,19 @@ static u32 get_sg_info(struct scatterlist *sg, dma_ad=
dr_t *dma_addr)
 }
=20
 /*
- * init_phys_pg_pack_from_userptr - initialize physical page pack from hos=
t
- *                                   memory
- *
- * @ctx                : current context
- * @userptr            : userptr to initialize from
- * @pphys_pg_pack      : res pointer
+ * hl_init_phys_pg_pack_from_userptr() - initialize physical page pack fro=
m host
+ *                                       memory
+ * @asid: current context ASID.
+ * @userptr: userptr to initialize from.
+ * @pphys_pg_pack: result pointer.
  *
  * This function does the following:
- * - Pin the physical pages related to the given virtual block
+ * - Pin the physical pages related to the given virtual block.
  * - Create a physical page pack from the physical pages related to the gi=
ven
- *   virtual block
+ *   virtual block.
  */
-static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
-		struct hl_userptr *userptr,
-		struct hl_vm_phys_pg_pack **pphys_pg_pack)
+int hl_init_phys_pg_pack_from_userptr(u32 asid, struct hl_userptr *userptr=
,
+				struct hl_vm_phys_pg_pack **pphys_pg_pack)
 {
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
 	struct scatterlist *sg;
@@ -660,7 +659,7 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx=
 *ctx,
=20
 	phys_pg_pack->vm_type =3D userptr->vm_type;
 	phys_pg_pack->created_from_userptr =3D true;
-	phys_pg_pack->asid =3D ctx->asid;
+	phys_pg_pack->asid =3D asid;
 	atomic_set(&phys_pg_pack->mapping_cnt, 1);
=20
 	/* Only if all dma_addrs are aligned to 2MB and their
@@ -731,19 +730,18 @@ static int init_phys_pg_pack_from_userptr(struct hl_c=
tx *ctx,
 }
=20
 /*
- * map_phys_page_pack - maps the physical page pack
- *
- * @ctx                : current context
- * @vaddr              : start address of the virtual area to map from
- * @phys_pg_pack       : the pack of physical pages to map to
+ * hl_map_phys_pg_pack() - maps the physical page pack.
+ * @ctx: current context.
+ * @vaddr: start address of the virtual area to map from.
+ * @phys_pg_pack: the pack of physical pages to map to.
  *
  * This function does the following:
- * - Maps each chunk of virtual memory to matching physical chunk
- * - Stores number of successful mappings in the given argument
+ * - Maps each chunk of virtual memory to matching physical chunk.
+ * - Stores number of successful mappings in the given argument.
  * - Returns 0 on success, error code otherwise.
  */
-static int map_phys_page_pack(struct hl_ctx *ctx, u64 vaddr,
-		struct hl_vm_phys_pg_pack *phys_pg_pack)
+int hl_map_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
+				struct hl_vm_phys_pg_pack *phys_pg_pack)
 {
 	struct hl_device *hdev =3D ctx->hdev;
 	u64 next_vaddr =3D vaddr, paddr, mapped_pg_cnt =3D 0, i;
@@ -783,6 +781,36 @@ static int map_phys_page_pack(struct hl_ctx *ctx, u64 =
vaddr,
 	return rc;
 }
=20
+/*
+ * hl_unmap_phys_pg_pack() - unmaps the physical page pack.
+ * @ctx: current context.
+ * @vaddr: start address of the virtual area to unmap.
+ * @phys_pg_pack: the pack of physical pages to unmap.
+ */
+void hl_unmap_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
+				struct hl_vm_phys_pg_pack *phys_pg_pack)
+{
+	struct hl_device *hdev =3D ctx->hdev;
+	u64 next_vaddr, i;
+	u32 page_size;
+
+	page_size =3D phys_pg_pack->page_size;
+	next_vaddr =3D vaddr;
+
+	for (i =3D 0 ; i < phys_pg_pack->npages ; i++, next_vaddr +=3D page_size)=
 {
+		if (hl_mmu_unmap(ctx, next_vaddr, page_size))
+			dev_warn_ratelimited(hdev->dev,
+			"unmap failed for vaddr: 0x%llx\n", next_vaddr);
+
+		/*
+		 * unmapping on Palladium can be really long, so avoid a CPU
+		 * soft lockup bug by sleeping a little between unmapping pages
+		 */
+		if (hdev->pldm)
+			usleep_range(500, 1000);
+	}
+}
+
 static int get_paddr_from_handle(struct hl_ctx *ctx, struct hl_mem_in *arg=
s,
 				u64 *paddr)
 {
@@ -827,7 +855,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_=
mem_in *args,
 	struct hl_device *hdev =3D ctx->hdev;
 	struct hl_vm *vm =3D &hdev->vm;
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
-	struct hl_userptr *userptr =3D NULL;
+	struct hl_userptr *userptr;
 	struct hl_vm_hash_node *hnode;
 	enum vm_type_t *vm_type;
 	u64 ret_vaddr, hint_addr;
@@ -839,18 +867,21 @@ static int map_device_va(struct hl_ctx *ctx, struct h=
l_mem_in *args,
 	*device_addr =3D 0;
=20
 	if (is_userptr) {
-		rc =3D get_userptr_from_host_va(hdev, args, &userptr);
+		u64 addr =3D args->map_host.host_virt_addr,
+			size =3D args->map_host.mem_size;
+
+		rc =3D hl_dma_map_host_va(hdev, addr, size, false, &userptr);
 		if (rc) {
 			dev_err(hdev->dev, "failed to get userptr from va\n");
 			return rc;
 		}
=20
-		rc =3D init_phys_pg_pack_from_userptr(ctx, userptr,
+		rc =3D hl_init_phys_pg_pack_from_userptr(ctx->asid, userptr,
 				&phys_pg_pack);
 		if (rc) {
 			dev_err(hdev->dev,
 				"unable to init page pack for vaddr 0x%llx\n",
-				args->map_host.host_virt_addr);
+				addr);
 			goto init_page_pack_err;
 		}
=20
@@ -909,7 +940,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_=
mem_in *args,
=20
 	mutex_lock(&ctx->mmu_lock);
=20
-	rc =3D map_phys_page_pack(ctx, ret_vaddr, phys_pg_pack);
+	rc =3D hl_map_phys_pg_pack(ctx, ret_vaddr, phys_pg_pack);
 	if (rc) {
 		mutex_unlock(&ctx->mmu_lock);
 		dev_err(hdev->dev, "mapping page pack failed for handle %u\n",
@@ -933,7 +964,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_=
mem_in *args,
 	*device_addr =3D ret_vaddr;
=20
 	if (is_userptr)
-		free_phys_pg_pack(hdev, phys_pg_pack);
+		hl_free_phys_pg_pack(hdev, phys_pg_pack);
=20
 	return 0;
=20
@@ -952,10 +983,10 @@ static int map_device_va(struct hl_ctx *ctx, struct h=
l_mem_in *args,
 shared_err:
 	atomic_dec(&phys_pg_pack->mapping_cnt);
 	if (is_userptr)
-		free_phys_pg_pack(hdev, phys_pg_pack);
+		hl_free_phys_pg_pack(hdev, phys_pg_pack);
 init_page_pack_err:
 	if (is_userptr)
-		free_userptr(hdev, userptr);
+		hl_dma_unmap_host_va(hdev, userptr);
=20
 	return rc;
 }
@@ -977,8 +1008,6 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vad=
dr)
 	struct hl_vm_hash_node *hnode =3D NULL;
 	struct hl_userptr *userptr =3D NULL;
 	enum vm_type_t *vm_type;
-	u64 next_vaddr, i;
-	u32 page_size;
 	bool is_userptr;
 	int rc;
=20
@@ -1004,8 +1033,8 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 va=
ddr)
 	if (*vm_type =3D=3D VM_TYPE_USERPTR) {
 		is_userptr =3D true;
 		userptr =3D hnode->ptr;
-		rc =3D init_phys_pg_pack_from_userptr(ctx, userptr,
-				&phys_pg_pack);
+		rc =3D hl_init_phys_pg_pack_from_userptr(ctx->asid, userptr,
+							&phys_pg_pack);
 		if (rc) {
 			dev_err(hdev->dev,
 				"unable to init page pack for vaddr 0x%llx\n",
@@ -1029,24 +1058,11 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 =
vaddr)
 		goto mapping_cnt_err;
 	}
=20
-	page_size =3D phys_pg_pack->page_size;
-	vaddr &=3D ~(((u64) page_size) - 1);
-
-	next_vaddr =3D vaddr;
+	vaddr &=3D ~(((u64) phys_pg_pack->page_size) - 1);
=20
 	mutex_lock(&ctx->mmu_lock);
=20
-	for (i =3D 0 ; i < phys_pg_pack->npages ; i++, next_vaddr +=3D page_size)=
 {
-		if (hl_mmu_unmap(ctx, next_vaddr, page_size))
-			dev_warn_ratelimited(hdev->dev,
-			"unmap failed for vaddr: 0x%llx\n", next_vaddr);
-
-		/* unmapping on Palladium can be really long, so avoid a CPU
-		 * soft lockup bug by sleeping a little between unmapping pages
-		 */
-		if (hdev->pldm)
-			usleep_range(500, 1000);
-	}
+	hl_unmap_phys_pg_pack(ctx, vaddr, phys_pg_pack);
=20
 	hdev->asic_funcs->mmu_invalidate_cache(hdev, true);
=20
@@ -1063,15 +1079,15 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 =
vaddr)
 	kfree(hnode);
=20
 	if (is_userptr) {
-		free_phys_pg_pack(hdev, phys_pg_pack);
-		free_userptr(hdev, userptr);
+		hl_free_phys_pg_pack(hdev, phys_pg_pack);
+		hl_dma_unmap_host_va(hdev, userptr);
 	}
=20
 	return 0;
=20
 mapping_cnt_err:
 	if (is_userptr)
-		free_phys_pg_pack(hdev, phys_pg_pack);
+		hl_free_phys_pg_pack(hdev, phys_pg_pack);
 vm_type_err:
 	mutex_lock(&ctx->mem_hash_lock);
 	hash_add(ctx->mem_hash, &hnode->node, vaddr);
@@ -1203,56 +1219,60 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data=
)
 	return rc;
 }
=20
-/*
- * hl_pin_host_memory - pins a chunk of host memory
- *
- * @hdev                : pointer to the habanalabs device structure
- * @addr                : the user-space virtual address of the memory are=
a
- * @size                : the size of the memory area
- * @userptr	        : pointer to hl_userptr structure
- *
- * This function does the following:
- * - Pins the physical pages
- * - Create a SG list from those pages
- */
-int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
-			struct hl_userptr *userptr)
+static int init_sg_list_for_vmalloc_memory(struct hl_device *hdev, u64 add=
r,
+						u64 size, u32 npages,
+						u32 offset,
+						struct sg_table *sgt)
 {
-	u64 start, end;
-	u32 npages, offset;
-	int rc;
+	struct page *page, **pages;
+	u64 tmp_addr;
+	int i, rc;
=20
-	if (!size) {
-		dev_err(hdev->dev, "size to pin is invalid - %llu\n", size);
-		return -EINVAL;
-	}
+	pages =3D kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
=20
-	if (!access_ok((void __user *) (uintptr_t) addr, size)) {
-		dev_err(hdev->dev, "user pointer is invalid - 0x%llx\n", addr);
-		return -EFAULT;
+	tmp_addr =3D addr;
+
+	for (i =3D 0 ; i < npages ; i++) {
+		page =3D vmalloc_to_page((void *) (uintptr_t) tmp_addr);
+		if (!page) {
+			dev_err(hdev->dev,
+				"failed to get physical page for va 0x%llx\n",
+				tmp_addr);
+			rc =3D -EFAULT;
+			goto free_pages;
+		}
+		pages[i] =3D page;
+		tmp_addr +=3D PAGE_SIZE;
 	}
=20
-	/*
-	 * If the combination of the address and size requested for this memory
-	 * region causes an integer overflow, return error.
-	 */
-	if (((addr + size) < addr) ||
-			PAGE_ALIGN(addr + size) < (addr + size)) {
-		dev_err(hdev->dev,
-			"user pointer 0x%llx + %llu causes integer overflow\n",
-			addr, size);
-		return -EINVAL;
+	rc =3D sg_alloc_table_from_pages(sgt, pages, npages, offset, size,
+					GFP_KERNEL);
+	if (rc < 0) {
+		dev_err(hdev->dev, "failed to create SG table from pages\n");
+		goto free_pages;
 	}
=20
-	start =3D addr & PAGE_MASK;
-	offset =3D addr & ~PAGE_MASK;
-	end =3D PAGE_ALIGN(addr + size);
-	npages =3D (end - start) >> PAGE_SHIFT;
+	kfree(pages);
=20
-	userptr->size =3D size;
-	userptr->addr =3D addr;
-	userptr->dma_mapped =3D false;
-	INIT_LIST_HEAD(&userptr->job_node);
+	return 0;
+
+free_pages:
+	kfree(pages);
+	return rc;
+}
+
+static int get_user_memory(struct hl_device *hdev, u64 addr, u64 size,
+				u32 npages, u64 start, u32 offset,
+				struct hl_userptr *userptr)
+{
+	int rc;
+
+	if (!access_ok((void __user *) (uintptr_t) addr, size)) {
+		dev_err(hdev->dev, "user pointer is invalid - 0x%llx\n", addr);
+		return -EFAULT;
+	}
=20
 	userptr->vec =3D frame_vector_create(npages);
 	if (!userptr->vec) {
@@ -1279,26 +1299,16 @@ int hl_pin_host_memory(struct hl_device *hdev, u64 =
addr, u64 size,
 		goto put_framevec;
 	}
=20
-	userptr->sgt =3D kzalloc(sizeof(*userptr->sgt), GFP_ATOMIC);
-	if (!userptr->sgt) {
-		rc =3D -ENOMEM;
-		goto put_framevec;
-	}
-
 	rc =3D sg_alloc_table_from_pages(userptr->sgt,
 					frame_vector_pages(userptr->vec),
 					npages, offset, size, GFP_ATOMIC);
 	if (rc < 0) {
 		dev_err(hdev->dev, "failed to create SG table from pages\n");
-		goto free_sgt;
+		goto put_framevec;
 	}
=20
-	hl_debugfs_add_userptr(hdev, userptr);
-
 	return 0;
=20
-free_sgt:
-	kfree(userptr->sgt);
 put_framevec:
 	put_vaddr_frames(userptr->vec);
 destroy_framevec:
@@ -1307,43 +1317,128 @@ int hl_pin_host_memory(struct hl_device *hdev, u64=
 addr, u64 size,
 }
=20
 /*
- * hl_unpin_host_memory - unpins a chunk of host memory
+ * hl_pin_host_memory() - pins a chunk of host memory.
+ * @hdev: pointer to the habanalabs device structure.
+ * @addr: the host virtual address of the memory area.
+ * @size: the size of the memory area.
+ * @userptr: pointer to hl_userptr structure.
  *
- * @hdev                : pointer to the habanalabs device structure
- * @userptr             : pointer to hl_userptr structure
+ * This function does the following:
+ * - Pins the physical pages - for user memory only, as vmalloc pages are
+ *   already pinned.
+ * - Create an SG list from those pages.
+ */
+int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
+					struct hl_userptr *userptr)
+{
+	u64 start, end;
+	u32 npages, offset;
+	int rc;
+
+	if (!size) {
+		dev_err(hdev->dev, "size to pin is invalid - %llu\n", size);
+		return -EINVAL;
+	}
+
+	/*
+	 * If the combination of the address and size requested for this memory
+	 * region causes an integer overflow, return error.
+	 */
+	if (((addr + size) < addr) ||
+			PAGE_ALIGN(addr + size) < (addr + size)) {
+		dev_err(hdev->dev,
+			"user pointer 0x%llx + %llu causes integer overflow\n",
+			addr, size);
+		return -EINVAL;
+	}
+
+	/*
+	 * This function can be called also from data path, hence use atomic
+	 * always as it is not a big allocation.
+	 */
+	userptr->sgt =3D kzalloc(sizeof(*userptr->sgt), GFP_ATOMIC);
+	if (!userptr->sgt)
+		return -ENOMEM;
+
+	start =3D addr & PAGE_MASK;
+	offset =3D addr & ~PAGE_MASK;
+	end =3D PAGE_ALIGN(addr + size);
+	npages =3D (end - start) >> PAGE_SHIFT;
+
+	userptr->size =3D size;
+	userptr->addr =3D addr;
+	userptr->dma_mapped =3D false;
+	INIT_LIST_HEAD(&userptr->job_node);
+
+	if (userptr->kernel_address) {
+		/* no need in pinning, only init an SG list */
+		rc =3D init_sg_list_for_vmalloc_memory(hdev, addr, size, npages,
+							offset, userptr->sgt);
+		if (rc) {
+			dev_err(hdev->dev,
+				"failed to init an SG list for vmalloc address 0x%llx\n",
+				addr);
+			goto free_sgt;
+		}
+	} else {
+		rc =3D get_user_memory(hdev, addr, size, npages, start, offset,
+					userptr);
+		if (rc) {
+			dev_err(hdev->dev,
+				"failed to get user memory for address 0x%llx\n",
+				addr);
+			goto free_sgt;
+		}
+	}
+
+	hl_debugfs_add_userptr(hdev, userptr);
+
+	return 0;
+
+free_sgt:
+	kfree(userptr->sgt);
+	return rc;
+}
+
+/*
+ * hl_unpin_host_memory() - unpins a chunk of host memory.
+ * @hdev: pointer to the habanalabs device structure.
+ * @userptr: pointer to hl_userptr structure.
  *
  * This function does the following:
- * - Unpins the physical pages related to the host memory
- * - Free the SG list
+ * - Unpins the physical pages related to the host memory - for user memor=
y
+ *   only.
+ * - Free the SG list.
  */
-int hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userpt=
r)
+void hl_unpin_host_memory(struct hl_device *hdev,
+					struct hl_userptr *userptr)
 {
 	struct page **pages;
=20
 	hl_debugfs_remove_userptr(hdev, userptr);
=20
 	if (userptr->dma_mapped)
-		hdev->asic_funcs->hl_dma_unmap_sg(hdev,
-				userptr->sgt->sgl,
-				userptr->sgt->nents,
-				userptr->dir);
-
-	pages =3D frame_vector_pages(userptr->vec);
-	if (!IS_ERR(pages)) {
-		int i;
-
-		for (i =3D 0; i < frame_vector_count(userptr->vec); i++)
-			set_page_dirty_lock(pages[i]);
+		hdev->asic_funcs->hl_dma_unmap_sg(hdev, userptr->sgt->sgl,
+							userptr->sgt->nents,
+							userptr->dir);
+
+	/* only user memory should be manually unpinned */
+	if (!userptr->kernel_address) {
+		pages =3D frame_vector_pages(userptr->vec);
+		if (!IS_ERR(pages)) {
+			int i;
+
+			for (i =3D 0; i < frame_vector_count(userptr->vec); i++)
+				set_page_dirty_lock(pages[i]);
+		}
+		put_vaddr_frames(userptr->vec);
+		frame_vector_destroy(userptr->vec);
 	}
-	put_vaddr_frames(userptr->vec);
-	frame_vector_destroy(userptr->vec);
=20
 	list_del(&userptr->job_node);
=20
 	sg_free_table(userptr->sgt);
 	kfree(userptr->sgt);
-
-	return 0;
 }
=20
 /*
@@ -1627,11 +1722,11 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	idr_for_each_entry(&vm->phys_pg_pack_handles, phys_pg_list, i)
 		if (phys_pg_list->asid =3D=3D ctx->asid) {
 			dev_dbg(hdev->dev,
-				"page list 0x%p of asid %d is still alive\n",
+				"page list 0x%px of asid %d is still alive\n",
 				phys_pg_list, ctx->asid);
 			atomic64_sub(phys_pg_list->total_size,
 					&hdev->dram_used_mem);
-			free_phys_pg_pack(hdev, phys_pg_list);
+			hl_free_phys_pg_pack(hdev, phys_pg_list);
 			idr_remove(&vm->phys_pg_pack_handles, i);
 		}
 	spin_unlock(&vm->idr_lock);
--=20
2.17.1

