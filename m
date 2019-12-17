Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68EBC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839E4206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfLQNn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:43:58 -0500
Received: from foss.arm.com ([217.140.110.172]:37544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbfLQNn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:43:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38A3231B;
        Tue, 17 Dec 2019 05:43:56 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B7003F719;
        Tue, 17 Dec 2019 05:43:54 -0800 (PST)
From:   lukasz.luba@arm.com
To:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org
Cc:     rostedt@goodmis.org, mingo@redhat.com, james.quinlan@broadcom.com,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 2/2] drivers: firmware: scmi: Extend SCMI transport layer by trace events
Date:   Tue, 17 Dec 2019 13:43:45 +0000
Message-Id: <20191217134345.14004-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217134345.14004-1-lukasz.luba@arm.com>
References: <20191217134345.14004-1-lukasz.luba@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

The SCMI transport layer communicates via mailboxes and shared memory with
firmware running on a microcontroller. It is platform specific how long it
takes to pass a SCMI message. The most sensitive requests are coming from
CPUFreq subsystem, which might be used by the scheduler.
Thus, there is a need to measure these delays and capture anomalies.
This change introduces trace events wrapped around transfer code.

According to Jim's suggestion a unique transfer_id is to distinguish
similar entries which might have the same message id, protocol id and
sequence. This is a case then there are some timeouts in transfers.

Suggested-by: Jim Quinlan <james.quinlan@broadcom.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  2 ++
 drivers/firmware/arm_scmi/driver.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 5237c2ff79fe..df35358ff324 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -81,6 +81,7 @@ struct scmi_msg {
 /**
  * struct scmi_xfer - Structure representing a message flow
  *
+ * @transfer_id: Unique ID for debug & profiling purpose
  * @hdr: Transmit message header
  * @tx: Transmit message
  * @rx: Receive message, the buffer should be pre-allocated to store
@@ -90,6 +91,7 @@ struct scmi_msg {
  * @async: pointer to delayed response message received event completion
  */
 struct scmi_xfer {
+	int transfer_id;
 	struct scmi_msg_hdr hdr;
 	struct scmi_msg tx;
 	struct scmi_msg rx;
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 3eb0382491ce..15c5629ad2cd 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -29,6 +29,9 @@
 
 #include "common.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/scmi.h>
+
 #define MSG_ID_MASK		GENMASK(7, 0)
 #define MSG_XTRACT_ID(hdr)	FIELD_GET(MSG_ID_MASK, (hdr))
 #define MSG_TYPE_MASK		GENMASK(9, 8)
@@ -61,6 +64,8 @@ enum scmi_error_codes {
 static LIST_HEAD(scmi_list);
 /* Protection for the entire list */
 static DEFINE_MUTEX(scmi_list_mutex);
+/* Track the unique id for the transfers for debug & profiling purpose */
+static atomic_t transfer_last_id;
 
 /**
  * struct scmi_xfers_info - Structure to manage transfer information
@@ -304,6 +309,7 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
 	xfer = &minfo->xfer_block[xfer_id];
 	xfer->hdr.seq = xfer_id;
 	reinit_completion(&xfer->done);
+	xfer->transfer_id = atomic_inc_return(&transfer_last_id);
 
 	return xfer;
 }
@@ -374,6 +380,10 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
 
 	scmi_fetch_response(xfer, mem);
 
+	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
+			   xfer->hdr.protocol_id, xfer->hdr.seq,
+			   msg_type);
+
 	if (msg_type == MSG_TYPE_DELAYED_RESP)
 		complete(xfer->async_done);
 	else
@@ -439,6 +449,10 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	if (unlikely(!cinfo))
 		return -EINVAL;
 
+	trace_scmi_xfer_begin(xfer->transfer_id, xfer->hdr.id,
+			      xfer->hdr.protocol_id, xfer->hdr.seq,
+			      xfer->hdr.poll_completion);
+
 	ret = mbox_send_message(cinfo->chan, xfer);
 	if (ret < 0) {
 		dev_dbg(dev, "mbox send fail %d\n", ret);
@@ -478,6 +492,10 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	 */
 	mbox_client_txdone(cinfo->chan, ret);
 
+	trace_scmi_xfer_end(xfer->transfer_id, xfer->hdr.id,
+			    xfer->hdr.protocol_id, xfer->hdr.seq,
+			    xfer->hdr.status);
+
 	return ret;
 }
 
-- 
2.17.1

