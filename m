Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6F2C04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C882146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BUDCrgLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfELB0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:26:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45263 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfELBZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:25:39 -0400
Received: by mail-io1-f65.google.com with SMTP id b3so7382964iob.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wf0TOrrLxzKcHaG1KCgyPYskSeCrrYCI+kKDr0TmMA8=;
        b=BUDCrgLwsl4WnNTZ6tE0aic9rUUVYxa8OOwJropzaLf8+/1MIwqWr0QUcGE7fMTqti
         HkMdNaJVfyLArdAcvKgZVTYEvieJKJR28oTdg19YPhAyUEOj3hTLs1Z870GfaH11m4kF
         fKPX0WPt+EdLYIy/1LPU105uP7Tp9joXtqSyFrh6PdE/lS9DO7LrO7KfkPretagYKXkL
         ZDhOvFZMcI+KeX3rFbTLy8++J6cAWWvQYvXw1RU+xctVI0oU+0pAg5sp4jH5t5tdEio2
         L++He1woYIpsAxtyXAAi2wjBCF/H3IwqBCdiSPAw6Ajt5bMefwPm2zTJXcASdwn2BRYw
         1maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wf0TOrrLxzKcHaG1KCgyPYskSeCrrYCI+kKDr0TmMA8=;
        b=oG+j3TSphrQdodPOY+bBoBj4N72RftbssbOm9c2ShJv+s+2Uf3hPfG6vIhD0/FaRmW
         sUuzgFtwqwk0sykLjhTL0zFOBNa3zSbIxNADzYbEOjOWksaIYBjEpZaXHu4Ijd81n4YA
         ZWxFaKS6KXqZD/zjWG0ZLZp+d+YNwOk3dF5+EjWWqde9aifF8otDXj2pupUij394OgVC
         wuVt7dKuvW8cqtrxYFhk3a8w+FQ792CFV2X04swaHri+JHeUHbNINITfA+JFUtT+PqPU
         ucU1vypcGR5QfMB9L1W4RF5TUjbBbXh/+Vxu9kXEmN0HHMLhfpYB6E1jd0QTCPN8onMA
         +VPA==
X-Gm-Message-State: APjAAAVTvUQqiwdbjIaOlNc07UlFbx0s++HyyR1J0yQSQWA0MNIca1Xu
        v3p6Cc4TLOitO4B7NMVPuXS/6w==
X-Google-Smtp-Source: APXvYqzpnRKEOlWYS+rRSBE3veU3EB9Xp7zQ0J89j813EXb6wTfQCjPQcbXaP8OQSyqbx/lLeF4VRg==
X-Received: by 2002:a5e:a51a:: with SMTP id 26mr4317801iog.171.1557624337588;
        Sat, 11 May 2019 18:25:37 -0700 (PDT)
Received: from shibby.hil-lafwehx.chi.wayport.net (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.gmail.com with ESMTPSA id u134sm1579013itb.32.2019.05.11.18.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:25:36 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [PATCH 07/18] soc: qcom: ipa: GSI headers
Date:   Sat, 11 May 2019 20:24:57 -0500
Message-Id: <20190512012508.10608-8-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512012508.10608-1-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Generic Software Interface is a layer of the IPA driver that
abstracts the underlying hardware.  The next patch includes the
main code for GSI (including some additional documentation).  This
patch just includes three GSI header files.

  - "gsi.h" is the top-level GSI header file.  There is one of these
    associated with the IPA structure; in fact, it is embedded within
    the IPA structure.  (Were it not embedded this way, many of the
    definitions structures defined here could be private to GSI code.)
    The main abstraction implemented by the GSI code is the channel,
    and this header exposes several operations that can be performed
    on a GSI channel.

  - "gsi_private.h" exposes some definitions that are intended to be
    private, used only by the main GSI code and the GSI transaction
    code (defined in an upcoming patch).

  - Like "ipa_reg.h", "gsi_reg.h" defines the offsets of the 32-bit
    registers used by the GSI layer, along with masks that define the
    position and width of fields less than 32 bits located within
    these registers.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.h         | 241 ++++++++++++++++++++++
 drivers/net/ipa/gsi_private.h | 147 +++++++++++++
 drivers/net/ipa/gsi_reg.h     | 376 ++++++++++++++++++++++++++++++++++
 3 files changed, 764 insertions(+)
 create mode 100644 drivers/net/ipa/gsi.h
 create mode 100644 drivers/net/ipa/gsi_private.h
 create mode 100644 drivers/net/ipa/gsi_reg.h

diff --git a/drivers/net/ipa/gsi.h b/drivers/net/ipa/gsi.h
new file mode 100644
index 000000000000..8194a4110a40
--- /dev/null
+++ b/drivers/net/ipa/gsi.h
@@ -0,0 +1,241 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018-2019 Linaro Ltd.
+ */
+#ifndef _GSI_H_
+#define _GSI_H_
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/completion.h>
+#include <linux/platform_device.h>
+#include <linux/netdevice.h>
+
+#define GSI_CHANNEL_MAX		14
+#define GSI_EVT_RING_MAX	10
+
+struct device;
+struct scatterlist;
+struct platform_device;
+
+struct gsi;
+struct gsi_trans;
+struct gsi_channel_data;
+struct gsi_ipa_endpoint_data;
+
+/* Execution environment IDs */
+enum gsi_ee_id {
+	GSI_EE_AP	= 0,
+	GSI_EE_MODEM	= 1,
+	GSI_EE_UC	= 2,
+	GSI_EE_TZ	= 3,
+};
+
+/* Channel operation statistics, aggregated across all channels */
+struct gsi_channel_stats {
+	u64 allocate;
+	u64 start;
+	u64 stop;
+	u64 reset;
+	u64 free;
+};
+
+struct gsi_ring {
+	spinlock_t spinlock;		/* protects wp, rp updates */
+	void *virt;
+	dma_addr_t addr;
+	size_t size;
+	u32 base;			/* low 32 bits of addr */
+	u32 wp;
+	u32 wp_local;
+	u32 rp_local;
+	u32 end;			/* offset past last element */
+};
+
+struct gsi_trans_info {
+	struct gsi_trans **map;		/* TRE -> transaction map */
+	u32 pool_count;			/* # transactions in the pool */
+	struct gsi_trans *pool;		/* transaction allocation pool */
+	u32 pool_free;			/* next free transaction in pool */
+	u32 sg_pool_count;		/* # SGs in the allocation pool */
+	struct scatterlist *sg_pool;	/* SG allocation pool */
+	u32 sg_pool_free;		/* next free SG pool entry */
+
+	spinlock_t spinlock;		/* protects updates to the rest */
+	u32 tre_avail;			/* unallocated TREs in ring */
+	struct list_head alloc;		/* allocated, not committed */
+	struct list_head pending;	/* committed, awaiting completion */
+	struct list_head complete;	/* completed, awaiting poll */
+	struct list_head polled;	/* returned by gsi_channel_poll_one() */
+};
+
+/* Hardware values signifying the state of a channel */
+enum gsi_channel_state {
+	GSI_CHANNEL_STATE_NOT_ALLOCATED	= 0x0,
+	GSI_CHANNEL_STATE_ALLOCATED	= 0x1,
+	GSI_CHANNEL_STATE_STARTED	= 0x2,
+	GSI_CHANNEL_STATE_STOPPED	= 0x3,
+	GSI_CHANNEL_STATE_STOP_IN_PROC	= 0x4,
+	GSI_CHANNEL_STATE_ERROR		= 0xf,
+};
+
+/* We only care about channels between IPA and AP */
+struct gsi_channel {
+	struct gsi *gsi;
+	u32 toward_ipa;			/* 0: IPA->AP; 1: AP->IPA */
+
+	const struct gsi_channel_data *data;	/* initialization data */
+
+	struct completion completion;	/* signals channel state changes */
+	enum gsi_channel_state state;
+
+	struct gsi_ring tre_ring;
+	u32 evt_ring_id;
+
+	u64 byte_count;			/* total # bytes transferred */
+	u64 trans_count;		/* total # transactions */
+	u64 doorbell_byte_count;	/* TX byte_count at last doorbell */
+	u64 doorbell_trans_count;	/* TX trans_count at last doorbell */
+
+	struct gsi_trans_info trans_info;
+
+	struct napi_struct napi;
+};
+
+/* Hardware values signifying the state of an event ring */
+enum gsi_evt_ring_state {
+	GSI_EVT_RING_STATE_NOT_ALLOCATED	= 0x0,
+	GSI_EVT_RING_STATE_ALLOCATED		= 0x1,
+	GSI_EVT_RING_STATE_ERROR		= 0xf,
+};
+
+struct gsi_evt_ring {
+	struct gsi_channel *channel;
+	struct completion completion;	/* signals event ring state changes */
+	enum gsi_evt_ring_state state;
+	struct gsi_ring ring;
+};
+
+struct gsi {
+	struct device *dev;		/* Same as IPA device */
+	struct net_device dummy_dev;	/* needed for NAPI */
+	void __iomem *virt;
+	u32 irq;
+	u32 irq_wake_enabled;		/* 1: irq wake was enabled */
+	struct gsi_channel channel[GSI_CHANNEL_MAX];
+	struct gsi_channel_stats channel_stats;
+	struct gsi_evt_ring evt_ring[GSI_EVT_RING_MAX];
+	u32 event_bitmap;
+	u32 event_enable_bitmap;
+	spinlock_t spinlock;		/* global register updates */
+	struct mutex mutex;		/* protects commands, programming */
+};
+
+/**
+ * gsi_setup() - Set up the GSI subsystem
+ * @gsi:	Address of GSI structure embedded in an IPA structure
+ *
+ * @Return:	0 if successful, or a negative error code
+ *
+ * Performs initialization that must wait until the GSI hardware is
+ * ready (including firmware loaded).
+ */
+int gsi_setup(struct gsi *gsi);
+
+/**
+ * gsi_teardown() - Tear down GSI subsystem
+ * @gsi:	GSI address previously passed to a successful gsi_setup() call
+ */
+void gsi_teardown(struct gsi *gsi);
+
+/**
+ * gsi_channel_trans_max() - Channel maximum number of transactions
+ * @gsi:	GSI pointer
+ * @channel_id:	Channel whose limit is to be returned
+ *
+ * @Return:	 The maximum number of pending transactions on the channel
+ */
+u32 gsi_channel_trans_max(struct gsi *gsi, u32 channel_id);
+
+/**
+ * gsi_channel_trans_tre_max() - Return the maximum TREs per transaction
+ * @gsi:	GSI pointer
+ * @channel_id:	Channel whose limit is to be returned
+ *
+ * @Return:	 The maximum TRE count per transaction on the channel
+ */
+u32 gsi_channel_trans_tre_max(struct gsi *gsi, u32 channel_id);
+
+/**
+ * gsi_channel_trans_quiesce() - Wait for channel transactions to complete
+ * @gsi:	GSI pointer
+ * @channel_id:	Channel to quiesce
+ *
+ * Wait for all of a channel's currently-allocated transactions to
+ * be committed, complete, and be freed.
+ *
+ * NOTE:  Assumes no new transactions will be issued before it returns.
+ */
+void gsi_channel_trans_quiesce(struct gsi *gsi, u32 channel_id);
+
+/**
+ * gsi_channel_start() - Make a GSI channel operational
+ * @gsi:	GSI pointer
+ * @channel_id:	Channel to start
+ *
+ * @Return:	0 if successful, or a negative error code
+ */
+int gsi_channel_start(struct gsi *gsi, u32 channel_id);
+
+/**
+ * gsi_channel_stop() - Stop an operational GSI channel
+ * @gsi:	GSI pointer returned by gsi_setup()
+ * @channel_id:	Channel to stop
+ *
+ * @Return:	0 if successful, or a negative error code
+ */
+int gsi_channel_stop(struct gsi *gsi, u32 channel_id);
+
+/**
+ * gsi_channel_reset() - Reset a GSI channel
+ * @gsi:	GSI pointer
+ * @channel_id:	Channel to be reset
+ *
+ * @Return:	0 if successful, or a negative error code
+ *
+ * GSI hardware relinquishes ownership of all pending receive buffer
+ * transactions as a result of reset.  They will be completed with
+ * result code -ECANCELED.
+ */
+int gsi_channel_reset(struct gsi *gsi, u32 channel_id);
+
+/**
+ * gsi_channel_config() - Configure a GSI channel
+ * @gsi:		GSI pointer
+ * @channel_id:		Channel to be configured
+ * @doorbell_enable:	Whether to enable hardware doorbell engine
+ */
+void gsi_channel_config(struct gsi *gsi, u32 channel_id, bool doorbell_enable);
+
+/**
+ * gsi_init() - Initialize the GSI subsystem
+ * @gsi:	Address of GSI structure embedded in an IPA structure
+ * @pdev:	IPA platform device
+ *
+ * @Return:	0 if successful, or a negative error code
+ *
+ * Early stage initialization of the GSI subsystem, performing tasks
+ * that can be done before the GSI hardware is ready to use.
+ */
+int gsi_init(struct gsi *gsi, struct platform_device *pdev, u32 data_count,
+	     const struct gsi_ipa_endpoint_data *data);
+
+/**
+ * gsi_exit() - Exit the GSI subsystem
+ * @gsi:	GSI address previously passed to a successful gsi_init() call
+ */
+void gsi_exit(struct gsi *gsi);
+
+#endif /* _GSI_H_ */
diff --git a/drivers/net/ipa/gsi_private.h b/drivers/net/ipa/gsi_private.h
new file mode 100644
index 000000000000..31a665fb7756
--- /dev/null
+++ b/drivers/net/ipa/gsi_private.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018-2019 Linaro Ltd.
+ */
+#ifndef _GSI_PRIVATE_H_
+#define _GSI_PRIVATE_H_
+
+#include <linux/types.h>
+
+/* === NOTE:  Only "gsi.c" and "gsi_trans.c" should include this file === */
+
+struct gsi_trans;
+struct gsi_ring;
+struct gsi_channel;
+
+/* An entry in an event ring */
+struct gsi_xfer_compl_evt {
+	__le64 xfer_ptr;
+	__le16 len;
+	u8 rsvd1;
+	u8 code;
+	__le16 rsvd;
+	u8 type;
+	u8 chid;
+} __packed;
+
+/* An entry in a channel ring */
+struct gsi_tre {
+	__le64 addr;		/* DMA address */
+	__le16 len_opcode;	/* length in bytes or enum IPA_CMD_* */
+	__le16 reserved;
+	__le32 flags;		/* GSI_TRE_FLAGS_* */
+};
+
+/**
+ * gsi_trans_move_complete() - Mark a GSI transaction completed
+ * @trans:	Transaction to commit
+ */
+void gsi_trans_move_complete(struct gsi_trans *trans);
+
+/**
+ * gsi_trans_move_polled() - Mark a transaction polled
+ * @trans:	Transaction to update
+ */
+void gsi_trans_move_polled(struct gsi_trans *trans);
+
+/**
+ * gsi_trans_complete() - Complete a GSI transaction
+ * @trans:	Transaction to complete
+ *
+ * Marks a transaction complete (including freeing it).
+ */
+void gsi_trans_complete(struct gsi_trans *trans);
+
+/**
+ * gsi_channel_trans_mapped() - Return a transaction mapped to a TRE index
+ * @channel:	Channel associated with the transaction
+ * @index:	Index of the TRE having a transaction
+ *
+ * @Return:	The GSI transaction pointer associated with the TRE index
+ */
+struct gsi_trans *gsi_channel_trans_mapped(struct gsi_channel *channel,
+					   u32 index);
+
+/**
+ * gsi_channel_trans_complete() - Return a channel's next completed transaction
+ * @channel:	Channel whose next transaction is to be returned
+ *
+ * @Return:	The next completed transaction, or NULL if nothing new
+ */
+struct gsi_trans *gsi_channel_trans_complete(struct gsi_channel *channel);
+
+/**
+ * gsi_channel_trans_cancel_pending() - Cancel pending transactions
+ * @channel:	Channel whose pending transactions should be cancelled
+ *
+ * Cancel all pending transactions on a channel.  These are
+ * transactions that have been comitted but not yet completed.  This
+ * is required when the channel gets reset.  At that time all
+ * pending transactions will be completed with a result -ECANCELED.
+ *
+ * NOTE:  Transactions already complete at the time of this call are
+ *	  unaffected.
+ */
+void gsi_channel_trans_cancel_pending(struct gsi_channel *channel);
+
+/**
+ * gsi_channel_trans_init() - Initialize a channel's GSI transaction info
+ * @channel:	The channel whose transaction info is to be set up
+ *
+ * @Return:	0 if successful, or -ENOMEM on allocation failure
+ *
+ * Creates and sets up information for managing transactions on a channel
+ */
+int gsi_channel_trans_init(struct gsi_channel *channel);
+
+/**
+ * gsi_channel_trans_exit() - Inverse of gsi_channel_trans_init()
+ * @channel:	Channel whose transaction information is to be cleaned up
+ */
+void gsi_channel_trans_exit(struct gsi_channel *channel);
+
+/**
+ * gsi_channel_doorbell() - Ring a channel's doorbell
+ * @channel:	Channel whose doorbell should be rung
+ *
+ * Rings a channel's doorbell to inform the GSI hardware that new
+ * transactions (TREs, really) are available for it to process.
+ */
+void gsi_channel_doorbell(struct gsi_channel *channel);
+
+/**
+ * gsi_ring_virt() - Return virtual address for a 32-bit ring offset
+ * @ring:	Ring whose address is to be translated
+ * @addr:	32-bit ring "hardware" address (low 32 bits of DMA address)
+ */
+void *gsi_ring_virt(struct gsi_ring *ring, u32 offset);
+
+/**
+ * gsi_ring_index() - Return index for a 32-bit ring offset
+ * @ring:	Ring whose address is to be translated
+ * @addr:	32-bit ring "hardware" address (low 32 bits of DMA address)
+ */
+u32 ring_index(struct gsi_ring *ring, u32 offset);
+
+/**
+ * gsi_ring_wp_local_add() - Advance ring local write pointer
+ * @ring:	Ring whose address is to be translated
+ * @val:	Number of ring slots to add to local write pointer
+ */
+void gsi_ring_wp_local_add(struct gsi_ring *ring, u32 val);
+
+/**
+ * gsi_event_handle() - Handle the arrival of an event
+ * @gsi:	GSI pointer
+ * @evt_ring_id: Event ring for which an event has occurred
+ *
+ * This is normally used in IRQ handling when an IEOB interrupt
+ * arrives.  But it is also used when cancelling transactions
+ * following a channel reset.
+ */
+void gsi_event_handle(struct gsi *gsi, u32 evt_ring_id);
+
+u32 gsi_channel_id(struct gsi_channel *channel);
+
+#endif /* _GSI_PRIVATE_H_ */
diff --git a/drivers/net/ipa/gsi_reg.h b/drivers/net/ipa/gsi_reg.h
new file mode 100644
index 000000000000..969215ae1580
--- /dev/null
+++ b/drivers/net/ipa/gsi_reg.h
@@ -0,0 +1,376 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Copyright (c) 2015-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018-2019 Linaro Ltd.
+ */
+#ifndef _GSI_REG_H_
+#define _GSI_REG_H_
+
+#include <linux/bits.h>
+
+/* === NOTE:  Only "gsi.c" should include this file === */
+
+/**
+ * DOC: GSI Registers
+ *
+ * GSI registers are located within the "gsi" address space defined by Device
+ * Tree.  The offset of each register within that space is specified by
+ * symbols defined below.  The GSI address space is mapped to virtual memory
+ * space in gsi_init().  All GSI registers are 32 bits wide.
+ *
+ * Each register type is duplicated for a number of instances of something.
+ * For example, each GSI channel has its own set of registers defining its
+ * configuration.  The offset to a channel's set of registers is computed
+ * based on a "base" offset plus an additional "stride" amount computed by
+ * from the channel's ID.  For such registers, the offset is computed by a
+ * function-like macro that takes a parameter used in the computation.
+ *
+ * The offset of a register dependent on execution environment is computed
+ * by a macro that is supplied a parameter "ee".  The "ee" value is a member
+ * of the gsi_ee enumerated type.
+ *
+ * The offset of a channel register is computed by a macro that is supplied a
+ * parameter "ch".  The "ch" value is a channel id whose maximum value is 30
+ * (though the actual limit is hardware-dependent).
+ *
+ * The offset of an event register is computed by a macro that is supplied a
+ * parameter "ev".  The "ev" value is an event id whose maximum value is 15
+ * (though the actual limit is hardware-dependent).
+ */
+
+#define GSI_INTER_EE_SRC_CH_IRQ_OFFSET \
+			GSI_INTER_EE_N_SRC_CH_IRQ_OFFSET(GSI_EE_AP)
+#define GSI_INTER_EE_N_SRC_CH_IRQ_OFFSET(ee) \
+			(0x0000c018 + 0x1000 * (ee))
+
+#define GSI_INTER_EE_SRC_EV_CH_IRQ_OFFSET \
+			GSI_INTER_EE_N_SRC_EV_CH_IRQ_OFFSET(GSI_EE_AP)
+#define GSI_INTER_EE_N_SRC_EV_CH_IRQ_OFFSET(ee) \
+			(0x0000c01c + 0x1000 * (ee))
+
+#define GSI_INTER_EE_SRC_CH_IRQ_CLR_OFFSET \
+			GSI_INTER_EE_N_SRC_CH_IRQ_CLR_OFFSET(GSI_EE_AP)
+#define GSI_INTER_EE_N_SRC_CH_IRQ_CLR_OFFSET(ee) \
+			(0x0000c028 + 0x1000 * (ee))
+
+#define GSI_INTER_EE_SRC_EV_CH_IRQ_CLR_OFFSET \
+			GSI_INTER_EE_N_SRC_EV_CH_IRQ_CLR_OFFSET(GSI_EE_AP)
+#define GSI_INTER_EE_N_SRC_EV_CH_IRQ_CLR_OFFSET(ee) \
+			(0x0000c02c + 0x1000 * (ee))
+
+#define GSI_CH_C_CNTXT_0_OFFSET(ch) \
+		GSI_EE_N_CH_C_CNTXT_0_OFFSET((ch), GSI_EE_AP)
+#define GSI_EE_N_CH_C_CNTXT_0_OFFSET(ch, ee) \
+		(0x0001c000 + 0x4000 * (ee) + 0x80 * (ch))
+#define CHTYPE_PROTOCOL_FMASK		GENMASK(2, 0)
+#define CHTYPE_DIR_FMASK		GENMASK(3, 3)
+#define EE_FMASK			GENMASK(7, 4)
+#define CHID_FMASK			GENMASK(12, 8)
+#define ERINDEX_FMASK			GENMASK(18, 14)
+#define CHSTATE_FMASK			GENMASK(23, 20)
+#define ELEMENT_SIZE_FMASK		GENMASK(31, 24)
+
+#define GSI_CH_C_CNTXT_1_OFFSET(ch) \
+		GSI_EE_N_CH_C_CNTXT_1_OFFSET((ch), GSI_EE_AP)
+#define GSI_EE_N_CH_C_CNTXT_1_OFFSET(ch, ee) \
+		(0x0001c004 + 0x4000 * (ee) + 0x80 * (ch))
+#define R_LENGTH_FMASK			GENMASK(15, 0)
+
+#define GSI_CH_C_CNTXT_2_OFFSET(ch) \
+		GSI_EE_N_CH_C_CNTXT_2_OFFSET((ch), GSI_EE_AP)
+#define GSI_EE_N_CH_C_CNTXT_2_OFFSET(ch, ee) \
+		(0x0001c008 + 0x4000 * (ee) + 0x80 * (ch))
+
+#define GSI_CH_C_CNTXT_3_OFFSET(ch) \
+		GSI_EE_N_CH_C_CNTXT_3_OFFSET((ch), GSI_EE_AP)
+#define GSI_EE_N_CH_C_CNTXT_3_OFFSET(ch, ee) \
+		(0x0001c00c + 0x4000 * (ee) + 0x80 * (ch))
+
+#define GSI_CH_C_QOS_OFFSET(ch) \
+		GSI_EE_N_CH_C_QOS_OFFSET((ch), GSI_EE_AP)
+#define GSI_EE_N_CH_C_QOS_OFFSET(ch, ee) \
+		(0x0001c05c + 0x4000 * (ee) + 0x80 * (ch))
+#define WRR_WEIGHT_FMASK		GENMASK(3, 0)
+#define MAX_PREFETCH_FMASK		GENMASK(8, 8)
+#define USE_DB_ENG_FMASK		GENMASK(9, 9)
+
+#define GSI_CH_C_SCRATCH_0_OFFSET(ch) \
+		GSI_EE_N_CH_C_SCRATCH_0_OFFSET((ch), GSI_EE_AP)
+#define GSI_EE_N_CH_C_SCRATCH_0_OFFSET(ch, ee) \
+		(0x0001c060 + 0x4000 * (ee) + 0x80 * (ch))
+
+#define GSI_CH_C_SCRATCH_1_OFFSET(ch) \
+		GSI_EE_N_CH_C_SCRATCH_1_OFFSET((ch), GSI_EE_AP)
+#define GSI_EE_N_CH_C_SCRATCH_1_OFFSET(ch, ee) \
+		(0x0001c064 + 0x4000 * (ee) + 0x80 * (ch))
+
+#define GSI_CH_C_SCRATCH_2_OFFSET(ch) \
+		GSI_EE_N_CH_C_SCRATCH_2_OFFSET((ch), GSI_EE_AP)
+#define GSI_EE_N_CH_C_SCRATCH_2_OFFSET(ch, ee) \
+		(0x0001c068 + 0x4000 * (ee) + 0x80 * (ch))
+
+#define GSI_CH_C_SCRATCH_3_OFFSET(ch) \
+		GSI_EE_N_CH_C_SCRATCH_3_OFFSET((ch), GSI_EE_AP)
+#define GSI_EE_N_CH_C_SCRATCH_3_OFFSET(ch, ee) \
+		(0x0001c06c + 0x4000 * (ee) + 0x80 * (ch))
+
+#define GSI_EV_CH_E_CNTXT_0_OFFSET(ev) \
+		GSI_EE_N_EV_CH_E_CNTXT_0_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_0_OFFSET(ev, ee) \
+		(0x0001d000 + 0x4000 * (ee) + 0x80 * (ev))
+#define EV_CHTYPE_FMASK			GENMASK(3, 0)
+#define EV_EE_FMASK			GENMASK(7, 4)
+#define EV_EVCHID_FMASK			GENMASK(15, 8)
+#define EV_INTYPE_FMASK			GENMASK(16, 16)
+#define EV_CHSTATE_FMASK		GENMASK(23, 20)
+#define EV_ELEMENT_SIZE_FMASK		GENMASK(31, 24)
+
+#define GSI_EV_CH_E_CNTXT_1_OFFSET(ev) \
+		GSI_EE_N_EV_CH_E_CNTXT_1_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_1_OFFSET(ev, ee) \
+		(0x0001d004 + 0x4000 * (ee) + 0x80 * (ev))
+#define EV_R_LENGTH_FMASK		GENMASK(15, 0)
+
+#define GSI_EV_CH_E_CNTXT_2_OFFSET(ev) \
+		GSI_EE_N_EV_CH_E_CNTXT_2_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_2_OFFSET(ev, ee) \
+		(0x0001d008 + 0x4000 * (ee) + 0x80 * (ev))
+
+#define GSI_EV_CH_E_CNTXT_3_OFFSET(ev) \
+		GSI_EE_N_EV_CH_E_CNTXT_3_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_3_OFFSET(ev, ee) \
+		(0x0001d00c + 0x4000 * (ee) + 0x80 * (ev))
+
+#define GSI_EV_CH_E_CNTXT_4_OFFSET(ev) \
+		GSI_EE_N_EV_CH_E_CNTXT_4_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_4_OFFSET(ev, ee) \
+		(0x0001d010 + 0x4000 * (ee) + 0x80 * (ev))
+
+#define GSI_EV_CH_E_CNTXT_8_OFFSET(ev) \
+		GSI_EE_N_EV_CH_E_CNTXT_8_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_8_OFFSET(ev, ee) \
+		(0x0001d020 + 0x4000 * (ee) + 0x80 * (ev))
+#define MODT_FMASK			GENMASK(15, 0)
+#define MODC_FMASK			GENMASK(23, 16)
+#define MOD_CNT_FMASK			GENMASK(31, 24)
+
+#define GSI_EV_CH_E_CNTXT_9_OFFSET(ev) \
+		GSI_EE_N_EV_CH_E_CNTXT_9_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_9_OFFSET(ev, ee) \
+		(0x0001d024 + 0x4000 * (ee) + 0x80 * (ev))
+
+#define GSI_EV_CH_E_CNTXT_10_OFFSET(ev) \
+		GSI_EE_N_EV_CH_E_CNTXT_10_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_10_OFFSET(ev, ee) \
+		(0x0001d028 + 0x4000 * (ee) + 0x80 * (ev))
+
+#define GSI_EV_CH_E_CNTXT_11_OFFSET(ev) \
+		GSI_EE_N_EV_CH_E_CNTXT_11_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_11_OFFSET(ev, ee) \
+		(0x0001d02c + 0x4000 * (ee) + 0x80 * (ev))
+
+#define GSI_EV_CH_E_CNTXT_12_OFFSET(ev) \
+		GSI_EE_N_EV_CH_E_CNTXT_12_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_12_OFFSET(ev, ee) \
+		(0x0001d030 + 0x4000 * (ee) + 0x80 * (ev))
+
+#define GSI_EV_CH_E_CNTXT_13_OFFSET(ev) \
+		GSI_EE_N_EV_CH_E_CNTXT_13_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_CNTXT_13_OFFSET(ev, ee) \
+		(0x0001d034 + 0x4000 * (ee) + 0x80 * (ev))
+
+#define GSI_EV_CH_E_SCRATCH_0_OFFSET(ev) \
+		GSI_EE_N_EV_CH_E_SCRATCH_0_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_SCRATCH_0_OFFSET(ev, ee) \
+		(0x0001d048 + 0x4000 * (ee) + 0x80 * (ev))
+
+#define GSI_EV_CH_E_SCRATCH_1_OFFSET(ev) \
+		GSI_EE_N_EV_CH_E_SCRATCH_1_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_SCRATCH_1_OFFSET(ev, ee) \
+		(0x0001d04c + 0x4000 * (ee) + 0x80 * (ev))
+
+#define GSI_CH_C_DOORBELL_0_OFFSET(ch) \
+		GSI_EE_N_CH_C_DOORBELL_0_OFFSET((ch), GSI_EE_AP)
+#define GSI_EE_N_CH_C_DOORBELL_0_OFFSET(ch, ee) \
+			(0x0001e000 + 0x4000 * (ee) + 0x08 * (ch))
+
+#define GSI_EV_CH_E_DOORBELL_0_OFFSET(ev) \
+			GSI_EE_N_EV_CH_E_DOORBELL_0_OFFSET((ev), GSI_EE_AP)
+#define GSI_EE_N_EV_CH_E_DOORBELL_0_OFFSET(ev, ee) \
+			(0x0001e100 + 0x4000 * (ee) + 0x08 * (ev))
+
+#define GSI_GSI_STATUS_OFFSET \
+			GSI_EE_N_GSI_STATUS_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_GSI_STATUS_OFFSET(ee) \
+			(0x0001f000 + 0x4000 * (ee))
+#define ENABLED_FMASK			GENMASK(0, 0)
+
+#define GSI_CH_CMD_OFFSET \
+			GSI_EE_N_CH_CMD_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CH_CMD_OFFSET(ee) \
+			(0x0001f008 + 0x4000 * (ee))
+#define CH_CHID_FMASK			GENMASK(7, 0)
+#define CH_OPCODE_FMASK			GENMASK(31, 24)
+
+#define GSI_EV_CH_CMD_OFFSET \
+			GSI_EE_N_EV_CH_CMD_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_EV_CH_CMD_OFFSET(ee) \
+			(0x0001f010 + 0x4000 * (ee))
+#define EV_CHID_FMASK			GENMASK(7, 0)
+#define EV_OPCODE_FMASK			GENMASK(31, 24)
+
+#define GSI_GSI_HW_PARAM_2_OFFSET \
+			GSI_EE_N_GSI_HW_PARAM_2_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_GSI_HW_PARAM_2_OFFSET(ee) \
+			(0x0001f040 + 0x4000 * (ee))
+#define IRAM_SIZE_FMASK			GENMASK(2, 0)
+#define NUM_CH_PER_EE_FMASK		GENMASK(7, 3)
+#define NUM_EV_PER_EE_FMASK		GENMASK(12, 8)
+#define GSI_CH_PEND_TRANSLATE_FMASK	GENMASK(13, 13)
+#define GSI_CH_FULL_LOGIC_FMASK		GENMASK(14, 14)
+#define IRAM_SIZE_ONE_KB_FVAL			0
+#define IRAM_SIZE_TWO_KB_FVAL			1
+
+#define GSI_CNTXT_TYPE_IRQ_OFFSET \
+			GSI_EE_N_CNTXT_TYPE_IRQ_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_TYPE_IRQ_OFFSET(ee) \
+			(0x0001f080 + 0x4000 * (ee))
+#define CH_CTRL_FMASK			GENMASK(0, 0)
+#define EV_CTRL_FMASK			GENMASK(1, 1)
+#define GLOB_EE_FMASK			GENMASK(2, 2)
+#define IEOB_FMASK			GENMASK(3, 3)
+#define INTER_EE_CH_CTRL_FMASK		GENMASK(4, 4)
+#define INTER_EE_EV_CTRL_FMASK		GENMASK(5, 5)
+#define GENERAL_FMASK			GENMASK(6, 6)
+
+#define GSI_CNTXT_TYPE_IRQ_MSK_OFFSET \
+			GSI_EE_N_CNTXT_TYPE_IRQ_MSK_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_TYPE_IRQ_MSK_OFFSET(ee) \
+			(0x0001f088 + 0x4000 * (ee))
+#define MSK_CH_CTRL_FMASK		GENMASK(0, 0)
+#define MSK_EV_CTRL_FMASK		GENMASK(1, 1)
+#define MSK_GLOB_EE_FMASK		GENMASK(2, 2)
+#define MSK_IEOB_FMASK			GENMASK(3, 3)
+#define MSK_INTER_EE_CH_CTRL_FMASK	GENMASK(4, 4)
+#define MSK_INTER_EE_EV_CTRL_FMASK	GENMASK(5, 5)
+#define MSK_GENERAL_FMASK		GENMASK(6, 6)
+#define GSI_CNTXT_TYPE_IRQ_MSK_ALL	GENMASK(6, 0)
+
+#define GSI_CNTXT_SRC_CH_IRQ_OFFSET \
+			GSI_EE_N_CNTXT_SRC_CH_IRQ_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_CH_IRQ_OFFSET(ee) \
+			(0x0001f090 + 0x4000 * (ee))
+
+#define GSI_CNTXT_SRC_EV_CH_IRQ_OFFSET \
+			GSI_EE_N_CNTXT_SRC_EV_CH_IRQ_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_EV_CH_IRQ_OFFSET(ee) \
+			(0x0001f094 + 0x4000 * (ee))
+
+#define GSI_CNTXT_SRC_CH_IRQ_MSK_OFFSET \
+			GSI_EE_N_CNTXT_SRC_CH_IRQ_MSK_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_CH_IRQ_MSK_OFFSET(ee) \
+			(0x0001f098 + 0x4000 * (ee))
+
+#define GSI_CNTXT_SRC_EV_CH_IRQ_MSK_OFFSET \
+			GSI_EE_N_CNTXT_SRC_EV_CH_IRQ_MSK_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_EV_CH_IRQ_MSK_OFFSET(ee) \
+			(0x0001f09c + 0x4000 * (ee))
+
+#define GSI_CNTXT_SRC_CH_IRQ_CLR_OFFSET \
+			GSI_EE_N_CNTXT_SRC_CH_IRQ_CLR_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_CH_IRQ_CLR_OFFSET(ee) \
+			(0x0001f0a0 + 0x4000 * (ee))
+
+#define GSI_CNTXT_SRC_EV_CH_IRQ_CLR_OFFSET \
+			GSI_EE_N_CNTXT_SRC_EV_CH_IRQ_CLR_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_EV_CH_IRQ_CLR_OFFSET(ee) \
+			(0x0001f0a4 + 0x4000 * (ee))
+
+#define GSI_CNTXT_SRC_IEOB_IRQ_OFFSET \
+			GSI_EE_N_CNTXT_SRC_IEOB_IRQ_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_IEOB_IRQ_OFFSET(ee) \
+			(0x0001f0b0 + 0x4000 * (ee))
+
+#define GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET \
+			GSI_EE_N_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET(ee) \
+			(0x0001f0b8 + 0x4000 * (ee))
+
+#define GSI_CNTXT_SRC_IEOB_IRQ_CLR_OFFSET \
+			GSI_EE_N_CNTXT_SRC_IEOB_IRQ_CLR_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_SRC_IEOB_IRQ_CLR_OFFSET(ee) \
+			(0x0001f0c0 + 0x4000 * (ee))
+
+#define GSI_CNTXT_GLOB_IRQ_STTS_OFFSET \
+			GSI_EE_N_CNTXT_GLOB_IRQ_STTS_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_GLOB_IRQ_STTS_OFFSET(ee) \
+			(0x0001f100 + 0x4000 * (ee))
+#define ERROR_INT_FMASK			GENMASK(0, 0)
+#define GP_INT1_FMASK			GENMASK(1, 1)
+#define GP_INT2_FMASK			GENMASK(2, 2)
+#define GP_INT3_FMASK			GENMASK(3, 3)
+
+#define GSI_CNTXT_GLOB_IRQ_EN_OFFSET \
+			GSI_EE_N_CNTXT_GLOB_IRQ_EN_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_GLOB_IRQ_EN_OFFSET(ee) \
+			(0x0001f108 + 0x4000 * (ee))
+#define EN_ERROR_INT_FMASK		GENMASK(0, 0)
+#define EN_GP_INT1_FMASK		GENMASK(1, 1)
+#define EN_GP_INT2_FMASK		GENMASK(2, 2)
+#define EN_GP_INT3_FMASK		GENMASK(3, 3)
+#define GSI_CNTXT_GLOB_IRQ_ALL		GENMASK(3, 0)
+
+#define GSI_CNTXT_GLOB_IRQ_CLR_OFFSET \
+			GSI_EE_N_CNTXT_GLOB_IRQ_CLR_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_GLOB_IRQ_CLR_OFFSET(ee) \
+			(0x0001f110 + 0x4000 * (ee))
+#define CLR_ERROR_INT_FMASK		GENMASK(0, 0)
+#define CLR_GP_INT1_FMASK		GENMASK(1, 1)
+#define CLR_GP_INT2_FMASK		GENMASK(2, 2)
+#define CLR_GP_INT3_FMASK		GENMASK(3, 3)
+
+#define GSI_CNTXT_GSI_IRQ_STTS_OFFSET \
+			GSI_EE_N_CNTXT_GSI_IRQ_STTS_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_GSI_IRQ_STTS_OFFSET(ee) \
+			(0x0001f118 + 0x4000 * (ee))
+#define BREAK_POINT_FMASK		GENMASK(0, 0)
+#define BUS_ERROR_FMASK			GENMASK(1, 1)
+#define CMD_FIFO_OVRFLOW_FMASK		GENMASK(2, 2)
+#define MCS_STACK_OVRFLOW_FMASK		GENMASK(3, 3)
+
+#define GSI_CNTXT_GSI_IRQ_EN_OFFSET \
+			GSI_EE_N_CNTXT_GSI_IRQ_EN_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_GSI_IRQ_EN_OFFSET(ee) \
+			(0x0001f120 + 0x4000 * (ee))
+#define EN_BREAK_POINT_FMASK		GENMASK(0, 0)
+#define EN_BUS_ERROR_FMASK		GENMASK(1, 1)
+#define EN_CMD_FIFO_OVRFLOW_FMASK	GENMASK(2, 2)
+#define EN_MCS_STACK_OVRFLOW_FMASK	GENMASK(3, 3)
+#define GSI_CNTXT_GSI_IRQ_ALL		GENMASK(3, 0)
+
+#define GSI_CNTXT_GSI_IRQ_CLR_OFFSET \
+			GSI_EE_N_CNTXT_GSI_IRQ_CLR_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_GSI_IRQ_CLR_OFFSET(ee) \
+			(0x0001f128 + 0x4000 * (ee))
+#define CLR_BREAK_POINT_FMASK		GENMASK(0, 0)
+#define CLR_BUS_ERROR_FMASK		GENMASK(1, 1)
+#define CLR_CMD_FIFO_OVRFLOW_FMASK	GENMASK(2, 2)
+#define CLR_MCS_STACK_OVRFLOW_FMASK	GENMASK(3, 3)
+
+#define GSI_CNTXT_INTSET_OFFSET \
+			GSI_EE_N_CNTXT_INTSET_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_CNTXT_INTSET_OFFSET(ee) \
+			(0x0001f180 + 0x4000 * (ee))
+#define INTYPE_FMASK			GENMASK(0, 0)
+
+#define GSI_ERROR_LOG_OFFSET \
+			GSI_EE_N_ERROR_LOG_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_ERROR_LOG_OFFSET(ee) \
+			(0x0001f200 + 0x4000 * (ee))
+
+#define GSI_ERROR_LOG_CLR_OFFSET \
+			GSI_EE_N_ERROR_LOG_CLR_OFFSET(GSI_EE_AP)
+#define GSI_EE_N_ERROR_LOG_CLR_OFFSET(ee) \
+			(0x0001f210 + 0x4000 * (ee))
+
+#endif	/* _GSI_REG_H_ */
-- 
2.20.1

