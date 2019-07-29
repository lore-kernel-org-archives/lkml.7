Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B31C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D30216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="XCeulL1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbfG2V7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:59:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40556 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730601AbfG2V7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:59:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so54830902wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ka7x1gX+cc0hv8MDuwO2Malh6j1ZrZUM3jDIBgobxjI=;
        b=XCeulL1HqFo71FGgcdV/5qsSDWdEGSIBblaeaVZGBZUjTcko2yKOt8vaOVNS9Umo4x
         BYK3fAoJ8NZLicm4kDYLSHzAk7dusf9h95YXBk4IKA/FDB4tFYfCdIOznpZSk7WTT+ze
         gj0sOFP0LVlO6b45XQSbeoGr3ZD94Pj5LqPOjImqrrYvzx9mykAhdhw18TZF8RWlkujj
         hMmNo7mXw7jF4SlHvV9Vnrq5ZNGA1MR1frTUyL/Ul51gAgwS3CHdjjX9h4zJcvhtmlc0
         /zSI6gJ7eFXRY7kIqVjYY3CzIueKbZXgWPuJcuSQudYSrWXGM97tyMj8L8VD0Ijy0vHt
         5nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ka7x1gX+cc0hv8MDuwO2Malh6j1ZrZUM3jDIBgobxjI=;
        b=oAETKNTk5sZXU5RyOcbygWmWpREm4Cn8kBK3DfIsiqWH89+4wHT9QpDcSb1sn0I/yD
         coVInYJh0xoSw6A0X/f8/U4FsXEUTK35dL9/jEh0xCzspqmtfT24f7MPj58WThE1DCHN
         PBqPtJtPECL9+jr/5X27KdGcet/GINrDfZe/wpWP0ZF0iQGQMh8si6Jvb3JTppmWpA6l
         N1h6TazMFX/ND8mhZ3buZ6d74SkObJWLSaV7P8fRPY7ItpXV0r1mer1yvokz7JrKLcQK
         rJNEnV261de0qFLFQmWujlvhIxCiVzXkf3qF0NUU3qBWPovnwkLrWj7zCMRxc4jHcxMv
         ZEwA==
X-Gm-Message-State: APjAAAUrlQxwjVCVvRj4b227Y7Tj+T/09iPpZjJABozMRxMyVEBGxR0Z
        Nvwj2I7KnnEly3it/Dq76/I7QCr59YuB7eOsdMz6QGSlNi3DPPt7kt70bcRBzbM41T5PAOQKZYP
        IB/EzDo/s52ZfyT6kIm2+WqtpitfO0wx5IGjiSWcDd56JpXX1ZluQzaCyzw2ZFMbgpTHOH8cNjm
        JQyhmrn97ih9MnAb8H6LTgnNaQE9+QJpbKIVpuxs0=
X-Google-Smtp-Source: APXvYqy82N1/rS2k+0d9HP0mbqZT6+7XINBuI3UNSfy2RMfcEhMIKVXp/SDEcPsHnzMKYzmg/9wesg==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr104788522wml.90.1564437547221;
        Mon, 29 Jul 2019 14:59:07 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.59.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:59:06 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
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
Subject: [PATCHv5 10/37] posix-clocks: Introduce CLOCK_BOOTTIME time namespace offset
Date:   Mon, 29 Jul 2019 22:57:30 +0100
Message-Id: <20190729215758.28405-49-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
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
index 186c134fe222..334c1a1c6607 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -48,6 +48,14 @@ static inline void timens_add_monotonic(struct timespec64 *ts)
 		*ts = timespec64_add(*ts, ns_offsets->monotonic);
 }
 
+static inline void timens_add_boottime(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+
+	if (ns_offsets)
+		*ts = timespec64_add(*ts, ns_offsets->boottime);
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
index 55cb6e78d082..b1e82bb6cc6b 100644
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
index cfeb0477d1f9..265fbc816520 100644
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

