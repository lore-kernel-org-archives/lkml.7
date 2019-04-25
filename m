Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191C5C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE5920651
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PbBxPk8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfDYQQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:16:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34723 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfDYQOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id a6so426566edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fxvw7TygPwiSoysVCZEVs8yLHQrUAIGkANiXe8cHtMM=;
        b=PbBxPk8RtR0+q0STPqx1yEP/z6JEEa2/778kw7RS67bGKtUEvl266hyDyJFS+7F+wC
         EZ9yrpegW8rOf67mHa3gqNNFIWlEqJTi/jttXFkhHZOvL32pY0R+RlSedFh8n5ntQ69U
         wpKfECDnKyslYl0wcUBi+jepJIlTFf1Odj35O2xJ9dSLx7HM3TaL0qh+ywLyFk3kc2OS
         zMtRB/T+wdAUflyzfrEI5NYLSgf7Cfi902i3fr4d+KNF0zxGkHtzdF7LE4tTpy2xtIYh
         WMYk1TrH6jRiKmzUoBcrqsNWVj8I4v/YCHZC8kfGDcW+IvVgPSeaBNG0eclvIL0suMT8
         LgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fxvw7TygPwiSoysVCZEVs8yLHQrUAIGkANiXe8cHtMM=;
        b=bZsaTebV+mIL3nVF4eh6RcUFS/JLhv7ox6fAUA+FeoO6inZMp/0KTHxt9tmjeXvfH8
         3JSLbvZ/zvhEK3M8ZJlmRULcgMhNzyt7GWE6TFPKqEBoffWC5RydBNqjuHAIHlvrOYxZ
         R30xlGGufEiZNt1r47irWn8m1eCEumRfPRtDCuT3JR67cfo0LnBXtSgEfZP0ZtiB/GmL
         3UiCCumbHxU/XcKKyDHfbOs97Aj9hVPecH2ge+u1F8+nfxUYmhrNrNz7lfSCLxHHfwDl
         OE22nkQCenAjeI7jCLWPdmU1MfdkMSPr0b0d4oFAVoIEGYU0aGIMtbh2GBeNn8l8jQm+
         JLLA==
X-Gm-Message-State: APjAAAWQAT8grItiezs+EiFCYrZGGq8blbee99dx5ngPRkocDuwzWgZ1
        QP29etCBLm+cMHJsSAuTpAXaV1W1dek=
X-Google-Smtp-Source: APXvYqzXVtc0NxubYsI8RvsGuxt+fxF4EOIfwRKYMbmjNwKE4RLaPVOy43jwOEDzgCEeTvVjcvkhfA==
X-Received: by 2002:a17:906:4d4d:: with SMTP id b13mr19309587ejv.256.1556208863246;
        Thu, 25 Apr 2019 09:14:23 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:22 -0700 (PDT)
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
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv3 03/27] timens: Introduce CLOCK_MONOTONIC offsets
Date:   Thu, 25 Apr 2019 17:13:52 +0100
Message-Id: <20190425161416.26600-4-dima@arista.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190425161416.26600-1-dima@arista.com>
References: <20190425161416.26600-1-dima@arista.com>
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
 include/linux/time_namespace.h |  8 ++++++++
 include/linux/timens_offsets.h |  1 +
 include/uapi/linux/time.h      |  2 ++
 kernel/time/posix-stubs.c      |  2 ++
 kernel/time/posix-timers.c     | 11 +++++++++--
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index b6985aa87479..8f75d34cf34a 100644
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
+                *ts = timespec64_add(*ts, ns_offsets->monotonic_time_offset);
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
index 7d7cb68ea778..248b0c0bb92a 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -3,6 +3,7 @@
 #define _LINUX_TIME_OFFSETS_H
 
 struct timens_offsets {
+	struct timespec64  monotonic_time_offset;
 };
 
 #endif
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 958932effc5e..32abadc68f72 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -65,6 +65,8 @@ struct itimerval {
 #define CLOCKS_MASK			(CLOCK_REALTIME | CLOCK_MONOTONIC)
 #define CLOCKS_MONO			CLOCK_MONOTONIC
 
+#define CLOCK_TIMENS			1024
+
 /*
  * The various flags for setting POSIX.1b interval timers:
  */
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
index 29176635991f..a047d6b7c768 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -30,6 +30,7 @@
 #include <linux/hashtable.h>
 #include <linux/compat.h>
 #include <linux/nospec.h>
+#include <linux/time_namespace.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -190,6 +191,8 @@ static int posix_clock_realtime_adj(const clockid_t which_clock,
 static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_ts64(tp);
+	if (which_clock & CLOCK_TIMENS)
+		timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -199,6 +202,8 @@ static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_raw_ts64(tp);
+	if (which_clock & CLOCK_TIMENS)
+		timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -213,6 +218,8 @@ static int posix_get_monotonic_coarse(clockid_t which_clock,
 						struct timespec64 *tp)
 {
 	ktime_get_coarse_ts64(tp);
+	if (which_clock & CLOCK_TIMENS)
+		timens_add_monotonic(tp);
 	return 0;
 }
 
@@ -1039,7 +1046,7 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 	if (!kc)
 		return -EINVAL;
 
-	error = kc->clock_get(which_clock, &kernel_tp);
+	error = kc->clock_get(which_clock | CLOCK_TIMENS, &kernel_tp);
 
 	if (!error && put_timespec64(&kernel_tp, tp))
 		error = -EFAULT;
@@ -1121,7 +1128,7 @@ SYSCALL_DEFINE2(clock_gettime32, clockid_t, which_clock,
 	if (!kc)
 		return -EINVAL;
 
-	err = kc->clock_get(which_clock, &ts);
+	err = kc->clock_get(which_clock | CLOCK_TIMENS, &ts);
 
 	if (!err && put_old_timespec32(&ts, tp))
 		err = -EFAULT;
-- 
2.21.0

