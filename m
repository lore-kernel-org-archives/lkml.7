Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FC8C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7EB21721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="G3xBxusS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfFLT2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:28:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37129 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfFLT0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:26:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so18131326wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+0bCsvW0leJeWcSaXdF9Pf6o6k198MJcOxy/7YaYSY=;
        b=G3xBxusSn3AJXI3lbO60Zw8icEb9IYRciGYBwSUszE4r9qdxvf3satBIm9c73YEMrG
         9DIhfmyklqZU0G75I9+SkqDh0R7i6a27QyiVtEE2wjs9Q+cCoUynJ4SXm6nF7GIoCh1o
         f6Z4S8lQlP9bkUjfW2cqjnmofW9/isPXn8JVXp/9cNwJgaeONsWRcDYRs22xiR8gvlgt
         YWg8v11V8RjsW51zv0MLB03eFKttm6QRV9tDeYOsdcH/mekV2WZSiUINlgNH4U1VuT21
         r9P9V+tx6Q2J0vPyHQwCt+ut/pit31wNLG5BO7Es87XXNTArjqGgxUZ7rbg+vXDcEDVG
         7tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+0bCsvW0leJeWcSaXdF9Pf6o6k198MJcOxy/7YaYSY=;
        b=BviNpbrJt0RyiEMUXYAL2Eld0wucBSt99bn13RW57IhzymsLuRu0f9J1ZxKh5zqJfw
         tea/2fMXHZRRZkkiaekbgLNhZVUUEdh4g2SHL2SiP8D2dVTHYtAvKdsQa5yYjuvcT42S
         QN9NyFaw7QKaFivUPO5cXYs4aK6Dp022eEfnnw+boOTwrMznF6ekbZ4KCKjmz7u1bJO3
         gCd7LuYPNc5UJD1yK+AVEv3LBJ31iLCCp0bUs2Wh0lpqrW3/ZuaF6ceF45fblIqcyk0h
         cc7oxlgzsIKsud85F9tDc2sAJ+YhrZQEHc++HtpRB/k92KqWGsCqXJBfpSdKrgOn+4rL
         x6nQ==
X-Gm-Message-State: APjAAAWOZzAVzqZZxRRdlxDr+iaXGH01Cg0OO3KoHiLA7St3YEEkSdqm
        PZtuZcl/yCSxa999EiyAN/YWZmNO9QA=
X-Google-Smtp-Source: APXvYqyKkGf4WbdKqtzWBxyv6vK7MB/pLfwtqXEj/31JuYGR+I/fvx1QsWtDX1YDefUU7xFLyrmcTw==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr36012935wrw.309.1560367597224;
        Wed, 12 Jun 2019 12:26:37 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:36 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [PATCHv4 05/28] timens: Introduce CLOCK_BOOTTIME offset
Date:   Wed, 12 Jun 2019 20:26:04 +0100
Message-Id: <20190612192628.23797-6-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Adds boottime virtualisation for time namespace.
Introduce timespec for boottime clock into timens offsets and wire
clock_gettime() syscall.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h | 9 +++++++++
 include/linux/timens_offsets.h | 1 +
 kernel/time/alarmtimer.c       | 1 +
 kernel/time/posix-stubs.c      | 1 +
 kernel/time/posix-timers.c     | 1 +
 5 files changed, 13 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 81d0c989df3c..1dda8af6b9fe 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -48,6 +48,14 @@ static inline void timens_add_monotonic(struct timespec64 *ts)
                 *ts = timespec64_add(*ts, ns_offsets->monotonic);
 }
 
+static inline void timens_add_boottime(struct timespec64 *ts)
+{
+        struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+
+        if (ns_offsets)
+                *ts = timespec64_add(*ts, ns_offsets->boottime);
+}
+
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -73,6 +81,7 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 }
 
 static inline void timens_add_monotonic(struct timespec64 *ts) {}
+static inline void timens_add_boottime(struct timespec64 *ts) {}
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index eaac2c82be5c..e93aabaa5e45 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -4,6 +4,7 @@
 
 struct timens_offsets {
 	struct timespec64 monotonic;
+	struct timespec64 boottime;
 };
 
 #endif
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 68a163c8b4f2..6346e6ee0d32 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -26,6 +26,7 @@
 #include <linux/freezer.h>
 #include <linux/compat.h>
 #include <linux/module.h>
+#include <linux/time_namespace.h>
 
 #include "posix-timers.h"
 
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 17c67e0aecd8..edaf075d1ee4 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -82,6 +82,7 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 		break;
 	case CLOCK_BOOTTIME:
 		ktime_get_boottime_ts64(tp);
+		timens_add_boottime(tp);
 		break;
 	default:
 		return -EINVAL;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 52098f6ad596..573942ae2629 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -240,6 +240,7 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 int posix_get_boottime_timespec(const clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_boottime_ts64(tp);
+	timens_add_boottime(tp);
 	return 0;
 }
 
-- 
2.22.0

