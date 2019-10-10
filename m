Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4663C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C168206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="W4L1sH8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfJJOGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:06:31 -0400
Received: from mail-eopbgr140125.outbound.protection.outlook.com ([40.107.14.125]:43673
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbfJJOGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:06:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpE3l3M3FfFp5QhiuZwpnrGyOew2ONXkV4/67x0+9yzO42f6aqSnkICkm/RxnT7fsmW3/1S5K09Vze/qgkBNGjFqZpRuKKYlQPS3bCHnmTyhmr+lVtGRT01PPvvP7oiQUNUqi9QyIT3xyyZ0eWoo4fGNkK+YIKRHgy/ZfYp59FmB6tfQcwVCFEz8hAp3dwHkG9ks/FwpuAnWhGTi0+UNQjJovwmlnrEAq2Xyv/7CrhgGA2To9YzXKQrjAtb0bNKf7lDvK6HZfCfeVUnDSZR2bCl0QrTZdUIXVdL8bIQF5w2MGokobTUwJhgGpwJl23XUZ+aOnkrRPuNT6V2FON45gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEBOPVm9pjsT40Tb4m1esRSsHfmStUNNTRIfmgP00hA=;
 b=iPJ9XCXht1QDsVLgXNCWEfYrVfh3ASWeCLZPCKaq9D6NZl6AMx1ObgP/KDSMv4gigfWdu72h4AIbdnTpS1jMuyoqTSHm+qgDjcenj/83NnYMaED3np48j4Gm7kX4VFkqYdnJFz4VC8p0lvqgv+CQtpp9XWVqorsc9Mn6JK/9OF5k+l6iOPualXlf7cGacxkUljAlm93ZkX4x156Qe/s13wQVOqKrHnQ0EeDOCUWeMSLnIp8MUE8a3a+Uc9khkiY+9PRnQLaM3LzWPBTZtmZzDlekvRIFAcJoeQMBmNVc6K7H2C6/tP6VjdlbJnxaCLbz7R8lGHtLlHlGR6NusujygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEBOPVm9pjsT40Tb4m1esRSsHfmStUNNTRIfmgP00hA=;
 b=W4L1sH8JgxtuWl80Et6RHDR+nFZjubvbkOn9wn/t1/tt0xHr/jX2GaQA1gk2sfbXfa/GDFjAbmGmDe7vT0fCUE1AMuzceNtv+/hw5F8Y67TffWtg54Iy8yRuNRPGQo9w7i59mOyX8yZeO6oh29lj9TSm1o62gxa3RJtfRZ8MWyw=
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com (52.133.8.16) by
 AM6PR0202MB3447.eurprd02.prod.outlook.com (52.133.8.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 14:06:22 +0000
Received: from AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251]) by AM6PR0202MB3382.eurprd02.prod.outlook.com
 ([fe80::6479:5608:22f:e251%5]) with mapi id 15.20.2327.026; Thu, 10 Oct 2019
 14:06:22 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] habanalabs: support vmalloc memory mapping
Thread-Topic: [PATCH 1/2] habanalabs: support vmalloc memory mapping
Thread-Index: AQHVf3PlrNoEOJqtQ0eTOfjIKEa+lA==
Date:   Thu, 10 Oct 2019 14:06:22 +0000
Message-ID: <20191010140615.26460-1-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0073.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::14) To AM6PR0202MB3382.eurprd02.prod.outlook.com
 (2603:10a6:209:20::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ae8b1f7-9457-4787-f791-08d74d8b07a3
x-ms-traffictypediagnostic: AM6PR0202MB3447:
x-microsoft-antispam-prvs: <AM6PR0202MB3447055B13036E708F4B0C9EB8940@AM6PR0202MB3447.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:517;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(136003)(346002)(39840400004)(199004)(189003)(30864003)(4326008)(81166006)(52116002)(2351001)(186003)(25786009)(316002)(256004)(386003)(14444005)(3846002)(6116002)(7736002)(26005)(50226002)(8936002)(102836004)(8676002)(5660300002)(1361003)(81156014)(14454004)(1076003)(99286004)(305945005)(6506007)(66066001)(71190400001)(71200400001)(6436002)(66446008)(64756008)(66556008)(66476007)(6916009)(6486002)(86362001)(486006)(36756003)(2501003)(478600001)(66946007)(6512007)(2906002)(2616005)(476003)(5640700003)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0202MB3447;H:AM6PR0202MB3382.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ZR55BtMxUIUBmwG1Q+obp1EGjDVkelBJFFam7eM01Qfu8kRImz7WP4oXsU+HcyjbNQhPGBa0HeBM2F3Rei6hQvBKrL3FA6qR9LdPTE8KRc0q6h1fGgl3eHHRHh6Xj4pj+Nmu2l6+dUhE88rk6LLHDLrJlMLxnMXjuYJhvnAo1/0c6w8bYxl0Q8sTCU3u8EQ9tWnzPaBBMtmweEumkvPOKWnB2N0S3piUELXKdfK04R6eUPqBdi108KWnwKMsLUtCwU8rwSz0ALSUfe4TEcTduTPk6gv/IWqlDGOO5jYGbErx6uKqSXgnhEcstFxiZollzzvbKsbmBs9pbogI4KVvkDvSI3tiPsmfvkvMo79/fkMdEIrK+6iy9W9CRRRRy1EmOCeDYrKYOI9GUAReyyUWfMI8aJ3xx4Jy3CrII8nnrc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae8b1f7-9457-4787-f791-08d74d8b07a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 14:06:22.3461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +kaRDR744L5xwvryDyGh+Y/eRXWyKAydZioY7Yf2QyzyM5NeggNhPgqiB5GIeUnwhRqWp/Pu8FyDf4g92ooFxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0202MB3447
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support in mapping of vmalloc memory.
In contrary to user memory, vmalloc memory is already pinned and has no
vm_area structure. Therefore a new capability was needed in order to map
this memory.
Mapping vmalloc memory is needed for Gaudi ASIC.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/goya/goya.c  |   2 +-
 drivers/misc/habanalabs/habanalabs.h |  13 +-
 drivers/misc/habanalabs/memory.c     | 405 ++++++++++++++++-----------
 3 files changed, 261 insertions(+), 159 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/=
goya/goya.c
index d49f5ecd903b..949d3c54b351 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3936,7 +3936,7 @@ static int goya_parse_cb_no_ext_queue(struct hl_devic=
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
index 91445371b08b..8577f29f54fe 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1527,9 +1527,20 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx);
 int hl_vm_init(struct hl_device *hdev);
 void hl_vm_fini(struct hl_device *hdev);
=20
+int hl_dma_map_host_va(struct hl_device *hdev, u64 addr, u64 size,
+				struct hl_userptr **p_userptr);
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
index 365fb0cb8dff..cec4155533af 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -159,20 +159,20 @@ static int alloc_device_memory(struct hl_ctx *ctx, st=
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
+					struct hl_userptr **p_userptr)
 {
 	struct hl_userptr *userptr;
 	int rc;
@@ -183,8 +183,7 @@ static int get_userptr_from_host_va(struct hl_device *h=
dev,
 		goto userptr_err;
 	}
=20
-	rc =3D hl_pin_host_memory(hdev, args->map_host.host_virt_addr,
-			args->map_host.mem_size, userptr);
+	rc =3D hl_pin_host_memory(hdev, addr, size, userptr);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to pin host memory\n");
 		goto pin_err;
@@ -215,16 +214,15 @@ static int get_userptr_from_host_va(struct hl_device =
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
@@ -253,18 +251,17 @@ static void dram_pg_pool_do_release(struct kref *ref)
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
@@ -328,7 +325,7 @@ static int free_device_memory(struct hl_ctx *ctx, u32 h=
andle)
 		atomic64_sub(phys_pg_pack->total_size, &ctx->dram_phys_mem);
 		atomic64_sub(phys_pg_pack->total_size, &hdev->dram_used_mem);
=20
-		free_phys_pg_pack(hdev, phys_pg_pack);
+		hl_free_phys_pg_pack(hdev, phys_pg_pack);
 	} else {
 		spin_unlock(&vm->idr_lock);
 		dev_err(hdev->dev,
@@ -630,21 +627,19 @@ static u32 get_sg_info(struct scatterlist *sg, dma_ad=
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
@@ -660,7 +655,7 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx=
 *ctx,
=20
 	phys_pg_pack->vm_type =3D userptr->vm_type;
 	phys_pg_pack->created_from_userptr =3D true;
-	phys_pg_pack->asid =3D ctx->asid;
+	phys_pg_pack->asid =3D asid;
 	atomic_set(&phys_pg_pack->mapping_cnt, 1);
=20
 	/* Only if all dma_addrs are aligned to 2MB and their
@@ -731,19 +726,18 @@ static int init_phys_pg_pack_from_userptr(struct hl_c=
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
@@ -783,6 +777,36 @@ static int map_phys_page_pack(struct hl_ctx *ctx, u64 =
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
@@ -827,7 +851,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_=
mem_in *args,
 	struct hl_device *hdev =3D ctx->hdev;
 	struct hl_vm *vm =3D &hdev->vm;
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
-	struct hl_userptr *userptr =3D NULL;
+	struct hl_userptr *userptr;
 	struct hl_vm_hash_node *hnode;
 	enum vm_type_t *vm_type;
 	u64 ret_vaddr, hint_addr;
@@ -839,18 +863,21 @@ static int map_device_va(struct hl_ctx *ctx, struct h=
l_mem_in *args,
 	*device_addr =3D 0;
=20
 	if (is_userptr) {
-		rc =3D get_userptr_from_host_va(hdev, args, &userptr);
+		u64 addr =3D args->map_host.host_virt_addr,
+			size =3D args->map_host.mem_size;
+
+		rc =3D hl_dma_map_host_va(hdev, addr, size, &userptr);
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
@@ -909,7 +936,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_=
mem_in *args,
=20
 	mutex_lock(&ctx->mmu_lock);
=20
-	rc =3D map_phys_page_pack(ctx, ret_vaddr, phys_pg_pack);
+	rc =3D hl_map_phys_pg_pack(ctx, ret_vaddr, phys_pg_pack);
 	if (rc) {
 		mutex_unlock(&ctx->mmu_lock);
 		dev_err(hdev->dev, "mapping page pack failed for handle %u\n",
@@ -933,7 +960,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_=
mem_in *args,
 	*device_addr =3D ret_vaddr;
=20
 	if (is_userptr)
-		free_phys_pg_pack(hdev, phys_pg_pack);
+		hl_free_phys_pg_pack(hdev, phys_pg_pack);
=20
 	return 0;
=20
@@ -952,10 +979,10 @@ static int map_device_va(struct hl_ctx *ctx, struct h=
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
@@ -977,8 +1004,6 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vad=
dr)
 	struct hl_vm_hash_node *hnode =3D NULL;
 	struct hl_userptr *userptr =3D NULL;
 	enum vm_type_t *vm_type;
-	u64 next_vaddr, i;
-	u32 page_size;
 	bool is_userptr;
 	int rc;
=20
@@ -1004,8 +1029,8 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 va=
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
@@ -1029,24 +1054,11 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 =
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
@@ -1063,15 +1075,15 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 =
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
@@ -1203,56 +1215,60 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data=
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
@@ -1279,26 +1295,16 @@ int hl_pin_host_memory(struct hl_device *hdev, u64 =
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
@@ -1307,43 +1313,128 @@ int hl_pin_host_memory(struct hl_device *hdev, u64=
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
+	if (is_vmalloc_addr((void *) (uintptr_t) addr)) {
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
+	if (!is_vmalloc_addr((void *) (uintptr_t) userptr->addr)) {
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
@@ -1627,11 +1718,11 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
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

