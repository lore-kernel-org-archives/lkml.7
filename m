Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0093C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B9E20879
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzwgTlwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfEYQ6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:58:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46393 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfEYQ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:58:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so2294927pfm.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dgl9OWPnnj/iQ3pQ+2spS25PUtCy589pg+sDA5BZybk=;
        b=AzwgTlwEKZ60ZFbY+PZQ8qBjB/OYYuf0ttrszoc/LB3LFsI976Oj0qCBCr4GIfC4bP
         j1YBld8WHA+DeTr8bYgbfslQMt6G8jqWDa8bMVo7xXhyLxDUN9FhIE910dzVL2TUF7fQ
         Qgs0am2LU5AUvQCxQfvL3sU5gZFOL/FCIqlVb+zDE8+53PV3XZ8EHlxRt65AkgjXHbgX
         6+vGyuQbb5wndZiyLx0tW8EMF2u+O2JQXQVJwjU83AlVhJ6VlKnYuZloH0IOjl9OgXHe
         rJZvaS0NdOSaYfhLo2Kq3sn+WRmFqYutcu+4i4spJp06HEd4pRAMnzOqBOULC+TSu82/
         b4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dgl9OWPnnj/iQ3pQ+2spS25PUtCy589pg+sDA5BZybk=;
        b=ssmx3sQjxjTkfu153HKbOGds9b2dRG07aGn02tBZvbBiUYNjpRIiw/LAogAD6IX3en
         a9kazcoRGw7d6e5IwPfPilPT+5CnmKK498+gYUH6rVtqHbtgkEj/7tWLRktFBdXj1EQI
         VMmIbR+NdPwM0WAQGbqm51SZ3HwtMYfy4o0CwHuSh5ZxFZ5gEcEbfJ3W+3OszL5VFlLC
         uTrDPdmi+LRMqIt0rfBArMvz/IQJTYbZ6EsruVbOgsEgj9JjLVBHGlQUbDvPC3m/T9Rw
         Q+xDyhi679yVLhe0EPIagiQKM4z7f3ppV8dS6HQzuh9AQd5H2Eh+jRRZlIffUeRnURc3
         XRTQ==
X-Gm-Message-State: APjAAAUdGSvmwnxTerbN523c0iRC4UOAMdCudt6VK5U/z/2bVOE2Ol2m
        DSsAsZFaqcOl6Yj1sG19QI61+1uf
X-Google-Smtp-Source: APXvYqy0l8n5YY6a7u1KCUNMve8gZ6E42iyu1QKwcjhNvmH4jSssK6VaGR92wlH/wqSFLuvwlGHwDQ==
X-Received: by 2002:a17:90a:bf01:: with SMTP id c1mr17593684pjs.78.1558803492955;
        Sat, 25 May 2019 09:58:12 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id q142sm8787585pfc.27.2019.05.25.09.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 May 2019 09:58:12 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 3/4] trace: make trace_get_fields() global
Date:   Sat, 25 May 2019 09:58:01 -0700
Message-Id: <20190525165802.25944-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525165802.25944-1-xiyou.wangcong@gmail.com>
References: <20190525165802.25944-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_get_fields() is the only way to read tracepoint fields at
run time, as their fields are defined at compile-time with macros.
Make this function visible to all users and it will be used by
trace event injection code to calculate the size of a tracepoint
entry.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 include/linux/trace_events.h | 8 ++++++++
 kernel/trace/trace_events.c  | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5c6f2a6c8cd2..5150436783e8 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -318,6 +318,14 @@ trace_event_name(struct trace_event_call *call)
 		return call->name;
 }
 
+static inline struct list_head *
+trace_get_fields(struct trace_event_call *event_call)
+{
+	if (!event_call->class->get_fields)
+		return &event_call->class->fields;
+	return event_call->class->get_fields(event_call);
+}
+
 struct trace_array;
 struct trace_subsystem_dir;
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0ce3db67f556..98df044d34ce 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -70,14 +70,6 @@ static int system_refcount_dec(struct event_subsystem *system)
 #define while_for_each_event_file()		\
 	}
 
-static struct list_head *
-trace_get_fields(struct trace_event_call *event_call)
-{
-	if (!event_call->class->get_fields)
-		return &event_call->class->fields;
-	return event_call->class->get_fields(event_call);
-}
-
 static struct ftrace_event_field *
 __find_event_field(struct list_head *head, char *name)
 {
-- 
2.21.0

