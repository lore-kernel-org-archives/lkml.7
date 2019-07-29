Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CA8C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4C120C01
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 22:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="lnGCc3se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbfG2WCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 18:02:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53242 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389152AbfG2V6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:58:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so55167646wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ajclCtPkHmfsuDyTsBDDeDUaIMIa7xyqZsQj0HfpnOA=;
        b=lnGCc3seAz7/5Fk6BPBM3aWZ8SM01FKbNWAOT+zQzVtr/Dzq+ZE0LKa3/1heVwkriP
         GhPol7F3fLGRmH5gCcgh/n+JCqadb8TUR0ieLX95mfsoYOUh1Nt5JCEwbhM7ZNdrsSIw
         imb3IM0USy672ek71uW/Wfq+rBMOslAN+T1lQ2HKpJ62uhmmd5FWaYVsktGisr/4SvxR
         JiWGK6pu6l0KWh/D2mHj0TZKhxc05iMAfQYU9ZKYCVZbuRmY3AhfIL8SnAqJ8bYyjlQM
         8EW/HXLWuHzAtDInwOnhpeQuEJLToQekLjPvcWpqaGT1xQeNiB9h0HilWtDxYPN1jC2J
         4Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ajclCtPkHmfsuDyTsBDDeDUaIMIa7xyqZsQj0HfpnOA=;
        b=imsn6O+cSMVbtn57bfLrSyHVFnPafLE1UIGWi3O5tuNTqZZUm17gP9DXF1dPl3it2g
         U8W1XwHE9ZyvJPSDnmPU9APyLvQeouSkvY5CR/wGWDSTIi5jGYxI0nsMDfFAYv46Ku99
         arpclOoY6bvuLabC3fTKNMHDvgqekDLgLTHlcBafps1tL8Y1QgT2XsDmKCGcWHOIXdJ2
         ZzsG6oc4HDb6GvK0RtBHWIb3hpUKI89+IIYzF+dyS0NkVl4TpwsUgTyYM+x+OSTMkn4t
         FOG5rvRRXhdo7Bhm8G9y175IjlUk8qwF0+p8ZbHJB/slJWMEMNKWHs7bJTz2sG6mX3rj
         5MpQ==
X-Gm-Message-State: APjAAAVf5mk2l7bpanNBcpp+EXIUUrq9xt/EuNSLKIx4P1zT3JOqCIKV
        v9xFaLsXe2JA8CiWXARzEyRKvuKsjwxIrNh7rCW4bJdBUes/+Mo+AeuietsmWnub8d1zN2q7nf5
        qII2aRMJ33ElQ3+iUg42Ki2EdrnuJkwCH2r23RP9fJq6GqsIaD4pRdfvDNUjflJXTs4AZVNxzof
        6XPOsfg91M2lGXtma6NtxD4Qd4tNVF9tdTL55bFyg=
X-Google-Smtp-Source: APXvYqydKDW+gZkozu2vWEw/73hiTbniTs0dQQl6sxyCjCKYQWJKj6t2LhCJsZSlAT2HCPI/buB3Xg==
X-Received: by 2002:a7b:c106:: with SMTP id w6mr106405895wmi.80.1564437487180;
        Mon, 29 Jul 2019 14:58:07 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:06 -0700 (PDT)
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
Subject: [PATCHv5 05/37] alarmtimer: Rename gettime() callback to get_ktime()
Date:   Mon, 29 Jul 2019 22:56:47 +0100
Message-Id: <20190729215758.28405-6-dima@arista.com>
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

The upcoming support for time namespaces requires to have access to:
  - The time in a tasks time namespace for sys_clock_gettime()
  - The time in the root name space for common_timer_get()

struct alarm_base needs to follow the same name convention, so rename
.gettime() callback into get_ktime() as a preparation for introducing
get_timespec().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/time/alarmtimer.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index c191254f178b..37254eb64459 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -36,13 +36,13 @@
  * struct alarm_base - Alarm timer bases
  * @lock:		Lock for syncrhonized access to the base
  * @timerqueue:		Timerqueue head managing the list of events
- * @gettime:		Function to read the time correlating to the base
+ * @get_ktime:		Function to read the time correlating to the base
  * @base_clockid:	clockid for the base
  */
 static struct alarm_base {
 	spinlock_t		lock;
 	struct timerqueue_head	timerqueue;
-	ktime_t			(*gettime)(void);
+	ktime_t			(*get_ktime)(void);
 	clockid_t		base_clockid;
 } alarm_bases[ALARM_NUMTYPE];
 
@@ -207,7 +207,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 	spin_unlock_irqrestore(&base->lock, flags);
 
 	if (alarm->function)
-		restart = alarm->function(alarm, base->gettime());
+		restart = alarm->function(alarm, base->get_ktime());
 
 	spin_lock_irqsave(&base->lock, flags);
 	if (restart != ALARMTIMER_NORESTART) {
@@ -217,7 +217,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 	}
 	spin_unlock_irqrestore(&base->lock, flags);
 
-	trace_alarmtimer_fired(alarm, base->gettime());
+	trace_alarmtimer_fired(alarm, base->get_ktime());
 	return ret;
 
 }
@@ -225,7 +225,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 ktime_t alarm_expires_remaining(const struct alarm *alarm)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	return ktime_sub(alarm->node.expires, base->gettime());
+	return ktime_sub(alarm->node.expires, base->get_ktime());
 }
 EXPORT_SYMBOL_GPL(alarm_expires_remaining);
 
@@ -270,7 +270,7 @@ static int alarmtimer_suspend(struct device *dev)
 		spin_unlock_irqrestore(&base->lock, flags);
 		if (!next)
 			continue;
-		delta = ktime_sub(next->expires, base->gettime());
+		delta = ktime_sub(next->expires, base->get_ktime());
 		if (!min || (delta < min)) {
 			expires = next->expires;
 			min = delta;
@@ -364,7 +364,7 @@ void alarm_start(struct alarm *alarm, ktime_t start)
 	hrtimer_start(&alarm->timer, alarm->node.expires, HRTIMER_MODE_ABS);
 	spin_unlock_irqrestore(&base->lock, flags);
 
-	trace_alarmtimer_start(alarm, base->gettime());
+	trace_alarmtimer_start(alarm, base->get_ktime());
 }
 EXPORT_SYMBOL_GPL(alarm_start);
 
@@ -377,7 +377,7 @@ void alarm_start_relative(struct alarm *alarm, ktime_t start)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
-	start = ktime_add_safe(start, base->gettime());
+	start = ktime_add_safe(start, base->get_ktime());
 	alarm_start(alarm, start);
 }
 EXPORT_SYMBOL_GPL(alarm_start_relative);
@@ -414,7 +414,7 @@ int alarm_try_to_cancel(struct alarm *alarm)
 		alarmtimer_dequeue(base, alarm);
 	spin_unlock_irqrestore(&base->lock, flags);
 
-	trace_alarmtimer_cancel(alarm, base->gettime());
+	trace_alarmtimer_cancel(alarm, base->get_ktime());
 	return ret;
 }
 EXPORT_SYMBOL_GPL(alarm_try_to_cancel);
@@ -474,7 +474,7 @@ u64 alarm_forward_now(struct alarm *alarm, ktime_t interval)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
-	return alarm_forward(alarm, base->gettime(), interval);
+	return alarm_forward(alarm, base->get_ktime(), interval);
 }
 EXPORT_SYMBOL_GPL(alarm_forward_now);
 
@@ -500,7 +500,7 @@ static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
 		return;
 	}
 
-	delta = ktime_sub(absexp, base->gettime());
+	delta = ktime_sub(absexp, base->get_ktime());
 
 	spin_lock_irqsave(&freezer_delta_lock, flags);
 	if (!freezer_delta || (delta < freezer_delta)) {
@@ -619,7 +619,7 @@ static void alarm_timer_arm(struct k_itimer *timr, ktime_t expires,
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
 	if (!absolute)
-		expires = ktime_add_safe(expires, base->gettime());
+		expires = ktime_add_safe(expires, base->get_ktime());
 	if (sigev_none)
 		alarm->node.expires = expires;
 	else
@@ -657,7 +657,7 @@ static int alarm_clock_get_timespec(clockid_t which_clock, struct timespec64 *tp
 	if (!alarmtimer_get_rtcdev())
 		return -EINVAL;
 
-	*tp = ktime_to_timespec64(base->gettime());
+	*tp = ktime_to_timespec64(base->get_ktime());
 	return 0;
 }
 
@@ -734,7 +734,7 @@ static int alarmtimer_do_nsleep(struct alarm *alarm, ktime_t absexp,
 		struct timespec64 rmt;
 		ktime_t rem;
 
-		rem = ktime_sub(absexp, alarm_bases[type].gettime());
+		rem = ktime_sub(absexp, alarm_bases[type].get_ktime());
 
 		if (rem <= 0)
 			return 0;
@@ -803,7 +803,7 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 	exp = timespec64_to_ktime(*tsreq);
 	/* Convert (if necessary) to absolute time */
 	if (flags != TIMER_ABSTIME) {
-		ktime_t now = alarm_bases[type].gettime();
+		ktime_t now = alarm_bases[type].get_ktime();
 
 		exp = ktime_add_safe(now, exp);
 	}
@@ -868,9 +868,9 @@ static int __init alarmtimer_init(void)
 
 	/* Initialize alarm bases */
 	alarm_bases[ALARM_REALTIME].base_clockid = CLOCK_REALTIME;
-	alarm_bases[ALARM_REALTIME].gettime = &ktime_get_real;
+	alarm_bases[ALARM_REALTIME].get_ktime = &ktime_get_real;
 	alarm_bases[ALARM_BOOTTIME].base_clockid = CLOCK_BOOTTIME;
-	alarm_bases[ALARM_BOOTTIME].gettime = &ktime_get_boottime;
+	alarm_bases[ALARM_BOOTTIME].get_ktime = &ktime_get_boottime;
 	for (i = 0; i < ALARM_NUMTYPE; i++) {
 		timerqueue_init_head(&alarm_bases[i].timerqueue);
 		spin_lock_init(&alarm_bases[i].lock);
-- 
2.22.0

