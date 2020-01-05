Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C48C00523
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 09:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C178420848
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 09:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="sF7bUzA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgAEJGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 04:06:05 -0500
Received: from mail-vi1eur05on2098.outbound.protection.outlook.com ([40.107.21.98]:2913
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbgAEJGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 04:06:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKXbPiJojpjWpfeWRcJQwCEfyW9hDXui/xQiGOFNCDZXP6yW4/lEwSvbLPZrlSE6W7d9U65iqwknIKe4rc0Sv2LUBZkJ9yUtH1tzL5xgrtL8FaquNVrpgdIWWSZgEfpiII0HnFT0xOZJB0OiSsphn8+wGDD24GSvx3WHOfsnKLSSBq2waKjRsgD5ApL3qDP2aLc/4v7SPYFqzh9LRTIcMjzzNHlbwONlyQYOxjNAKiKMulQwCLrvNNeLIzSlSOSPpJs7rylTs6jcXDbl+7dzNpHYexjgBkHNzJMbo5AcpUrbm55TjDVzbIxkZeC/DaptInPJm6XgPvoxcIeatRIo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T44tKIMIZwfwrx106ewJN63H5HtKlCLirks4UBdWejU=;
 b=MMGlDmcZfGvD6yG1H7nHkLcW0F0iqu1a3rTVRMyUp4ucNsEfqmC3GLK/3+VdSHD+8+4i65bvlGWHO1lOvCiURotFj00H1X/1Zj8LD4SVy5xNVqObm2bvTNgDDX5cg3vZ3XTjJnNQRTdSLwt7DRf4iASjmiDppsMMwfAw3nTyDpP9jv++YVeQbTQmkGgKKgG+xpYj0rc0B9Xh2JrelhIaMbaj1gYRFPHGtr98da2pzSk9VafuJeivI12fGaT5mFjLW/aQu0UcCpI9HMCAbF2zsPTVu4wkcQSK2VKoFRSRtMYi6fZd/aLqdyChfazCdrD2ssOJ6zl9jffGhmSHdzkcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T44tKIMIZwfwrx106ewJN63H5HtKlCLirks4UBdWejU=;
 b=sF7bUzA63M2knSLFVWpumEFBu3dw76YsGZMydsBK6cyFSzRbCne64irhvfqc1HTTYJ9Q3huKi0WanJZ6itD2XgGdpUvDz9opf2RU7+MNO5fkNSDXY8iSwTdG+yLiQfyLPFMAvBKpuSjoj3UbnjQQ9gEfmPZt24dzouOJmAU2jhY=
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (10.255.29.216) by
 AM0PR02MB3731.eurprd02.prod.outlook.com (52.133.63.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Sun, 5 Jan 2020 09:05:45 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::313d:beaa:db61:2e3d]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::313d:beaa:db61:2e3d%2]) with mapi id 15.20.2602.015; Sun, 5 Jan 2020
 09:05:45 +0000
Received: from oshpigelman2-vm.habana-labs.com (31.154.190.6) by ZR0P278CA0022.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend Transport; Sun, 5 Jan 2020 09:05:44 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] habanalabs: split the host MMU properties
Thread-Topic: [PATCH 1/2] habanalabs: split the host MMU properties
Thread-Index: AQHVw6dQ2swLNOzfrkiiE/ToX0A3XQ==
Date:   Sun, 5 Jan 2020 09:05:45 +0000
Message-ID: <20200105090537.19979-1-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ZR0P278CA0022.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::9) To AM0PR02MB5523.eurprd02.prod.outlook.com
 (2603:10a6:208:15e::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oshpigelman@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af32195c-400f-4a9c-a237-08d791be7295
x-ms-traffictypediagnostic: AM0PR02MB3731:
x-microsoft-antispam-prvs: <AM0PR02MB3731683830DF735E9AC5870AB83D0@AM0PR02MB3731.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 027367F73D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39840400004)(376002)(346002)(366004)(396003)(199004)(189003)(5660300002)(36756003)(6916009)(1076003)(2906002)(86362001)(6486002)(30864003)(316002)(52116002)(81156014)(956004)(2616005)(81166006)(8936002)(8676002)(66556008)(66476007)(66946007)(66446008)(64756008)(186003)(478600001)(26005)(16526019)(6506007)(4326008)(6512007)(71200400001)(579004)(559001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR02MB3731;H:AM0PR02MB5523.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MBOMoZrM7efGwT7Kbl/wxhnAebAvGfJdNQ4cJ31jHykPcWcivaxRULm/cCS8bXVre2lM5/ME2pd0Li5/mZ/fCxAkHg5Mf6uZtugHRAA8xrNURhJ3LWYWcDmvWcoX2xcmsjvZXnwvTcAqfrWn8w0yi/R+iYdm5TykXfkDgX79A4nokHMPhilstD3kACdTuB5q+vXWmy+H6F1kzz5GItt5vmH4GspJqWNSCoq2R1Avdxpgbva4vuHiERsutAwylrpZe4ZxW01XMCpkeYE3RojsyVkTxOACpO/asRrNVU4bjppOEFtbwZveSANsHbmuh1j+OBCDzf8BM0Bnr+XKuLhpH48OqHBI2qhvpc3UGafGLB+zwCHYfHBjHJLWAfqfOAjr7H/ANZkQeP64nZYaHDqtDZMe/FwZkWrGqYwS/UpYhTgKdz1pihjdfU9jRbjkq1c+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: af32195c-400f-4a9c-a237-08d791be7295
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2020 09:05:45.1555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOJ2Cgu4Ok9GwC35bnnKVzV4TdGA6+lxEafqZNzf/4rc2LXv5S0OZ1zmwi/LTnpE9sGOjgwb5w3dEpWMhJE4KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB3731
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host memory may be alloacted with huge pages.
A different virtual range may be used for mapping in this case.
Add Huge PCI MMU (HPMMU) properties to support it.
This patch is a prerequisite for future ASICs support and has no effect on
Goya ASIC as currently a single virtual host range is used for all page
sizes.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/debugfs.c             |  21 +-
 drivers/misc/habanalabs/goya/goya.c           |  25 +-
 drivers/misc/habanalabs/goya/goya_coresight.c |   4 +-
 drivers/misc/habanalabs/habanalabs.h          |  31 ++-
 drivers/misc/habanalabs/memory.c              | 213 ++++++++++++------
 drivers/misc/habanalabs/mmu.c                 |  68 +++---
 6 files changed, 225 insertions(+), 137 deletions(-)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/de=
bugfs.c
index 20413e350343..599d17dfd542 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -393,9 +393,10 @@ static int mmu_show(struct seq_file *s, void *data)
 	}
=20
 	is_dram_addr =3D hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size=
,
-				prop->va_space_dram_start_address,
-				prop->va_space_dram_end_address);
+						prop->dmmu.start_addr,
+						prop->dmmu.end_addr);
=20
+	/* shifts and masks are the same in PMMU and HPMMU, use one of them */
 	mmu_prop =3D is_dram_addr ? &prop->dmmu : &prop->pmmu;
=20
 	mutex_lock(&ctx->mmu_lock);
@@ -547,12 +548,15 @@ static bool hl_is_device_va(struct hl_device *hdev, u=
64 addr)
 		goto out;
=20
 	if (hdev->dram_supports_virtual_memory &&
-			addr >=3D prop->va_space_dram_start_address &&
-			addr < prop->va_space_dram_end_address)
+		(addr >=3D prop->dmmu.start_addr && addr < prop->dmmu.end_addr))
 		return true;
=20
-	if (addr >=3D prop->va_space_host_start_address &&
-			addr < prop->va_space_host_end_address)
+	if (addr >=3D prop->pmmu.start_addr &&
+		addr < prop->pmmu.end_addr)
+		return true;
+
+	if (addr >=3D prop->pmmu_huge.start_addr &&
+		addr < prop->pmmu_huge.end_addr)
 		return true;
 out:
 	return false;
@@ -575,9 +579,10 @@ static int device_va_to_pa(struct hl_device *hdev, u64=
 virt_addr,
 	}
=20
 	is_dram_addr =3D hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size=
,
-				prop->va_space_dram_start_address,
-				prop->va_space_dram_end_address);
+						prop->dmmu.start_addr,
+						prop->dmmu.end_addr);
=20
+	/* shifts and masks are the same in PMMU and HPMMU, use one of them */
 	mmu_prop =3D is_dram_addr ? &prop->dmmu : &prop->pmmu;
=20
 	mutex_lock(&ctx->mmu_lock);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/=
goya/goya.c
index 5750294400f4..382331cc00d3 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -393,19 +393,21 @@ void goya_get_fixed_properties(struct hl_device *hdev=
)
 	prop->dmmu.hop2_mask =3D HOP2_MASK;
 	prop->dmmu.hop3_mask =3D HOP3_MASK;
 	prop->dmmu.hop4_mask =3D HOP4_MASK;
-	prop->dmmu.huge_page_size =3D PAGE_SIZE_2MB;
+	prop->dmmu.start_addr =3D VA_DDR_SPACE_START;
+	prop->dmmu.end_addr =3D VA_DDR_SPACE_END;
+	prop->dmmu.page_size =3D PAGE_SIZE_2MB;
=20
-	/* No difference between PMMU and DMMU except of page size */
+	/* shifts and masks are the same in PMMU and DMMU */
 	memcpy(&prop->pmmu, &prop->dmmu, sizeof(prop->dmmu));
-	prop->dmmu.page_size =3D PAGE_SIZE_2MB;
+	prop->pmmu.start_addr =3D VA_HOST_SPACE_START;
+	prop->pmmu.end_addr =3D VA_HOST_SPACE_END;
 	prop->pmmu.page_size =3D PAGE_SIZE_4KB;
=20
-	prop->va_space_host_start_address =3D VA_HOST_SPACE_START;
-	prop->va_space_host_end_address =3D VA_HOST_SPACE_END;
-	prop->va_space_dram_start_address =3D VA_DDR_SPACE_START;
-	prop->va_space_dram_end_address =3D VA_DDR_SPACE_END;
-	prop->dram_size_for_default_page_mapping =3D
-			prop->va_space_dram_end_address;
+	/* PMMU and HPMMU are the same except of page size */
+	memcpy(&prop->pmmu_huge, &prop->pmmu, sizeof(prop->pmmu));
+	prop->pmmu_huge.page_size =3D PAGE_SIZE_2MB;
+
+	prop->dram_size_for_default_page_mapping =3D VA_DDR_SPACE_END;
 	prop->cfg_size =3D CFG_SIZE;
 	prop->max_asid =3D MAX_ASID;
 	prop->num_of_events =3D GOYA_ASYNC_EVENT_ID_SIZE;
@@ -3443,12 +3445,13 @@ static int goya_validate_dma_pkt_mmu(struct hl_devi=
ce *hdev,
 	/*
 	 * WA for HW-23.
 	 * We can't allow user to read from Host using QMANs other than 1.
+	 * PMMU and HPMMU addresses are equal, check only one of them.
 	 */
 	if (parser->hw_queue_id !=3D GOYA_QUEUE_ID_DMA_1 &&
 		hl_mem_area_inside_range(le64_to_cpu(user_dma_pkt->src_addr),
 				le32_to_cpu(user_dma_pkt->tsize),
-				hdev->asic_prop.va_space_host_start_address,
-				hdev->asic_prop.va_space_host_end_address)) {
+				hdev->asic_prop.pmmu.start_addr,
+				hdev->asic_prop.pmmu.end_addr)) {
 		dev_err(hdev->dev,
 			"Can't DMA from host on queue other then 1\n");
 		return -EFAULT;
diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/h=
abanalabs/goya/goya_coresight.c
index c1ee6e2b5dff..a1bc930d904f 100644
--- a/drivers/misc/habanalabs/goya/goya_coresight.c
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -364,8 +364,8 @@ static int goya_etr_validate_address(struct hl_device *=
hdev, u64 addr,
 	u64 range_start, range_end;
=20
 	if (hdev->mmu_enable) {
-		range_start =3D prop->va_space_dram_start_address;
-		range_end =3D prop->va_space_dram_end_address;
+		range_start =3D prop->dmmu.start_addr;
+		range_end =3D prop->dmmu.end_addr;
 	} else {
 		range_start =3D prop->dram_user_base_address;
 		range_end =3D prop->dram_end_address;
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs=
/habanalabs.h
index df34227dea31..5c751b9517c0 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -132,6 +132,8 @@ enum hl_device_hw_state {
=20
 /**
  * struct hl_mmu_properties - ASIC specific MMU address translation proper=
ties.
+ * @start_addr: virtual start address of the memory region.
+ * @end_addr: virtual end address of the memory region.
  * @hop0_shift: shift of hop 0 mask.
  * @hop1_shift: shift of hop 1 mask.
  * @hop2_shift: shift of hop 2 mask.
@@ -143,9 +145,10 @@ enum hl_device_hw_state {
  * @hop3_mask: mask to get the PTE address in hop 3.
  * @hop4_mask: mask to get the PTE address in hop 4.
  * @page_size: default page size used to allocate memory.
- * @huge_page_size: page size used to allocate memory with huge pages.
  */
 struct hl_mmu_properties {
+	u64	start_addr;
+	u64	end_addr;
 	u64	hop0_shift;
 	u64	hop1_shift;
 	u64	hop2_shift;
@@ -157,7 +160,6 @@ struct hl_mmu_properties {
 	u64	hop3_mask;
 	u64	hop4_mask;
 	u32	page_size;
-	u32	huge_page_size;
 };
=20
 /**
@@ -169,6 +171,8 @@ struct hl_mmu_properties {
  * @preboot_ver: F/W Preboot version.
  * @dmmu: DRAM MMU address translation properties.
  * @pmmu: PCI (host) MMU address translation properties.
+ * @pmmu_huge: PCI (host) MMU address translation properties for memory
+ *              allocated with huge pages.
  * @sram_base_address: SRAM physical start address.
  * @sram_end_address: SRAM physical end address.
  * @sram_user_base_address - SRAM physical start address for user access.
@@ -178,14 +182,6 @@ struct hl_mmu_properties {
  * @dram_size: DRAM total size.
  * @dram_pci_bar_size: size of PCI bar towards DRAM.
  * @max_power_default: max power of the device after reset
- * @va_space_host_start_address: base address of virtual memory range for
- *                               mapping host memory.
- * @va_space_host_end_address: end address of virtual memory range for
- *                             mapping host memory.
- * @va_space_dram_start_address: base address of virtual memory range for
- *                               mapping DRAM memory.
- * @va_space_dram_end_address: end address of virtual memory range for
- *                             mapping DRAM memory.
  * @dram_size_for_default_page_mapping: DRAM size needed to map to avoid p=
age
  *                                      fault.
  * @pcie_dbi_base_address: Base address of the PCIE_DBI block.
@@ -218,6 +214,7 @@ struct asic_fixed_properties {
 	char				preboot_ver[VERSION_MAX_LEN];
 	struct hl_mmu_properties	dmmu;
 	struct hl_mmu_properties	pmmu;
+	struct hl_mmu_properties	pmmu_huge;
 	u64				sram_base_address;
 	u64				sram_end_address;
 	u64				sram_user_base_address;
@@ -227,10 +224,6 @@ struct asic_fixed_properties {
 	u64				dram_size;
 	u64				dram_pci_bar_size;
 	u64				max_power_default;
-	u64				va_space_host_start_address;
-	u64				va_space_host_end_address;
-	u64				va_space_dram_start_address;
-	u64				va_space_dram_end_address;
 	u64				dram_size_for_default_page_mapping;
 	u64				pcie_dbi_base_address;
 	u64				pcie_aux_dbi_reg_addr;
@@ -658,6 +651,8 @@ struct hl_va_range {
  *		this hits 0l. It is incremented on CS and CS_WAIT.
  * @cs_pending: array of DMA fence objects representing pending CS.
  * @host_va_range: holds available virtual addresses for host mappings.
+ * @host_huge_va_range: holds available virtual addresses for host mapping=
s
+ *                      with huge pages.
  * @dram_va_range: holds available virtual addresses for DRAM mappings.
  * @mem_hash_lock: protects the mem_hash.
  * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifin=
g the
@@ -688,8 +683,9 @@ struct hl_ctx {
 	struct hl_device	*hdev;
 	struct kref		refcount;
 	struct dma_fence	*cs_pending[HL_MAX_PENDING_CS];
-	struct hl_va_range	host_va_range;
-	struct hl_va_range	dram_va_range;
+	struct hl_va_range	*host_va_range;
+	struct hl_va_range	*host_huge_va_range;
+	struct hl_va_range	*dram_va_range;
 	struct mutex		mem_hash_lock;
 	struct mutex		mmu_lock;
 	struct list_head	debugfs_list;
@@ -1291,6 +1287,8 @@ struct hl_device_idle_busy_ts {
  *                   otherwise.
  * @dram_supports_virtual_memory: is MMU enabled towards DRAM.
  * @dram_default_page_mapping: is DRAM default page mapping enabled.
+ * @pmmu_huge_range: is a different virtual addresses range used for PMMU =
with
+ *                   huge pages.
  * @init_done: is the initialization of the device done.
  * @mmu_enable: is MMU enabled.
  * @device_cpu_disabled: is the device CPU disabled (due to timeouts)
@@ -1372,6 +1370,7 @@ struct hl_device {
 	u8				reset_on_lockup;
 	u8				dram_supports_virtual_memory;
 	u8				dram_default_page_mapping;
+	u8				pmmu_huge_range;
 	u8				init_done;
 	u8				device_cpu_disabled;
 	u8				dma_mask;
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/mem=
ory.c
index b612b1ad0aac..a72f766ca470 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -530,7 +530,7 @@ static u64 get_va_block(struct hl_device *hdev,
 		 * or not, hence we continue with the biggest possible
 		 * granularity.
 		 */
-		page_size =3D hdev->asic_prop.pmmu.huge_page_size;
+		page_size =3D hdev->asic_prop.pmmu_huge.page_size;
 	else
 		page_size =3D hdev->asic_prop.dmmu.page_size;
=20
@@ -638,13 +638,12 @@ static int init_phys_pg_pack_from_userptr(struct hl_c=
tx *ctx,
 				struct hl_userptr *userptr,
 				struct hl_vm_phys_pg_pack **pphys_pg_pack)
 {
-	struct hl_mmu_properties *mmu_prop =3D &ctx->hdev->asic_prop.pmmu;
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
 	struct scatterlist *sg;
 	dma_addr_t dma_addr;
 	u64 page_mask, total_npages;
 	u32 npages, page_size =3D PAGE_SIZE,
-		huge_page_size =3D mmu_prop->huge_page_size;
+		huge_page_size =3D ctx->hdev->asic_prop.pmmu_huge.page_size;
 	bool first =3D true, is_huge_page_opt =3D true;
 	int rc, i, j;
 	u32 pgs_in_huge_page =3D huge_page_size >> __ffs(page_size);
@@ -856,6 +855,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_=
mem_in *args,
 	struct hl_vm_phys_pg_pack *phys_pg_pack;
 	struct hl_userptr *userptr =3D NULL;
 	struct hl_vm_hash_node *hnode;
+	struct hl_va_range *va_range;
 	enum vm_type_t *vm_type;
 	u64 ret_vaddr, hint_addr;
 	u32 handle =3D 0;
@@ -927,9 +927,16 @@ static int map_device_va(struct hl_ctx *ctx, struct hl=
_mem_in *args,
 		goto hnode_err;
 	}
=20
-	ret_vaddr =3D get_va_block(hdev,
-			is_userptr ? &ctx->host_va_range : &ctx->dram_va_range,
-			phys_pg_pack->total_size, hint_addr, is_userptr);
+	if (is_userptr)
+		if (phys_pg_pack->page_size =3D=3D hdev->asic_prop.pmmu.page_size)
+			va_range =3D ctx->host_va_range;
+		else
+			va_range =3D ctx->host_huge_va_range;
+	else
+		va_range =3D ctx->dram_va_range;
+
+	ret_vaddr =3D get_va_block(hdev, va_range, phys_pg_pack->total_size,
+					hint_addr, is_userptr);
 	if (!ret_vaddr) {
 		dev_err(hdev->dev, "no available va block for handle %u\n",
 				handle);
@@ -968,10 +975,8 @@ static int map_device_va(struct hl_ctx *ctx, struct hl=
_mem_in *args,
 	return 0;
=20
 map_err:
-	if (add_va_block(hdev,
-			is_userptr ? &ctx->host_va_range : &ctx->dram_va_range,
-			ret_vaddr,
-			ret_vaddr + phys_pg_pack->total_size - 1))
+	if (add_va_block(hdev, va_range, ret_vaddr,
+				ret_vaddr + phys_pg_pack->total_size - 1))
 		dev_warn(hdev->dev,
 			"release va block failed for handle 0x%x, vaddr: 0x%llx\n",
 				handle, ret_vaddr);
@@ -1033,7 +1038,6 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 va=
ddr, bool ctx_free)
=20
 	if (*vm_type =3D=3D VM_TYPE_USERPTR) {
 		is_userptr =3D true;
-		va_range =3D &ctx->host_va_range;
 		userptr =3D hnode->ptr;
 		rc =3D init_phys_pg_pack_from_userptr(ctx, userptr,
 							&phys_pg_pack);
@@ -1043,9 +1047,15 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 v=
addr, bool ctx_free)
 				vaddr);
 			goto vm_type_err;
 		}
+
+		if (phys_pg_pack->page_size =3D=3D
+					hdev->asic_prop.pmmu.page_size)
+			va_range =3D ctx->host_va_range;
+		else
+			va_range =3D ctx->host_huge_va_range;
 	} else if (*vm_type =3D=3D VM_TYPE_PHYS_PACK) {
 		is_userptr =3D false;
-		va_range =3D &ctx->dram_va_range;
+		va_range =3D ctx->dram_va_range;
 		phys_pg_pack =3D hnode->ptr;
 	} else {
 		dev_warn(hdev->dev,
@@ -1441,19 +1451,18 @@ bool hl_userptr_is_pinned(struct hl_device *hdev, u=
64 addr,
 }
=20
 /*
- * hl_va_range_init - initialize virtual addresses range
- *
- * @hdev                : pointer to the habanalabs device structure
- * @va_range            : pointer to the range to initialize
- * @start               : range start address
- * @end                 : range end address
+ * va_range_init - initialize virtual addresses range
+ * @hdev: pointer to the habanalabs device structure
+ * @va_range: pointer to the range to initialize
+ * @start: range start address
+ * @end: range end address
  *
  * This function does the following:
  * - Initializes the virtual addresses list of the given range with the gi=
ven
  *   addresses.
  */
-static int hl_va_range_init(struct hl_device *hdev,
-		struct hl_va_range *va_range, u64 start, u64 end)
+static int va_range_init(struct hl_device *hdev, struct hl_va_range *va_ra=
nge,
+				u64 start, u64 end)
 {
 	int rc;
=20
@@ -1488,47 +1497,105 @@ static int hl_va_range_init(struct hl_device *hdev=
,
 }
=20
 /*
- * hl_vm_ctx_init_with_ranges - initialize virtual memory for context
+ * va_range_fini() - clear a virtual addresses range
+ * @hdev: pointer to the habanalabs structure
+ * va_range: pointer to virtual addresses range
  *
- * @ctx                 : pointer to the habanalabs context structure
- * @host_range_start    : host virtual addresses range start
- * @host_range_end      : host virtual addresses range end
- * @dram_range_start    : dram virtual addresses range start
- * @dram_range_end      : dram virtual addresses range end
+ * This function does the following:
+ * - Frees the virtual addresses block list and its lock
+ */
+static void va_range_fini(struct hl_device *hdev,
+		struct hl_va_range *va_range)
+{
+	mutex_lock(&va_range->lock);
+	clear_va_list_locked(hdev, &va_range->list);
+	mutex_unlock(&va_range->lock);
+
+	mutex_destroy(&va_range->lock);
+	kfree(va_range);
+}
+
+/*
+ * vm_ctx_init_with_ranges() - initialize virtual memory for context
+ * @ctx: pointer to the habanalabs context structure
+ * @host_range_start: host virtual addresses range start.
+ * @host_range_end: host virtual addresses range end.
+ * @host_huge_range_start: host virtual addresses range start for memory
+ *                          allocated with huge pages.
+ * @host_huge_range_end: host virtual addresses range end for memory alloc=
ated
+ *                        with huge pages.
+ * @dram_range_start: dram virtual addresses range start.
+ * @dram_range_end: dram virtual addresses range end.
  *
  * This function initializes the following:
  * - MMU for context
  * - Virtual address to area descriptor hashtable
  * - Virtual block list of available virtual memory
  */
-static int hl_vm_ctx_init_with_ranges(struct hl_ctx *ctx, u64 host_range_s=
tart,
-				u64 host_range_end, u64 dram_range_start,
-				u64 dram_range_end)
+static int vm_ctx_init_with_ranges(struct hl_ctx *ctx,
+					u64 host_range_start,
+					u64 host_range_end,
+					u64 host_huge_range_start,
+					u64 host_huge_range_end,
+					u64 dram_range_start,
+					u64 dram_range_end)
 {
 	struct hl_device *hdev =3D ctx->hdev;
 	int rc;
=20
+	ctx->host_va_range =3D kzalloc(sizeof(*ctx->host_va_range), GFP_KERNEL);
+	if (!ctx->host_va_range)
+		return -ENOMEM;
+
+	ctx->host_huge_va_range =3D kzalloc(sizeof(*ctx->host_huge_va_range),
+						GFP_KERNEL);
+	if (!ctx->host_huge_va_range) {
+		rc =3D  -ENOMEM;
+		goto host_huge_va_range_err;
+	}
+
+	ctx->dram_va_range =3D kzalloc(sizeof(*ctx->dram_va_range), GFP_KERNEL);
+	if (!ctx->dram_va_range) {
+		rc =3D -ENOMEM;
+		goto dram_va_range_err;
+	}
+
 	rc =3D hl_mmu_ctx_init(ctx);
 	if (rc) {
 		dev_err(hdev->dev, "failed to init context %d\n", ctx->asid);
-		return rc;
+		goto mmu_ctx_err;
 	}
=20
 	mutex_init(&ctx->mem_hash_lock);
 	hash_init(ctx->mem_hash);
=20
-	mutex_init(&ctx->host_va_range.lock);
+	mutex_init(&ctx->host_va_range->lock);
=20
-	rc =3D hl_va_range_init(hdev, &ctx->host_va_range, host_range_start,
-			host_range_end);
+	rc =3D va_range_init(hdev, ctx->host_va_range, host_range_start,
+				host_range_end);
 	if (rc) {
 		dev_err(hdev->dev, "failed to init host vm range\n");
-		goto host_vm_err;
+		goto host_page_range_err;
+	}
+
+	if (hdev->pmmu_huge_range) {
+		mutex_init(&ctx->host_huge_va_range->lock);
+
+		rc =3D va_range_init(hdev, ctx->host_huge_va_range,
+					host_huge_range_start,
+					host_huge_range_end);
+		if (rc) {
+			dev_err(hdev->dev,
+				"failed to init host huge vm range\n");
+			goto host_hpage_range_err;
+		}
+	} else {
+		ctx->host_huge_va_range =3D ctx->host_va_range;
 	}
=20
-	mutex_init(&ctx->dram_va_range.lock);
+	mutex_init(&ctx->dram_va_range->lock);
=20
-	rc =3D hl_va_range_init(hdev, &ctx->dram_va_range, dram_range_start,
+	rc =3D va_range_init(hdev, ctx->dram_va_range, dram_range_start,
 			dram_range_end);
 	if (rc) {
 		dev_err(hdev->dev, "failed to init dram vm range\n");
@@ -1540,15 +1607,29 @@ static int hl_vm_ctx_init_with_ranges(struct hl_ctx=
 *ctx, u64 host_range_start,
 	return 0;
=20
 dram_vm_err:
-	mutex_destroy(&ctx->dram_va_range.lock);
+	mutex_destroy(&ctx->dram_va_range->lock);
=20
-	mutex_lock(&ctx->host_va_range.lock);
-	clear_va_list_locked(hdev, &ctx->host_va_range.list);
-	mutex_unlock(&ctx->host_va_range.lock);
-host_vm_err:
-	mutex_destroy(&ctx->host_va_range.lock);
+	if (hdev->pmmu_huge_range) {
+		mutex_lock(&ctx->host_huge_va_range->lock);
+		clear_va_list_locked(hdev, &ctx->host_huge_va_range->list);
+		mutex_unlock(&ctx->host_huge_va_range->lock);
+	}
+host_hpage_range_err:
+	if (hdev->pmmu_huge_range)
+		mutex_destroy(&ctx->host_huge_va_range->lock);
+	mutex_lock(&ctx->host_va_range->lock);
+	clear_va_list_locked(hdev, &ctx->host_va_range->list);
+	mutex_unlock(&ctx->host_va_range->lock);
+host_page_range_err:
+	mutex_destroy(&ctx->host_va_range->lock);
 	mutex_destroy(&ctx->mem_hash_lock);
 	hl_mmu_ctx_fini(ctx);
+mmu_ctx_err:
+	kfree(ctx->dram_va_range);
+dram_va_range_err:
+	kfree(ctx->host_huge_va_range);
+host_huge_va_range_err:
+	kfree(ctx->host_va_range);
=20
 	return rc;
 }
@@ -1556,8 +1637,8 @@ static int hl_vm_ctx_init_with_ranges(struct hl_ctx *=
ctx, u64 host_range_start,
 int hl_vm_ctx_init(struct hl_ctx *ctx)
 {
 	struct asic_fixed_properties *prop =3D &ctx->hdev->asic_prop;
-	u64 host_range_start, host_range_end, dram_range_start,
-		dram_range_end;
+	u64 host_range_start, host_range_end, host_huge_range_start,
+		host_huge_range_end, dram_range_start, dram_range_end;
=20
 	atomic64_set(&ctx->dram_phys_mem, 0);
=20
@@ -1569,38 +1650,26 @@ int hl_vm_ctx_init(struct hl_ctx *ctx)
 	 *   address of the memory related to the given handle.
 	 */
 	if (ctx->hdev->mmu_enable) {
-		dram_range_start =3D prop->va_space_dram_start_address;
-		dram_range_end =3D prop->va_space_dram_end_address;
-		host_range_start =3D prop->va_space_host_start_address;
-		host_range_end =3D prop->va_space_host_end_address;
+		dram_range_start =3D prop->dmmu.start_addr;
+		dram_range_end =3D prop->dmmu.end_addr;
+		host_range_start =3D prop->pmmu.start_addr;
+		host_range_end =3D prop->pmmu.end_addr;
+		host_huge_range_start =3D prop->pmmu_huge.start_addr;
+		host_huge_range_end =3D prop->pmmu_huge.end_addr;
 	} else {
 		dram_range_start =3D prop->dram_user_base_address;
 		dram_range_end =3D prop->dram_end_address;
 		host_range_start =3D prop->dram_user_base_address;
 		host_range_end =3D prop->dram_end_address;
+		host_huge_range_start =3D prop->dram_user_base_address;
+		host_huge_range_end =3D prop->dram_end_address;
 	}
=20
-	return hl_vm_ctx_init_with_ranges(ctx, host_range_start, host_range_end,
-			dram_range_start, dram_range_end);
-}
-
-/*
- * hl_va_range_fini     - clear a virtual addresses range
- *
- * @hdev                : pointer to the habanalabs structure
- * va_range             : pointer to virtual addresses range
- *
- * This function does the following:
- * - Frees the virtual addresses block list and its lock
- */
-static void hl_va_range_fini(struct hl_device *hdev,
-		struct hl_va_range *va_range)
-{
-	mutex_lock(&va_range->lock);
-	clear_va_list_locked(hdev, &va_range->list);
-	mutex_unlock(&va_range->lock);
-
-	mutex_destroy(&va_range->lock);
+	return vm_ctx_init_with_ranges(ctx, host_range_start, host_range_end,
+					host_huge_range_start,
+					host_huge_range_end,
+					dram_range_start,
+					dram_range_end);
 }
=20
 /*
@@ -1667,8 +1736,10 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 		}
 	spin_unlock(&vm->idr_lock);
=20
-	hl_va_range_fini(hdev, &ctx->dram_va_range);
-	hl_va_range_fini(hdev, &ctx->host_va_range);
+	va_range_fini(hdev, ctx->dram_va_range);
+	if (hdev->pmmu_huge_range)
+		va_range_fini(hdev, ctx->host_huge_va_range);
+	va_range_fini(hdev, ctx->host_va_range);
=20
 	mutex_destroy(&ctx->mem_hash_lock);
 	hl_mmu_ctx_fini(ctx);
diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index 006eee47909d..a290d6b49d78 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -254,6 +254,15 @@ static inline u64 get_phys_addr(struct hl_ctx *ctx, u6=
4 shadow_addr)
 	return phys_hop_addr + pte_offset;
 }
=20
+static bool is_dram_va(struct hl_device *hdev, u64 virt_addr)
+{
+	struct asic_fixed_properties *prop =3D &hdev->asic_prop;
+
+	return hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size,
+					prop->dmmu.start_addr,
+					prop->dmmu.end_addr);
+}
+
 static int dram_default_mapping_init(struct hl_ctx *ctx)
 {
 	struct hl_device *hdev =3D ctx->hdev;
@@ -548,6 +557,7 @@ static int _hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_a=
ddr, bool is_dram_addr)
 		curr_pte;
 	bool is_huge, clear_hop3 =3D true;
=20
+	/* shifts and masks are the same in PMMU and HPMMU, use one of them */
 	mmu_prop =3D is_dram_addr ? &prop->dmmu : &prop->pmmu;
=20
 	hop0_addr =3D get_hop0_addr(ctx);
@@ -702,26 +712,25 @@ int hl_mmu_unmap(struct hl_ctx *ctx, u64 virt_addr, u=
32 page_size,
 	if (!hdev->mmu_enable)
 		return 0;
=20
-	is_dram_addr =3D hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size=
,
-				prop->va_space_dram_start_address,
-				prop->va_space_dram_end_address);
+	is_dram_addr =3D is_dram_va(hdev, virt_addr);
=20
-	mmu_prop =3D is_dram_addr ? &prop->dmmu : &prop->pmmu;
+	if (is_dram_addr)
+		mmu_prop =3D &prop->dmmu;
+	else if ((page_size % prop->pmmu_huge.page_size) =3D=3D 0)
+		mmu_prop =3D &prop->pmmu_huge;
+	else
+		mmu_prop =3D &prop->pmmu;
=20
 	/*
 	 * The H/W handles mapping of specific page sizes. Hence if the page
 	 * size is bigger, we break it to sub-pages and unmap them separately.
 	 */
-	if ((page_size % mmu_prop->huge_page_size) =3D=3D 0) {
-		real_page_size =3D mmu_prop->huge_page_size;
-	} else if ((page_size % mmu_prop->page_size) =3D=3D 0) {
+	if ((page_size % mmu_prop->page_size) =3D=3D 0) {
 		real_page_size =3D mmu_prop->page_size;
 	} else {
 		dev_err(hdev->dev,
-			"page size of %u is not %uKB nor %uMB aligned, can't unmap\n",
-			page_size,
-			mmu_prop->page_size >> 10,
-			mmu_prop->huge_page_size >> 20);
+			"page size of %u is not %uKB aligned, can't unmap\n",
+			page_size, mmu_prop->page_size >> 10);
=20
 		return -EFAULT;
 	}
@@ -759,8 +768,6 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_add=
r, u64 phys_addr,
 		hop4_new =3D false, is_huge;
 	int rc =3D -ENOMEM;
=20
-	mmu_prop =3D is_dram_addr ? &prop->dmmu : &prop->pmmu;
-
 	/*
 	 * This mapping function can map a page or a huge page. For huge page
 	 * there are only 3 hops rather than 4. Currently the DRAM allocation
@@ -768,11 +775,15 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_a=
ddr, u64 phys_addr,
 	 * one of the two page sizes. Since this is a common code for all the
 	 * three cases, we need this hugs page check.
 	 */
-	is_huge =3D page_size =3D=3D mmu_prop->huge_page_size;
-
-	if (is_dram_addr && !is_huge) {
-		dev_err(hdev->dev, "DRAM mapping should use huge pages only\n");
-		return -EFAULT;
+	if (is_dram_addr) {
+		mmu_prop =3D &prop->dmmu;
+		is_huge =3D true;
+	} else if (page_size =3D=3D prop->pmmu_huge.page_size) {
+		mmu_prop =3D &prop->pmmu_huge;
+		is_huge =3D true;
+	} else {
+		mmu_prop =3D &prop->pmmu;
+		is_huge =3D false;
 	}
=20
 	hop0_addr =3D get_hop0_addr(ctx);
@@ -942,26 +953,25 @@ int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64=
 phys_addr, u32 page_size,
 	if (!hdev->mmu_enable)
 		return 0;
=20
-	is_dram_addr =3D hl_mem_area_inside_range(virt_addr, prop->dmmu.page_size=
,
-				prop->va_space_dram_start_address,
-				prop->va_space_dram_end_address);
+	is_dram_addr =3D is_dram_va(hdev, virt_addr);
=20
-	mmu_prop =3D is_dram_addr ? &prop->dmmu : &prop->pmmu;
+	if (is_dram_addr)
+		mmu_prop =3D &prop->dmmu;
+	else if ((page_size % prop->pmmu_huge.page_size) =3D=3D 0)
+		mmu_prop =3D &prop->pmmu_huge;
+	else
+		mmu_prop =3D &prop->pmmu;
=20
 	/*
 	 * The H/W handles mapping of specific page sizes. Hence if the page
 	 * size is bigger, we break it to sub-pages and map them separately.
 	 */
-	if ((page_size % mmu_prop->huge_page_size) =3D=3D 0) {
-		real_page_size =3D mmu_prop->huge_page_size;
-	} else if ((page_size % mmu_prop->page_size) =3D=3D 0) {
+	if ((page_size % mmu_prop->page_size) =3D=3D 0) {
 		real_page_size =3D mmu_prop->page_size;
 	} else {
 		dev_err(hdev->dev,
-			"page size of %u is not %dKB nor %dMB aligned, can't unmap\n",
-			page_size,
-			mmu_prop->page_size >> 10,
-			mmu_prop->huge_page_size >> 20);
+			"page size of %u is not %uKB aligned, can't unmap\n",
+			page_size, mmu_prop->page_size >> 10);
=20
 		return -EFAULT;
 	}
--=20
2.17.1

