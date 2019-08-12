Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6335C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891EB216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfHLKVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:21:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfHLKVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:21:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3BD8308FC4A;
        Mon, 12 Aug 2019 10:21:17 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-6.ams2.redhat.com [10.36.117.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 35AC271C31;
        Mon, 12 Aug 2019 10:21:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: iosf_mbi: Rewrite locking
Date:   Mon, 12 Aug 2019 12:21:13 +0200
Message-Id: <20190812102113.95794-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 12 Aug 2019 10:21:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 2 problems with the old iosf PMIC I2C bus arbritration code which
this commit fixes:

1. The lockdep code complains about a possible deadlock in the
iosf_mbi_[un]block_punit_i2c_access code:

[    6.712662] ======================================================
[    6.712673] WARNING: possible circular locking dependency detected
[    6.712685] 5.3.0-rc2+ #79 Not tainted
[    6.712692] ------------------------------------------------------
[    6.712702] kworker/0:1/7 is trying to acquire lock:
[    6.712712] 00000000df1c5681 (iosf_mbi_block_punit_i2c_access_count_mutex){+.+.}, at: iosf_mbi_unblock_punit_i2c_access+0x13/0x90
[    6.712739]
               but task is already holding lock:
[    6.712749] 0000000067cb23e7 (iosf_mbi_punit_mutex){+.+.}, at: iosf_mbi_block_punit_i2c_access+0x97/0x186
[    6.712768]
               which lock already depends on the new lock.

[    6.712780]
               the existing dependency chain (in reverse order) is:
[    6.712792]
               -> #1 (iosf_mbi_punit_mutex){+.+.}:
[    6.712808]        __mutex_lock+0xa8/0x9a0
[    6.712818]        iosf_mbi_block_punit_i2c_access+0x97/0x186
[    6.712831]        i2c_dw_acquire_lock+0x20/0x30
[    6.712841]        i2c_dw_set_reg_access+0x15/0xb0
[    6.712851]        i2c_dw_probe+0x57/0x473
[    6.712861]        dw_i2c_plat_probe+0x33e/0x640
[    6.712874]        platform_drv_probe+0x38/0x80
[    6.712884]        really_probe+0xf3/0x380
[    6.712894]        driver_probe_device+0x59/0xd0
[    6.712905]        bus_for_each_drv+0x84/0xd0
[    6.712915]        __device_attach+0xe4/0x170
[    6.712925]        bus_probe_device+0x9f/0xb0
[    6.712935]        deferred_probe_work_func+0x79/0xd0
[    6.712946]        process_one_work+0x234/0x560
[    6.712957]        worker_thread+0x50/0x3b0
[    6.712967]        kthread+0x10a/0x140
[    6.712977]        ret_from_fork+0x3a/0x50
[    6.712986]
               -> #0 (iosf_mbi_block_punit_i2c_access_count_mutex){+.+.}:
[    6.713004]        __lock_acquire+0xe07/0x1930
[    6.713015]        lock_acquire+0x9d/0x1a0
[    6.713025]        __mutex_lock+0xa8/0x9a0
[    6.713035]        iosf_mbi_unblock_punit_i2c_access+0x13/0x90
[    6.713047]        i2c_dw_set_reg_access+0x4d/0xb0
[    6.713058]        i2c_dw_probe+0x57/0x473
[    6.713068]        dw_i2c_plat_probe+0x33e/0x640
[    6.713079]        platform_drv_probe+0x38/0x80
[    6.713089]        really_probe+0xf3/0x380
[    6.713099]        driver_probe_device+0x59/0xd0
[    6.713109]        bus_for_each_drv+0x84/0xd0
[    6.713119]        __device_attach+0xe4/0x170
[    6.713129]        bus_probe_device+0x9f/0xb0
[    6.713140]        deferred_probe_work_func+0x79/0xd0
[    6.713150]        process_one_work+0x234/0x560
[    6.713160]        worker_thread+0x50/0x3b0
[    6.713170]        kthread+0x10a/0x140
[    6.713180]        ret_from_fork+0x3a/0x50
[    6.713189]
               other info that might help us debug this:

[    6.713202]  Possible unsafe locking scenario:

[    6.713212]        CPU0                    CPU1
[    6.713221]        ----                    ----
[    6.713229]   lock(iosf_mbi_punit_mutex);
[    6.713239]                                lock(iosf_mbi_block_punit_i2c_access_count_mutex);
[    6.713253]                                lock(iosf_mbi_punit_mutex);
[    6.713265]   lock(iosf_mbi_block_punit_i2c_access_count_mutex);
[    6.713276]
                *** DEADLOCK ***

In practice can never happen because only the first caller which
increments iosf_mbi_block_punit_i2c_access_count will also take
iosf_mbi_punit_mutex, that is the whole purpose of the counter, which
itself is protected by iosf_mbi_block_punit_i2c_access_count_mutex.

But there is no way to tell the lockdep code about this and we really
want to be able to run a kernel with lockdep enabled without these
warnings being triggered.

2. The lockdep warning also points out another real problem, if 2 threads
both are in a block of code protected by iosf_mbi_block_punit_i2c_access
and the first thread to acquire the block exits before the second thread
then the second thread will call mutex_unlock on iosf_mbi_punit_mutex,
but it is not the thread which took the mutex and unlocking by another
thread is not allowed.

This commit fixes this by getting rid of the notion of holding a mutex
for the entire duration of the PMIC accesses, be it either from the
PUnit side, or from an in kernel I2C driver. In general holding a mutex
after exiting a function is a bad idea and the above problems show this
case is no different.

Instead 2 counters are now used, one for PMIC accesses from the PUnit
and one for accesses from in kernel I2C code. When access is requested
now the code will wait (using a waitqueue) for the counter of the other
type of access to reach 0 and on release, if the counter reaches 0 the
wakequeue is woken.

Note that the counter approach is necessary to allow nested calls.
The main reason for this is so that a series of i2c transfers can be done
with the punit blocked from accessing the bus the whole time. This is
necessary to be able to safely read/modify/write a PMIC register without
racing with the PUNIT doing the same thing.

Allowing nested iosf_mbi_block_punit_i2c_access() calls also is desirable
from a performance pov since the whole dance necessary to block the PUnit
from accessing the PMIC I2C bus is somewhat expensive.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/platform/intel/iosf_mbi.c | 100 ++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index 2e796b54cbde..9e2444500428 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/capability.h>
 #include <linux/pm_qos.h>
+#include <linux/wait.h>
 
 #include <asm/iosf_mbi.h>
 
@@ -201,23 +202,45 @@ EXPORT_SYMBOL(iosf_mbi_available);
 #define PUNIT_SEMAPHORE_BIT		BIT(0)
 #define PUNIT_SEMAPHORE_ACQUIRE		BIT(1)
 
-static DEFINE_MUTEX(iosf_mbi_punit_mutex);
-static DEFINE_MUTEX(iosf_mbi_block_punit_i2c_access_count_mutex);
+static DEFINE_MUTEX(iosf_mbi_pmic_access_mutex);
 static BLOCKING_NOTIFIER_HEAD(iosf_mbi_pmic_bus_access_notifier);
-static u32 iosf_mbi_block_punit_i2c_access_count;
+static DECLARE_WAIT_QUEUE_HEAD(iosf_mbi_pmic_access_waitq);
+static u32 iosf_mbi_pmic_punit_access_count;
+static u32 iosf_mbi_pmic_i2c_access_count;
 static u32 iosf_mbi_sem_address;
 static unsigned long iosf_mbi_sem_acquired;
 static struct pm_qos_request iosf_mbi_pm_qos;
 
 void iosf_mbi_punit_acquire(void)
 {
-	mutex_lock(&iosf_mbi_punit_mutex);
+	/* Wait for any I2C PMIC accesses from in kernel drivers to finish. */
+	mutex_lock(&iosf_mbi_pmic_access_mutex);
+	while (iosf_mbi_pmic_i2c_access_count != 0) {
+		mutex_unlock(&iosf_mbi_pmic_access_mutex);
+		wait_event(iosf_mbi_pmic_access_waitq,
+			   iosf_mbi_pmic_i2c_access_count == 0);
+		mutex_lock(&iosf_mbi_pmic_access_mutex);
+	}
+	/*
+	 * We do not need to do anything to allow the PUNIT to safely access
+	 * the PMIC, other then block in kernel accesses to the PMIC.
+	 */
+	iosf_mbi_pmic_punit_access_count++;
+	mutex_unlock(&iosf_mbi_pmic_access_mutex);
 }
 EXPORT_SYMBOL(iosf_mbi_punit_acquire);
 
 void iosf_mbi_punit_release(void)
 {
-	mutex_unlock(&iosf_mbi_punit_mutex);
+	bool do_wakeup;
+
+	mutex_lock(&iosf_mbi_pmic_access_mutex);
+	iosf_mbi_pmic_punit_access_count--;
+	do_wakeup = iosf_mbi_pmic_punit_access_count == 0;
+	mutex_unlock(&iosf_mbi_pmic_access_mutex);
+
+	if (do_wakeup)
+		wake_up(&iosf_mbi_pmic_access_waitq);
 }
 EXPORT_SYMBOL(iosf_mbi_punit_release);
 
@@ -256,34 +279,32 @@ static void iosf_mbi_reset_semaphore(void)
  * already blocked P-Unit accesses because it wants them blocked over multiple
  * i2c-transfers, for e.g. read-modify-write of an I2C client register.
  *
- * The P-Unit accesses already being blocked is tracked through the
- * iosf_mbi_block_punit_i2c_access_count variable which is protected by the
- * iosf_mbi_block_punit_i2c_access_count_mutex this mutex is hold for the
- * entire duration of the function.
- *
- * If access is not blocked yet, this function takes the following steps:
+ * To allow safe PMIC i2c bus accesses this function takes the following steps:
  *
  * 1) Some code sends request to the P-Unit which make it access the PMIC
  *    I2C bus. Testing has shown that the P-Unit does not check its internal
  *    PMIC bus semaphore for these requests. Callers of these requests call
  *    iosf_mbi_punit_acquire()/_release() around their P-Unit accesses, these
- *    functions lock/unlock the iosf_mbi_punit_mutex.
- *    As the first step we lock the iosf_mbi_punit_mutex, to wait for any in
- *    flight requests to finish and to block any new requests.
+ *    functions increase/decrease iosf_mbi_pmic_punit_access_count, so first
+ *    we wait for iosf_mbi_pmic_punit_access_count to become 0.
+ *
+ * 2) Check iosf_mbi_pmic_i2c_access_count, if access has already
+ *    been blocked by another caller, we only need to increment
+ *    iosf_mbi_pmic_i2c_access_count and we can skip the other steps.
  *
- * 2) Some code makes such P-Unit requests from atomic contexts where it
+ * 3) Some code makes such P-Unit requests from atomic contexts where it
  *    cannot call iosf_mbi_punit_acquire() as that may sleep.
  *    As the second step we call a notifier chain which allows any code
  *    needing P-Unit resources from atomic context to acquire them before
  *    we take control over the PMIC I2C bus.
  *
- * 3) When CPU cores enter C6 or C7 the P-Unit needs to talk to the PMIC
+ * 4) When CPU cores enter C6 or C7 the P-Unit needs to talk to the PMIC
  *    if this happens while the kernel itself is accessing the PMIC I2C bus
  *    the SoC hangs.
  *    As the third step we call pm_qos_update_request() to disallow the CPU
  *    to enter C6 or C7.
  *
- * 4) The P-Unit has a PMIC bus semaphore which we can request to stop
+ * 5) The P-Unit has a PMIC bus semaphore which we can request to stop
  *    autonomous P-Unit tasks from accessing the PMIC I2C bus while we hold it.
  *    As the fourth and final step we request this semaphore and wait for our
  *    request to be acknowledged.
@@ -297,12 +318,18 @@ int iosf_mbi_block_punit_i2c_access(void)
 	if (WARN_ON(!mbi_pdev || !iosf_mbi_sem_address))
 		return -ENXIO;
 
-	mutex_lock(&iosf_mbi_block_punit_i2c_access_count_mutex);
+	mutex_lock(&iosf_mbi_pmic_access_mutex);
 
-	if (iosf_mbi_block_punit_i2c_access_count > 0)
+	while (iosf_mbi_pmic_punit_access_count != 0) {
+		mutex_unlock(&iosf_mbi_pmic_access_mutex);
+		wait_event(iosf_mbi_pmic_access_waitq,
+			   iosf_mbi_pmic_punit_access_count == 0);
+		mutex_lock(&iosf_mbi_pmic_access_mutex);
+	}
+
+	if (iosf_mbi_pmic_i2c_access_count > 0)
 		goto success;
 
-	mutex_lock(&iosf_mbi_punit_mutex);
 	blocking_notifier_call_chain(&iosf_mbi_pmic_bus_access_notifier,
 				     MBI_PMIC_BUS_ACCESS_BEGIN, NULL);
 
@@ -330,10 +357,6 @@ int iosf_mbi_block_punit_i2c_access(void)
 			iosf_mbi_sem_acquired = jiffies;
 			dev_dbg(&mbi_pdev->dev, "P-Unit semaphore acquired after %ums\n",
 				jiffies_to_msecs(jiffies - start));
-			/*
-			 * Success, keep iosf_mbi_punit_mutex locked till
-			 * iosf_mbi_unblock_punit_i2c_access() gets called.
-			 */
 			goto success;
 		}
 
@@ -344,15 +367,13 @@ int iosf_mbi_block_punit_i2c_access(void)
 	dev_err(&mbi_pdev->dev, "Error P-Unit semaphore timed out, resetting\n");
 error:
 	iosf_mbi_reset_semaphore();
-	mutex_unlock(&iosf_mbi_punit_mutex);
-
 	if (!iosf_mbi_get_sem(&sem))
 		dev_err(&mbi_pdev->dev, "P-Unit semaphore: %d\n", sem);
 success:
 	if (!WARN_ON(ret))
-		iosf_mbi_block_punit_i2c_access_count++;
+		iosf_mbi_pmic_i2c_access_count++;
 
-	mutex_unlock(&iosf_mbi_block_punit_i2c_access_count_mutex);
+	mutex_unlock(&iosf_mbi_pmic_access_mutex);
 
 	return ret;
 }
@@ -360,17 +381,20 @@ EXPORT_SYMBOL(iosf_mbi_block_punit_i2c_access);
 
 void iosf_mbi_unblock_punit_i2c_access(void)
 {
-	mutex_lock(&iosf_mbi_block_punit_i2c_access_count_mutex);
+	bool do_wakeup = false;
 
-	iosf_mbi_block_punit_i2c_access_count--;
-	if (iosf_mbi_block_punit_i2c_access_count == 0) {
+	mutex_lock(&iosf_mbi_pmic_access_mutex);
+	iosf_mbi_pmic_i2c_access_count--;
+	if (iosf_mbi_pmic_i2c_access_count == 0) {
 		iosf_mbi_reset_semaphore();
-		mutex_unlock(&iosf_mbi_punit_mutex);
 		dev_dbg(&mbi_pdev->dev, "punit semaphore held for %ums\n",
 			jiffies_to_msecs(jiffies - iosf_mbi_sem_acquired));
+		do_wakeup = true;
 	}
+	mutex_unlock(&iosf_mbi_pmic_access_mutex);
 
-	mutex_unlock(&iosf_mbi_block_punit_i2c_access_count_mutex);
+	if (do_wakeup)
+		wake_up(&iosf_mbi_pmic_access_waitq);
 }
 EXPORT_SYMBOL(iosf_mbi_unblock_punit_i2c_access);
 
@@ -379,10 +403,10 @@ int iosf_mbi_register_pmic_bus_access_notifier(struct notifier_block *nb)
 	int ret;
 
 	/* Wait for the bus to go inactive before registering */
-	mutex_lock(&iosf_mbi_punit_mutex);
+	iosf_mbi_punit_acquire();
 	ret = blocking_notifier_chain_register(
 				&iosf_mbi_pmic_bus_access_notifier, nb);
-	mutex_unlock(&iosf_mbi_punit_mutex);
+	iosf_mbi_punit_release();
 
 	return ret;
 }
@@ -403,9 +427,9 @@ int iosf_mbi_unregister_pmic_bus_access_notifier(struct notifier_block *nb)
 	int ret;
 
 	/* Wait for the bus to go inactive before unregistering */
-	mutex_lock(&iosf_mbi_punit_mutex);
+	iosf_mbi_punit_acquire();
 	ret = iosf_mbi_unregister_pmic_bus_access_notifier_unlocked(nb);
-	mutex_unlock(&iosf_mbi_punit_mutex);
+	iosf_mbi_punit_release();
 
 	return ret;
 }
@@ -413,7 +437,7 @@ EXPORT_SYMBOL(iosf_mbi_unregister_pmic_bus_access_notifier);
 
 void iosf_mbi_assert_punit_acquired(void)
 {
-	WARN_ON(!mutex_is_locked(&iosf_mbi_punit_mutex));
+	WARN_ON(iosf_mbi_pmic_punit_access_count == 0);
 }
 EXPORT_SYMBOL(iosf_mbi_assert_punit_acquired);
 
-- 
2.23.0.rc1

