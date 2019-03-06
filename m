Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FB0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8072064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfCFLrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:47:12 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:12732 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729681AbfCFLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:47:10 -0500
X-UUID: 30a1608a79144e35b66d91cb382acf09-20190306
X-UUID: 30a1608a79144e35b66d91cb382acf09-20190306
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1212110909; Wed, 06 Mar 2019 19:46:56 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 19:46:54 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 19:46:53 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 08/11] usb: mtu3: add debugfs interface files
Date:   Wed, 6 Mar 2019 19:46:20 +0800
Message-ID: <1551872783-13707-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1551872783-13707-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1551872783-13707-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds more debugfs consumers. The debugfs entries read some
important registers, fifo status, QMU ring, endpoint status, and
IPPC probe interface to get internal status.
With these entries, users can check the registers, endpoint and
GPD used during run time.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/Makefile       |   4 +
 drivers/usb/mtu3/mtu3_core.c    |   3 +
 drivers/usb/mtu3/mtu3_debug.h   |  40 +++
 drivers/usb/mtu3/mtu3_debugfs.c | 438 ++++++++++++++++++++++++++++++++
 drivers/usb/mtu3/mtu3_dr.c      |  13 +-
 drivers/usb/mtu3/mtu3_hw_regs.h |  11 +
 drivers/usb/mtu3/mtu3_plat.c    |   7 +-
 7 files changed, 503 insertions(+), 13 deletions(-)
 create mode 100644 drivers/usb/mtu3/mtu3_debug.h
 create mode 100644 drivers/usb/mtu3/mtu3_debugfs.c

diff --git a/drivers/usb/mtu3/Makefile b/drivers/usb/mtu3/Makefile
index 4a9715812bf9..7c1826bbcebb 100644
--- a/drivers/usb/mtu3/Makefile
+++ b/drivers/usb/mtu3/Makefile
@@ -17,3 +17,7 @@ endif
 ifneq ($(CONFIG_USB_MTU3_DUAL_ROLE),)
 	mtu3-y	+= mtu3_dr.o
 endif
+
+ifneq ($(CONFIG_DEBUG_FS),)
+	mtu3-y	+= mtu3_debugfs.o
+endif
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index d354f5c3805a..f106fe81ae10 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 
 #include "mtu3.h"
+#include "mtu3_debug.h"
 
 static int ep_fifo_alloc(struct mtu3_ep *mep, u32 seg_size)
 {
@@ -900,6 +901,8 @@ int ssusb_gadget_init(struct ssusb_mtk *ssusb)
 	if (mtu->ssusb->dr_mode == USB_DR_MODE_OTG)
 		mtu3_stop(mtu);
 
+	ssusb_dev_debugfs_init(ssusb);
+
 	dev_dbg(dev, " %s() done...\n", __func__);
 
 	return 0;
diff --git a/drivers/usb/mtu3/mtu3_debug.h b/drivers/usb/mtu3/mtu3_debug.h
new file mode 100644
index 000000000000..94d39b00403e
--- /dev/null
+++ b/drivers/usb/mtu3/mtu3_debug.h
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mtu3_debug.h - debug header
+ *
+ * Copyright (C) 2019 MediaTek Inc.
+ *
+ * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
+ */
+
+#ifndef __MTU3_DEBUG_H__
+#define __MTU3_DEBUG_H__
+
+#include <linux/debugfs.h>
+
+#define MTU3_DEBUGFS_NAME_LEN 32
+
+struct mtu3_regset {
+	char name[MTU3_DEBUGFS_NAME_LEN];
+	struct debugfs_regset32 regset;
+	size_t nregs;
+};
+
+struct mtu3_file_map {
+	const char *name;
+	int (*show)(struct seq_file *s, void *unused);
+};
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+void ssusb_dev_debugfs_init(struct ssusb_mtk *ssusb);
+void ssusb_debugfs_create_root(struct ssusb_mtk *ssusb);
+void ssusb_debugfs_remove_root(struct ssusb_mtk *ssusb);
+
+#else
+static inline void ssusb_dev_debugfs_init(struct ssusb_mtk *ssusb) {}
+static inline void ssusb_debugfs_create_root(struct ssusb_mtk *ssusb) {}
+static inline void ssusb_debugfs_remove_root(struct ssusb_mtk *ssusb) {}
+
+#endif /* CONFIG_DEBUG_FS */
+
+#endif /* __MTU3_DEBUG_H__ */
diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
new file mode 100644
index 000000000000..7cb1cad5a4b3
--- /dev/null
+++ b/drivers/usb/mtu3/mtu3_debugfs.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mtu3_debugfs.c - debugfs interface
+ *
+ * Copyright (C) 2019 MediaTek Inc.
+ *
+ * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
+ */
+
+#include <linux/uaccess.h>
+
+#include "mtu3.h"
+#include "mtu3_debug.h"
+
+#define dump_register(nm)		\
+{					\
+	.name = __stringify(nm),	\
+	.offset = U3D_ ##nm,		\
+}
+
+#define dump_prb_reg(nm, os)	\
+{				\
+	.name = nm,		\
+	.offset = os,		\
+}
+
+static const struct debugfs_reg32 mtu3_ippc_regs[] = {
+	dump_register(SSUSB_IP_PW_CTRL0),
+	dump_register(SSUSB_IP_PW_CTRL1),
+	dump_register(SSUSB_IP_PW_CTRL2),
+	dump_register(SSUSB_IP_PW_CTRL3),
+	dump_register(SSUSB_OTG_STS),
+	dump_register(SSUSB_IP_XHCI_CAP),
+	dump_register(SSUSB_IP_DEV_CAP),
+	dump_register(SSUSB_U3_CTRL_0P),
+	dump_register(SSUSB_U2_CTRL_0P),
+	dump_register(SSUSB_HW_ID),
+	dump_register(SSUSB_HW_SUB_ID),
+	dump_register(SSUSB_IP_SPARE0),
+};
+
+static const struct debugfs_reg32 mtu3_dev_regs[] = {
+	dump_register(LV1ISR),
+	dump_register(LV1IER),
+	dump_register(EPISR),
+	dump_register(EPIER),
+	dump_register(EP0CSR),
+	dump_register(RXCOUNT0),
+	dump_register(QISAR0),
+	dump_register(QIER0),
+	dump_register(QISAR1),
+	dump_register(QIER1),
+	dump_register(CAP_EPNTXFFSZ),
+	dump_register(CAP_EPNRXFFSZ),
+	dump_register(CAP_EPINFO),
+	dump_register(MISC_CTRL),
+};
+
+static const struct debugfs_reg32 mtu3_csr_regs[] = {
+	dump_register(DEVICE_CONF),
+	dump_register(DEV_LINK_INTR_ENABLE),
+	dump_register(DEV_LINK_INTR),
+	dump_register(LTSSM_CTRL),
+	dump_register(USB3_CONFIG),
+	dump_register(LINK_STATE_MACHINE),
+	dump_register(LTSSM_INTR_ENABLE),
+	dump_register(LTSSM_INTR),
+	dump_register(U3U2_SWITCH_CTRL),
+	dump_register(POWER_MANAGEMENT),
+	dump_register(DEVICE_CONTROL),
+	dump_register(COMMON_USB_INTR_ENABLE),
+	dump_register(COMMON_USB_INTR),
+	dump_register(USB20_MISC_CONTROL),
+	dump_register(USB20_OPSTATE),
+};
+
+static int mtu3_link_state_show(struct seq_file *sf, void *unused)
+{
+	struct mtu3 *mtu = sf->private;
+	void __iomem *mbase = mtu->mac_base;
+
+	seq_printf(sf, "opstate: %#x, ltssm: %#x\n",
+		   mtu3_readl(mbase, U3D_USB20_OPSTATE),
+		   LTSSM_STATE(mtu3_readl(mbase, U3D_LINK_STATE_MACHINE)));
+
+	return 0;
+}
+
+static int mtu3_ep_used_show(struct seq_file *sf, void *unused)
+{
+	struct mtu3 *mtu = sf->private;
+	struct mtu3_ep *mep;
+	unsigned long flags;
+	int used = 0;
+	int i;
+
+	spin_lock_irqsave(&mtu->lock, flags);
+
+	for (i = 0; i < mtu->num_eps; i++) {
+		mep = mtu->in_eps + i;
+		if (mep->flags & MTU3_EP_ENABLED) {
+			seq_printf(sf, "%s - type: %d\n", mep->name, mep->type);
+			used++;
+		}
+
+		mep = mtu->out_eps + i;
+		if (mep->flags & MTU3_EP_ENABLED) {
+			seq_printf(sf, "%s - type: %d\n", mep->name, mep->type);
+			used++;
+		}
+	}
+	seq_printf(sf, "total used: %d eps\n", used);
+
+	spin_unlock_irqrestore(&mtu->lock, flags);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(mtu3_link_state);
+DEFINE_SHOW_ATTRIBUTE(mtu3_ep_used);
+
+static void mtu3_debugfs_regset(struct mtu3 *mtu, void __iomem *base,
+				const struct debugfs_reg32 *regs, size_t nregs,
+				const char *name, struct dentry *parent)
+{
+	struct debugfs_regset32 *regset;
+	struct mtu3_regset *mregs;
+
+	mregs = devm_kzalloc(mtu->dev, sizeof(*regset), GFP_KERNEL);
+	if (!mregs)
+		return;
+
+	sprintf(mregs->name, "%s", name);
+	regset = &mregs->regset;
+	regset->regs = regs;
+	regset->nregs = nregs;
+	regset->base = base;
+
+	debugfs_create_regset32(mregs->name, 0444, parent, regset);
+}
+
+static void mtu3_debugfs_ep_regset(struct mtu3 *mtu, struct mtu3_ep *mep,
+				   struct dentry *parent)
+{
+	struct debugfs_reg32 *regs;
+	int epnum = mep->epnum;
+	int in = mep->is_in;
+
+	regs = devm_kcalloc(mtu->dev, 7, sizeof(*regs), GFP_KERNEL);
+	if (!regs)
+		return;
+
+	regs[0].name = in ? "TCR0" : "RCR0";
+	regs[0].offset = in ? MU3D_EP_TXCR0(epnum) : MU3D_EP_RXCR0(epnum);
+	regs[1].name = in ? "TCR1" : "RCR1";
+	regs[1].offset = in ? MU3D_EP_TXCR1(epnum) : MU3D_EP_RXCR1(epnum);
+	regs[2].name = in ? "TCR2" : "RCR2";
+	regs[2].offset = in ? MU3D_EP_TXCR2(epnum) : MU3D_EP_RXCR2(epnum);
+	regs[3].name = in ? "TQHIAR" : "RQHIAR";
+	regs[3].offset = in ? USB_QMU_TQHIAR(epnum) : USB_QMU_RQHIAR(epnum);
+	regs[4].name = in ? "TQCSR" : "RQCSR";
+	regs[4].offset = in ? USB_QMU_TQCSR(epnum) : USB_QMU_RQCSR(epnum);
+	regs[5].name = in ? "TQSAR" : "RQSAR";
+	regs[5].offset = in ? USB_QMU_TQSAR(epnum) : USB_QMU_RQSAR(epnum);
+	regs[6].name = in ? "TQCPR" : "RQCPR";
+	regs[6].offset = in ? USB_QMU_TQCPR(epnum) : USB_QMU_RQCPR(epnum);
+
+	mtu3_debugfs_regset(mtu, mtu->mac_base, regs, 7, "ep-regs", parent);
+}
+
+static int mtu3_ep_info_show(struct seq_file *sf, void *unused)
+{
+	struct mtu3_ep *mep = sf->private;
+	struct mtu3 *mtu = mep->mtu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mtu->lock, flags);
+	seq_printf(sf, "ep - type:%d, maxp:%d, slot:%d, flags:%x\n",
+		   mep->type, mep->maxp, mep->slot, mep->flags);
+	spin_unlock_irqrestore(&mtu->lock, flags);
+
+	return 0;
+}
+
+static int mtu3_fifo_show(struct seq_file *sf, void *unused)
+{
+	struct mtu3_ep *mep = sf->private;
+	struct mtu3 *mtu = mep->mtu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mtu->lock, flags);
+	seq_printf(sf, "fifo - seg_size:%d, addr:%d, size:%d\n",
+		   mep->fifo_seg_size, mep->fifo_addr, mep->fifo_size);
+	spin_unlock_irqrestore(&mtu->lock, flags);
+
+	return 0;
+}
+
+static int mtu3_qmu_ring_show(struct seq_file *sf, void *unused)
+{
+	struct mtu3_ep *mep = sf->private;
+	struct mtu3 *mtu = mep->mtu;
+	struct mtu3_gpd_ring *ring;
+	unsigned long flags;
+
+	ring = &mep->gpd_ring;
+	spin_lock_irqsave(&mtu->lock, flags);
+	seq_printf(sf,
+		   "qmu-ring - dma:%pad, start:%p, end:%p, enq:%p, dep:%p\n",
+		   &ring->dma, ring->start, ring->end,
+		   ring->enqueue, ring->dequeue);
+	spin_unlock_irqrestore(&mtu->lock, flags);
+
+	return 0;
+}
+
+static int mtu3_qmu_gpd_show(struct seq_file *sf, void *unused)
+{
+	struct mtu3_ep *mep = sf->private;
+	struct mtu3 *mtu = mep->mtu;
+	struct mtu3_gpd_ring *ring;
+	struct qmu_gpd *gpd;
+	dma_addr_t dma;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&mtu->lock, flags);
+	ring = &mep->gpd_ring;
+	gpd = ring->start;
+	if (!gpd || !(mep->flags & MTU3_EP_ENABLED)) {
+		seq_puts(sf, "empty!\n");
+		goto out;
+	}
+
+	for (i = 0; i < MAX_GPD_NUM; i++, gpd++) {
+		dma = ring->dma + i * sizeof(*gpd);
+		seq_printf(sf, "gpd.%03d -> %pad, %p: %08x %08x %08x %08x\n",
+			   i, &dma, gpd, gpd->dw0_info, gpd->next_gpd,
+			   gpd->buffer, gpd->dw3_info);
+	}
+
+out:
+	spin_unlock_irqrestore(&mtu->lock, flags);
+
+	return 0;
+}
+
+static const struct mtu3_file_map mtu3_ep_files[] = {
+	{"ep-info", mtu3_ep_info_show, },
+	{"fifo", mtu3_fifo_show, },
+	{"qmu-ring", mtu3_qmu_ring_show, },
+	{"qmu-gpd", mtu3_qmu_gpd_show, },
+};
+
+static int mtu3_ep_open(struct inode *inode, struct file *file)
+{
+	const char *file_name = file_dentry(file)->d_iname;
+	const struct mtu3_file_map *f_map;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mtu3_ep_files); i++) {
+		f_map = &mtu3_ep_files[i];
+
+		if (strcmp(f_map->name, file_name) == 0)
+			break;
+	}
+
+	return single_open(file, f_map->show, inode->i_private);
+}
+
+static const struct file_operations mtu3_ep_fops = {
+	.open = mtu3_ep_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static struct debugfs_reg32 mtu3_prb_regs[] = {
+	dump_prb_reg("enable", U3D_SSUSB_PRB_CTRL0),
+	dump_prb_reg("byte-sell", U3D_SSUSB_PRB_CTRL1),
+	dump_prb_reg("byte-selh", U3D_SSUSB_PRB_CTRL2),
+	dump_prb_reg("module-sel", U3D_SSUSB_PRB_CTRL3),
+	dump_prb_reg("sw-out", U3D_SSUSB_PRB_CTRL4),
+	dump_prb_reg("data", U3D_SSUSB_PRB_CTRL5),
+};
+
+static int mtu3_probe_show(struct seq_file *sf, void *unused)
+{
+	const char *file_name = file_dentry(sf->file)->d_iname;
+	struct mtu3 *mtu = sf->private;
+	const struct debugfs_reg32 *regs;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mtu3_prb_regs); i++) {
+		regs = &mtu3_prb_regs[i];
+
+		if (strcmp(regs->name, file_name) == 0)
+			break;
+	}
+
+	seq_printf(sf, "0x%04x - 0x%08x\n", (u32)regs->offset,
+		   mtu3_readl(mtu->ippc_base, (u32)regs->offset));
+
+	return 0;
+}
+
+static int mtu3_probe_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, mtu3_probe_show, inode->i_private);
+}
+
+static ssize_t mtu3_probe_write(struct file *file, const char __user *ubuf,
+				size_t count, loff_t *ppos)
+{
+	const char *file_name = file_dentry(file)->d_iname;
+	struct seq_file *sf = file->private_data;
+	struct mtu3 *mtu = sf->private;
+	const struct debugfs_reg32 *regs;
+	char buf[32];
+	u32 val;
+	int i;
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (kstrtou32(buf, 0, &val))
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(mtu3_prb_regs); i++) {
+		regs = &mtu3_prb_regs[i];
+
+		if (strcmp(regs->name, file_name) == 0)
+			break;
+	}
+	mtu3_writel(mtu->ippc_base, (u32)regs->offset, val);
+
+	return count;
+}
+
+static const struct file_operations mtu3_probe_fops = {
+	.open = mtu3_probe_open,
+	.write = mtu3_probe_write,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static void mtu3_debugfs_create_prb_files(struct mtu3 *mtu)
+{
+	struct ssusb_mtk *ssusb = mtu->ssusb;
+	struct debugfs_reg32 *regs;
+	struct dentry *dir_prb;
+	int i;
+
+	dir_prb = debugfs_create_dir("probe", ssusb->dbgfs_root);
+
+	for (i = 0; i < ARRAY_SIZE(mtu3_prb_regs); i++) {
+		regs = &mtu3_prb_regs[i];
+		debugfs_create_file(regs->name, 0644, dir_prb,
+				    mtu, &mtu3_probe_fops);
+	}
+
+	mtu3_debugfs_regset(mtu, mtu->ippc_base, mtu3_prb_regs,
+			    ARRAY_SIZE(mtu3_prb_regs), "regs", dir_prb);
+}
+
+static void mtu3_debugfs_create_ep_dir(struct mtu3_ep *mep,
+				       struct dentry *parent)
+{
+	const struct mtu3_file_map *files;
+	struct dentry *dir_ep;
+	int i;
+
+	dir_ep = debugfs_create_dir(mep->name, parent);
+	mtu3_debugfs_ep_regset(mep->mtu, mep, dir_ep);
+
+	for (i = 0; i < ARRAY_SIZE(mtu3_ep_files); i++) {
+		files = &mtu3_ep_files[i];
+
+		debugfs_create_file(files->name, 0444, dir_ep,
+				    mep, &mtu3_ep_fops);
+	}
+}
+
+static void mtu3_debugfs_create_ep_dirs(struct mtu3 *mtu)
+{
+	struct ssusb_mtk *ssusb = mtu->ssusb;
+	struct dentry *dir_eps;
+	int i;
+
+	dir_eps = debugfs_create_dir("eps", ssusb->dbgfs_root);
+
+	for (i = 1; i < mtu->num_eps; i++) {
+		mtu3_debugfs_create_ep_dir(mtu->in_eps + i, dir_eps);
+		mtu3_debugfs_create_ep_dir(mtu->out_eps + i, dir_eps);
+	}
+}
+
+void ssusb_dev_debugfs_init(struct ssusb_mtk *ssusb)
+{
+	struct mtu3 *mtu = ssusb->u3d;
+	struct dentry *dir_regs;
+
+	dir_regs = debugfs_create_dir("regs", ssusb->dbgfs_root);
+
+	mtu3_debugfs_regset(mtu, mtu->ippc_base,
+			    mtu3_ippc_regs, ARRAY_SIZE(mtu3_ippc_regs),
+			    "reg-ippc", dir_regs);
+
+	mtu3_debugfs_regset(mtu, mtu->mac_base,
+			    mtu3_dev_regs, ARRAY_SIZE(mtu3_dev_regs),
+			    "reg-dev", dir_regs);
+
+	mtu3_debugfs_regset(mtu, mtu->mac_base,
+			    mtu3_csr_regs, ARRAY_SIZE(mtu3_csr_regs),
+			    "reg-csr", dir_regs);
+
+	mtu3_debugfs_create_ep_dirs(mtu);
+
+	mtu3_debugfs_create_prb_files(mtu);
+
+	debugfs_create_file("link-state", 0444, ssusb->dbgfs_root,
+			    mtu, &mtu3_link_state_fops);
+	debugfs_create_file("ep-used", 0444, ssusb->dbgfs_root,
+			    mtu, &mtu3_ep_used_fops);
+}
+
+void ssusb_debugfs_create_root(struct ssusb_mtk *ssusb)
+{
+	ssusb->dbgfs_root =
+		debugfs_create_dir(dev_name(ssusb->dev), usb_debug_root);
+}
+
+void ssusb_debugfs_remove_root(struct ssusb_mtk *ssusb)
+{
+	debugfs_remove_recursive(ssusb->dbgfs_root);
+	ssusb->dbgfs_root = NULL;
+}
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 61694c40e101..3f86ae1e73e8 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -379,20 +379,12 @@ static const struct file_operations ssusb_vbus_fops = {
 
 static void ssusb_debugfs_init(struct ssusb_mtk *ssusb)
 {
-	struct dentry *root;
-
-	root = debugfs_create_dir(dev_name(ssusb->dev), usb_debug_root);
-	ssusb->dbgfs_root = root;
+	struct dentry *root = ssusb->dbgfs_root;
 
 	debugfs_create_file("mode", 0644, root, ssusb, &ssusb_mode_fops);
 	debugfs_create_file("vbus", 0644, root, ssusb, &ssusb_vbus_fops);
 }
 
-static void ssusb_debugfs_exit(struct ssusb_mtk *ssusb)
-{
-	debugfs_remove_recursive(ssusb->dbgfs_root);
-}
-
 void ssusb_set_force_mode(struct ssusb_mtk *ssusb,
 			  enum mtu3_dr_force_mode mode)
 {
@@ -436,9 +428,6 @@ void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
 {
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 
-	if (otg_sx->manual_drd_enabled)
-		ssusb_debugfs_exit(ssusb);
-
 	cancel_work_sync(&otg_sx->id_work);
 	cancel_work_sync(&otg_sx->vbus_work);
 }
diff --git a/drivers/usb/mtu3/mtu3_hw_regs.h b/drivers/usb/mtu3/mtu3_hw_regs.h
index bf70ea2426a9..8382d066749e 100644
--- a/drivers/usb/mtu3/mtu3_hw_regs.h
+++ b/drivers/usb/mtu3/mtu3_hw_regs.h
@@ -290,6 +290,7 @@
 #define U3D_LTSSM_CTRL		(SSUSB_USB3_MAC_CSR_BASE + 0x0010)
 #define U3D_USB3_CONFIG		(SSUSB_USB3_MAC_CSR_BASE + 0x001C)
 
+#define U3D_LINK_STATE_MACHINE	(SSUSB_USB3_MAC_CSR_BASE + 0x0134)
 #define U3D_LTSSM_INTR_ENABLE	(SSUSB_USB3_MAC_CSR_BASE + 0x013C)
 #define U3D_LTSSM_INTR		(SSUSB_USB3_MAC_CSR_BASE + 0x0140)
 
@@ -307,6 +308,9 @@
 /* U3D_USB3_CONFIG */
 #define USB3_EN			BIT(0)
 
+/* U3D_LINK_STATE_MACHINE */
+#define LTSSM_STATE(x)	((x) & 0x1f)
+
 /* U3D_LTSSM_INTR_ENABLE */
 /* U3D_LTSSM_INTR */
 #define U3_RESUME_INTR		BIT(18)
@@ -372,6 +376,7 @@
 #define U3D_USB20_FRAME_NUM		(SSUSB_USB2_CSR_BASE + 0x003C)
 #define U3D_USB20_LPM_PARAMETER		(SSUSB_USB2_CSR_BASE + 0x0044)
 #define U3D_USB20_MISC_CONTROL		(SSUSB_USB2_CSR_BASE + 0x004C)
+#define U3D_USB20_OPSTATE		(SSUSB_USB2_CSR_BASE + 0x0060)
 
 /*---------------- SSUSB_USB2_CSR FIELD DEFINITION ----------------*/
 
@@ -445,6 +450,12 @@
 #define U3D_SSUSB_HW_ID		(SSUSB_SIFSLV_IPPC_BASE + 0x00A0)
 #define U3D_SSUSB_HW_SUB_ID	(SSUSB_SIFSLV_IPPC_BASE + 0x00A4)
 #define U3D_SSUSB_IP_TRUNK_VERS	(U3D_SSUSB_HW_SUB_ID)
+#define U3D_SSUSB_PRB_CTRL0	(SSUSB_SIFSLV_IPPC_BASE + 0x00B0)
+#define U3D_SSUSB_PRB_CTRL1	(SSUSB_SIFSLV_IPPC_BASE + 0x00B4)
+#define U3D_SSUSB_PRB_CTRL2	(SSUSB_SIFSLV_IPPC_BASE + 0x00B8)
+#define U3D_SSUSB_PRB_CTRL3	(SSUSB_SIFSLV_IPPC_BASE + 0x00BC)
+#define U3D_SSUSB_PRB_CTRL4	(SSUSB_SIFSLV_IPPC_BASE + 0x00C0)
+#define U3D_SSUSB_PRB_CTRL5	(SSUSB_SIFSLV_IPPC_BASE + 0x00C4)
 #define U3D_SSUSB_IP_SPARE0	(SSUSB_SIFSLV_IPPC_BASE + 0x00C8)
 
 /*---------------- SSUSB_SIFSLV_IPPC FIELD DEFINITION ----------------*/
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index a326b1d6006a..dca8bd864e63 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -16,6 +16,7 @@
 
 #include "mtu3.h"
 #include "mtu3_dr.h"
+#include "mtu3_debug.h"
 
 /* u2-port0 should be powered on and enabled; */
 int ssusb_check_clocks(struct ssusb_mtk *ssusb, u32 ex_clks)
@@ -232,7 +233,7 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	int i;
 	int ret;
 
-	ssusb->vusb33 = devm_regulator_get(&pdev->dev, "vusb33");
+	ssusb->vusb33 = devm_regulator_get(dev, "vusb33");
 	if (IS_ERR(ssusb->vusb33)) {
 		dev_err(dev, "failed to get vusb33\n");
 		return PTR_ERR(ssusb->vusb33);
@@ -353,6 +354,8 @@ static int mtu3_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ssusb_debugfs_create_root(ssusb);
+
 	/* enable power domain */
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
@@ -423,6 +426,7 @@ static int mtu3_probe(struct platform_device *pdev)
 comm_init_err:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
+	ssusb_debugfs_remove_root(ssusb);
 
 	return ret;
 }
@@ -450,6 +454,7 @@ static int mtu3_remove(struct platform_device *pdev)
 	ssusb_rscs_exit(ssusb);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	ssusb_debugfs_remove_root(ssusb);
 
 	return 0;
 }
-- 
2.20.1

