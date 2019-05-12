Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6072EC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F972184E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KGQAaO4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfELBZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:25:46 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38473 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfELBZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:25:42 -0400
Received: by mail-io1-f67.google.com with SMTP id u2so1199717ior.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2P6lzbNz9LN9Yx2+EH0GhR5OaQPCQbRN02nIIRvlaS4=;
        b=KGQAaO4GXI0CwVfAc05qBUBFAm4jHqwH03NKU7Do02iJqC4fCVugge3qsbmQJbWZAY
         tb+hcsnfZXFCTruQ2cmeKuH9y1mD1hKdJFk14If3rLi2ThgP7HUiZxUDaANMJLmM4bX0
         o5fas9Zak/rqlKVLh+85eRYKF0Wx5p5VJySWH0lcba4IXJIcL95kOCqKdz6w3/8zEtVz
         dH3JPXheoAQP/vkl7F6cHB67udwtn++iE1x/iS2SYf/gHXyrhHRkBEuPmrtxZ6+yBwoY
         k6k5aIZWuclPhPEvP4bPH+zASUpCtKmfew1JKj54if9NKkXMBIy/Jrv6QPFs1J/joQSn
         D/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2P6lzbNz9LN9Yx2+EH0GhR5OaQPCQbRN02nIIRvlaS4=;
        b=WT27YkSEfnzswoqUOKj9I/7NtZ/W9yY5crfb1p0+m8nSDyilyKZnPFq9wGx/UKfsUe
         sNMvrEyglad2hwJC7OtrGo7qI2Gt7in4kION1ovkUW3X4VfNnFGnnF7lCyBEtTn+dWzS
         ieMLrjprvIXuYruOHRHasxP8aRbFpgGY7wBJILliCdO6fIYQ1/rOpsQ2azzSRonpuRPb
         78p5kg4aBAc9jas/fVTFBDUPOCU36wMkW+QrKCLy5nYQuTh72hzA2CppHTWsITD1b63B
         ZYDT48KUX+Mpyvb7Oo8bwmkZ+LrtxQhcg/A3jaKptzuO2KJgUjnb+OcxjGGm6/LCUGpr
         M7NQ==
X-Gm-Message-State: APjAAAVDW2lCkX8hjnoYoV+Yt+DFjLA1PPtGS5lslaJgy/0Ghrk0oQmA
        wE3jPxWO9nxRMO5d1PAuanUgjQ==
X-Google-Smtp-Source: APXvYqx7F9/v72J4OkViapgOseoY6Q+EDhSO1Bxqsp6rBNNkJNRQh4pB7h6TbegBU7aQY9+kAGohfw==
X-Received: by 2002:a6b:3b88:: with SMTP id i130mr11704792ioa.21.1557624339543;
        Sat, 11 May 2019 18:25:39 -0700 (PDT)
Received: from shibby.hil-lafwehx.chi.wayport.net (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.gmail.com with ESMTPSA id u134sm1579013itb.32.2019.05.11.18.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:25:38 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [PATCH 08/18] soc: qcom: ipa: the generic software interface
Date:   Sat, 11 May 2019 20:24:58 -0500
Message-Id: <20190512012508.10608-9-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512012508.10608-1-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes "gsi.c", which implements the generic software
interface (GSI) for IPA.  The generic software interface abstracts
channels, which provide a means of transferring data either from the
AP to the IPA, or from the IPA to the AP.  A ring buffer of "transfer
elements" (TREs) is used to describe data transfers to perform.  The
AP writes a doorbell register associated with a channel to let it know
it has added new entries (for an AP->IPA channel) or has finished
processing entries (for an IPA->AP channel).

Each channel also has an event ring buffer, used by the IPA to
communicate information about events related to a channel (for
example, the completion of TREs).  The IPA writes its own doorbell
register, which triggers an interrupt on the AP, to signal that
new event information has arrived.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 1741 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1741 insertions(+)
 create mode 100644 drivers/net/ipa/gsi.c

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
new file mode 100644
index 000000000000..e9dd40c058c6
--- /dev/null
+++ b/drivers/net/ipa/gsi.c
@@ -0,0 +1,1741 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018-2019 Linaro Ltd.
+ */
+
+#include <linux/types.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/completion.h>
+#include <linux/io.h>
+#include <linux/bug.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/netdevice.h>
+
+#include "gsi.h"
+#include "gsi_reg.h"
+#include "gsi_private.h"
+#include "gsi_trans.h"
+#include "ipa_gsi.h"
+#include "ipa_data.h"
+
+/**
+ * DOC: The IPA Generic Software Interface
+ *
+ * The generic software interface (GSI) is an integral component of the IPA,
+ * providing a well-defined communication layer between the AP subsystem
+ * and the IPA core.  The modem uses the GSI layer as well.
+ *
+ *	--------	     ---------
+ *	|      |	     |	     |
+ *	|  AP  +<---.	.----+ Modem |
+ *	|      +--. |	| .->+	     |
+ *	|      |  | |	| |  |	     |
+ *	--------  | |	| |  ---------
+ *		  v |	v |
+ *		--+-+---+-+--
+ *		|    GSI    |
+ *		|-----------|
+ *		|	    |
+ *		|    IPA    |
+ *		|	    |
+ *		-------------
+ *
+ * In the above diagram, the AP and Modem represent "execution environments"
+ * (EEs), which are independent operating environments that use the IPA for
+ * data transfer.
+ *
+ * Each EE uses a set of unidirectional GSI "channels," which allow transfer
+ * of data to or from the IPA.  A channel is implemented as a ring buffer,
+ * with a DRAM-resident array of "transfer elements" (TREs) available to
+ * describe transfers to or from other EEs through the IPA.  A transfer
+ * element can also contain an immediate command, requesting the IPA perform
+ * actions other than data transfer.
+ *
+ * Each TRE refers to a block of data--also located DRAM.  After writing one
+ * or more TREs to a channel, the writer (either the IPA or an EE) writes a
+ * doorbell register to inform the receiving side how many elements have
+ * been written.  Writing to a doorbell register triggers an interrupt on
+ * the receiver.
+ *
+ * Each channel has a GSI "event ring" associated with it.  An event ring
+ * is implemented very much like a channel ring, but is always directed from
+ * the IPA to an EE.  The IPA notifies an EE (such as the AP) about channel
+ * events by adding an entry to the event ring associated with the channel;
+ * when it writes the event ring's doorbell register the EE is interrupted.
+ * Each entry in an event ring contains a pointer to the channel TRE whose
+ * completion the event represents.
+ *
+ * Each TRE in a channel ring has a set of flags.  One flag indicates whether
+ * the completion of the transfer operation generates an entry (and possibly
+ * an interrupt) in the channel's event ring.  Oother flags allow transfer
+ * elements to be chained together, forming a single logical transaction.
+ * TRE flags are used to control whether and when interrupts are generated
+ * to signal completion of channel transfers.
+ *
+ * Elements in channel and event rings are completed (or consumed) strictly
+ * in order.  Completion of one entry implies the completion of all preceding
+ * entries.  A single completion interrupt can communicate the completion of
+ * many transfers.
+ *
+ * Note that all GSI registers are little-endian, which is the assumed
+ * endianness of I/O space accesses.  The accessor functions perform byte
+ * swapping if needed (i.e., for a big endian CPU).
+ */
+
+/* Delay period for interrupt moderation (in 32KHz IPA timer ticks) */
+#define IPA_GSI_EVT_RING_INT_MODT	(32 * 1) /* 1ms under 32KHz clock */
+
+#define GSI_CMD_TIMEOUT		5	/* seconds */
+
+#define GSI_MHI_ER_START	10	/* First reserved event number */
+#define GSI_MHI_ER_END		16	/* Last reserved event number */
+
+#define GSI_RESET_WA_MIN_SLEEP	1000	/* microseconds */
+#define GSI_RESET_WA_MAX_SLEEP	2000	/* microseconds */
+
+#define GSI_ISR_MAX_ITER	50
+
+/* Hardware values from the error log register error code field */
+enum gsi_err_code {
+	GSI_INVALID_TRE_ERR			= 0x1,
+	GSI_OUT_OF_BUFFERS_ERR			= 0x2,
+	GSI_OUT_OF_RESOURCES_ERR		= 0x3,
+	GSI_UNSUPPORTED_INTER_EE_OP_ERR		= 0x4,
+	GSI_EVT_RING_EMPTY_ERR			= 0x5,
+	GSI_NON_ALLOCATED_EVT_ACCESS_ERR	= 0x6,
+	GSI_HWO_1_ERR				= 0x8,
+};
+
+/* Hardware values from the error log register error type field */
+enum gsi_err_type {
+	GSI_ERR_TYPE_GLOB	= 0x1,
+	GSI_ERR_TYPE_CHAN	= 0x2,
+	GSI_ERR_TYPE_EVT	= 0x3,
+};
+
+/* Fields in an error log register at GSI_ERROR_LOG_OFFSET */
+#define GSI_LOG_ERR_ARG3_FMASK		GENMASK(3, 0)
+#define GSI_LOG_ERR_ARG2_FMASK		GENMASK(7, 4)
+#define GSI_LOG_ERR_ARG1_FMASK		GENMASK(11, 8)
+#define GSI_LOG_ERR_CODE_FMASK		GENMASK(15, 12)
+#define GSI_LOG_ERR_VIRT_IDX_FMASK	GENMASK(23, 19)
+#define GSI_LOG_ERR_TYPE_FMASK		GENMASK(27, 24)
+#define GSI_LOG_ERR_EE_FMASK		GENMASK(31, 28)
+
+/* Hardware values used when programming an event ring */
+enum gsi_evt_chtype {
+	GSI_EVT_CHTYPE_MHI_EV	= 0x0,
+	GSI_EVT_CHTYPE_XHCI_EV	= 0x1,
+	GSI_EVT_CHTYPE_GPI_EV	= 0x2,
+	GSI_EVT_CHTYPE_XDCI_EV	= 0x3,
+};
+
+/* Hardware values used when programming a channel */
+enum gsi_channel_protocol {
+	GSI_CHANNEL_PROTOCOL_MHI	= 0x0,
+	GSI_CHANNEL_PROTOCOL_XHCI	= 0x1,
+	GSI_CHANNEL_PROTOCOL_GPI	= 0x2,
+	GSI_CHANNEL_PROTOCOL_XDCI	= 0x3,
+};
+
+/* Hardware values representing an event ring immediate command opcode */
+enum gsi_evt_ch_cmd_opcode {
+	GSI_EVT_ALLOCATE	= 0x0,
+	GSI_EVT_RESET		= 0x9,
+	GSI_EVT_DE_ALLOC	= 0xa,
+};
+
+/* Hardware values representing a channel immediate command opcode */
+enum gsi_ch_cmd_opcode {
+	GSI_CH_ALLOCATE	= 0x0,
+	GSI_CH_START	= 0x1,
+	GSI_CH_STOP	= 0x2,
+	GSI_CH_RESET	= 0x9,
+	GSI_CH_DE_ALLOC	= 0xa,
+	GSI_CH_DB_STOP	= 0xb,
+};
+
+/** gsi_gpi_channel_scratch - GPI protocol scratch register
+ *
+ * @max_outstanding_tre:
+ *	Defines the maximum number of TREs allowed in a single transaction
+ *	on a channel (in Bytes).  This determines the amount of prefetch
+ *	performed by the hardware.  We configure this to equal the size of
+ *	the TLV FIFO for the channel.
+ * @outstanding_threshold:
+ *	Defines the threshold (in Bytes) determining when the sequencer
+ *	should update the channel doorbell.  We configure this to equal
+ *	the size of two TREs.
+ */
+struct gsi_gpi_channel_scratch {
+	u64 rsvd1;
+	u16 rsvd2;
+	u16 max_outstanding_tre;
+	u16 rsvd3;
+	u16 outstanding_threshold;
+} __packed;
+
+/** gsi_channel_scratch - channel scratch configuration area
+ *
+ * The exact interpretation of this register is protocol-specific.
+ * We only use GPI channels; see struct gsi_gpi_channel_scratch, above.
+ */
+union gsi_channel_scratch {
+	struct gsi_gpi_channel_scratch gpi;
+	struct {
+		u32 word1;
+		u32 word2;
+		u32 word3;
+		u32 word4;
+	} data;
+} __packed;
+
+/* Enable or disable an event interrupt */
+static void
+_gsi_irq_control_event(struct gsi *gsi, u32 evt_ring_id, bool enable)
+{
+	u32 mask = BIT(evt_ring_id);
+	u32 val;
+
+	if (enable)
+		gsi->event_enable_bitmap |= mask;
+	else
+		gsi->event_enable_bitmap &= ~mask;
+
+	val = gsi->event_enable_bitmap;
+	iowrite32(val, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET);
+}
+
+static void gsi_irq_enable_event(struct gsi *gsi, u32 evt_ring_id)
+{
+	_gsi_irq_control_event(gsi, evt_ring_id, true);
+}
+
+static void gsi_irq_disable_event(struct gsi *gsi, u32 evt_ring_id)
+{
+	_gsi_irq_control_event(gsi, evt_ring_id, false);
+}
+
+/* Enable or disable all interrupt types */
+static void _gsi_irq_control_all(struct gsi *gsi, bool enable)
+{
+	u32 val;
+
+	/* Inter EE commands / interrupt are no supported. */
+	val = enable ? GSI_CNTXT_TYPE_IRQ_MSK_ALL : 0;
+	iowrite32(val, gsi->virt + GSI_CNTXT_TYPE_IRQ_MSK_OFFSET);
+
+	val = enable ? GENMASK(GSI_CHANNEL_MAX - 1, 0) : 0;
+	iowrite32(val, gsi->virt + GSI_CNTXT_SRC_CH_IRQ_MSK_OFFSET);
+
+	val = enable ? GENMASK(GSI_EVT_RING_MAX - 1, 0) : 0;
+	iowrite32(val, gsi->virt + GSI_CNTXT_SRC_EV_CH_IRQ_MSK_OFFSET);
+
+	/* IEOB interrupts are managed individually */
+	val = enable ? gsi->event_enable_bitmap : 0;
+	iowrite32(val, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET);
+
+	val = enable ? GSI_CNTXT_GLOB_IRQ_ALL : 0;
+	iowrite32(val, gsi->virt + GSI_CNTXT_GLOB_IRQ_EN_OFFSET);
+
+	/* Never enable GSI_BREAK_POINT */
+	val = enable ? GSI_CNTXT_GSI_IRQ_ALL & ~EN_BREAK_POINT_FMASK : 0;
+	iowrite32(val, gsi->virt + GSI_CNTXT_GSI_IRQ_EN_OFFSET);
+}
+
+static void gsi_irq_disable_all(struct gsi *gsi)
+{
+	_gsi_irq_control_all(gsi, false);
+}
+
+static void gsi_irq_enable_all(struct gsi *gsi)
+{
+	_gsi_irq_control_all(gsi, true);
+}
+
+/* Return the channel id associated with a given channel */
+u32 gsi_channel_id(struct gsi_channel *channel)
+{
+	return channel - &channel->gsi->channel[0];
+}
+
+/* Return the hardware's notion of the current state of a channel */
+static enum gsi_channel_state gsi_channel_state(struct gsi_channel *channel)
+{
+	u32 channel_id = gsi_channel_id(channel);
+	struct gsi *gsi = channel->gsi;
+	u32 val;
+
+	val = ioread32(gsi->virt + GSI_CH_C_CNTXT_0_OFFSET(channel_id));
+
+	return u32_get_bits(val, CHSTATE_FMASK);
+}
+
+/* Return the hardware's notion of the current state of an event ring */
+static enum gsi_evt_ring_state
+gsi_evt_ring_state(struct gsi *gsi, u32 evt_ring_id)
+{
+	u32 val = ioread32(gsi->virt + GSI_EV_CH_E_CNTXT_0_OFFSET(evt_ring_id));
+
+	return u32_get_bits(val, EV_CHSTATE_FMASK);
+}
+
+/* Channel control interrupt handler */
+static void gsi_isr_chan_ctrl(struct gsi *gsi)
+{
+	u32 channel_mask;
+
+	channel_mask = ioread32(gsi->virt + GSI_CNTXT_SRC_CH_IRQ_OFFSET);
+	iowrite32(channel_mask, gsi->virt + GSI_CNTXT_SRC_CH_IRQ_CLR_OFFSET);
+
+	while (channel_mask) {
+		u32 channel_id = __ffs(channel_mask);
+		struct gsi_channel *channel;
+
+		channel_mask ^= BIT(channel_id);
+
+		channel = &gsi->channel[channel_id];
+		channel->state = gsi_channel_state(channel);
+
+		complete(&channel->completion);
+	}
+}
+
+static void gsi_isr_evt_ctrl(struct gsi *gsi)
+{
+	u32 evt_mask;
+
+	evt_mask = ioread32(gsi->virt + GSI_CNTXT_SRC_EV_CH_IRQ_OFFSET);
+	iowrite32(evt_mask, gsi->virt + GSI_CNTXT_SRC_EV_CH_IRQ_CLR_OFFSET);
+
+	while (evt_mask) {
+		u32 evt_ring_id = __ffs(evt_mask);
+		struct gsi_evt_ring *evt_ring;
+
+		evt_mask ^= BIT(evt_ring_id);
+
+		evt_ring = &gsi->evt_ring[evt_ring_id];
+		evt_ring->state = gsi_evt_ring_state(gsi, evt_ring_id);
+
+		complete(&evt_ring->completion);
+	}
+}
+
+static void
+gsi_isr_glob_chan_err(struct gsi *gsi, u32 err_ee, u32 channel_id, u32 code)
+{
+	if (code == GSI_OUT_OF_RESOURCES_ERR) {
+		dev_err(gsi->dev, "channel %u out of resources\n", channel_id);
+		complete(&gsi->channel[channel_id].completion);
+		return;
+	}
+
+	/* Report, but otherwise ignore all other error codes */
+	WARN(true, "channel %u global error ee 0x%08x code 0x%08x\n",
+	     channel_id, err_ee, code);
+}
+
+static void
+gsi_isr_glob_evt_err(struct gsi *gsi, u32 err_ee, u32 evt_ring_id, u32 code)
+{
+	if (code == GSI_OUT_OF_RESOURCES_ERR) {
+		struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
+		u32 channel_id = gsi_channel_id(evt_ring->channel);
+
+		complete(&evt_ring->completion);
+		dev_err(gsi->dev, "evt_ring for channel %u out of resources\n",
+			channel_id);
+		return;
+	}
+
+	/* Report, but otherwise ignore all other error codes */
+	WARN(true, "event ring 0x%08x global error ee %u code 0x%08x\n",
+	     evt_ring_id, err_ee, code);
+}
+
+static void gsi_isr_glob_err(struct gsi *gsi)
+{
+	enum gsi_err_type type;
+	enum gsi_err_code code;
+	u32 which;
+	u32 val;
+	u32 ee;
+
+	/* Get the logged error, then reinitialize the log */
+	val = ioread32(gsi->virt + GSI_ERROR_LOG_OFFSET);
+	iowrite32(0, gsi->virt + GSI_ERROR_LOG_OFFSET);
+	iowrite32(~0, gsi->virt + GSI_ERROR_LOG_CLR_OFFSET);
+
+	ee = u32_get_bits(val, GSI_LOG_ERR_EE_FMASK);
+	which = u32_get_bits(val, GSI_LOG_ERR_VIRT_IDX_FMASK);
+	type = u32_get_bits(val, GSI_LOG_ERR_TYPE_FMASK);
+	code = u32_get_bits(val, GSI_LOG_ERR_CODE_FMASK);
+
+	if (type == GSI_ERR_TYPE_CHAN)
+		gsi_isr_glob_chan_err(gsi, ee, which, code);
+	else if (type == GSI_ERR_TYPE_EVT)
+		gsi_isr_glob_evt_err(gsi, ee, which, code);
+	else	/* type GSI_ERR_TYPE_GLOB should be fatal */
+		WARN(true, "unexpected global error 0x%08x\n", type);
+}
+
+static void gsi_isr_glob_ee(struct gsi *gsi)
+{
+	u32 val;
+
+	val = ioread32(gsi->virt + GSI_CNTXT_GLOB_IRQ_STTS_OFFSET);
+
+	if (val & ERROR_INT_FMASK)
+		gsi_isr_glob_err(gsi);
+
+	iowrite32(val, gsi->virt + GSI_CNTXT_GLOB_IRQ_CLR_OFFSET);
+
+	val ^= ERROR_INT_FMASK;
+
+	if (val & EN_GP_INT1_FMASK)
+		dev_err(gsi->dev, "unexpected global INT1\n");
+	val ^= EN_GP_INT1_FMASK;
+
+	WARN(val, "unexpected global interrupt 0x%08x\n", val);
+}
+
+/* Returns true if the interrupt state (enabled or not) changed */
+static bool gsi_channel_intr(struct gsi_channel *channel, bool enable)
+{
+	u32 evt_ring_id = channel->evt_ring_id;
+	struct gsi *gsi = channel->gsi;
+	u32 mask = BIT(evt_ring_id);
+	unsigned long flags;
+	bool different;
+	u32 enabled;
+
+	spin_lock_irqsave(&gsi->spinlock, flags);
+
+	enabled = gsi->event_enable_bitmap & mask;
+	different = enable == !enabled;
+
+	if (different) {
+		if (enabled)
+			gsi_irq_disable_event(channel->gsi, evt_ring_id);
+		else
+			gsi_irq_enable_event(channel->gsi, evt_ring_id);
+	}
+
+	spin_unlock_irqrestore(&gsi->spinlock, flags);
+
+	return different;
+}
+
+/* This function is almost always called in interrupt context,
+ * meaning the interrupt is enabled.  The request to disable
+ * the interrupt here will therefore "succeed", that is, it
+ * will disable an enabled interrupt.
+ *
+ * However, this function is also called when cancelling pending
+ * transactions, and when that occurs it's possible interrupts are
+ * already disabled.  For that reason we only schedule NAPI if we
+ * actually caused interrupts to become disabled.
+ */
+void gsi_event_handle(struct gsi *gsi, u32 evt_ring_id)
+{
+	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
+	struct gsi_channel *channel = evt_ring->channel;
+
+	if (gsi_channel_intr(channel, false))
+		napi_schedule(&channel->napi);
+}
+
+static void gsi_isr_ieob(struct gsi *gsi)
+{
+	u32 evt_mask;
+
+	evt_mask = ioread32(gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_OFFSET);
+	evt_mask &= ioread32(gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET);
+	iowrite32(evt_mask, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_CLR_OFFSET);
+
+	while (evt_mask) {
+		u32 evt_ring_id = __ffs(evt_mask);
+
+		evt_mask ^= BIT(evt_ring_id);
+
+		gsi_event_handle(gsi, evt_ring_id);
+	}
+}
+
+static void gsi_isr_inter_ee_chan_ctrl(struct gsi *gsi)
+{
+	u32 channel_mask;
+
+	channel_mask = ioread32(gsi->virt + GSI_INTER_EE_SRC_CH_IRQ_OFFSET);
+	iowrite32(channel_mask, gsi->virt + GSI_INTER_EE_SRC_CH_IRQ_CLR_OFFSET);
+
+	while (channel_mask) {
+		u32 channel_id = __ffs(channel_mask);
+
+		/* not currently expected */
+		dev_err(gsi->dev, "ch %u inter-EE interrupt\n", channel_id);
+		channel_mask ^= BIT(channel_id);
+	}
+}
+
+static void gsi_isr_inter_ee_evt_ctrl(struct gsi *gsi)
+{
+	u32 evt_mask;
+
+	evt_mask = ioread32(gsi->virt + GSI_INTER_EE_SRC_EV_CH_IRQ_OFFSET);
+	iowrite32(evt_mask, gsi->virt + GSI_INTER_EE_SRC_EV_CH_IRQ_CLR_OFFSET);
+
+	while (evt_mask) {
+		u32 evt_ring_id = __ffs(evt_mask);
+
+		/* not currently expected */
+		dev_err(gsi->dev, "evt %u inter-EE interrupt\n", evt_ring_id);
+		evt_mask ^= BIT(evt_ring_id);
+	}
+}
+
+static void gsi_isr_general(struct gsi *gsi)
+{
+	u32 val;
+
+	val = ioread32(gsi->virt + GSI_CNTXT_GSI_IRQ_STTS_OFFSET);
+	iowrite32(val, gsi->virt + GSI_CNTXT_GSI_IRQ_CLR_OFFSET);
+
+	if (val & CLR_BREAK_POINT_FMASK)
+		dev_err(gsi->dev, "breakpoint!\n");
+	val ^= CLR_BREAK_POINT_FMASK;
+
+	WARN(val, "unexpected general interrupt 0x%08x\n", val);
+}
+
+/**
+ * gsi_isr() - Top level GSI interrupt service routine
+ * @irq:	Interrupt number (ignored)
+ * @dev_id:	Device id pointer supplied to request_irq()
+ *
+ * This is the main handler function registered for the GSI IRQ.  The
+ * GSI pointer is supplied as the "device id" value when the handler
+ * is registered, and is provided here.  Each type of interrupt has a
+ * separate handler function that is called from here.
+ */
+static irqreturn_t gsi_isr(int irq, void *dev_id)
+{
+	struct gsi *gsi = dev_id;
+	u32 intr_mask;
+	u32 cnt = 0;
+
+	while ((intr_mask = ioread32(gsi->virt + GSI_CNTXT_TYPE_IRQ_OFFSET))) {
+		/* intr_mask contains bitmask of pending GSI interrupts */
+		do {
+			u32 gsi_intr = BIT(__ffs(intr_mask));
+
+			intr_mask ^= gsi_intr;
+
+			switch (gsi_intr) {
+			case CH_CTRL_FMASK:
+				gsi_isr_chan_ctrl(gsi);
+				break;
+			case EV_CTRL_FMASK:
+				gsi_isr_evt_ctrl(gsi);
+				break;
+			case GLOB_EE_FMASK:
+				gsi_isr_glob_ee(gsi);
+				break;
+			case IEOB_FMASK:
+				gsi_isr_ieob(gsi);
+				break;
+			case INTER_EE_CH_CTRL_FMASK:
+				gsi_isr_inter_ee_chan_ctrl(gsi);
+				break;
+			case INTER_EE_EV_CTRL_FMASK:
+				gsi_isr_inter_ee_evt_ctrl(gsi);
+				break;
+			case GENERAL_FMASK:
+				gsi_isr_general(gsi);
+				break;
+			default:
+				WARN(true, "%s: unrecognized type 0x%08x\n",
+				     __func__, gsi_intr);
+				break;
+			}
+		} while (intr_mask);
+
+		if (WARN(++cnt > GSI_ISR_MAX_ITER, "interrupt flood\n"))
+			break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* Return the virtual address associated with a 32-bit ring offset */
+void *gsi_ring_virt(struct gsi_ring *ring, u32 offset)
+{
+	return ring->virt + (offset - ring->base);
+}
+
+/* Return the ring index of a 32-bit ring offset */
+u32 ring_index(struct gsi_ring *ring, u32 offset)
+{
+	/* Code assumes channel and event ring elements are the same size */
+	BUILD_BUG_ON(sizeof(struct gsi_tre) !=
+		     sizeof(struct gsi_xfer_compl_evt));
+
+	return (offset - ring->base) / sizeof(struct gsi_tre);
+}
+
+/* Return the 32-bit ring offset that precedes the one at the given offset */
+static u32 ring_prev(struct gsi_ring *ring, u32 offset)
+{
+	if (offset == ring->base)
+		offset = ring->end;
+
+	return offset - sizeof(struct gsi_tre);
+}
+
+/* Advance a ring's local write pointer by the given number of slots */
+void gsi_ring_wp_local_add(struct gsi_ring *ring, u32 val)
+{
+	ring->wp_local += val * sizeof(struct gsi_tre);
+	if (ring->wp_local >= ring->end)
+		ring->wp_local -= ring->size;
+}
+
+/* Advance a ring's local read pointer by the given number of slots */
+static void gsi_ring_rp_local_add(struct gsi_ring *ring, u32 val)
+{
+	ring->rp_local += val * sizeof(struct gsi_tre);
+	if (ring->rp_local == ring->end)
+		ring->rp_local -= ring->size;
+}
+
+static void __gsi_evt_tx_update(struct gsi_evt_ring *evt_ring, u32 rp)
+{
+	struct gsi_channel *channel = evt_ring->channel;
+	struct gsi_ring *ring = &evt_ring->ring;
+	struct gsi_xfer_compl_evt *evt;
+	struct gsi_trans *first_trans;
+	struct gsi_trans *last_trans;
+	u32 trans_count;
+	u32 byte_count;
+	u32 tre_offset;
+	u32 tre_index;
+
+	/* Get the first (oldest) un-processed event */
+	evt = gsi_ring_virt(ring, ring->rp_local);
+	/* Get the TRE offset from that, and its associated transaction */
+	tre_offset = le64_to_cpu(evt->xfer_ptr) & GENMASK(31, 0);
+	tre_index = ring_index(&channel->tre_ring, tre_offset);
+	first_trans = gsi_channel_trans_mapped(channel, tre_index);
+
+	/* Get the last (newest) un-processed event */
+	evt = gsi_ring_virt(ring, ring_prev(ring, rp));
+	/* Get the TRE offset from that, and its associated transaction */
+	tre_offset = le64_to_cpu(evt->xfer_ptr) & GENMASK(31, 0);
+	tre_index = ring_index(&channel->tre_ring, tre_offset);
+	last_trans = gsi_channel_trans_mapped(channel, tre_index);
+
+	/* Report the total number of transactions and bytes that have
+	 * been transferred, *including* the last one.
+	 */
+	trans_count = last_trans->trans_count - first_trans->trans_count + 1;
+	byte_count = last_trans->byte_count - first_trans->byte_count;
+	byte_count += last_trans->len;
+
+	ipa_gsi_channel_tx_completed(channel->gsi, gsi_channel_id(channel),
+				     trans_count, byte_count);
+}
+
+/**
+ * __gsi_evt_rx_update() - Record lengths of received data
+ * @evt_ring:	Event ring associated with channel that received packets
+ * @ep:		Last event in the ring associated with a completed request
+ *
+ * Events for RX channels contain the actual number of bytes received into
+ * the buffer.  Every event has a transaction associated with it, and here
+ * we update each transaction's result code to record the received length.
+ *
+ * This function is called whenever we learn that the GSI hardware has filled
+ * new events since the last time we checked.  We need to update transaction
+ * lengths for events starting at the ring's rp_local up to (and including)
+ * the ring offset supplied as an argument.
+ *
+ * Events are sequential within the event ring, and transactions are
+ * sequential within the transaction pool.  We compute the first event's
+ * transaction pointer; the next event's transaction will just next one in
+ * the transaction pool.
+ *
+ * Note that @rp always points to an element *within* the event ring.
+ */
+static void __gsi_evt_rx_update(struct gsi_evt_ring *evt_ring, u32 rp)
+{
+	struct gsi_channel *channel = evt_ring->channel;
+	struct gsi_ring *ring = &evt_ring->ring;
+	struct gsi_xfer_compl_evt *evt_last;
+	struct gsi_xfer_compl_evt *evt_end;
+	struct gsi_trans_info *trans_info;
+	struct gsi_xfer_compl_evt *evt;
+	struct gsi_trans *trans_end;
+	struct gsi_trans *trans;
+	u32 byte_count = 0;
+	u32 tre_offset;
+	u32 tre_index;
+
+	/* Start with the first un-processed event */
+	evt = gsi_ring_virt(ring, ring->rp_local);
+	evt_last = gsi_ring_virt(ring, rp);
+	evt_end = gsi_ring_virt(ring, ring->end);
+
+	/* Event xfer_ptr records the TRE it's associated with */
+	tre_offset = le64_to_cpu(evt->xfer_ptr) & GENMASK(31, 0);
+	tre_index = ring_index(&channel->tre_ring, tre_offset);
+	/* Get the transaction mapped to the first unprocessed event */
+	trans = gsi_channel_trans_mapped(channel, tre_index);
+	trans_info = &channel->trans_info;
+	trans_end = &trans_info->pool[trans_info->pool_count];
+
+	do {
+		trans->len = __le16_to_cpu(evt->len);
+		trans->result = __le16_to_cpu(evt->len);
+		byte_count += trans->result;
+		if (++evt == evt_end)
+			evt = gsi_ring_virt(&evt_ring->ring, ring->base);
+		if (++trans == trans_end)
+			trans = &trans_info->pool[0];
+	} while (evt != evt_last);
+
+	/* We record RX bytes when they are received */
+	channel->byte_count += byte_count;
+	channel->trans_count++;
+}
+
+static void
+gsi_evt_ring_doorbell(struct gsi *gsi, u32 evt_ring_id)
+{
+	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
+	u32 val;
+
+	/* We only need to write the lower 32 bits */
+	val = evt_ring->ring.wp_local;
+	iowrite32(val, gsi->virt + GSI_EV_CH_E_DOORBELL_0_OFFSET(evt_ring_id));
+}
+
+static u32 gsi_channel_max(struct gsi *gsi)
+{
+	u32 val = ioread32(gsi->virt + GSI_GSI_HW_PARAM_2_OFFSET);
+
+	return u32_get_bits(val, NUM_CH_PER_EE_FMASK);
+}
+
+static u32 gsi_evt_ring_max(struct gsi *gsi)
+{
+	u32 val = ioread32(gsi->virt + GSI_GSI_HW_PARAM_2_OFFSET);
+
+	return u32_get_bits(val, NUM_EV_PER_EE_FMASK);
+}
+
+/* Issue a GSI command by writing a value to a register, then wait
+ * for completion to be signaled.  Returns true if successful or
+ * false if a timeout occurred.
+ */
+static void
+gsi_command(struct gsi *gsi, u32 reg, u32 val, struct completion *completion)
+{
+	unsigned long ret;
+
+	reinit_completion(completion);
+
+	iowrite32(val, gsi->virt + reg);
+	ret = wait_for_completion_timeout(completion, GSI_CMD_TIMEOUT * HZ);
+	WARN(!ret, "%s timeout reg 0x%08x val 0x%08x\n", __func__, reg, val);
+}
+
+/* Issue an event ring command and wait for it to complete */
+static void evt_ring_command(struct gsi *gsi, u32 evt_ring_id,
+			     enum gsi_evt_ch_cmd_opcode op)
+{
+	struct completion *completion = &gsi->evt_ring[evt_ring_id].completion;
+	u32 val = 0;
+
+	val |= u32_encode_bits(evt_ring_id, EV_CHID_FMASK);
+	val |= u32_encode_bits(op, EV_OPCODE_FMASK);
+
+	gsi_command(gsi, GSI_EV_CH_CMD_OFFSET, val, completion);
+}
+
+/* Issue a channel command and wait for it to complete */
+static void
+gsi_channel_command(struct gsi_channel *channel, enum gsi_ch_cmd_opcode op)
+{
+	u32 channel_id = gsi_channel_id(channel);
+	u32 val = 0;
+
+	val |= u32_encode_bits(channel_id, CH_CHID_FMASK);
+	val |= u32_encode_bits(op, CH_OPCODE_FMASK);
+
+	gsi_command(channel->gsi, GSI_CH_CMD_OFFSET, val, &channel->completion);
+}
+
+static int gsi_ring_alloc(struct gsi *gsi, struct gsi_ring *ring, u32 count)
+{
+	size_t size = roundup_pow_of_two(count * sizeof(struct gsi_tre));
+	dma_addr_t addr;
+
+	/* Hardware requires a power-of-2 ring size (and alignment) */
+	ring->virt = dma_alloc_coherent(gsi->dev, size, &addr, GFP_KERNEL);
+	if (!ring->virt)
+		return -ENOMEM;
+	ring->addr = addr;
+	ring->base = addr & GENMASK(31, 0);
+	ring->size = size;
+	ring->end = ring->base + size;
+	spin_lock_init(&ring->spinlock);
+
+	return 0;
+}
+
+static void gsi_ring_free(struct gsi *gsi, struct gsi_ring *ring)
+{
+	dma_free_coherent(gsi->dev, ring->size, ring->virt, ring->addr);
+	memset(ring, 0, sizeof(*ring));
+}
+
+static void gsi_evt_ring_prime(struct gsi *gsi, u32 evt_ring_id)
+{
+	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
+	struct gsi_ring *ring = &evt_ring->ring;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ring->spinlock, flags);
+
+	memset(ring->virt, 0, ring->size);
+	/* Point the write pointer at the last element */
+	ring->wp_local = ring_prev(ring, ring->base);
+	gsi_evt_ring_doorbell(gsi, evt_ring_id);
+
+	spin_unlock_irqrestore(&ring->spinlock, flags);
+}
+
+static void gsi_evt_ring_program(struct gsi *gsi, u32 evt_ring_id)
+{
+	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
+	u32 val = 0;
+
+	BUILD_BUG_ON(sizeof(struct gsi_xfer_compl_evt) >
+		     field_max(EV_ELEMENT_SIZE_FMASK));
+
+	val |= u32_encode_bits(GSI_EVT_CHTYPE_GPI_EV, EV_CHTYPE_FMASK);
+	val |= EV_INTYPE_FMASK;
+	val |= u32_encode_bits(sizeof(struct gsi_xfer_compl_evt),
+			       EV_ELEMENT_SIZE_FMASK);
+	iowrite32(val, gsi->virt + GSI_EV_CH_E_CNTXT_0_OFFSET(evt_ring_id));
+
+	val = u32_encode_bits(evt_ring->ring.size, EV_R_LENGTH_FMASK);
+	iowrite32(val, gsi->virt + GSI_EV_CH_E_CNTXT_1_OFFSET(evt_ring_id));
+
+	/* The context 2 and 3 registers store the low-order and
+	 * high-order 32 bits of the address of the event ring,
+	 * respectively.
+	 */
+	val = evt_ring->ring.base;
+	iowrite32(val, gsi->virt + GSI_EV_CH_E_CNTXT_2_OFFSET(evt_ring_id));
+
+	val = evt_ring->ring.addr >> 32;
+	iowrite32(val, gsi->virt + GSI_EV_CH_E_CNTXT_3_OFFSET(evt_ring_id));
+
+	/* Enable interrupt moderation by setting the moderation delay */
+	val = u32_encode_bits(IPA_GSI_EVT_RING_INT_MODT, MODT_FMASK);
+	val |= u32_encode_bits(1, MODC_FMASK);	/* comes from channel */
+	iowrite32(val, gsi->virt + GSI_EV_CH_E_CNTXT_8_OFFSET(evt_ring_id));
+
+	/* No MSI write data, and MSI address high and low address is 0 */
+	iowrite32(0, gsi->virt + GSI_EV_CH_E_CNTXT_9_OFFSET(evt_ring_id));
+	iowrite32(0, gsi->virt + GSI_EV_CH_E_CNTXT_10_OFFSET(evt_ring_id));
+	iowrite32(0, gsi->virt + GSI_EV_CH_E_CNTXT_11_OFFSET(evt_ring_id));
+
+	/* We don't need to get event read pointer updates */
+	iowrite32(0, gsi->virt + GSI_EV_CH_E_CNTXT_12_OFFSET(evt_ring_id));
+	iowrite32(0, gsi->virt + GSI_EV_CH_E_CNTXT_13_OFFSET(evt_ring_id));
+}
+
+static void gsi_ring_init(struct gsi_ring *ring)
+{
+	ring->wp = ring->base;
+	ring->wp_local = ring->base;
+	ring->rp_local = ring->base;
+}
+
+static void gsi_evt_ring_scratch_zero(struct gsi *gsi, u32 evt_ring_id)
+{
+	iowrite32(0, gsi->virt + GSI_EV_CH_E_SCRATCH_0_OFFSET(evt_ring_id));
+	iowrite32(0, gsi->virt + GSI_EV_CH_E_SCRATCH_1_OFFSET(evt_ring_id));
+}
+
+static int gsi_evt_ring_alloc_hw(struct gsi *gsi, u32 evt_ring_id)
+{
+	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
+	unsigned long flags;
+	u32 val;
+
+	evt_ring_command(gsi, evt_ring_id, GSI_EVT_ALLOCATE);
+
+	if (evt_ring->state != GSI_EVT_RING_STATE_ALLOCATED) {
+		dev_err(gsi->dev, "evt_ring_id %u allocation bad state %u\n",
+			evt_ring_id, evt_ring->state);
+		return -EIO;
+	}
+
+	gsi_evt_ring_program(gsi, evt_ring_id);
+	gsi_ring_init(&evt_ring->ring);
+	gsi_evt_ring_prime(gsi, evt_ring_id);
+
+	spin_lock_irqsave(&gsi->spinlock, flags);
+
+	/* Enable the event interrupt (clear it first in case pending) */
+	val = BIT(evt_ring_id);
+	iowrite32(val, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_CLR_OFFSET);
+	gsi_irq_enable_event(gsi, evt_ring_id);
+
+	spin_unlock_irqrestore(&gsi->spinlock, flags);
+
+	return 0;
+}
+
+static void gsi_evt_ring_free_hw(struct gsi *gsi, u32 evt_ring_id)
+{
+	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
+	unsigned long flags;
+
+	spin_lock_irqsave(&gsi->spinlock, flags);
+
+	/* Disable the event interrupt */
+	gsi_irq_disable_event(gsi, evt_ring_id);
+
+	spin_unlock_irqrestore(&gsi->spinlock, flags);
+
+	evt_ring_command(gsi, evt_ring_id, GSI_EVT_RESET);
+
+	gsi_evt_ring_program(gsi, evt_ring_id);
+	gsi_ring_init(&evt_ring->ring);
+	gsi_evt_ring_scratch_zero(gsi, evt_ring_id);
+	gsi_evt_ring_prime(gsi, evt_ring_id);
+
+	evt_ring_command(gsi, evt_ring_id, GSI_EVT_DE_ALLOC);
+}
+
+static int gsi_evt_ring_id_alloc(struct gsi *gsi)
+{
+	u32 evt_ring_id;
+
+	if (gsi->event_bitmap == ~0U)
+		return -ENOSPC;
+
+	evt_ring_id = ffz(gsi->event_bitmap);
+	gsi->event_bitmap |= BIT(evt_ring_id);
+
+	return (int)evt_ring_id;
+}
+
+static void gsi_evt_ring_id_free(struct gsi *gsi, u32 evt_ring_id)
+{
+	gsi->event_bitmap &= ~BIT(evt_ring_id);
+}
+
+void gsi_channel_doorbell(struct gsi_channel *channel)
+{
+	u32 channel_id = gsi_channel_id(channel);
+	struct gsi *gsi = channel->gsi;
+	u32 val;
+
+	channel->tre_ring.wp = channel->tre_ring.wp_local;
+
+	/* We only need to write the lower 32 bits */
+	val = channel->tre_ring.wp_local;
+	iowrite32(val, gsi->virt + GSI_CH_C_DOORBELL_0_OFFSET(channel_id));
+}
+
+static void __gsi_evt_ring_update(struct gsi *gsi, u32 evt_ring_id)
+{
+	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
+	u32 offset = GSI_EV_CH_E_CNTXT_4_OFFSET(evt_ring_id);
+	struct gsi_channel *channel = evt_ring->channel;
+	struct gsi_ring *tre_ring = &channel->tre_ring;
+	struct gsi_ring *ring = &evt_ring->ring;
+	u32 rp = ioread32(gsi->virt + offset);
+	struct gsi_xfer_compl_evt *evt;
+	struct gsi_trans *trans;
+	u32 tre_offset;
+	u32 tre_index;
+	u32 rp_last;
+
+	/* If we have nothing new to process we're done */
+	if (ring->rp_local == rp)
+		return;
+
+	/* Extract information from the newly-completed events.  For TX
+	 * channels, report the number of transferred bytes they represent.
+	 * For RX channels, update each transaction with the number of bytes
+	 * actually received.
+	 */
+	if (channel->toward_ipa)
+		__gsi_evt_tx_update(evt_ring, rp);
+	else
+		__gsi_evt_rx_update(evt_ring, rp);
+
+	/* Get the TRE pointer from the latest completion event, and get
+	 * the transaction associated with that.  Move all new transactions
+	 * up to and including that one to the completed list.
+	 */
+	rp_last = ring_prev(ring, rp);
+	evt = gsi_ring_virt(ring, rp_last);
+	tre_offset = le64_to_cpu(evt->xfer_ptr) & GENMASK(31, 0);
+	tre_index = ring_index(tre_ring, tre_offset);
+	trans = gsi_channel_trans_mapped(channel, tre_index);
+	gsi_trans_move_complete(trans);
+
+	/* We need nothing more from these TREs, so consume them */
+	tre_ring->rp_local = tre_offset;
+	gsi_ring_rp_local_add(tre_ring, 1);
+
+	/* Record that we're caught up on these events, and give the
+	 * completed ones back to the hardware for reuse.
+	 */
+	ring->rp_local = rp;
+	ring->wp_local = rp_last;
+	gsi_evt_ring_doorbell(channel->gsi, channel->evt_ring_id);
+}
+
+/* Consult hardware, move any newly completed transactions to completed list */
+static void gsi_channel_update(struct gsi_channel *channel)
+{
+	struct gsi_evt_ring *evt_ring;
+	unsigned long flags;
+
+	evt_ring = &channel->gsi->evt_ring[channel->evt_ring_id];
+
+	spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
+
+	__gsi_evt_ring_update(channel->gsi, channel->evt_ring_id);
+
+	spin_unlock_irqrestore(&evt_ring->ring.spinlock, flags);
+}
+
+/**
+ * gsi_channel_poll_one() - Return a single completed transaction on a channel
+ * @channel:	Channel to be polled
+ *
+ * @Return:	 Transaction pointer, or null if none are available
+ *
+ * This function returns the first entry on a channel's completed
+ * transaction list.  If that list is empty, the hardware is consulted
+ * to determine whether any new transactions have completed.  If so,
+ * they're moved to the completed list and the new first entry is
+ * returned.  If there are no more completed transactions, a null
+ * pointer is returned.
+ */
+static struct gsi_trans *gsi_channel_poll_one(struct gsi_channel *channel)
+{
+	struct gsi_trans *trans;
+
+	/* Get the first transaction from the completed list */
+	trans = gsi_channel_trans_complete(channel);
+	if (!trans) {
+		/* List is empty; see if there's more to do */
+		gsi_channel_update(channel);
+		trans = gsi_channel_trans_complete(channel);
+	}
+
+	if (trans)
+		gsi_trans_move_polled(trans);
+
+	return trans;
+}
+
+/**
+ * gsi_channel_poll() - NAPI poll function for a channel
+ * @napi:	NAPI structure for the channel
+ * @budget:	Budget supplied by NAPI core
+
+ * @channel_id:	Channel to be reset
+ *
+ * @Return:	 Number of items polled (<= budget)
+ *
+ * Single transactions completed by hardware are polled until either
+ * the budget is exhausted, or there are no more.  Each transaction
+ * polled is passed to gsi_trans_complete(), to perform remaining
+ * completion processing and retire/free the transaction.
+ */
+static int gsi_channel_poll(struct napi_struct *napi, int budget)
+{
+	struct gsi_channel *channel;
+	int count = 0;
+
+	channel = container_of(napi, struct gsi_channel, napi);
+	while (count < budget) {
+		struct gsi_trans *trans;
+
+		trans = gsi_channel_poll_one(channel);
+		if (!trans)
+			break;
+		gsi_trans_complete(trans);
+	}
+
+	if (count < budget) {
+		napi_complete(&channel->napi);
+		(void)gsi_channel_intr(channel, true);
+	}
+
+	return count;
+}
+
+/* The event bitmap represents which event ids are available for
+ * allocation.  Set bits are not available, clear bits can be used.
+ * This function initializes the map so all events supported by the
+ * hardware are available, then precludes any reserved events from
+ * being allocated.
+ */
+static u32 gsi_event_bitmap_init(u32 evt_ring_max)
+{
+	u32 event_bitmap = GENMASK(BITS_PER_LONG - 1, evt_ring_max);
+
+	return event_bitmap | GENMASK(GSI_MHI_ER_END, GSI_MHI_ER_START);
+}
+
+/* Setup function for event rings */
+static int gsi_evt_ring_setup(struct gsi *gsi)
+{
+	u32 evt_ring_max;
+	u32 evt_ring_id;
+
+	evt_ring_max = gsi_evt_ring_max(gsi);
+	dev_dbg(gsi->dev, "evt_ring_max %u\n", evt_ring_max);
+	if (evt_ring_max != GSI_EVT_RING_MAX)
+		return -EIO;
+
+	for (evt_ring_id = 0; evt_ring_id < GSI_EVT_RING_MAX; evt_ring_id++) {
+		struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
+
+		evt_ring->state = gsi_evt_ring_state(gsi, evt_ring_id);
+		if (evt_ring->state != GSI_EVT_RING_STATE_NOT_ALLOCATED)
+			return -EIO;
+	}
+
+	/* Enable all event interrupts */
+	gsi_irq_enable_all(gsi);
+
+	return 0;
+}
+
+/* Inverse of gsi_evt_ring_setup() */
+static void gsi_evt_ring_teardown(struct gsi *gsi)
+{
+	gsi_irq_disable_all(gsi);
+}
+
+static void gsi_channel_scratch_write(struct gsi_channel *channel)
+{
+	u32 channel_id = gsi_channel_id(channel);
+	struct gsi_gpi_channel_scratch *gpi;
+	union gsi_channel_scratch scr = { };
+	struct gsi *gsi = channel->gsi;
+	u32 val;
+
+	/* See comments above definition of gsi_gpi_channel_scratch */
+	gpi = &scr.gpi;
+	gpi->max_outstanding_tre = channel->data->tlv_count *
+					sizeof(struct gsi_tre);
+	gpi->outstanding_threshold = 2 * sizeof(struct gsi_tre);
+
+	val = scr.data.word1;
+	iowrite32(val, gsi->virt + GSI_CH_C_SCRATCH_0_OFFSET(channel_id));
+
+	val = scr.data.word2;
+	iowrite32(val, gsi->virt + GSI_CH_C_SCRATCH_1_OFFSET(channel_id));
+
+	val = scr.data.word3;
+	iowrite32(val, gsi->virt + GSI_CH_C_SCRATCH_2_OFFSET(channel_id));
+
+	/* We must preserve the upper 16 bits of the last scratch
+	 * register.  The next sequence assumes those bits remain
+	 * unchanged between the read and the write.
+	 */
+	val = ioread32(gsi->virt + GSI_CH_C_SCRATCH_3_OFFSET(channel_id));
+	val = (scr.data.word4 & GENMASK(31, 16)) | (val & GENMASK(15, 0));
+	iowrite32(val, gsi->virt + GSI_CH_C_SCRATCH_3_OFFSET(channel_id));
+}
+
+static void gsi_channel_program(struct gsi_channel *channel, bool doorbell)
+{
+	u32 channel_id = gsi_channel_id(channel);
+	struct gsi *gsi = channel->gsi;
+	u32 wrr_weight = 0;
+	u32 val = 0;
+
+	BUILD_BUG_ON(sizeof(struct gsi_tre) > field_max(ELEMENT_SIZE_FMASK));
+
+	val |= u32_encode_bits(GSI_CHANNEL_PROTOCOL_GPI, CHTYPE_PROTOCOL_FMASK);
+	if (channel->toward_ipa)
+		val |= CHTYPE_DIR_FMASK;
+	val |= u32_encode_bits(channel->evt_ring_id, ERINDEX_FMASK);
+	val |= u32_encode_bits(sizeof(struct gsi_tre), ELEMENT_SIZE_FMASK);
+	iowrite32(val, gsi->virt + GSI_CH_C_CNTXT_0_OFFSET(channel_id));
+
+	val = u32_encode_bits(channel->tre_ring.size, R_LENGTH_FMASK);
+	iowrite32(val, gsi->virt + GSI_CH_C_CNTXT_1_OFFSET(channel_id));
+
+	/* The context 2 and 3 registers store the low-order and
+	 * high-order 32 bits of the address of the channel ring,
+	 * respectively.
+	 */
+	val = channel->tre_ring.addr & GENMASK(31, 0);
+	iowrite32(val, gsi->virt + GSI_CH_C_CNTXT_2_OFFSET(channel_id));
+
+	val = channel->tre_ring.addr >> 32;
+	iowrite32(val, gsi->virt + GSI_CH_C_CNTXT_3_OFFSET(channel_id));
+
+	if (channel->data->wrr_priority)
+		wrr_weight = field_max(WRR_WEIGHT_FMASK);
+	val = u32_encode_bits(wrr_weight, WRR_WEIGHT_FMASK);
+
+	/* Max prefetch is 1 segment (do not set MAX_PREFETCH_FMASK) */
+	if (doorbell)
+		val |= USE_DB_ENG_FMASK;
+	iowrite32(val, gsi->virt + GSI_CH_C_QOS_OFFSET(channel_id));
+}
+
+static void
+__gsi_channel_config(struct gsi_channel *channel, bool doorbell_enable)
+{
+	gsi_channel_program(channel, doorbell_enable);
+	gsi_ring_init(&channel->tre_ring);
+	gsi_channel_scratch_write(channel);
+}
+
+void gsi_channel_config(struct gsi *gsi, u32 channel_id, bool doorbell_enable)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+
+	mutex_lock(&gsi->mutex);
+
+	__gsi_channel_config(channel, doorbell_enable);
+
+	mutex_unlock(&gsi->mutex);
+}
+
+/* Setup function for a single channel */
+static int gsi_channel_setup_one(struct gsi_channel *channel)
+{
+	struct gsi *gsi = channel->gsi;
+	int ret;
+
+	if (!gsi)
+		return 0;	/* Ignore uninitialized channels */
+
+	channel->state = gsi_channel_state(channel);
+	if (channel->state != GSI_CHANNEL_STATE_NOT_ALLOCATED)
+		return -EIO;
+
+	mutex_lock(&gsi->mutex);
+
+	ret = gsi_evt_ring_alloc_hw(gsi, channel->evt_ring_id);
+	if (ret) {
+		mutex_unlock(&gsi->mutex);
+
+		return ret;
+	}
+
+	gsi_channel_command(channel, GSI_CH_ALLOCATE);
+	ret = channel->state == GSI_CHANNEL_STATE_ALLOCATED ? 0 : -EIO;
+	if (ret) {
+		gsi_evt_ring_free_hw(gsi, channel->evt_ring_id);
+		mutex_unlock(&gsi->mutex);
+
+		return ret;
+	}
+
+	__gsi_channel_config(channel, true);
+
+	mutex_unlock(&gsi->mutex);
+
+	gsi->channel_stats.allocate++;
+
+	if (channel->toward_ipa)
+		netif_tx_napi_add(&gsi->dummy_dev, &channel->napi,
+				  gsi_channel_poll, NAPI_POLL_WEIGHT);
+	else
+		netif_napi_add(&gsi->dummy_dev, &channel->napi,
+			       gsi_channel_poll, NAPI_POLL_WEIGHT);
+
+	return 0;
+}
+
+/* Inverse of gsi_channel_setup_one() */
+static void gsi_channel_teardown_one(struct gsi_channel *channel)
+{
+	struct gsi *gsi = channel->gsi;
+
+	if (!gsi)
+		return;
+
+	netif_napi_del(&channel->napi);
+
+	mutex_lock(&gsi->mutex);
+
+	gsi_channel_command(channel, GSI_CH_DE_ALLOC);
+
+	gsi->channel_stats.free++;
+
+	gsi_evt_ring_free_hw(gsi, channel->evt_ring_id);
+
+	mutex_unlock(&gsi->mutex);
+
+	gsi_channel_trans_exit(channel);
+}
+
+/* Setup function for channels */
+static int gsi_channel_setup(struct gsi *gsi)
+{
+	u32 channel_max;
+	u32 channel_id;
+	int ret;
+
+	channel_max = gsi_channel_max(gsi);
+	dev_dbg(gsi->dev, "channel_max %u\n", channel_max);
+	if (channel_max != GSI_CHANNEL_MAX)
+		return -EIO;
+
+	ret = gsi_evt_ring_setup(gsi);
+	if (ret)
+		return ret;
+
+	for (channel_id = 0; channel_id < GSI_CHANNEL_MAX; channel_id++) {
+		ret = gsi_channel_setup_one(&gsi->channel[channel_id]);
+		if (ret)
+			goto err_unwind;
+	}
+
+	return 0;
+
+err_unwind:
+	while (channel_id--)
+		gsi_channel_teardown_one(&gsi->channel[channel_id]);
+	gsi_evt_ring_teardown(gsi);
+
+	return ret;
+}
+
+/* Inverse of gsi_channel_setup() */
+static void gsi_channel_teardown(struct gsi *gsi)
+{
+	u32 channel_id;
+
+	for (channel_id = 0; channel_id < GSI_CHANNEL_MAX; channel_id++) {
+		struct gsi_channel *channel = &gsi->channel[channel_id];
+
+		gsi_channel_teardown_one(channel);
+	}
+
+	gsi_evt_ring_teardown(gsi);
+}
+
+/* Setup function for GSI.  GSI firmware must be loaded and initialized */
+int gsi_setup(struct gsi *gsi)
+{
+	u32 val;
+
+	/* Here is where we first touch the GSI hardware */
+	val = ioread32(gsi->virt + GSI_GSI_STATUS_OFFSET);
+	if (!(val & ENABLED_FMASK)) {
+		dev_err(gsi->dev, "GSI has not been enabled\n");
+		return -EIO;
+	}
+
+	/* Initialize the error log */
+	iowrite32(0, gsi->virt + GSI_ERROR_LOG_OFFSET);
+
+	/* Writing 1 indicates IRQ interrupts; 0 would be MSI */
+	iowrite32(1, gsi->virt + GSI_CNTXT_INTSET_OFFSET);
+
+	return gsi_channel_setup(gsi);
+}
+
+/* Inverse of gsi_setup() */
+void gsi_teardown(struct gsi *gsi)
+{
+	gsi_channel_teardown(gsi);
+}
+
+/* Initialize a channel's event ring */
+static int gsi_channel_evt_ring_init(struct gsi_channel *channel)
+{
+	struct gsi *gsi = channel->gsi;
+	struct gsi_evt_ring *evt_ring;
+	int ret;
+
+	ret = gsi_evt_ring_id_alloc(gsi);
+	if (ret < 0)
+		return ret;
+	channel->evt_ring_id = ret;
+
+	evt_ring = &gsi->evt_ring[channel->evt_ring_id];
+	evt_ring->channel = channel;
+
+	ret = gsi_ring_alloc(gsi, &evt_ring->ring, channel->data->event_count);
+	if (ret)
+		goto err_free_evt_ring_id;
+
+	return 0;
+
+err_free_evt_ring_id:
+	gsi_evt_ring_id_free(gsi, channel->evt_ring_id);
+
+	return ret;
+}
+
+/* Inverse of gsi_channel_evt_ring_init() */
+static void gsi_channel_evt_ring_exit(struct gsi_channel *channel)
+{
+	struct gsi *gsi = channel->gsi;
+	struct gsi_evt_ring *evt_ring;
+
+	evt_ring = &gsi->evt_ring[channel->evt_ring_id];
+	gsi_ring_free(gsi, &evt_ring->ring);
+
+	gsi_evt_ring_id_free(gsi, channel->evt_ring_id);
+}
+
+/* Init function for event rings */
+static void gsi_evt_ring_init(struct gsi *gsi)
+{
+	u32 evt_ring_id;
+
+	BUILD_BUG_ON(GSI_EVT_RING_MAX >= BITS_PER_LONG);
+
+	gsi->event_bitmap = gsi_event_bitmap_init(GSI_EVT_RING_MAX);
+	gsi->event_enable_bitmap = 0;
+	for (evt_ring_id = 0; evt_ring_id < GSI_EVT_RING_MAX; evt_ring_id++)
+		init_completion(&gsi->evt_ring[evt_ring_id].completion);
+}
+
+/* Inverse of gsi_evt_ring_init() */
+static void gsi_evt_ring_exit(struct gsi *gsi)
+{
+	/* Nothing to do */
+}
+
+/* Init function for a single channel */
+static int
+gsi_channel_init_one(struct gsi *gsi, const struct gsi_ipa_endpoint_data *data)
+{
+	struct gsi_channel *channel;
+	int ret;
+
+	if (data->ee_id != GSI_EE_AP)
+		return 0;	/* Ignore non-AP channels */
+
+	if (data->channel_id >= GSI_CHANNEL_MAX)
+		return -EIO;
+	channel = &gsi->channel[data->channel_id];
+
+	channel->gsi = gsi;
+	channel->toward_ipa = data->toward_ipa;
+	channel->data = &data->channel;
+
+	init_completion(&channel->completion);
+
+	ret = gsi_channel_evt_ring_init(channel);
+	if (ret)
+		return ret;
+
+	ret = gsi_ring_alloc(gsi, &channel->tre_ring, channel->data->tre_count);
+	if (ret)
+		goto err_channel_evt_ring_exit;
+
+	ret = gsi_channel_trans_init(channel);
+	if (ret)
+		goto err_ring_free;
+
+	return 0;
+
+err_ring_free:
+	gsi_ring_free(gsi, &channel->tre_ring);
+err_channel_evt_ring_exit:
+	gsi_channel_evt_ring_exit(channel);
+
+	return ret;
+}
+
+/* Inverse of gsi_channel_init_one() */
+static void gsi_channel_exit_one(struct gsi_channel *channel)
+{
+	gsi_channel_trans_exit(channel);
+	gsi_ring_free(channel->gsi, &channel->tre_ring);
+	gsi_channel_evt_ring_exit(channel);
+}
+
+/* Init function for channels */
+static int gsi_channel_init(struct gsi *gsi, u32 data_count,
+			    const struct gsi_ipa_endpoint_data *data)
+{
+	int ret = 0;
+	u32 i;
+
+	gsi_evt_ring_init(gsi);
+	for (i = 0; i < data_count; i++) {
+		ret = gsi_channel_init_one(gsi, &data[i]);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+/* Inverse of gsi_channel_init() */
+static void gsi_channel_exit(struct gsi *gsi)
+{
+	u32 channel_id;
+
+	for (channel_id = 0; channel_id < GSI_CHANNEL_MAX; channel_id++)
+		gsi_channel_exit_one(&gsi->channel[channel_id]);
+	gsi_evt_ring_exit(gsi);
+}
+
+/* Init function for GSI.  GSI hardware does not need to be "ready" */
+int gsi_init(struct gsi *gsi, struct platform_device *pdev, u32 data_count,
+	     const struct gsi_ipa_endpoint_data *data)
+{
+	struct resource *res;
+	resource_size_t size;
+	unsigned int irq;
+	int ret;
+
+	gsi->dev = &pdev->dev;
+	init_dummy_netdev(&gsi->dummy_dev);
+
+	/* Get GSI memory range and map it */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gsi");
+	if (!res)
+		return -ENXIO;
+
+	size = resource_size(res);
+	if (res->start > U32_MAX || size > U32_MAX - res->start)
+		return -EINVAL;
+
+	gsi->virt = ioremap_nocache(res->start, size);
+	if (!gsi->virt)
+		return -ENOMEM;
+
+	ret = platform_get_irq_byname(pdev, "gsi");
+	if (ret < 0)
+		goto err_unmap_virt;
+	irq = ret;
+
+	ret = request_irq(irq, gsi_isr, 0, "gsi", gsi);
+	if (ret)
+		goto err_unmap_virt;
+	gsi->irq = irq;
+
+	ret = enable_irq_wake(gsi->irq);
+	if (ret)
+		dev_err(gsi->dev, "error %d enabling gsi wake irq\n", ret);
+	gsi->irq_wake_enabled = ret ? 0 : 1;
+
+	spin_lock_init(&gsi->spinlock);
+	mutex_init(&gsi->mutex);
+
+	ret = gsi_channel_init(gsi, data_count, data);
+	if (ret)
+		goto err_mutex_destroy;
+
+	return 0;
+
+err_mutex_destroy:
+	mutex_destroy(&gsi->mutex);
+	if (gsi->irq_wake_enabled)
+		(void)disable_irq_wake(gsi->irq);
+	free_irq(gsi->irq, gsi);
+err_unmap_virt:
+	iounmap(gsi->virt);
+
+	return ret;
+}
+
+/* Inverse of gsi_init() */
+void gsi_exit(struct gsi *gsi)
+{
+	gsi_channel_exit(gsi);
+
+	mutex_destroy(&gsi->mutex);
+	if (gsi->irq_wake_enabled)
+		(void)disable_irq_wake(gsi->irq);
+	free_irq(gsi->irq, gsi);
+	iounmap(gsi->virt);
+}
+
+/* Returns the maximum number of pending transactions on a channel */
+u32 gsi_channel_trans_max(struct gsi *gsi, u32 channel_id)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+
+	return channel->data->tre_count;
+}
+
+/* Returns the maximum number of TREs in a single transaction for a channel */
+u32 gsi_channel_trans_tre_max(struct gsi *gsi, u32 channel_id)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+
+	return channel->data->tlv_count;
+}
+
+/* Wait for all transaction activity on a channel to complete */
+void gsi_channel_trans_quiesce(struct gsi *gsi, u32 channel_id)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	struct gsi_trans_info *trans_info;
+	struct gsi_trans *trans = NULL;
+	struct gsi_evt_ring *evt_ring;
+	struct list_head *list;
+	unsigned long flags;
+
+	trans_info = &channel->trans_info;
+	evt_ring = &channel->gsi->evt_ring[channel->evt_ring_id];
+
+	spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
+
+	/* Find the last list to which a transaction was added */
+	if (!list_empty(&trans_info->alloc))
+		list = &trans_info->alloc;
+	else if (!list_empty(&trans_info->pending))
+		list = &trans_info->pending;
+	else if (!list_empty(&trans_info->complete))
+		list = &trans_info->complete;
+	else if (!list_empty(&trans_info->polled))
+		list = &trans_info->polled;
+	else
+		list = NULL;
+
+	if (list) {
+		struct gsi_trans *trans;
+
+		/* The last entry on this list is the last one allocated.
+		 * Grab a reference so we can wait for it.
+		 */
+		trans = list_last_entry(list, struct gsi_trans, links);
+		refcount_inc(&trans->refcount);
+	}
+
+	spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
+
+	/* If there is one, wait for it to complete */
+	if (trans) {
+		wait_for_completion(&trans->completion);
+		gsi_trans_free(trans);
+	}
+}
+
+/* Make a channel operational */
+int gsi_channel_start(struct gsi *gsi, u32 channel_id)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+
+	if (channel->state != GSI_CHANNEL_STATE_ALLOCATED &&
+	    channel->state != GSI_CHANNEL_STATE_STOP_IN_PROC &&
+	    channel->state != GSI_CHANNEL_STATE_STOPPED) {
+		dev_err(gsi->dev, "channel %u bad state %u\n", channel_id,
+			(u32)channel->state);
+		return -ENOTSUPP;
+	}
+
+	napi_enable(&channel->napi);
+
+	mutex_lock(&gsi->mutex);
+
+	gsi_channel_command(channel, GSI_CH_START);
+
+	mutex_unlock(&gsi->mutex);
+
+	gsi->channel_stats.start++;
+
+	return 0;
+}
+
+/* Stop an operational channel */
+int gsi_channel_stop(struct gsi *gsi, u32 channel_id)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	int ret;
+
+	if (channel->state == GSI_CHANNEL_STATE_STOPPED)
+		return 0;
+
+	if (channel->state != GSI_CHANNEL_STATE_STARTED &&
+	    channel->state != GSI_CHANNEL_STATE_STOP_IN_PROC &&
+	    channel->state != GSI_CHANNEL_STATE_ERROR) {
+		dev_err(gsi->dev, "channel %u bad state %u\n", channel_id,
+			(u32)channel->state);
+		return -ENOTSUPP;
+	}
+
+	gsi_channel_trans_quiesce(gsi, channel_id);
+
+	mutex_lock(&gsi->mutex);
+
+	gsi_channel_command(channel, GSI_CH_STOP);
+
+	mutex_unlock(&gsi->mutex);
+
+	if (channel->state == GSI_CHANNEL_STATE_STOPPED)
+		ret = 0;
+	else if (channel->state == GSI_CHANNEL_STATE_STOP_IN_PROC)
+		ret = -EAGAIN;
+	else
+		ret = -EIO;
+
+	gsi->channel_stats.stop++;
+
+	if (!ret)
+		napi_disable(&channel->napi);
+
+	return ret;
+}
+
+/* Reset a GSI channel */
+int gsi_channel_reset(struct gsi *gsi, u32 channel_id)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+
+	if (channel->state != GSI_CHANNEL_STATE_STOPPED) {
+		dev_err(gsi->dev, "channel %u bad state %u\n", channel_id,
+			(u32)channel->state);
+		return -ENOTSUPP;
+	}
+
+	/* In case the reset follows stop, need to wait 1 msec */
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
+
+	mutex_lock(&gsi->mutex);
+
+	gsi_channel_command(channel, GSI_CH_RESET);
+
+	/* workaround: reset RX channels again */
+	if (!channel->toward_ipa) {
+		usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
+		gsi_channel_command(channel, GSI_CH_RESET);
+	}
+
+	__gsi_channel_config(channel, true);
+
+	/* Cancel pending transactions before the channel is started again */
+	gsi_channel_trans_cancel_pending(channel);
+
+	mutex_unlock(&gsi->mutex);
+
+	gsi->channel_stats.reset++;
+
+	return 0;
+}
-- 
2.20.1

