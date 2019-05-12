Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23BEC04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733CD21851
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfBZa96J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfELBZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:25:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33507 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfELBZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:25:42 -0400
Received: by mail-io1-f65.google.com with SMTP id z4so7437941iol.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z1vpsRw/Qv1PVg/5Liz57VgaRQaN+KbLk5lodQH6TDw=;
        b=cfBZa96JjTLCleX9rHtjKSPZjVNLIMKBrGrDrCioSGAxcZJo38ptYGzlIfhhsq+NOm
         0iysZGuibyIfnoX8TU81kNctmAir2bHF/LxNtdfCWkqoOtgTCAo/nIo8ySA22ySk3mUB
         Ijb5tOmlKvhI+lqo5IaaGCF/abI+i92XgM9IdgLt0TWbWtwdXQ32wY7K9QnDZEZwyddU
         BUKklLop8JlrlZP3cGrn+Kk0cI7wrO9OQSNfiG10/wE7NC6SIBgDsHoMzOJeMl28U9c7
         9svfyCTUmQVX17AqiCyCa/EwmGYJxMd4wzYelviJVxoZLw4rtuq3Zk3DmiBEfTwqain2
         KClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z1vpsRw/Qv1PVg/5Liz57VgaRQaN+KbLk5lodQH6TDw=;
        b=SLQ1mC4jFL3dSmtHXXqPx8F0OTdUOy2C1hXjpqBbiQ9X74nEec520YRv8soMXYYbsz
         vasU3XxLTp1DMyEY3Vc3fFR3ShvLGvHyVxIMB/ByrALHThoUuc7+KPK096vgJKPxMwuy
         0yJekBxwcQdKkvRUP831o/G52d3BbbwGm9k87CJdhSIStjapQ4Ff4wgX5FymzkC7q9Hq
         f+U4t3myqWgE/t6xrxglx1hAgRYBuFfXgi8CvRcPpCcDWjDbwB4qAi1CLhE5L/VZ9TNW
         Sz9ZvswckhPsnGAIdvrncgYNlakntfmjY16Mfu6qwO74Al3f+7Yt8SznOfCKzdKY27Kw
         03eQ==
X-Gm-Message-State: APjAAAUyzW4M5ITWmMWzS7f8KIRxTzPmADAvyp1+3D+vS0BhtmO9SdWc
        lg5+H4/jBnG0Bj76o76XWayAJg==
X-Google-Smtp-Source: APXvYqwxpJEKYmPQd7mezr0OGUKn+Wav9N1rSSVuN2TC/PK5K0RjIzyMTPWSTt3ucQXYfnEqjoCCiA==
X-Received: by 2002:a05:6602:1d6:: with SMTP id w22mr2928270iot.215.1557624340875;
        Sat, 11 May 2019 18:25:40 -0700 (PDT)
Received: from shibby.hil-lafwehx.chi.wayport.net (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.gmail.com with ESMTPSA id u134sm1579013itb.32.2019.05.11.18.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:25:40 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [PATCH 09/18] soc: qcom: ipa: GSI transactions
Date:   Sat, 11 May 2019 20:24:59 -0500
Message-Id: <20190512012508.10608-10-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512012508.10608-1-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements GSI transactions.  A GSI transaction is a
structure that represents a single request (consisting of one or
more TREs) sent to the GSI hardware.  The last TRE in a transaction
includes a flag requesting that the GSI interrupt the AP to notify
that it has completed.

TREs are executed and completed strictly in order.  For this reason,
the completion of a single TRE implies that all previous TREs (in
particular all of those "earlier" in a transaction) have completed.

Whenever there is a need to send a request (a set of TREs) to the
IPA, a GSI transaction is allocated, specifying the number of TREs
that will be required.  Details of the request (e.g. transfer offsets
and length) are represented by in a Linux scatterlist array that is
incorporated in the transaction structure.

Once "filled," the transaction is committed.  The GSI transaction
layer performs all needed mapping (and unmapping) for DMA, and
issues the request to the hardware.  When the hardware signals
that the request has completed, a function in the IPA layer is
called, allowing for cleanup or followup activity to be performed
before the transaction is freed.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi_trans.c | 604 ++++++++++++++++++++++++++++++++++++
 drivers/net/ipa/gsi_trans.h | 106 +++++++
 2 files changed, 710 insertions(+)
 create mode 100644 drivers/net/ipa/gsi_trans.c
 create mode 100644 drivers/net/ipa/gsi_trans.h

diff --git a/drivers/net/ipa/gsi_trans.c b/drivers/net/ipa/gsi_trans.c
new file mode 100644
index 000000000000..e35e8369d5d0
--- /dev/null
+++ b/drivers/net/ipa/gsi_trans.c
@@ -0,0 +1,604 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+
+#include <linux/types.h>
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/refcount.h>
+#include <linux/scatterlist.h>
+
+#include "gsi.h"
+#include "gsi_private.h"
+#include "gsi_trans.h"
+#include "ipa_gsi.h"
+#include "ipa_data.h"
+#include "ipa_cmd.h"
+
+/**
+ * DOC: GSI Transactions
+ *
+ * A GSI transaction abstracts the behavior of a GSI channel by representing
+ * everything about a related group of data transfers in a single structure.
+ * Most details of interaction with the GSI hardware are managed by the GSI
+ * transaction core, allowing users to simply describe transfers to be
+ * performed and optionally supply a callback function to run once the set
+ * of transfers has been completed.
+ *
+ * To perform a data transfer (or a related set of them), a user of the GSI
+ * transaction interface allocates a transaction, indicating the number of
+ * TREs required (one per data transfer).  If sufficient TREs are available,
+ * they are reserved for use in the transaction and the allocation succeeds.
+ * This way exhaustion of the available TREs in a channel ring is detected
+ * as early as possible.  All resources required to complete a transaction
+ * are allocated at transaction allocation time.
+ *
+ * Transfers performed as part of a transaction are represented in an array
+ * of Linux scatterlist structures.  This array is allocated with the
+ * transaction, and its entries must be initialized using standard
+ * scatterlist functions (such as sg_init_one() or skb_to_sgvec()).  The
+ * user must supply the total number of bytes represented by all transfers
+ * in the transaction.
+ *
+ * Once a transaction has been prepared, it is committed.  The GSI transaction
+ * layer is responsible for DMA mapping (and unmapping) memory described in
+ * the transaction's scatterlist array.  The only way committing a transaction
+ * fails is if this DMA mapping step returns an error.  Otherwise, ownership
+ * of the entire transaction is transferred to the GSI transaction core.  The
+ * GSI transaction code formats the content of the scatterlist array into the
+ * channel ring buffer and informs the hardware that new TREs are available
+ * to process.
+ *
+ * The last TRE in each transaction is marked to interrupt the AP when the
+ * GSI hardware has completed it.  Because transfers described by TREs are
+ * performed strictly in order, signaling the completion of just the last
+ * TRE in the transaction is sufficient to indicate the full transaction
+ * is complete.
+ *
+ * When a transaction is complete, ipa_gsi_trans_complete() is called by the
+ * GSI code into the IPA layer, allowing it to perform any final cleanup
+ * required before the transaction is freed.
+ *
+ * It is possible to await the completion of a transaction; only immediate
+ * commands currently use this functionality.
+ */
+
+/* gsi_tre->flags mask values (in CPU byte order) */
+#define GSI_TRE_FLAGS_CHAIN_FMASK	GENMASK(0, 0)
+#define GSI_TRE_FLAGS_IEOB_FMASK	GENMASK(8, 8)
+#define GSI_TRE_FLAGS_IEOT_FMASK	GENMASK(9, 9)
+#define GSI_TRE_FLAGS_BEI_FMASK		GENMASK(10, 10)
+#define GSI_TRE_FLAGS_TYPE_FMASK	GENMASK(23, 16)
+
+/* Hardware values representing a transfer element type */
+enum gsi_tre_type {
+	GSI_RE_XFER	= 0x2,
+	GSI_RE_IMMD_CMD	= 0x3,
+	GSI_RE_NOP	= 0x4,
+};
+
+/* Map a given ring entry index to the transaction associated with it */
+static void gsi_channel_trans_map(struct gsi_channel *channel, u32 index,
+				  struct gsi_trans *trans)
+{
+	channel->trans_info.map[index] = trans;
+}
+
+/* Return the transaction mapped to a given ring entry */
+struct gsi_trans *
+gsi_channel_trans_mapped(struct gsi_channel *channel, u32 index)
+{
+	return channel->trans_info.map[index];
+}
+
+/* Return the oldest completed transaction for a channel (or null) */
+struct gsi_trans *gsi_channel_trans_complete(struct gsi_channel *channel)
+{
+	return list_first_entry_or_null(&channel->trans_info.complete,
+					struct gsi_trans, links);
+}
+
+/* Move a transaction from the allocated list to the pending list */
+static void gsi_trans_move_pending(struct gsi_trans *trans)
+{
+	struct gsi_channel *channel = &trans->gsi->channel[trans->channel_id];
+	struct gsi_trans_info *trans_info = &channel->trans_info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&trans_info->spinlock, flags);
+
+	list_move_tail(&trans->links, &trans_info->pending);
+
+	spin_unlock_irqrestore(&trans_info->spinlock, flags);
+}
+
+/* Move a transaction and all of its predecessors from the pending list
+ * to the completed list.
+ */
+void gsi_trans_move_complete(struct gsi_trans *trans)
+{
+	struct gsi_channel *channel = &trans->gsi->channel[trans->channel_id];
+	struct gsi_trans_info *trans_info;
+	struct list_head list;
+	unsigned long flags;
+
+	trans_info = &channel->trans_info;
+
+	spin_lock_irqsave(&trans_info->spinlock, flags);
+
+	/* Move this transaction and all predecessors to completed list */
+	list_cut_position(&list, &trans_info->pending, &trans->links);
+	list_splice_tail(&list, &trans_info->complete);
+
+	spin_unlock_irqrestore(&trans_info->spinlock, flags);
+}
+
+/* Move a transaction from the completed list to the polled list */
+void gsi_trans_move_polled(struct gsi_trans *trans)
+{
+	struct gsi_channel *channel = &trans->gsi->channel[trans->channel_id];
+	struct gsi_trans_info *trans_info = &channel->trans_info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&trans_info->spinlock, flags);
+
+	list_move_tail(&trans->links, &trans_info->polled);
+
+	spin_unlock_irqrestore(&trans_info->spinlock, flags);
+}
+
+/* Allocate a GSI transaction on a channel */
+struct gsi_trans *
+gsi_channel_trans_alloc(struct gsi *gsi, u32 channel_id, u32 tre_count)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	struct gsi_trans_info *trans_info = &channel->trans_info;
+	struct gsi_trans *trans = NULL;
+	unsigned long flags;
+
+	/* Caller should know the limit is gsi_channel_trans_max() */
+	if (WARN_ON(tre_count > channel->data->tlv_count))
+		return NULL;
+
+	spin_lock_irqsave(&trans_info->spinlock, flags);
+
+	if (trans_info->tre_avail >= tre_count) {
+		u32 avail;
+
+		/* Allocate the transaction */
+		if (trans_info->pool_free == trans_info->pool_count)
+			trans_info->pool_free = 0;
+		trans = &trans_info->pool[trans_info->pool_free++];
+
+		/* Allocate the scatter/gather entries it will use.  If
+		 * what's needed would cross the end-of-pool boundary,
+		 * allocate them from the beginning.
+		 */
+		avail = trans_info->sg_pool_count - trans_info->sg_pool_free;
+		if (tre_count > avail)
+			trans_info->sg_pool_free = 0;
+		trans->sgl = &trans_info->sg_pool[trans_info->sg_pool_free];
+		trans->sgc = tre_count;
+		trans_info->sg_pool_free += tre_count;
+
+		/* We reserve the TREs now, but consume them at commit time */
+		trans_info->tre_avail -= tre_count;
+
+		list_add_tail(&trans->links, &trans_info->alloc);
+	}
+
+	spin_unlock_irqrestore(&trans_info->spinlock, flags);
+
+	if (!trans)
+		return NULL;
+
+	trans->gsi = gsi;
+	trans->channel_id = channel_id;
+	refcount_set(&trans->refcount, 1);
+	trans->tre_count = tre_count;
+	init_completion(&trans->completion);
+
+	/* We're reusing, so make sure all fields are reinitialized */
+	trans->dev = gsi->dev;
+	trans->result = 0;	/* Success assumed unless overwritten */
+	trans->data = NULL;
+
+	return trans;
+}
+
+/* Free a previously-allocated transaction (used only in case of error) */
+void gsi_trans_free(struct gsi_trans *trans)
+{
+	struct gsi_trans_info *trans_info;
+	struct gsi_channel *channel;
+	unsigned long flags;
+
+	if (!refcount_dec_and_test(&trans->refcount))
+		return;
+
+	channel = &trans->gsi->channel[trans->channel_id];
+	trans_info = &channel->trans_info;
+
+	spin_lock_irqsave(&trans_info->spinlock, flags);
+
+	list_del(&trans->links);
+	trans_info->tre_avail += trans->tre_count;
+
+	spin_unlock_irqrestore(&trans_info->spinlock, flags);
+}
+
+/* Compute the length/opcode value to use for a TRE */
+static __le16 gsi_tre_len_opcode(enum ipa_cmd_opcode opcode, u32 len)
+{
+	return opcode == IPA_CMD_NONE ? cpu_to_le16((u16)len)
+				      : cpu_to_le16((u16)opcode);
+}
+
+/* Compute the flags value to use for a given TRE */
+static __le32 gsi_tre_flags(bool last_tre, bool bei, enum ipa_cmd_opcode opcode)
+{
+	enum gsi_tre_type tre_type;
+	u32 tre_flags;
+
+	tre_type = opcode == IPA_CMD_NONE ? GSI_RE_XFER : GSI_RE_IMMD_CMD;
+	tre_flags = u32_encode_bits(tre_type, GSI_TRE_FLAGS_TYPE_FMASK);
+
+	/* Last TRE contains interrupt flags */
+	if (last_tre) {
+		/* All transactions end in a transfer completion interrupt */
+		tre_flags |= GSI_TRE_FLAGS_IEOT_FMASK;
+		/* Don't interrupt when outbound commands are acknowledged */
+		if (bei)
+			tre_flags |= GSI_TRE_FLAGS_BEI_FMASK;
+	} else {	/* All others indicate there's more to come */
+		tre_flags |= GSI_TRE_FLAGS_CHAIN_FMASK;
+	}
+
+	return cpu_to_le32(tre_flags);
+}
+
+static void gsi_trans_tre_fill(struct gsi_tre *dest_tre, dma_addr_t addr,
+			       u32 len, bool last_tre, bool bei,
+			       enum ipa_cmd_opcode opcode)
+{
+	struct gsi_tre tre;
+
+	tre.addr = cpu_to_le64(addr);
+	tre.len_opcode = gsi_tre_len_opcode(opcode, len);
+	tre.reserved = 0;
+	tre.flags = gsi_tre_flags(last_tre, bei, opcode);
+
+	*dest_tre = tre;	/* Write TRE as a single (16-byte) unit */
+}
+
+int gsi_trans_read_byte(struct gsi *gsi, u32 channel_id, dma_addr_t addr)
+{
+	struct gsi_channel *channel = &gsi->channel[channel_id];
+	struct gsi_trans_info *trans_info;
+	struct gsi_evt_ring *evt_ring;
+	struct gsi_tre *dest_tre;
+	bool exhausted = false;
+	unsigned long flags;
+	u32 wp_local;
+
+	/* assert(!channel->toward_ipa); */
+
+	trans_info = &channel->trans_info;
+	spin_lock_irqsave(&trans_info->spinlock, flags);
+
+	if (trans_info->tre_avail)
+		trans_info->tre_avail--;
+	else
+		exhausted = true;
+
+	spin_unlock_irqrestore(&trans_info->spinlock, flags);
+
+	if (exhausted)
+		return -EBUSY;
+
+	evt_ring = &gsi->evt_ring[channel->evt_ring_id];
+	spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
+
+	wp_local = channel->tre_ring.wp_local;
+	if (wp_local == channel->tre_ring.end)
+		wp_local = channel->tre_ring.base;
+	dest_tre = gsi_ring_virt(&channel->tre_ring, wp_local);
+
+	gsi_trans_tre_fill(dest_tre, addr, 1, true, false, IPA_CMD_NONE);
+
+	gsi_ring_wp_local_add(&channel->tre_ring, 1);
+
+	gsi_channel_doorbell(channel);
+
+	spin_unlock_irqrestore(&evt_ring->ring.spinlock, flags);
+
+	return 0;
+}
+
+/**
+ * __gsi_trans_commit() - Common GSI transaction commit code
+ * @trans:	Transaction to commit
+ * @opcode:	Immediate command opcode, or IPA_CMD_NONE
+ * @ring_db:	Whether to tell the hardware about these queued transfers
+ *
+ * @Return:	0 if successful, or a negative error code
+ *
+ * Maps the transactions's scatterlist array for DMA, and returns -ENOMEM
+ * if that fails.  Formats channel ring TRE entries based on the content of
+ * the scatterlist.  Records the transaction pointer in the map entry for
+ * the last ring entry used for the transaction so it can be recovered when
+ * it completes, and moves the transaction to the pending list.  Updates the
+ * channel ring pointer and optionally rings the doorbell.
+ */
+static int __gsi_trans_commit(struct gsi_trans *trans,
+			      enum ipa_cmd_opcode opcode, bool ring_db)
+{
+	struct gsi_channel *channel = &trans->gsi->channel[trans->channel_id];
+	enum dma_data_direction direction;
+	bool bei = channel->toward_ipa;
+	struct gsi_evt_ring *evt_ring;
+	struct scatterlist *sg;
+	struct gsi_tre *dest_tre;
+	u32 queued_trans_count;
+	u32 queued_byte_count;
+	unsigned long flags;
+	u32 byte_count = 0;
+	u32 wp_local;
+	u32 index;
+	u32 avail;
+	int ret;
+	u32 i;
+
+	direction = channel->toward_ipa ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	ret = dma_map_sg(trans->dev, trans->sgl, trans->sgc, direction);
+	if (!ret)
+		return -ENOMEM;
+
+	evt_ring = &channel->gsi->evt_ring[channel->evt_ring_id];
+
+	spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
+
+	/* We'll consume the entries available at the end of the ring,
+	 * switching to the beginning to finish if necessary.
+	 */
+	wp_local = channel->tre_ring.wp_local;
+	dest_tre = gsi_ring_virt(&channel->tre_ring, wp_local);
+
+	avail = (channel->tre_ring.end - wp_local) / sizeof(*dest_tre);
+
+	for_each_sg(trans->sgl, sg, trans->sgc, i) {
+		bool last_tre = i == trans->tre_count - 1;
+		dma_addr_t addr = sg_dma_address(sg);
+		u32 len = sg_dma_len(sg);
+
+		byte_count += len;
+		if (!avail--)
+			dest_tre = gsi_ring_virt(&channel->tre_ring,
+						 channel->tre_ring.base);
+
+		gsi_trans_tre_fill(dest_tre, addr, len, last_tre, bei, opcode);
+		dest_tre++;
+	}
+
+	if (channel->toward_ipa) {
+		/* We record TX bytes when they are sent */
+		trans->len = byte_count;
+		trans->trans_count = channel->trans_count;
+		trans->byte_count = channel->byte_count;
+		channel->trans_count++;
+		channel->byte_count += byte_count;
+	}
+
+	/* Advance the write pointer; record info for last used element */
+	gsi_ring_wp_local_add(&channel->tre_ring, trans->tre_count - 1);
+	index = ring_index(&channel->tre_ring, channel->tre_ring.wp_local);
+	gsi_channel_trans_map(channel, index, trans);
+	gsi_ring_wp_local_add(&channel->tre_ring, 1);
+
+	gsi_trans_move_pending(trans);
+
+	/* Ring doorbell if requested, or if all TREs are allocated */
+	if (ring_db || !channel->trans_info.tre_avail) {
+		/* Report what we're handing off to hardware for TX channels */
+		if (channel->toward_ipa) {
+			queued_trans_count = channel->trans_count -
+						channel->doorbell_trans_count;
+			queued_byte_count = channel->byte_count -
+						channel->doorbell_byte_count;
+			channel->doorbell_trans_count = channel->trans_count;
+			channel->doorbell_byte_count = channel->byte_count;
+
+			ipa_gsi_channel_tx_queued(trans->gsi,
+						  gsi_channel_id(channel),
+						  queued_trans_count,
+						  queued_byte_count);
+		}
+
+		gsi_channel_doorbell(channel);
+	}
+
+	spin_unlock_irqrestore(&evt_ring->ring.spinlock, flags);
+
+	return 0;
+}
+
+/* Commit a GSI transaction */
+int gsi_trans_commit(struct gsi_trans *trans, bool ring_db)
+{
+	return __gsi_trans_commit(trans, IPA_CMD_NONE, ring_db);
+}
+
+/* Commit a GSI command transaction and wait for it to complete */
+int gsi_trans_commit_command(struct gsi_trans *trans,
+			     enum ipa_cmd_opcode opcode)
+{
+	int ret;
+
+	refcount_inc(&trans->refcount);
+
+	ret = __gsi_trans_commit(trans, opcode, true);
+	if (ret)
+		goto out_free_trans;
+
+	wait_for_completion(&trans->completion);
+
+out_free_trans:
+	gsi_trans_free(trans);
+
+	return ret;
+}
+
+/* Commit a GSI command transaction, wait for it to complete, with timeout */
+int gsi_trans_commit_command_timeout(struct gsi_trans *trans,
+				     enum ipa_cmd_opcode opcode,
+				     unsigned long timeout)
+{
+	unsigned long timeout_jiffies = msecs_to_jiffies(timeout);
+	unsigned long remaining;
+	int ret;
+
+	refcount_inc(&trans->refcount);
+
+	ret = __gsi_trans_commit(trans, opcode, true);
+	if (ret)
+		goto out_free_trans;
+
+	remaining = wait_for_completion_timeout(&trans->completion,
+						timeout_jiffies);
+out_free_trans:
+	gsi_trans_free(trans);
+
+	return ret ? ret : remaining ? 0 : -ETIMEDOUT;
+}
+
+/* Return a channel's next completed transaction (or NULL) */
+void gsi_trans_complete(struct gsi_trans *trans)
+{
+	struct gsi_channel *channel = &trans->gsi->channel[trans->channel_id];
+	enum dma_data_direction direction;
+
+	direction = channel->toward_ipa ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+
+	dma_unmap_sg(trans->dev, trans->sgl, trans->sgc, direction);
+
+	ipa_gsi_trans_complete(trans);
+
+	complete(&trans->completion);
+
+	gsi_trans_free(trans);
+}
+
+/* Cancel a channel's pending transactions */
+void gsi_channel_trans_cancel_pending(struct gsi_channel *channel)
+{
+	struct gsi_trans_info *trans_info = &channel->trans_info;
+	u32 evt_ring_id = channel->evt_ring_id;
+	struct gsi *gsi = channel->gsi;
+	struct gsi_evt_ring *evt_ring;
+	struct gsi_trans *trans;
+	unsigned long flags;
+
+	evt_ring = &gsi->evt_ring[evt_ring_id];
+
+	spin_lock_irqsave(&evt_ring->ring.spinlock, flags);
+
+	list_for_each_entry(trans, &trans_info->pending, links)
+		trans->result = -ECANCELED;
+
+	list_splice_tail_init(&trans_info->pending, &trans_info->complete);
+
+	spin_unlock_irqrestore(&evt_ring->ring.spinlock, flags);
+
+	spin_lock_irqsave(&gsi->spinlock, flags);
+
+	if (gsi->event_enable_bitmap & BIT(evt_ring_id))
+		gsi_event_handle(gsi, evt_ring_id);
+
+	spin_unlock_irqrestore(&gsi->spinlock, flags);
+}
+
+/* Initialize a channel's GSI transaction info */
+int gsi_channel_trans_init(struct gsi_channel *channel)
+{
+	struct gsi_trans_info *trans_info = &channel->trans_info;
+	u32 tre_count = channel->data->tre_count;
+
+	trans_info->map = kcalloc(tre_count, sizeof(*trans_info->map),
+				  GFP_KERNEL);
+	if (!trans_info->map)
+		return -ENOMEM;
+
+	/* We will never need more transactions than there are TRE
+	 * entries in the transfer ring.  For that reason, we can
+	 * preallocate an array of (at least) that many transactions,
+	 * and use a single free index to determine the next one
+	 * available for allocation.
+	 */
+	trans_info->pool_count = tre_count;
+	trans_info->pool = kcalloc(trans_info->pool_count,
+				   sizeof(*trans_info->pool), GFP_KERNEL);
+	if (!trans_info->pool)
+		goto err_free_map;
+	/* If we get extra memory from the allocator, use it */
+	trans_info->pool_count =
+		ksize(trans_info->pool) / sizeof(*trans_info->pool);
+	trans_info->pool_free = 0;
+
+	/* While transactions are allocated one at a time, a transaction
+	 * can have multiple TREs.  The number of TRE entries in a single
+	 * transaction is limited by the number of TLV FIFO entries the
+	 * channel has.  We reserve TREs when a transaction is allocated,
+	 * but we don't actually use them until the transaction is
+	 * committed.
+	 *
+	 * A transaction uses a scatterlist array to represent the data
+	 * transfers implemented by the transaction.  Each scatterliest
+	 * element is used to fill a single TRE when the transaction is
+	 * committed.  As a result, we need the same number of scatterlist
+	 * elements as there are TREs in the transfer ring, and we can
+	 * preallocate them in a pool.
+	 *
+	 * If we allocate a few (tlv_count - 1) extra entries in our pool
+	 * we can always satisfy requests without ever worrying about
+	 * straddling the end of the array.  If there aren't enough
+	 * entries starting at the free index, we just allocate free
+	 * entries from the beginning of the pool.
+	 */
+	trans_info->sg_pool_count = tre_count + channel->data->tlv_count - 1;
+	trans_info->sg_pool = kcalloc(trans_info->sg_pool_count,
+				      sizeof(*trans_info->sg_pool), GFP_KERNEL);
+	if (!trans_info->sg_pool)
+		goto err_free_pool;
+	/* Use any extra memory we get from the allocator */
+	trans_info->sg_pool_count =
+		ksize(trans_info->sg_pool) / sizeof(*trans_info->sg_pool);
+	trans_info->sg_pool_free = 0;
+
+	spin_lock_init(&trans_info->spinlock);
+	trans_info->tre_avail = tre_count;	/* maximum active */
+	INIT_LIST_HEAD(&trans_info->alloc);
+	INIT_LIST_HEAD(&trans_info->pending);
+	INIT_LIST_HEAD(&trans_info->complete);
+	INIT_LIST_HEAD(&trans_info->polled);
+
+	return 0;
+
+err_free_pool:
+	kfree(trans_info->pool);
+err_free_map:
+	kfree(trans_info->map);
+
+	return -ENOMEM;
+}
+
+/* Inverse of gsi_channel_trans_init() */
+void gsi_channel_trans_exit(struct gsi_channel *channel)
+{
+	struct gsi_trans_info *trans_info = &channel->trans_info;
+
+	kfree(trans_info->sg_pool);
+	kfree(trans_info->pool);
+	kfree(trans_info->map);
+}
diff --git a/drivers/net/ipa/gsi_trans.h b/drivers/net/ipa/gsi_trans.h
new file mode 100644
index 000000000000..160902b077a7
--- /dev/null
+++ b/drivers/net/ipa/gsi_trans.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+#ifndef _GSI_TRANS_H_
+#define _GSI_TRANS_H_
+
+#include <linux/types.h>
+#include <linux/refcount.h>
+#include <linux/completion.h>
+
+struct scatterlist;
+struct device;
+
+struct gsi;
+struct gsi_trans;
+enum ipa_cmd_opcode;
+
+struct gsi_trans {
+	struct list_head links;		/* gsi_channel lists */
+
+	struct gsi *gsi;
+	u32 channel_id;
+
+	u32 tre_count;			/* # TREs requested */
+	u32 len;			/* total # bytes in sgl */
+	struct scatterlist *sgl;
+	u32 sgc;			/* # entries in sgl[] */
+
+	struct completion completion;
+	refcount_t refcount;
+
+	/* fields above are internal only */
+
+	struct device *dev;		/* Use this for DMA mapping */
+	long result;			/* RX count, 0, or error code */
+
+	u64 byte_count;			/* channel byte_count when committed */
+	u64 trans_count;		/* channel trans_count when committed */
+
+	void *data;
+};
+
+/**
+ * gsi_channel_trans_alloc() - Allocate a GSI transaction on a channel
+ * @gsi:	GSI pointer
+ * @channel_id:	Channel the transaction is associated with
+ * @tre_count:	Number of elements in the transaction
+ *
+ * @Return:	A GSI transaction structure, or a null pointer if all
+ *		available transactions are in use
+ */
+struct gsi_trans *gsi_channel_trans_alloc(struct gsi *gsi, u32 channel_id,
+					  u32 tre_count);
+
+/**
+ * gsi_trans_free() - Free a previously-allocated GSI transaction
+ * @trans:	Transaction to be freed
+ *
+ * Note: this should only be used in error paths, before the transaction is
+ * committed or in the event committing the transaction produces an error.
+ * Successfully committing a transaction passes ownership of the structure
+ * to the core transaction code.
+ */
+void gsi_trans_free(struct gsi_trans *trans);
+
+/**
+ * gsi_trans_commit() - Commit a GSI transaction
+ * @trans:	Transaction to commit
+ * @ring_db:	Whether to tell the hardware about these queued transfers
+ * @callback:	Function called when transaction has completed.
+ */
+int gsi_trans_commit(struct gsi_trans *trans, bool ring_db);
+
+/**
+ * gsi_trans_commit_command() - Commit a GSI command transaction and wait
+ *				wait for it to complete
+ * @trans:	Transaction to commit
+ */
+int gsi_trans_commit_command(struct gsi_trans *trans,
+			     enum ipa_cmd_opcode opcode);
+
+/**
+ * gsi_trans_commit_command_timeout() - Commit a GSI command transaction,
+ *					wait for it to complete, with timeout
+ * @trans:	Transaction to commit
+ * @ring_db:	Whether to tell the hardware about these queued transfers
+ * @timeout:	Timeout period (in milliseconds)
+ */
+int gsi_trans_commit_command_timeout(struct gsi_trans *trans,
+				     enum ipa_cmd_opcode opcode,
+				     unsigned long timeout);
+
+/**
+ * gsi_trans_read_byte() - Issue a single byte read TRE on a channel
+ * @gsi:	GSI pointer
+ * @channel_id:	Channel on which to read a byte
+ * @addr:	DMA address into which to transfer the one byte
+ *
+ * This is not a transaction operation at all.  It's defined here because
+ * it needs to be done in coordination with other transaction activity.
+ */
+int gsi_trans_read_byte(struct gsi *gsi, u32 channel_id, dma_addr_t addr);
+
+#endif /* _GSI_TRANS_H_ */
-- 
2.20.1

