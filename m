Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1919C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8512070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHlbf4UU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfCZMNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:13:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33243 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZMNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:13:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so7996153pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 05:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mCYbGmR9tENrJETVY8U3vERANzorFWafknFB1qXIOrM=;
        b=QHlbf4UU3ilHN9JYT82ULeIK1MLOWiJZpWhw47R/UtiQShZhOYo/6rkvtB2jXotyLN
         fFeUchRriz5XmSW2EOEvsFpUpOfCgA3syL6GU6fvWkeuapmOo6/+v5kRqDX6kmONH4wz
         jeBmfIxch5XHIngA5WzIdbmpFzpplgkrSkk5KFScD7CgmMC/EMn2dnOz+AYhTuhHfC3A
         40+AkmOgOqYDPYlgdYA82SFTYzI0XRWu0Ohryy2h4MZnfs2epvtCgQYI+Tzu+ixhQhwJ
         HA1SJOA5pAYUDzmiHrMN/6nBE7AEkVqu1OL/J3QoIjrvWNqRFENF1y0rpwXgCYpE+G4t
         qCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mCYbGmR9tENrJETVY8U3vERANzorFWafknFB1qXIOrM=;
        b=i/pTbgj5St+xVvtivPmIxzeVqNkWbWz1PgKFI13z2rwe856Kqzg9NKH6iwHeb2msuI
         8APqrOtgDDa8/9AMpbkeaDtuyuF5DgN33B073dWBhgY+pnq0l8Sbv5ZxeBRGZawI6gNR
         NC0gSCVKTxR3TyIZJ6EpUZCIiPhydVAKqZqKn/qW8ZV4sHuNvLLdCEqn3GUQNTCK+lAo
         SAms1BlT/u5MfGqlwN+5l7+7oWopisctRT57YaF+q3zdB2f7ovRYySE7djTZR15Smxev
         jXOCUA+xD0CTVUKuyaSSDGe2ljqvW9dvQiWaLJ1wMulrjOp9cRRprkiOX+ryLtu6JCiF
         nkKw==
X-Gm-Message-State: APjAAAUSMwwmUbvHm4jA805P5EktZXISpG0cjYJt86YNUP1/bcBgxXV5
        6by+3w095nWFqyxGoxSa+Us=
X-Google-Smtp-Source: APXvYqzugEMVLXvkPliP/6KvNX6Bt9FBw2cechtEdao9/2mAvgpvcoTYSy8MTvT/8aqFa9M0zKZXiQ==
X-Received: by 2002:a62:e911:: with SMTP id j17mr29343193pfh.107.1553602429012;
        Tue, 26 Mar 2019 05:13:49 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id e2sm31263881pfa.64.2019.03.26.05.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 05:13:48 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, peterz@infradead.org, paulmck@linux.ibm.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 1/3] tracing: introduce TRACE_EVENT_NOP()
Date:   Tue, 26 Mar 2019 20:13:09 +0800
Message-Id: <1553602391-11926-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553602391-11926-1-git-send-email-laoar.shao@gmail.com>
References: <1553602391-11926-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want to define a tracepoint as a do-nothing function.
So I introduce TRACE_EVENT_NOP, DECLARE_EVENT_CLASS_NOP and
DEFINE_EVENT_NOP for this kind of usage.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/tracepoint.h   | 15 +++++++++++++++
 include/trace/define_trace.h |  8 ++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 9c31865..86b019a 100644
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
index cb30c55..bd75f97 100644
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
1.8.3.1

