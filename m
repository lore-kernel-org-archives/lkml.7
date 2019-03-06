Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD84C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32B320828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfCFLrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:47:17 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:65061 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729566AbfCFLrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:47:11 -0500
X-UUID: 367713df308d40c598415eb963d4846d-20190306
X-UUID: 367713df308d40c598415eb963d4846d-20190306
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 854441205; Wed, 06 Mar 2019 19:46:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 19:46:56 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 19:46:56 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 10/11] usb: mtu3: add tracepoints to help debug
Date:   Wed, 6 Mar 2019 19:46:22 +0800
Message-ID: <1551872783-13707-11-git-send-email-chunfeng.yun@mediatek.com>
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

This patch implements a few initial tracepoints for the
mtu3 driver. More traces can be added as necessary in order
to ease the task of debugging.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/Makefile          |   7 +
 drivers/usb/mtu3/mtu3_core.c       |   5 +
 drivers/usb/mtu3/mtu3_debug.h      |   8 +
 drivers/usb/mtu3/mtu3_dr.c         |   1 +
 drivers/usb/mtu3/mtu3_gadget.c     |  14 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c |   4 +
 drivers/usb/mtu3/mtu3_qmu.c        |   7 +
 drivers/usb/mtu3/mtu3_trace.c      |  23 +++
 drivers/usb/mtu3/mtu3_trace.h      | 279 +++++++++++++++++++++++++++++
 9 files changed, 347 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/mtu3/mtu3_trace.c
 create mode 100644 drivers/usb/mtu3/mtu3_trace.h

diff --git a/drivers/usb/mtu3/Makefile b/drivers/usb/mtu3/Makefile
index 7c1826bbcebb..3bf8cbcc1add 100644
--- a/drivers/usb/mtu3/Makefile
+++ b/drivers/usb/mtu3/Makefile
@@ -2,10 +2,17 @@
 
 ccflags-$(CONFIG_USB_MTU3_DEBUG)	+= -DDEBUG
 
+# define_trace.h needs to know how to find our header
+CFLAGS_mtu3_trace.o	:= -I$(src)
+
 obj-$(CONFIG_USB_MTU3)	+= mtu3.o
 
 mtu3-y	:= mtu3_plat.o
 
+ifneq ($(CONFIG_TRACING),)
+	mtu3-y	+= mtu3_trace.o
+endif
+
 ifneq ($(filter y,$(CONFIG_USB_MTU3_HOST) $(CONFIG_USB_MTU3_DUAL_ROLE)),)
 	mtu3-y	+= mtu3_host.o
 endif
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index f106fe81ae10..f8bd1d57e795 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -17,6 +17,7 @@
 
 #include "mtu3.h"
 #include "mtu3_debug.h"
+#include "mtu3_trace.h"
 
 static int ep_fifo_alloc(struct mtu3_ep *mep, u32 seg_size)
 {
@@ -656,6 +657,8 @@ static irqreturn_t mtu3_link_isr(struct mtu3 *mtu)
 		break;
 	}
 	dev_dbg(mtu->dev, "%s: %s\n", __func__, usb_speed_string(udev_speed));
+	mtu3_dbg_trace(mtu->dev, "link speed %s",
+		       usb_speed_string(udev_speed));
 
 	mtu->g.speed = udev_speed;
 	mtu->g.ep0->maxpacket = maxpkt;
@@ -678,6 +681,7 @@ static irqreturn_t mtu3_u3_ltssm_isr(struct mtu3 *mtu)
 	ltssm &= mtu3_readl(mbase, U3D_LTSSM_INTR_ENABLE);
 	mtu3_writel(mbase, U3D_LTSSM_INTR, ltssm); /* W1C */
 	dev_dbg(mtu->dev, "=== LTSSM[%x] ===\n", ltssm);
+	trace_mtu3_u3_ltssm_isr(ltssm);
 
 	if (ltssm & (HOT_RST_INTR | WARM_RST_INTR))
 		mtu3_gadget_reset(mtu);
@@ -708,6 +712,7 @@ static irqreturn_t mtu3_u2_common_isr(struct mtu3 *mtu)
 	u2comm &= mtu3_readl(mbase, U3D_COMMON_USB_INTR_ENABLE);
 	mtu3_writel(mbase, U3D_COMMON_USB_INTR, u2comm); /* W1C */
 	dev_dbg(mtu->dev, "=== U2COMM[%x] ===\n", u2comm);
+	trace_mtu3_u2_common_isr(u2comm);
 
 	if (u2comm & SUSPEND_INTR)
 		mtu3_gadget_suspend(mtu);
diff --git a/drivers/usb/mtu3/mtu3_debug.h b/drivers/usb/mtu3/mtu3_debug.h
index d97a48c73469..e96a69234d05 100644
--- a/drivers/usb/mtu3/mtu3_debug.h
+++ b/drivers/usb/mtu3/mtu3_debug.h
@@ -39,4 +39,12 @@ static inline void ssusb_debugfs_remove_root(struct ssusb_mtk *ssusb) {}
 
 #endif /* CONFIG_DEBUG_FS */
 
+#if IS_ENABLED(CONFIG_TRACING)
+void mtu3_dbg_trace(struct device *dev, const char *fmt, ...);
+
+#else
+static inline void mtu3_dbg_trace(struct device *dev, const char *fmt, ...) {}
+
+#endif /* CONFIG_TRACING */
+
 #endif /* __MTU3_DEBUG_H__ */
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index ff2956272e15..82913120622b 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -141,6 +141,7 @@ static void ssusb_set_mailbox(struct otg_switch_mtk *otg_sx,
 	struct mtu3 *mtu = ssusb->u3d;
 
 	dev_dbg(ssusb->dev, "mailbox state(%d)\n", status);
+	mtu3_dbg_trace(ssusb->dev, "mailbox %d", status);
 
 	switch (status) {
 	case MTU3_ID_GROUND:
diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
index fe798b94a357..f93732e53fd8 100644
--- a/drivers/usb/mtu3/mtu3_gadget.c
+++ b/drivers/usb/mtu3/mtu3_gadget.c
@@ -8,6 +8,7 @@
  */
 
 #include "mtu3.h"
+#include "mtu3_trace.h"
 
 void mtu3_req_complete(struct mtu3_ep *mep,
 		     struct usb_request *req, int status)
@@ -25,6 +26,8 @@ __acquires(mep->mtu->lock)
 
 	mtu = mreq->mtu;
 	mep->busy = 1;
+
+	trace_mtu3_req_complete(mreq);
 	spin_unlock(&mtu->lock);
 
 	/* ep0 makes use of PIO, needn't unmap it */
@@ -201,6 +204,7 @@ static int mtu3_gadget_ep_enable(struct usb_ep *ep,
 	spin_unlock_irqrestore(&mtu->lock, flags);
 
 	dev_dbg(mtu->dev, "%s active_ep=%d\n", __func__, mtu->active_ep);
+	trace_mtu3_gadget_ep_enable(mep);
 
 	return ret;
 }
@@ -212,6 +216,7 @@ static int mtu3_gadget_ep_disable(struct usb_ep *ep)
 	unsigned long flags;
 
 	dev_dbg(mtu->dev, "%s %s\n", __func__, mep->name);
+	trace_mtu3_gadget_ep_disable(mep);
 
 	if (!(mep->flags & MTU3_EP_ENABLED)) {
 		dev_warn(mtu->dev, "%s is already disabled\n", mep->name);
@@ -242,13 +247,17 @@ struct usb_request *mtu3_alloc_request(struct usb_ep *ep, gfp_t gfp_flags)
 	mreq->request.dma = DMA_ADDR_INVALID;
 	mreq->epnum = mep->epnum;
 	mreq->mep = mep;
+	trace_mtu3_alloc_request(mreq);
 
 	return &mreq->request;
 }
 
 void mtu3_free_request(struct usb_ep *ep, struct usb_request *req)
 {
-	kfree(to_mtu3_request(req));
+	struct mtu3_request *mreq = to_mtu3_request(req);
+
+	trace_mtu3_free_request(mreq);
+	kfree(mreq);
 }
 
 static int mtu3_gadget_queue(struct usb_ep *ep,
@@ -316,6 +325,7 @@ static int mtu3_gadget_queue(struct usb_ep *ep,
 
 error:
 	spin_unlock_irqrestore(&mtu->lock, flags);
+	trace_mtu3_gadget_queue(mreq);
 
 	return ret;
 }
@@ -333,6 +343,7 @@ static int mtu3_gadget_dequeue(struct usb_ep *ep, struct usb_request *req)
 		return -EINVAL;
 
 	dev_dbg(mtu->dev, "%s : req=%p\n", __func__, req);
+	trace_mtu3_gadget_dequeue(mreq);
 
 	spin_lock_irqsave(&mtu->lock, flags);
 
@@ -403,6 +414,7 @@ static int mtu3_gadget_ep_set_halt(struct usb_ep *ep, int value)
 
 done:
 	spin_unlock_irqrestore(&mtu->lock, flags);
+	trace_mtu3_gadget_ep_set_halt(mep);
 
 	return ret;
 }
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 7cb7ac980446..4da216c99726 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -11,6 +11,8 @@
 #include <linux/usb/composite.h>
 
 #include "mtu3.h"
+#include "mtu3_debug.h"
+#include "mtu3_trace.h"
 
 /* ep0 is always mtu3->in_eps[0] */
 #define	next_ep0_request(mtu)	next_request((mtu)->ep0)
@@ -634,6 +636,7 @@ __acquires(mtu->lock)
 	int handled = 0;
 
 	ep0_read_setup(mtu, &setup);
+	trace_mtu3_handle_setup(&setup);
 
 	if ((setup.bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD)
 		handled = handle_standard_request(mtu, &setup);
@@ -710,6 +713,7 @@ irqreturn_t mtu3_ep0_isr(struct mtu3 *mtu)
 		ret = IRQ_HANDLED;
 	}
 	dev_dbg(mtu->dev, "ep0_state: %s\n", decode_ep0_state(mtu));
+	mtu3_dbg_trace(mtu->dev, "ep0_state %s", decode_ep0_state(mtu));
 
 	switch (mtu->ep0_state) {
 	case MU3D_EP0_STATE_TX:
diff --git a/drivers/usb/mtu3/mtu3_qmu.c b/drivers/usb/mtu3/mtu3_qmu.c
index 9f017aa8fbeb..3f414f91b589 100644
--- a/drivers/usb/mtu3/mtu3_qmu.c
+++ b/drivers/usb/mtu3/mtu3_qmu.c
@@ -22,6 +22,7 @@
 #include <linux/iopoll.h>
 
 #include "mtu3.h"
+#include "mtu3_trace.h"
 
 #define QMU_CHECKSUM_LEN	16
 
@@ -275,6 +276,7 @@ static int mtu3_prepare_tx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	gpd->dw0_info |= cpu_to_le32(GPD_FLAGS_IOC | GPD_FLAGS_HWO);
 
 	mreq->gpd = gpd;
+	trace_mtu3_prepare_gpd(mep, gpd);
 
 	return 0;
 }
@@ -307,6 +309,7 @@ static int mtu3_prepare_rx_gpd(struct mtu3_ep *mep, struct mtu3_request *mreq)
 	gpd->dw0_info |= cpu_to_le32(GPD_FLAGS_IOC | GPD_FLAGS_HWO);
 
 	mreq->gpd = gpd;
+	trace_mtu3_prepare_gpd(mep, gpd);
 
 	return 0;
 }
@@ -431,6 +434,7 @@ static void qmu_tx_zlp_error_handler(struct mtu3 *mtu, u8 epnum)
 	}
 
 	dev_dbg(mtu->dev, "%s send ZLP for req=%p\n", __func__, mreq);
+	trace_mtu3_zlp_exp_gpd(mep, gpd_current);
 
 	mtu3_clrbits(mbase, MU3D_EP_TXCR0(mep->epnum), TX_DMAREQEN);
 
@@ -486,6 +490,7 @@ static void qmu_done_tx(struct mtu3 *mtu, u8 epnum)
 
 		request = &mreq->request;
 		request->actual = GPD_DATA_LEN(mtu, le32_to_cpu(gpd->dw3_info));
+		trace_mtu3_complete_gpd(mep, gpd);
 		mtu3_req_complete(mep, request, 0);
 
 		gpd = advance_deq_gpd(ring);
@@ -524,6 +529,7 @@ static void qmu_done_rx(struct mtu3 *mtu, u8 epnum)
 		req = &mreq->request;
 
 		req->actual = GPD_DATA_LEN(mtu, le32_to_cpu(gpd->dw3_info));
+		trace_mtu3_complete_gpd(mep, gpd);
 		mtu3_req_complete(mep, req, 0);
 
 		gpd = advance_deq_gpd(ring);
@@ -601,6 +607,7 @@ irqreturn_t mtu3_qmu_isr(struct mtu3 *mtu)
 	dev_dbg(mtu->dev, "=== QMUdone[tx=%x, rx=%x] QMUexp[%x] ===\n",
 		(qmu_done_status & 0xFFFF), qmu_done_status >> 16,
 		qmu_status);
+	trace_mtu3_qmu_isr(qmu_done_status, qmu_status);
 
 	if (qmu_done_status)
 		qmu_done_isr(mtu, qmu_done_status);
diff --git a/drivers/usb/mtu3/mtu3_trace.c b/drivers/usb/mtu3/mtu3_trace.c
new file mode 100644
index 000000000000..4f5e7857ec31
--- /dev/null
+++ b/drivers/usb/mtu3/mtu3_trace.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * mtu3_trace.c - trace support
+ *
+ * Copyright (C) 2019 MediaTek Inc.
+ *
+ * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
+ */
+
+#define CREATE_TRACE_POINTS
+#include "mtu3_trace.h"
+
+void mtu3_dbg_trace(struct device *dev, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	trace_mtu3_log(dev, &vaf);
+	va_end(args);
+}
diff --git a/drivers/usb/mtu3/mtu3_trace.h b/drivers/usb/mtu3/mtu3_trace.h
new file mode 100644
index 000000000000..050e30f0fbd4
--- /dev/null
+++ b/drivers/usb/mtu3/mtu3_trace.h
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * mtu3_trace.h - trace support
+ *
+ * Copyright (C) 2019 MediaTek Inc.
+ *
+ * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mtu3
+
+#if !defined(__MTU3_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ)
+#define __MTU3_TRACE_H__
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+#include "mtu3.h"
+
+#define MTU3_MSG_MAX	256
+
+TRACE_EVENT(mtu3_log,
+	TP_PROTO(struct device *dev, struct va_format *vaf),
+	TP_ARGS(dev, vaf),
+	TP_STRUCT__entry(
+		__string(name, dev_name(dev))
+		__dynamic_array(char, msg, MTU3_MSG_MAX)
+	),
+	TP_fast_assign(
+		__assign_str(name, dev_name(dev));
+		vsnprintf(__get_str(msg), MTU3_MSG_MAX, vaf->fmt, *vaf->va);
+	),
+	TP_printk("%s: %s", __get_str(name), __get_str(msg))
+);
+
+TRACE_EVENT(mtu3_u3_ltssm_isr,
+	TP_PROTO(u32 intr),
+	TP_ARGS(intr),
+	TP_STRUCT__entry(
+		__field(u32, intr)
+	),
+	TP_fast_assign(
+		__entry->intr = intr;
+	),
+	TP_printk("(%08x) %s %s %s %s %s %s", __entry->intr,
+		__entry->intr & HOT_RST_INTR ? "HOT_RST" : "",
+		__entry->intr & WARM_RST_INTR ? "WARM_RST" : "",
+		__entry->intr & ENTER_U3_INTR ? "ENT_U3" : "",
+		__entry->intr & EXIT_U3_INTR ? "EXIT_U3" : "",
+		__entry->intr & VBUS_RISE_INTR ? "VBUS_RISE" : "",
+		__entry->intr & VBUS_FALL_INTR ? "VBUS_FALL" : ""
+	)
+);
+
+TRACE_EVENT(mtu3_u2_common_isr,
+	TP_PROTO(u32 intr),
+	TP_ARGS(intr),
+	TP_STRUCT__entry(
+		__field(u32, intr)
+	),
+	TP_fast_assign(
+		__entry->intr = intr;
+	),
+	TP_printk("(%08x) %s %s %s", __entry->intr,
+		__entry->intr & SUSPEND_INTR ? "SUSPEND" : "",
+		__entry->intr & RESUME_INTR ? "RESUME" : "",
+		__entry->intr & RESET_INTR ? "RESET" : ""
+	)
+);
+
+TRACE_EVENT(mtu3_qmu_isr,
+	TP_PROTO(u32 done_intr, u32 exp_intr),
+	TP_ARGS(done_intr, exp_intr),
+	TP_STRUCT__entry(
+		__field(u32, done_intr)
+		__field(u32, exp_intr)
+	),
+	TP_fast_assign(
+		__entry->done_intr = done_intr;
+		__entry->exp_intr = exp_intr;
+	),
+	TP_printk("done (tx %04x, rx %04x), exp (%08x)",
+		__entry->done_intr & 0xffff,
+		__entry->done_intr >> 16,
+		__entry->exp_intr
+	)
+);
+
+DECLARE_EVENT_CLASS(mtu3_log_setup,
+	TP_PROTO(struct usb_ctrlrequest *setup),
+	TP_ARGS(setup),
+	TP_STRUCT__entry(
+		__field(__u8, bRequestType)
+		__field(__u8, bRequest)
+		__field(__u16, wValue)
+		__field(__u16, wIndex)
+		__field(__u16, wLength)
+	),
+	TP_fast_assign(
+		__entry->bRequestType = setup->bRequestType;
+		__entry->bRequest = setup->bRequest;
+		__entry->wValue = le16_to_cpu(setup->wValue);
+		__entry->wIndex = le16_to_cpu(setup->wIndex);
+		__entry->wLength = le16_to_cpu(setup->wLength);
+	),
+	TP_printk("setup - %02x %02x %04x %04x %04x",
+		__entry->bRequestType, __entry->bRequest,
+		__entry->wValue, __entry->wIndex, __entry->wLength
+	)
+);
+
+DEFINE_EVENT(mtu3_log_setup, mtu3_handle_setup,
+	TP_PROTO(struct usb_ctrlrequest *setup),
+	TP_ARGS(setup)
+);
+
+DECLARE_EVENT_CLASS(mtu3_log_request,
+	TP_PROTO(struct mtu3_request *mreq),
+	TP_ARGS(mreq),
+	TP_STRUCT__entry(
+		__string(name, mreq->mep->name)
+		__field(struct mtu3_request *, mreq)
+		__field(struct qmu_gpd *, gpd)
+		__field(unsigned int, actual)
+		__field(unsigned int, length)
+		__field(int, status)
+		__field(int, zero)
+		__field(int, no_interrupt)
+	),
+	TP_fast_assign(
+		__assign_str(name, mreq->mep->name);
+		__entry->mreq = mreq;
+		__entry->gpd = mreq->gpd;
+		__entry->actual = mreq->request.actual;
+		__entry->length = mreq->request.length;
+		__entry->status = mreq->request.status;
+		__entry->zero = mreq->request.zero;
+		__entry->no_interrupt = mreq->request.no_interrupt;
+	),
+	TP_printk("%s: req %p gpd %p len %u/%u %s%s --> %d",
+		__get_str(name), __entry->mreq, __entry->gpd,
+		__entry->actual, __entry->length,
+		__entry->zero ? "Z" : "z",
+		__entry->no_interrupt ? "i" : "I",
+		__entry->status
+	)
+);
+
+DEFINE_EVENT(mtu3_log_request, mtu3_alloc_request,
+	TP_PROTO(struct mtu3_request *req),
+	TP_ARGS(req)
+);
+
+DEFINE_EVENT(mtu3_log_request, mtu3_free_request,
+	TP_PROTO(struct mtu3_request *req),
+	TP_ARGS(req)
+);
+
+DEFINE_EVENT(mtu3_log_request, mtu3_gadget_queue,
+	TP_PROTO(struct mtu3_request *req),
+	TP_ARGS(req)
+);
+
+DEFINE_EVENT(mtu3_log_request, mtu3_gadget_dequeue,
+	TP_PROTO(struct mtu3_request *req),
+	TP_ARGS(req)
+);
+
+DEFINE_EVENT(mtu3_log_request, mtu3_req_complete,
+	TP_PROTO(struct mtu3_request *req),
+	TP_ARGS(req)
+);
+
+DECLARE_EVENT_CLASS(mtu3_log_gpd,
+	TP_PROTO(struct mtu3_ep *mep, struct qmu_gpd *gpd),
+	TP_ARGS(mep, gpd),
+	TP_STRUCT__entry(
+		__string(name, mep->name)
+		__field(struct qmu_gpd *, gpd)
+		__field(u32, dw0)
+		__field(u32, dw1)
+		__field(u32, dw2)
+		__field(u32, dw3)
+	),
+	TP_fast_assign(
+		__assign_str(name, mep->name);
+		__entry->gpd = gpd;
+		__entry->dw0 = le32_to_cpu(gpd->dw0_info);
+		__entry->dw1 = le32_to_cpu(gpd->next_gpd);
+		__entry->dw2 = le32_to_cpu(gpd->buffer);
+		__entry->dw3 = le32_to_cpu(gpd->dw3_info);
+	),
+	TP_printk("%s: gpd %p - %08x %08x %08x %08x",
+		__get_str(name), __entry->gpd,
+		__entry->dw0, __entry->dw1,
+		__entry->dw2, __entry->dw3
+	)
+);
+
+DEFINE_EVENT(mtu3_log_gpd, mtu3_prepare_gpd,
+	TP_PROTO(struct mtu3_ep *mep, struct qmu_gpd *gpd),
+	TP_ARGS(mep, gpd)
+);
+
+DEFINE_EVENT(mtu3_log_gpd, mtu3_complete_gpd,
+	TP_PROTO(struct mtu3_ep *mep, struct qmu_gpd *gpd),
+	TP_ARGS(mep, gpd)
+);
+
+DEFINE_EVENT(mtu3_log_gpd, mtu3_zlp_exp_gpd,
+	TP_PROTO(struct mtu3_ep *mep, struct qmu_gpd *gpd),
+	TP_ARGS(mep, gpd)
+);
+
+DECLARE_EVENT_CLASS(mtu3_log_ep,
+	TP_PROTO(struct mtu3_ep *mep),
+	TP_ARGS(mep),
+	TP_STRUCT__entry(
+		__string(name, mep->name)
+		__field(unsigned int, type)
+		__field(unsigned int, slot)
+		__field(unsigned int, maxp)
+		__field(unsigned int, mult)
+		__field(unsigned int, maxburst)
+		__field(unsigned int, flags)
+		__field(unsigned int, direction)
+		__field(struct mtu3_gpd_ring *, gpd_ring)
+	),
+	TP_fast_assign(
+		__assign_str(name, mep->name);
+		__entry->type = mep->type;
+		__entry->slot = mep->slot;
+		__entry->maxp = mep->ep.maxpacket;
+		__entry->mult = mep->ep.mult;
+		__entry->maxburst = mep->ep.maxburst;
+		__entry->flags = mep->flags;
+		__entry->direction = mep->is_in;
+		__entry->gpd_ring = &mep->gpd_ring;
+	),
+	TP_printk("%s: type %d maxp %d slot %d mult %d burst %d ring %p/%pad flags %c:%c%c%c:%c",
+		__get_str(name), __entry->type,
+		__entry->maxp, __entry->slot,
+		__entry->mult, __entry->maxburst,
+		__entry->gpd_ring, &__entry->gpd_ring->dma,
+		__entry->flags & MTU3_EP_ENABLED ? 'E' : 'e',
+		__entry->flags & MTU3_EP_STALL ? 'S' : 's',
+		__entry->flags & MTU3_EP_WEDGE ? 'W' : 'w',
+		__entry->flags & MTU3_EP_BUSY ? 'B' : 'b',
+		__entry->direction ? '<' : '>'
+	)
+);
+
+DEFINE_EVENT(mtu3_log_ep, mtu3_gadget_ep_enable,
+	TP_PROTO(struct mtu3_ep *mep),
+	TP_ARGS(mep)
+);
+
+DEFINE_EVENT(mtu3_log_ep, mtu3_gadget_ep_disable,
+	TP_PROTO(struct mtu3_ep *mep),
+	TP_ARGS(mep)
+);
+
+DEFINE_EVENT(mtu3_log_ep, mtu3_gadget_ep_set_halt,
+	TP_PROTO(struct mtu3_ep *mep),
+	TP_ARGS(mep)
+);
+
+#endif /* __MTU3_TRACE_H__ */
+
+/* this part has to be here */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE mtu3_trace
+
+#include <trace/define_trace.h>
-- 
2.20.1

