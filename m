Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364FDC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1D5215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Cw0ffJv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfFLT2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:28:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40555 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfFLT0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:26:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so7670562wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 12:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2JPk6BIRBZXJQGOFkLGaB5p7L5O4E3bM0QjQWgAe7EI=;
        b=Cw0ffJv3sB1P4EbqlP5IJLd7vzE4KLoJES0WYNLZh6OOHkO2jNisDYRXGMYDtefTi/
         fizkUxL75OhI6pEbloGwSK9WveEHCyljtDEdGWRDlT3OGwTJE8nx1x5OPhi1EL1XvPmT
         YotuWY3mWKy2PcgGFhyP8Qs+umQvsGsazPh0iwzXJCTY/mrPrX2GPUccmajEDiw64WDE
         WLri4d6mPGGDKf085qVAdPCOdf4QDyCChIDl0l5uI8kS4CpmCRSlN6STy9LJiVWV5bpR
         ubmHOfc0hK8Q1w9HfgY+zw2L9u42Smn7wqxXGzszn4NeuPIe3CM1LqjHXx+RcqDaTxGj
         FSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2JPk6BIRBZXJQGOFkLGaB5p7L5O4E3bM0QjQWgAe7EI=;
        b=W6WoAoWjjyzLRnxqF188PI/7c8JunBQ2UpOdGs3dYjS9FcA1xQblisk4Dp2STbsGKK
         IJwUdEzeG9gNxVr/5tGUxT3PAioKO8WH3vQrzleLX03wueJnlSvJG4ztvfOiD0v2JR/r
         A7CAc06W4E+O0EmG17xF0445cJbHGDeFac8reXaG2Y4qx99/gwyVlnqNRkA1VI1WjQvG
         Hs5x5lUZSXpjg7XZ+GWEqJCOp9qF6LPj1FKeXFmi8cg+oaotDcCPNNDf0CwxgdslFiZo
         E+U1TKT816DSs8kO1udRkncCjyAAHn8Q7srM6H6kcLnHk9dfx7wN3syb8vOYNwknXW4t
         gwqw==
X-Gm-Message-State: APjAAAUHOaiG1gr7L0n91+vKnjSVauy8knA/mlWlU/PknaQ1IiXxLNvz
        2C2KhgVrqNJCnW4PjPBC4IBgblDJYQM=
X-Google-Smtp-Source: APXvYqxk1EDWl6fJpR5+71bdyZLsjVFY4BVnwL1pj8jpx3LStNmx2Y145SCe3BmstwwaE/quayRkWw==
X-Received: by 2002:a05:600c:389:: with SMTP id w9mr487071wmd.139.1560367598747;
        Wed, 12 Jun 2019 12:26:38 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:38 -0700 (PDT)
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
Subject: [PATCHv4 06/28] timerfd/timens: Take into account ns clock offsets
Date:   Wed, 12 Jun 2019 20:26:05 +0100
Message-Id: <20190612192628.23797-7-dima@arista.com>
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

Make timerfd respect timens offsets.
Provide a helper timens_ktime_to_host() that is useful to wire up
timens to different kernel subsystems.

Signed-off-by: Andrei Vagin <avagin@openvz.org>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 fs/timerfd.c                   |  3 +++
 include/linux/time_namespace.h | 18 ++++++++++++++++++
 kernel/time_namespace.c        | 27 +++++++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/fs/timerfd.c b/fs/timerfd.c
index 6a6fc8aa1de7..9b0c2f65e7e8 100644
--- a/fs/timerfd.c
+++ b/fs/timerfd.c
@@ -26,6 +26,7 @@
 #include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <linux/rcupdate.h>
+#include <linux/time_namespace.h>
 
 struct timerfd_ctx {
 	union {
@@ -196,6 +197,8 @@ static int timerfd_setup(struct timerfd_ctx *ctx, int flags,
 	}
 
 	if (texp != 0) {
+		if (flags & TFD_TIMER_ABSTIME)
+			texp = timens_ktime_to_host(clockid, texp);
 		if (isalarm(ctx)) {
 			if (flags & TFD_TIMER_ABSTIME)
 				alarm_start(&ctx->t.alarm, texp);
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 1dda8af6b9fe..d32b55fad953 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -56,6 +56,19 @@ static inline void timens_add_boottime(struct timespec64 *ts)
                 *ts = timespec64_add(*ts, ns_offsets->boottime);
 }
 
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *offsets);
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	struct timens_offsets *offsets = current->nsproxy->time_ns->offsets;
+
+	if (!offsets) /* fast-path for the root time namespace */
+	       return tim;
+
+	return do_timens_ktime_to_host(clockid, tim, offsets);
+}
+
+
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -82,6 +95,11 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 
 static inline void timens_add_monotonic(struct timespec64 *ts) {}
 static inline void timens_add_boottime(struct timespec64 *ts) {}
+
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	return tim;
+}
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/kernel/time_namespace.c b/kernel/time_namespace.c
index 4828447721ec..b3cffdf2635c 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -15,6 +15,33 @@
 #include <linux/sched/task.h>
 #include <linux/mm.h>
 
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim, struct timens_offsets *ns_offsets)
+{
+	ktime_t koff;
+
+	switch (clockid) {
+	case CLOCK_MONOTONIC:
+		koff = timespec64_to_ktime(ns_offsets->monotonic);
+		break;
+	case CLOCK_BOOTTIME:
+	case CLOCK_BOOTTIME_ALARM:
+		koff = timespec64_to_ktime(ns_offsets->boottime);
+		break;
+	default:
+		return tim;
+	}
+
+	/* tim - off has to be in [0, KTIME_MAX) */
+	if (tim < koff)
+		tim = 0;
+	else if (KTIME_MAX - tim < -koff)
+		tim = KTIME_MAX;
+	else
+		tim = ktime_sub(tim, koff);
+
+	return tim;
+}
+
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_TIME_NAMESPACES);
-- 
2.22.0

