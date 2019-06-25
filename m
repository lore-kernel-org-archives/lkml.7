Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3ACC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4497221670
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ihxT0NBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfFYITc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:19:32 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:38083 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfFYITb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:19:31 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c4d01081;
        Tue, 25 Jun 2019 07:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=2oUXYO/ZlKc88Ej+IHrly3uiZ
        o4=; b=ihxT0NBfTWjQVuwgzsSOVSXLDTPuyZmoqIMZ/CbKrraGLF3w8/Ta5qADf
        MP+RhCOK3Ros+msDJZPsYYPKNvEpRV1pn7kOvBYT3/9+jOodbq9oDa5B4VWhhqIx
        iZBxZ9gTDvUDgPMX2WQz70MbAWFWAL9TliPuUgXTy3yrs28q1Et1VhT57JpPsJ25
        Y+qGXajCocedM013PSvSLIQXXVqNTkQJwpw4tX4ukiRV15TQY3CVVZ4iLgzwIZJ5
        Vl5jLSiIrU/N6+klyYQc1sxo2DJgcR2CQeyHPvruyqPtXvRI60DWdDwv7vBVuhlq
        6+4KrNqXguyC+HkFq/3kBY/V2qrPQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b724ab95 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 25 Jun 2019 07:45:35 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/2] timekeeping: rename fast getter functions to be consistent
Date:   Tue, 25 Jun 2019 10:19:12 +0200
Message-Id: <20190625081912.14813-3-Jason@zx2c4.com>
In-Reply-To: <20190625081912.14813-1-Jason@zx2c4.com>
References: <20190625081912.14813-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _fast_ family of functions put the _fast_ modifier in the wrong
place and confuse tai with clocktai and boot with boottime. Also, no
other functions use _mono, making that the default unlabeled one.
This commit normalizes these to match the rest of timekeeping.h.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/core-api/timekeeping.rst | 18 ++++++++--------
 Documentation/trace/ftrace.rst         |  2 +-
 drivers/base/power/runtime.c           | 12 +++++------
 drivers/gpu/drm/i915/i915_perf.c       |  2 +-
 fs/pstore/platform.c                   |  2 +-
 include/linux/pm_runtime.h             |  2 +-
 include/linux/timekeeping.h            | 24 ++++++++++-----------
 kernel/bpf/helpers.c                   |  2 +-
 kernel/debug/kdb/kdb_main.c            |  2 +-
 kernel/events/core.c                   |  4 ++--
 kernel/rcu/rcuperf.c                   |  6 +++---
 kernel/rcu/srcutree.c                  |  6 +++---
 kernel/time/timekeeping.c              | 30 +++++++++++++-------------
 kernel/trace/trace.c                   |  6 +++---
 kernel/watchdog_hld.c                  |  2 +-
 15 files changed, 60 insertions(+), 60 deletions(-)

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
index 29d38a86faac..3a9eac43f619 100644
--- a/Documentation/core-api/timekeeping.rst
+++ b/Documentation/core-api/timekeeping.rst
@@ -129,15 +129,15 @@ Some additional variants exist for more specialized cases:
 	up to several microseconds on older hardware with an external
 	clocksource.
 
-.. c:function:: ktime_t ktime_get_mono_fast( void )
-		ktime_t ktime_get_raw_fast( void )
-		ktime_t ktime_get_boottime_fast( void )
-		ktime_t ktime_get_real_fast( void )
-
-.. c:function:: u64 ktime_get_mono_fast_ns( void )
-		u64 ktime_get_raw_fast_ns( void )
-		u64 ktime_get_boot_fast_ns( void )
-		u64 ktime_get_real_fast_ns( void )
+.. c:function:: ktime_t ktime_get_fast( void )
+		ktime_t ktime_get_fast_raw( void )
+		ktime_t ktime_get_fast_boottime( void )
+		ktime_t ktime_get_fast_real( void )
+
+.. c:function:: u64 ktime_get_fast_ns( void )
+		u64 ktime_get_fast_raw_ns( void )
+		u64 ktime_get_fast_boottime_ns( void )
+		u64 ktime_get_fast_real_ns( void )
 
 	These variants are safe to call from any context, including from
 	a non-maskable interrupt (NMI) during a timekeeper update, and
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index f60079259669..6ec0e2a59419 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -482,7 +482,7 @@ of ftrace. Here is a list of some of the key files:
 		Also on 32-bit systems, it's possible that the 64-bit boot offset
 		sees a partial update. These effects are rare and post
 		processing should be able to handle them. See comments in the
-		ktime_get_boot_fast_ns() function for more information.
+		ktime_get_fast_boottime_ns() function for more information.
 
 	To set a clock, simply echo the clock name into this file::
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 952a1e7057c7..218bc89c20ba 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -71,11 +71,11 @@ static void update_pm_runtime_accounting(struct device *dev)
 
 	last = dev->power.accounting_timestamp;
 
-	now = ktime_get_mono_fast_ns();
+	now = ktime_get_fast_ns();
 	dev->power.accounting_timestamp = now;
 
 	/*
-	 * Because ktime_get_mono_fast_ns() is not monotonic during
+	 * Because ktime_get_fast_ns() is not monotonic during
 	 * timekeeping updates, ensure that 'now' is after the last saved
 	 * timesptamp.
 	 */
@@ -174,7 +174,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 
 	expires  = READ_ONCE(dev->power.last_busy);
 	expires += (u64)autosuspend_delay * NSEC_PER_MSEC;
-	if (expires > ktime_get_mono_fast_ns())
+	if (expires > ktime_get_fast_ns())
 		return expires;	/* Expires in the future */
 
 	return 0;
@@ -938,7 +938,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 	 * If 'expires' is after the current time, we've been called
 	 * too early.
 	 */
-	if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
+	if (expires > 0 && expires < ktime_get_fast_ns()) {
 		dev->power.timer_expires = 0;
 		rpm_suspend(dev, dev->power.timer_autosuspends ?
 		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
@@ -974,7 +974,7 @@ int pm_schedule_suspend(struct device *dev, unsigned int delay)
 	/* Other scheduled or pending requests need to be canceled. */
 	pm_runtime_cancel_pending(dev);
 
-	expires = ktime_get_mono_fast_ns() + (u64)delay * NSEC_PER_MSEC;
+	expires = ktime_get_fast_ns() + (u64)delay * NSEC_PER_MSEC;
 	dev->power.timer_expires = expires;
 	dev->power.timer_autosuspends = 0;
 	hrtimer_start(&dev->power.suspend_timer, expires, HRTIMER_MODE_ABS);
@@ -1378,7 +1378,7 @@ void pm_runtime_enable(struct device *dev)
 
 		/* About to enable runtime pm, set accounting_timestamp to now */
 		if (!dev->power.disable_depth)
-			dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
+			dev->power.accounting_timestamp = ktime_get_fast_ns();
 	} else {
 		dev_warn(dev, "Unbalanced %s!\n", __func__);
 	}
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index dc4ce694c06a..211b10cec5e2 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -478,7 +478,7 @@ static bool oa_buffer_check_unlocked(struct drm_i915_private *dev_priv)
 	 */
 	hw_tail &= ~(report_size - 1);
 
-	now = ktime_get_mono_fast_ns();
+	now = ktime_get_fast_ns();
 
 	/* Update the aged tail
 	 *
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 3d7024662d29..531e48d96096 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -378,7 +378,7 @@ void pstore_record_init(struct pstore_record *record,
 	record->psi = psinfo;
 
 	/* Report zeroed timestamp if called before timekeeping has resumed. */
-	record->time = ns_to_timespec64(ktime_get_real_fast_ns());
+	record->time = ns_to_timespec64(ktime_get_fast_real_ns());
 }
 
 /*
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 22af69d237a6..e904d93c6cfd 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -104,7 +104,7 @@ static inline bool pm_runtime_callbacks_present(struct device *dev)
 
 static inline void pm_runtime_mark_last_busy(struct device *dev)
 {
-	WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
+	WRITE_ONCE(dev->power.last_busy, ktime_get_fast_ns());
 }
 
 static inline bool pm_runtime_is_irq_safe(struct device *dev)
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index b8a3a129258c..e06a5989b7c5 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -174,29 +174,29 @@ static inline u64 ktime_get_raw_ns(void)
 	return ktime_to_ns(ktime_get_raw());
 }
 
-extern ktime_t ktime_get_mono_fast(void);
-extern ktime_t ktime_get_raw_fast(void);
-extern ktime_t ktime_get_boottime_fast(void);
-extern ktime_t ktime_get_real_fast(void);
+extern ktime_t ktime_get_fast(void);
+extern ktime_t ktime_get_fast_raw(void);
+extern ktime_t ktime_get_fast_boottime(void);
+extern ktime_t ktime_get_fast_real(void);
 
-static inline u64 ktime_get_mono_fast_ns(void)
+static inline u64 ktime_get_fast_ns(void)
 {
-	return ktime_to_ns(ktime_get_mono_fast());
+	return ktime_to_ns(ktime_get_fast());
 }
 
-static inline u64 ktime_get_raw_fast_ns(void)
+static inline u64 ktime_get_fast_raw_ns(void)
 {
-	return ktime_to_ns(ktime_get_raw_fast());
+	return ktime_to_ns(ktime_get_fast_raw());
 }
 
-static inline u64 ktime_get_boot_fast_ns(void)
+static inline u64 ktime_get_fast_boottime_ns(void)
 {
-	return ktime_to_ns(ktime_get_boottime_fast());
+	return ktime_to_ns(ktime_get_fast_boottime());
 }
 
-static inline u64 ktime_get_real_fast_ns(void)
+static inline u64 ktime_get_fast_real_ns(void)
 {
-	return ktime_to_ns(ktime_get_real_fast());
+	return ktime_to_ns(ktime_get_fast_real());
 }
 
 /*
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5e28718928ca..df3617962dfd 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -143,7 +143,7 @@ const struct bpf_func_proto bpf_get_numa_node_id_proto = {
 BPF_CALL_0(bpf_ktime_get_ns)
 {
 	/* NMI safe access to clock monotonic */
-	return ktime_get_mono_fast_ns();
+	return ktime_get_fast_ns();
 }
 
 const struct bpf_func_proto bpf_ktime_get_ns_proto = {
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 9ecfa37c7fbf..59dce544cfea 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2491,7 +2491,7 @@ static int kdb_kill(int argc, const char **argv)
  */
 static void kdb_sysinfo(struct sysinfo *val)
 {
-	u64 uptime = ktime_get_mono_fast_ns();
+	u64 uptime = ktime_get_fast_ns();
 
 	memset(val, 0, sizeof(*val));
 	val->uptime = div_u64(uptime, NSEC_PER_SEC);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e2d014395fc6..2f708be06aad 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10666,12 +10666,12 @@ static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
 
 	switch (clk_id) {
 	case CLOCK_MONOTONIC:
-		event->clock = &ktime_get_mono_fast_ns;
+		event->clock = &ktime_get_fast_ns;
 		nmi_safe = true;
 		break;
 
 	case CLOCK_MONOTONIC_RAW:
-		event->clock = &ktime_get_raw_fast_ns;
+		event->clock = &ktime_get_fast_raw_ns;
 		nmi_safe = true;
 		break;
 
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 7a6890b23c5f..665056894dea 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -375,7 +375,7 @@ rcu_perf_writer(void *arg)
 	if (holdoff)
 		schedule_timeout_uninterruptible(holdoff * HZ);
 
-	t = ktime_get_mono_fast_ns();
+	t = ktime_get_fast_ns();
 	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
 		t_rcu_perf_writer_started = t;
 		if (gp_exp) {
@@ -390,7 +390,7 @@ rcu_perf_writer(void *arg)
 		if (writer_holdoff)
 			udelay(writer_holdoff);
 		wdp = &wdpp[i];
-		*wdp = ktime_get_mono_fast_ns();
+		*wdp = ktime_get_fast_ns();
 		if (gp_async) {
 retry:
 			if (!rhp)
@@ -415,7 +415,7 @@ rcu_perf_writer(void *arg)
 			cur_ops->sync();
 		}
 		rcu_perf_writer_state = RTWS_IDLE;
-		t = ktime_get_mono_fast_ns();
+		t = ktime_get_fast_ns();
 		*wdp = t - *wdp;
 		i_max = i;
 		if (!started &&
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9b761e546de8..21e06a227e0a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -179,7 +179,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
 	init_srcu_struct_nodes(ssp, is_static);
 	ssp->srcu_gp_seq_needed_exp = 0;
-	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
+	ssp->srcu_last_gp_end = ktime_get_fast_ns();
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
 	return ssp->sda ? 0 : -ENOMEM;
 }
@@ -530,7 +530,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	idx = rcu_seq_state(ssp->srcu_gp_seq);
 	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
 	cbdelay = srcu_get_delay(ssp);
-	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
+	ssp->srcu_last_gp_end = ktime_get_fast_ns();
 	rcu_seq_end(&ssp->srcu_gp_seq);
 	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
@@ -779,7 +779,7 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	 */
 
 	/* First, see if enough time has passed since the last GP. */
-	t = ktime_get_mono_fast_ns();
+	t = ktime_get_fast_ns();
 	if (exp_holdoff == 0 ||
 	    time_in_range_open(t, ssp->srcu_last_gp_end,
 			       ssp->srcu_last_gp_end + exp_holdoff))
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index db0081a14b90..ae0ab8911e0c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -391,7 +391,7 @@ static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 c
  * So if a NMI hits the update of base[0] then it will use base[1]
  * which is still consistent. In the worst case this can result is a
  * slightly wrong timestamp (a few nanoseconds). See
- * @ktime_get_mono_fast_ns.
+ * @ktime_get_fast_ns.
  */
 static void update_fast_timekeeper(const struct tk_read_base *tkr,
 				   struct tk_fast *tkf)
@@ -412,7 +412,7 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
 }
 
 /**
- * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
+ * ktime_get_fast_ns - Fast NMI safe access to clock monotonic
  *
  * This timestamp is not guaranteed to be monotonic across an update.
  * The timestamp is calculated by:
@@ -463,20 +463,20 @@ static __always_inline ktime_t __ktime_get_fast(struct tk_fast *tkf)
 	return now;
 }
 
-ktime_t ktime_get_mono_fast(void)
+ktime_t ktime_get_fast(void)
 {
 	return __ktime_get_fast(&tk_fast_mono);
 }
-EXPORT_SYMBOL_GPL(ktime_get_mono_fast);
+EXPORT_SYMBOL_GPL(ktime_get_fast);
 
-ktime_t ktime_get_raw_fast(void)
+ktime_t ktime_get_fast_raw(void)
 {
 	return __ktime_get_fast(&tk_fast_raw);
 }
-EXPORT_SYMBOL_GPL(ktime_get_raw_fast);
+EXPORT_SYMBOL_GPL(ktime_get_fast_raw);
 
 /**
- * ktime_get_boottime_fast - NMI safe and fast access to boot clock.
+ * ktime_get_fast_boottime - NMI safe and fast access to boot clock.
  *
  * To keep it NMI safe since we're accessing from tracing, we're not using a
  * separate timekeeper with updates to monotonic clock and boot offset
@@ -496,19 +496,19 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast);
  * partially updated.  Since the tk->offs_boot update is a rare event, this
  * should be a rare occurrence which postprocessing should be able to handle.
  */
-ktime_t notrace ktime_get_boottime_fast(void)
+ktime_t notrace ktime_get_fast_boottime(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 
-	return ktime_add(ktime_get_mono_fast(), tk->offs_boot);
+	return ktime_add(ktime_get_fast(), tk->offs_boot);
 }
-EXPORT_SYMBOL_GPL(ktime_get_boottime_fast);
+EXPORT_SYMBOL_GPL(ktime_get_fast_boottime);
 
 
 /*
  * See comment for __ktime_get_fast() vs. timestamp ordering
  */
-static __always_inline ktime_t __ktime_get_real_fast(struct tk_fast *tkf)
+static __always_inline ktime_t __ktime_get_fast_real(struct tk_fast *tkf)
 {
 	struct tk_read_base *tkr;
 	unsigned int seq;
@@ -529,13 +529,13 @@ static __always_inline ktime_t __ktime_get_real_fast(struct tk_fast *tkf)
 }
 
 /**
- * ktime_get_real_fast: - NMI safe and fast access to clock realtime.
+ * ktime_get_fast_real: - NMI safe and fast access to clock realtime.
  */
-ktime_t ktime_get_real_fast(void)
+ktime_t ktime_get_fast_real(void)
 {
-	return __ktime_get_real_fast(&tk_fast_mono);
+	return __ktime_get_fast_real(&tk_fast_mono);
 }
-EXPORT_SYMBOL_GPL(ktime_get_real_fast);
+EXPORT_SYMBOL_GPL(ktime_get_fast_real);
 
 /**
  * halt_fast_timekeeper - Prevent fast timekeeper from accessing clocksource.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 83e08b78dbee..840a4d024015 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1336,9 +1336,9 @@ static struct {
 	{ trace_clock_counter,		"counter",	0 },
 	{ trace_clock_jiffies,		"uptime",	0 },
 	{ trace_clock,			"perf",		1 },
-	{ ktime_get_mono_fast_ns,	"mono",		1 },
-	{ ktime_get_raw_fast_ns,	"mono_raw",	1 },
-	{ ktime_get_boot_fast_ns,	"boot",		1 },
+	{ ktime_get_fast_ns,		"mono",		1 },
+	{ ktime_get_fast_raw_ns,	"mono_raw",	1 },
+	{ ktime_get_fast_boottime_ns,	"boot",		1 },
 	ARCH_TRACE_CLOCKS
 };
 
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..044fc850b9a9 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -75,7 +75,7 @@ void watchdog_update_hrtimer_threshold(u64 period)
 
 static bool watchdog_check_timestamp(void)
 {
-	ktime_t delta, now = ktime_get_mono_fast_ns();
+	ktime_t delta, now = ktime_get_fast_ns();
 
 	delta = now - __this_cpu_read(last_timestamp);
 	if (delta < watchdog_hrtimer_sample_threshold) {
-- 
2.21.0

