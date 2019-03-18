Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BA7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F2920872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 02:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="upKR3T/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfCRCyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 22:54:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36650 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfCRCyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 22:54:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id p10so3424935pff.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 19:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9LO9kgJmE8Q1XXRyG10ntfuNrII39zZgFWKhScJB1QU=;
        b=upKR3T/8mg2ohnzHTGSjZ5JRIsFuf3siD+CSlm5ZXKir89/TFMe8smtmtT63ni2EI1
         jdY/zPW9VLYofXIQv1ns0BWafdWJonnIZHOMRNd1YNiMrReUoR8LiJXGjJgg/5pRg/1r
         EdJ8HFOZhdG7lvS/+MwdQU5v9YZ+x0ESxV9ekq/g46+4GsU7q4YxdEq4JR/y69f70aDA
         Gz2DsBGlvhD47dkLb9yPeAHuE0rxDr9hEllzx9xvHeADrV9q8trJg0JG1oLLmNFDEDv0
         3E7kf4kXF6iZGibu9/QZQfDTdAwaSG/vuDWKqZZWS7tcDR74Vgu5tGd+k4Nc1OtKbNyE
         Ca2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LO9kgJmE8Q1XXRyG10ntfuNrII39zZgFWKhScJB1QU=;
        b=lp+zrEEZCxeQOmfjATIsYIpKSGeSR4NmvuHMdOmQizKDSo+t+EtQDWRAn22ihEN8f5
         wPArHRar7OBHBu5Eso6RhEK7/VYjv1bZWN7i6RuBzLIXPNAnVCeWy+aw0WQeYJ+mxDad
         Hjw/WkeMOtuZZ1JjJhD+SXnRHCT6TmCikb+gNDnNFeCIZMWAHJkfJelO9DsP/isrq1hJ
         L+fYlNPZmdSvkpfXMwkAugKLT+TqE+hXdu9vzz4kvjN4DlIiBcl/9SyvYWRoxToL0s13
         TsWEB9W55w3s3KOBpT+Cb0v4Beypd4RfAa9DUIo8cJRVvuVnXcvWctdp9CTooUC1mY5K
         KNYg==
X-Gm-Message-State: APjAAAX5pvbAI3S86kXIfzsxj+CbvT1ooI5XrpNJCuKk/BOziELrDt7S
        JVsnbjEOTY63uQZFoueVTiPlUA==
X-Google-Smtp-Source: APXvYqzfVVbZwxbC7r0KhyHcu3FnZz1RVjLQH+MyjE0l9o6wPS3uNYdtPBWL14mYyPmhJaeRjuYCXQ==
X-Received: by 2002:a63:c00a:: with SMTP id h10mr14416081pgg.272.1552877688714;
        Sun, 17 Mar 2019 19:54:48 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id i126sm13672955pfc.101.2019.03.17.19.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 19:54:48 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     oberpar@linux.ibm.com
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        yamada.masahiro@socionext.com, akpm@linux-foundation.org,
        Tri Vo <trong@android.com>, Trilok Soni <tsoni@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>
Subject: [PATCH v4 1/3] gcov: Clang: move common GCC code into gcc_base.c
Date:   Sun, 17 Mar 2019 19:54:09 -0700
Message-Id: <20190318025411.98014-2-trong@android.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
In-Reply-To: <20190318025411.98014-1-trong@android.com>
References: <20190318025411.98014-1-trong@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Hackmann <ghackmann@android.com>

base.c contains a few callbacks specific to GCC's gcov implementation.
Move these into their own module in preparation for Clang support.

Signed-off-by: Greg Hackmann <ghackmann@android.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Tri Vo <trong@android.com>
Tested-by: Trilok Soni <tsoni@quicinc.com>
Tested-by: Prasad Sodagudi <psodagud@quicinc.com>
Tested-by: Tri Vo <trong@android.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 kernel/gcov/Makefile   |  4 +-
 kernel/gcov/base.c     | 84 +----------------------------------------
 kernel/gcov/gcc_base.c | 86 ++++++++++++++++++++++++++++++++++++++++++
 kernel/gcov/gcov.h     |  3 ++
 4 files changed, 93 insertions(+), 84 deletions(-)
 create mode 100644 kernel/gcov/gcc_base.c

diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
index ff06d64df397..45431ed679d1 100644
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -2,5 +2,5 @@
 ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
 
 obj-y := base.o fs.o
-obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_3_4.o
-obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_4_7.o
+obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_base.o gcc_3_4.o
+obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_base.o gcc_4_7.o
diff --git a/kernel/gcov/base.c b/kernel/gcov/base.c
index 9c7c8d5c18f2..799d42072727 100644
--- a/kernel/gcov/base.c
+++ b/kernel/gcov/base.c
@@ -22,88 +22,8 @@
 #include <linux/sched.h>
 #include "gcov.h"
 
-static int gcov_events_enabled;
-static DEFINE_MUTEX(gcov_lock);
-
-/*
- * __gcov_init is called by gcc-generated constructor code for each object
- * file compiled with -fprofile-arcs.
- */
-void __gcov_init(struct gcov_info *info)
-{
-	static unsigned int gcov_version;
-
-	mutex_lock(&gcov_lock);
-	if (gcov_version == 0) {
-		gcov_version = gcov_info_version(info);
-		/*
-		 * Printing gcc's version magic may prove useful for debugging
-		 * incompatibility reports.
-		 */
-		pr_info("version magic: 0x%x\n", gcov_version);
-	}
-	/*
-	 * Add new profiling data structure to list and inform event
-	 * listener.
-	 */
-	gcov_info_link(info);
-	if (gcov_events_enabled)
-		gcov_event(GCOV_ADD, info);
-	mutex_unlock(&gcov_lock);
-}
-EXPORT_SYMBOL(__gcov_init);
-
-/*
- * These functions may be referenced by gcc-generated profiling code but serve
- * no function for kernel profiling.
- */
-void __gcov_flush(void)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_flush);
-
-void __gcov_merge_add(gcov_type *counters, unsigned int n_counters)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_merge_add);
-
-void __gcov_merge_single(gcov_type *counters, unsigned int n_counters)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_merge_single);
-
-void __gcov_merge_delta(gcov_type *counters, unsigned int n_counters)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_merge_delta);
-
-void __gcov_merge_ior(gcov_type *counters, unsigned int n_counters)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_merge_ior);
-
-void __gcov_merge_time_profile(gcov_type *counters, unsigned int n_counters)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_merge_time_profile);
-
-void __gcov_merge_icall_topn(gcov_type *counters, unsigned int n_counters)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_merge_icall_topn);
-
-void __gcov_exit(void)
-{
-	/* Unused. */
-}
-EXPORT_SYMBOL(__gcov_exit);
+int gcov_events_enabled;
+DEFINE_MUTEX(gcov_lock);
 
 /**
  * gcov_enable_events - enable event reporting through gcov_event()
diff --git a/kernel/gcov/gcc_base.c b/kernel/gcov/gcc_base.c
new file mode 100644
index 000000000000..3cf736b9f880
--- /dev/null
+++ b/kernel/gcov/gcc_base.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include "gcov.h"
+
+/*
+ * __gcov_init is called by gcc-generated constructor code for each object
+ * file compiled with -fprofile-arcs.
+ */
+void __gcov_init(struct gcov_info *info)
+{
+	static unsigned int gcov_version;
+
+	mutex_lock(&gcov_lock);
+	if (gcov_version == 0) {
+		gcov_version = gcov_info_version(info);
+		/*
+		 * Printing gcc's version magic may prove useful for debugging
+		 * incompatibility reports.
+		 */
+		pr_info("version magic: 0x%x\n", gcov_version);
+	}
+	/*
+	 * Add new profiling data structure to list and inform event
+	 * listener.
+	 */
+	gcov_info_link(info);
+	if (gcov_events_enabled)
+		gcov_event(GCOV_ADD, info);
+	mutex_unlock(&gcov_lock);
+}
+EXPORT_SYMBOL(__gcov_init);
+
+/*
+ * These functions may be referenced by gcc-generated profiling code but serve
+ * no function for kernel profiling.
+ */
+void __gcov_flush(void)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_flush);
+
+void __gcov_merge_add(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_add);
+
+void __gcov_merge_single(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_single);
+
+void __gcov_merge_delta(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_delta);
+
+void __gcov_merge_ior(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_ior);
+
+void __gcov_merge_time_profile(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_time_profile);
+
+void __gcov_merge_icall_topn(gcov_type *counters, unsigned int n_counters)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_merge_icall_topn);
+
+void __gcov_exit(void)
+{
+	/* Unused. */
+}
+EXPORT_SYMBOL(__gcov_exit);
diff --git a/kernel/gcov/gcov.h b/kernel/gcov/gcov.h
index de118ad4a024..0ecf1d664ec3 100644
--- a/kernel/gcov/gcov.h
+++ b/kernel/gcov/gcov.h
@@ -83,4 +83,7 @@ struct gcov_link {
 };
 extern const struct gcov_link gcov_link[];
 
+extern int gcov_events_enabled;
+extern struct mutex gcov_lock;
+
 #endif /* GCOV_H */
-- 
2.21.0.225.g810b269d1ac-goog

