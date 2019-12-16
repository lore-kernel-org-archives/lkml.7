Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BD9C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1013F206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLPQRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:17:11 -0500
Received: from foss.arm.com ([217.140.110.172]:60428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPQRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:17:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A08C71045;
        Mon, 16 Dec 2019 08:17:08 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 014DE3F718;
        Mon, 16 Dec 2019 08:17:06 -0800 (PST)
From:   lukasz.luba@arm.com
To:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH 2/2] drivers: firmware: scmi: Extend SCMI transport layer by trace events
Date:   Mon, 16 Dec 2019 16:16:50 +0000
Message-Id: <20191216161650.21844-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216161650.21844-1-lukasz.luba@arm.com>
References: <20191216161650.21844-1-lukasz.luba@arm.com>
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

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 3eb0382491ce..0fda9b418bc6 100644
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
@@ -439,6 +442,9 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	if (unlikely(!cinfo))
 		return -EINVAL;
 
+	trace_scmi_xfer_begin(xfer->hdr.id, xfer->hdr.protocol_id,
+			      xfer->hdr.seq, xfer->hdr.poll_completion);
+
 	ret = mbox_send_message(cinfo->chan, xfer);
 	if (ret < 0) {
 		dev_dbg(dev, "mbox send fail %d\n", ret);
@@ -478,6 +484,9 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 	 */
 	mbox_client_txdone(cinfo->chan, ret);
 
+	trace_scmi_xfer_end(xfer->hdr.id, xfer->hdr.protocol_id, xfer->hdr.seq,
+			    xfer->hdr.status);
+
 	return ret;
 }
 
-- 
2.17.1

