Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C8CC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DB821D6C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 01:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="diwpJPk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfJKBXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 21:23:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41112 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbfJKBXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 21:23:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id q9so9953279wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 18:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4NkZd3+L9Zc9aLTq5lNzxqpZor3mG4y4h8wq599474=;
        b=diwpJPk27mWG1S3iugiI7WTlAFCeA72zADOW4LdHzHMxWdBnffkKb6VvOO+j8lOaMw
         igpOKZ1JmF9v4oQ/59kmYCe3V6NbDxsayK6OBI4gWIU1xcIzWwsMvy1BTOtMmwDsIq6k
         M6zDwcfrqP+lPT1phry/1mMvSRaFW3mOcP1dLbM5qqxyJSTx368KWHYxgJLGwJeFz4TO
         ADo0D5YbbqhP9k4SzgAPjizWGfGRi2kDWaL81uuhkI3YF06bunaZZBPgKHjp+wqr08dh
         Axf9imDfYfWU8dxHvS1z/RcKBhMBY8yHWRHWryovnwKHlYNmb0bxdR7wlbKhxOZf5nXQ
         mtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4NkZd3+L9Zc9aLTq5lNzxqpZor3mG4y4h8wq599474=;
        b=iKmPUZPN+eQiVOymfw6kFQ2xGRv+ZKoCivPL2EWR+pNNef/k0vMXUwFYE6Z2qNKUob
         ayeP9bvtsRGd/RaHan+mpHDXhsXrh63cYP93/6NJwK1sQt425OSwclDDgljWgB/II6lR
         QjFLAmW0M7ACNQXe13YhrksnOKk2M9/JZprJ9tcXmdRLHqVezGqHlxO1t++rdRXAbS9H
         2UhlFriyjOb6r65ey+fFEV/uOZLMpzVSVTw/Cwo0CqitHiT46x+6Ot2asXzzKg+ubSxt
         To6F0jojGjYrB/mL+LYK7cfpx+iBz+zLXjczT+LjyggB5+8sDbFKT0y2fu+r0bDfLYiZ
         kx+g==
X-Gm-Message-State: APjAAAXnwNNE4XDCaqXE6Pb++JWBK4DHgkvZSB88t9liZkHtDY8uW+dZ
        YUYQWf1bfWGZwLTQgiteMA85ZR+6VT0=
X-Google-Smtp-Source: APXvYqyBfeXEbJQpSUBrKcxiMSbwYkh9g79/3pWnIBrMaU9cKsjY3PSa7qG8ZM9XXA6QPY4usvitOA==
X-Received: by 2002:adf:f50b:: with SMTP id q11mr7148735wro.310.1570757028130;
        Thu, 10 Oct 2019 18:23:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:23:47 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv7 02/33] time: Add timens_offsets to be used for tasks in timens
Date:   Fri, 11 Oct 2019 02:23:10 +0100
Message-Id: <20191011012341.846266-3-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Introduce offsets for time namespace. They will contain an adjustment
needed to convert clocks to/from host's.

A new namespace is created with the same offsets as the time namespace
of the current process.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h | 22 ++++++++++++++++++++++
 kernel/time/namespace.c        |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 873b908c9ba8..3d429c7ecca5 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -12,11 +12,17 @@
 struct user_namespace;
 extern struct user_namespace init_user_ns;
 
+struct timens_offsets {
+	struct timespec64 monotonic;
+	struct timespec64 boottime;
+};
+
 struct time_namespace {
 	struct kref kref;
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
 	struct ns_common ns;
+	struct timens_offsets offsets;
 } __randomize_layout;
 extern struct time_namespace init_time_ns;
 
@@ -37,6 +43,20 @@ static inline void put_time_ns(struct time_namespace *ns)
 	kref_put(&ns->kref, free_time_ns);
 }
 
+static inline void timens_add_monotonic(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;
+
+	*ts = timespec64_add(*ts, ns_offsets->monotonic);
+}
+
+static inline void timens_add_boottime(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;
+
+	*ts = timespec64_add(*ts, ns_offsets->boottime);
+}
+
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -61,6 +81,8 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 	return 0;
 }
 
+static inline void timens_add_monotonic(struct timespec64 *ts) {}
+static inline void timens_add_boottime(struct timespec64 *ts) {}
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 2662a69e0382..c2a58e45fc4b 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/err.h>
+#include <linux/mm.h>
 
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
@@ -60,6 +61,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	ns->ucounts = ucounts;
 	ns->ns.ops = &timens_operations;
 	ns->user_ns = get_user_ns(user_ns);
+	ns->offsets = old_ns->offsets;
 	return ns;
 
 fail_free:
-- 
2.23.0

