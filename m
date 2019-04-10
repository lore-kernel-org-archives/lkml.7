Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CCCC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6632077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfDJJO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:14:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41700 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbfDJJO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:14:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so1979720wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 02:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NezGnSbssck4iyTMRku9DxU13Rz1O8OQniwQrFvvePs=;
        b=cqeEN1+rfYuESSFyYP73PoWzLZD3NLsn4NyoE54wjICjEHdy10VSk+giU+KTTIZPeQ
         vUuedNn7fLGIkrctCC9v3doqGK5KmbzDVecaLutrmGQ7PcCvJC7PAYUv5JKRvuYVeEor
         jkQnfgA5h11tVvlqNvXG6xwUH7zvfcUGfjRP1XFLZiPWtsDqE8FUK5/zaoU6PjfEnJp9
         SJzwt7MesXoW+MeXPVeWyb952ZwydR/4h4R/aoT9roqQQuBmCVyteGRgPDjgplpLNtBa
         Y+bGZn3M55+7eU8RkttHA6XkiA93xNZIMfeTpFUdZ8bL5Ue2lw3Ouc+nRdxUIrSyQr4i
         XApA==
X-Gm-Message-State: APjAAAULP4qhCZ040tkyApo4xQu9XpG0w++sdBDIK3t7olpJaSsP7iVb
        k2nAuBFezpsnYlt8uOZtiIUiKg==
X-Google-Smtp-Source: APXvYqw71eP9oJFeKGflOSNhkSXWj8hjNYsMNEO4vkQD5Na5rJn4VvPsDOg5yLmhzfHfAI+UiQsfUQ==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr19519747wru.299.1554887664414;
        Wed, 10 Apr 2019 02:14:24 -0700 (PDT)
Received: from localhost.localdomain.com ([2a02:8308:b13e:ee00:435d:e8f:90ca:755e])
        by smtp.gmail.com with ESMTPSA id t24sm2305381wmi.10.2019.04.10.02.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 02:14:23 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-audit@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH ghak10 v8 1/2] timekeeping: Audit clock adjustments
Date:   Wed, 10 Apr 2019 11:14:19 +0200
Message-Id: <20190410091420.23987-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410091420.23987-1-omosnace@redhat.com>
References: <20190410091420.23987-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emit an audit record whenever the system clock is changed (i.e. shifted
by a non-zero offset) by a syscall from userspace. The syscalls than can
(at the time of writing) trigger such record are:
  - settimeofday(2), stime(2), clock_settime(2) -- via
    do_settimeofday64()
  - adjtimex(2), clock_adjtime(2) -- via do_adjtimex()

The new records have type AUDIT_TIME_INJOFFSET and contain the following
fields:
  - sec -- the 'seconds' part of the offset
  - nsec -- the 'nanoseconds' part of the offset

Example record (time was shifted backwards by ~15.875 seconds):

type=TIME_INJOFFSET msg=audit(1530616049.652:13): sec=-16 nsec=124887145

The records of this type will be associated with the corresponding
syscall records.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/audit.h      | 14 ++++++++++++++
 include/uapi/linux/audit.h |  1 +
 kernel/auditsc.c           |  6 ++++++
 kernel/time/timekeeping.c  |  6 ++++++
 4 files changed, 27 insertions(+)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 1e69d9fe16da..2c62c0468888 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -365,6 +365,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
 extern void __audit_mmap_fd(int fd, int flags);
 extern void __audit_log_kern_module(char *name);
 extern void __audit_fanotify(unsigned int response);
+extern void __audit_tk_injoffset(struct timespec64 offset);
 
 static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
@@ -467,6 +468,16 @@ static inline void audit_fanotify(unsigned int response)
 		__audit_fanotify(response);
 }
 
+static inline void audit_tk_injoffset(struct timespec64 offset)
+{
+	/* ignore no-op events */
+	if (offset.tv_sec == 0 && offset.tv_nsec == 0)
+		return;
+
+	if (!audit_dummy_context())
+		__audit_tk_injoffset(offset);
+}
+
 extern int audit_n_rules;
 extern int audit_signals;
 #else /* CONFIG_AUDITSYSCALL */
@@ -580,6 +591,9 @@ static inline void audit_log_kern_module(char *name)
 static inline void audit_fanotify(unsigned int response)
 { }
 
+static inline void audit_tk_injoffset(struct timespec64 offset)
+{ }
+
 static inline void audit_ptrace(struct task_struct *t)
 { }
 #define audit_n_rules 0
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 3901c51c0b93..ab58d67baf4d 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -114,6 +114,7 @@
 #define AUDIT_REPLACE		1329	/* Replace auditd if this packet unanswerd */
 #define AUDIT_KERN_MODULE	1330	/* Kernel Module events */
 #define AUDIT_FANOTIFY		1331	/* Fanotify access decision */
+#define AUDIT_TIME_INJOFFSET	1332	/* Timekeeping offset injected */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 51a2ceb3a1ca..80dfe0cdc636 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2512,6 +2512,12 @@ void __audit_fanotify(unsigned int response)
 		AUDIT_FANOTIFY,	"resp=%u", response);
 }
 
+void __audit_tk_injoffset(struct timespec64 offset)
+{
+	audit_log(audit_context(), GFP_KERNEL, AUDIT_TIME_INJOFFSET,
+		  "sec=%lli nsec=%li", (long long)offset.tv_sec, offset.tv_nsec);
+}
+
 static void audit_log_task(struct audit_buffer *ab)
 {
 	kuid_t auid, uid;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f986e1918d12..3d24be4cd607 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -21,6 +21,7 @@
 #include <linux/stop_machine.h>
 #include <linux/pvclock_gtod.h>
 #include <linux/compiler.h>
+#include <linux/audit.h>
 
 #include "tick-internal.h"
 #include "ntp_internal.h"
@@ -1250,6 +1251,9 @@ out:
 	/* signal hrtimers about time change */
 	clock_was_set();
 
+	if (!ret)
+		audit_tk_injoffset(ts_delta);
+
 	return ret;
 }
 EXPORT_SYMBOL(do_settimeofday64);
@@ -2322,6 +2326,8 @@ int do_adjtimex(struct __kernel_timex *txc)
 		ret = timekeeping_inject_offset(&delta);
 		if (ret)
 			return ret;
+
+		audit_tk_injoffset(delta);
 	}
 
 	ktime_get_real_ts64(&ts);
-- 
2.20.1

