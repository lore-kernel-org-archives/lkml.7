Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A5AC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18952071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSk14tTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfKVP1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:27:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46082 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfKVP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:27:20 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so5675300wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 07:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hEkNkSrp8km0CreoucFi1BgIya/dvxAxyWgm3O9Oa4A=;
        b=QSk14tTRm3kPhwN6nMGxS2I+AOA5Yl5RN2zUYTGICyoS2r9hGYszK6D+SeVAFo5k/E
         rZg5dQhJeMELMLUnot7FxpdB3tvbuncb16aLcyDf9TXGIZaAJ2JMHmY/odWmuX7XGiHx
         j5wzKu8913t98T0zibWM+lYRjiaZrw73nDpenqq6+8FPBd9arcSxRuPX145b9U7tU2Ms
         FnWatqUXBw3z14nvMiybYtO3SyScaMZhmCO1JrNfwQQFsaM2uozdSmHRRFzLghUwRZBe
         qscpyU8Bg/mHWr3AYzCpkkttdkI/CeGHFIQawqX7VhHU+ZkuSwXVj/1b8tGNnk4gNmF2
         hD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hEkNkSrp8km0CreoucFi1BgIya/dvxAxyWgm3O9Oa4A=;
        b=MvM439yJbWscL6gPm18+jiBDdnRQnoMTS2THm9b5KjBGer6NZ5O9edl8PlSxIHahzE
         yAMRW7vZbGCUfD1Et75TtTb3iI+w64U9hrTGYc9w9x+pP3xtjX0fmHupp1smfJAZRoT9
         bv+18CZ9CpdTjF2nTISM9U+bADzx0cz91IHO5VoxdlazMFS3KVtOw/5dHJ98jveIZD00
         eYS8qqBAjTuZD0xHRxsr1RDi9lF1buo+bQRgyoXS2bYNcMwbni245F2hVdc8TGBL2Tdd
         HjKyemNRYZpA8Qg5DBtuUmF7DYiy/HQRUNtOskDP622NgOpOZHQk4NzjWsY77EwcywmD
         Ze6Q==
X-Gm-Message-State: APjAAAXykzfL4KTgx1euMeP6NVklocVN5aLJa6gRv4pdOoW5mX7UhWzI
        3QI3fuun8YXmf9gb2c4IjJSwjA==
X-Google-Smtp-Source: APXvYqzisXnUeVOdqP1dS2D+LXMimH6hbmBWtHQ0u9pukgly+38mDbFsbQyPNY45Eg2lEr3tB7fKRQ==
X-Received: by 2002:adf:f987:: with SMTP id f7mr18326940wrr.284.1574436438619;
        Fri, 22 Nov 2019 07:27:18 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a206sm4061081wmf.15.2019.11.22.07.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Nov 2019 07:27:17 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v3 3/3] interconnect: Add basic tracepoints
Date:   Fri, 22 Nov 2019 17:27:12 +0200
Message-Id: <20191122152712.19105-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122152712.19105-1-georgi.djakov@linaro.org>
References: <20191122152712.19105-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracepoints can help with understanding the system behavior of a
given interconnect path when the consumer drivers change their bandwidth
demands. This might be interesting when we want to monitor the requested
interconnect bandwidth for each client driver. The paths may share the
same nodes and this will help to understand "who and when is requesting
what". All this is useful for subsystem drivers developers and may also
provide hints when optimizing the power and performance profile of the
system.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/Makefile |  1 +
 drivers/interconnect/core.c   |  7 +++
 drivers/interconnect/trace.h  | 90 +++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)
 create mode 100644 drivers/interconnect/trace.h

diff --git a/drivers/interconnect/Makefile b/drivers/interconnect/Makefile
index 28f2ab0824d5..725029ae7a2c 100644
--- a/drivers/interconnect/Makefile
+++ b/drivers/interconnect/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+CFLAGS_core.o				:= -I$(src)
 icc-core-objs				:= core.o
 
 obj-$(CONFIG_INTERCONNECT)		+= icc-core.o
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1ddad8ef3cf0..b218a2609f6b 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -19,6 +19,9 @@
 #include <linux/of.h>
 #include <linux/overflow.h>
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 #include "internal.h"
 
 static DEFINE_IDR(icc_idr);
@@ -435,6 +438,8 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 
 		/* aggregate requests for this node */
 		aggregate_requests(node);
+
+		trace_icc_set_bw(path, node, i, avg_bw, peak_bw);
 	}
 
 	ret = apply_constraints(path);
@@ -453,6 +458,8 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 
 	mutex_unlock(&icc_lock);
 
+	trace_icc_set_bw_end(path, ret);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(icc_set_bw);
diff --git a/drivers/interconnect/trace.h b/drivers/interconnect/trace.h
new file mode 100644
index 000000000000..d2421bf7b389
--- /dev/null
+++ b/drivers/interconnect/trace.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interconnect framework tracepoints
+ * Copyright (c) 2019, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM interconnect
+
+#if !defined(_TRACE_INTERCONNECT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_INTERCONNECT_H
+
+#include <linux/interconnect.h>
+#include <linux/tracepoint.h>
+
+#include "internal.h"
+
+TRACE_EVENT(icc_set_bw,
+
+	TP_PROTO(struct icc_path *p, struct icc_node *n, int i,
+		 u32 avg_bw, u32 peak_bw),
+
+	TP_ARGS(p, n, i, avg_bw, peak_bw),
+
+	TP_STRUCT__entry(
+		__string(path_name, p->name)
+		__string(dev, dev_name(p->reqs[i].dev))
+		__string(node_name, n->name)
+		__field(u32, avg_bw)
+		__field(u32, peak_bw)
+		__field(u32, node_avg_bw)
+		__field(u32, node_peak_bw)
+	),
+
+	TP_fast_assign(
+		__assign_str(path_name, p->name);
+		__assign_str(dev, dev_name(p->reqs[i].dev));
+		__assign_str(node_name, n->name);
+		__entry->avg_bw = avg_bw;
+		__entry->peak_bw = peak_bw;
+		__entry->node_avg_bw = n->avg_bw;
+		__entry->node_peak_bw = n->peak_bw;
+	),
+
+	TP_printk("path=%s dev=%s node=%s avg_bw=%u peak_bw=%u agg_avg=%u agg_peak=%u",
+		  __get_str(path_name),
+		  __get_str(dev),
+		  __get_str(node_name),
+		  __entry->avg_bw,
+		  __entry->peak_bw,
+		  __entry->node_avg_bw,
+		  __entry->node_peak_bw)
+);
+
+TRACE_EVENT(icc_set_bw_end,
+
+	TP_PROTO(struct icc_path *p, int ret),
+
+	TP_ARGS(p, ret),
+
+	TP_STRUCT__entry(
+		__string(path_name, p->name)
+		__string(dev, dev_name(p->reqs[0].dev))
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__assign_str(path_name, p->name);
+		__assign_str(dev, dev_name(p->reqs[0].dev));
+		__entry->ret = ret;
+	),
+
+	TP_printk("path=%s dev=%s ret=%d",
+		  __get_str(path_name),
+		  __get_str(dev),
+		  __entry->ret)
+);
+
+#endif /* _TRACE_INTERCONNECT_H */
+
+/* This part must be outside protection */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>
