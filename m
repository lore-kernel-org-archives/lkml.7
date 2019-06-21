Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ABCC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F6C20449
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="y867cxr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfFUPGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:06:01 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:40599 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfFUPGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:06:00 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 6421f68f;
        Fri, 21 Jun 2019 14:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=QimAawYOkkUQgMpPGIbkj2w4T
        JA=; b=y867cxr+IgHYRLzmpnZSAackASsz87ucMoU+GvpT68HehRPa9yUEV7iQk
        jfrsFPpZambamdKqMzdTup4PUhbLn5gknT+oxo/92KPsftJWaglcQHdrI71ekLZU
        BKm8cvOf0CBn3Iz0B1asWlUiVAqFnnUJLU3op8c/vty0e522b8LPJkDn6eKhNdAa
        C1JL/Tml9pNrRLxpfsEej5gbOX1XELm8HN9SIPR8qGAmhHQKyGT6flZHVgaTQpk6
        cECcbd9UQZ+qHj2gDuD0SGs6863qBxd0Ozw5q6oHEXd4zcIy4Tg8SqaPwBhkrdiA
        y6TGFiMqsOnmAtTFuvq00uqPx9QKA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0a4cd6d0 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 21 Jun 2019 14:32:31 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 4/4] timekeeping: rename getter functions to be consistent and intuitive
Date:   Fri, 21 Jun 2019 17:05:21 +0200
Message-Id: <20190621150521.17687-4-Jason@zx2c4.com>
In-Reply-To: <20190621150521.17687-1-Jason@zx2c4.com>
References: <20190621150521.17687-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several functions have been added, which all tried to conform to the
function signature of their nearest neighbor, but those neighbors were
also inconsistent with still others. This commit unifies things globally
and adopts a more intuitive adjective ordering. The set of
transformations are:

    s/ktime_get_boot_coarse_ns/ktime_get_boottime_coarse_ns/g
    s/ktime_get_boot_fast_ns/ktime_get_boottime_fast_ns/g
    s/ktime_get_boot_ns/ktime_get_boottime_ns/g
    s/ktime_get_tai_coarse_ns/ktime_get_clocktai_coarse_ns/g
    s/ktime_get_tai_fast_ns/ktime_get_clocktai_fast_ns/g
    s/ktime_get_tai_ns/ktime_get_clocktai_ns/g
    s/ktime_get_\([^_]\+\)_coarse/ktime_get_coarse_\1/g
    s/ktime_get_\([^_]\+\)_fast/ktime_get_fast_\1/g

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/core-api/timekeeping.rst        | 24 ++++++-------
 Documentation/trace/ftrace.rst                |  2 +-
 arch/x86/kvm/pmu.c                            |  4 +--
 arch/x86/kvm/x86.c                            | 12 +++----
 drivers/base/power/runtime.c                  | 12 +++----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 drivers/gpu/drm/i915/i915_perf.c              |  2 +-
 drivers/iio/humidity/dht11.c                  |  8 ++---
 drivers/iio/industrialio-core.c               |  4 +--
 drivers/infiniband/hw/mlx4/alias_GUID.c       |  6 ++--
 drivers/leds/trigger/ledtrig-activity.c       |  2 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  2 +-
 drivers/net/wireless/mac80211_hwsim.c         |  2 +-
 drivers/net/wireless/ti/wlcore/main.c         |  2 +-
 drivers/net/wireless/ti/wlcore/rx.c           |  2 +-
 drivers/net/wireless/ti/wlcore/tx.c           |  2 +-
 drivers/net/wireless/virt_wifi.c              |  2 +-
 fs/pstore/platform.c                          |  2 +-
 include/linux/pm_runtime.h                    |  2 +-
 include/linux/timekeeping.h                   | 34 +++++++++---------
 include/net/cfg80211.h                        |  2 +-
 kernel/bpf/helpers.c                          |  2 +-
 kernel/bpf/syscall.c                          |  2 +-
 kernel/debug/kdb/kdb_main.c                   |  2 +-
 kernel/events/core.c                          |  8 ++---
 kernel/fork.c                                 |  2 +-
 kernel/rcu/rcuperf.c                          |  6 ++--
 kernel/rcu/srcutree.c                         |  6 ++--
 kernel/time/timekeeping.c                     | 36 +++++++++----------
 kernel/trace/trace.c                          |  6 ++--
 kernel/watchdog_hld.c                         |  2 +-
 34 files changed, 104 insertions(+), 104 deletions(-)

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
index 0d4019fcaa87..554d20b71a1e 100644
--- a/Documentation/core-api/timekeeping.rst
+++ b/Documentation/core-api/timekeeping.rst
@@ -65,7 +65,7 @@ different format depending on what is required by the user:
 .. c:function:: u64 ktime_get_ns( void )
 		u64 ktime_get_boottime_ns( void )
 		u64 ktime_get_real_ns( void )
-		u64 ktime_get_tai_ns( void )
+		u64 ktime_get_clocktai_ns( void )
 		u64 ktime_get_raw_ns( void )
 
 	Same as the plain ktime_get functions, but returning a u64 number
@@ -105,9 +105,9 @@ Some additional variants exist for more specialized cases:
 		ktime_t ktime_get_coarse_clocktai( void )
 
 .. c:function:: u64 ktime_get_coarse_ns( void )
-		u64 ktime_get_boot_coarse_ns( void )
-		u64 ktime_get_real_coarse_ns( void )
-		u64 ktime_get_tai_coarse_ns( void )
+		u64 ktime_get_coarse_boottime_ns( void )
+		u64 ktime_get_coarse_real_ns( void )
+		u64 ktime_get_coarse_clocktai_ns( void )
 
 .. c:function:: void ktime_get_coarse_ts64( struct timespec64 * )
 		void ktime_get_coarse_boottime_ts64( struct timespec64 * )
@@ -129,15 +129,15 @@ Some additional variants exist for more specialized cases:
 	up to several microseconds on older hardware with an external
 	clocksource.
 
-.. c:function:: ktime_t ktime_get_mono_fast( void )
-		ktime_t ktime_get_raw_fast( void )
-		ktime_t ktime_get_boottime_fast( void )
-		ktime_t ktime_get_real_fast( void )
+.. c:function:: ktime_t ktime_get_fast_mono( void )
+		ktime_t ktime_get_fast_raw( void )
+		ktime_t ktime_get_fast_boottime( void )
+		ktime_t ktime_get_fast_real( void )
 
-.. c:function:: u64 ktime_get_mono_fast_ns( void )
-		u64 ktime_get_raw_fast_ns( void )
-		u64 ktime_get_boot_fast_ns( void )
-		u64 ktime_get_real_fast_ns( void )
+.. c:function:: u64 ktime_get_fast_mono_ns( void )
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
 
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index dd745b58ffd8..1aea628ef6b8 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -264,10 +264,10 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 		ctr_val = rdtsc();
 		break;
 	case VMWARE_BACKDOOR_PMC_REAL_TIME:
-		ctr_val = ktime_get_boot_ns();
+		ctr_val = ktime_get_boottime_ns();
 		break;
 	case VMWARE_BACKDOOR_PMC_APPARENT_TIME:
-		ctr_val = ktime_get_boot_ns() +
+		ctr_val = ktime_get_boottime_ns() +
 			vcpu->kvm->arch.kvmclock_offset;
 		break;
 	default:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 83aefd759846..81a0914a1ec1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1731,7 +1731,7 @@ void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr)
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
 	offset = kvm_compute_tsc_offset(vcpu, data);
-	ns = ktime_get_boot_ns();
+	ns = ktime_get_boottime_ns();
 	elapsed = ns - kvm->arch.last_tsc_nsec;
 
 	if (vcpu->arch.virtual_tsc_khz) {
@@ -2073,7 +2073,7 @@ u64 get_kvmclock_ns(struct kvm *kvm)
 	spin_lock(&ka->pvclock_gtod_sync_lock);
 	if (!ka->use_master_clock) {
 		spin_unlock(&ka->pvclock_gtod_sync_lock);
-		return ktime_get_boot_ns() + ka->kvmclock_offset;
+		return ktime_get_boottime_ns() + ka->kvmclock_offset;
 	}
 
 	hv_clock.tsc_timestamp = ka->master_cycle_now;
@@ -2089,7 +2089,7 @@ u64 get_kvmclock_ns(struct kvm *kvm)
 				   &hv_clock.tsc_to_system_mul);
 		ret = __pvclock_read_cycles(&hv_clock, rdtsc());
 	} else
-		ret = ktime_get_boot_ns() + ka->kvmclock_offset;
+		ret = ktime_get_boottime_ns() + ka->kvmclock_offset;
 
 	put_cpu();
 
@@ -2188,7 +2188,7 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
 	}
 	if (!use_master_clock) {
 		host_tsc = rdtsc();
-		kernel_ns = ktime_get_boot_ns();
+		kernel_ns = ktime_get_boottime_ns();
 	}
 
 	tsc_timestamp = kvm_read_l1_tsc(v, host_tsc);
@@ -9018,7 +9018,7 @@ int kvm_arch_hardware_enable(void)
 	 * before any KVM threads can be running.  Unfortunately, we can't
 	 * bring the TSCs fully up to date with real time, as we aren't yet far
 	 * enough into CPU bringup that we know how much real time has actually
-	 * elapsed; our helper function, ktime_get_boot_ns() will be using boot
+	 * elapsed; our helper function, ktime_get_boottime_ns() will be using boot
 	 * variables that haven't been updated yet.
 	 *
 	 * So we simply find the maximum observed TSC above, then record the
@@ -9246,7 +9246,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	mutex_init(&kvm->arch.apic_map_lock);
 	spin_lock_init(&kvm->arch.pvclock_gtod_sync_lock);
 
-	kvm->arch.kvmclock_offset = -ktime_get_boot_ns();
+	kvm->arch.kvmclock_offset = -ktime_get_boottime_ns();
 	pvclock_update_vm_gtod_copy(kvm);
 
 	kvm->arch.guest_can_read_msr_platform_info = true;
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 952a1e7057c7..de9beb6b46ef 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -71,11 +71,11 @@ static void update_pm_runtime_accounting(struct device *dev)
 
 	last = dev->power.accounting_timestamp;
 
-	now = ktime_get_mono_fast_ns();
+	now = ktime_get_fast_mono_ns();
 	dev->power.accounting_timestamp = now;
 
 	/*
-	 * Because ktime_get_mono_fast_ns() is not monotonic during
+	 * Because ktime_get_fast_mono_ns() is not monotonic during
 	 * timekeeping updates, ensure that 'now' is after the last saved
 	 * timesptamp.
 	 */
@@ -174,7 +174,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 
 	expires  = READ_ONCE(dev->power.last_busy);
 	expires += (u64)autosuspend_delay * NSEC_PER_MSEC;
-	if (expires > ktime_get_mono_fast_ns())
+	if (expires > ktime_get_fast_mono_ns())
 		return expires;	/* Expires in the future */
 
 	return 0;
@@ -938,7 +938,7 @@ static enum hrtimer_restart  pm_suspend_timer_fn(struct hrtimer *timer)
 	 * If 'expires' is after the current time, we've been called
 	 * too early.
 	 */
-	if (expires > 0 && expires < ktime_get_mono_fast_ns()) {
+	if (expires > 0 && expires < ktime_get_fast_mono_ns()) {
 		dev->power.timer_expires = 0;
 		rpm_suspend(dev, dev->power.timer_autosuspends ?
 		    (RPM_ASYNC | RPM_AUTO) : RPM_ASYNC);
@@ -974,7 +974,7 @@ int pm_schedule_suspend(struct device *dev, unsigned int delay)
 	/* Other scheduled or pending requests need to be canceled. */
 	pm_runtime_cancel_pending(dev);
 
-	expires = ktime_get_mono_fast_ns() + (u64)delay * NSEC_PER_MSEC;
+	expires = ktime_get_fast_mono_ns() + (u64)delay * NSEC_PER_MSEC;
 	dev->power.timer_expires = expires;
 	dev->power.timer_autosuspends = 0;
 	hrtimer_start(&dev->power.suspend_timer, expires, HRTIMER_MODE_ABS);
@@ -1378,7 +1378,7 @@ void pm_runtime_enable(struct device *dev)
 
 		/* About to enable runtime pm, set accounting_timestamp to now */
 		if (!dev->power.disable_depth)
-			dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
+			dev->power.accounting_timestamp = ktime_get_fast_mono_ns();
 	} else {
 		dev_warn(dev, "Unbalanced %s!\n", __func__);
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 083bd8114db1..dd6b4b0b5f30 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -837,7 +837,7 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
 
 	/* No access to rdtsc. Using raw monotonic time */
 	args->cpu_clock_counter = ktime_get_raw_ns();
-	args->system_clock_counter = ktime_get_boot_ns();
+	args->system_clock_counter = ktime_get_boottime_ns();
 
 	/* Since the counter is in nano-seconds we use 1GHz frequency */
 	args->system_clock_freq = 1000000000;
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index dc4ce694c06a..8784d8b0fdfd 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -478,7 +478,7 @@ static bool oa_buffer_check_unlocked(struct drm_i915_private *dev_priv)
 	 */
 	hw_tail &= ~(report_size - 1);
 
-	now = ktime_get_mono_fast_ns();
+	now = ktime_get_fast_mono_ns();
 
 	/* Update the aged tail
 	 *
diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index c8159205c77d..4e22b3c3e488 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -149,7 +149,7 @@ static int dht11_decode(struct dht11 *dht11, int offset)
 		return -EIO;
 	}
 
-	dht11->timestamp = ktime_get_boot_ns();
+	dht11->timestamp = ktime_get_boottime_ns();
 	if (hum_int < 4) {  /* DHT22: 100000 = (3*256+232)*100 */
 		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
 					((temp_int & 0x80) ? -100 : 100);
@@ -177,7 +177,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
 
 	/* TODO: Consider making the handler safe for IRQ sharing */
 	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
-		dht11->edges[dht11->num_edges].ts = ktime_get_boot_ns();
+		dht11->edges[dht11->num_edges].ts = ktime_get_boottime_ns();
 		dht11->edges[dht11->num_edges++].value =
 						gpio_get_value(dht11->gpio);
 
@@ -196,7 +196,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 	int ret, timeres, offset;
 
 	mutex_lock(&dht11->lock);
-	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_boot_ns()) {
+	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_boottime_ns()) {
 		timeres = ktime_get_resolution_ns();
 		dev_dbg(dht11->dev, "current timeresolution: %dns\n", timeres);
 		if (timeres > DHT11_MIN_TIMERES) {
@@ -322,7 +322,7 @@ static int dht11_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	dht11->timestamp = ktime_get_boot_ns() - DHT11_DATA_VALID_TIME - 1;
+	dht11->timestamp = ktime_get_boottime_ns() - DHT11_DATA_VALID_TIME - 1;
 	dht11->num_edges = -1;
 
 	platform_set_drvdata(pdev, iio);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f5a4581302f4..16008f862d19 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -231,9 +231,9 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev)
 		ktime_get_coarse_ts64(&tp);
 		return timespec64_to_ns(&tp);
 	case CLOCK_BOOTTIME:
-		return ktime_get_boot_ns();
+		return ktime_get_boottime_ns();
 	case CLOCK_TAI:
-		return ktime_get_tai_ns();
+		return ktime_get_clocktai_ns();
 	default:
 		BUG();
 	}
diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index 2a0b59a4b6eb..cca414ecfcd5 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -310,7 +310,7 @@ static void aliasguid_query_handler(int status,
 	if (status) {
 		pr_debug("(port: %d) failed: status = %d\n",
 			 cb_ctx->port, status);
-		rec->time_to_run = ktime_get_boot_ns() + 1 * NSEC_PER_SEC;
+		rec->time_to_run = ktime_get_boottime_ns() + 1 * NSEC_PER_SEC;
 		goto out;
 	}
 
@@ -416,7 +416,7 @@ static void aliasguid_query_handler(int status,
 			 be64_to_cpu((__force __be64)rec->guid_indexes),
 			 be64_to_cpu((__force __be64)applied_guid_indexes),
 			 be64_to_cpu((__force __be64)declined_guid_indexes));
-		rec->time_to_run = ktime_get_boot_ns() +
+		rec->time_to_run = ktime_get_boottime_ns() +
 			resched_delay_sec * NSEC_PER_SEC;
 	} else {
 		rec->status = MLX4_GUID_INFO_STATUS_SET;
@@ -709,7 +709,7 @@ static int get_low_record_time_index(struct mlx4_ib_dev *dev, u8 port,
 		}
 	}
 	if (resched_delay_sec) {
-		u64 curr_time = ktime_get_boot_ns();
+		u64 curr_time = ktime_get_boottime_ns();
 
 		*resched_delay_sec = (low_record_time < curr_time) ? 0 :
 			div_u64((low_record_time - curr_time), NSEC_PER_SEC);
diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
index bcbf41c90c30..0f130dd998b3 100644
--- a/drivers/leds/trigger/ledtrig-activity.c
+++ b/drivers/leds/trigger/ledtrig-activity.c
@@ -73,7 +73,7 @@ static void led_activity_function(struct timer_list *t)
 	 * down to 16us, ensuring we won't overflow 32-bit computations below
 	 * even up to 3k CPUs, while keeping divides cheap on smaller systems.
 	 */
-	curr_boot = ktime_get_boot_ns() * cpus;
+	curr_boot = ktime_get_boottime_ns() * cpus;
 	diff_boot = (curr_boot - activity_data->last_boot) >> 16;
 	diff_used = (curr_used - activity_data->last_used) >> 16;
 	activity_data->last_boot = curr_boot;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index fec38a47696e..9f4b117db9d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -93,7 +93,7 @@ void iwl_mvm_ftm_restart(struct iwl_mvm *mvm)
 	struct cfg80211_pmsr_result result = {
 		.status = NL80211_PMSR_STATUS_FAILURE,
 		.final = 1,
-		.host_time = ktime_get_boot_ns(),
+		.host_time = ktime_get_boottime_ns(),
 		.type = NL80211_PMSR_TYPE_FTM,
 	};
 	int i;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index fbd3014e8b82..160b0db27103 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -555,7 +555,7 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	if (unlikely(ieee80211_is_beacon(hdr->frame_control) ||
 		     ieee80211_is_probe_resp(hdr->frame_control)))
-		rx_status->boottime_ns = ktime_get_boot_ns();
+		rx_status->boottime_ns = ktime_get_boottime_ns();
 
 	/* Take a reference briefly to kick off a d0i3 entry delay so
 	 * we can handle bursts of RX packets without toggling the
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 1824566d08fc..64f950501287 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1684,7 +1684,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 		if (unlikely(ieee80211_is_beacon(hdr->frame_control) ||
 			     ieee80211_is_probe_resp(hdr->frame_control)))
-			rx_status->boottime_ns = ktime_get_boot_ns();
+			rx_status->boottime_ns = ktime_get_boottime_ns();
 	}
 
 	if (iwl_mvm_create_skb(mvm, skb, hdr, len, crypt_len, rxb)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index cc56ab88fb43..72cd5b3f2d8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1445,7 +1445,7 @@ void iwl_mvm_get_sync_time(struct iwl_mvm *mvm, u32 *gp2, u64 *boottime)
 	}
 
 	*gp2 = iwl_mvm_get_systime(mvm);
-	*boottime = ktime_get_boot_ns();
+	*boottime = ktime_get_boottime_ns();
 
 	if (!ps_disabled) {
 		mvm->ps_disabled = ps_disabled;
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index b5274d1f30fa..3233f5dd6797 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1274,7 +1274,7 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	 */
 	if (ieee80211_is_beacon(hdr->frame_control) ||
 	    ieee80211_is_probe_resp(hdr->frame_control)) {
-		rx_status.boottime_ns = ktime_get_boot_ns();
+		rx_status.boottime_ns = ktime_get_boottime_ns();
 		now = data->abs_bcn_ts;
 	} else {
 		now = mac80211_hwsim_get_tsf_raw();
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index c9a485ecee7b..b74dc8bc9755 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -483,7 +483,7 @@ static int wlcore_fw_status(struct wl1271 *wl, struct wl_fw_status *status)
 	}
 
 	/* update the host-chipset time offset */
-	wl->time_offset = (ktime_get_boot_ns() >> 10) -
+	wl->time_offset = (ktime_get_boottime_ns() >> 10) -
 		(s64)(status->fw_localtime);
 
 	wl->fw_fast_lnk_map = status->link_fast_bitmap;
diff --git a/drivers/net/wireless/ti/wlcore/rx.c b/drivers/net/wireless/ti/wlcore/rx.c
index d96bb602fae6..307fab21050b 100644
--- a/drivers/net/wireless/ti/wlcore/rx.c
+++ b/drivers/net/wireless/ti/wlcore/rx.c
@@ -93,7 +93,7 @@ static void wl1271_rx_status(struct wl1271 *wl,
 	}
 
 	if (beacon || probe_rsp)
-		status->boottime_ns = ktime_get_boot_ns();
+		status->boottime_ns = ktime_get_boottime_ns();
 
 	if (beacon)
 		wlcore_set_pending_regdomain_ch(wl, (u16)desc->channel,
diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
index 057c6be330e7..90e56d4c3df3 100644
--- a/drivers/net/wireless/ti/wlcore/tx.c
+++ b/drivers/net/wireless/ti/wlcore/tx.c
@@ -273,7 +273,7 @@ static void wl1271_tx_fill_hdr(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 	}
 
 	/* configure packet life time */
-	hosttime = (ktime_get_boot_ns() >> 10);
+	hosttime = (ktime_get_boottime_ns() >> 10);
 	desc->start_time = cpu_to_le32(hosttime - wl->time_offset);
 
 	is_dummy = wl12xx_is_dummy_packet(wl, skb);
diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index 606999f102eb..be92e1220284 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -172,7 +172,7 @@ static void virt_wifi_scan_result(struct work_struct *work)
 	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
 					   CFG80211_BSS_FTYPE_PRESP,
 					   fake_router_bssid,
-					   ktime_get_boot_ns(),
+					   ktime_get_boottime_ns(),
 					   WLAN_CAPABILITY_ESS, 0,
 					   (void *)&ssid, sizeof(ssid),
 					   DBM_TO_MBM(-50), GFP_KERNEL);
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
index 22af69d237a6..7542bde4ce42 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -104,7 +104,7 @@ static inline bool pm_runtime_callbacks_present(struct device *dev)
 
 static inline void pm_runtime_mark_last_busy(struct device *dev)
 {
-	WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
+	WRITE_ONCE(dev->power.last_busy, ktime_get_fast_mono_ns());
 }
 
 static inline bool pm_runtime_is_irq_safe(struct device *dev)
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 3df8e63c704b..7fe5cdc156ea 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -125,17 +125,17 @@ static inline u64 ktime_get_coarse_ns(void)
 	return ktime_to_ns(ktime_get_coarse());
 }
 
-static inline u64 ktime_get_real_coarse_ns(void)
+static inline u64 ktime_get_coarse_real_ns(void)
 {
 	return ktime_to_ns(ktime_get_coarse_real());
 }
 
-static inline u64 ktime_get_boot_coarse_ns(void)
+static inline u64 ktime_get_coarse_boottime_ns(void)
 {
 	return ktime_to_ns(ktime_get_coarse_boottime());
 }
 
-static inline u64 ktime_get_tai_coarse_ns(void)
+static inline u64 ktime_get_coarse_clocktai_ns(void)
 {
 	return ktime_to_ns(ktime_get_coarse_clocktai());
 }
@@ -158,12 +158,12 @@ static inline u64 ktime_get_real_ns(void)
 	return ktime_to_ns(ktime_get_real());
 }
 
-static inline u64 ktime_get_boot_ns(void)
+static inline u64 ktime_get_boottime_ns(void)
 {
 	return ktime_to_ns(ktime_get_boottime());
 }
 
-static inline u64 ktime_get_tai_ns(void)
+static inline u64 ktime_get_clocktai_ns(void)
 {
 	return ktime_to_ns(ktime_get_clocktai());
 }
@@ -173,29 +173,29 @@ static inline u64 ktime_get_raw_ns(void)
 	return ktime_to_ns(ktime_get_raw());
 }
 
-extern ktime_t ktime_get_mono_fast(void);
-extern ktime_t ktime_get_raw_fast(void);
-extern ktime_t ktime_get_boottime_fast(void);
-extern ktime_t ktime_get_real_fast(void);
+extern ktime_t ktime_get_fast_mono(void);
+extern ktime_t ktime_get_fast_raw(void);
+extern ktime_t ktime_get_fast_boottime(void);
+extern ktime_t ktime_get_fast_real(void);
 
-static inline u64 ktime_get_mono_fast_ns(void)
+static inline u64 ktime_get_fast_mono_ns(void)
 {
-	return ktime_to_ns(ktime_get_mono_fast());
+	return ktime_to_ns(ktime_get_fast_mono());
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
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 948139690a58..9d225e56777d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2010,7 +2010,7 @@ enum cfg80211_signal_type {
  *	received by the device (not just by the host, in case it was
  *	buffered on the device) and be accurate to about 10ms.
  *	If the frame isn't buffered, just passing the return value of
- *	ktime_get_boot_ns() is likely appropriate.
+ *	ktime_get_boottime_ns() is likely appropriate.
  * @parent_tsf: the time at the start of reception of the first octet of the
  *	timestamp field of the frame. The time is the TSF of the BSS specified
  *	by %parent_bssid.
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5e28718928ca..787441353176 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -143,7 +143,7 @@ const struct bpf_func_proto bpf_get_numa_node_id_proto = {
 BPF_CALL_0(bpf_ktime_get_ns)
 {
 	/* NMI safe access to clock monotonic */
-	return ktime_get_mono_fast_ns();
+	return ktime_get_fast_mono_ns();
 }
 
 const struct bpf_func_proto bpf_ktime_get_ns_proto = {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 42d17f730780..5b30f8baaf02 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1668,7 +1668,7 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 	if (err < 0)
 		goto free_prog;
 
-	prog->aux->load_time = ktime_get_boot_ns();
+	prog->aux->load_time = ktime_get_boottime_ns();
 	err = bpf_obj_name_cpy(prog->aux->name, attr->prog_name);
 	if (err)
 		goto free_prog;
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 9ecfa37c7fbf..7d5e32a3e629 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2491,7 +2491,7 @@ static int kdb_kill(int argc, const char **argv)
  */
 static void kdb_sysinfo(struct sysinfo *val)
 {
-	u64 uptime = ktime_get_mono_fast_ns();
+	u64 uptime = ktime_get_fast_mono_ns();
 
 	memset(val, 0, sizeof(*val));
 	val->uptime = div_u64(uptime, NSEC_PER_SEC);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..7efb854b1a64 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10666,12 +10666,12 @@ static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
 
 	switch (clk_id) {
 	case CLOCK_MONOTONIC:
-		event->clock = &ktime_get_mono_fast_ns;
+		event->clock = &ktime_get_fast_mono_ns;
 		nmi_safe = true;
 		break;
 
 	case CLOCK_MONOTONIC_RAW:
-		event->clock = &ktime_get_raw_fast_ns;
+		event->clock = &ktime_get_fast_raw_ns;
 		nmi_safe = true;
 		break;
 
@@ -10680,11 +10680,11 @@ static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
 		break;
 
 	case CLOCK_BOOTTIME:
-		event->clock = &ktime_get_boot_ns;
+		event->clock = &ktime_get_boottime_ns;
 		break;
 
 	case CLOCK_TAI:
-		event->clock = &ktime_get_tai_ns;
+		event->clock = &ktime_get_clocktai_ns;
 		break;
 
 	default:
diff --git a/kernel/fork.c b/kernel/fork.c
index 75675b9bf6df..4722f1a320bf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2139,7 +2139,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 
 	p->start_time = ktime_get_ns();
-	p->real_start_time = ktime_get_boot_ns();
+	p->real_start_time = ktime_get_boottime_ns();
 
 	/*
 	 * Make it visible to the rest of the system, but dont wake it up yet.
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 7a6890b23c5f..b74c78ea00a7 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -375,7 +375,7 @@ rcu_perf_writer(void *arg)
 	if (holdoff)
 		schedule_timeout_uninterruptible(holdoff * HZ);
 
-	t = ktime_get_mono_fast_ns();
+	t = ktime_get_fast_mono_ns();
 	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
 		t_rcu_perf_writer_started = t;
 		if (gp_exp) {
@@ -390,7 +390,7 @@ rcu_perf_writer(void *arg)
 		if (writer_holdoff)
 			udelay(writer_holdoff);
 		wdp = &wdpp[i];
-		*wdp = ktime_get_mono_fast_ns();
+		*wdp = ktime_get_fast_mono_ns();
 		if (gp_async) {
 retry:
 			if (!rhp)
@@ -415,7 +415,7 @@ rcu_perf_writer(void *arg)
 			cur_ops->sync();
 		}
 		rcu_perf_writer_state = RTWS_IDLE;
-		t = ktime_get_mono_fast_ns();
+		t = ktime_get_fast_mono_ns();
 		*wdp = t - *wdp;
 		i_max = i;
 		if (!started &&
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9b761e546de8..8892e40043cc 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -179,7 +179,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
 	init_srcu_struct_nodes(ssp, is_static);
 	ssp->srcu_gp_seq_needed_exp = 0;
-	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
+	ssp->srcu_last_gp_end = ktime_get_fast_mono_ns();
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
 	return ssp->sda ? 0 : -ENOMEM;
 }
@@ -530,7 +530,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	idx = rcu_seq_state(ssp->srcu_gp_seq);
 	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
 	cbdelay = srcu_get_delay(ssp);
-	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
+	ssp->srcu_last_gp_end = ktime_get_fast_mono_ns();
 	rcu_seq_end(&ssp->srcu_gp_seq);
 	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
@@ -779,7 +779,7 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	 */
 
 	/* First, see if enough time has passed since the last GP. */
-	t = ktime_get_mono_fast_ns();
+	t = ktime_get_fast_mono_ns();
 	if (exp_holdoff == 0 ||
 	    time_in_range_open(t, ssp->srcu_last_gp_end,
 			       ssp->srcu_last_gp_end + exp_holdoff))
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index db0081a14b90..14c3a05b1857 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -391,7 +391,7 @@ static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 c
  * So if a NMI hits the update of base[0] then it will use base[1]
  * which is still consistent. In the worst case this can result is a
  * slightly wrong timestamp (a few nanoseconds). See
- * @ktime_get_mono_fast_ns.
+ * @ktime_get_fast_mono_ns.
  */
 static void update_fast_timekeeper(const struct tk_read_base *tkr,
 				   struct tk_fast *tkf)
@@ -412,7 +412,7 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
 }
 
 /**
- * ktime_get_mono_fast_ns - Fast NMI safe access to clock monotonic
+ * ktime_get_fast_mono_ns - Fast NMI safe access to clock monotonic
  *
  * This timestamp is not guaranteed to be monotonic across an update.
  * The timestamp is calculated by:
@@ -443,7 +443,7 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
  * of the following timestamps. Callers need to be aware of that and
  * deal with it.
  */
-static __always_inline ktime_t __ktime_get_fast(struct tk_fast *tkf)
+static __always_inline ktime_t __ktime_get_fast_fast(struct tk *tkf)
 {
 	struct tk_read_base *tkr;
 	unsigned int seq;
@@ -463,20 +463,20 @@ static __always_inline ktime_t __ktime_get_fast(struct tk_fast *tkf)
 	return now;
 }
 
-ktime_t ktime_get_mono_fast(void)
+ktime_t ktime_get_fast_mono(void)
 {
-	return __ktime_get_fast(&tk_fast_mono);
+	return __ktime_get_fast_fast(&tk_mono);
 }
-EXPORT_SYMBOL_GPL(ktime_get_mono_fast);
+EXPORT_SYMBOL_GPL(ktime_get_fast_mono);
 
-ktime_t ktime_get_raw_fast(void)
+ktime_t ktime_get_fast_raw(void)
 {
-	return __ktime_get_fast(&tk_fast_raw);
+	return __ktime_get_fast_fast(&tk_raw);
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
+	return ktime_add(ktime_get_fast_mono(), tk->offs_boot);
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
index 83e08b78dbee..f9c085583b83 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1336,9 +1336,9 @@ static struct {
 	{ trace_clock_counter,		"counter",	0 },
 	{ trace_clock_jiffies,		"uptime",	0 },
 	{ trace_clock,			"perf",		1 },
-	{ ktime_get_mono_fast_ns,	"mono",		1 },
-	{ ktime_get_raw_fast_ns,	"mono_raw",	1 },
-	{ ktime_get_boot_fast_ns,	"boot",		1 },
+	{ ktime_get_fast_mono_ns,	"mono",		1 },
+	{ ktime_get_fast_raw_ns,	"mono_raw",	1 },
+	{ ktime_get_fast_boottime_ns,	"boot",		1 },
 	ARCH_TRACE_CLOCKS
 };
 
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..60e0fef60b3b 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -75,7 +75,7 @@ void watchdog_update_hrtimer_threshold(u64 period)
 
 static bool watchdog_check_timestamp(void)
 {
-	ktime_t delta, now = ktime_get_mono_fast_ns();
+	ktime_t delta, now = ktime_get_fast_mono_ns();
 
 	delta = now - __this_cpu_read(last_timestamp);
 	if (delta < watchdog_hrtimer_sample_threshold) {
-- 
2.21.0

