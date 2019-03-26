Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAFB2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZplhQc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfCZBkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:40:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34663 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfCZBki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:40:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so5922719pfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 18:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y5LzK+NGOQu00/0oiJaxPPBOSYz2xzWCsp+F1301xHI=;
        b=eZplhQc0JgvlvBk1kp2q6sEvEfSzf+9YfqzUT0oE5g8grWbOvfhJ5FEPfp31dFDosh
         klJC4dDtB7nfIt2PiBRHe0IpHhxdr5OZKU78e4FWnLogOIruPk5MImYq5M1iWQFkz3cd
         fGiRB4GBo+E7Wpz6qShB+e2TrtcadfTYICZaa3h25ZozTTwLMXx21b8TikGSKvxfZOyS
         c2tRq4WctfOMw5vo5vzGBSQFJZU+sPzdoWXOdYoDK1frSWZ2p0fcUaesC/wwjpWiO8tE
         QQsYBiiT8Z+YRS4i1nAHl1A+BZvjVhCv5pnjCBbAJVevWOzxo95htBOd8GCCY+Jsrv1l
         j06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y5LzK+NGOQu00/0oiJaxPPBOSYz2xzWCsp+F1301xHI=;
        b=BWCCYAife4ZCyUxz6hxhFg2Fyatp18Hsc2cGlkMOMq3VJk2MI4VQAffeTlqpSbgULO
         0L+69i18Kjgbp+nHv1ecdyMjyEP5d0FpQ6mx7GUXh83Q6mpPq4/MbAo0hI3tNdMJYYWX
         kjSUA5jYNXDQLU1f2QPGi07EdeKQfPPXep+RufyMCk0WwfwezTsbyg1nOa3QxqcRD3bA
         CMkDvJR6E038fEaLH3R7F3EOnHMqgFyQtuZjNh4Kuwkz/NoNHf8dVmcNtZFfUWsTZIOZ
         i/0KGJP+vU9Zr4pOIXWheFTkn4zhRUaIbcqt8IVP8LAO1fHdr7HGu1V4UURSreW6s6rB
         Cf4w==
X-Gm-Message-State: APjAAAUswl9otnP+vhrzRbkcEB4Fu0SnIrvvAHwafNgAItpi7r9KGJqF
        SiQeUswhUxwn6mQunStIDCo=
X-Google-Smtp-Source: APXvYqxQR9eGz7KXsPMP74Ci+uCVmkD2/bVTHAU4QLd6a3FVB7A3nd4oCvbMfZTwawhmD7p9x72m1Q==
X-Received: by 2002:a63:6786:: with SMTP id b128mr17034690pgc.318.1553564437558;
        Mon, 25 Mar 2019 18:40:37 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id m7sm41464119pgg.62.2019.03.25.18.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 18:40:36 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     shaoyafang@didiglobal.com, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 2/3] sched/fair: do not expose some tracepoints to user if CONFIG_SCHEDSTATS is not set
Date:   Tue, 26 Mar 2019 09:40:06 +0800
Message-Id: <1553564407-1162-3-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553564407-1162-1-git-send-email-laoar.shao@gmail.com>
References: <1553564407-1162-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracepoints trace_sched_stat_{iowait, blocked, wait, sleep} should
be not exposed to user if CONFIG_SCHEDSTATS is not set.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/sched.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9a4bdfa..4686c7f 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -336,6 +336,7 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 		  __entry->pid, __entry->old_pid)
 );
 
+#ifdef CONFIG_SCHEDSTATS
 /*
  * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE
  *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
@@ -395,6 +396,19 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 	     TP_PROTO(struct task_struct *tsk, u64 delay),
 	     TP_ARGS(tsk, delay));
 
+#else /* CONFIG_SCHEDSTATS */
+
+TRACE_EVENT_NONE(sched_stat_wait,
+		 TP_PROTO(struct task_struct *tsk, u64 delay));
+TRACE_EVENT_NONE(sched_stat_sleep,
+		 TP_PROTO(struct task_struct *tsk, u64 delay));
+TRACE_EVENT_NONE(sched_stat_iowait,
+		 TP_PROTO(struct task_struct *tsk, u64 delay));
+TRACE_EVENT_NONE(sched_stat_blocked,
+		 TP_PROTO(struct task_struct *tsk, u64 delay));
+
+#endif /* CONFIG_SCHEDSTATS */
+
 /*
  * Tracepoint for accounting runtime (time the task is executing
  * on a CPU).
-- 
1.8.3.1

