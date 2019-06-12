Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAB5C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2322184E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="KIeRc8Fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfFLT0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:26:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37126 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbfFLT0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:26:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so18131248wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3O5/C/fbSc9x+5pAskiiyuSQ0dAxI0FzcbQ1ANBs5Ck=;
        b=KIeRc8Fb9bbQIwNUBDyZDnBJH9NJgjyukqcJEnDStUGYrsLa+7N2KT1NkzHVSLmgOM
         mj477x8Do81r1rneO0H6MiZYVR3KPKUjf7ODnIepC4WQaQJAFqWDlbaJt+uGru8tdOD7
         wBVPeoHTHTSMpNG9kNitVHskSZgIwHoyRYEK6WOzeu7enEyk8PZg4rf1o/MmU9AUtWxR
         20ZKz/OPlabzUNM4r8x3A5jjHK9oVxQDQqY9Dk3/4sOFiQEsXSJg23iUocZGydmv3Z1L
         7WIfqE5DBEKFv2D+C/LLd+GtEI5M0vWdcKKh+MBDUB8pgbSH3+Ukjd9ez6rXPL9GtMs/
         jAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3O5/C/fbSc9x+5pAskiiyuSQ0dAxI0FzcbQ1ANBs5Ck=;
        b=Ro5ZKCxthmJe3z0KVstqWfhmZ/IsWMTgdhR9xVfsn28DFZu1/SqZhSqJrbWCZxgpn5
         zmLddS9yVFlh2nodi/ePh65fLT1DsBHrwpSJ4cuTONqDgrXirzLMIFTMR6BfK8W/y41Y
         AZBwf4VjucPycgSFC8lu8GXqzxB/aJrpL6LXaM/HcOlr7fCWvOOXMLy7+gFIpXAiibPr
         lFfBgWHrhV719mrtgVg8bA1pccxuRC5dUgXpLwokjwKf6yrv4irNQaq9IOLJ8i0xkiRj
         92eqZtsXOYFShn2TxCSchRYIhmfSCIrG9Mtl88SHNqjn3wr0pr2HD0hM2shQBuWaHqcI
         yIbg==
X-Gm-Message-State: APjAAAX3t61e+7enBg5ng0M280ngsJ578bpalcDPsdsElS4+CGw0x2DG
        mHjalavwxp7ajZo27ovCYLP8HqXqIl0=
X-Google-Smtp-Source: APXvYqzJtG1fIcf+rUY91ElqBYkviYyHT1tPL71ZjgdgebQZiqch6xY4fqRiBcHSL8k/R/KX8KjcFw==
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr16811668wrv.132.1560367595795;
        Wed, 12 Jun 2019 12:26:35 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:35 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
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
Subject: [PATCHv4 04/28] timens: Introduce CLOCK_MONOTONIC offsets
Date:   Wed, 12 Jun 2019 20:26:03 +0100
Message-Id: <20190612192628.23797-5-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@openvz.org>

Add monotonic time virtualisation for time namespace.
Introduce timespec for monotionic clock into timens offsets and wire
clock_gettime() syscall.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h | 8 ++++++++
 include/linux/timens_offsets.h | 1 +
 kernel/time/posix-stubs.c      | 2 ++
 kernel/time/posix-timers.c     | 4 ++++
 4 files changed, 15 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index b6985aa87479..81d0c989df3c 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -40,6 +40,13 @@ static inline void put_time_ns(struct time_namespace *ns)
 	kref_put(&ns->kref, free_time_ns);
 }
 
+static inline void timens_add_monotonic(struct timespec64 *ts)
+{
+        struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+
+        if (ns_offsets)
+                *ts = timespec64_add(*ts, ns_offsets->monotonic);
+}
 
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
@@ -65,6 +72,7 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 	return 0;
 }
 
+static inline void timens_add_monotonic(struct timespec64 *ts) {}
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/include/linux/timens_offsets.h b/include/linux/timens_offsets.h
index 7d7cb68ea778..eaac2c82be5c 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -3,6 +3,7 @@
 #define _LINUX_TIME_OFFSETS_H
 
 struct timens_offsets {
+	struct timespec64 monotonic;
 };
 
 #endif
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 67df65f887ac..17c67e0aecd8 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -14,6 +14,7 @@
 #include <linux/ktime.h>
 #include <linux/timekeeping.h>
 #include <linux/posix-timers.h>
+#include <linux/time_namespace.h>
 #include <linux/compat.h>
 
 #ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
@@ -77,6 +78,7 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 		break;
 	case CLOCK_MONOTONIC:
 		ktime_get_ts64(tp);
+		timens_add_monotonic(tp);
 		break;
 	case CLOCK_BOOTTIME:
 		ktime_get_boottime_ts64(tp);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b6fcf6935204..52098f6ad596 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -30,6 +30,7 @@
 #include <linux/hashtable.h>
 #include <linux/compat.h>
 #include <linux/nospec.h>
+#include <linux/time_namespace.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -196,6 +197,7 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 int posix_get_timespec(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -210,6 +212,7 @@ static ktime_t posix_get_ktime(clockid_t which_clock)
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_raw_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -224,6 +227,7 @@ static int posix_get_monotonic_coarse(clockid_t which_clock,
 						struct timespec64 *tp)
 {
 	ktime_get_coarse_ts64(tp);
+	timens_add_monotonic(tp);
 	return 0;
 }
 
-- 
2.22.0

