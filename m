Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E45CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5A6217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 13:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m2c6kB/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfKANAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 09:00:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35649 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfKANAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 09:00:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10so9613487wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zgv/LTWdUPNIRDPJwbY82R6L2iDmim3JZRo8TtTz+DY=;
        b=m2c6kB/LVRJSVWZHgdelDlqhnHhd5gEDgD5WOy08yss+OVxQy2bbNOOeJaFURNoD9b
         IY4afffJgN/frvFyhGmkcCMoq/UF7Sbh5NnoHOxAEsyVJ6bO68psGKCkJX9N0XRgRlFB
         JKW77qcnOQpcON/+CJ/eVyh8vtjYQYKpizevs/fyavmUpTrcFfLCi2L3t21CNocpfrDV
         nsTLEO0Q8YWTVScdy/et75XKbtTSLsjX7dIGEWdmjlf51ZUZYdZNgdOsgOVS99oZ8FvC
         j1GFB+IvgSxmIgZRtw4qnZPAaR0wfCueJW7nHNaAXt9B3G+5M0WSqI+G2nTMEfjvYRCz
         nugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zgv/LTWdUPNIRDPJwbY82R6L2iDmim3JZRo8TtTz+DY=;
        b=FH2cdI4k0zBhYRKlFMeAOfyDwXPdQQ1WVhbVpftN2zTeCsXNa0SlKMO47k26YFM1og
         cGjyXYBYAVvClTdmKiguNcAzDI0LX2TdBE9kyuU9m7tv0pu4ywPnYJyBTgbcwh48xB12
         y0+Psxcs+Th9cjlL8mmBG+xO3SrCMwyMvJSq2Si0Eyf+EfLhQ+G3VQ1YGbDDkWnM5VaA
         z/lOMbkBbpb4XDJ9UyEit3uDy8O29OyrRaRDnw4rm6rDlEOBliMWxz+TWPkrOzB0yvqX
         I0CohpvGgy7ijP6EMrlaGX3g7Z8jrPHqFEw5JeAGf6tvnD4Y+9qICCbu5qkImSUzMqfw
         UiXA==
X-Gm-Message-State: APjAAAW93ZVOsiAPnEGqDex3+XzWgvWoSflvEJ4ORkMnihqwB17Z7B4D
        Ndm0sWuTJO2BCOwktPcI+fQsyA==
X-Google-Smtp-Source: APXvYqwVGRprB/tc1woV5aX/nx+Hv/+U5SrzfdXyQ9nfNAQlvzclYFxj361Z1IW2A+ySlxSqPA7lag==
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr18778wrn.256.1572613234712;
        Fri, 01 Nov 2019 06:00:34 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id x7sm14208476wrg.63.2019.11.01.06.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Nov 2019 06:00:34 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v2 1/3] interconnect: Move internal structs into a separate file
Date:   Fri,  1 Nov 2019 15:00:29 +0200
Message-Id: <20191101130031.27996-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101130031.27996-1-georgi.djakov@linaro.org>
References: <20191101130031.27996-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the interconnect framework internal structs into a separate file,
so that it can be included and used by ftrace code. This will allow us
to expose some more useful information in the traces.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c     | 30 ++-----------------------
 drivers/interconnect/internal.h | 40 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 28 deletions(-)
 create mode 100644 drivers/interconnect/internal.h

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 56cc4bacea5b..86ca6245fe6e 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -19,39 +19,13 @@
 #include <linux/of.h>
 #include <linux/overflow.h>
 
+#include "internal.h"
+
 static DEFINE_IDR(icc_idr);
 static LIST_HEAD(icc_providers);
 static DEFINE_MUTEX(icc_lock);
 static struct dentry *icc_debugfs_dir;
 
-/**
- * struct icc_req - constraints that are attached to each node
- * @req_node: entry in list of requests for the particular @node
- * @node: the interconnect node to which this constraint applies
- * @dev: reference to the device that sets the constraints
- * @tag: path tag (optional)
- * @avg_bw: an integer describing the average bandwidth in kBps
- * @peak_bw: an integer describing the peak bandwidth in kBps
- */
-struct icc_req {
-	struct hlist_node req_node;
-	struct icc_node *node;
-	struct device *dev;
-	u32 tag;
-	u32 avg_bw;
-	u32 peak_bw;
-};
-
-/**
- * struct icc_path - interconnect path structure
- * @num_nodes: number of hops (nodes)
- * @reqs: array of the requests applicable to this path of nodes
- */
-struct icc_path {
-	size_t num_nodes;
-	struct icc_req reqs[];
-};
-
 static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
 {
 	if (!n)
diff --git a/drivers/interconnect/internal.h b/drivers/interconnect/internal.h
new file mode 100644
index 000000000000..5853e8faf223
--- /dev/null
+++ b/drivers/interconnect/internal.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interconnect framework internal structs
+ *
+ * Copyright (c) 2019, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_INTERNAL_H
+#define __DRIVERS_INTERCONNECT_INTERNAL_H
+
+/**
+ * struct icc_req - constraints that are attached to each node
+ * @req_node: entry in list of requests for the particular @node
+ * @node: the interconnect node to which this constraint applies
+ * @dev: reference to the device that sets the constraints
+ * @tag: path tag (optional)
+ * @avg_bw: an integer describing the average bandwidth in kBps
+ * @peak_bw: an integer describing the peak bandwidth in kBps
+ */
+struct icc_req {
+	struct hlist_node req_node;
+	struct icc_node *node;
+	struct device *dev;
+	u32 tag;
+	u32 avg_bw;
+	u32 peak_bw;
+};
+
+/**
+ * struct icc_path - interconnect path structure
+ * @num_nodes: number of hops (nodes)
+ * @reqs: array of the requests applicable to this path of nodes
+ */
+struct icc_path {
+	size_t num_nodes;
+	struct icc_req reqs[];
+};
+
+#endif
