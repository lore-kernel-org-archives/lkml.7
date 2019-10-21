Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555FACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B212184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388240AbfJVIMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:12:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:64390 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387614AbfJVIMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:12:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 01:12:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="200703487"
Received: from sqa-gate.sh.intel.com (HELO clx-ap-likexu.tsp.org) ([10.239.48.212])
  by orsmga003.jf.intel.com with ESMTP; 22 Oct 2019 01:12:21 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     pbonzini@redhat.com, peterz@infradead.org, kvm@vger.kernel.org
Cc:     like.xu@intel.com, linux-kernel@vger.kernel.org,
        jmattson@google.com, sean.j.christopherson@intel.com,
        wei.w.wang@intel.com, kan.liang@intel.com
Subject: [PATCH v3 1/6] perf/core: Provide a kernel-internal interface to recalibrate event period
Date:   Tue, 22 Oct 2019 00:06:46 +0800
Message-Id: <20191021160651.49508-2-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021160651.49508-1-like.xu@linux.intel.com>
References: <20191021160651.49508-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, perf_event_period() is used by user tools via ioctl. Based on
naming convention, exporting perf_event_period() for kernel users (such
as KVM) who may recalibrate the event period for their assigned counter
according to their requirements.

The perf_event_period() is an external accessor, just like the
perf_event_{en,dis}able() and should thus use perf_event_ctx_lock().

Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 include/linux/perf_event.h |  5 +++++
 kernel/events/core.c       | 28 +++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61448c19a132..d601df36e671 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1336,6 +1336,7 @@ extern void perf_event_disable_local(struct perf_event *event);
 extern void perf_event_disable_inatomic(struct perf_event *event);
 extern void perf_event_task_tick(void);
 extern int perf_event_account_interrupt(struct perf_event *event);
+extern int perf_event_period(struct perf_event *event, u64 value);
 #else /* !CONFIG_PERF_EVENTS: */
 static inline void *
 perf_aux_output_begin(struct perf_output_handle *handle,
@@ -1415,6 +1416,10 @@ static inline void perf_event_disable(struct perf_event *event)		{ }
 static inline int __perf_event_disable(void *info)			{ return -1; }
 static inline void perf_event_task_tick(void)				{ }
 static inline int perf_event_release_kernel(struct perf_event *event)	{ return 0; }
+static inline int perf_event_period(struct perf_event *event, u64 value)
+{
+	return -EINVAL;
+}
 #endif
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9ec0b0bfddbd..e1b83d2731da 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5106,16 +5106,11 @@ static int perf_event_check_period(struct perf_event *event, u64 value)
 	return event->pmu->check_period(event, value);
 }
 
-static int perf_event_period(struct perf_event *event, u64 __user *arg)
+static int _perf_event_period(struct perf_event *event, u64 value)
 {
-	u64 value;
-
 	if (!is_sampling_event(event))
 		return -EINVAL;
 
-	if (copy_from_user(&value, arg, sizeof(value)))
-		return -EFAULT;
-
 	if (!value)
 		return -EINVAL;
 
@@ -5133,6 +5128,19 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
 	return 0;
 }
 
+int perf_event_period(struct perf_event *event, u64 value)
+{
+	struct perf_event_context *ctx;
+	int ret;
+
+	ctx = perf_event_ctx_lock(event);
+	ret = _perf_event_period(event, value);
+	perf_event_ctx_unlock(event, ctx);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(perf_event_period);
+
 static const struct file_operations perf_fops;
 
 static inline int perf_fget_light(int fd, struct fd *p)
@@ -5176,8 +5184,14 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 		return _perf_event_refresh(event, arg);
 
 	case PERF_EVENT_IOC_PERIOD:
-		return perf_event_period(event, (u64 __user *)arg);
+	{
+		u64 value;
+
+		if (copy_from_user(&value, (u64 __user *)arg, sizeof(value)))
+			return -EFAULT;
 
+		return _perf_event_period(event, value);
+	}
 	case PERF_EVENT_IOC_ID:
 	{
 		u64 id = primary_event_id(event);
-- 
2.21.0

