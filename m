Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF328C17447
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAC32196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Np+AhLdE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKLB1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:27:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34264 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfKLB1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:27:38 -0500
Received: by mail-wm1-f67.google.com with SMTP id j18so1133507wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1LUDXBB8p4SWDZcyqO1bx/Tpm6RXRLsAhLch+D7CesM=;
        b=Np+AhLdECbNazejClk/a7TVO4e1SYS3ecZZMmIovr4QUo4n3sPwwe86RzsX9Npgeg+
         RD+ht8NU/XXfpfzxRE4qjmFFqHXOdZoUSKIYDHzCSJSyGvRGmZzuMmXGpIOR2Rvrwgce
         /wX2BAI5XPrE784FbFCE4cTM9fP5S9ytX4rl9G0zPIFtfyKsbgNq3UFTsMtHYwVsB1Gm
         Jn1tFo5/Ll46wNmJUeyjw+HfETwataqskbvjI5sIRVia0K2KosVTRaUDNiU6uKTIUyFq
         +SUPVhANn0cpsXh4fsATXOoMaVTzG6ZxaD2YqPgvkxEAn6qXQ8TEDiYAET9yfE+lYGu9
         792A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1LUDXBB8p4SWDZcyqO1bx/Tpm6RXRLsAhLch+D7CesM=;
        b=WLCt2w7dK+Un0Ay0ssmluMB3KFpYhHEXq2LE/5kSHyIVXb7/wEvKO4w5C9pCoEz76B
         wnUUZ7vMvCWNxvIiCNChXj5bOUotb+n29AjfpLIUWWh/OMANiy9e3mJThgt2stXNoBjH
         p5sIcp2EIcA7MgB8yF5xmA77N/meh7FPBxO7LETEKpwiy/Vs9p3fks2MnNYcYWoJJbpB
         oJ54Decw4N3+qqPpYu8lbDwLhXuAGgWs/RVXbX53KA8ZJxIwIHahFdle3WQK/fa/sOO9
         pZsyOYnPx5vgorPpnsMUdlLPkKqvz6oFnvvsdaeag7F6TxAlNW021+76W8oMQh5iCZz/
         JXxg==
X-Gm-Message-State: APjAAAVz8p9BdNoLDMDz4yhZqfFFXTk7EE6UYPwEpd3lbNmKYHxgsE+D
        Jn9M9B7ncBNQCGQdeuOStGesiT4hjk8=
X-Google-Smtp-Source: APXvYqxA+P+8170d9z5KNSrQMlSPGeDQlZV0PAWgY8kB//ieNASdl9SUMvosabPuxvilMRpl7JHEnQ==
X-Received: by 2002:a1c:998f:: with SMTP id b137mr1618590wme.104.1573522056635;
        Mon, 11 Nov 2019 17:27:36 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:36 -0800 (PST)
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
Subject: [PATCHv8 04/34] time: Add timens_offsets to be used for tasks in timens
Date:   Tue, 12 Nov 2019 01:26:53 +0000
Message-Id: <20191112012724.250792-5-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
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
2.24.0

