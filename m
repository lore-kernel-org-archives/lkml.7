Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A210C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4E4217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564434943;
	bh=q4r3/xXyQIdY27voN2IGQxMw00U3Yk78rY1J9t+EXfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lZGSY6gRwmjucd5NLwYLwqVmdcA1MKjlsKPwdd/p9jLN8i0uDStRbqbG5kloU/ZBH
	 97ZQRuR5c2mvtuM2IO+n0jX8Zn5OXlNQayopHk6qBu2nC6rnK2eGyF59Z/QcOY6K/P
	 oTFwycjpoG60MJvPH8rF2q8DslhISKHU+kPrP9ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbfG2VPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388719AbfG2VPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:15:30 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73DE6217D6;
        Mon, 29 Jul 2019 21:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564434929;
        bh=q4r3/xXyQIdY27voN2IGQxMw00U3Yk78rY1J9t+EXfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddj4/dje2vUjyW3GTLJ7deMBZf/03/hs90DUIlNJZuBgCX11Mdyf/UrP8yT6dSyZh
         FDJNGt0BLYCwfMmttrnqy4i/4xui6sSwTmfU1gwWRRGNkrD+4fDsWMl2IV2E+VqtCz
         cMs7JfFseeLeLRwJjHazVa7ehs1iiLXVeJl5nw6g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>
Subject: [PATCH 07/12] tools headers UAPI: Sync sched.h with the kernel
Date:   Mon, 29 Jul 2019 18:14:54 -0300
Message-Id: <20190729211456.6380-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729211456.6380-1-acme@kernel.org>
References: <20190729211456.6380-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes in:

  a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
  1d6362fa0cfc ("sched/core: Allow sched_setattr() to use the current policy")
  7f192e3cd316 ("fork: add clone3")

And silence this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
  diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h

No changes in tools/ due to the above.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Link: https://lkml.kernel.org/n/tip-mtrpsjrux5hgyr5uf8l1aa46@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index ed4ee170bee2..b3105ac1381a 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -2,6 +2,8 @@
 #ifndef _UAPI_LINUX_SCHED_H
 #define _UAPI_LINUX_SCHED_H
 
+#include <linux/types.h>
+
 /*
  * cloning flags:
  */
@@ -31,6 +33,20 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
+/*
+ * Arguments for the clone3 syscall
+ */
+struct clone_args {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+};
+
 /*
  * Scheduling policies
  */
@@ -51,9 +67,21 @@
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
 #define SCHED_FLAG_DL_OVERRUN		0x04
+#define SCHED_FLAG_KEEP_POLICY		0x08
+#define SCHED_FLAG_KEEP_PARAMS		0x10
+#define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
+#define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+
+#define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
+				 SCHED_FLAG_KEEP_PARAMS)
+
+#define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
+				 SCHED_FLAG_UTIL_CLAMP_MAX)
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
-			 SCHED_FLAG_DL_OVERRUN)
+			 SCHED_FLAG_DL_OVERRUN		| \
+			 SCHED_FLAG_KEEP_ALL		| \
+			 SCHED_FLAG_UTIL_CLAMP)
 
 #endif /* _UAPI_LINUX_SCHED_H */
-- 
2.21.0

