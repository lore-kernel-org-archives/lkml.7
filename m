Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6099DC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D5821655
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JKZPsMHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfDYQOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:14:30 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38630 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfDYQO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:14:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id c1so399435edk.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 09:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6MTKn/xpklQD8jal484Yp/i6TVnvaFq2uXDk3CSvRY4=;
        b=JKZPsMHEX60fxoa0WnGyGenox6egSbjv5GgEjQyWpk/MvvB04dkY48myhCxP2gsON+
         6uN+nkO1w7FYNoyXxzZPsrdpbwcvl8jDz40mDE4CfK/kfb7XxqSFtq9ElqSSKYK49F7u
         m9/R5YKGuLTYWz7ErnhLCDP1xcV/aCINVCGmCE/PT3KQZ+VkmSqwMGZ/grhq7gKVRY2m
         X/5qOkNs4S+gRE+BgMSOQYbD1U8WjByAYAt0JA92HhnnbQ49viiioNvLh0kHz5EkNw8c
         OSU2rwGLvvggNLrHVVId5mdvkm/DFDaWL/hAzAcceIFHy2oBhMTbN1jbRQT/ZNFwMPxu
         9g6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6MTKn/xpklQD8jal484Yp/i6TVnvaFq2uXDk3CSvRY4=;
        b=bnD3W3h1AwNN/3qBhqqHCNiRFeGdSDMqESe6sRVCnkM7qUOJmc4+NDD07UFTV0hl2h
         vbWuIvD6XKmNElrzWHya1PthcP9fl4I6Y3rtiNls2S+BjwaSiiPceKdm+gPC9leziqxB
         VZMPpPPn+wMrztDPlQT3v0yZ2MSOqrGAnM/kDbTBVSqITazOPPR5BINj2IX/mA5mxm0z
         1UtcWJ4BwuSaNtqOowizor289jGA7xiUx8Xm7FwrhMy+V2+DjUQ4wSZV2oU7fmYMKrFN
         9IEF/feWQfp4KTRmRT9qwLjKOUjJrTrZECHvHdrYDROrWf8CRHgXppBJv1sLZIQL9gj4
         n0iA==
X-Gm-Message-State: APjAAAVD/AfhSt97xcwZzI9H2/4WMVYXrnl0T74bwTWGGLG8qHm3mlfA
        7lv/qEn7h9RoslMLVXHKWkqlsRq0Zg4=
X-Google-Smtp-Source: APXvYqwA0TsfqsrH2xJIWMfh5u6j1xFggz7TgdEC3JzqhoyA++E1Pc3xoBYW/kW26FGy5wpSRLAfzA==
X-Received: by 2002:a17:906:364f:: with SMTP id r15mr20245356ejb.215.1556208864811;
        Thu, 25 Apr 2019 09:14:24 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id br19sm4147042ejb.48.2019.04.25.09.14.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Apr 2019 09:14:24 -0700 (PDT)
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
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv3 04/27] timens: Introduce CLOCK_BOOTTIME offset
Date:   Thu, 25 Apr 2019 17:13:53 +0100
Message-Id: <20190425161416.26600-5-dima@arista.com>
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

Adds boottime virtualisation for time namespace.
Introduce timespec for boottime clock into timens offsets and wire
clock_gettime() syscall.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h | 9 +++++++++
 include/linux/timens_offsets.h | 1 +
 kernel/time/alarmtimer.c       | 8 +++++++-
 kernel/time/posix-stubs.c      | 1 +
 kernel/time/posix-timers.c     | 2 ++
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 8f75d34cf34a..5f0da6858b10 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -48,6 +48,14 @@ static inline void timens_add_monotonic(struct timespec64 *ts)
                 *ts = timespec64_add(*ts, ns_offsets->monotonic_time_offset);
 }
 
+static inline void timens_add_boottime(struct timespec64 *ts)
+{
+        struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
+
+        if (ns_offsets)
+                *ts = timespec64_add(*ts, ns_offsets->monotonic_boottime_offset);
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
index 248b0c0bb92a..777530c46852 100644
--- a/include/linux/timens_offsets.h
+++ b/include/linux/timens_offsets.h
@@ -4,6 +4,7 @@
 
 struct timens_offsets {
 	struct timespec64  monotonic_time_offset;
+	struct timespec64  monotonic_boottime_offset;
 };
 
 #endif
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 0519a8805aab..31f99361342e 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -653,12 +653,18 @@ static int alarm_clock_getres(const clockid_t which_clock, struct timespec64 *tp
  */
 static int alarm_clock_get(clockid_t which_clock, struct timespec64 *tp)
 {
-	struct alarm_base *base = &alarm_bases[clock2alarm(which_clock)];
+	struct alarm_base *base;
+
+	base = &alarm_bases[clock2alarm(which_clock & ~CLOCK_TIMENS)];
 
 	if (!alarmtimer_get_rtcdev())
 		return -EINVAL;
 
 	*tp = ktime_to_timespec64(base->gettime());
+
+	if (which_clock == (CLOCK_BOOTTIME_ALARM | CLOCK_TIMENS))
+		timens_add_boottime(tp);
+
 	return 0;
 }
 
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
index a047d6b7c768..a723e63d55fd 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -232,6 +232,8 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 static int posix_get_boottime(const clockid_t which_clock, struct timespec64 *tp)
 {
 	ktime_get_boottime_ts64(tp);
+	if (which_clock & CLOCK_TIMENS)
+		timens_add_boottime(tp);
 	return 0;
 }
 
-- 
2.21.0

