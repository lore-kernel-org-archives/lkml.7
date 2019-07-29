Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0A4C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB12B2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="n7mF5N4Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfG2V6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:58:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51173 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389250AbfG2V6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so55210896wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CL7BuFSrbJFNxj7ShYd110TtYKaJGS9/+ZXIwtFyKB0=;
        b=n7mF5N4Y31jDw1naKhkxwokqodl0+81LKojt1OmSg1cQlk+r4WTap4L3dSwiu9kJwq
         VHc51PQ2aGcV0zv0c+0cZLgM09rW1kGxW7fHKRO5lxTS4W6Cof3x8OjNthPxdDMHPfC2
         oc1n7O1w58MOt9Hb3qEVSsmG0Zs+PNX6x5ZT80FFOh91I1kFpZqB4Pu31G+76wLIQbNT
         erlC500m6/V5lcuX+gOuvaqR8If2IodE4mruUOrlBIo7PsV6cag2SxN7/RqPf4vkU547
         Ufq/qcevG5uuGQ9YPENLjLcp57HT+WaervgK7fF5xy18fs6k3BbEjS63dac0NaKgJ0fe
         eeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CL7BuFSrbJFNxj7ShYd110TtYKaJGS9/+ZXIwtFyKB0=;
        b=TAzWW5zapk6yXKN109Jsl3+TWLvy+JKubD5IYphndqZq1hr7ZZGn9nXW/etZG0xdg3
         UaXm3hWlRL9gKGw9oevpyGNGhw60VBu3EDiZG9B0zN0EhkJthQdT85DPRuUy9PS3e3YM
         3vpg1B0YlADR159+KlJLusqSQ5RkzwpAn6f6zMGLuUpz45TeXSablK1/3tSLRDRAPquU
         YsbPac1CTWCSJHUIYqr4TsQ4usmriVJnO1GQMjNluL8gYpoTCuiBQyKbpWGlgNtxl0l1
         L1go+4TqmqWHym40Kxw7JFx2a3oSj3UxrbdQiwcfWtR5mlH+yMURSNKneoHPrK/rQ0/6
         /ytA==
X-Gm-Message-State: APjAAAVWJWbxn5HXpJOXMeBZzSK7VQhgM6Mc47QMpVtpUxBmOBXSesWZ
        q26gFdoiAwRSJzD085bIecZFjxpIl4azgn4itlTvPWmT3VQXm9z8oX85+dIAK/wzOrCDSsD5n2h
        BqUGnSph5KLSoFRsyLo7KCi45sbasTocodDtzCrcrEbIANx5Ensex3BWDVSxmPdVkw2xCr2M0W7
        NekloIsWaNjrPvPTD4bNTxcSojICag8TpHniM7sVY=
X-Google-Smtp-Source: APXvYqx5iz2o6SvSGcoO1F7NoeIhRAN/6eGgdUUVZlDoXesZdLXrHe3iOasMyCZyS4bqyPaoSe02JQ==
X-Received: by 2002:a1c:4041:: with SMTP id n62mr41295154wma.100.1564437495430;
        Mon, 29 Jul 2019 14:58:15 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:14 -0700 (PDT)
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
Subject: [PATCHv5 11/37] kernel: Add do_timens_ktime_to_host() helper
Date:   Mon, 29 Jul 2019 22:56:53 +0100
Message-Id: <20190729215758.28405-12-dima@arista.com>
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

The helper subtracts namespace's clock offset from the given time
and checks that the result is in [0, KTIME_MAX].

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/time_namespace.h | 17 ++++++++++++++
 kernel/time_namespace.c        | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 334c1a1c6607..9ba9664ff0ab 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -56,6 +56,18 @@ static inline void timens_add_boottime(struct timespec64 *ts)
 		*ts = timespec64_add(*ts, ns_offsets->boottime);
 }
 
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *offsets);
+static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
+{
+	struct timens_offsets *offsets = current->nsproxy->time_ns->offsets;
+
+	if (!offsets)
+		return tim;
+
+	return do_timens_ktime_to_host(clockid, tim, offsets);
+}
+
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -82,6 +94,11 @@ static inline int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *ts
 
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
index f849c59f1108..9807c5c90cb2 100644
--- a/kernel/time_namespace.c
+++ b/kernel/time_namespace.c
@@ -16,6 +16,49 @@
 #include <linux/err.h>
 #include <linux/mm.h>
 
+ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
+				struct timens_offsets *ns_offsets)
+{
+	ktime_t offset;
+
+	switch (clockid) {
+	case CLOCK_MONOTONIC:
+		offset = timespec64_to_ktime(ns_offsets->monotonic);
+		break;
+	case CLOCK_BOOTTIME:
+	case CLOCK_BOOTTIME_ALARM:
+		offset = timespec64_to_ktime(ns_offsets->boottime);
+		break;
+	default:
+		return tim;
+	}
+
+	/*
+	 * Check that @tim value is in [offset, KTIME_MAX + offset]
+	 * and subtract offset.
+	 */
+	if (tim < offset) {
+		/*
+		 * User can specify @tim *absolute* value - if it's lesser than
+		 * the time namespace's offset - it's already expired.
+		 */
+		tim = 0;
+	} else if (KTIME_MAX - tim < -offset) {
+		/*
+		 * User-supplied @tim may be close or even equal KTIME_MAX
+		 * and time namespace offset can be negative.
+		 * Let's check (tim - offset) for an overflow.
+		 * Return KTIME_MAX in such case, as the time value is
+		 * thousands *years* in future anyway.
+		 */
+		tim = KTIME_MAX;
+	} else {
+		tim = ktime_sub(tim, offset);
+	}
+
+	return tim;
+}
+
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_TIME_NAMESPACES);
-- 
2.22.0

