Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2578C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CCB2184B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfGQT0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:26:48 -0400
Received: from foss.arm.com ([217.140.110.172]:50296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727270AbfGQT0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:26:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BD6F337;
        Wed, 17 Jul 2019 12:26:46 -0700 (PDT)
Received: from tuskha01.cambridge.arm.com (tuskha01.cambridge.arm.com [10.1.196.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F10953F71A;
        Wed, 17 Jul 2019 12:26:44 -0700 (PDT)
From:   Tushar Khandelwal <tushar.khandelwal@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     tushar.2nov@gmail.com, morten_bp@live.dk, jassisinghbrar@gmail.com,
        nd@arm.com, Morten Borup Petersen <morten.petersen@arm.com>,
        Tushar Khandelwal <tushar.khandelwal@arm.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 4/4] mailbox: arm_mhuv2: add multi word transport protocol operations
Date:   Wed, 17 Jul 2019 20:26:16 +0100
Message-Id: <20190717192616.1731-5-tushar.khandelwal@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717192616.1731-1-tushar.khandelwal@arm.com>
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morten Borup Petersen <morten.petersen@arm.com>

When in multi-word mode, the mailbox controller will provide a single
mailbox. It is required that the MHU device has at least 2 channel windows
available for the MHU to function in multi-word mode.

Transmitting and receiving data through the mailbox framework in
multi-word mode is done through a struct arm_mbox_msg.

Signed-off-by: Morten Borup Petersen <morten.petersen@arm.com>
Signed-off-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
Cc: jassisinghbrar@gmail.com
Cc: devicetree@vger.kernel.org
---
 drivers/mailbox/arm_mhu_v2.c | 225 +++++++++++++++++++++++++++++++++++
 1 file changed, 225 insertions(+)

diff --git a/drivers/mailbox/arm_mhu_v2.c b/drivers/mailbox/arm_mhu_v2.c
index 0e3fa5917925..324b19bdb28a 100644
--- a/drivers/mailbox/arm_mhu_v2.c
+++ b/drivers/mailbox/arm_mhu_v2.c
@@ -430,6 +430,228 @@ static const struct mhuv2_ops mhuv2_single_word_ops = {
 };
 /* ========================================================================== */
 
+/* ================ Multi word transport protocol operations ================ */
+static inline int mhuv2_read_data_multi_word(struct arm_mhuv2 *mhuv2,
+					     struct mbox_chan *chan,
+					     struct arm_mbox_msg *msg)
+{
+	int ch;
+	const int channels =
+		readl_relaxed_bitfield(&mhuv2->reg.recv->MHU_CFG, NUM_CH);
+
+	msg->data = kzalloc(MHUV2_STAT_BYTES * channels, GFP_KERNEL);
+
+	for (ch = 0; ch < channels; ch++) {
+		/*
+		 * Messages are expected to be received in order of most
+		 * significant word to least significant word.
+		 * (see mhuv2_send_data_multi_word)
+		 */
+		const mhuv2_stat_reg_t word =
+			readl_relaxed(&mhuv2->reg.recv->channel[ch].STAT);
+		((mhuv2_stat_reg_t *)msg->data)[channels - 1 - ch] = word;
+	}
+
+	msg->len = channels * MHUV2_STAT_BYTES;
+	return 0;
+}
+
+static inline int mhuv2_clear_data_multi_word(struct arm_mhuv2 *mhuv2,
+					      struct mbox_chan *chan,
+					      struct arm_mbox_msg *msg)
+{
+	int ch;
+	const int channels =
+		readl_relaxed_bitfield(&mhuv2->reg.recv->MHU_CFG, NUM_CH);
+
+	for (ch = 0; ch < channels; ch++) {
+		/*
+		 * Last channel window must be cleared as the final operation.
+		 * Upon clearing the last channel window register, which is
+		 * unmasked in multi-word mode, the interrupt is deasserted.
+		 */
+		writel_relaxed(
+			readl_relaxed(&mhuv2->reg.recv->channel[ch].STAT),
+			&mhuv2->reg.recv->channel[ch].STAT_CLEAR);
+	}
+	return 0;
+}
+
+static inline int __mhuv2_mw_bytes_to_send(const int bytes_in_round,
+					    const int bytes_left)
+{
+	/*
+	 * Bytes to send on the current channel will always be MHUV2_STAT_BYTES
+	 * unless in the last round and
+	 *	msg->len % MHUV2_STAT_BYTES != 0
+	 */
+	if (bytes_in_round % MHUV2_STAT_BYTES != 0) {
+		const int bts = bytes_left % MHUV2_STAT_BYTES;
+		return bts == 0 ? MHUV2_STAT_BYTES : bts;
+	} else {
+		return MHUV2_STAT_BYTES;
+	}
+}
+
+static inline int mhuv2_send_data_multi_word(struct arm_mhuv2 *mhuv2,
+					     struct mbox_chan *chan,
+					     const struct arm_mbox_msg *msg)
+{
+	/*
+	 * Message will be transmitted from most significant to least
+	 * significant word. This is to allow for messages shorter than
+	 * $channels to still trigger the receiver interrupt which gets
+	 * activated when the last STAT register is written. As an example, a
+	 * 6-word message is to be written on a 4-channel MHU connection:
+	 * Registers marked with '*' are masked, and will not generate an
+	 * interrupt on the receiver side once written.
+	 *
+	 * uint32_t *data = [0x00000001],[0x00000002],[0x00000003],[0x00000004],
+	 *		    [0x00000005], [0x00000006]
+	 *
+	 *  ROUND 1:
+	 *   STAT reg      To write    Write sequence
+	 *  [ STAT 3 ] <- [0x00000001]       4 <- triggers interrupt on receiver
+	 * *[ STAT 2 ] <- [0x00000002]       3
+	 * *[ STAT 1 ] <- [0x00000003]       2
+	 * *[ STAT 0 ] <- [0x00000004]       1
+	 *
+	 *  data += 4 // Increment data pointer by number of STAT regs
+	 *
+	 *  ROUND 2:
+	 *   STAT reg      To write    Write sequence
+	 *  [ STAT 3 ] <- [0x00000005]       2 <- triggers interrupt on receiver
+	 * *[ STAT 2 ] <- [0x00000006]       1
+	 * *[ STAT 1 ] <- [0x00000000]
+	 * *[ STAT 0 ] <- [0x00000000]
+	 */
+	int bytes_left, bytes_to_send, i, ch_idx;
+	const int ch_windows =
+		readl_relaxed_bitfield(&mhuv2->reg.recv->MHU_CFG, NUM_CH);
+	const size_t round_capacity = ch_windows * MHUV2_STAT_BYTES;
+
+	bytes_left = msg->len;
+	mhuv2_stat_reg_t *data = msg->data;
+
+	while (bytes_left > 0) {
+		/* Note: Each entry of this loop indicates a new ROUND */
+		if (*(u32 *)data == 0) {
+			dev_err(mhuv2->dev,
+				"values in *data aligned on NUM_STAT boundaries must not be zero to ensure that receiver interrupt is triggered\n",
+				ch_windows);
+			return -EINVAL;
+		}
+
+		const int bytes_in_round = bytes_left > round_capacity ?
+						   round_capacity :
+						   bytes_left;
+
+		for (i = (ch_windows - 1); i >= 0; i--) {
+			ch_idx = ch_windows - 1 - i;
+			/*
+			 * Check whether data should be transmitted in register
+			 * of index 'ch'.
+			 */
+			if (bytes_in_round > (i * MHUV2_STAT_BYTES)) {
+				mhuv2_stat_reg_t word = data[i];
+
+				bytes_to_send = __mhuv2_mw_bytes_to_send(
+					bytes_in_round, bytes_left);
+
+				if (bytes_to_send != MHUV2_STAT_BYTES) {
+					word &= LSB_MASK(bytes_to_send *
+							 __CHAR_BIT__);
+				}
+				while (readl_relaxed(
+					       &mhuv2->reg.send->channel[ch_idx]
+							.STAT) != 0)
+					continue;
+
+				writel_relaxed(
+				    word,
+				    &mhuv2->reg.send->channel[ch_idx].STAT_SET);
+				bytes_left -= bytes_to_send;
+			}
+		}
+
+		data += ch_windows;
+
+		for (ch_idx = 0; ch_idx < ch_windows; ch_idx++) {
+			while (readl_relaxed(
+				   &mhuv2->reg.send->channel[ch_idx].STAT) != 0)
+				continue;
+		}
+	}
+	return 0;
+}
+
+
+static inline int mhuv2_last_tx_done_multi_word(struct arm_mhuv2 *mhuv2,
+						struct mbox_chan *chan)
+{
+	int ch_idx;
+	bool tx_done = true;
+
+	for (ch_idx = 0;
+	     ch_idx < readl_relaxed_bitfield(&mhuv2->reg.send->MHU_CFG, NUM_CH);
+	     ch_idx++) {
+		tx_done &= readl_relaxed(
+				   &mhuv2->reg.send->channel[ch_idx].STAT) == 0;
+	}
+	return tx_done;
+}
+
+static inline int mhuv2_setup_multi_word(struct arm_mhuv2 *mhuv2)
+{
+	int ret, i;
+
+	const u32 channel_windows =
+		readl_relaxed_bitfield(mhuv2->frame == RECEIVER_FRAME ?
+					       &mhuv2->reg.recv->MHU_CFG :
+					       &mhuv2->reg.send->MHU_CFG,
+				       NUM_CH);
+	if (channel_windows < 2) {
+		dev_err(mhuv2->dev,
+			"Error: at least 2 MHU channel windows are required for using the multi-word transfer protocol");
+		return -ENODEV;
+	}
+
+	if (mhuv2->frame == RECEIVER_FRAME) {
+		/*
+		 * The multi-word transport protocol mandates that all but
+		 * the last status register must be masked.
+		 */
+		for (i = 0; i < (channel_windows - 1); i++) {
+			writel_relaxed(-1,
+				       &mhuv2->reg.recv->channel[i].MASK_SET);
+		}
+	}
+
+	mhuv2->mbox.num_chans = 1;
+	mhuv2->mbox.chans =
+		devm_kzalloc(mhuv2->dev,
+			     mhuv2->mbox.num_chans * sizeof(struct mbox_chan),
+			     GFP_KERNEL);
+
+	return 0;
+}
+
+static inline struct mbox_chan *
+	mhuv2_get_active_mbox_chan_multi_word(struct arm_mhuv2 *mhuv2)
+{
+	return &mhuv2->mbox.chans[0];
+}
+
+static const struct mhuv2_ops mhuv2_multi_word_ops = {
+	.read_data = mhuv2_read_data_multi_word,
+	.clear_data = mhuv2_clear_data_multi_word,
+	.send_data = mhuv2_send_data_multi_word,
+	.setup = mhuv2_setup_multi_word,
+	.last_tx_done = mhuv2_last_tx_done_multi_word,
+	.get_active_mbox_chan = mhuv2_get_active_mbox_chan_multi_word,
+};
+/* ========================================================================== */
+
 /* =================== Doorbell transport protocol operations =============== */
 
 static inline int mhuv2_read_data_doorbell(struct arm_mhuv2 *mhuv2,
@@ -740,6 +962,9 @@ static int mhuv2_probe(struct amba_device *adev, const struct amba_id *id)
 
 	/* Assign transport protocol-specific operations */
 	switch (mhuv2->protocol) {
+	case MULTI_WORD:
+		mhuv2->ops = &mhuv2_multi_word_ops;
+		break;
 	case SINGLE_WORD:
 		mhuv2->ops = &mhuv2_single_word_ops;
 		break;
-- 
2.17.1

