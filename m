Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AC4C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAB320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fY7Kpd+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389498AbfG2V7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:59:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38906 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbfG2V7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:59:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id s15so33441656wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZLZDNq5pm2mTDaqv2dwp/abuaruOxAFX4DFrbxtsS3U=;
        b=fY7Kpd+yuXwm7P4rTQ7cvrYy2QaBpk8fVQjLQGAJVN63a6jYIT39vRAVo42ZwJBAzc
         n62ZMKGIdmUOn8TiTaOH6nrpDucVU0YcRDV72mybRDgG7NBr+qSy6SlyIgwMmskpV4FU
         SzZOGJUXc8RoTmeCyrvzbWZFH2aq5qq0uB1FIV7juLhHcJdkxLU0kYz4Iy4GBMpAlyUD
         nIwkcWZZ7jRDou2yni8o5J1tZGC0YoYT11WyAlC5SmFIZ/sNRAUFvPQnlihb+KfGDvQ7
         9TyUgYiDS2q7bdJBxivwcTBndEYvbMCsbNLHkVWQP4ZZukErT1caGXVC1FUEEZXOsRj2
         NraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZLZDNq5pm2mTDaqv2dwp/abuaruOxAFX4DFrbxtsS3U=;
        b=tj1wbD6DEykd4jTMM1VTdShJdxTH7CzjikoJ60SClCChWq0vPhnTaoFLPseTgv+F9u
         1xH84QlMGLvZcgPY9Wlw8C2Vi+Dy4rSs/Ev8nDGCouQ80kiWDj2hqs9rzutWCx+moQPI
         STAaSq4jbyLWWyLLsEH8P1Zp+3h9n3sSJBY0dC8KBX/B+a0wtBRVcdTt7Mq9DRGAMTBZ
         0JsU51zbJxnwCW6cgyDRuuEjuQ1UKllaDv+YIDVoliagJOerM4V45D0gaDUwOdQLFIPz
         2TIODw4ItRl/6NPnzin9zMCg0bC2UyNj0q/cmA7/zY4bn0RgxIBaYoyBzalSj7tNBqfA
         LrHQ==
X-Gm-Message-State: APjAAAVym/6FU+H3832ZGra0LKpgJbGrDZZskRu7J3tQzyxkRghfYIn7
        yqVHPVRX3bS9jsV4+Gib3obpTrp72cNbZEfC1aR3K/VETOv0JUtKYhTVVcfYhCzU8qzHW/8H0NJ
        5cYHdNiDt1mJMjmCaj596FPEt1fNvsPdzb0C1g3NFdruzCTh4FhyLG0jS7vrb/Hre1JFEMd3naG
        vYDW1L5lFjwU2VsxcoWWCw0XvmNySd2TuODp3pSSg=
X-Google-Smtp-Source: APXvYqyyd8QMGJlXsKgbAJvJZ00e8fZysTvNQDcGQhhfztiT6N+m8EP6WD1I6LYcRUkkK5Js5HMFfg==
X-Received: by 2002:a1c:4041:: with SMTP id n62mr41296662wma.100.1564437545831;
        Mon, 29 Jul 2019 14:59:05 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.59.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:59:05 -0700 (PDT)
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
Subject: [PATCHv5 09/37] posix-clocks: Introduce CLOCK_MONOTONIC time namespace offsets
Date:   Mon, 29 Jul 2019 22:57:29 +0100
Message-Id: <20190729215758.28405-48-dima@arista.com>
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
index b6985aa87479..186c134fe222 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -40,6 +40,13 @@ static inline void put_time_ns(struct time_namespace *ns)
 	kref_put(&ns->kref, free_time_ns);
 }
 
+static inline void timens_add_monotonic(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+
+	if (ns_offsets)
+		*ts = timespec64_add(*ts, ns_offsets->monotonic);
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
index aae7ab53790d..cfeb0477d1f9 100644
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

