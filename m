Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34216C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F013020675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kduPkqa2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCGLUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:20:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35348 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfCGLUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:20:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id e17so11016877pgd.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 03:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Y/4kKmgfNhcZEpBfnXnIV8mrD1sFEAjo0NeebCdZe9Q=;
        b=kduPkqa25Wkrc1EWVKaI+i7l98P2xd3C2YGUc/HHs/9naI+4vws+MK+QR0Nz+WtRIX
         bI3wcLpcYcZt1TjBqdHpBAuUruHc1nag8n7/XnX7anQ+g4OXm/kPWy+ftPbBWscROfVk
         gByLnjlWaiauyT4gfagkx6bQ/jlVeNneHqFQMcB0wSG1oh9G/84wT8cmeOj/QwhDn4Im
         AdF68sWkJNi1lT2hYFy2gi+8ktR21a/Udrvt8OPH7jtYY6kAeXCbg4warlJ16FXoEJjN
         270fSFywquDYIg6CUyaHS0ryTVCUx0xQ3yZEJKOOSWRRo5ZKd1H+shCP4QReLgS5Djf2
         ecLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y/4kKmgfNhcZEpBfnXnIV8mrD1sFEAjo0NeebCdZe9Q=;
        b=FaXmXUzwscFm2sgrfiSOOpqedUKlbPoqubslTTQKTRroshD+7y8h/KjdzjmF6u/lJh
         VnCSZyZKYAYL5J1kXXkeTAiKlXG/bYHCELM0lPat2dq5+tI1vo69mbhZeNto2I8wLsud
         +lz0pdif4xo/AClYCQEPureanCO8u783GYZCJRC3iek4GU6Ds8L2D4hehdVUkV6DY9aa
         iIiQRYG6COIo5MLJJOAJzYABlNOIzdTt6c81O165Di9fuOMaPq6LiR5Sxa7j3B0MiqLg
         P+GLOye7xXgh57WHqg+ECFVOdkAOHysZ9ps9FsS15CSBB13SQOPuvlV7Eq+quwzFEQ7q
         Zokg==
X-Gm-Message-State: APjAAAViTq4SJgXDsVNO9hVGnCLyB3B23lyb7NfLfecoOOOWs4EM5EAK
        JRvIARVv9Rr4GuBYMMryo8k=
X-Google-Smtp-Source: APXvYqx1mvnjhbfkj/cG8JVjv6RYcRnKO1p00nuEqy49p+whOmkBh5gGVNYPoEp+Ze0K9R3IA444kQ==
X-Received: by 2002:a63:1105:: with SMTP id g5mr10965700pgl.322.1551957634274;
        Thu, 07 Mar 2019 03:20:34 -0800 (PST)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id a2sm6126929pff.58.2019.03.07.03.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 03:20:33 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2] sched: fair: fix missed CONFIG_SCHEDSTATS
Date:   Thu,  7 Mar 2019 19:20:11 +0800
Message-Id: <1551957611-31457-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I'm using trace_sched_stat_{iowait, blocked, wait, sleep} to
measure how long the processes are stalled, there's always no output
from
trace_pipe while there're really some tasks in uninterruptible sleep
state. That makes me confused, so I try to investigate why.
Finally I find the reason is that CONFIG_SCHEDSTATS is not set.

To avoid such kind of confusion, we should not expose these tracepoints
if CONFIG_SCHEDSTATS is not set.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/trace/events/sched.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9a4bdfa..f060940 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -241,7 +241,6 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 DEFINE_EVENT(sched_process_template, sched_process_free,
 	     TP_PROTO(struct task_struct *p),
 	     TP_ARGS(p));
-	     
 
 /*
  * Tracepoint for a task exiting:
@@ -336,6 +335,7 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 		  __entry->pid, __entry->old_pid)
 );
 
+#ifdef CONFIG_SCHEDSTATS
 /*
  * XXX the below sched_stat tracepoints only apply to SCHED_OTHER/BATCH/IDLE
  *     adding sched_stat support to SCHED_FIFO/RR would be welcome.
@@ -395,6 +395,28 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 	     TP_PROTO(struct task_struct *tsk, u64 delay),
 	     TP_ARGS(tsk, delay));
 
+#else
+
+#ifndef DEFINE_EVENT_NONE
+#define DEFINE_EVENT_NONE(name, var)		\
+	static inline void trace_##name(var)	\
+	{					\
+	}
+
+DEFINE_EVENT_NONE(sched_stat_wait,
+		  TP_PROTO(struct task_struct *tsk, u64 delay))
+
+DEFINE_EVENT_NONE(sched_stat_sleep,
+		  TP_PROTO(struct task_struct *tsk, u64 delay))
+
+DEFINE_EVENT_NONE(sched_stat_iowait,
+		  TP_PROTO(struct task_struct *tsk, u64 delay))
+
+DEFINE_EVENT_NONE(sched_stat_blocked,
+		  TP_PROTO(struct task_struct *tsk, u64 delay))
+#endif
+#endif
+
 /*
  * Tracepoint for accounting runtime (time the task is executing
  * on a CPU).
-- 
1.8.3.1

