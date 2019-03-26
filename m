Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8A0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9EF2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLq7A+xy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfCZBkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:40:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37654 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfCZBkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:40:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id q6so822355pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 18:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9dpIZIy9gCyE7D6yDcqhwzJJ98DH5uQDvoJ4ObuHyl8=;
        b=kLq7A+xy7lyi5BtN1RX486UF1RizLtOtVCjlyVj72sZAVsO6GcEfSMyQEz4aALaXAP
         fcEOu7hV10PINlc4S4JQq+Bidaa1bqB7NTzJn27AgG6n+FkYKZrQ7k44CuCeeu1fAI8O
         vZ25yJu2qXEDmJXZmO3MG5GPxwZi6l0pU5clHf24PbDau30y83CcyULWBiZBfccUXHZt
         VMtIX/zB6BF2Cy/vyqzCY+6jDjR3uHLZ4r3iC1wcNt9h0ls8VkSFo0/LvIJOyu/pusQM
         FmXsWPy/g232H+XDHzDoKNsJ+LGPfkssLwVcCdZiYA+OfruUbZp45iCpxJ8f/8QriOKr
         VYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9dpIZIy9gCyE7D6yDcqhwzJJ98DH5uQDvoJ4ObuHyl8=;
        b=L7byZRR2GCJBk6iqzqwz1r1Y7/m89FEugmfNK048z6NjeE+jnlQmAV9f4r0vJXfPPe
         BHRf5rZ5oCGd+5/YCKTKV2IkMNFnXfweI7Im1h7NPkOW9bhFW2kQfaGF+xJBy1urh2/P
         EcT5UofFWplEpxTKGc1x2v8Bcv7cxIp9Tpd4oP55TjRK9H9KBEOSS6ROJWjwBPeOwp8h
         0KucMgevcg1ikHVVYohyjiIKBoIR6gGuKzTG71smfv7wBbP9C7m9nUhef+2UGxJXYHLr
         CXoeYcbhHZNuHcgVwc3xCBIhzmXqsSHdnE8xuW23wgpoYui7iOSzzWLXd+ndap5bbrKK
         ZzUQ==
X-Gm-Message-State: APjAAAUtSbsfOARuKWM7U7QHETClxDLujQCJWlimxwwnRziJUTKBCTqE
        T7NarKm3k/e4SfiTiujRQkw=
X-Google-Smtp-Source: APXvYqxP42wkvx9GQCTJktQXb0wQzrs0fBE6MwZxAPXEiEo5DRGLBwY54g8FjKzNzaei4eqwN2LuaQ==
X-Received: by 2002:a17:902:bb05:: with SMTP id l5mr8572116pls.311.1553564431386;
        Mon, 25 Mar 2019 18:40:31 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id m7sm41464119pgg.62.2019.03.25.18.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 18:40:30 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org
Cc:     shaoyafang@didiglobal.com, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/3] tracing: introduce TRACE_EVENT_NONE()
Date:   Tue, 26 Mar 2019 09:40:05 +0800
Message-Id: <1553564407-1162-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1553564407-1162-1-git-send-email-laoar.shao@gmail.com>
References: <1553564407-1162-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want define a tracepoint as a do-nothing function.
So I introduce this TRACE_EVENT_NONE() for this kind of usage.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/tracepoint.h   | 8 ++++++++
 include/trace/define_trace.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 9c31865..d00c5e6 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -548,4 +548,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #define TRACE_EVENT_PERF_PERM(event, expr...)
 
+#define TRACE_EVENT_NONE(name, proto)				\
+	static inline void trace_##name(proto)			\
+	{ }							\
+	static inline bool trace_##name##_enabled(void)		\
+	{							\
+		return false;					\
+	}
+
 #endif /* ifdef TRACE_EVENT (see note above) */
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index cb30c55..a833b6f 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -46,6 +46,9 @@
 		assign, print, reg, unreg)			\
 	DEFINE_TRACE_FN(name, reg, unreg)
 
+#undef TRACE_EVENT_NONE
+#define TRACE_EVENT_NONE(name, proto)
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args) \
 	DEFINE_TRACE(name)
@@ -102,6 +105,7 @@
 #undef TRACE_EVENT_FN
 #undef TRACE_EVENT_FN_COND
 #undef TRACE_EVENT_CONDITION
+#undef TRACE_EVENT_NONE
 #undef DECLARE_EVENT_CLASS
 #undef DEFINE_EVENT
 #undef DEFINE_EVENT_FN
-- 
1.8.3.1

