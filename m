Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5150FC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198B72073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Xvj7FXGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfG2V6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:58:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54226 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389231AbfG2V6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so55202772wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ka7x1gX+cc0hv8MDuwO2Malh6j1ZrZUM3jDIBgobxjI=;
        b=Xvj7FXGOcZc8glBEOSMlCCRea94AmWoUVCJMP4wuIQXao27FvB4hBx1k92QxTkajh1
         WY9QHbdeRtE5Z6xDWbgfQ9X7s5m4rKiPEIG3HvXUoVr/LuauNb2sAkNkZoNYLVQWV0j8
         PRoFX4kbJW1IMVapY3ml5xDK0ckUVqvxR3mc/ly8Rhj7LVik0gw9BEUFvWNKPpPyPd6b
         rgcPv4NoHwaotea3sOn3POMM8cMkmKuimIZtGpdPxIZqB296MQkqX1o2x+13ce2N/NUr
         NyapX0AJFU6J35F/tgLrdWswAZ8FWI0O3VPDnRtZx8BFbK5ftShXT2EX6u1+Vpj5+7fS
         K9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ka7x1gX+cc0hv8MDuwO2Malh6j1ZrZUM3jDIBgobxjI=;
        b=qX8mi6Bn88f5c9iR1MoUmPhagj4VGvmS1028VCRkBt7W0MFKcel9tgLX4zA/GaoEaj
         +V7fOslSH1Akia2Qze84cZZTQwZ9NcScqCyTxCFS6joZIP2GvK4z79uDwRywOneqqWl0
         JDoTLz350LtRxwjn4OeLz0Lx+64SMOshxvcZ5ycG85bVB9d+GCv1l3hqjAZKLzNiMOKV
         4+Cmvz8mA3tk2+v1R+ImM5qJAYkfiiylaQBlmHcsq2eV7amImTCMTTpnzjt2NJq223Cy
         n3lVHkTEJOJESKegl3wN871aO80jcxrYXWGlkdxbADy28K/34l9eND+amXLfxDOeXYki
         w+3g==
X-Gm-Message-State: APjAAAUpyTeIYyXQB/V1WS/bvuO9od63ls/1hh+44huo/9WQCg3o/j7f
        y7nr4A01PzAELdWVk9GufnTMTozdpAXtrfm3d3Dy+LFENAGGJJnMiqH/I9gn1V+/DNCcO/krelV
        mmWjaU/eKOfB0WD/TsS69xwFVlVh034JtPUGzzkrRm+UzRkJrQiYaSUJqd3+KfHF5Wur/955HbW
        +ozVa2q4kHaVfFFA9JpIyghNBFu/AJqfx3hx6Hzf8=
X-Google-Smtp-Source: APXvYqzls+7xlTd6LVoyGi5O5Qsqv6ds0nGfqdgYsh1OcxGC2C81nOLD4IK/YCIrQEc3dfuOi7V58w==
X-Received: by 2002:a1c:c545:: with SMTP id v66mr103549986wmf.51.1564437494027;
        Mon, 29 Jul 2019 14:58:14 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:13 -0700 (PDT)
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
Date:   Mon, 29 Jul 2019 22:56:52 +0100
Message-Id: <20190729215758.28405-11-dima@arista.com>
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

