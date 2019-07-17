Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682C7C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC4821743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfGQT0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:26:45 -0400
Received: from foss.arm.com ([217.140.110.172]:50286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfGQT0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:26:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19D84344;
        Wed, 17 Jul 2019 12:26:43 -0700 (PDT)
Received: from tuskha01.cambridge.arm.com (tuskha01.cambridge.arm.com [10.1.196.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EDDEF3F71A;
        Wed, 17 Jul 2019 12:26:41 -0700 (PDT)
From:   Tushar Khandelwal <tushar.khandelwal@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tushar.2nov@gmail.com, morten_bp@live.dk, jassisinghbrar@gmail.com,
        nd@arm.com, Morten Borup Petersen <morten.petersen@arm.com>,
        Tushar Khandelwal <tushar.khandelwal@arm.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 3/4] mailbox: arm_mhuv2: add doorbell transport protocol operations
Date:   Wed, 17 Jul 2019 20:26:15 +0100
Message-Id: <20190717192616.1731-4-tushar.khandelwal@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717192616.1731-1-tushar.khandelwal@arm.com>
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morten Borup Petersen <morten.petersen@arm.com>

In doorbell mode, the mailbox controller will provide a mailbox for each
flag bit available in the combined number of channel windows available
within the MHU device.

When in doorbell mode, the MHU should be used solely as an interrupt
generating mechanism. If data is to be transmitted, this must be done
out-band, ie. through shared memory, by a driving utilizing the mailbox
for interrupt generation.

Signed-off-by: Morten Borup Petersen <morten.petersen@arm.com>
Signed-off-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
Cc:Jassi Brar <jassisinghbrar@gmail.com
Cc: devicetree@vger.kernel.org
---
 drivers/mailbox/arm_mhu_v2.c | 108 +++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/mailbox/arm_mhu_v2.c b/drivers/mailbox/arm_mhu_v2.c
index a0af683b83a2..0e3fa5917925 100644
--- a/drivers/mailbox/arm_mhu_v2.c
+++ b/drivers/mailbox/arm_mhu_v2.c
@@ -430,6 +430,111 @@ static const struct mhuv2_ops mhuv2_single_word_ops = {
 };
 /* ========================================================================== */
 
+/* =================== Doorbell transport protocol operations =============== */
+
+static inline int mhuv2_read_data_doorbell(struct arm_mhuv2 *mhuv2,
+					   struct mbox_chan *chan,
+					   struct arm_mbox_msg *msg)
+{
+	return 0;
+}
+
+static inline int mhuv2_clear_data_doorbell(struct arm_mhuv2 *mhuv2,
+					    struct mbox_chan *chan,
+					    struct arm_mbox_msg *msg)
+{
+	const u32 ch_mbox_idx = mhuv2_chan_idx(chan);
+	const u32 ch_window_idx = ch_mbox_idx / MHUV2_STAT_BITS;
+	const u32 ch_window_reg_idx = ch_mbox_idx % MHUV2_STAT_BITS;
+
+	writel_relaxed(BIT(ch_window_reg_idx),
+		       &mhuv2->reg.recv->channel[ch_window_idx].STAT_CLEAR);
+	return 0;
+}
+
+static inline int mhuv2_send_data_doorbell(struct arm_mhuv2 *mhuv2,
+					   struct mbox_chan *chan,
+					   const struct arm_mbox_msg *msg)
+{
+	const u32 ch_mbox_idx = mhuv2_chan_idx(chan);
+	const u32 ch_window_idx = ch_mbox_idx / MHUV2_STAT_BITS;
+	const u32 ch_window_reg_idx = ch_mbox_idx % MHUV2_STAT_BITS;
+
+	writel_relaxed(
+		readl_relaxed(&mhuv2->reg.send->channel[ch_window_idx].STAT) |
+			BIT(ch_window_reg_idx),
+		&mhuv2->reg.send->channel[ch_window_idx].STAT_SET);
+	return 0;
+}
+
+static inline int mhuv2_last_tx_done_doorbell(struct arm_mhuv2 *mhuv2,
+					      struct mbox_chan *chan)
+{
+	const u32 ch_mbox_idx = mhuv2_chan_idx(chan);
+	const u32 ch_window_idx = ch_mbox_idx / MHUV2_STAT_BITS;
+	const u32 ch_window_reg_idx = ch_mbox_idx % MHUV2_STAT_BITS;
+
+	return (readl_relaxed(&mhuv2->reg.send->channel[ch_window_idx].STAT) &
+		BIT(ch_window_reg_idx)) == 0;
+}
+
+static inline int mhuv2_setup_doorbell(struct arm_mhuv2 *mhuv2)
+{
+	int i;
+	const u32 channel_windows =
+		readl_relaxed_bitfield(mhuv2->frame == RECEIVER_FRAME ?
+					       &mhuv2->reg.recv->MHU_CFG :
+					       &mhuv2->reg.send->MHU_CFG,
+				       NUM_CH);
+
+	mhuv2->mbox.num_chans = MHUV2_STAT_BITS * channel_windows;
+	mhuv2->mbox.chans =
+		devm_kzalloc(mhuv2->dev,
+			     mhuv2->mbox.num_chans * sizeof(struct mbox_chan),
+			     GFP_KERNEL);
+
+	for (i = 0; i < mhuv2->mbox.num_chans; i++) {
+		mhuv2->mbox.chans[i].con_priv =
+			devm_kzalloc(mhuv2->dev,
+				     sizeof(struct arm_mhuv2_mbox_chan_priv),
+				     GFP_KERNEL);
+		mhuv2_chan_idx(&mhuv2->mbox.chans[i]) = i;
+	}
+
+	if (mhuv2->frame == RECEIVER_FRAME) {
+		/* Ensure all status registers are unmasked */
+		for (i = 0; i < channel_windows; i++) {
+			writel_relaxed(0x0,
+				       &mhuv2->reg.recv->channel[i].MASK_SET);
+		}
+	}
+
+	return 0;
+}
+
+static inline struct mbox_chan *
+	mhuv2_get_active_mbox_chan_doorbell(struct arm_mhuv2 *mhuv2)
+{
+	const u32 ch_window_idx = mhuv2_combint_idx(mhuv2);
+	const u32 ch_window_reg_idx = __find_set_bit(
+		readl_relaxed(&mhuv2->reg.recv->channel[ch_window_idx].STAT));
+	if (ch_window_reg_idx == -1)
+		return ERR_PTR(-EIO);
+
+	return &mhuv2->mbox.chans[ch_window_reg_idx +
+				  ch_window_idx * MHUV2_STAT_BITS];
+}
+
+static const struct mhuv2_ops mhuv2_doorbell_ops = {
+	.read_data = mhuv2_read_data_doorbell,
+	.clear_data = mhuv2_clear_data_doorbell,
+	.send_data = mhuv2_send_data_doorbell,
+	.setup = mhuv2_setup_doorbell,
+	.last_tx_done = mhuv2_last_tx_done_doorbell,
+	.get_active_mbox_chan = mhuv2_get_active_mbox_chan_doorbell,
+};
+/* ========================================================================== */
+
 /*
  * MHUv2 receiver interrupt service routine
  *
@@ -638,6 +743,9 @@ static int mhuv2_probe(struct amba_device *adev, const struct amba_id *id)
 	case SINGLE_WORD:
 		mhuv2->ops = &mhuv2_single_word_ops;
 		break;
+	case DOORBELL:
+		mhuv2->ops = &mhuv2_doorbell_ops;
+		break;
 	default:
 		return -ENODEV;
 	}
-- 
2.17.1

