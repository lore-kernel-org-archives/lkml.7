Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A0AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2EE2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EM4ioaB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfCSVyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:54:32 -0400
Received: from mail-eopbgr710050.outbound.protection.outlook.com ([40.107.71.50]:45844
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbfCSVya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5R/HpNd1eDhTNrzM8nkopaxGdUsqdC9sGcgWDoIptzE=;
 b=EM4ioaB7brhWJQOdiFr/e++NZhj2h82qzBW8T3k0o3cuvUoZ6GLdCTBTc+G3Yo7h+D2Q7Nz3T9yh67Tevb72/Q2OK92ap+QTjB2GN2HU26YQyZ5Evr0SNsOjCAIH9nrkDZN8pBYhVD8bEmTI6pO9Q2lcUKHdkXfrVOQXkHmfVk0=
Received: from MWHPR02CA0057.namprd02.prod.outlook.com (2603:10b6:301:60::46)
 by BL0PR02MB5539.namprd02.prod.outlook.com (2603:10b6:208:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Tue, 19 Mar
 2019 21:54:15 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by MWHPR02CA0057.outlook.office365.com
 (2603:10b6:301:60::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 21:54:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Tue, 19 Mar 2019 21:54:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1h6MgY-0001Qc-1r; Tue, 19 Mar 2019 14:54:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1h6MgS-0001Ps-U4; Tue, 19 Mar 2019 14:54:08 -0700
Received: from [172.19.73.196] (helo=xsjsonals5570.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <sonals@xilinx.com>)
        id 1h6MgL-0001Ke-SI; Tue, 19 Mar 2019 14:54:01 -0700
Received: by xsjsonals5570.xilinx.com (Postfix, from userid 1000)
        id 9771C76001F; Tue, 19 Mar 2019 14:54:01 -0700 (PDT)
From:   <sonal.santan@xilinx.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <airlied@redhat.com>, <cyrilc@xilinx.com>, <michals@xilinx.com>,
        <lizhih@xilinx.com>, <hyunk@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>
Subject: [RFC PATCH Xilinx Alveo 6/6] Add user physical function driver
Date:   Tue, 19 Mar 2019 14:54:01 -0700
Message-ID: <20190319215401.6562-7-sonal.santan@xilinx.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190319215401.6562-1-sonal.santan@xilinx.com>
References: <20190319215401.6562-1-sonal.santan@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(346002)(396003)(136003)(39860400002)(376002)(2980300002)(199004)(189003)(76176011)(36756003)(30864003)(8936002)(36386004)(6266002)(106002)(47776003)(51416003)(63266004)(478600001)(5024004)(14444005)(53946003)(1076003)(6916009)(106466001)(2351001)(2906002)(86152003)(90966002)(52956003)(186003)(336012)(50226002)(81156014)(26005)(5660300002)(305945005)(42186006)(54906003)(2876002)(16586007)(316002)(486006)(2616005)(476003)(126002)(426003)(81166006)(8676002)(48376002)(446003)(4326008)(50466002)(103686004)(11346002)(107886003)(356004)(2004002)(959014)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB5539;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42b1b7d5-4a85-4e09-4157-08d6acb56db2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BL0PR02MB5539;
X-MS-TrafficTypeDiagnostic: BL0PR02MB5539:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB55399A5D40DACFDC912127C8BB400@BL0PR02MB5539.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 0RpXaNy5jeN7frxgL/UulCTtNn9LlCuHqtQytPabsr10lYtYFEyqel9Bzp2TaRuSglVNEm1cu6x4dtgwVsbSEy2OYUdqO6dlTCdvxIsdmPLLiMEzFEntYy6lZwjSLnWn1+ao2RoAokZkgbSGzQ1zO/z0hOFXUHQDJn+rqyKPCDns2IFPs4lWB/VAprhNQ7BIOtZzdhOfLwIIMYHEIM1m7D4LyeOv0OUoZdtzzxZuC5XzDA0sKTIrg0I+joYBf3Cm/sWybhfHaGaD9Q/aM8BDAuFuANcqRxHiGbOwF9264q3qcQaqv7kHt0KvArL3KwwUo9Cs1TyB8TG62FrRiGV3ERLGToaIsNzQ9+hENLR0kYj39uYeCOCLeQXRwYcCM2d1Rc7UcSkhFMyLhmATkv+0GZisusxLJLJomezOaBP3aYU=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 21:54:14.5177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b1b7d5-4a85-4e09-4157-08d6acb56db2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5539
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/gpu/drm/xocl/userpf/common.h     |  157 +++
 drivers/gpu/drm/xocl/userpf/xocl_bo.c    | 1255 ++++++++++++++++++++++
 drivers/gpu/drm/xocl/userpf/xocl_bo.h    |  119 ++
 drivers/gpu/drm/xocl/userpf/xocl_drm.c   |  640 +++++++++++
 drivers/gpu/drm/xocl/userpf/xocl_drv.c   |  743 +++++++++++++
 drivers/gpu/drm/xocl/userpf/xocl_ioctl.c |  396 +++++++
 drivers/gpu/drm/xocl/userpf/xocl_sysfs.c |  344 ++++++
 7 files changed, 3654 insertions(+)
 create mode 100644 drivers/gpu/drm/xocl/userpf/common.h
 create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_bo.c
 create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_bo.h
 create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_drm.c
 create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_drv.c
 create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_ioctl.c
 create mode 100644 drivers/gpu/drm/xocl/userpf/xocl_sysfs.c

diff --git a/drivers/gpu/drm/xocl/userpf/common.h b/drivers/gpu/drm/xocl/userpf/common.h
new file mode 100644
index 000000000000..c7dd4a68441c
--- /dev/null
+++ b/drivers/gpu/drm/xocl/userpf/common.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2016-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors:
+ * Lizhi Hou <lizhi.hou@xilinx.com>
+ *
+ */
+
+#ifndef _USERPF_COMMON_H
+#define	_USERPF_COMMON_H
+
+#include "../xocl_drv.h"
+#include "xocl_bo.h"
+#include "../xocl_drm.h"
+#include <drm/xocl_drm.h>
+#include <linux/hashtable.h>
+
+#define XOCL_DRIVER_DESC        "Xilinx PCIe Accelerator Device Manager"
+#define XOCL_DRIVER_DATE        "20180612"
+#define XOCL_DRIVER_MAJOR       2018
+#define XOCL_DRIVER_MINOR       2
+#define XOCL_DRIVER_PATCHLEVEL  8
+
+#define XOCL_MAX_CONCURRENT_CLIENTS 32
+
+#define XOCL_DRIVER_VERSION                             \
+	__stringify(XOCL_DRIVER_MAJOR) "."              \
+	__stringify(XOCL_DRIVER_MINOR) "."              \
+	__stringify(XOCL_DRIVER_PATCHLEVEL)
+
+#define XOCL_DRIVER_VERSION_NUMBER                              \
+	((XOCL_DRIVER_MAJOR)*1000 + (XOCL_DRIVER_MINOR)*100 +   \
+	XOCL_DRIVER_PATCHLEVEL)
+
+#define userpf_err(d, args...)                     \
+	xocl_err(&XDEV(d)->pdev->dev, ##args)
+#define userpf_info(d, args...)                    \
+	xocl_info(&XDEV(d)->pdev->dev, ##args)
+#define userpf_dbg(d, args...)                     \
+	xocl_dbg(&XDEV(d)->pdev->dev, ##args)
+
+#define xocl_get_root_dev(dev, root)		\
+	for (root = dev; root->bus && root->bus->self; root = root->bus->self)
+
+#define	XOCL_USER_PROC_HASH_SZ		256
+
+#define XOCL_U32_MASK 0xFFFFFFFF
+
+#define	MAX_SLOTS	128
+#define MAX_CUS		128
+#define MAX_U32_SLOT_MASKS (((MAX_SLOTS-1)>>5) + 1)
+#define MAX_U32_CU_MASKS (((MAX_CUS-1)>>5) + 1)
+#define MAX_DEPS        8
+
+#define XOCL_DRM_FREE_MALLOC
+
+#define XOCL_PA_SECTION_SHIFT		28
+
+struct xocl_dev	{
+	struct xocl_dev_core	core;
+
+	bool			offline;
+
+	/* health thread */
+	struct task_struct	       *health_thread;
+	struct xocl_health_thread_arg	thread_arg;
+
+	u32			p2p_bar_idx;
+	resource_size_t		p2p_bar_len;
+	void			* __iomem p2p_bar_addr;
+
+	/*should be removed after mailbox is supported */
+	struct percpu_ref ref;
+	struct completion cmp;
+
+	struct dev_pagemap pgmap;
+	struct list_head                ctx_list;
+	struct mutex			ctx_list_lock;
+	unsigned int                    needs_reset; /* bool aligned */
+	atomic_t                        outstanding_execs;
+	atomic64_t                      total_execs;
+	void				*p2p_res_grp;
+};
+
+/**
+ * struct client_ctx: Manage user space client attached to device
+ *
+ * @link: Client context is added to list in device
+ * @xclbin_id: UUID for xclbin loaded by client, or nullid if no xclbin loaded
+ * @xclbin_locked: Flag to denote that this context locked the xclbin
+ * @trigger: Poll wait counter for number of completed exec buffers
+ * @outstanding_execs: Counter for number outstanding exec buffers
+ * @abort: Flag to indicate that this context has detached from user space (ctrl-c)
+ * @num_cus: Number of resources (CUs) explcitly aquired
+ * @lock: Mutex lock for exclusive access
+ * @cu_bitmap: CUs reserved by this context, may contain implicit resources
+ */
+struct client_ctx {
+	struct list_head	link;
+	uuid_t                  xclbin_id;
+	unsigned int            xclbin_locked;
+	unsigned int            abort;
+	unsigned int		num_cus; /* number of resource locked explicitly by client */
+	atomic_t		trigger;     /* count of poll notification to acknowledge */
+	atomic_t                outstanding_execs;
+	struct mutex		lock;
+	struct xocl_dev        *xdev;
+	DECLARE_BITMAP(cu_bitmap, MAX_CUS);  /* may contain implicitly aquired resources such as CDMA */
+	struct pid             *pid;
+};
+
+struct xocl_mm_wrapper {
+	struct drm_mm *mm;
+	struct drm_xocl_mm_stat *mm_usage_stat;
+	uint64_t start_addr;
+	uint64_t size;
+	uint32_t ddr;
+	struct hlist_node node;
+};
+
+/* ioctl functions */
+int xocl_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+int xocl_execbuf_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_ctx_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
+int xocl_user_intr_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_read_axlf_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_hot_reset_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_reclock_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+
+/* sysfs functions */
+int xocl_init_sysfs(struct device *dev);
+void xocl_fini_sysfs(struct device *dev);
+
+/* helper functions */
+int64_t xocl_hot_reset(struct xocl_dev *xdev, bool force);
+void xocl_p2p_mem_release(struct xocl_dev *xdev, bool recov_bar_sz);
+int xocl_p2p_mem_reserve(struct xocl_dev *xdev);
+int xocl_get_p2p_bar(struct xocl_dev *xdev, u64 *bar_size);
+int xocl_pci_resize_resource(struct pci_dev *dev, int resno, int size);
+void xocl_reset_notify(struct pci_dev *pdev, bool prepare);
+void user_pci_reset_prepare(struct pci_dev *pdev);
+void user_pci_reset_done(struct pci_dev *pdev);
+
+uint get_live_client_size(struct xocl_dev *xdev);
+void reset_notify_client_ctx(struct xocl_dev *xdev);
+
+void get_pcie_link_info(struct xocl_dev	*xdev,
+	unsigned short *link_width, unsigned short *link_speed, bool is_cap);
+int xocl_reclock(struct xocl_dev *xdev, void *data);
+#endif
diff --git a/drivers/gpu/drm/xocl/userpf/xocl_bo.c b/drivers/gpu/drm/xocl/userpf/xocl_bo.c
new file mode 100644
index 000000000000..546ce5f7e428
--- /dev/null
+++ b/drivers/gpu/drm/xocl/userpf/xocl_bo.c
@@ -0,0 +1,1255 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2016-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors:
+ *    Sonal Santan <sonal.santan@xilinx.com>
+ *    Sarabjeet Singh <sarabjeet.singh@xilinx.com>
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/swap.h>
+#include <linux/dma-buf.h>
+#include <linux/pagemap.h>
+#include <linux/version.h>
+#include <drm/drmP.h>
+#include "common.h"
+
+#ifdef _XOCL_BO_DEBUG
+#define	BO_ENTER(fmt, args...)		\
+	pr_info("[BO] Entering %s:"fmt"\n", __func__, ##args)
+#define	BO_DEBUG(fmt, args...)		\
+	pr_info("[BO] %s:%d:"fmt"\n", __func__, __LINE__, ##args)
+#else
+#define BO_ENTER(fmt, args...)
+#define	BO_DEBUG(fmt, args...)
+#endif
+
+#if defined(XOCL_DRM_FREE_MALLOC)
+static inline void drm_free_large(void *ptr)
+{
+	kvfree(ptr);
+}
+
+static inline void *drm_malloc_ab(size_t nmemb, size_t size)
+{
+	return kvmalloc_array(nmemb, sizeof(struct page *), GFP_KERNEL);
+}
+#endif
+
+static inline void xocl_release_pages(struct page **pages, int nr, bool cold)
+{
+	release_pages(pages, nr);
+}
+
+
+static inline void __user *to_user_ptr(u64 address)
+{
+	return (void __user *)(uintptr_t)address;
+}
+
+static size_t xocl_bo_physical_addr(const struct drm_xocl_bo *xobj)
+{
+	uint64_t paddr = xobj->mm_node ? xobj->mm_node->start : 0xffffffffffffffffull;
+
+	//Sarab: Need to check for number of hops & size of DDRs
+	if (xobj->type & XOCL_BO_ARE)
+		paddr |= XOCL_ARE_HOP;
+	return paddr;
+}
+
+void xocl_describe(const struct drm_xocl_bo *xobj)
+{
+	size_t size_in_kb = xobj->base.size / 1024;
+	size_t physical_addr = xocl_bo_physical_addr(xobj);
+	unsigned int ddr = xocl_bo_ddr_idx(xobj->flags);
+	unsigned int userptr = xocl_bo_userptr(xobj) ? 1 : 0;
+
+	DRM_DEBUG("%p: H[%p] SIZE[0x%zxKB] D[0x%zx] DDR[%u] UPTR[%u] SGLCOUNT[%u]\n",
+		  xobj, xobj->vmapping ? xobj->vmapping : xobj->bar_vmapping, size_in_kb,
+			physical_addr, ddr, userptr, xobj->sgt->orig_nents);
+}
+
+static void xocl_free_mm_node(struct drm_xocl_bo *xobj)
+{
+	struct drm_device *ddev = xobj->base.dev;
+	struct xocl_drm *drm_p = ddev->dev_private;
+	unsigned int ddr = xocl_bo_ddr_idx(xobj->flags);
+
+	mutex_lock(&drm_p->mm_lock);
+	BO_ENTER("xobj %p, mm_node %p", xobj, xobj->mm_node);
+	if (!xobj->mm_node)
+		goto end;
+
+	xocl_mm_update_usage_stat(drm_p, ddr, xobj->base.size, -1);
+	BO_DEBUG("remove mm_node:%p, start:%llx size: %llx", xobj->mm_node,
+		xobj->mm_node->start, xobj->mm_node->size);
+	drm_mm_remove_node(xobj->mm_node);
+	kfree(xobj->mm_node);
+	xobj->mm_node = NULL;
+end:
+	mutex_unlock(&drm_p->mm_lock);
+}
+
+static void xocl_free_bo(struct drm_gem_object *obj)
+{
+	struct drm_xocl_bo *xobj = to_xocl_bo(obj);
+	struct drm_device *ddev = xobj->base.dev;
+	struct xocl_drm *drm_p = ddev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+	int npages = obj->size >> PAGE_SHIFT;
+
+	DRM_DEBUG("Freeing BO %p\n", xobj);
+
+	BO_ENTER("xobj %p pages %p", xobj, xobj->pages);
+	if (xobj->vmapping)
+		vunmap(xobj->vmapping);
+	xobj->vmapping = NULL;
+
+	if (xobj->dmabuf)
+		unmap_mapping_range(xobj->dmabuf->file->f_mapping, 0, 0, 1);
+
+	if (xobj->dma_nsg) {
+		pci_unmap_sg(xdev->core.pdev, xobj->sgt->sgl, xobj->dma_nsg,
+			PCI_DMA_BIDIRECTIONAL);
+	}
+
+	if (xobj->pages) {
+		if (xocl_bo_userptr(xobj)) {
+			xocl_release_pages(xobj->pages, npages, 0);
+			drm_free_large(xobj->pages);
+		} else if (xocl_bo_p2p(xobj)) {
+			drm_free_large(xobj->pages);
+			/*devm_* will release all the pages while unload xocl driver*/
+			xobj->bar_vmapping = NULL;
+		} else if (!xocl_bo_import(xobj)) {
+			drm_gem_put_pages(obj, xobj->pages, false, false);
+		}
+	}
+	xobj->pages = NULL;
+
+	if (!xocl_bo_import(xobj)) {
+		DRM_DEBUG("Freeing regular buffer\n");
+		if (xobj->sgt) {
+			sg_free_table(xobj->sgt);
+			kfree(xobj->sgt);
+		}
+		xobj->sgt = NULL;
+		xocl_free_mm_node(xobj);
+	} else {
+		DRM_DEBUG("Freeing imported buffer\n");
+		if (!(xobj->type & XOCL_BO_ARE))
+			xocl_free_mm_node(xobj);
+
+		if (obj->import_attach) {
+			DRM_DEBUG("Unnmapping attached dma buf\n");
+			dma_buf_unmap_attachment(obj->import_attach, xobj->sgt, DMA_TO_DEVICE);
+			drm_prime_gem_destroy(obj, NULL);
+		}
+	}
+
+	/* If it is imported BO then we do not delete SG Table
+	 * And if is imported from ARE device then we do not free the mm_node
+	 * as well
+	 * Call detach here........
+	 * to let the exporting device know that importing device do not need
+	 * it anymore..
+	 * else free_bo i.e this function is not called for exporting device
+	 * as it assumes that the exported buffer is still being used
+	 * dmabuf->ops->release(dmabuf);
+	 * The drm_driver.gem_free_object callback is responsible for cleaning
+	 * up the dma_buf attachment and references acquired at import time.
+	 *
+	 * This crashes machine.. Using above code instead
+	 * drm_prime_gem_destroy calls detach function..
+	 * struct dma_buf *imported_dma_buf = obj->dma_buf;
+	 * if (imported_dma_buf->ops->detach)
+	 * imported_dma_buf->ops->detach(imported_dma_buf, obj->import_attach);
+	 */
+
+	drm_gem_object_release(obj);
+	kfree(xobj);
+}
+
+void xocl_drm_free_bo(struct drm_gem_object *obj)
+{
+	xocl_free_bo(obj);
+}
+
+static inline int check_bo_user_reqs(const struct drm_device *dev,
+	unsigned int flags, unsigned int type)
+{
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+	u16 ddr_count;
+	unsigned int ddr;
+
+	if (type == DRM_XOCL_BO_EXECBUF)
+		return 0;
+	if (type == DRM_XOCL_BO_CMA)
+		return -EINVAL;
+
+	//From "mem_topology" or "feature rom" depending on
+	//unified or non-unified dsa
+	ddr_count = XOCL_DDR_COUNT(xdev);
+
+	if (ddr_count == 0)
+		return -EINVAL;
+	ddr = xocl_bo_ddr_idx(flags);
+	if (ddr >= ddr_count)
+		return -EINVAL;
+	if (XOCL_MEM_TOPOLOGY(xdev)->m_mem_data[ddr].m_type == MEM_STREAMING)
+		return -EINVAL;
+	if (!XOCL_IS_DDR_USED(xdev, ddr)) {
+		userpf_err(xdev, "Bank %d is marked as unused in axlf", ddr);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static struct drm_xocl_bo *xocl_create_bo(struct drm_device *dev,
+					  uint64_t unaligned_size,
+					  unsigned int user_flags,
+					  unsigned int user_type)
+{
+	size_t size = PAGE_ALIGN(unaligned_size);
+	struct drm_xocl_bo *xobj;
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+	unsigned int ddr = xocl_bo_ddr_idx(user_flags);
+	u16 ddr_count = 0;
+	bool xobj_inited = false;
+	int err = 0;
+
+	BO_DEBUG("New create bo flags:%u type:%u", user_flags, user_type);
+	if (!size)
+		return ERR_PTR(-EINVAL);
+
+	/* Either none or only one DDR should be specified */
+	/* Check the type */
+	if (check_bo_user_reqs(dev, user_flags, user_type))
+		return ERR_PTR(-EINVAL);
+
+	xobj = kzalloc(sizeof(*xobj), GFP_KERNEL);
+	if (!xobj)
+		return ERR_PTR(-ENOMEM);
+
+	BO_ENTER("xobj %p", xobj);
+	err = drm_gem_object_init(dev, &xobj->base, size);
+	if (err)
+		goto failed;
+	xobj_inited = true;
+
+	if (user_type == DRM_XOCL_BO_EXECBUF) {
+		xobj->type = XOCL_BO_EXECBUF;
+		xobj->metadata.state = DRM_XOCL_EXECBUF_STATE_ABORT;
+		return xobj;
+	}
+
+	if (user_type & DRM_XOCL_BO_P2P)
+		xobj->type = XOCL_BO_P2P;
+
+	xobj->mm_node = kzalloc(sizeof(*xobj->mm_node), GFP_KERNEL);
+	if (!xobj->mm_node) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	ddr_count = XOCL_DDR_COUNT(xdev);
+
+	mutex_lock(&drm_p->mm_lock);
+	/* Attempt to allocate buffer on the requested DDR */
+	xocl_xdev_dbg(xdev, "alloc bo from bank%u", ddr);
+	err = xocl_mm_insert_node(drm_p, ddr, xobj->mm_node,
+		xobj->base.size);
+	BO_DEBUG("insert mm_node:%p, start:%llx size: %llx",
+		xobj->mm_node, xobj->mm_node->start,
+		xobj->mm_node->size);
+	if (err)
+		goto failed;
+
+	xocl_mm_update_usage_stat(drm_p, ddr, xobj->base.size, 1);
+	mutex_unlock(&drm_p->mm_lock);
+	/* Record the DDR we allocated the buffer on */
+	//xobj->flags |= (1 << ddr);
+	xobj->flags = ddr;
+
+	return xobj;
+failed:
+	mutex_unlock(&drm_p->mm_lock);
+	kfree(xobj->mm_node);
+
+	if (xobj_inited)
+		drm_gem_object_release(&xobj->base);
+
+	kfree(xobj);
+
+	return ERR_PTR(err);
+}
+
+struct drm_xocl_bo *xocl_drm_create_bo(struct xocl_drm *drm_p,
+					  uint64_t unaligned_size,
+					  unsigned int user_flags,
+					  unsigned int user_type)
+{
+	return xocl_create_bo(drm_p->ddev, unaligned_size, user_flags,
+			user_type);
+}
+
+static struct page **xocl_p2p_get_pages(void *bar_vaddr, int npages)
+{
+	struct page *p, **pages;
+	int i;
+	uint64_t page_offset_enum = 0;
+
+	pages = drm_malloc_ab(npages, sizeof(struct page *));
+
+	if (pages == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < npages; i++) {
+		p = virt_to_page(bar_vaddr+page_offset_enum);
+		pages[i] = p;
+
+		if (IS_ERR(p))
+			goto fail;
+
+		page_offset_enum += PAGE_SIZE;
+	}
+
+	return pages;
+fail:
+	kvfree(pages);
+	return ERR_CAST(p);
+}
+
+/*
+ * For ARE device do not reserve DDR space
+ * In below import it will reuse the mm_node which is already created by other application
+ */
+
+static struct drm_xocl_bo *xocl_create_bo_forARE(struct drm_device *dev,
+						 uint64_t unaligned_size,
+						 struct drm_mm_node   *exporting_mm_node)
+{
+	struct drm_xocl_bo *xobj;
+	size_t size = PAGE_ALIGN(unaligned_size);
+	int err = 0;
+
+	if (!size)
+		return ERR_PTR(-EINVAL);
+
+	xobj = kzalloc(sizeof(*xobj), GFP_KERNEL);
+	if (!xobj)
+		return ERR_PTR(-ENOMEM);
+
+	BO_ENTER("xobj %p", xobj);
+	err = drm_gem_object_init(dev, &xobj->base, size);
+	if (err)
+		goto out3;
+
+	xobj->mm_node = exporting_mm_node;
+	if (!xobj->mm_node) {
+		err = -ENOMEM;
+		goto out3;
+	}
+
+	/* Record that this buffer is on remote device to be access over ARE*/
+	//xobj->flags = XOCL_BO_ARE;
+	xobj->type |= XOCL_BO_ARE;
+	return xobj;
+out3:
+	kfree(xobj);
+	return ERR_PTR(err);
+}
+
+
+int xocl_create_bo_ioctl(struct drm_device *dev,
+			 void *data,
+			 struct drm_file *filp)
+{
+	int ret;
+	struct drm_xocl_bo *xobj;
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+	struct drm_xocl_create_bo *args = data;
+	//unsigned ddr = args->flags & XOCL_MEM_BANK_MSK;
+	unsigned int ddr = args->flags;
+	//unsigned bar_mapped = (args->flags & DRM_XOCL_BO_P2P) ? 1 : 0;
+	unsigned int bar_mapped = (args->type & DRM_XOCL_BO_P2P) ? 1 : 0;
+
+//	//Only one bit should be set in ddr. Other bits are now in "type"
+//	if (hweight_long(ddr) > 1)
+//		return -EINVAL;
+////	if (args->flags && (args->flags != DRM_XOCL_BO_EXECBUF)) {
+//		if (hweight_long(ddr) > 1)
+//			return -EINVAL;
+//	}
+
+	if (bar_mapped) {
+		if (!xdev->p2p_bar_addr) {
+			xocl_xdev_err(xdev, "No P2P mem region available, Can't create p2p BO");
+			return -EINVAL;
+		}
+	}
+
+	xobj = xocl_create_bo(dev, args->size, args->flags, args->type);
+
+	BO_ENTER("xobj %p, mm_node %p", xobj, xobj->mm_node);
+	if (IS_ERR(xobj)) {
+		DRM_DEBUG("object creation failed\n");
+		return PTR_ERR(xobj);
+	}
+
+	if (bar_mapped) {
+		ddr = xocl_bo_ddr_idx(xobj->flags);
+		/*
+		 * DRM allocate contiguous pages, shift the vmapping with
+		 * bar address offset
+		 */
+		xobj->bar_vmapping = xdev->p2p_bar_addr +
+			drm_p->mm_p2p_off[ddr] + xobj->mm_node->start -
+			XOCL_MEM_TOPOLOGY(xdev)->m_mem_data[ddr].m_base_address;
+	}
+
+	if (bar_mapped)
+		xobj->pages = xocl_p2p_get_pages(xobj->bar_vmapping, xobj->base.size >> PAGE_SHIFT);
+	else
+		xobj->pages = drm_gem_get_pages(&xobj->base);
+
+	if (IS_ERR(xobj->pages)) {
+		ret = PTR_ERR(xobj->pages);
+		goto out_free;
+	}
+
+	xobj->sgt = drm_prime_pages_to_sg(xobj->pages, xobj->base.size >> PAGE_SHIFT);
+	if (IS_ERR(xobj->sgt)) {
+		ret = PTR_ERR(xobj->sgt);
+		goto out_free;
+	}
+
+	if (!bar_mapped) {
+		xobj->vmapping = vmap(xobj->pages, xobj->base.size >> PAGE_SHIFT, VM_MAP, PAGE_KERNEL);
+		if (!xobj->vmapping) {
+			ret = -ENOMEM;
+			goto out_free;
+		}
+	}
+
+	ret = drm_gem_create_mmap_offset(&xobj->base);
+	if (ret < 0)
+		goto out_free;
+	ret = drm_gem_handle_create(filp, &xobj->base, &args->handle);
+	if (ret < 0)
+		goto out_free;
+
+	xocl_describe(xobj);
+//PORT4_20
+//	drm_gem_object_unreference_unlocked(&xobj->base);
+	drm_gem_object_put_unlocked(&xobj->base);
+	return ret;
+
+out_free:
+	xocl_free_bo(&xobj->base);
+	return ret;
+}
+
+int xocl_userptr_bo_ioctl(struct drm_device *dev,
+			      void *data,
+			      struct drm_file *filp)
+{
+	int ret;
+	struct drm_xocl_bo *xobj;
+	unsigned int page_count;
+	struct drm_xocl_userptr_bo *args = data;
+	//unsigned ddr = args->flags & XOCL_MEM_BANK_MSK;
+	//unsigned ddr = args->flags;
+
+	if (offset_in_page(args->addr))
+		return -EINVAL;
+
+	if (args->type & DRM_XOCL_BO_EXECBUF)
+		return -EINVAL;
+
+	if (args->type & DRM_XOCL_BO_CMA)
+		return -EINVAL;
+
+//	if (args->flags && (hweight_long(ddr) > 1))
+//		return -EINVAL;
+
+	xobj = xocl_create_bo(dev, args->size, args->flags, args->type);
+	BO_ENTER("xobj %p", xobj);
+
+	if (IS_ERR(xobj)) {
+		DRM_DEBUG("object creation failed\n");
+		return PTR_ERR(xobj);
+	}
+
+	/* Use the page rounded size so we can accurately account for number of pages */
+	page_count = xobj->base.size >> PAGE_SHIFT;
+
+	xobj->pages = drm_malloc_ab(page_count, sizeof(*xobj->pages));
+	if (!xobj->pages) {
+		ret = -ENOMEM;
+		goto out1;
+	}
+	ret = get_user_pages_fast(args->addr, page_count, 1, xobj->pages);
+
+	if (ret != page_count)
+		goto out0;
+
+	xobj->sgt = drm_prime_pages_to_sg(xobj->pages, page_count);
+	if (IS_ERR(xobj->sgt)) {
+		ret = PTR_ERR(xobj->sgt);
+		goto out0;
+	}
+
+	/* TODO: resolve the cache issue */
+	xobj->vmapping = vmap(xobj->pages, page_count, VM_MAP, PAGE_KERNEL);
+
+	if (!xobj->vmapping) {
+		ret = -ENOMEM;
+		goto out1;
+	}
+
+	ret = drm_gem_handle_create(filp, &xobj->base, &args->handle);
+	if (ret)
+		goto out1;
+
+	xobj->type |= XOCL_BO_USERPTR;
+	xocl_describe(xobj);
+//PORT4_20
+//	drm_gem_object_unreference_unlocked(&xobj->base);
+	drm_gem_object_put_unlocked(&xobj->base);
+	return ret;
+
+out0:
+	drm_free_large(xobj->pages);
+	xobj->pages = NULL;
+out1:
+	xocl_free_bo(&xobj->base);
+	DRM_DEBUG("handle creation failed\n");
+	return ret;
+}
+
+
+int xocl_map_bo_ioctl(struct drm_device *dev,
+		      void *data,
+		      struct drm_file *filp)
+{
+	int ret = 0;
+	struct drm_xocl_map_bo *args = data;
+	struct drm_gem_object *obj;
+	struct drm_xocl_bo *xobj;
+
+	obj = xocl_gem_object_lookup(dev, filp, args->handle);
+	xobj = to_xocl_bo(obj);
+
+	if (!obj) {
+		DRM_ERROR("Failed to look up GEM BO %d\n", args->handle);
+		return -ENOENT;
+	}
+
+	BO_ENTER("xobj %p", xobj);
+	if (xocl_bo_userptr(xobj)) {
+		ret = -EPERM;
+		goto out;
+	}
+	/* The mmap offset was set up at BO allocation time. */
+	args->offset = drm_vma_node_offset_addr(&obj->vma_node);
+	xocl_describe(to_xocl_bo(obj));
+out:
+//PORT4_20
+//	drm_gem_object_unreference_unlocked(obj);
+	drm_gem_object_put_unlocked(obj);
+	return ret;
+}
+
+static struct sg_table *alloc_onetime_sg_table(struct page **pages, uint64_t offset, uint64_t size)
+{
+	int ret;
+	unsigned int nr_pages;
+	struct sg_table *sgt = kmalloc(sizeof(struct sg_table), GFP_KERNEL);
+
+	if (!sgt)
+		return ERR_PTR(-ENOMEM);
+
+	pages += (offset >> PAGE_SHIFT);
+	offset &= (~PAGE_MASK);
+	nr_pages = PAGE_ALIGN(size + offset) >> PAGE_SHIFT;
+
+	ret = sg_alloc_table_from_pages(sgt, pages, nr_pages, offset, size, GFP_KERNEL);
+	if (ret)
+		goto cleanup;
+	return sgt;
+
+cleanup:
+	kfree(sgt);
+	return ERR_PTR(-ENOMEM);
+}
+
+int xocl_sync_bo_ioctl(struct drm_device *dev,
+		       void *data,
+		       struct drm_file *filp)
+{
+	const struct drm_xocl_bo *xobj;
+	struct sg_table *sgt;
+	u64 paddr = 0;
+	int channel = 0;
+	ssize_t ret = 0;
+	const struct drm_xocl_sync_bo *args = data;
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+
+	u32 dir = (args->dir == DRM_XOCL_SYNC_BO_TO_DEVICE) ? 1 : 0;
+	struct drm_gem_object *gem_obj = xocl_gem_object_lookup(dev, filp,
+							       args->handle);
+	if (!gem_obj) {
+		DRM_ERROR("Failed to look up GEM BO %d\n", args->handle);
+		return -ENOENT;
+	}
+
+	xobj = to_xocl_bo(gem_obj);
+	BO_ENTER("xobj %p", xobj);
+	sgt = xobj->sgt;
+
+	if (xocl_bo_p2p(xobj)) {
+		DRM_DEBUG("P2P_BO doesn't support sync_bo\n");
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	//Sarab: If it is a remote BO then why do sync over ARE.
+	//We should do sync directly using the other device which this bo locally.
+	//So that txfer is: HOST->PCIE->DDR; Else it will be HOST->PCIE->ARE->DDR
+	paddr = xocl_bo_physical_addr(xobj);
+
+	if (paddr == 0xffffffffffffffffull)
+		return -EINVAL;
+
+	/* If device is offline (due to error), reject all DMA requests */
+	if (xdev->offline)
+		return -ENODEV;
+
+
+	if ((args->offset + args->size) > gem_obj->size) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* only invalidate the range of addresses requested by the user */
+	paddr += args->offset;
+
+	if (args->offset || (args->size != xobj->base.size)) {
+		sgt = alloc_onetime_sg_table(xobj->pages, args->offset, args->size);
+		if (IS_ERR(sgt)) {
+			ret = PTR_ERR(sgt);
+			goto out;
+		}
+	}
+
+	//drm_clflush_sg(sgt);
+	channel = xocl_acquire_channel(xdev, dir);
+
+	if (channel < 0) {
+		ret = -EINVAL;
+		goto clear;
+	}
+	/* Now perform DMA */
+	ret = xocl_migrate_bo(xdev, sgt, dir, paddr, channel, args->size);
+	if (ret >= 0)
+		ret = (ret == args->size) ? 0 : -EIO;
+	xocl_release_channel(xdev, dir, channel);
+clear:
+	if (args->offset || (args->size != xobj->base.size)) {
+		sg_free_table(sgt);
+		kfree(sgt);
+	}
+out:
+//PORT4_20
+	drm_gem_object_put_unlocked(gem_obj);
+	return ret;
+}
+
+int xocl_info_bo_ioctl(struct drm_device *dev,
+		       void *data,
+		       struct drm_file *filp)
+{
+	const struct drm_xocl_bo *xobj;
+	struct drm_xocl_info_bo *args = data;
+	struct drm_gem_object *gem_obj = xocl_gem_object_lookup(dev, filp,
+								args->handle);
+
+	if (!gem_obj) {
+		DRM_ERROR("Failed to look up GEM BO %d\n", args->handle);
+		return -ENOENT;
+	}
+
+	xobj = to_xocl_bo(gem_obj);
+	BO_ENTER("xobj %p", xobj);
+
+	args->size = xobj->base.size;
+
+	args->paddr = xocl_bo_physical_addr(xobj);
+	xocl_describe(xobj);
+//PORT4_20
+	drm_gem_object_put_unlocked(gem_obj);
+
+	return 0;
+}
+
+int xocl_pwrite_bo_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *filp)
+{
+	struct drm_xocl_bo *xobj;
+	const struct drm_xocl_pwrite_bo *args = data;
+	struct drm_gem_object *gem_obj = xocl_gem_object_lookup(dev, filp,
+							       args->handle);
+	char __user *user_data = to_user_ptr(args->data_ptr);
+	int ret = 0;
+	void *kaddr;
+
+	if (!gem_obj) {
+		DRM_ERROR("Failed to look up GEM BO %d\n", args->handle);
+		return -ENOENT;
+	}
+
+	if ((args->offset > gem_obj->size) || (args->size > gem_obj->size)
+	    || ((args->offset + args->size) > gem_obj->size)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (args->size == 0) {
+		ret = 0;
+		goto out;
+	}
+
+	if (!access_ok(user_data, args->size)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	xobj = to_xocl_bo(gem_obj);
+	BO_ENTER("xobj %p", xobj);
+
+	if (xocl_bo_userptr(xobj)) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	kaddr = xobj->vmapping ? xobj->vmapping : xobj->bar_vmapping;
+	kaddr += args->offset;
+
+	ret = copy_from_user(kaddr, user_data, args->size);
+out:
+//PORT4_20
+	drm_gem_object_put_unlocked(gem_obj);
+
+	return ret;
+}
+
+int xocl_pread_bo_ioctl(struct drm_device *dev, void *data,
+			struct drm_file *filp)
+{
+	struct drm_xocl_bo *xobj;
+	const struct drm_xocl_pread_bo *args = data;
+	struct drm_gem_object *gem_obj = xocl_gem_object_lookup(dev, filp,
+							       args->handle);
+	char __user *user_data = to_user_ptr(args->data_ptr);
+	int ret = 0;
+	void *kaddr;
+
+	if (!gem_obj) {
+		DRM_ERROR("Failed to look up GEM BO %d\n", args->handle);
+		return -ENOENT;
+	}
+
+	if (xocl_bo_userptr(to_xocl_bo(gem_obj))) {
+		ret = -EPERM;
+		goto out;
+	}
+
+	if ((args->offset > gem_obj->size) || (args->size > gem_obj->size)
+	    || ((args->offset + args->size) > gem_obj->size)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (args->size == 0) {
+		ret = 0;
+		goto out;
+	}
+
+	if (!access_ok(user_data, args->size)) {
+		ret = EFAULT;
+		goto out;
+	}
+
+	xobj = to_xocl_bo(gem_obj);
+	BO_ENTER("xobj %p", xobj);
+	kaddr = xobj->vmapping ? xobj->vmapping : xobj->bar_vmapping;
+	kaddr += args->offset;
+
+	ret = copy_to_user(user_data, kaddr, args->size);
+
+out:
+//PORT4_20
+	drm_gem_object_put_unlocked(gem_obj);
+
+	return ret;
+}
+
+int xocl_copy_bo_ioctl(struct drm_device *dev,
+			 void *data,
+			 struct drm_file *filp)
+{
+	const struct drm_xocl_bo *dst_xobj, *src_xobj;
+	struct sg_table *sgt;
+	u64 paddr = 0;
+	int channel = 0;
+	ssize_t ret = 0;
+	const struct drm_xocl_copy_bo *args = data;
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+	u32 dir = 0; //always write data from source to destination
+	struct drm_gem_object *dst_gem_obj, *src_gem_obj;
+
+	dst_gem_obj = xocl_gem_object_lookup(dev, filp,
+							       args->dst_handle);
+	if (!dst_gem_obj) {
+		DRM_ERROR("Failed to look up Destination GEM BO %d\n", args->dst_handle);
+		return -ENOENT;
+	}
+	src_gem_obj = xocl_gem_object_lookup(dev, filp,
+							       args->src_handle);
+	if (!src_gem_obj) {
+		DRM_ERROR("Failed to look up Source GEM BO %d\n", args->src_handle);
+		ret = -ENOENT;
+		goto src_lookup_fail;
+	}
+
+	dst_xobj = to_xocl_bo(dst_gem_obj);
+	src_xobj = to_xocl_bo(src_gem_obj);
+
+	if (!xocl_bo_p2p(src_xobj)) {
+		DRM_ERROR("src_bo must be p2p bo, copy_bo aborted");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	DRM_DEBUG("dst_xobj %p, src_xobj %p", dst_xobj, src_xobj);
+	DRM_DEBUG("dst_xobj->sgt %p, src_xobj->sgt %p", dst_xobj->sgt, src_xobj->sgt);
+	sgt = dst_xobj->sgt;
+
+	paddr = xocl_bo_physical_addr(src_xobj);
+
+	if (paddr == 0xffffffffffffffffull) {
+		ret =  -EINVAL;
+		goto out;
+	}
+	/* If device is offline (due to error), reject all DMA requests */
+	if (xdev->offline) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (((args->src_offset + args->size) > src_gem_obj->size) ||
+			((args->dst_offset + args->size) > dst_gem_obj->size)) {
+		DRM_ERROR("offsize + sizes out of boundary, copy_bo abort");
+		ret = -EINVAL;
+		goto out;
+	}
+	paddr += args->src_offset;
+
+	DRM_DEBUG("%s, xobj->pages = %p\n", __func__, dst_xobj->pages);
+
+
+	if (args->dst_offset || (args->size != dst_xobj->base.size)) {
+		sgt = alloc_onetime_sg_table(dst_xobj->pages, args->dst_offset, args->size);
+		if (IS_ERR(sgt)) {
+			ret = PTR_ERR(sgt);
+			goto out;
+		}
+	}
+
+	channel = xocl_acquire_channel(xdev, dir);
+
+	if (channel < 0) {
+		ret = -EINVAL;
+		goto clear;
+	}
+	/* Now perform DMA */
+	ret = xocl_migrate_bo(xdev, sgt, dir, paddr, channel,
+		args->size);
+
+	if (ret >= 0)
+		ret = (ret == args->size) ? 0 : -EIO;
+	xocl_release_channel(xdev, dir, channel);
+
+
+clear:
+	if (args->dst_offset || (args->size != dst_xobj->base.size)) {
+		sg_free_table(sgt);
+		kfree(sgt);
+	}
+out:
+//PORT4_20
+	drm_gem_object_put_unlocked(src_gem_obj);
+src_lookup_fail:
+//PORT4_20
+	drm_gem_object_put_unlocked(dst_gem_obj);
+	return ret;
+
+}
+
+
+struct sg_table *xocl_gem_prime_get_sg_table(struct drm_gem_object *obj)
+{
+	struct drm_xocl_bo *xobj = to_xocl_bo(obj);
+
+	BO_ENTER("xobj %p", xobj);
+	return drm_prime_pages_to_sg(xobj->pages, xobj->base.size >> PAGE_SHIFT);
+}
+
+
+static struct drm_xocl_bo *xocl_is_exporting_xare(struct drm_device *dev, struct dma_buf_attachment *attach)
+{
+	struct drm_gem_object *exporting_gem_obj;
+	struct drm_device *exporting_drm_dev;
+	struct xocl_drm *exporting_drmp;
+	struct xocl_dev *exporting_xdev;
+
+	struct device_driver *importing_dma_driver = dev->dev->driver;
+	struct dma_buf *exporting_dma_buf = attach->dmabuf;
+	struct device_driver *exporting_dma_driver = attach->dev->driver;
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+
+	if (xocl_is_are(xdev))
+		return NULL;
+
+	//We don't know yet if the exporting device is Xilinx/XOCL or third party or USB device
+	//So checking it in below code
+	if (importing_dma_driver != exporting_dma_driver)
+		return NULL;
+
+	//Exporting devices have same driver as us. So this is Xilinx device
+	//So now we can get gem_object, drm_device & xocl_dev
+	exporting_gem_obj = exporting_dma_buf->priv;
+	exporting_drm_dev = exporting_gem_obj->dev;
+	exporting_drmp = exporting_drm_dev->dev_private;
+	exporting_xdev = exporting_drmp->xdev;
+	//exporting_xdev->header;//This has FeatureROM header
+	if (xocl_is_are(exporting_xdev))
+		return to_xocl_bo(exporting_gem_obj);
+
+	return NULL;
+}
+
+struct drm_gem_object *xocl_gem_prime_import_sg_table(struct drm_device *dev,
+						      struct dma_buf_attachment *attach, struct sg_table *sgt)
+{
+	int ret = 0;
+	struct drm_xocl_bo *exporting_xobj;
+	struct drm_xocl_bo *importing_xobj;
+
+	/*
+	 * For ARE device resue the mm node from exporting xobj
+	 * For non ARE devices we need to create a full BO but share the SG
+	 * table
+	 * ???? add flags to create_bo.. for DDR bank??
+	 */
+
+	exporting_xobj = xocl_is_exporting_xare(dev, attach);
+	importing_xobj = exporting_xobj ?
+		xocl_create_bo_forARE(dev, attach->dmabuf->size,
+				exporting_xobj->mm_node) :
+		xocl_create_bo(dev, attach->dmabuf->size, 0, 0);
+
+	BO_ENTER("xobj %p", importing_xobj);
+
+	if (IS_ERR(importing_xobj)) {
+		DRM_DEBUG("object creation failed\n");
+		return (struct drm_gem_object *)importing_xobj;
+	}
+
+	importing_xobj->type |= XOCL_BO_IMPORT;
+	importing_xobj->sgt = sgt;
+	importing_xobj->pages = drm_malloc_ab(attach->dmabuf->size >> PAGE_SHIFT, sizeof(*importing_xobj->pages));
+	if (!importing_xobj->pages) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	ret = drm_prime_sg_to_page_addr_arrays(sgt, importing_xobj->pages,
+					       NULL, attach->dmabuf->size >> PAGE_SHIFT);
+	if (ret)
+		goto out_free;
+
+	importing_xobj->vmapping = vmap(importing_xobj->pages, importing_xobj->base.size >> PAGE_SHIFT, VM_MAP,
+					PAGE_KERNEL);
+
+	if (!importing_xobj->vmapping) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	ret = drm_gem_create_mmap_offset(&importing_xobj->base);
+	if (ret < 0)
+		goto out_free;
+
+	xocl_describe(importing_xobj);
+	return &importing_xobj->base;
+
+out_free:
+	xocl_free_bo(&importing_xobj->base);
+	DRM_ERROR("Buffer import failed\n");
+	return ERR_PTR(ret);
+}
+
+void *xocl_gem_prime_vmap(struct drm_gem_object *obj)
+{
+	struct drm_xocl_bo *xobj = to_xocl_bo(obj);
+
+	BO_ENTER("xobj %p", xobj);
+	return xobj->vmapping;
+}
+
+void xocl_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
+{
+
+}
+
+int xocl_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
+{
+	struct drm_xocl_bo *xobj = to_xocl_bo(obj);
+	int ret;
+
+	BO_ENTER("obj %p", obj);
+	if (obj->size < vma->vm_end - vma->vm_start)
+		return -EINVAL;
+
+	if (!obj->filp)
+		return -ENODEV;
+
+	ret = obj->filp->f_op->mmap(obj->filp, vma);
+	if (ret)
+		return ret;
+
+	fput(vma->vm_file);
+	if (!IS_ERR(xobj->dmabuf)) {
+		vma->vm_file = get_file(xobj->dmabuf->file);
+		vma->vm_ops = xobj->dmabuf_vm_ops;
+		vma->vm_private_data = obj;
+		vma->vm_flags |= VM_MIXEDMAP;
+	}
+
+	return 0;
+}
+
+int xocl_init_unmgd(struct drm_xocl_unmgd *unmgd, uint64_t data_ptr,
+	uint64_t size, u32 write)
+{
+	int ret;
+	char __user *user_data = to_user_ptr(data_ptr);
+
+	if (!access_ok(user_data, size))
+		return -EFAULT;
+
+	memset(unmgd, 0, sizeof(struct drm_xocl_unmgd));
+
+	unmgd->npages = (((unsigned long)user_data + size + PAGE_SIZE - 1) -
+			((unsigned long)user_data & PAGE_MASK)) >> PAGE_SHIFT;
+
+	unmgd->pages = drm_malloc_ab(unmgd->npages, sizeof(*unmgd->pages));
+	if (!unmgd->pages)
+		return -ENOMEM;
+
+	ret = get_user_pages_fast(data_ptr, unmgd->npages, (write == 0) ? 1 : 0, unmgd->pages);
+
+	if (ret != unmgd->npages)
+		goto clear_pages;
+
+	unmgd->sgt = alloc_onetime_sg_table(unmgd->pages, data_ptr & ~PAGE_MASK, size);
+	if (IS_ERR(unmgd->sgt)) {
+		ret = PTR_ERR(unmgd->sgt);
+		goto clear_release;
+	}
+
+	return 0;
+
+clear_release:
+	xocl_release_pages(unmgd->pages, unmgd->npages, 0);
+clear_pages:
+	drm_free_large(unmgd->pages);
+	unmgd->pages = NULL;
+	return ret;
+}
+
+void xocl_finish_unmgd(struct drm_xocl_unmgd *unmgd)
+{
+	if (!unmgd->pages)
+		return;
+	sg_free_table(unmgd->sgt);
+	kfree(unmgd->sgt);
+	xocl_release_pages(unmgd->pages, unmgd->npages, 0);
+	drm_free_large(unmgd->pages);
+	unmgd->pages = NULL;
+}
+
+static bool xocl_validate_paddr(struct xocl_dev *xdev, u64 paddr, u64 size)
+{
+	struct mem_data *mem_data;
+	int	i;
+	uint64_t addr;
+	bool start_check = false;
+	bool end_check = false;
+
+	for (i = 0; i < XOCL_MEM_TOPOLOGY(xdev)->m_count; i++) {
+		mem_data = &XOCL_MEM_TOPOLOGY(xdev)->m_mem_data[i];
+		addr = mem_data->m_base_address;
+		start_check = (paddr >= addr);
+		end_check = (paddr + size <= addr + mem_data->m_size * 1024);
+		if (mem_data->m_used && start_check && end_check)
+			return true;
+	}
+
+	return false;
+}
+
+int xocl_pwrite_unmgd_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp)
+{
+	int channel;
+	struct drm_xocl_unmgd unmgd;
+	const struct drm_xocl_pwrite_unmgd *args = data;
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+	u32 dir = 1;
+	ssize_t ret = 0;
+
+	if (args->address_space != 0) {
+		userpf_err(xdev, "invalid addr space");
+		return -EFAULT;
+	}
+
+	if (args->size == 0)
+		return 0;
+
+	if (!xocl_validate_paddr(xdev, args->paddr, args->size)) {
+		userpf_err(xdev, "invalid paddr: 0x%llx, size:0x%llx",
+			args->paddr, args->size);
+		/* currently we are not able to return error because
+		 * it is unclear that what addresses are valid other than
+		 * ddr area. we should revisit this sometime.
+		 * return -EINVAL;
+		 */
+	}
+
+	ret = xocl_init_unmgd(&unmgd, args->data_ptr, args->size, dir);
+	if (ret) {
+		userpf_err(xdev, "init unmgd failed %ld", ret);
+		return ret;
+	}
+
+	channel = xocl_acquire_channel(xdev, dir);
+	if (channel < 0) {
+		userpf_err(xdev, "acquire channel failed");
+		ret = -EINVAL;
+		goto clear;
+	}
+	/* Now perform DMA */
+	ret = xocl_migrate_bo(xdev, unmgd.sgt, dir, args->paddr, channel,
+		args->size);
+	if (ret >= 0)
+		ret = (ret == args->size) ? 0 : -EIO;
+	xocl_release_channel(xdev, dir, channel);
+clear:
+	xocl_finish_unmgd(&unmgd);
+	return ret;
+}
+
+int xocl_pread_unmgd_ioctl(struct drm_device *dev, void *data,
+			   struct drm_file *filp)
+{
+	int channel;
+	struct drm_xocl_unmgd unmgd;
+	const struct drm_xocl_pwrite_unmgd *args = data;
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+	u32 dir = 0;  /* read */
+	ssize_t ret = 0;
+
+	if (args->address_space != 0) {
+		userpf_err(xdev, "invalid addr space");
+		return -EFAULT;
+	}
+
+	if (args->size == 0)
+		return 0;
+
+	if (!xocl_validate_paddr(xdev, args->paddr, args->size)) {
+		userpf_err(xdev, "invalid paddr: 0x%llx, size:0x%llx",
+			args->paddr, args->size);
+		/* currently we are not able to return error because
+		 * it is unclear that what addresses are valid other than
+		 * ddr area. we should revisit this sometime.
+		 * return -EINVAL;
+		 */
+	}
+
+	ret = xocl_init_unmgd(&unmgd, args->data_ptr, args->size, dir);
+	if (ret) {
+		userpf_err(xdev, "init unmgd failed %ld", ret);
+		return ret;
+	}
+
+	channel = xocl_acquire_channel(xdev, dir);
+
+	if (channel < 0) {
+		userpf_err(xdev, "acquire channel failed");
+		ret = -EINVAL;
+		goto clear;
+	}
+	/* Now perform DMA */
+	ret = xocl_migrate_bo(xdev, unmgd.sgt, dir, args->paddr, channel,
+		args->size);
+	if (ret >= 0)
+		ret = (ret == args->size) ? 0 : -EIO;
+
+	xocl_release_channel(xdev, dir, channel);
+clear:
+	xocl_finish_unmgd(&unmgd);
+	return ret;
+}
+
+int xocl_usage_stat_ioctl(struct drm_device *dev, void *data,
+			  struct drm_file *filp)
+{
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+	struct drm_xocl_usage_stat *args = data;
+	int	i;
+
+	args->mm_channel_count = XOCL_DDR_COUNT(xdev);
+	if (args->mm_channel_count > 8)
+		args->mm_channel_count = 8;
+	for (i = 0; i < args->mm_channel_count; i++)
+		xocl_mm_get_usage_stat(drm_p, i, args->mm + i);
+
+	args->dma_channel_count = xocl_get_chan_count(xdev);
+	if (args->dma_channel_count > 8)
+		args->dma_channel_count = 8;
+
+	for (i = 0; i < args->dma_channel_count; i++) {
+		args->h2c[i] = xocl_get_chan_stat(xdev, i, 1);
+		args->c2h[i] = xocl_get_chan_stat(xdev, i, 0);
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/xocl/userpf/xocl_bo.h b/drivers/gpu/drm/xocl/userpf/xocl_bo.h
new file mode 100644
index 000000000000..38ac78cd59f6
--- /dev/null
+++ b/drivers/gpu/drm/xocl/userpf/xocl_bo.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2016-2018 Xilinx, Inc. All rights reserved.
+ *
+ * Authors:
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _XOCL_BO_H
+#define	_XOCL_BO_H
+
+#include <drm/xocl_drm.h>
+#include "../xocl_drm.h"
+
+#define XOCL_BO_USERPTR (1 << 31)
+#define XOCL_BO_IMPORT  (1 << 30)
+#define XOCL_BO_EXECBUF (1 << 29)
+#define XOCL_BO_CMA     (1 << 28)
+#define XOCL_BO_P2P     (1 << 27)
+
+#define XOCL_BO_DDR0 (1 << 0)
+#define XOCL_BO_DDR1 (1 << 1)
+#define XOCL_BO_DDR2 (1 << 2)
+#define XOCL_BO_DDR3 (1 << 3)
+
+
+
+//#define XOCL_MEM_BANK_MSK (0xFFFFFF)
+/*
+ * When the BO is imported from an ARE device. This is remote BO to
+ * be accessed over ARE
+ */
+#define XOCL_BO_ARE  (1 << 26)
+
+static inline bool xocl_bo_userptr(const struct drm_xocl_bo *bo)
+{
+	return (bo->type & XOCL_BO_USERPTR);
+}
+
+static inline bool xocl_bo_import(const struct drm_xocl_bo *bo)
+{
+	return (bo->type & XOCL_BO_IMPORT);
+}
+
+static inline bool xocl_bo_execbuf(const struct drm_xocl_bo *bo)
+{
+	return (bo->type & XOCL_BO_EXECBUF);
+}
+
+static inline bool xocl_bo_cma(const struct drm_xocl_bo *bo)
+{
+	return (bo->type & XOCL_BO_CMA);
+}
+static inline bool xocl_bo_p2p(const struct drm_xocl_bo *bo)
+{
+	return (bo->type & XOCL_BO_P2P);
+}
+
+static inline struct drm_gem_object *xocl_gem_object_lookup(struct drm_device *dev,
+							    struct drm_file *filp,
+							    u32 handle)
+{
+	return drm_gem_object_lookup(filp, handle);
+}
+
+static inline struct drm_xocl_dev *bo_xocl_dev(const struct drm_xocl_bo *bo)
+{
+	return bo->base.dev->dev_private;
+}
+
+static inline unsigned int xocl_bo_ddr_idx(unsigned int flags)
+{
+	return flags;
+}
+
+int xocl_create_bo_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_userptr_bo_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_sync_bo_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_copy_bo_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_map_bo_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_info_bo_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_pwrite_bo_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_pread_bo_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_ctx_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_pwrite_unmgd_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_pread_unmgd_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+int xocl_usage_stat_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp);
+
+struct sg_table *xocl_gem_prime_get_sg_table(struct drm_gem_object *obj);
+struct drm_gem_object *xocl_gem_prime_import_sg_table(struct drm_device *dev,
+	struct dma_buf_attachment *attach, struct sg_table *sgt);
+void *xocl_gem_prime_vmap(struct drm_gem_object *obj);
+void xocl_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
+int xocl_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
+
+#endif
diff --git a/drivers/gpu/drm/xocl/userpf/xocl_drm.c b/drivers/gpu/drm/xocl/userpf/xocl_drm.c
new file mode 100644
index 000000000000..e07f5f8a054a
--- /dev/null
+++ b/drivers/gpu/drm/xocl/userpf/xocl_drm.c
@@ -0,0 +1,640 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2016-2018 Xilinx, Inc. All rights reserved.
+ *
+ * Authors:
+ *
+ */
+
+#include <linux/version.h>
+#include <drm/drmP.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_mm.h>
+#include "../version.h"
+#include "../lib/libxdma_api.h"
+#include "common.h"
+
+#if defined(__PPC64__)
+#define XOCL_FILE_PAGE_OFFSET	0x10000
+#else
+#define XOCL_FILE_PAGE_OFFSET	0x100000
+#endif
+
+#ifndef VM_RESERVED
+#define VM_RESERVED (VM_DONTEXPAND | VM_DONTDUMP)
+#endif
+
+#ifdef _XOCL_DRM_DEBUG
+#define DRM_ENTER(fmt, args...)		 \
+	printk(KERN_INFO "[DRM] Entering %s:"fmt"\n", __func__, ##args)
+#define DRM_DBG(fmt, args...)	       \
+	printk(KERN_INFO "[DRM] %s:%d:"fmt"\n", __func__, __LINE__, ##args)
+#else
+#define DRM_ENTER(fmt, args...)
+#define DRM_DBG(fmt, args...)
+#endif
+
+static char driver_date[9];
+
+static void xocl_free_object(struct drm_gem_object *obj)
+{
+	DRM_ENTER("");
+	xocl_drm_free_bo(obj);
+}
+
+static int xocl_open(struct inode *inode, struct file *filp)
+{
+	struct xocl_drm *drm_p;
+	struct drm_file *priv;
+	struct drm_device *ddev;
+	int ret;
+
+	ret = drm_open(inode, filp);
+	if (ret)
+		return ret;
+
+	priv = filp->private_data;
+	ddev = priv->minor->dev;
+	drm_p = xocl_drvinst_open(ddev);
+	if (!drm_p)
+		return -ENXIO;
+
+	return 0;
+}
+
+static int xocl_release(struct inode *inode, struct file *filp)
+{
+	struct drm_file *priv = filp->private_data;
+	struct drm_device *ddev = priv->minor->dev;
+	struct xocl_drm	*drm_p = ddev->dev_private;
+	int ret;
+
+	ret = drm_release(inode, filp);
+	xocl_drvinst_close(drm_p);
+
+	return ret;
+}
+
+static int xocl_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	int ret;
+	struct drm_file *priv = filp->private_data;
+	struct drm_device *dev = priv->minor->dev;
+	struct mm_struct *mm = current->mm;
+	struct xocl_drm *drm_p = dev->dev_private;
+	xdev_handle_t xdev = drm_p->xdev;
+	unsigned long vsize;
+	phys_addr_t res_start;
+
+	DRM_ENTER("vm pgoff %lx", vma->vm_pgoff);
+
+	/*
+	 * If the page offset is > than 4G, then let GEM handle that and do what
+	 * it thinks is best,we will only handle page offsets less than 4G.
+	 */
+	if (likely(vma->vm_pgoff >= XOCL_FILE_PAGE_OFFSET)) {
+		ret = drm_gem_mmap(filp, vma);
+		if (ret)
+			return ret;
+		/* Clear VM_PFNMAP flag set by drm_gem_mmap()
+		 * we have "struct page" for all backing pages for bo
+		 */
+		vma->vm_flags &= ~VM_PFNMAP;
+		/* Clear VM_IO flag set by drm_gem_mmap()
+		 * it prevents gdb from accessing mapped buffers
+		 */
+		vma->vm_flags &= ~VM_IO;
+		vma->vm_flags |= VM_MIXEDMAP;
+		vma->vm_flags |= mm->def_flags;
+		vma->vm_pgoff = 0;
+
+		/* Override pgprot_writecombine() mapping setup by
+		 * drm_gem_mmap()
+		 * which results in very poor read performance
+		 */
+		if (vma->vm_flags & (VM_READ | VM_MAYREAD))
+			vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
+		else
+			vma->vm_page_prot = pgprot_writecombine(
+				vm_get_page_prot(vma->vm_flags));
+		return ret;
+	}
+
+	if (vma->vm_pgoff != 0)
+		return -EINVAL;
+
+	vsize = vma->vm_end - vma->vm_start;
+	if (vsize > XDEV(xdev)->bar_size)
+		return -EINVAL;
+
+	DRM_DBG("MAP size %ld", vsize);
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_flags |= VM_IO;
+	vma->vm_flags |= VM_RESERVED;
+
+	res_start = pci_resource_start(XDEV(xdev)->pdev, XDEV(xdev)->bar_idx);
+	ret = io_remap_pfn_range(vma, vma->vm_start,
+				 res_start >> PAGE_SHIFT,
+				 vsize, vma->vm_page_prot);
+	userpf_info(xdev, "io_remap_pfn_range ret code: %d", ret);
+
+	return ret;
+}
+
+int xocl_gem_fault(struct vm_fault *vmf)
+{
+	loff_t num_pages;
+	unsigned int page_offset;
+	struct vm_area_struct *vma = vmf->vma;
+	struct drm_xocl_bo *xobj = to_xocl_bo(vma->vm_private_data);
+	int ret = 0;
+	unsigned long vmf_address = vmf->address;
+
+	page_offset = (vmf_address - vma->vm_start) >> PAGE_SHIFT;
+
+
+	if (!xobj->pages)
+		return VM_FAULT_SIGBUS;
+
+	num_pages = DIV_ROUND_UP(xobj->base.size, PAGE_SIZE);
+	if (page_offset > num_pages)
+		return VM_FAULT_SIGBUS;
+
+	if (xobj->type & XOCL_BO_P2P)
+		ret = vm_insert_page(vma, vmf_address, xobj->pages[page_offset]);
+	else
+		ret = vm_insert_page(vma, vmf_address, xobj->pages[page_offset]);
+
+	switch (ret) {
+	case -EAGAIN:
+	case 0:
+	case -ERESTARTSYS:
+		return VM_FAULT_NOPAGE;
+	case -ENOMEM:
+		return VM_FAULT_OOM;
+	default:
+		return VM_FAULT_SIGBUS;
+	}
+}
+
+static int xocl_client_open(struct drm_device *dev, struct drm_file *filp)
+{
+	struct xocl_drm	*drm_p = dev->dev_private;
+	int	ret = 0;
+
+	DRM_ENTER("");
+
+	/* We do not allow users to open PRIMARY node, /dev/dri/cardX node.
+	 * Users should only open RENDER, /dev/dri/renderX node
+	 */
+	if (drm_is_primary_client(filp))
+		return -EPERM;
+
+	if (get_live_client_size(drm_p->xdev) > XOCL_MAX_CONCURRENT_CLIENTS)
+		return -EBUSY;
+
+	ret = xocl_exec_create_client(drm_p->xdev, &filp->driver_priv);
+	if (ret)
+		goto failed;
+
+	return 0;
+
+failed:
+	return ret;
+}
+
+static void xocl_client_release(struct drm_device *dev, struct drm_file *filp)
+{
+	struct xocl_drm	*drm_p = dev->dev_private;
+
+	xocl_exec_destroy_client(drm_p->xdev, &filp->driver_priv);
+}
+
+static uint xocl_poll(struct file *filp, poll_table *wait)
+{
+	struct drm_file *priv = filp->private_data;
+	struct drm_device *dev = priv->minor->dev;
+	struct xocl_drm	*drm_p = dev->dev_private;
+
+	BUG_ON(!priv->driver_priv);
+
+	DRM_ENTER("");
+	return xocl_exec_poll_client(drm_p->xdev, filp, wait, priv->driver_priv);
+}
+
+static const struct drm_ioctl_desc xocl_ioctls[] = {
+	DRM_IOCTL_DEF_DRV(XOCL_CREATE_BO, xocl_create_bo_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_USERPTR_BO, xocl_userptr_bo_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_MAP_BO, xocl_map_bo_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_SYNC_BO, xocl_sync_bo_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_INFO_BO, xocl_info_bo_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_PWRITE_BO, xocl_pwrite_bo_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_PREAD_BO, xocl_pread_bo_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_CTX, xocl_ctx_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_INFO, xocl_info_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_READ_AXLF, xocl_read_axlf_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_PWRITE_UNMGD, xocl_pwrite_unmgd_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_PREAD_UNMGD, xocl_pread_unmgd_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_USAGE_STAT, xocl_usage_stat_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_USER_INTR, xocl_user_intr_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_EXECBUF, xocl_execbuf_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_COPY_BO, xocl_copy_bo_ioctl,
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_HOT_RESET, xocl_hot_reset_ioctl,
+		  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XOCL_RECLOCK, xocl_reclock_ioctl,
+	  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
+};
+
+static long xocl_drm_ioctl(struct file *filp,
+			      unsigned int cmd, unsigned long arg)
+{
+	return drm_ioctl(filp, cmd, arg);
+}
+
+static const struct file_operations xocl_driver_fops = {
+	.owner		= THIS_MODULE,
+	.open		= xocl_open,
+	.mmap		= xocl_mmap,
+	.poll		= xocl_poll,
+	.read		= drm_read,
+	.unlocked_ioctl = xocl_drm_ioctl,
+	.release	= xocl_release,
+};
+
+static const struct vm_operations_struct xocl_vm_ops = {
+	.fault = xocl_gem_fault,
+	.open = drm_gem_vm_open,
+	.close = drm_gem_vm_close,
+};
+
+static struct drm_driver mm_drm_driver = {
+	.driver_features		= DRIVER_GEM | DRIVER_PRIME |
+						DRIVER_RENDER,
+
+	.postclose			= xocl_client_release,
+	.open				= xocl_client_open,
+
+	.gem_free_object		= xocl_free_object,
+	.gem_vm_ops			= &xocl_vm_ops,
+
+	.ioctls				= xocl_ioctls,
+	.num_ioctls			= ARRAY_SIZE(xocl_ioctls),
+	.fops				= &xocl_driver_fops,
+
+	.gem_prime_get_sg_table		= xocl_gem_prime_get_sg_table,
+	.gem_prime_import_sg_table	= xocl_gem_prime_import_sg_table,
+	.gem_prime_vmap			= xocl_gem_prime_vmap,
+	.gem_prime_vunmap		= xocl_gem_prime_vunmap,
+	.gem_prime_mmap			= xocl_gem_prime_mmap,
+
+	.prime_handle_to_fd		= drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle		= drm_gem_prime_fd_to_handle,
+	.gem_prime_import		= drm_gem_prime_import,
+	.gem_prime_export		= drm_gem_prime_export,
+	.name				= XOCL_MODULE_NAME,
+	.desc				= XOCL_DRIVER_DESC,
+	.date				= driver_date,
+};
+
+void *xocl_drm_init(xdev_handle_t xdev_hdl)
+{
+	struct xocl_drm		*drm_p = NULL;
+	struct drm_device	*ddev = NULL;
+	int			year, mon, day;
+	int			ret = 0;
+	bool			drm_registered = false;
+
+	sscanf(XRT_DRIVER_VERSION, "%d.%d.%d",
+		&mm_drm_driver.major,
+		&mm_drm_driver.minor,
+		&mm_drm_driver.patchlevel);
+
+	sscanf(xrt_build_version_date, "%d-%d-%d ", &year, &mon, &day);
+	snprintf(driver_date, sizeof(driver_date),
+		"%d%02d%02d", year, mon, day);
+
+	ddev = drm_dev_alloc(&mm_drm_driver, &XDEV(xdev_hdl)->pdev->dev);
+	if (!ddev) {
+		xocl_xdev_err(xdev_hdl, "alloc drm dev failed");
+		ret = -ENOMEM;
+		goto failed;
+	}
+
+	drm_p = xocl_drvinst_alloc(ddev->dev, sizeof(*drm_p));
+	if (!drm_p) {
+		xocl_xdev_err(xdev_hdl, "alloc drm inst failed");
+		ret = -ENOMEM;
+		goto failed;
+	}
+	drm_p->xdev = xdev_hdl;
+
+	ddev->pdev = XDEV(xdev_hdl)->pdev;
+
+	ret = drm_dev_register(ddev, 0);
+	if (ret) {
+		xocl_xdev_err(xdev_hdl, "register drm dev failed 0x%x", ret);
+		goto failed;
+	}
+	drm_registered = true;
+
+	drm_p->ddev = ddev;
+
+	mutex_init(&drm_p->mm_lock);
+	ddev->dev_private = drm_p;
+	hash_init(drm_p->mm_range);
+
+	xocl_drvinst_set_filedev(drm_p, ddev);
+	return drm_p;
+
+failed:
+	if (drm_registered)
+		drm_dev_unregister(ddev);
+//PORT4_20
+	if (ddev)
+		drm_dev_put(ddev);
+	if (drm_p)
+		xocl_drvinst_free(drm_p);
+
+	return NULL;
+}
+
+void xocl_drm_fini(struct xocl_drm *drm_p)
+{
+	xocl_cleanup_mem(drm_p);
+	drm_put_dev(drm_p->ddev);
+	mutex_destroy(&drm_p->mm_lock);
+
+	xocl_drvinst_free(drm_p);
+}
+
+void xocl_mm_get_usage_stat(struct xocl_drm *drm_p, u32 ddr,
+	struct drm_xocl_mm_stat *pstat)
+{
+	pstat->memory_usage = drm_p->mm_usage_stat[ddr] ?
+		drm_p->mm_usage_stat[ddr]->memory_usage : 0;
+	pstat->bo_count = drm_p->mm_usage_stat[ddr] ?
+		drm_p->mm_usage_stat[ddr]->bo_count : 0;
+}
+
+void xocl_mm_update_usage_stat(struct xocl_drm *drm_p, u32 ddr,
+	u64 size, int count)
+{
+	BUG_ON(!drm_p->mm_usage_stat[ddr]);
+
+	drm_p->mm_usage_stat[ddr]->memory_usage += (count > 0) ? size : -size;
+	drm_p->mm_usage_stat[ddr]->bo_count += count;
+}
+
+int xocl_mm_insert_node(struct xocl_drm *drm_p, u32 ddr,
+		struct drm_mm_node *node, u64 size)
+{
+	return drm_mm_insert_node_generic(drm_p->mm[ddr], node, size, PAGE_SIZE,
+#if defined(XOCL_DRM_FREE_MALLOC)
+		0, 0);
+#else
+		0, 0, 0);
+#endif
+}
+
+int xocl_check_topology(struct xocl_drm *drm_p)
+{
+	struct mem_topology    *topology;
+	u16	i;
+	int	err = 0;
+
+	topology = XOCL_MEM_TOPOLOGY(drm_p->xdev);
+	if (topology == NULL)
+		return 0;
+
+	for (i = 0; i < topology->m_count; i++) {
+		if (!topology->m_mem_data[i].m_used)
+			continue;
+
+		if (topology->m_mem_data[i].m_type == MEM_STREAMING)
+			continue;
+
+		if (drm_p->mm_usage_stat[i]->bo_count != 0) {
+			err = -EPERM;
+			xocl_err(drm_p->ddev->dev,
+				 "The ddr %d has pre-existing buffer allocations, please exit and re-run.",
+				 i);
+		}
+	}
+
+	return err;
+}
+
+uint32_t xocl_get_shared_ddr(struct xocl_drm *drm_p, struct mem_data *m_data)
+{
+	struct xocl_mm_wrapper *wrapper;
+	uint64_t start_addr = m_data->m_base_address;
+	uint64_t sz = m_data->m_size*1024;
+
+	hash_for_each_possible(drm_p->mm_range, wrapper, node, start_addr) {
+		if (!wrapper)
+			continue;
+
+		if (wrapper->start_addr == start_addr) {
+			if (wrapper->size == sz)
+				return wrapper->ddr;
+			else
+				return 0xffffffff;
+		}
+	}
+	return 0xffffffff;
+}
+
+void xocl_cleanup_mem(struct xocl_drm *drm_p)
+{
+	struct mem_topology *topology;
+	u16 i, ddr;
+	uint64_t addr;
+	struct xocl_mm_wrapper *wrapper;
+	struct hlist_node *tmp;
+
+	topology = XOCL_MEM_TOPOLOGY(drm_p->xdev);
+	if (topology) {
+		ddr = topology->m_count;
+		for (i = 0; i < ddr; i++) {
+			if (!topology->m_mem_data[i].m_used)
+				continue;
+
+			if (topology->m_mem_data[i].m_type == MEM_STREAMING)
+				continue;
+
+			xocl_info(drm_p->ddev->dev, "Taking down DDR : %d", i);
+			addr = topology->m_mem_data[i].m_base_address;
+
+			hash_for_each_possible_safe(drm_p->mm_range, wrapper,
+					tmp, node, addr) {
+				if (wrapper->ddr == i) {
+					hash_del(&wrapper->node);
+					vfree(wrapper);
+					drm_mm_takedown(drm_p->mm[i]);
+					vfree(drm_p->mm[i]);
+					vfree(drm_p->mm_usage_stat[i]);
+				}
+			}
+
+			drm_p->mm[i] = NULL;
+			drm_p->mm_usage_stat[i] = NULL;
+		}
+	}
+	vfree(drm_p->mm);
+	drm_p->mm = NULL;
+	vfree(drm_p->mm_usage_stat);
+	drm_p->mm_usage_stat = NULL;
+	vfree(drm_p->mm_p2p_off);
+	drm_p->mm_p2p_off = NULL;
+}
+
+int xocl_init_mem(struct xocl_drm *drm_p)
+{
+	size_t length = 0;
+	size_t mm_size = 0, mm_stat_size = 0;
+	size_t size = 0, wrapper_size = 0;
+	size_t ddr_bank_size;
+	struct mem_topology *topo;
+	struct mem_data *mem_data;
+	uint32_t shared;
+	struct xocl_mm_wrapper *wrapper = NULL;
+	uint64_t reserved1 = 0;
+	uint64_t reserved2 = 0;
+	uint64_t reserved_start;
+	uint64_t reserved_end;
+	int err = 0;
+	int i = -1;
+
+	if (XOCL_DSA_IS_MPSOC(drm_p->xdev)) {
+		/* TODO: This is still hardcoding.. */
+		reserved1 = 0x80000000;
+		reserved2 = 0x1000000;
+	}
+
+	topo = XOCL_MEM_TOPOLOGY(drm_p->xdev);
+	if (topo == NULL)
+		return 0;
+
+	length = topo->m_count * sizeof(struct mem_data);
+	size = topo->m_count * sizeof(void *);
+	wrapper_size = sizeof(struct xocl_mm_wrapper);
+	mm_size = sizeof(struct drm_mm);
+	mm_stat_size = sizeof(struct drm_xocl_mm_stat);
+
+	xocl_info(drm_p->ddev->dev, "Topology count = %d, data_length = %ld",
+		topo->m_count, length);
+
+	drm_p->mm = vzalloc(size);
+	drm_p->mm_usage_stat = vzalloc(size);
+	drm_p->mm_p2p_off = vzalloc(topo->m_count * sizeof(u64));
+	if (!drm_p->mm || !drm_p->mm_usage_stat || !drm_p->mm_p2p_off) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	for (i = 0; i < topo->m_count; i++) {
+		mem_data = &topo->m_mem_data[i];
+		ddr_bank_size = mem_data->m_size * 1024;
+
+		xocl_info(drm_p->ddev->dev, "  Mem Index %d", i);
+		xocl_info(drm_p->ddev->dev, "  Base Address:0x%llx",
+			mem_data->m_base_address);
+		xocl_info(drm_p->ddev->dev, "  Size:0x%lx", ddr_bank_size);
+		xocl_info(drm_p->ddev->dev, "  Type:%d", mem_data->m_type);
+		xocl_info(drm_p->ddev->dev, "  Used:%d", mem_data->m_used);
+	}
+
+	/* Initialize the used banks and their sizes */
+	/* Currently only fixed sizes are supported */
+	for (i = 0; i < topo->m_count; i++) {
+		mem_data = &topo->m_mem_data[i];
+		if (!mem_data->m_used)
+			continue;
+
+		if (mem_data->m_type == MEM_STREAMING ||
+			mem_data->m_type == MEM_STREAMING_CONNECTION)
+			continue;
+
+		ddr_bank_size = mem_data->m_size * 1024;
+		xocl_info(drm_p->ddev->dev, "Allocating DDR bank%d", i);
+		xocl_info(drm_p->ddev->dev, "  base_addr:0x%llx, total size:0x%lx",
+			mem_data->m_base_address, ddr_bank_size);
+
+		if (XOCL_DSA_IS_MPSOC(drm_p->xdev)) {
+			reserved_end = mem_data->m_base_address + ddr_bank_size;
+			reserved_start = reserved_end - reserved1 - reserved2;
+			xocl_info(drm_p->ddev->dev, "  reserved region:0x%llx - 0x%llx",
+				reserved_start, reserved_end - 1);
+		}
+
+		shared = xocl_get_shared_ddr(drm_p, mem_data);
+		if (shared != 0xffffffff) {
+			xocl_info(drm_p->ddev->dev, "Found duplicated memory region!");
+			drm_p->mm[i] = drm_p->mm[shared];
+			drm_p->mm_usage_stat[i] = drm_p->mm_usage_stat[shared];
+			continue;
+		}
+
+		xocl_info(drm_p->ddev->dev, "Found a new memory region");
+		wrapper = vzalloc(wrapper_size);
+		drm_p->mm[i] = vzalloc(mm_size);
+		drm_p->mm_usage_stat[i] = vzalloc(mm_stat_size);
+
+		if (!drm_p->mm[i] || !drm_p->mm_usage_stat[i] || !wrapper) {
+			err = -ENOMEM;
+			goto failed;
+		}
+
+		wrapper->start_addr = mem_data->m_base_address;
+		wrapper->size = mem_data->m_size*1024;
+		wrapper->mm = drm_p->mm[i];
+		wrapper->mm_usage_stat = drm_p->mm_usage_stat[i];
+		wrapper->ddr = i;
+		hash_add(drm_p->mm_range, &wrapper->node, wrapper->start_addr);
+
+		drm_mm_init(drm_p->mm[i], mem_data->m_base_address,
+				ddr_bank_size - reserved1 - reserved2);
+		drm_p->mm_p2p_off[i] = ddr_bank_size * i;
+
+		xocl_info(drm_p->ddev->dev, "drm_mm_init called");
+	}
+
+	return 0;
+
+failed:
+	vfree(wrapper);
+	if (drm_p->mm) {
+		for (; i >= 0; i--) {
+			drm_mm_takedown(drm_p->mm[i]);
+			vfree(drm_p->mm[i]);
+			vfree(drm_p->mm_usage_stat[i]);
+		}
+		vfree(drm_p->mm);
+		drm_p->mm = NULL;
+	}
+	vfree(drm_p->mm_usage_stat);
+	drm_p->mm_usage_stat = NULL;
+	vfree(drm_p->mm_p2p_off);
+	drm_p->mm_p2p_off = NULL;
+
+	return err;
+}
diff --git a/drivers/gpu/drm/xocl/userpf/xocl_drv.c b/drivers/gpu/drm/xocl/userpf/xocl_drv.c
new file mode 100644
index 000000000000..6fc57da3deab
--- /dev/null
+++ b/drivers/gpu/drm/xocl/userpf/xocl_drv.c
@@ -0,0 +1,743 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2016-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors: Lizhi.Hou@xilinx.com
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "../xocl_drv.h"
+#include "common.h"
+#include "../version.h"
+#include <linux/memremap.h>
+
+#ifndef PCI_EXT_CAP_ID_REBAR
+#define PCI_EXT_CAP_ID_REBAR 0x15
+#endif
+
+#ifndef PCI_REBAR_CTRL
+#define PCI_REBAR_CTRL          8       /* control register */
+#endif
+
+#ifndef PCI_REBAR_CTRL_BAR_SIZE
+#define  PCI_REBAR_CTRL_BAR_SIZE        0x00001F00  /* BAR size */
+#endif
+
+#ifndef PCI_REBAR_CTRL_BAR_SHIFT
+#define  PCI_REBAR_CTRL_BAR_SHIFT       8           /* shift for BAR size */
+#endif
+
+#define REBAR_FIRST_CAP		4
+
+static const struct pci_device_id pciidlist[] = XOCL_USER_PCI_IDS;
+
+struct class *xrt_class;
+
+MODULE_DEVICE_TABLE(pci, pciidlist);
+
+static int userpf_intr_config(xdev_handle_t xdev_hdl, u32 intr, bool en)
+{
+	return xocl_dma_intr_config(xdev_hdl, intr, en);
+}
+
+static int userpf_intr_register(xdev_handle_t xdev_hdl, u32 intr,
+		irq_handler_t handler, void *arg)
+{
+	return handler ?
+		xocl_dma_intr_register(xdev_hdl, intr, handler, arg, -1) :
+		xocl_dma_intr_unreg(xdev_hdl, intr);
+}
+
+struct xocl_pci_funcs userpf_pci_ops = {
+	.intr_config = userpf_intr_config,
+	.intr_register = userpf_intr_register,
+};
+
+void xocl_reset_notify(struct pci_dev *pdev, bool prepare)
+{
+	struct xocl_dev *xdev = pci_get_drvdata(pdev);
+
+	xocl_info(&pdev->dev, "PCI reset NOTIFY, prepare %d", prepare);
+
+	if (prepare) {
+		xocl_mailbox_reset(xdev, false);
+		xocl_subdev_destroy_by_id(xdev, XOCL_SUBDEV_DMA);
+	} else {
+		reset_notify_client_ctx(xdev);
+		xocl_subdev_create_by_id(xdev, XOCL_SUBDEV_DMA);
+		xocl_mailbox_reset(xdev, true);
+		xocl_exec_reset(xdev);
+	}
+}
+
+static void kill_all_clients(struct xocl_dev *xdev)
+{
+	struct list_head *ptr;
+	struct client_ctx *entry;
+	int ret;
+	int total_wait_secs = 10; // sec
+	int wait_interval = 100; // millisec
+	int retry = total_wait_secs * 1000 / wait_interval;
+
+	mutex_lock(&xdev->ctx_list_lock);
+
+	list_for_each(ptr, &xdev->ctx_list) {
+		entry = list_entry(ptr, struct client_ctx, link);
+		ret = kill_pid(entry->pid, SIGBUS, 1);
+		if (ret) {
+			userpf_err(xdev, "killing pid: %d failed. err: %d",
+				pid_nr(entry->pid), ret);
+		}
+	}
+
+	mutex_unlock(&xdev->ctx_list_lock);
+
+	while (!list_empty(&xdev->ctx_list) && retry--)
+		msleep(wait_interval);
+
+	if (!list_empty(&xdev->ctx_list))
+		userpf_err(xdev, "failed to kill all clients");
+}
+
+int64_t xocl_hot_reset(struct xocl_dev *xdev, bool force)
+{
+	bool skip = false;
+	int64_t ret = 0, mbret = 0;
+	struct mailbox_req mbreq = { MAILBOX_REQ_HOT_RESET, };
+	size_t resplen = sizeof(ret);
+
+	mutex_lock(&xdev->ctx_list_lock);
+	if (xdev->offline) {
+		skip = true;
+	} else if (!force && !list_is_singular(&xdev->ctx_list)) {
+		/* We should have one context for ourselves. */
+		BUG_ON(list_empty(&xdev->ctx_list));
+		userpf_err(xdev, "device is in use, can't reset");
+		ret = -EBUSY;
+	} else {
+		xdev->offline = true;
+	}
+	mutex_unlock(&xdev->ctx_list_lock);
+	if (ret < 0 || skip)
+		return ret;
+
+	userpf_info(xdev, "resetting device...");
+
+	if (force)
+		kill_all_clients(xdev);
+
+	xocl_reset_notify(xdev->core.pdev, true);
+	mbret = xocl_peer_request(xdev, &mbreq, sizeof(struct mailbox_req), &ret, &resplen, NULL, NULL);
+	if (mbret)
+		ret = mbret;
+	xocl_reset_notify(xdev->core.pdev, false);
+
+	mutex_lock(&xdev->ctx_list_lock);
+	xdev->offline = false;
+	mutex_unlock(&xdev->ctx_list_lock);
+
+	return ret;
+}
+
+
+int xocl_reclock(struct xocl_dev *xdev, void *data)
+{
+	int err = 0;
+	int64_t msg = -ENODEV;
+	struct mailbox_req *req = NULL;
+	size_t resplen = sizeof(msg);
+	size_t reqlen = sizeof(struct mailbox_req)+sizeof(struct drm_xocl_reclock_info);
+
+	req = kzalloc(reqlen, GFP_KERNEL);
+	req->req = MAILBOX_REQ_RECLOCK;
+	req->data_total_len = sizeof(struct drm_xocl_reclock_info);
+	memcpy(req->data, data, sizeof(struct drm_xocl_reclock_info));
+
+	err = xocl_peer_request(xdev, req, reqlen,
+		&msg, &resplen, NULL, NULL);
+
+	if (msg != 0)
+		err = -ENODEV;
+
+	kfree(req);
+	return err;
+}
+
+static void xocl_mailbox_srv(void *arg, void *data, size_t len,
+	u64 msgid, int err)
+{
+	struct xocl_dev *xdev = (struct xocl_dev *)arg;
+	struct mailbox_req *req = (struct mailbox_req *)data;
+
+	if (err != 0)
+		return;
+
+	userpf_info(xdev, "received request (%d) from peer\n", req->req);
+
+	switch (req->req) {
+	case MAILBOX_REQ_FIREWALL:
+		(void) xocl_hot_reset(xdev, true);
+		break;
+	default:
+		userpf_err(xdev, "dropped bad request (%d)\n", req->req);
+		break;
+	}
+}
+
+void get_pcie_link_info(struct xocl_dev *xdev,
+	unsigned short *link_width, unsigned short *link_speed, bool is_cap)
+{
+	u16 stat;
+	long result;
+	int pos = is_cap ? PCI_EXP_LNKCAP : PCI_EXP_LNKSTA;
+
+	result = pcie_capability_read_word(xdev->core.pdev, pos, &stat);
+	if (result) {
+		*link_width = *link_speed = 0;
+		xocl_info(&xdev->core.pdev->dev, "Read pcie capability failed");
+		return;
+	}
+	*link_width = (stat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
+	*link_speed = stat & PCI_EXP_LNKSTA_CLS;
+}
+
+void user_pci_reset_prepare(struct pci_dev *pdev)
+{
+	xocl_reset_notify(pdev, true);
+}
+
+void user_pci_reset_done(struct pci_dev *pdev)
+{
+	xocl_reset_notify(pdev, false);
+}
+
+static void xocl_dev_percpu_release(struct percpu_ref *ref)
+{
+	struct xocl_dev *xdev = container_of(ref, struct xocl_dev, ref);
+
+	complete(&xdev->cmp);
+}
+
+static void xocl_dev_percpu_exit(void *data)
+{
+	struct percpu_ref *ref = data;
+	struct xocl_dev *xdev = container_of(ref, struct xocl_dev, ref);
+
+	wait_for_completion(&xdev->cmp);
+	percpu_ref_exit(ref);
+}
+
+
+static void xocl_dev_percpu_kill(void *data)
+{
+	struct percpu_ref *ref = data;
+
+	percpu_ref_kill(ref);
+}
+
+void xocl_p2p_mem_release(struct xocl_dev *xdev, bool recov_bar_sz)
+{
+	struct pci_dev *pdev = xdev->core.pdev;
+	int p2p_bar = -1;
+
+	if (xdev->p2p_bar_addr) {
+		devres_release_group(&pdev->dev, xdev->p2p_res_grp);
+		xdev->p2p_bar_addr = NULL;
+		xdev->p2p_res_grp = NULL;
+	}
+	if (xdev->p2p_res_grp) {
+		devres_remove_group(&pdev->dev, xdev->p2p_res_grp);
+		xdev->p2p_res_grp = NULL;
+	}
+
+	if (recov_bar_sz) {
+		p2p_bar = xocl_get_p2p_bar(xdev, NULL);
+		if (p2p_bar < 0)
+			return;
+
+		xocl_pci_resize_resource(pdev, p2p_bar,
+				(XOCL_PA_SECTION_SHIFT - 20));
+
+		xocl_info(&pdev->dev, "Resize p2p bar %d to %d M ", p2p_bar,
+			(1 << XOCL_PA_SECTION_SHIFT));
+	}
+}
+
+int xocl_p2p_mem_reserve(struct xocl_dev *xdev)
+{
+	resource_size_t p2p_bar_addr;
+	resource_size_t p2p_bar_len;
+	struct resource res;
+	uint32_t p2p_bar_idx;
+	struct pci_dev *pdev = xdev->core.pdev;
+	int32_t ret;
+
+	xocl_info(&pdev->dev, "reserve p2p mem, bar %d, len %lld",
+			xdev->p2p_bar_idx, xdev->p2p_bar_len);
+
+	if (xdev->p2p_bar_idx < 0 ||
+		xdev->p2p_bar_len <= (1<<XOCL_PA_SECTION_SHIFT)) {
+		/* only p2p_bar_len > SECTION (256MB) */
+		xocl_info(&pdev->dev, "Did not find p2p BAR");
+		return 0;
+	}
+
+	p2p_bar_len = xdev->p2p_bar_len;
+	p2p_bar_idx = xdev->p2p_bar_idx;
+
+	xdev->p2p_res_grp = devres_open_group(&pdev->dev, NULL, GFP_KERNEL);
+	if (!xdev->p2p_res_grp) {
+		xocl_err(&pdev->dev, "open p2p resource group failed");
+		ret = -ENOMEM;
+		goto failed;
+	}
+
+	p2p_bar_addr = pci_resource_start(pdev, p2p_bar_idx);
+
+	res.start = p2p_bar_addr;
+	res.end	  = p2p_bar_addr+p2p_bar_len-1;
+	res.name  = NULL;
+	res.flags = IORESOURCE_MEM;
+
+	init_completion(&xdev->cmp);
+
+	ret = percpu_ref_init(&xdev->ref, xocl_dev_percpu_release, 0,
+		GFP_KERNEL);
+	if (ret)
+		goto failed;
+
+	ret = devm_add_action_or_reset(&(pdev->dev), xocl_dev_percpu_exit,
+		&xdev->ref);
+	if (ret)
+		goto failed;
+
+	xdev->pgmap.ref = &xdev->ref;
+	memcpy(&xdev->pgmap.res, &res, sizeof(struct resource));
+	xdev->pgmap.altmap_valid = false;
+	xdev->p2p_bar_addr = devm_memremap_pages(&(pdev->dev), &xdev->pgmap);
+
+	if (!xdev->p2p_bar_addr) {
+		ret = -ENOMEM;
+		percpu_ref_kill(&xdev->ref);
+		devres_close_group(&pdev->dev, xdev->p2p_res_grp);
+		goto failed;
+	}
+
+	ret = devm_add_action_or_reset(&(pdev->dev), xocl_dev_percpu_kill,
+				       &xdev->ref);
+	if (ret) {
+		percpu_ref_kill(&xdev->ref);
+		devres_close_group(&pdev->dev, xdev->p2p_res_grp);
+		goto failed;
+	}
+
+	devres_close_group(&pdev->dev, xdev->p2p_res_grp);
+
+	return 0;
+
+failed:
+	xocl_p2p_mem_release(xdev, false);
+
+	return ret;
+}
+
+static inline u64 xocl_pci_rebar_size_to_bytes(int size)
+{
+	return 1ULL << (size + 20);
+}
+
+int xocl_get_p2p_bar(struct xocl_dev *xdev, u64 *bar_size)
+{
+	struct pci_dev *dev = xdev->core.pdev;
+	int i, pos;
+	u32 cap, ctrl, size;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_REBAR);
+	if (!pos) {
+		xocl_err(&dev->dev, "did not find rebar cap");
+		return -ENOTSUPP;
+	}
+
+	pos += REBAR_FIRST_CAP;
+	for (i = PCI_STD_RESOURCES; i <= PCI_STD_RESOURCE_END; i++) {
+		pci_read_config_dword(dev, pos, &cap);
+		pci_read_config_dword(dev, pos + 4, &ctrl);
+		size = (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >>
+			PCI_REBAR_CTRL_BAR_SHIFT;
+		if (xocl_pci_rebar_size_to_bytes(size) >=
+			(1 << XOCL_PA_SECTION_SHIFT) &&
+			cap >= 0x1000) {
+			if (bar_size)
+				*bar_size = xocl_pci_rebar_size_to_bytes(size);
+			return i;
+		}
+		pos += 8;
+	}
+
+	if (bar_size)
+		*bar_size = 0;
+
+	return -1;
+}
+
+static int xocl_reassign_resources(struct pci_dev *dev, int resno)
+{
+	pci_assign_unassigned_bus_resources(dev->bus);
+
+	return 0;
+}
+
+int xocl_pci_resize_resource(struct pci_dev *dev, int resno, int size)
+{
+	struct resource *res = dev->resource + resno;
+	struct pci_dev *root;
+	struct resource *root_res;
+	u64 bar_size, req_size;
+	unsigned long flags;
+	u16 cmd;
+	int pos, ret = 0;
+	u32 ctrl, i;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_REBAR);
+	if (!pos) {
+		xocl_err(&dev->dev, "did not find rebar cap");
+		return -ENOTSUPP;
+	}
+
+	pos += resno * PCI_REBAR_CTRL;
+	pci_read_config_dword(dev, pos + PCI_REBAR_CTRL, &ctrl);
+
+	bar_size = xocl_pci_rebar_size_to_bytes(
+			(ctrl & PCI_REBAR_CTRL_BAR_SIZE) >>
+			PCI_REBAR_CTRL_BAR_SHIFT);
+	req_size = xocl_pci_rebar_size_to_bytes(size);
+
+	xocl_info(&dev->dev, "req_size %lld, bar size %lld\n",
+			req_size, bar_size);
+	if (req_size == bar_size) {
+		xocl_info(&dev->dev, "same size, return success");
+		return -EALREADY;
+	}
+
+	xocl_get_root_dev(dev, root);
+
+	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
+		root_res = root->subordinate->resource[i];
+		root_res = (root_res) ? root_res->parent : NULL;
+		if (root_res && (root_res->flags & IORESOURCE_MEM)
+			&& resource_size(root_res) > req_size)
+			break;
+	}
+
+	if (i == PCI_BRIDGE_RESOURCE_NUM) {
+		xocl_err(&dev->dev, "Not enough IO Mem space, Please check BIOS settings. ");
+		return -ENOSPC;
+	}
+	pci_release_selected_regions(dev, (1 << resno));
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	pci_write_config_word(dev, PCI_COMMAND,
+		cmd & ~PCI_COMMAND_MEMORY);
+
+	flags = res->flags;
+	if (res->parent)
+		release_resource(res);
+
+	ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
+	ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
+	pci_write_config_dword(dev, pos + PCI_REBAR_CTRL, ctrl);
+
+
+	res->start = 0;
+	res->end = req_size - 1;
+
+	xocl_info(&dev->dev, "new size %lld", resource_size(res));
+	xocl_reassign_resources(dev, resno);
+	res->flags = flags;
+
+	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
+	pci_request_selected_regions(dev, (1 << resno),
+		XOCL_MODULE_NAME);
+
+	return ret;
+}
+
+static int identify_bar(struct xocl_dev *xdev)
+{
+	struct pci_dev *pdev = xdev->core.pdev;
+	resource_size_t bar_len;
+	int		i;
+
+	for (i = PCI_STD_RESOURCES; i <= PCI_STD_RESOURCE_END; i++) {
+		bar_len = pci_resource_len(pdev, i);
+		if (bar_len >= (1 << XOCL_PA_SECTION_SHIFT)) {
+			xdev->p2p_bar_idx = i;
+			xdev->p2p_bar_len = bar_len;
+			pci_request_selected_regions(pdev, 1 << i,
+				XOCL_MODULE_NAME);
+		} else if (bar_len >= 32 * 1024 * 1024) {
+			xdev->core.bar_addr = ioremap_nocache(
+				pci_resource_start(pdev, i), bar_len);
+			if (!xdev->core.bar_addr)
+				return -EIO;
+			xdev->core.bar_idx = i;
+			xdev->core.bar_size = bar_len;
+		}
+	}
+
+	return 0;
+}
+
+static void unmap_bar(struct xocl_dev *xdev)
+{
+	if (xdev->core.bar_addr) {
+		iounmap(xdev->core.bar_addr);
+		xdev->core.bar_addr = NULL;
+	}
+
+	if (xdev->p2p_bar_len)
+		pci_release_selected_regions(xdev->core.pdev,
+				1 << xdev->p2p_bar_idx);
+}
+
+/* pci driver callbacks */
+int xocl_userpf_probe(struct pci_dev *pdev,
+		const struct pci_device_id *ent)
+{
+	struct xocl_dev			*xdev;
+	struct xocl_board_private	*dev_info;
+	int				ret;
+
+	xdev = devm_kzalloc(&pdev->dev, sizeof(*xdev), GFP_KERNEL);
+	if (!xdev) {
+		xocl_err(&pdev->dev, "failed to alloc xocl_dev");
+		return -ENOMEM;
+	}
+
+	/* this is used for all subdevs, bind it to device earlier */
+	pci_set_drvdata(pdev, xdev);
+	dev_info = (struct xocl_board_private *)ent->driver_data;
+
+	xdev->core.pci_ops = &userpf_pci_ops;
+	xdev->core.pdev = pdev;
+	xocl_fill_dsa_priv(xdev, dev_info);
+
+	ret = identify_bar(xdev);
+	if (ret) {
+		xocl_err(&pdev->dev, "failed to identify bar");
+		goto failed_to_bar;
+	}
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		xocl_err(&pdev->dev, "failed to enable device.");
+		goto failed_to_enable;
+	}
+
+	ret = xocl_alloc_dev_minor(xdev);
+	if (ret)
+		goto failed_alloc_minor;
+
+	ret = xocl_subdev_create_all(xdev, dev_info->subdev_info,
+			dev_info->subdev_num);
+	if (ret) {
+		xocl_err(&pdev->dev, "failed to register subdevs");
+		goto failed_create_subdev;
+	}
+
+	ret = xocl_p2p_mem_reserve(xdev);
+	if (ret)
+		xocl_err(&pdev->dev, "failed to reserve p2p memory region");
+
+	ret = xocl_init_sysfs(&pdev->dev);
+	if (ret) {
+		xocl_err(&pdev->dev, "failed to init sysfs");
+		goto failed_init_sysfs;
+	}
+
+	mutex_init(&xdev->ctx_list_lock);
+	xdev->needs_reset = false;
+	atomic64_set(&xdev->total_execs, 0);
+	atomic_set(&xdev->outstanding_execs, 0);
+	INIT_LIST_HEAD(&xdev->ctx_list);
+
+	/* Launch the mailbox server. */
+	(void) xocl_peer_listen(xdev, xocl_mailbox_srv, (void *)xdev);
+
+	return 0;
+
+failed_init_sysfs:
+	xocl_p2p_mem_release(xdev, false);
+	xocl_subdev_destroy_all(xdev);
+
+failed_create_subdev:
+	xocl_free_dev_minor(xdev);
+
+failed_alloc_minor:
+	pci_disable_device(pdev);
+failed_to_enable:
+	unmap_bar(xdev);
+failed_to_bar:
+	devm_kfree(&pdev->dev, xdev);
+	pci_set_drvdata(pdev, NULL);
+
+	return ret;
+}
+
+void xocl_userpf_remove(struct pci_dev *pdev)
+{
+	struct xocl_dev		*xdev;
+
+	xdev = pci_get_drvdata(pdev);
+	if (!xdev) {
+		xocl_err(&pdev->dev, "driver data is NULL");
+		return;
+	}
+
+	xocl_p2p_mem_release(xdev, false);
+	xocl_subdev_destroy_all(xdev);
+
+	xocl_fini_sysfs(&pdev->dev);
+	xocl_free_dev_minor(xdev);
+
+	pci_disable_device(pdev);
+
+	unmap_bar(xdev);
+
+	mutex_destroy(&xdev->ctx_list_lock);
+
+	pci_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, xdev);
+}
+
+static pci_ers_result_t user_pci_error_detected(struct pci_dev *pdev,
+		pci_channel_state_t state)
+{
+	switch (state) {
+	case pci_channel_io_normal:
+		xocl_info(&pdev->dev, "PCI normal state error\n");
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_frozen:
+		xocl_info(&pdev->dev, "PCI frozen state error\n");
+		return PCI_ERS_RESULT_NEED_RESET;
+	case pci_channel_io_perm_failure:
+		xocl_info(&pdev->dev, "PCI failure state error\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	default:
+		xocl_info(&pdev->dev, "PCI unknown state (%d) error\n", state);
+		break;
+	}
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t user_pci_slot_reset(struct pci_dev *pdev)
+{
+	xocl_info(&pdev->dev, "PCI reset slot");
+	pci_restore_state(pdev);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void user_pci_error_resume(struct pci_dev *pdev)
+{
+	xocl_info(&pdev->dev, "PCI error resume");
+	pci_cleanup_aer_uncorrect_error_status(pdev);
+}
+
+static const struct pci_error_handlers xocl_err_handler = {
+	.error_detected	= user_pci_error_detected,
+	.slot_reset	= user_pci_slot_reset,
+	.resume		= user_pci_error_resume,
+	.reset_prepare	= user_pci_reset_prepare,
+	.reset_done	= user_pci_reset_done,
+};
+
+static struct pci_driver userpf_driver = {
+	.name = XOCL_MODULE_NAME,
+	.id_table = pciidlist,
+	.probe = xocl_userpf_probe,
+	.remove = xocl_userpf_remove,
+	.err_handler = &xocl_err_handler,
+};
+
+/* INIT */
+static int (*xocl_drv_reg_funcs[])(void) __initdata = {
+	xocl_init_feature_rom,
+	xocl_init_xdma,
+	xocl_init_mb_scheduler,
+	xocl_init_mailbox,
+	xocl_init_xmc,
+	xocl_init_icap,
+	xocl_init_xvc,
+};
+
+static void (*xocl_drv_unreg_funcs[])(void) = {
+	xocl_fini_feature_rom,
+	xocl_fini_xdma,
+	xocl_fini_mb_scheduler,
+	xocl_fini_mailbox,
+	xocl_fini_xmc,
+	xocl_fini_icap,
+	xocl_fini_xvc,
+};
+
+static int __init xocl_init(void)
+{
+	int		ret, i;
+
+	xrt_class = class_create(THIS_MODULE, "xrt_user");
+	if (IS_ERR(xrt_class)) {
+		ret = PTR_ERR(xrt_class);
+		goto err_class_create;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(xocl_drv_reg_funcs); ++i) {
+		ret = xocl_drv_reg_funcs[i]();
+		if (ret)
+			goto failed;
+	}
+
+	ret = pci_register_driver(&userpf_driver);
+	if (ret)
+		goto failed;
+
+	return 0;
+
+failed:
+	for (i--; i >= 0; i--)
+		xocl_drv_unreg_funcs[i]();
+
+	class_destroy(xrt_class);
+	xrt_class = NULL;
+
+err_class_create:
+	return ret;
+}
+
+static void __exit xocl_exit(void)
+{
+	int i;
+
+	pci_unregister_driver(&userpf_driver);
+
+	for (i = ARRAY_SIZE(xocl_drv_unreg_funcs) - 1; i >= 0; i--)
+		xocl_drv_unreg_funcs[i]();
+
+	class_destroy(xrt_class);
+	xrt_class = NULL;
+}
+
+module_init(xocl_init);
+module_exit(xocl_exit);
+
+MODULE_VERSION(XRT_DRIVER_VERSION);
+
+MODULE_DESCRIPTION(XOCL_DRIVER_DESC);
+MODULE_AUTHOR("Lizhi Hou <lizhi.hou@xilinx.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpu/drm/xocl/userpf/xocl_ioctl.c b/drivers/gpu/drm/xocl/userpf/xocl_ioctl.c
new file mode 100644
index 000000000000..665ecb0e27ac
--- /dev/null
+++ b/drivers/gpu/drm/xocl/userpf/xocl_ioctl.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2016-2018 Xilinx, Inc. All rights reserved.
+ *
+ * Authors: Sonal Santan
+ *
+ */
+
+#include <linux/version.h>
+#include <drm/drmP.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_mm.h>
+#include <linux/eventfd.h>
+#include <linux/uuid.h>
+#include <linux/hashtable.h>
+#include "../version.h"
+#include "common.h"
+
+int xocl_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
+{
+	struct drm_xocl_info *obj = data;
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+	struct pci_dev *pdev = xdev->core.pdev;
+	u32 major, minor, patch;
+
+	userpf_info(xdev, "INFO IOCTL");
+
+	if (sscanf(XRT_DRIVER_VERSION, "%d.%d.%d", &major, &minor, &patch) != 3)
+		return -ENODEV;
+
+	obj->vendor = pdev->vendor;
+	obj->device = pdev->device;
+	obj->subsystem_vendor = pdev->subsystem_vendor;
+	obj->subsystem_device = pdev->subsystem_device;
+	obj->driver_version = XOCL_DRV_VER_NUM(major, minor, patch);
+	obj->pci_slot = PCI_SLOT(pdev->devfn);
+
+	return 0;
+}
+
+int xocl_execbuf_ioctl(struct drm_device *dev,
+	void *data, struct drm_file *filp)
+{
+	struct xocl_drm *drm_p = dev->dev_private;
+	int ret = 0;
+
+	ret = xocl_exec_client_ioctl(drm_p->xdev,
+		       DRM_XOCL_EXECBUF, data, filp);
+
+	return ret;
+}
+
+/*
+ * Create a context (only shared supported today) on a CU. Take a lock on xclbin if
+ * it has not been acquired before. Shared the same lock for all context requests
+ * for that process
+ */
+int xocl_ctx_ioctl(struct drm_device *dev, void *data,
+		   struct drm_file *filp)
+{
+	struct xocl_drm *drm_p = dev->dev_private;
+	int ret = 0;
+
+	ret = xocl_exec_client_ioctl(drm_p->xdev,
+		       DRM_XOCL_CTX, data, filp);
+
+	return ret;
+}
+
+int xocl_user_intr_ioctl(struct drm_device *dev, void *data,
+			 struct drm_file *filp)
+{
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+	struct drm_xocl_user_intr *args = data;
+	int	ret = 0;
+
+	xocl_info(dev->dev, "USER INTR ioctl");
+
+	if (args->fd < 0)
+		return -EINVAL;
+
+	xocl_dma_intr_register(xdev, args->msix, NULL, NULL, args->fd);
+	xocl_dma_intr_config(xdev, args->msix, true);
+
+	return ret;
+}
+
+char *kind_to_string(enum axlf_section_kind kind)
+{
+	switch (kind) {
+	case 0:	 return "BITSTREAM";
+	case 1:	 return "CLEARING_BITSTREAM";
+	case 2:	 return "EMBEDDED_METADATA";
+	case 3:	 return "FIRMWARE";
+	case 4:	 return "DEBUG_DATA";
+	case 5:	 return "SCHED_FIRMWARE";
+	case 6:	 return "MEM_TOPOLOGY";
+	case 7:	 return "CONNECTIVITY";
+	case 8:	 return "IP_LAYOUT";
+	case 9:	 return "DEBUG_IP_LAYOUT";
+	case 10: return "DESIGN_CHECK_POINT";
+	case 11: return "CLOCK_FREQ_TOPOLOGY";
+	default: return "UNKNOWN";
+	}
+}
+
+/* should be obsoleted after mailbox implememted */
+static const struct axlf_section_header *
+get_axlf_section(const struct axlf *top, enum axlf_section_kind kind)
+{
+	int i = 0;
+
+	DRM_INFO("Finding %s section header", kind_to_string(kind));
+	for (i = 0; i < top->m_header.m_numSections; i++) {
+		if (top->m_sections[i].m_sectionKind == kind)
+			return &top->m_sections[i];
+	}
+	DRM_INFO("Did not find AXLF section %s", kind_to_string(kind));
+	return NULL;
+}
+
+static int
+xocl_check_section(const struct axlf_section_header *header, uint64_t len,
+		enum axlf_section_kind kind)
+{
+	uint64_t offset;
+	uint64_t size;
+
+	DRM_INFO("Section %s details:", kind_to_string(kind));
+	DRM_INFO("  offset = 0x%llx", header->m_sectionOffset);
+	DRM_INFO("  size = 0x%llx", header->m_sectionSize);
+
+	offset = header->m_sectionOffset;
+	size = header->m_sectionSize;
+	if (offset + size <= len)
+		return 0;
+
+	DRM_INFO("Section %s extends beyond xclbin boundary 0x%llx\n",
+			kind_to_string(kind), len);
+	return -EINVAL;
+}
+
+/* Return value: Negative for error, or the size in bytes has been copied */
+static int
+xocl_read_sect(enum axlf_section_kind kind, void **sect, struct axlf *axlf_full)
+{
+	const struct axlf_section_header *memHeader;
+	uint64_t xclbin_len;
+	uint64_t offset;
+	uint64_t size;
+	int err = 0;
+
+	memHeader = get_axlf_section(axlf_full, kind);
+	if (!memHeader)
+		return 0;
+
+	xclbin_len = axlf_full->m_header.m_length;
+	err = xocl_check_section(memHeader, xclbin_len, kind);
+	if (err)
+		return err;
+
+	offset = memHeader->m_sectionOffset;
+	size = memHeader->m_sectionSize;
+	*sect = &((char *)axlf_full)[offset];
+
+	return size;
+}
+
+/*
+ * Should be called with xdev->ctx_list_lock held
+ */
+static uint live_client_size(struct xocl_dev *xdev)
+{
+	const struct list_head *ptr;
+	const struct client_ctx *entry;
+	uint count = 0;
+
+	BUG_ON(!mutex_is_locked(&xdev->ctx_list_lock));
+
+	list_for_each(ptr, &xdev->ctx_list) {
+		entry = list_entry(ptr, struct client_ctx, link);
+		count++;
+	}
+	return count;
+}
+
+static int
+xocl_read_axlf_helper(struct xocl_drm *drm_p, struct drm_xocl_axlf *axlf_ptr)
+{
+	long err = 0;
+	struct axlf *axlf = 0;
+	struct axlf bin_obj;
+	size_t size;
+	int preserve_mem = 0;
+	struct mem_topology *new_topology = NULL, *topology;
+	struct xocl_dev *xdev = drm_p->xdev;
+	uuid_t *xclbin_id;
+
+	userpf_info(xdev, "READ_AXLF IOCTL\n");
+
+	if (!xocl_is_unified(xdev)) {
+		userpf_info(xdev, "XOCL: not unified dsa");
+		return err;
+	}
+
+	if (copy_from_user(&bin_obj, axlf_ptr->xclbin, sizeof(struct axlf)))
+		return -EFAULT;
+
+	if (memcmp(bin_obj.m_magic, "xclbin2", 8))
+		return -EINVAL;
+
+	if (xocl_xrt_version_check(xdev, &bin_obj, true))
+		return -EINVAL;
+
+	if (uuid_is_null(&bin_obj.m_header.uuid)) {
+		// Legacy xclbin, convert legacy id to new id
+		memcpy(&bin_obj.m_header.uuid, &bin_obj.m_header.m_timeStamp, 8);
+	}
+
+	xclbin_id = (uuid_t *)xocl_icap_get_data(xdev, XCLBIN_UUID);
+	if (!xclbin_id)
+		return -EINVAL;
+	/*
+	 * Support for multiple processes
+	 * 1. We lock &xdev->ctx_list_lock so no new contexts can be opened and no live contexts
+	 *    can be closed
+	 * 2. If more than one context exists -- more than one clients are connected -- we cannot
+	 *    swap the xclbin return -EPERM
+	 * 3. If no live contexts exist there may still be sumbitted exec BOs from a
+	 *    previous context (which was subsequently closed), hence we check for exec BO count.
+	 *    If exec BO are outstanding we return -EBUSY
+	 */
+	if (!uuid_equal(xclbin_id, &bin_obj.m_header.uuid)) {
+		if (atomic_read(&xdev->outstanding_execs)) {
+			userpf_err(xdev, "Current xclbin is busy, can't change\n");
+			return -EBUSY;
+		}
+	}
+
+	//Ignore timestamp matching for AWS platform
+	if (!xocl_is_aws(xdev) && !xocl_verify_timestamp(xdev,
+		bin_obj.m_header.m_featureRomTimeStamp)) {
+		userpf_err(xdev, "TimeStamp of ROM did not match Xclbin\n");
+		return -EINVAL;
+	}
+
+	userpf_info(xdev, "XOCL: VBNV and TimeStamps matched\n");
+
+	if (uuid_equal(xclbin_id, &bin_obj.m_header.uuid)) {
+		userpf_info(xdev, "Skipping repopulating topology, connectivity,ip_layout data\n");
+		goto done;
+	}
+
+	//Copy from user space and proceed.
+	axlf = vmalloc(bin_obj.m_header.m_length);
+	if (!axlf) {
+		userpf_err(xdev, "Unable to create axlf\n");
+		err = -ENOMEM;
+		goto done;
+	}
+
+	if (copy_from_user(axlf, axlf_ptr->xclbin, bin_obj.m_header.m_length)) {
+		err = -EFAULT;
+		goto done;
+	}
+
+	/* Populating MEM_TOPOLOGY sections. */
+	size = xocl_read_sect(MEM_TOPOLOGY, (void **)&new_topology, axlf);
+	if (size <= 0) {
+		if (size != 0)
+			goto done;
+	} else if (sizeof_sect(new_topology, m_mem_data) != size) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	topology = XOCL_MEM_TOPOLOGY(xdev);
+
+	/*
+	 * Compare MEM_TOPOLOGY previous vs new.
+	 * Ignore this and keep disable preserve_mem if not for aws.
+	 */
+	if (xocl_is_aws(xdev) && (topology != NULL)) {
+		if ((size == sizeof_sect(topology, m_mem_data)) &&
+		    !memcmp(new_topology, topology, size)) {
+			xocl_xdev_info(xdev, "MEM_TOPOLOGY match, preserve mem_topology.");
+			preserve_mem = 1;
+		} else {
+			xocl_xdev_info(xdev, "MEM_TOPOLOGY mismatch, do not preserve mem_topology.");
+		}
+	}
+
+	/* Switching the xclbin, make sure none of the buffers are used. */
+	if (!preserve_mem) {
+		err = xocl_check_topology(drm_p);
+		if (err)
+			goto done;
+		xocl_cleanup_mem(drm_p);
+	}
+
+	err = xocl_icap_download_axlf(xdev, axlf);
+	if (err) {
+		userpf_err(xdev, "%s Fail to download\n", __func__);
+		/*
+		 * Don't just bail out here, always recreate drm mem
+		 * since we have cleaned it up before download.
+		 */
+	}
+
+	if (!preserve_mem) {
+		int rc = xocl_init_mem(drm_p);
+
+		if (err == 0)
+			err = rc;
+	}
+
+done:
+	if (size < 0)
+		err = size;
+	if (err)
+		userpf_err(xdev, "err: %ld\n", err);
+	else
+		userpf_info(xdev, "Loaded xclbin %pUb", xclbin_id);
+	vfree(axlf);
+	return err;
+}
+
+int xocl_read_axlf_ioctl(struct drm_device *dev,
+			 void *data,
+			 struct drm_file *filp)
+{
+	struct drm_xocl_axlf *axlf_obj_ptr = data;
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+	struct client_ctx *client = filp->driver_priv;
+	int err = 0;
+	uuid_t *xclbin_id;
+
+	mutex_lock(&xdev->ctx_list_lock);
+	err = xocl_read_axlf_helper(drm_p, axlf_obj_ptr);
+	/*
+	 * Record that user land configured this context for current device xclbin
+	 * It doesn't mean that the context has a lock on the xclbin, only that
+	 * when a lock is eventually acquired it can be verified to be against to
+	 * be a lock on expected xclbin
+	 */
+	xclbin_id = (uuid_t *)xocl_icap_get_data(xdev, XCLBIN_UUID);
+	uuid_copy(&client->xclbin_id,
+			((err || !xclbin_id) ? &uuid_null : xclbin_id));
+	mutex_unlock(&xdev->ctx_list_lock);
+	return err;
+}
+
+uint get_live_client_size(struct xocl_dev *xdev)
+{
+	uint count;
+
+	mutex_lock(&xdev->ctx_list_lock);
+	count = live_client_size(xdev);
+	mutex_unlock(&xdev->ctx_list_lock);
+	return count;
+}
+
+void reset_notify_client_ctx(struct xocl_dev *xdev)
+{
+	xdev->needs_reset = false;
+//	wmb();
+}
+
+int xocl_hot_reset_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp)
+{
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+
+	int err = xocl_hot_reset(xdev, false);
+
+	userpf_info(xdev, "%s err: %d\n", __func__, err);
+	return err;
+}
+
+int xocl_reclock_ioctl(struct drm_device *dev, void *data,
+	struct drm_file *filp)
+{
+	struct xocl_drm *drm_p = dev->dev_private;
+	struct xocl_dev *xdev = drm_p->xdev;
+	int err = xocl_reclock(xdev, data);
+
+	userpf_info(xdev, "%s err: %d\n", __func__, err);
+	return err;
+}
diff --git a/drivers/gpu/drm/xocl/userpf/xocl_sysfs.c b/drivers/gpu/drm/xocl/userpf/xocl_sysfs.c
new file mode 100644
index 000000000000..fccb27906897
--- /dev/null
+++ b/drivers/gpu/drm/xocl/userpf/xocl_sysfs.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * A GEM style device manager for PCIe based OpenCL accelerators.
+ *
+ * Copyright (C) 2016-2019 Xilinx, Inc. All rights reserved.
+ *
+ * Authors: Lizhi.Hou@xilinx.com
+ *
+ */
+#include "common.h"
+
+//Attributes followed by bin_attributes.
+//
+/* -Attributes -- */
+
+/* -xclbinuuid-- (supersedes xclbinid) */
+static ssize_t xclbinuuid_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_dev *xdev = dev_get_drvdata(dev);
+	uuid_t *xclbin_id;
+
+	xclbin_id = (uuid_t *)xocl_icap_get_data(xdev, XCLBIN_UUID);
+	return sprintf(buf, "%pUb\n", xclbin_id ? xclbin_id : 0);
+}
+
+static DEVICE_ATTR_RO(xclbinuuid);
+
+/* -userbar-- */
+static ssize_t userbar_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_dev *xdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", xdev->core.bar_idx);
+}
+
+static DEVICE_ATTR_RO(userbar);
+
+static ssize_t user_pf_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	// The existence of entry indicates user function.
+	return sprintf(buf, "%s", "");
+}
+static DEVICE_ATTR_RO(user_pf);
+
+/* -live client contects-- */
+static ssize_t kdsstat_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_dev *xdev = dev_get_drvdata(dev);
+	int size;
+	uuid_t *xclbin_id;
+
+	xclbin_id = (uuid_t *)xocl_icap_get_data(xdev, XCLBIN_UUID);
+	size = sprintf(buf,
+			   "xclbin:\t\t\t%pUb\noutstanding execs:\t%d\ntotal execs:\t\t%lld\ncontexts:\t\t%d\n",
+			   xclbin_id ? xclbin_id : 0,
+			   atomic_read(&xdev->outstanding_execs),
+			   atomic64_read(&xdev->total_execs),
+			   get_live_client_size(xdev));
+	return size;
+}
+static DEVICE_ATTR_RO(kdsstat);
+
+static ssize_t xocl_mm_stat(struct xocl_dev *xdev, char *buf, bool raw)
+{
+	int i;
+	ssize_t count = 0;
+	ssize_t size = 0;
+	size_t memory_usage = 0;
+	unsigned int bo_count = 0;
+	const char *txt_fmt = "[%s] %s@0x%012llx (%lluMB): %lluKB %dBOs\n";
+	const char *raw_fmt = "%llu %d\n";
+	struct mem_topology *topo = NULL;
+	struct drm_xocl_mm_stat stat;
+	void *drm_hdl;
+
+	drm_hdl = xocl_dma_get_drm_handle(xdev);
+	if (!drm_hdl)
+		return -EINVAL;
+
+	mutex_lock(&xdev->ctx_list_lock);
+
+	topo = XOCL_MEM_TOPOLOGY(xdev);
+	if (!topo) {
+		mutex_unlock(&xdev->ctx_list_lock);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < topo->m_count; i++) {
+		xocl_mm_get_usage_stat(drm_hdl, i, &stat);
+
+		if (raw) {
+			memory_usage = 0;
+			bo_count = 0;
+			memory_usage = stat.memory_usage;
+			bo_count = stat.bo_count;
+
+			count = sprintf(buf, raw_fmt,
+				memory_usage,
+				bo_count);
+		} else {
+			count = sprintf(buf, txt_fmt,
+				topo->m_mem_data[i].m_used ?
+				"IN-USE" : "UNUSED",
+				topo->m_mem_data[i].m_tag,
+				topo->m_mem_data[i].m_base_address,
+				topo->m_mem_data[i].m_size / 1024,
+				stat.memory_usage / 1024,
+				stat.bo_count);
+		}
+		buf += count;
+		size += count;
+	}
+	mutex_unlock(&xdev->ctx_list_lock);
+	return size;
+}
+
+/* -live memory usage-- */
+static ssize_t memstat_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_dev *xdev = dev_get_drvdata(dev);
+
+	return xocl_mm_stat(xdev, buf, false);
+}
+static DEVICE_ATTR_RO(memstat);
+
+static ssize_t memstat_raw_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct xocl_dev *xdev = dev_get_drvdata(dev);
+
+	return xocl_mm_stat(xdev, buf, true);
+}
+static DEVICE_ATTR_RO(memstat_raw);
+
+static ssize_t p2p_enable_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct xocl_dev *xdev = dev_get_drvdata(dev);
+	u64 size;
+
+	if (xdev->p2p_bar_addr)
+		return sprintf(buf, "1\n");
+	else if (xocl_get_p2p_bar(xdev, &size) >= 0 &&
+			size > (1 << XOCL_PA_SECTION_SHIFT))
+		return sprintf(buf, "2\n");
+
+	return sprintf(buf, "0\n");
+}
+
+static ssize_t p2p_enable_store(struct device *dev,
+		struct device_attribute *da, const char *buf, size_t count)
+{
+	struct xocl_dev *xdev = dev_get_drvdata(dev);
+	struct pci_dev *pdev = xdev->core.pdev;
+	int ret, p2p_bar;
+	u32 enable;
+	u64 size;
+
+
+	if (kstrtou32(buf, 10, &enable) == -EINVAL || enable > 1)
+		return -EINVAL;
+
+	p2p_bar = xocl_get_p2p_bar(xdev, NULL);
+	if (p2p_bar < 0) {
+		xocl_err(&pdev->dev, "p2p bar is not configurable");
+		return -EACCES;
+	}
+
+	size = xocl_get_ddr_channel_size(xdev) *
+		xocl_get_ddr_channel_count(xdev); /* GB */
+	size = (ffs(size) == fls(size)) ? (fls(size) - 1) : fls(size);
+	size = enable ? (size + 10) : (XOCL_PA_SECTION_SHIFT - 20);
+	xocl_info(&pdev->dev, "Resize p2p bar %d to %d M ", p2p_bar,
+			(1 << size));
+	xocl_p2p_mem_release(xdev, false);
+
+	ret = xocl_pci_resize_resource(pdev, p2p_bar, size);
+	if (ret) {
+		xocl_err(&pdev->dev, "Failed to resize p2p BAR %d", ret);
+		goto failed;
+	}
+
+	xdev->p2p_bar_idx = p2p_bar;
+	xdev->p2p_bar_len = pci_resource_len(pdev, p2p_bar);
+
+	if (enable) {
+		ret = xocl_p2p_mem_reserve(xdev);
+		if (ret) {
+			xocl_err(&pdev->dev, "Failed to reserve p2p memory %d",
+					ret);
+		}
+	}
+
+	return count;
+
+failed:
+	return ret;
+
+}
+
+static DEVICE_ATTR(p2p_enable, 0644, p2p_enable_show, p2p_enable_store);
+
+static ssize_t dev_offline_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct xocl_dev *xdev = dev_get_drvdata(dev);
+	int val = xdev->core.offline ? 1 : 0;
+
+	return sprintf(buf, "%d\n", val);
+}
+static ssize_t dev_offline_store(struct device *dev,
+		struct device_attribute *da, const char *buf, size_t count)
+{
+	struct xocl_dev *xdev = dev_get_drvdata(dev);
+	int ret;
+	u32 offline;
+
+
+	if (kstrtou32(buf, 10, &offline) == -EINVAL || offline > 1)
+		return -EINVAL;
+
+	device_lock(dev);
+	if (offline) {
+		xocl_subdev_destroy_all(xdev);
+		xdev->core.offline = true;
+	} else {
+		ret = xocl_subdev_create_all(xdev, xdev->core.priv.subdev_info,
+				xdev->core.priv.subdev_num);
+		if (ret) {
+			xocl_err(dev, "Online subdevices failed");
+			return -EIO;
+		}
+		xdev->core.offline = false;
+	}
+	device_unlock(dev);
+
+	return count;
+}
+
+static DEVICE_ATTR(dev_offline, 0644, dev_offline_show, dev_offline_store);
+
+static ssize_t mig_calibration_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0\n");
+}
+
+static DEVICE_ATTR_RO(mig_calibration);
+
+static ssize_t link_width_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	unsigned short speed, width;
+	struct xocl_dev *xdev = dev_get_drvdata(dev);
+
+	get_pcie_link_info(xdev, &width, &speed, false);
+	return sprintf(buf, "%d\n", width);
+}
+static DEVICE_ATTR_RO(link_width);
+
+static ssize_t link_speed_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	unsigned short speed, width;
+	struct xocl_dev *xdev = dev_get_drvdata(dev);
+
+	get_pcie_link_info(xdev, &width, &speed, false);
+	return sprintf(buf, "%d\n", speed);
+}
+static DEVICE_ATTR_RO(link_speed);
+
+static ssize_t link_width_max_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	unsigned short speed, width;
+	struct xocl_dev *xdev = dev_get_drvdata(dev);
+
+	get_pcie_link_info(xdev, &width, &speed, true);
+	return sprintf(buf, "%d\n", width);
+}
+static DEVICE_ATTR_RO(link_width_max);
+
+static ssize_t link_speed_max_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	unsigned short speed, width;
+	struct xocl_dev *xdev = dev_get_drvdata(dev);
+
+	get_pcie_link_info(xdev, &width, &speed, true);
+	return sprintf(buf, "%d\n", speed);
+}
+static DEVICE_ATTR_RO(link_speed_max);
+/* - End attributes-- */
+
+static struct attribute *xocl_attrs[] = {
+	&dev_attr_xclbinuuid.attr,
+	&dev_attr_userbar.attr,
+	&dev_attr_kdsstat.attr,
+	&dev_attr_memstat.attr,
+	&dev_attr_memstat_raw.attr,
+	&dev_attr_user_pf.attr,
+	&dev_attr_p2p_enable.attr,
+	&dev_attr_dev_offline.attr,
+	&dev_attr_mig_calibration.attr,
+	&dev_attr_link_width.attr,
+	&dev_attr_link_speed.attr,
+	&dev_attr_link_speed_max.attr,
+	&dev_attr_link_width_max.attr,
+	NULL,
+};
+
+static struct attribute_group xocl_attr_group = {
+	.attrs = xocl_attrs,
+};
+
+//---
+int xocl_init_sysfs(struct device *dev)
+{
+	int ret;
+	struct pci_dev *rdev;
+
+	ret = sysfs_create_group(&dev->kobj, &xocl_attr_group);
+	if (ret)
+		xocl_err(dev, "create xocl attrs failed: %d", ret);
+
+	xocl_get_root_dev(to_pci_dev(dev), rdev);
+	ret = sysfs_create_link(&dev->kobj, &rdev->dev.kobj, "root_dev");
+	if (ret)
+		xocl_err(dev, "create root device link failed: %d", ret);
+
+	return ret;
+}
+
+void xocl_fini_sysfs(struct device *dev)
+{
+	sysfs_remove_link(&dev->kobj, "root_dev");
+	sysfs_remove_group(&dev->kobj, &xocl_attr_group);
+}
-- 
2.17.0

