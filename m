Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB51EFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850BD2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbfKHVTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:19:10 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:38719 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbfKHVTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:19:09 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MILru-1ifJ81154m-00EM7J; Fri, 08 Nov 2019 22:18:25 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 21/23] y2038: itimer: change implementation to timespec64
Date:   Fri,  8 Nov 2019 22:12:20 +0100
Message-Id: <20191108211323.1806194-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4WkMuoICC5cesI0C2ij5Gho0hUchtCPLguOrWCvkT18I3mUYApK
 mIyxo/O5FNWkF8GSg0X4w8Ww98ksKCmv8ZLnT/hZr85GXFsa3pozz8/14suHv+84Hzu6eSR
 UcPUzijDUs6fudfytij27jIyG1UkCiwCm9xWpM+dIquYzGp/AEgwoRztv/4mtIWSuUe1grY
 JKuiwc7WcoJkqNKWjP3yA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/zzQfwu0qCU=:bPvyytG05KOYtyFomJc9AT
 PTH/9UC/fN81cwpu/nHj2Q+fmPkG6Iy9RC7xLjg/sZPFIojpOfNaO9gcKOt/NslUOCCHzP+H+
 beXp9U97yPrHOACl1wlavSW+P3KcWUmG8rk64VXWejc5G1i0Hh70GKOlCOBnYz0sx5cx0rOWB
 /H4xcaZoni3XI/qYyKihjDPP322u9Q5ur4UaBAE0VjEydeTrmC+bSHmU7l2MMfKIXJor7qwXl
 AdDewFSDyDVHM9oeswrymeeZQkGTSmr9HPWK8kVbmECU4TygxO6G/QjilxqsLzi0198SlarEv
 noPhuuo2ySVefKKVrY15UH8ulei9gaqVm5jC3ZX6GKLQWzoAMWsIpkkqWAJkOouF8EDDR0yQr
 PA7u2OKSGrxjVf16zHdP50xBVOrgMkGGMHPY+zojvwSeBZVe3P345pwti53gNusZD1MyZX2js
 kYsjddcJY6p1O7OD2cK1VWYLuyq8Sjqr4f48P687HAiTaC03T6lkGjIUyfaLl+kV2WysDQx7H
 0GEDXf3PNSEDDi650xywVXIDIz5HCifBtMtUG0vmBmpQl0LN3jdbdVMT01S5SnkqUHHZrTmqg
 bDEd4uSy+GNNDQatje69cA/Vjt+Yb+SBE4GHyzI+ooIfWzkasQ/KApHjg5exDP2fKOj8mcQ0U
 yzYOOsK+N7b/2SJT4ESQancNYS/aUUW6RxF8UiSKixljUkYI6BHXDeih68nBDeYds5wozL0EH
 KkbqjwCEknBHJcTTVvkldCLv/V60u0I+tvJzVd5Sos/ynVlCIjO0q6IH77KCQcYKjqVhs5yTK
 hMYbpQQDA3hJD76gkfP/mccWii8orVmSvfoqo9wX57hq46d/1JByLcJL5ROgJM6E1eZwNYlrw
 Tqsq5uUyTrFHnZ7V6ikQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no 64-bit version of getitimer/setitimer since that is not
actually needed. However, the implementation is built around the
deprecated 'struct timeval' type.

Change the code to use timespec64 internally to reduce the dependencies
on timeval and associated helper functions.

Minor adjustments in the code are needed to make the native and compat
version work the same way, and to keep the range check working after
the conversion.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/trace/events/timer.h |   8 +-
 kernel/time/itimer.c         | 158 +++++++++++++++++++++--------------
 2 files changed, 100 insertions(+), 66 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index b7a904825e7d..939cbfc80015 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -303,7 +303,7 @@ DEFINE_EVENT(hrtimer_class, hrtimer_cancel,
  */
 TRACE_EVENT(itimer_state,
 
-	TP_PROTO(int which, const struct itimerval *const value,
+	TP_PROTO(int which, const struct itimerspec64 *const value,
 		 unsigned long long expires),
 
 	TP_ARGS(which, value, expires),
@@ -321,12 +321,12 @@ TRACE_EVENT(itimer_state,
 		__entry->which		= which;
 		__entry->expires	= expires;
 		__entry->value_sec	= value->it_value.tv_sec;
-		__entry->value_usec	= value->it_value.tv_usec;
+		__entry->value_usec	= value->it_value.tv_nsec / NSEC_PER_USEC;
 		__entry->interval_sec	= value->it_interval.tv_sec;
-		__entry->interval_usec	= value->it_interval.tv_usec;
+		__entry->interval_usec	= value->it_interval.tv_nsec / NSEC_PER_USEC;
 	),
 
-	TP_printk("which=%d expires=%llu it_value=%ld.%ld it_interval=%ld.%ld",
+	TP_printk("which=%d expires=%llu it_value=%ld.%06ld it_interval=%ld.%06ld",
 		  __entry->which, __entry->expires,
 		  __entry->value_sec, __entry->value_usec,
 		  __entry->interval_sec, __entry->interval_usec)
diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index ce9cd19ce72e..5872db9bd5f7 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -26,7 +26,7 @@
  * Returns the delta between the expiry time and now, which can be
  * less than zero or 1usec for an pending expired timer
  */
-static struct timeval itimer_get_remtime(struct hrtimer *timer)
+static struct timespec64 itimer_get_remtime(struct hrtimer *timer)
 {
 	ktime_t rem = __hrtimer_get_remaining(timer, true);
 
@@ -41,11 +41,11 @@ static struct timeval itimer_get_remtime(struct hrtimer *timer)
 	} else
 		rem = 0;
 
-	return ktime_to_timeval(rem);
+	return ktime_to_timespec64(rem);
 }
 
 static void get_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
-			   struct itimerval *const value)
+			   struct itimerspec64 *const value)
 {
 	u64 val, interval;
 	struct cpu_itimer *it = &tsk->signal->it[clock_id];
@@ -69,11 +69,11 @@ static void get_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
 
 	spin_unlock_irq(&tsk->sighand->siglock);
 
-	value->it_value = ns_to_timeval(val);
-	value->it_interval = ns_to_timeval(interval);
+	value->it_value = ns_to_timespec64(val);
+	value->it_interval = ns_to_timespec64(interval);
 }
 
-static int do_getitimer(int which, struct itimerval *value)
+static int do_getitimer(int which, struct itimerspec64 *value)
 {
 	struct task_struct *tsk = current;
 
@@ -82,7 +82,7 @@ static int do_getitimer(int which, struct itimerval *value)
 		spin_lock_irq(&tsk->sighand->siglock);
 		value->it_value = itimer_get_remtime(&tsk->signal->real_timer);
 		value->it_interval =
-			ktime_to_timeval(tsk->signal->it_real_incr);
+			ktime_to_timespec64(tsk->signal->it_real_incr);
 		spin_unlock_irq(&tsk->sighand->siglock);
 		break;
 	case ITIMER_VIRTUAL:
@@ -97,17 +97,26 @@ static int do_getitimer(int which, struct itimerval *value)
 	return 0;
 }
 
+static int put_itimerval(struct itimerval __user *o,
+			 const struct itimerspec64 *i)
+{
+	struct itimerval v;
+
+	v.it_interval.tv_sec = i->it_interval.tv_sec;
+	v.it_interval.tv_usec = i->it_interval.tv_nsec / NSEC_PER_USEC;
+	v.it_value.tv_sec = i->it_value.tv_sec;
+	v.it_value.tv_usec = i->it_value.tv_nsec / NSEC_PER_USEC;
+	return copy_to_user(o, &v, sizeof(struct itimerval)) ? -EFAULT : 0;
+}
+
+
 SYSCALL_DEFINE2(getitimer, int, which, struct itimerval __user *, value)
 {
-	int error = -EFAULT;
-	struct itimerval get_buffer;
+	struct itimerspec64 get_buffer;
+	int error = do_getitimer(which, &get_buffer);
 
-	if (value) {
-		error = do_getitimer(which, &get_buffer);
-		if (!error &&
-		    copy_to_user(value, &get_buffer, sizeof(get_buffer)))
-			error = -EFAULT;
-	}
+	if (!error && put_itimerval(value, &get_buffer))
+		error = -EFAULT;
 	return error;
 }
 
@@ -117,24 +126,25 @@ struct old_itimerval32 {
 	struct old_timeval32	it_value;
 };
 
-static int put_old_itimerval32(struct old_itimerval32 __user *o, const struct itimerval *i)
+static int put_old_itimerval32(struct old_itimerval32 __user *o,
+			       const struct itimerspec64 *i)
 {
 	struct old_itimerval32 v32;
 
 	v32.it_interval.tv_sec = i->it_interval.tv_sec;
-	v32.it_interval.tv_usec = i->it_interval.tv_usec;
+	v32.it_interval.tv_usec = i->it_interval.tv_nsec / NSEC_PER_USEC;
 	v32.it_value.tv_sec = i->it_value.tv_sec;
-	v32.it_value.tv_usec = i->it_value.tv_usec;
+	v32.it_value.tv_usec = i->it_value.tv_nsec / NSEC_PER_USEC;
 	return copy_to_user(o, &v32, sizeof(struct old_itimerval32)) ? -EFAULT : 0;
 }
 
 COMPAT_SYSCALL_DEFINE2(getitimer, int, which,
-		       struct old_itimerval32 __user *, it)
+		       struct old_itimerval32 __user *, value)
 {
-	struct itimerval kit;
-	int error = do_getitimer(which, &kit);
+	struct itimerspec64 get_buffer;
+	int error = do_getitimer(which, &get_buffer);
 
-	if (!error && put_old_itimerval32(it, &kit))
+	if (!error && put_old_itimerval32(value, &get_buffer))
 		error = -EFAULT;
 	return error;
 }
@@ -156,8 +166,8 @@ enum hrtimer_restart it_real_fn(struct hrtimer *timer)
 }
 
 static void set_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
-			   const struct itimerval *const value,
-			   struct itimerval *const ovalue)
+			   const struct itimerspec64 *const value,
+			   struct itimerspec64 *const ovalue)
 {
 	u64 oval, nval, ointerval, ninterval;
 	struct cpu_itimer *it = &tsk->signal->it[clock_id];
@@ -166,8 +176,8 @@ static void set_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
 	 * Use the to_ktime conversion because that clamps the maximum
 	 * value to KTIME_MAX and avoid multiplication overflows.
 	 */
-	nval = ktime_to_ns(timeval_to_ktime(value->it_value));
-	ninterval = ktime_to_ns(timeval_to_ktime(value->it_interval));
+	nval = timespec64_to_ns(&value->it_value);
+	ninterval = timespec64_to_ns(&value->it_interval);
 
 	spin_lock_irq(&tsk->sighand->siglock);
 
@@ -186,8 +196,8 @@ static void set_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
 	spin_unlock_irq(&tsk->sighand->siglock);
 
 	if (ovalue) {
-		ovalue->it_value = ns_to_timeval(oval);
-		ovalue->it_interval = ns_to_timeval(ointerval);
+		ovalue->it_value = ns_to_timespec64(oval);
+		ovalue->it_interval = ns_to_timespec64(ointerval);
 	}
 }
 
@@ -197,19 +207,13 @@ static void set_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
 #define timeval_valid(t) \
 	(((t)->tv_sec >= 0) && (((unsigned long) (t)->tv_usec) < USEC_PER_SEC))
 
-static int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
+static int do_setitimer(int which, struct itimerspec64 *value,
+			struct itimerspec64 *ovalue)
 {
 	struct task_struct *tsk = current;
 	struct hrtimer *timer;
 	ktime_t expires;
 
-	/*
-	 * Validate the timevals in value.
-	 */
-	if (!timeval_valid(&value->it_value) ||
-	    !timeval_valid(&value->it_interval))
-		return -EINVAL;
-
 	switch (which) {
 	case ITIMER_REAL:
 again:
@@ -218,7 +222,7 @@ static int do_setitimer(int which, struct itimerval *value, struct itimerval *ov
 		if (ovalue) {
 			ovalue->it_value = itimer_get_remtime(timer);
 			ovalue->it_interval
-				= ktime_to_timeval(tsk->signal->it_real_incr);
+				= ktime_to_timespec64(tsk->signal->it_real_incr);
 		}
 		/* We are sharing ->siglock with it_real_fn() */
 		if (hrtimer_try_to_cancel(timer) < 0) {
@@ -226,10 +230,10 @@ static int do_setitimer(int which, struct itimerval *value, struct itimerval *ov
 			hrtimer_cancel_wait_running(timer);
 			goto again;
 		}
-		expires = timeval_to_ktime(value->it_value);
+		expires = timespec64_to_ktime(value->it_value);
 		if (expires != 0) {
 			tsk->signal->it_real_incr =
-				timeval_to_ktime(value->it_interval);
+				timespec64_to_ktime(value->it_interval);
 			hrtimer_start(timer, expires, HRTIMER_MODE_REL);
 		} else
 			tsk->signal->it_real_incr = 0;
@@ -252,7 +256,7 @@ static int do_setitimer(int which, struct itimerval *value, struct itimerval *ov
 #ifdef CONFIG_SECURITY_SELINUX
 void clear_itimer(void)
 {
-	struct itimerval v = {};
+	struct itimerspec64 v = {};
 	int i;
 
 	for (i = 0; i < 3; i++)
@@ -276,15 +280,15 @@ void clear_itimer(void)
  */
 static unsigned int alarm_setitimer(unsigned int seconds)
 {
-	struct itimerval it_new, it_old;
+	struct itimerspec64 it_new, it_old;
 
 #if BITS_PER_LONG < 64
 	if (seconds > INT_MAX)
 		seconds = INT_MAX;
 #endif
 	it_new.it_value.tv_sec = seconds;
-	it_new.it_value.tv_usec = 0;
-	it_new.it_interval.tv_sec = it_new.it_interval.tv_usec = 0;
+	it_new.it_value.tv_nsec = 0;
+	it_new.it_interval.tv_sec = it_new.it_interval.tv_nsec = 0;
 
 	do_setitimer(ITIMER_REAL, &it_new, &it_old);
 
@@ -292,8 +296,8 @@ static unsigned int alarm_setitimer(unsigned int seconds)
 	 * We can't return 0 if we have an alarm pending ...  And we'd
 	 * better return too much than too little anyway
 	 */
-	if ((!it_old.it_value.tv_sec && it_old.it_value.tv_usec) ||
-	      it_old.it_value.tv_usec >= 500000)
+	if ((!it_old.it_value.tv_sec && it_old.it_value.tv_nsec) ||
+	      it_old.it_value.tv_nsec >= 500000)
 		it_old.it_value.tv_sec++;
 
 	return it_old.it_value.tv_sec;
@@ -310,15 +314,35 @@ SYSCALL_DEFINE1(alarm, unsigned int, seconds)
 
 #endif
 
+static int get_itimerval(struct itimerspec64 *o, const struct itimerval __user *i)
+{
+	struct itimerval v;
+
+	if (copy_from_user(&v, i, sizeof(struct itimerval)))
+		return -EFAULT;
+
+	/* Validate the timevals in value. */
+	if (!timeval_valid(&v.it_value) ||
+	    !timeval_valid(&v.it_interval))
+		return -EINVAL;
+
+	o->it_interval.tv_sec = v.it_interval.tv_sec;
+	o->it_interval.tv_nsec = v.it_interval.tv_usec * NSEC_PER_USEC;
+	o->it_value.tv_sec = v.it_value.tv_sec;
+	o->it_value.tv_nsec = v.it_value.tv_usec * NSEC_PER_USEC;
+	return 0;
+}
+
 SYSCALL_DEFINE3(setitimer, int, which, struct itimerval __user *, value,
 		struct itimerval __user *, ovalue)
 {
-	struct itimerval set_buffer, get_buffer;
+	struct itimerspec64 set_buffer, get_buffer;
 	int error;
 
 	if (value) {
-		if(copy_from_user(&set_buffer, value, sizeof(set_buffer)))
-			return -EFAULT;
+		error = get_itimerval(&set_buffer, value);
+		if (error)
+			return error;
 	} else {
 		memset(&set_buffer, 0, sizeof(set_buffer));
 		printk_once(KERN_WARNING "%s calls setitimer() with new_value NULL pointer."
@@ -330,43 +354,53 @@ SYSCALL_DEFINE3(setitimer, int, which, struct itimerval __user *, value,
 	if (error || !ovalue)
 		return error;
 
-	if (copy_to_user(ovalue, &get_buffer, sizeof(get_buffer)))
+	if (put_itimerval(ovalue, &get_buffer))
 		return -EFAULT;
 	return 0;
 }
 
 #if defined(CONFIG_COMPAT) || defined(CONFIG_ALPHA)
-static int get_old_itimerval32(struct itimerval *o, const struct old_itimerval32 __user *i)
+static int get_old_itimerval32(struct itimerspec64 *o, const struct old_itimerval32 __user *i)
 {
 	struct old_itimerval32 v32;
 
 	if (copy_from_user(&v32, i, sizeof(struct old_itimerval32)))
 		return -EFAULT;
+
+	/* Validate the timevals in value.  */
+	if (!timeval_valid(&v32.it_value) ||
+	    !timeval_valid(&v32.it_interval))
+		return -EINVAL;
+
 	o->it_interval.tv_sec = v32.it_interval.tv_sec;
-	o->it_interval.tv_usec = v32.it_interval.tv_usec;
+	o->it_interval.tv_nsec = v32.it_interval.tv_usec * NSEC_PER_USEC;
 	o->it_value.tv_sec = v32.it_value.tv_sec;
-	o->it_value.tv_usec = v32.it_value.tv_usec;
+	o->it_value.tv_nsec = v32.it_value.tv_usec * NSEC_PER_USEC;
 	return 0;
 }
 
 COMPAT_SYSCALL_DEFINE3(setitimer, int, which,
-		       struct old_itimerval32 __user *, in,
-		       struct old_itimerval32 __user *, out)
+		       struct old_itimerval32 __user *, value,
+		       struct old_itimerval32 __user *, ovalue)
 {
-	struct itimerval kin, kout;
+	struct itimerspec64 set_buffer, get_buffer;
 	int error;
 
-	if (in) {
-		if (get_old_itimerval32(&kin, in))
-			return -EFAULT;
+	if (value) {
+		error = get_old_itimerval32(&set_buffer, value);
+		if (error)
+			return error;
 	} else {
-		memset(&kin, 0, sizeof(kin));
+		memset(&set_buffer, 0, sizeof(set_buffer));
+		printk_once(KERN_WARNING "%s calls setitimer() with new_value NULL pointer."
+			    " Misfeature support will be removed\n",
+			    current->comm);
 	}
 
-	error = do_setitimer(which, &kin, out ? &kout : NULL);
-	if (error || !out)
+	error = do_setitimer(which, &set_buffer, ovalue ? &get_buffer : NULL);
+	if (error || !ovalue)
 		return error;
-	if (put_old_itimerval32(out, &kout))
+	if (put_old_itimerval32(ovalue, &get_buffer))
 		return -EFAULT;
 	return 0;
 }
-- 
2.20.0

