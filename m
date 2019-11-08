Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AB3FC6197
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD1F207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfKHVT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:19:26 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:59767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387457AbfKHVTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:19:25 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MYN7M-1iPHeH0u6U-00VTIJ; Fri, 08 Nov 2019 22:18:39 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 22/23] [RFC] y2038: itimer: use ktime_t internally
Date:   Fri,  8 Nov 2019 22:12:21 +0100
Message-Id: <20191108211323.1806194-13-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bM7Nq5CQwuGoA1BzdrxI+2VwSoMwQ74iQFLFgEinkzmGc+wlBQZ
 V318kOnZNRgaZA/puj1HIUZcWO4Ad6LjJnpaADk4UeLJEXxeMOXwQnM8Q1bg3xCgBc3OPkr
 wJ5SqoGUya06OdD55aZ08FKQ82G8L9N3iJsnzU0J7Jb29WzFDhqexRvR9515GOzVdTX9xke
 fEoghTmTy8yjmJwhOwfOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DrQ+rs5qJwo=:r0wIZdZ918c2vkhwfd6m0T
 J8RH6yELp3vSCjEg0mTtvZwZdqVASeKkTXX+nqi4pCnTdytolxdHOtmJ8eRpjAPFaGQFI4kZ/
 5MaKwvx0T2sHlYYEj8i23z0SLmrFttzs43cP9s1dBIdl8JeoyhYfoh36yuXBSe5Rm54ikNRRs
 r5NR+dJFxkfx9I7LMWTPhmZOWBZjkYn3q5xtTgXsB+DM5HTXeOV49LlqMAZG+3w73/n0dBRAn
 PO+W0kPZ4Zio/Ty56VJsGpk8XD/krjSwrtn3XQSFCXNUz5upsbsrYxf4rNkD85UQfnZ1gnEHF
 dclDtemsKkR05wgGMayYQMfphAMlVx575TZkO7EPfOxgO2I6JQcdYSLdpdXegQCrtEy7C4MWt
 E5Oe98FbMKBYJHoKsHmqZl1ZP3UFxEukCoL85MNmtbV0BouHee4IykTlfGztW0M9l8qRkHkto
 ezCsWSNz9ciR/k9aogSpc0s95yKAm0mVRMKgOsZjZgnDu6K1XWnsTT2Ut6ZPGoshEmZ6oug/W
 7DZToa2Fg34wJ8scRpeREb8hELiWpiIC38hRK3nkmTJwRgYB2q/a61X+GGenVoerY8IivVij9
 J/VzzVq4I3g1ZXRJ6qiPrylfuMQDkPscBj4b8IDutXO9MTp5dYqlWo5UAoQecFSrPdn6cnrcL
 opzPgtoaDERVpK1CIHSsKQnef78GkVCAvOhdzULSbV8vtPglihgGdVEUFfqy372CZYDaYvbS1
 GkBtof09S6GreNdI06B3GSKHAK7HtYL+QBtY078EPnw4SnFkSbW5/YVeLgDNADwyPEmCbqsni
 Xpt5OJr1hnkaWNdxx4JDm7PUN+wJkw7eL1wj9zYq4aZjBbl7q7O9CAfityg9eh0PcT8lpgbEj
 0d9yU7k/42n51ZuVnvGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the intermediate step going from timeval to timespec64 to
ktime_t and back by using ktime_t throughout the code.

I was going back and forth between the two implementations.
This patch is optional: if we want it, it could be folded into
the patch converting to itimerspec64.

On an arm32 build, this version actually produces 10% larger
code than the timespec64 version, while on x86-64 it's the
same as before, and the number of source lines stays the
same as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/trace/events/timer.h |  29 ++---
 kernel/time/itimer.c         | 229 ++++++++++++++++++-----------------
 2 files changed, 129 insertions(+), 129 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 939cbfc80015..021733a49f10 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -297,39 +297,36 @@ DEFINE_EVENT(hrtimer_class, hrtimer_cancel,
 /**
  * itimer_state - called when itimer is started or canceled
  * @which:	name of the interval timer
- * @value:	the itimers value, itimer is canceled if value->it_value is
- *		zero, otherwise it is started
+ * @interval:	the itimers value
+ * @interval:	the itimers interval
  * @expires:	the itimers expiry time
  */
 TRACE_EVENT(itimer_state,
 
-	TP_PROTO(int which, const struct itimerspec64 *const value,
-		 unsigned long long expires),
+	TP_PROTO(int which, ktime_t value, ktime_t interval, unsigned long long expires),
 
-	TP_ARGS(which, value, expires),
+	TP_ARGS(which, value, interval, expires),
 
 	TP_STRUCT__entry(
 		__field(	int,			which		)
 		__field(	unsigned long long,	expires		)
-		__field(	long,			value_sec	)
-		__field(	long,			value_usec	)
-		__field(	long,			interval_sec	)
-		__field(	long,			interval_usec	)
+		__field(	time64_t,		value_sec	)
+		__field(	u32,			value_nsec	)
+		__field(	time64_t,		interval_sec	)
+		__field(	u32,			interval_nsec	)
 	),
 
 	TP_fast_assign(
 		__entry->which		= which;
 		__entry->expires	= expires;
-		__entry->value_sec	= value->it_value.tv_sec;
-		__entry->value_usec	= value->it_value.tv_nsec / NSEC_PER_USEC;
-		__entry->interval_sec	= value->it_interval.tv_sec;
-		__entry->interval_usec	= value->it_interval.tv_nsec / NSEC_PER_USEC;
+		__entry->value_sec	= div_u64_rem(value, NSEC_PER_SEC, &__entry->value_nsec);
+		__entry->interval_sec	= div_u64_rem(interval, NSEC_PER_SEC, &__entry->interval_nsec);
 	),
 
-	TP_printk("which=%d expires=%llu it_value=%ld.%06ld it_interval=%ld.%06ld",
+	TP_printk("which=%d expires=%llu it_value=%lld.%09d it_interval=%lld.%09d",
 		  __entry->which, __entry->expires,
-		  __entry->value_sec, __entry->value_usec,
-		  __entry->interval_sec, __entry->interval_usec)
+		  __entry->value_sec, __entry->value_nsec,
+		  __entry->interval_sec, __entry->interval_nsec)
 );
 
 /**
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 5872db9bd5f7..707f73054d76 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -26,7 +26,7 @@
  * Returns the delta between the expiry time and now, which can be
  * less than zero or 1usec for an pending expired timer
  */
-static struct timespec64 itimer_get_remtime(struct hrtimer *timer)
+static ktime_t itimer_get_remtime(struct hrtimer *timer)
 {
 	ktime_t rem = __hrtimer_get_remaining(timer, true);
 
@@ -41,11 +41,11 @@ static struct timespec64 itimer_get_remtime(struct hrtimer *timer)
 	} else
 		rem = 0;
 
-	return ktime_to_timespec64(rem);
+	return rem;
 }
 
 static void get_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
-			   struct itimerspec64 *const value)
+			   ktime_t *ovalue, ktime_t *ointerval)
 {
 	u64 val, interval;
 	struct cpu_itimer *it = &tsk->signal->it[clock_id];
@@ -69,27 +69,26 @@ static void get_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
 
 	spin_unlock_irq(&tsk->sighand->siglock);
 
-	value->it_value = ns_to_timespec64(val);
-	value->it_interval = ns_to_timespec64(interval);
+	*ovalue = ns_to_ktime(val);
+	*ointerval = ns_to_ktime(interval);
 }
 
-static int do_getitimer(int which, struct itimerspec64 *value)
+static int do_getitimer(int which, ktime_t *value, ktime_t *interval)
 {
 	struct task_struct *tsk = current;
 
 	switch (which) {
 	case ITIMER_REAL:
 		spin_lock_irq(&tsk->sighand->siglock);
-		value->it_value = itimer_get_remtime(&tsk->signal->real_timer);
-		value->it_interval =
-			ktime_to_timespec64(tsk->signal->it_real_incr);
+		*value = itimer_get_remtime(&tsk->signal->real_timer);
+		*interval = tsk->signal->it_real_incr;
 		spin_unlock_irq(&tsk->sighand->siglock);
 		break;
 	case ITIMER_VIRTUAL:
-		get_cpu_itimer(tsk, CPUCLOCK_VIRT, value);
+		get_cpu_itimer(tsk, CPUCLOCK_VIRT, value, interval);
 		break;
 	case ITIMER_PROF:
-		get_cpu_itimer(tsk, CPUCLOCK_PROF, value);
+		get_cpu_itimer(tsk, CPUCLOCK_PROF, value, interval);
 		break;
 	default:
 		return(-EINVAL);
@@ -98,26 +97,31 @@ static int do_getitimer(int which, struct itimerspec64 *value)
 }
 
 static int put_itimerval(struct itimerval __user *o,
-			 const struct itimerspec64 *i)
+			 ktime_t value, ktime_t interval)
 {
 	struct itimerval v;
-
-	v.it_interval.tv_sec = i->it_interval.tv_sec;
-	v.it_interval.tv_usec = i->it_interval.tv_nsec / NSEC_PER_USEC;
-	v.it_value.tv_sec = i->it_value.tv_sec;
-	v.it_value.tv_usec = i->it_value.tv_nsec / NSEC_PER_USEC;
+	struct timespec64 ts;
+
+	ts = ktime_to_timespec64(interval);
+	v.it_interval.tv_sec = ts.tv_sec;
+	v.it_interval.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
+	ts = ktime_to_timespec64(value);
+	v.it_value.tv_sec = ts.tv_sec;
+	v.it_value.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
 	return copy_to_user(o, &v, sizeof(struct itimerval)) ? -EFAULT : 0;
 }
 
 
-SYSCALL_DEFINE2(getitimer, int, which, struct itimerval __user *, value)
+SYSCALL_DEFINE2(getitimer, int, which, struct itimerval __user *, it)
 {
-	struct itimerspec64 get_buffer;
-	int error = do_getitimer(which, &get_buffer);
+	ktime_t value, interval;
+	int error;
+
+	error = do_getitimer(which, &value, &interval);
+	if (error)
+		return error;
 
-	if (!error && put_itimerval(value, &get_buffer))
-		error = -EFAULT;
-	return error;
+	return put_itimerval(it, value, interval);
 }
 
 #if defined(CONFIG_COMPAT) || defined(CONFIG_ALPHA)
@@ -127,26 +131,31 @@ struct old_itimerval32 {
 };
 
 static int put_old_itimerval32(struct old_itimerval32 __user *o,
-			       const struct itimerspec64 *i)
+			       ktime_t value, ktime_t interval)
 {
 	struct old_itimerval32 v32;
-
-	v32.it_interval.tv_sec = i->it_interval.tv_sec;
-	v32.it_interval.tv_usec = i->it_interval.tv_nsec / NSEC_PER_USEC;
-	v32.it_value.tv_sec = i->it_value.tv_sec;
-	v32.it_value.tv_usec = i->it_value.tv_nsec / NSEC_PER_USEC;
+	struct timespec64 ts;
+
+	ts = ktime_to_timespec64(interval);
+	v32.it_interval.tv_sec = ts.tv_sec;
+	v32.it_interval.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
+	ts = ktime_to_timespec64(value);
+	v32.it_value.tv_sec = ts.tv_sec;
+	v32.it_value.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
 	return copy_to_user(o, &v32, sizeof(struct old_itimerval32)) ? -EFAULT : 0;
 }
 
 COMPAT_SYSCALL_DEFINE2(getitimer, int, which,
-		       struct old_itimerval32 __user *, value)
+		       struct old_itimerval32 __user *, it)
 {
-	struct itimerspec64 get_buffer;
-	int error = do_getitimer(which, &get_buffer);
+	ktime_t value, interval;
+	int error;
 
-	if (!error && put_old_itimerval32(value, &get_buffer))
-		error = -EFAULT;
-	return error;
+	error = do_getitimer(which, &value, &interval);
+	if (error)
+		return error;
+
+	return put_old_itimerval32(it, value, interval);
 }
 #endif
 
@@ -166,86 +175,78 @@ enum hrtimer_restart it_real_fn(struct hrtimer *timer)
 }
 
 static void set_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
-			   const struct itimerspec64 *const value,
-			   struct itimerspec64 *const ovalue)
+			   ktime_t value, ktime_t interval,
+			   ktime_t *ovalue, ktime_t *ointerval)
 {
-	u64 oval, nval, ointerval, ninterval;
+	u64 oval, nval;
 	struct cpu_itimer *it = &tsk->signal->it[clock_id];
 
-	/*
-	 * Use the to_ktime conversion because that clamps the maximum
-	 * value to KTIME_MAX and avoid multiplication overflows.
-	 */
-	nval = timespec64_to_ns(&value->it_value);
-	ninterval = timespec64_to_ns(&value->it_interval);
+	nval = value;
 
 	spin_lock_irq(&tsk->sighand->siglock);
 
 	oval = it->expires;
-	ointerval = it->incr;
+	if (ointerval)
+		*ointerval = it->incr;
+
 	if (oval || nval) {
 		if (nval > 0)
 			nval += TICK_NSEC;
 		set_process_cpu_timer(tsk, clock_id, &nval, &oval);
 	}
+
 	it->expires = nval;
-	it->incr = ninterval;
+	it->incr = interval;
+
 	trace_itimer_state(clock_id == CPUCLOCK_VIRT ?
-			   ITIMER_VIRTUAL : ITIMER_PROF, value, nval);
+			   ITIMER_VIRTUAL : ITIMER_PROF, value, interval, nval);
 
 	spin_unlock_irq(&tsk->sighand->siglock);
 
-	if (ovalue) {
-		ovalue->it_value = ns_to_timespec64(oval);
-		ovalue->it_interval = ns_to_timespec64(ointerval);
-	}
+	if (ovalue)
+		*ovalue = oval;
 }
 
-/*
- * Returns true if the timeval is in canonical form
- */
 #define timeval_valid(t) \
 	(((t)->tv_sec >= 0) && (((unsigned long) (t)->tv_usec) < USEC_PER_SEC))
 
-static int do_setitimer(int which, struct itimerspec64 *value,
-			struct itimerspec64 *ovalue)
+static int do_setitimer(int which, ktime_t value, ktime_t interval,
+			ktime_t *ovalue, ktime_t *ointerval)
 {
 	struct task_struct *tsk = current;
 	struct hrtimer *timer;
-	ktime_t expires;
 
 	switch (which) {
 	case ITIMER_REAL:
 again:
 		spin_lock_irq(&tsk->sighand->siglock);
 		timer = &tsk->signal->real_timer;
-		if (ovalue) {
-			ovalue->it_value = itimer_get_remtime(timer);
-			ovalue->it_interval
-				= ktime_to_timespec64(tsk->signal->it_real_incr);
-		}
+		if (ovalue)
+			*ovalue = itimer_get_remtime(timer);
+		if (ointerval)
+			*ointerval = tsk->signal->it_real_incr;
 		/* We are sharing ->siglock with it_real_fn() */
 		if (hrtimer_try_to_cancel(timer) < 0) {
 			spin_unlock_irq(&tsk->sighand->siglock);
 			hrtimer_cancel_wait_running(timer);
 			goto again;
 		}
-		expires = timespec64_to_ktime(value->it_value);
-		if (expires != 0) {
-			tsk->signal->it_real_incr =
-				timespec64_to_ktime(value->it_interval);
-			hrtimer_start(timer, expires, HRTIMER_MODE_REL);
+		if (value != 0) {
+			tsk->signal->it_real_incr = interval;
+			hrtimer_start(timer, value, HRTIMER_MODE_REL);
 		} else
 			tsk->signal->it_real_incr = 0;
 
-		trace_itimer_state(ITIMER_REAL, value, 0);
+		trace_itimer_state(ITIMER_REAL, value, interval, 0);
 		spin_unlock_irq(&tsk->sighand->siglock);
 		break;
 	case ITIMER_VIRTUAL:
-		set_cpu_itimer(tsk, CPUCLOCK_VIRT, value, ovalue);
+		set_cpu_itimer(tsk, CPUCLOCK_VIRT, value, interval,
+			       ovalue, ointerval);
 		break;
 	case ITIMER_PROF:
-		set_cpu_itimer(tsk, CPUCLOCK_PROF, value, ovalue);
+		set_cpu_itimer(tsk, CPUCLOCK_PROF, value, interval,
+			       ovalue, ointerval);
 		break;
 	default:
 		return -EINVAL;
@@ -256,11 +257,10 @@ static int do_setitimer(int which, struct itimerspec64 *value,
 #ifdef CONFIG_SECURITY_SELINUX
 void clear_itimer(void)
 {
-	struct itimerspec64 v = {};
 	int i;
 
 	for (i = 0; i < 3; i++)
-		do_setitimer(i, &v, NULL);
+		do_setitimer(i, 0, 0, NULL, NULL);
 }
 #endif
 
@@ -280,27 +280,23 @@ void clear_itimer(void)
  */
 static unsigned int alarm_setitimer(unsigned int seconds)
 {
-	struct itimerspec64 it_new, it_old;
+	ktime_t old;
 
 #if BITS_PER_LONG < 64
 	if (seconds > INT_MAX)
 		seconds = INT_MAX;
 #endif
-	it_new.it_value.tv_sec = seconds;
-	it_new.it_value.tv_nsec = 0;
-	it_new.it_interval.tv_sec = it_new.it_interval.tv_nsec = 0;
 
-	do_setitimer(ITIMER_REAL, &it_new, &it_old);
+	do_setitimer(ITIMER_REAL, ktime_set(seconds, 0), 0, &old, NULL);
 
 	/*
 	 * We can't return 0 if we have an alarm pending ...  And we'd
 	 * better return too much than too little anyway
 	 */
-	if ((!it_old.it_value.tv_sec && it_old.it_value.tv_nsec) ||
-	      it_old.it_value.tv_nsec >= 500000)
-		it_old.it_value.tv_sec++;
+	if (old > 0 && old < NSEC_PER_SEC)
+		return 1;
 
-	return it_old.it_value.tv_sec;
+	return div_u64(old + (NSEC_PER_SEC / 2), NSEC_PER_SEC);
 }
 
 /*
@@ -314,7 +310,8 @@ SYSCALL_DEFINE1(alarm, unsigned int, seconds)
 
 #endif
 
-static int get_itimerval(struct itimerspec64 *o, const struct itimerval __user *i)
+static int get_itimerval(ktime_t *value, ktime_t *interval,
+				const struct itimerval __user *i)
 {
 	struct itimerval v;
 
@@ -326,41 +323,45 @@ static int get_itimerval(struct itimerspec64 *o, const struct itimerval __user *
 	    !timeval_valid(&v.it_interval))
 		return -EINVAL;
 
-	o->it_interval.tv_sec = v.it_interval.tv_sec;
-	o->it_interval.tv_nsec = v.it_interval.tv_usec * NSEC_PER_USEC;
-	o->it_value.tv_sec = v.it_value.tv_sec;
-	o->it_value.tv_nsec = v.it_value.tv_usec * NSEC_PER_USEC;
+	*interval = ktime_set(v.it_interval.tv_sec,
+			      v.it_interval.tv_usec * NSEC_PER_USEC);
+	*value = ktime_set(v.it_value.tv_sec,
+			   v.it_value.tv_usec * NSEC_PER_USEC);
+
 	return 0;
 }
 
-SYSCALL_DEFINE3(setitimer, int, which, struct itimerval __user *, value,
-		struct itimerval __user *, ovalue)
+
+SYSCALL_DEFINE3(setitimer, int, which, struct itimerval __user *, in,
+		struct itimerval __user *, out)
 {
-	struct itimerspec64 set_buffer, get_buffer;
+	ktime_t value = 0, interval = 0;
+	ktime_t ovalue, ointerval;
 	int error;
 
-	if (value) {
-		error = get_itimerval(&set_buffer, value);
+	if (in) {
+		error = get_itimerval(&value, &interval, in);
 		if (error)
 			return error;
 	} else {
-		memset(&set_buffer, 0, sizeof(set_buffer));
 		printk_once(KERN_WARNING "%s calls setitimer() with new_value NULL pointer."
 			    " Misfeature support will be removed\n",
 			    current->comm);
 	}
 
-	error = do_setitimer(which, &set_buffer, ovalue ? &get_buffer : NULL);
-	if (error || !ovalue)
+	if (!out)
+		return do_setitimer(which, value, interval, NULL, NULL);
+
+	error = do_setitimer(which, value, interval, &ovalue, &ointerval);
+	if (error)
 		return error;
 
-	if (put_itimerval(ovalue, &get_buffer))
-		return -EFAULT;
-	return 0;
+	return put_itimerval(out, ovalue, ointerval);
 }
 
 #if defined(CONFIG_COMPAT) || defined(CONFIG_ALPHA)
-static int get_old_itimerval32(struct itimerspec64 *o, const struct old_itimerval32 __user *i)
+static int get_old_itimerval32(ktime_t *value, ktime_t *interval,
+				const struct old_itimerval32 __user *i)
 {
 	struct old_itimerval32 v32;
 
@@ -372,36 +373,38 @@ static int get_old_itimerval32(struct itimerspec64 *o, const struct old_itimerva
 	    !timeval_valid(&v32.it_interval))
 		return -EINVAL;
 
-	o->it_interval.tv_sec = v32.it_interval.tv_sec;
-	o->it_interval.tv_nsec = v32.it_interval.tv_usec * NSEC_PER_USEC;
-	o->it_value.tv_sec = v32.it_value.tv_sec;
-	o->it_value.tv_nsec = v32.it_value.tv_usec * NSEC_PER_USEC;
+	*interval = ktime_set(v32.it_interval.tv_sec,
+			      v32.it_interval.tv_usec * NSEC_PER_USEC);
+	*value = ktime_set(v32.it_value.tv_sec,
+			   v32.it_value.tv_usec * NSEC_PER_USEC);
+
 	return 0;
 }
 
 COMPAT_SYSCALL_DEFINE3(setitimer, int, which,
-		       struct old_itimerval32 __user *, value,
-		       struct old_itimerval32 __user *, ovalue)
+		       struct old_itimerval32 __user *, in,
+		       struct old_itimerval32 __user *, out)
 {
-	struct itimerspec64 set_buffer, get_buffer;
+	ktime_t value = 0, interval = 0;
+	ktime_t ovalue, ointerval;
 	int error;
 
-	if (value) {
-		error = get_old_itimerval32(&set_buffer, value);
+	if (in) {
+		error = get_old_itimerval32(&value, &interval, in);
 		if (error)
 			return error;
 	} else {
-		memset(&set_buffer, 0, sizeof(set_buffer));
 		printk_once(KERN_WARNING "%s calls setitimer() with new_value NULL pointer."
 			    " Misfeature support will be removed\n",
 			    current->comm);
 	}
 
-	error = do_setitimer(which, &set_buffer, ovalue ? &get_buffer : NULL);
-	if (error || !ovalue)
+	if (!out)
+		return do_setitimer(which, value, interval, NULL, NULL);
+
+	error = do_setitimer(which, value, interval, &ovalue, &ointerval);
+	if (error)
 		return error;
-	if (put_old_itimerval32(ovalue, &get_buffer))
-		return -EFAULT;
-	return 0;
+	return put_old_itimerval32(out, ovalue, ointerval);
 }
 #endif
-- 
2.20.0

