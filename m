Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3973CC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EECCF206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HQio8kJ5";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Tt55jyBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfLDJgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:36:03 -0500
Received: from a27-18.smtp-out.us-west-2.amazonses.com ([54.240.27.18]:51298
        "EHLO a27-18.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbfLDJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575452161;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=1QvqaMIDH5xRaCNrSAS5G5HcZdowy4mzv3Q6UfsNv+M=;
        b=HQio8kJ5JDUtInkMIX3EKorXT3PGodF9+Z21rDFSQh9M9cbyJHCNOgr6Ro5PM5uT
        ULbkVFF+ge+0MXiwDK4LEOL4jFDVOyS92J17oUtcggxoGGKRMZccwVZOZIqTyPuXeCc
        a3WHprhP4zOo+8z+TT5qi/nXAY1KBgBbV21Hc8jw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575452161;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=1QvqaMIDH5xRaCNrSAS5G5HcZdowy4mzv3Q6UfsNv+M=;
        b=Tt55jyBI4QDKgNIjeBb343ydUjzfX/24G9zNVxRPmwgpCcaRDIiJNal9yzI+eVjJ
        uob9ysh+fae1dQfSFGWuatAq3Oz+H8Nm1FVc2+ts/RPtzFoxTtP7Ghxm11DSjUD9a9J
        SUVrH4h8x7mI0qj7Lf3BzYGcJ6WkuELJdTCE8Y9o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DBF1C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
Subject: [PATCH v2] tracing: Fix lock inversion in
 trace_event_enable_tgid_record()
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, kaushalk@codeaurora.org
References: <0101016ecf398cfb-7361e722-7792-423a-85cf-7dd2fe048e9d-000000@us-west-2.amazonses.com>
 <1575435333-21626-1-git-send-email-prsood@codeaurora.org>
From:   Prateek Sood <prsood@codeaurora.org>
Message-ID: <0101016ed044340c-a91f7ec7-d896-461c-8bf1-c1877c0c1889-000000@us-west-2.amazonses.com>
Date:   Wed, 4 Dec 2019 09:36:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575435333-21626-1-git-send-email-prsood@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-SES-Outgoing: 2019.12.04-54.240.27.18
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Prateek Sood<prsood@codeaurora.org>
---
  kernel/trace/trace.c              | 6 ++++++
  kernel/trace/trace_events.c       | 8 ++++----
  kernel/trace/trace_irqsoff.c      | 4 ++++
  kernel/trace/trace_sched_wakeup.c | 4 ++++
  4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6a0ee91..2c09aa1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4590,6 +4590,8 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
  
  int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
  {
+	lockdep_assert_held(&event_mutex);
+
  	/* do nothing if flag is already set */
  	if (!!(tr->trace_flags & mask) == !!enabled)
  		return 0;
@@ -4657,6 +4659,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
  
  	cmp += len;
  
+	mutex_lock(&event_mutex);
  	mutex_lock(&trace_types_lock);
  
  	ret = match_string(trace_options, -1, cmp);
@@ -4667,6 +4670,7 @@ static int trace_set_options(struct trace_array *tr, char *option)
  		ret = set_tracer_flag(tr, 1 << ret, !neg);
  
  	mutex_unlock(&trace_types_lock);
+	mutex_unlock(&event_mutex);
  
  	/*
  	 * If the first trailing whitespace is replaced with '\0' by strstrip,
@@ -7972,9 +7976,11 @@ static void get_tr_index(void *data, struct trace_array **ptr,
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
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index a745b0c..887cdb5 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -560,8 +560,10 @@ static int __irqsoff_tracer_init(struct trace_array *tr)
  	save_flags = tr->trace_flags;
  
  	/* non overwrite screws up the latency tracers */
+	mutex_lock(&event_mutex);
  	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, 1);
  	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, 1);
+	mutex_unlock(&event_mutex);
  
  	tr->max_latency = 0;
  	irqsoff_trace = tr;
@@ -586,8 +588,10 @@ static void __irqsoff_tracer_reset(struct trace_array *tr)
  
  	stop_irqsoff_tracer(tr, is_graph(tr));
  
+	mutex_lock(&event_mutex);
  	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, lat_flag);
  	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, overwrite_flag);
+	mutex_unlock(&event_mutex);
  	ftrace_reset_array_ops(tr);
  
  	irqsoff_busy = false;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 5e43b96..0bc67d1 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -671,8 +671,10 @@ static int __wakeup_tracer_init(struct trace_array *tr)
  	save_flags = tr->trace_flags;
  
  	/* non overwrite screws up the latency tracers */
+	mutex_lock(&event_mutex);
  	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, 1);
  	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, 1);
+	mutex_unlock(&event_mutex);
  
  	tr->max_latency = 0;
  	wakeup_trace = tr;
@@ -722,8 +724,10 @@ static void wakeup_tracer_reset(struct trace_array *tr)
  	/* make sure we put back any tasks we are tracing */
  	wakeup_reset(tr);
  
+	mutex_lock(&event_mutex);
  	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, lat_flag);
  	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, overwrite_flag);
+	mutex_unlock(&event_mutex);
  	ftrace_reset_array_ops(tr);
  	wakeup_busy = false;
  }
-- Qualcomm India Private Limited, on behalf of Qualcomm Innovation 
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation 
Collaborative Project.

