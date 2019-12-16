Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01EDC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0D4206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLPQRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:17:07 -0500
Received: from foss.arm.com ([217.140.110.172]:60416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPQRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:17:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 963C71FB;
        Mon, 16 Dec 2019 08:17:06 -0800 (PST)
Received: from e123648.arm.com (unknown [10.37.12.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E95943F718;
        Mon, 16 Dec 2019 08:17:04 -0800 (PST)
From:   lukasz.luba@arm.com
To:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH 1/2] include: trace: Add SCMI header with trace events
Date:   Mon, 16 Dec 2019 16:16:49 +0000
Message-Id: <20191216161650.21844-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukasz Luba <lukasz.luba@arm.com>

Adding trace events would help to measure the speed of the communication
channel. It can be also potentially used helpful during investigation
of some issues platforms which use different transport layer.

Update also MAINTAINERS file with information that the new trace events
are maintained.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 MAINTAINERS                 |  1 +
 include/trace/events/scmi.h | 56 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 include/trace/events/scmi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cc0a4a8ae06a..0182315226fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15966,6 +15966,7 @@ F:	drivers/firmware/arm_scpi.c
 F:	drivers/firmware/arm_scmi/
 F:	drivers/reset/reset-scmi.c
 F:	include/linux/sc[mp]i_protocol.h
+F:	include/trace/events/scmi.h
 
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
new file mode 100644
index 000000000000..a84016b02ffd
--- /dev/null
+++ b/include/trace/events/scmi.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM scmi
+
+#if !defined(_TRACE_SCMI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SCMI_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(scmi_xfer_begin,
+	TP_PROTO(u8 id, u8 protocol_id, u16 seq, bool poll),
+	TP_ARGS(id, protocol_id, seq, poll),
+
+	TP_STRUCT__entry(
+		__field(u8, id)
+		__field(u8, protocol_id)
+		__field(u16, seq)
+		__field(bool, poll)
+	),
+
+	TP_fast_assign(
+		__entry->id = id;
+		__entry->protocol_id = protocol_id;
+		__entry->seq = seq;
+		__entry->poll = poll;
+	),
+
+	TP_printk("id=%u protocol_id=%u seq=%u poll=%u", __entry->id,
+		__entry->protocol_id, __entry->seq, __entry->poll)
+);
+
+TRACE_EVENT(scmi_xfer_end,
+	TP_PROTO(u8 id, u8 protocol_id, u16 seq, u32 status),
+	TP_ARGS(id, protocol_id, seq, status),
+
+	TP_STRUCT__entry(
+		__field(u8, id)
+		__field(u8, protocol_id)
+		__field(u16, seq)
+		__field(u32, status)
+	),
+
+	TP_fast_assign(
+		__entry->id = id;
+		__entry->protocol_id = protocol_id;
+		__entry->seq = seq;
+		__entry->status = status;
+	),
+
+	TP_printk("id=%u protocol_id=%u seq=%u status=%u", __entry->id,
+		__entry->protocol_id, __entry->seq, __entry->status)
+);
+#endif /* _TRACE_SCMI_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.17.1

