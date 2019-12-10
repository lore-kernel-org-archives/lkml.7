Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD92C2D0C6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1D82073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 09:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IEDYzP+t";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="L3C+0VpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfLJJPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 04:15:20 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:55414
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727227AbfLJJPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575969316;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=+q+DIo7o+t5flIqe6jyJka/bX4OKYvU6jVHhUFrKrr4=;
        b=IEDYzP+tK4vSXF3gW1jF/gAsENn/rvjBfc9/lZCVqEgtgub/A2Aj7KPKoEtzCrym
        mhXXtVJ50393fTAm5fc+uDs8G+LAq8DSMBhjRRuoa8b9qF9s70j4L82UzrJB/NYfnTn
        hoNKrfxCzKeLCsorj/vx1VN75QwU64UBbAfbrbkw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575969316;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=+q+DIo7o+t5flIqe6jyJka/bX4OKYvU6jVHhUFrKrr4=;
        b=L3C+0VpPKqTrMfK2G1lxHf/aF4Y6xb/tYr4kZ8qfboD2rBHExcuypv38+ZXLfpZS
        7QUJZC//UaMGE/jXHX0qDKONOsawao3UTrnShSbZxf0Ch0GI+sDsbwhhhQxyZnMhrhV
        g0s5RBS3UcgKKovToTfwcxgjF3+cJ91wk5dIX58M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D38AFC49482
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
From:   Prateek Sood <prsood@codeaurora.org>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, kaushalk@codeaurora.org,
        Prateek Sood <prsood@codeaurora.org>
Subject: [PATCH v3] tracing: Fix lock inversion in trace_event_enable_tgid_record()
Date:   Tue, 10 Dec 2019 09:15:16 +0000
Message-ID: <0101016eef175eef-efa77b74-ade6-4505-babf-98a98f25252e-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20191209142314.4f3e04d6@gandalf.local.home>
References: <20191209142314.4f3e04d6@gandalf.local.home>
X-SES-Outgoing: 2019.12.10-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Are you suggesting something like below?

>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8


       Task T2                             Task T3
trace_options_core_write()            subsystem_open()

 mutex_lock(trace_types_lock)           mutex_lock(event_mutex)

 set_tracer_flag()

   trace_event_enable_tgid_record()       mutex_lock(trace_types_lock)

    mutex_lock(event_mutex)

This gives a circular dependency deadlock between trace_types_lock and
event_mutex. To fix this invert the usage of trace_types_lock and
event_mutex in trace_options_core_write(). This keeps the sequence of
lock usage consistent.

Signed-off-by: Prateek Sood <prsood@codeaurora.org>
---
 kernel/trace/trace.c        | 8 ++++++++
 kernel/trace/trace_events.c | 8 ++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6a0ee91..4dc93e3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4590,6 +4590,10 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
 
 int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 {
+	if ((mask == TRACE_ITER_RECORD_TGID) ||
+	    (mask == TRACE_ITER_RECORD_CMD))
+		lockdep_assert_held(&event_mutex);
+
 	/* do nothing if flag is already set */
 	if (!!(tr->trace_flags & mask) == !!enabled)
 		return 0;
@@ -4657,6 +4661,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
 
 	cmp += len;
 
+	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
 
 	ret = match_string(trace_options, -1, cmp);
@@ -4667,6 +4672,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
 		ret = set_tracer_flag(tr, 1 << ret, !neg);
 
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 
 	/*
 	 * If the first trailing whitespace is replaced with '\0' by strstrip,
@@ -7972,9 +7978,11 @@ static void get_tr_index(void *data, struct trace_array **ptr,
 	if (val != 0 && val != 1)
 		return -EINVAL;
 
+	mutex_lock(&event_mutex);
 	mutex_lock(&trace_types_lock);
 	ret = set_tracer_flag(tr, 1 << index, val);
 	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
 
 	if (ret < 0)
 		return ret;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index fba87d1..995061b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -320,7 +320,8 @@ void trace_event_enable_cmd_record(bool enable)
 	struct trace_event_file *file;
 	struct trace_array *tr;
 
-	mutex_lock(&event_mutex);
+	lockdep_assert_held(&event_mutex);
+
 	do_for_each_event_file(tr, file) {
 
 		if (!(file->flags & EVENT_FILE_FL_ENABLED))
@@ -334,7 +335,6 @@ void trace_event_enable_cmd_record(bool enable)
 			clear_bit(EVENT_FILE_FL_RECORDED_CMD_BIT, &file->flags);
 		}
 	} while_for_each_event_file();
-	mutex_unlock(&event_mutex);
 }
 
 void trace_event_enable_tgid_record(bool enable)
@@ -342,7 +342,8 @@ void trace_event_enable_tgid_record(bool enable)
 	struct trace_event_file *file;
 	struct trace_array *tr;
 
-	mutex_lock(&event_mutex);
+	lockdep_assert_held(&event_mutex);
+
 	do_for_each_event_file(tr, file) {
 		if (!(file->flags & EVENT_FILE_FL_ENABLED))
 			continue;
@@ -356,7 +357,6 @@ void trace_event_enable_tgid_record(bool enable)
 				  &file->flags);
 		}
 	} while_for_each_event_file();
-	mutex_unlock(&event_mutex);
 }
 
 static int __ftrace_event_enable_disable(struct trace_event_file *file,
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

