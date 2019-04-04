Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38722C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036A2214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDDBi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfDDBhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:37:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E324421909;
        Thu,  4 Apr 2019 01:37:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hBrK6-00054i-1E; Wed, 03 Apr 2019 21:37:46 -0400
Message-Id: <20190404013745.924402837@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Apr 2019 21:37:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [for-next][PATCH 17/19] tracing: introduce TRACE_EVENT_NOP()
References: <20190404013721.023858792@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yafang Shao <laoar.shao@gmail.com>

Sometimes we want to define a tracepoint as a do-nothing function.
So I introduce TRACE_EVENT_NOP, DECLARE_EVENT_CLASS_NOP and
DEFINE_EVENT_NOP for this kind of usage.

Link: http://lkml.kernel.org/r/1553602391-11926-2-git-send-email-laoar.shao@gmail.com

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h   | 15 +++++++++++++++
 include/trace/define_trace.h |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 9c3186578ce0..86b019aa2839 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -548,4 +548,19 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define TRACE_EVENT_PERF_PERM(event, expr...)
 
+#define DECLARE_EVENT_NOP(name, proto, args)				\
+	static inline void trace_##name(proto)				\
+	{ }								\
+	static inline bool trace_##name##_enabled(void)			\
+	{								\
+		return false;						\
+	}
+
+#define TRACE_EVENT_NOP(name, proto, args, struct, assign, print)	\
+	DECLARE_EVENT_NOP(name, PARAMS(proto), PARAMS(args))
+
+#define DECLARE_EVENT_CLASS_NOP(name, proto, args, tstruct, assign, print)
+#define DEFINE_EVENT_NOP(template, name, proto, args)			\
+	DECLARE_EVENT_NOP(name, PARAMS(proto), PARAMS(args))
+
 #endif /* ifdef TRACE_EVENT (see note above) */
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index cb30c5532144..bd75f97867b9 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -46,6 +46,12 @@
 		assign, print, reg, unreg)			\
 	DEFINE_TRACE_FN(name, reg, unreg)
 
+#undef TRACE_EVENT_NOP
+#define TRACE_EVENT_NOP(name, proto, args, struct, assign, print)
+
+#undef DEFINE_EVENT_NOP
+#define DEFINE_EVENT_NOP(template, name, proto, args)
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args) \
 	DEFINE_TRACE(name)
@@ -102,6 +108,8 @@
 #undef TRACE_EVENT_FN
 #undef TRACE_EVENT_FN_COND
 #undef TRACE_EVENT_CONDITION
+#undef TRACE_EVENT_NOP
+#undef DEFINE_EVENT_NOP
 #undef DECLARE_EVENT_CLASS
 #undef DEFINE_EVENT
 #undef DEFINE_EVENT_FN
-- 
2.20.1


