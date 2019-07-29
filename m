Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E82C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE93020C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="M/VNVvPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfG2WB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:01:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40178 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389230AbfG2V6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so63462365wrl.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZLZDNq5pm2mTDaqv2dwp/abuaruOxAFX4DFrbxtsS3U=;
        b=M/VNVvPSR7BlmAhDH2lovmGmgLk97R+1GL43do5srTu1wANXq39v9P6m+cEXz6okk+
         ebIpEjYor2Vgti9kLgnwgLx/ptriGbWEG3u7mmaOUbUAZGu6wAPETV5ckspfAq8Pt9cT
         YrmxQriwMO1Y5HbF6Pfx6DpXuoR43Yz/LAFlpTrTZPp/VwKR97aDlDnvQPsrYTeJMH3g
         EaQJrsi5e+PNo19HgAzQVm/HQQwCJNUIZEjm0TiQttw25eUOj+cIlTgVMHwbVV2iPtpk
         xkWcZW5n1DtKPXOA0J6iuRhwuWL0t4MDyZtjA+qnc7yJHIBVHnCZxSmUGZ3ZWZuFNHhR
         BSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZLZDNq5pm2mTDaqv2dwp/abuaruOxAFX4DFrbxtsS3U=;
        b=mKLB8Dkv4p8h99bjWqz7nvIt9NAnPCYmgox2JIdOMqMVkTSmxMHkyl/uh4TdPbxOCP
         3Vz2jtFb1+B1ipORDBwf4ddPQKDTul7sCJpFGgg2QDV5Rb31LKi8xtDBoZgCV/IRvC1z
         1PgJGFg5Ff4Lf0g02rUB8ozwQacHdzNpfoqQ6tmAvVFU0pyh2xc/We8wX0aNcuZmwdwH
         gvxjpmVyBZvb2QqDKuH++CUU1gcQ1lpTJwVBfjdXUM3BFuoJx88Gcv8mwfQ7mrggKIOh
         fwXd0F0M5ewmx0tQOcYgoUCP/fwkUXDL1w573fRXxU0r6l1ph+QN+nSSD7ruQw3oVA2r
         YTyw==
X-Gm-Message-State: APjAAAVrmE0Uzrc+HMC87KFuJTQq3g8Mzlr8yNYH6j9WBlJ/Ym+xlPoF
        UVrtPr2xKlui6+xNWNmSHqZuEahlpwJ0BEmW35xTLlp/aKgpYt9Wo5RO2JtANH7HXgMSnWXX6Dq
        NDk9XeeOCvxmlnLoL5Rngr7jRYU5PJ4gsAycoa+fGKvwuOEm6dqMvn90FUjP0ThA0OFqapcNNs3
        rzRvcR8DxnrvJAQSYcG+jsLSRjOh1K8G0vdWRnVv4=
X-Google-Smtp-Source: APXvYqzVgjJW1NiW+wRac4WVlY92hv8PwXoC70KjvHAcyCjvnPXF0l/RBZpUyVD7uEE/Pda27Es8aw==
X-Received: by 2002:adf:f206:: with SMTP id p6mr50649643wro.216.1564437492712;
        Mon, 29 Jul 2019 14:58:12 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:12 -0700 (PDT)
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
Date:   Mon, 29 Jul 2019 22:56:51 +0100
Message-Id: <20190729215758.28405-10-dima@arista.com>
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

