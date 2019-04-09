Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D526C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412732084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfDIMbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:31:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38704 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIMbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:31:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so1210078wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 05:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZoWOwZLr9bIM7zUgp6sIHmtP4OXAOVUa67k/C1Vo1s=;
        b=RA7+p58oPmuXc0eqrqX/SwphRUDx2UlMlImHL64inRkAxOnRRUuor7FNsbWH6vtwSs
         hNb8hFfOKvp2PwUIhDrRb+JeIm6ao+89ac0kqPxS59ukTqBgCqB3uZ472B3jrk7v4OsK
         o+TZgfcn/SwtSZyeeeJQdsdRxjSd3pKlAEb+IjJn5Hr3eDnOK+adsm3GxyBPPGDLW/kr
         qfzq3gpNcuZq/jcMPRi+mJEjawf2kNx1q1W8ZypKEOpZe4+lAGRUx+Rzr+rTVwIRERkX
         gS+CH3ODamaLM0rxQL2ERGVYfygTvGR0OqJmwhRO/zGE/g5/cttBjWSxmtdsuJUkRCcR
         VmCg==
X-Gm-Message-State: APjAAAVa0TFZGqUEHxXdnEGRPr97EAGt/gQqRn/Ok0JT/No2gz2Pit5A
        NcHvaTQIhxf2Njns0uX+BELC/w==
X-Google-Smtp-Source: APXvYqzENTUmeeYryWPydQei0TzoW86K+2aKtGAQQuWmyXP+peG06FRa3o9H/JC/6k0LhXOSLA6SEg==
X-Received: by 2002:a1c:cf0b:: with SMTP id f11mr15229844wmg.26.1554813099553;
        Tue, 09 Apr 2019 05:31:39 -0700 (PDT)
Received: from localhost.localdomain.com ([2a02:8308:b13e:ee00:435d:e8f:90ca:755e])
        by smtp.gmail.com with ESMTPSA id z1sm27139721wrs.52.2019.04.09.05.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 05:31:38 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     linux-audit@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH ghak10 v7 2/2] ntp: Audit NTP parameters adjustment
Date:   Tue,  9 Apr 2019 14:31:34 +0200
Message-Id: <20190409123134.19350-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409123134.19350-1-omosnace@redhat.com>
References: <20190409123134.19350-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emit an audit record every time selected NTP parameters are modified
from userspace (via adjtimex(2) or clock_adjtime(2)). These parameters
may be used to indirectly change system clock, and thus their
modifications should be audited.

Such events will now generate records of type AUDIT_TIME_ADJNTPVAL
containing the following fields:
  - op -- which value was adjusted:
    - offset -- corresponding to the time_offset variable
    - freq   -- corresponding to the time_freq variable
    - status -- corresponding to the time_status variable
    - adjust -- corresponding to the time_adjust variable
    - tick   -- corresponding to the tick_usec variable
    - tai    -- corresponding to the timekeeping's TAI offset
  - old -- the old value
  - new -- the new value

Example records:

type=TIME_ADJNTPVAL msg=audit(1530616044.507:7): op=status old=64 new=8256
type=TIME_ADJNTPVAL msg=audit(1530616044.511:11): op=freq old=0 new=49180377088000

The records of this type will be associated with the corresponding
syscall records.

An overview of parameter changes that can be done via do_adjtimex()
(based on information from Miroslav Lichvar) and whether they are
audited:
  __timekeeping_set_tai_offset() -- sets the offset from the
                                    International Atomic Time
                                    (AUDITED)
  NTP variables:
    time_offset -- can adjust the clock by up to 0.5 seconds per call
                   and also speed it up or slow down by up to about
                   0.05% (43 seconds per day) (AUDITED)
    time_freq -- can speed up or slow down by up to about 0.05%
    time_status -- can insert/delete leap seconds and it also enables/
                   disables synchronization of the hardware real-time
                   clock (AUDITED)
    time_maxerror, time_esterror -- change error estimates used to
                                    inform userspace applications
                                    (NOT AUDITED)
    time_constant -- controls the speed of the clock adjustments that
                     are made when time_offset is set (NOT AUDITED)
    time_adjust -- can temporarily speed up or slow down the clock by up
                   to 0.05% (AUDITED)
    tick_usec -- a more extreme version of time_freq; can speed up or
                 slow down the clock by up to 10% (AUDITED)

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/audit.h      | 54 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/audit.h |  1 +
 kernel/auditsc.c           | 23 ++++++++++++++++
 kernel/time/ntp.c          | 22 +++++++++++++---
 kernel/time/ntp_internal.h |  4 ++-
 kernel/time/timekeeping.c  |  7 ++++-
 6 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 2c62c0468888..1c372ad7ebe9 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -86,6 +86,26 @@ struct audit_field {
 	u32				op;
 };
 
+#define AUDIT_NTP_OFFSET	0
+#define AUDIT_NTP_FREQ		1
+#define AUDIT_NTP_STATUS	2
+#define AUDIT_NTP_TAI		3
+#define AUDIT_NTP_TICK		4
+#define AUDIT_NTP_ADJUST	5
+#define AUDIT_NTP_NVALS		6 /* count */
+
+#ifdef CONFIG_AUDITSYSCALL
+struct audit_ntp_val {
+	s64 oldval, newval;
+};
+
+struct audit_ntp_data {
+	struct audit_ntp_val vals[AUDIT_NTP_NVALS];
+};
+#else
+struct audit_ntp_data {};
+#endif
+
 extern int is_audit_feature_set(int which);
 
 extern int __init audit_register_class(int class, unsigned *list);
@@ -366,6 +386,7 @@ extern void __audit_mmap_fd(int fd, int flags);
 extern void __audit_log_kern_module(char *name);
 extern void __audit_fanotify(unsigned int response);
 extern void __audit_tk_injoffset(struct timespec64 offset);
+extern void __audit_ntp_log(const struct audit_ntp_data *ad);
 
 static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
@@ -478,6 +499,27 @@ static inline void audit_tk_injoffset(struct timespec64 offset)
 		__audit_tk_injoffset(offset);
 }
 
+static inline void audit_ntp_init(struct audit_ntp_data *ad)
+{
+	memset(ad, 0, sizeof(*ad));
+}
+
+static inline void audit_ntp_set_old(struct audit_ntp_data *ad, int id, s64 val)
+{
+	ad->vals[id].oldval = val;
+}
+
+static inline void audit_ntp_set_new(struct audit_ntp_data *ad, int id, s64 val)
+{
+	ad->vals[id].newval = val;
+}
+
+static inline void audit_ntp_log(const struct audit_ntp_data *ad)
+{
+	if (!audit_dummy_context())
+		__audit_ntp_log(ad);
+}
+
 extern int audit_n_rules;
 extern int audit_signals;
 #else /* CONFIG_AUDITSYSCALL */
@@ -594,6 +636,18 @@ static inline void audit_fanotify(unsigned int response)
 static inline void audit_tk_injoffset(struct timespec64 offset)
 { }
 
+static inline void audit_ntp_init(struct audit_ntp_data *ad)
+{ }
+
+static inline void audit_ntp_set_old(struct audit_ntp_data *ad, int id, s64 val)
+{ }
+
+static inline void audit_ntp_set_new(struct audit_ntp_data *ad, int id, s64 val)
+{ }
+
+static inline void audit_ntp_log(const struct audit_ntp_data *ad)
+{ }
+
 static inline void audit_ptrace(struct task_struct *t)
 { }
 #define audit_n_rules 0
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index ab58d67baf4d..a1280af20336 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -115,6 +115,7 @@
 #define AUDIT_KERN_MODULE	1330	/* Kernel Module events */
 #define AUDIT_FANOTIFY		1331	/* Fanotify access decision */
 #define AUDIT_TIME_INJOFFSET	1332	/* Timekeeping offset injected */
+#define AUDIT_TIME_ADJNTPVAL	1333	/* NTP value adjustment */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 80dfe0cdc636..519ada7522ad 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2518,6 +2518,29 @@ void __audit_tk_injoffset(struct timespec64 offset)
 		  "sec=%lli nsec=%li", (long long)offset.tv_sec, offset.tv_nsec);
 }
 
+static void audit_log_ntp_val(const struct audit_ntp_data *ad,
+			      const char *type, int id)
+{
+	const struct audit_ntp_val *val = &ad->vals[id];
+
+	if (val->newval == val->oldval)
+		return;
+
+	audit_log(audit_context(), GFP_KERNEL, AUDIT_TIME_ADJNTPVAL,
+		  "op=%s old=%lli new=%lli", type,
+		  (long long)val->oldval, (long long)val->newval);
+}
+
+void __audit_ntp_log(const struct audit_ntp_data *ad)
+{
+	audit_log_ntp_val(ad, "offset",	AUDIT_NTP_OFFSET);
+	audit_log_ntp_val(ad, "freq",	AUDIT_NTP_FREQ);
+	audit_log_ntp_val(ad, "status",	AUDIT_NTP_STATUS);
+	audit_log_ntp_val(ad, "tai",	AUDIT_NTP_TAI);
+	audit_log_ntp_val(ad, "tick",	AUDIT_NTP_TICK);
+	audit_log_ntp_val(ad, "adjust",	AUDIT_NTP_ADJUST);
+}
+
 static void audit_log_task(struct audit_buffer *ab)
 {
 	kuid_t auid, uid;
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 92a90014a925..ac5555e25733 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/rtc.h>
+#include <linux/audit.h>
 
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -709,7 +710,7 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
  * kernel time-keeping variables. used by xntpd.
  */
 int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
-		  s32 *time_tai)
+		  s32 *time_tai, struct audit_ntp_data *ad)
 {
 	int result;
 
@@ -720,14 +721,29 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 			/* adjtime() is independent from ntp_adjtime() */
 			time_adjust = txc->offset;
 			ntp_update_frequency();
+
+			audit_ntp_set_old(ad, AUDIT_NTP_ADJUST,	save_adjust);
+			audit_ntp_set_new(ad, AUDIT_NTP_ADJUST,	time_adjust);
 		}
 		txc->offset = save_adjust;
 	} else {
-
 		/* If there are input parameters, then process them: */
-		if (txc->modes)
+		if (txc->modes) {
+			audit_ntp_set_old(ad, AUDIT_NTP_OFFSET,	time_offset);
+			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	time_freq);
+			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	time_status);
+			audit_ntp_set_old(ad, AUDIT_NTP_TAI,	*time_tai);
+			audit_ntp_set_old(ad, AUDIT_NTP_TICK,	tick_usec);
+
 			process_adjtimex_modes(txc, time_tai);
 
+			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	time_offset);
+			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	time_freq);
+			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	time_status);
+			audit_ntp_set_new(ad, AUDIT_NTP_TAI,	*time_tai);
+			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	tick_usec);
+		}
+
 		txc->offset = shift_right(time_offset * NTP_INTERVAL_FREQ,
 				  NTP_SCALE_SHIFT);
 		if (!(time_status & STA_NANO))
diff --git a/kernel/time/ntp_internal.h b/kernel/time/ntp_internal.h
index 40e6122e634e..908ecaa65fc3 100644
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -8,6 +8,8 @@ extern void ntp_clear(void);
 extern u64 ntp_tick_length(void);
 extern ktime_t ntp_get_next_leap(void);
 extern int second_overflow(time64_t secs);
-extern int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts, s32 *time_tai);
+extern int __do_adjtimex(struct __kernel_timex *txc,
+			 const struct timespec64 *ts,
+			 s32 *time_tai, struct audit_ntp_data *ad);
 extern void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts);
 #endif /* _LINUX_NTP_INTERNAL_H */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 3d24be4cd607..f366f2fdf1b0 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2307,6 +2307,7 @@ static int timekeeping_validate_timex(const struct __kernel_timex *txc)
 int do_adjtimex(struct __kernel_timex *txc)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
+	struct audit_ntp_data ad;
 	unsigned long flags;
 	struct timespec64 ts;
 	s32 orig_tai, tai;
@@ -2330,13 +2331,15 @@ int do_adjtimex(struct __kernel_timex *txc)
 		audit_tk_injoffset(delta);
 	}
 
+	audit_ntp_init(&ad);
+
 	ktime_get_real_ts64(&ts);
 
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	orig_tai = tai = tk->tai_offset;
-	ret = __do_adjtimex(txc, &ts, &tai);
+	ret = __do_adjtimex(txc, &ts, &tai, &ad);
 
 	if (tai != orig_tai) {
 		__timekeeping_set_tai_offset(tk, tai);
@@ -2347,6 +2350,8 @@ int do_adjtimex(struct __kernel_timex *txc)
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
+	audit_ntp_log(&ad);
+
 	/* Update the multiplier immediately if frequency was set directly */
 	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
 		timekeeping_advance(TK_ADV_FREQ);
-- 
2.20.1

