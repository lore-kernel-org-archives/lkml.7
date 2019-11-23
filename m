Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD1EC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4482071B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfKWSMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:12:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfKWSMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:12:43 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37F8220731;
        Sat, 23 Nov 2019 18:12:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iYZth-000Eyp-C3; Sat, 23 Nov 2019 13:12:41 -0500
Message-Id: <20191123181241.252520677@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 23 Nov 2019 13:12:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [for-next][PATCH 04/10] ftrace: Use BIT() macro
References: <20191123181157.851427201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Enrico Weigelt, metux IT consult" <info@metux.net>

It's cleaner to use the BIT() macro instead of raw shift operation.

Link: http://lkml.kernel.org/r/20191121133815.15040-1-info@metux.net

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
[ Added BIT() for bits 16 and 17 ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index af79b0f8cdc1..232806d5689d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -149,24 +149,24 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);
  *            (internal ftrace only, should not be used by others)
  */
 enum {
-	FTRACE_OPS_FL_ENABLED			= 1 << 0,
-	FTRACE_OPS_FL_DYNAMIC			= 1 << 1,
-	FTRACE_OPS_FL_SAVE_REGS			= 1 << 2,
-	FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED	= 1 << 3,
-	FTRACE_OPS_FL_RECURSION_SAFE		= 1 << 4,
-	FTRACE_OPS_FL_STUB			= 1 << 5,
-	FTRACE_OPS_FL_INITIALIZED		= 1 << 6,
-	FTRACE_OPS_FL_DELETED			= 1 << 7,
-	FTRACE_OPS_FL_ADDING			= 1 << 8,
-	FTRACE_OPS_FL_REMOVING			= 1 << 9,
-	FTRACE_OPS_FL_MODIFYING			= 1 << 10,
-	FTRACE_OPS_FL_ALLOC_TRAMP		= 1 << 11,
-	FTRACE_OPS_FL_IPMODIFY			= 1 << 12,
-	FTRACE_OPS_FL_PID			= 1 << 13,
-	FTRACE_OPS_FL_RCU			= 1 << 14,
-	FTRACE_OPS_FL_TRACE_ARRAY		= 1 << 15,
-	FTRACE_OPS_FL_PERMANENT                 = 1 << 16,
-	FTRACE_OPS_FL_DIRECT			= 1 << 17,
+	FTRACE_OPS_FL_ENABLED			= BIT(0),
+	FTRACE_OPS_FL_DYNAMIC			= BIT(1),
+	FTRACE_OPS_FL_SAVE_REGS			= BIT(2),
+	FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED	= BIT(3),
+	FTRACE_OPS_FL_RECURSION_SAFE		= BIT(4),
+	FTRACE_OPS_FL_STUB			= BIT(5),
+	FTRACE_OPS_FL_INITIALIZED		= BIT(6),
+	FTRACE_OPS_FL_DELETED			= BIT(7),
+	FTRACE_OPS_FL_ADDING			= BIT(8),
+	FTRACE_OPS_FL_REMOVING			= BIT(9),
+	FTRACE_OPS_FL_MODIFYING			= BIT(10),
+	FTRACE_OPS_FL_ALLOC_TRAMP		= BIT(11),
+	FTRACE_OPS_FL_IPMODIFY			= BIT(12),
+	FTRACE_OPS_FL_PID			= BIT(13),
+	FTRACE_OPS_FL_RCU			= BIT(14),
+	FTRACE_OPS_FL_TRACE_ARRAY		= BIT(15),
+	FTRACE_OPS_FL_PERMANENT                 = BIT(16),
+	FTRACE_OPS_FL_DIRECT			= BIT(17),
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-- 
2.24.0


