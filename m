Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CF1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A682184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfCTL71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:59:27 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:37753 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTL71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:59:27 -0400
X-Originating-IP: 182.72.246.220
Received: from localhost (unknown [182.72.246.220])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D5F09FF80B;
        Wed, 20 Mar 2019 11:59:22 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: core: correct trivial checkpatch warnings
Date:   Wed, 20 Mar 2019 12:59:09 +0100
Message-Id: <20190320115909.11871-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct trivial checkpatch warnings, mostly whitespace issues and
unbalanced braces.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/class.c     | 14 +++---
 drivers/rtc/dev.c       | 13 +++---
 drivers/rtc/hctosys.c   |  3 +-
 drivers/rtc/interface.c | 99 ++++++++++++++++++++++-------------------
 drivers/rtc/lib.c       | 22 ++++-----
 drivers/rtc/nvmem.c     |  2 +-
 drivers/rtc/proc.c      | 14 +++---
 drivers/rtc/sysfs.c     | 16 +++----
 8 files changed, 93 insertions(+), 90 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 22190ad28e8b..0f492b0940b3 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -20,13 +20,13 @@
 
 #include "rtc-core.h"
 
-
 static DEFINE_IDA(rtc_ida);
 struct class *rtc_class;
 
 static void rtc_device_release(struct device *dev)
 {
 	struct rtc_device *rtc = to_rtc_device(dev);
+
 	ida_simple_remove(&rtc_ida, rtc->id);
 	kfree(rtc);
 }
@@ -44,7 +44,6 @@ int rtc_hctosys_ret = -ENODEV;
 
 static struct timespec64 old_rtc, old_system, old_delta;
 
-
 static int rtc_suspend(struct device *dev)
 {
 	struct rtc_device	*rtc = to_rtc_device(dev);
@@ -68,7 +67,6 @@ static int rtc_suspend(struct device *dev)
 	ktime_get_real_ts64(&old_system);
 	old_rtc.tv_sec = rtc_tm_to_time64(&tm);
 
-
 	/*
 	 * To avoid drift caused by repeated suspend/resumes,
 	 * which each can add ~1 second drift error,
@@ -80,7 +78,7 @@ static int rtc_suspend(struct device *dev)
 	if (delta_delta.tv_sec < -2 || delta_delta.tv_sec >= 2) {
 		/*
 		 * if delta_delta is too large, assume time correction
-		 * has occured and set old_delta to the current delta.
+		 * has occurred and set old_delta to the current delta.
 		 */
 		old_delta = delta;
 	} else {
@@ -133,7 +131,7 @@ static int rtc_resume(struct device *dev)
 	 * to keep things accurate.
 	 */
 	sleep_time = timespec64_sub(sleep_time,
-			timespec64_sub(new_system, old_system));
+				    timespec64_sub(new_system, old_system));
 
 	if (sleep_time.tv_sec >= 0)
 		timekeeping_inject_sleeptime64(&sleep_time);
@@ -394,9 +392,9 @@ EXPORT_SYMBOL_GPL(__rtc_register_device);
  * rtc_register_device instead
  */
 struct rtc_device *devm_rtc_device_register(struct device *dev,
-					const char *name,
-					const struct rtc_class_ops *ops,
-					struct module *owner)
+					    const char *name,
+					    const struct rtc_class_ops *ops,
+					    struct module *owner)
 {
 	struct rtc_device *rtc;
 	int err;
diff --git a/drivers/rtc/dev.c b/drivers/rtc/dev.c
index f68aae035b81..84feb2565abd 100644
--- a/drivers/rtc/dev.c
+++ b/drivers/rtc/dev.c
@@ -57,7 +57,7 @@ static void rtc_uie_task(struct work_struct *work)
 	} else if (rtc->oldsecs != tm.tm_sec) {
 		num = (tm.tm_sec + 60 - rtc->oldsecs) % 60;
 		rtc->oldsecs = tm.tm_sec;
-		rtc->uie_timer.expires = jiffies + HZ - (HZ/10);
+		rtc->uie_timer.expires = jiffies + HZ - (HZ / 10);
 		rtc->uie_timer_active = 1;
 		rtc->uie_task_active = 0;
 		add_timer(&rtc->uie_timer);
@@ -68,6 +68,7 @@ static void rtc_uie_task(struct work_struct *work)
 	if (num)
 		rtc_handle_legacy_irq(rtc, num, RTC_UF);
 }
+
 static void rtc_uie_timer(struct timer_list *t)
 {
 	struct rtc_device *rtc = from_timer(rtc, t, uie_timer);
@@ -199,14 +200,14 @@ static __poll_t rtc_dev_poll(struct file *file, poll_table *wait)
 }
 
 static long rtc_dev_ioctl(struct file *file,
-		unsigned int cmd, unsigned long arg)
+			  unsigned int cmd, unsigned long arg)
 {
 	int err = 0;
 	struct rtc_device *rtc = file->private_data;
 	const struct rtc_class_ops *ops = rtc->ops;
 	struct rtc_time tm;
 	struct rtc_wkalrm alarm;
-	void __user *uarg = (void __user *) arg;
+	void __user *uarg = (void __user *)arg;
 
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
@@ -230,7 +231,7 @@ static long rtc_dev_ioctl(struct file *file,
 
 	case RTC_PIE_ON:
 		if (rtc->irq_freq > rtc->max_user_freq &&
-				!capable(CAP_SYS_RESOURCE))
+		    !capable(CAP_SYS_RESOURCE))
 			err = -EACCES;
 		break;
 	}
@@ -387,8 +388,9 @@ static long rtc_dev_ioctl(struct file *file,
 			err = ops->ioctl(rtc->dev.parent, cmd, arg);
 			if (err == -ENOIOCTLCMD)
 				err = -ENOTTY;
-		} else
+		} else {
 			err = -ENOTTY;
+		}
 		break;
 	}
 
@@ -400,6 +402,7 @@ static long rtc_dev_ioctl(struct file *file,
 static int rtc_dev_fasync(int fd, struct file *file, int on)
 {
 	struct rtc_device *rtc = file->private_data;
+
 	return fasync_helper(fd, file, on, &rtc->async_queue);
 }
 
diff --git a/drivers/rtc/hctosys.c b/drivers/rtc/hctosys.c
index eacbe500c44b..a74d0d890600 100644
--- a/drivers/rtc/hctosys.c
+++ b/drivers/rtc/hctosys.c
@@ -30,7 +30,7 @@ static int __init rtc_hctosys(void)
 	};
 	struct rtc_device *rtc = rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
 
-	if (rtc == NULL) {
+	if (!rtc) {
 		pr_info("unable to open rtc device (%s)\n",
 			CONFIG_RTC_HCTOSYS_DEVICE);
 		goto err_open;
@@ -41,7 +41,6 @@ static int __init rtc_hctosys(void)
 		dev_err(rtc->dev.parent,
 			"hctosys: unable to read the hardware clock\n");
 		goto err_read;
-
 	}
 
 	tv64.tv_sec = rtc_tm_to_time64(&tm);
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 28bd767e03a0..ccb7d6b4da3b 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -84,11 +84,12 @@ static int rtc_valid_range(struct rtc_device *rtc, struct rtc_time *tm)
 static int __rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm)
 {
 	int err;
-	if (!rtc->ops)
+
+	if (!rtc->ops) {
 		err = -ENODEV;
-	else if (!rtc->ops->read_time)
+	} else if (!rtc->ops->read_time) {
 		err = -EINVAL;
-	else {
+	} else {
 		memset(tm, 0, sizeof(struct rtc_time));
 		err = rtc->ops->read_time(rtc->dev.parent, tm);
 		if (err < 0) {
@@ -144,14 +145,13 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 		err = -ENODEV;
 	else if (rtc->ops->set_time)
 		err = rtc->ops->set_time(rtc->dev.parent, tm);
-	else if (rtc->ops->set_mmss64) {
-		time64_t secs64 = rtc_tm_to_time64(tm);
-
-		err = rtc->ops->set_mmss64(rtc->dev.parent, secs64);
-	} else if (rtc->ops->set_mmss) {
-		time64_t secs64 = rtc_tm_to_time64(tm);
-		err = rtc->ops->set_mmss(rtc->dev.parent, secs64);
-	} else
+	else if (rtc->ops->set_mmss64)
+		err = rtc->ops->set_mmss64(rtc->dev.parent,
+					   rtc_tm_to_time64(tm));
+	else if (rtc->ops->set_mmss)
+		err = rtc->ops->set_mmss(rtc->dev.parent,
+					 rtc_tm_to_time64(tm));
+	else
 		err = -EINVAL;
 
 	pm_stay_awake(rtc->dev.parent);
@@ -164,7 +164,8 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 }
 EXPORT_SYMBOL_GPL(rtc_set_time);
 
-static int rtc_read_alarm_internal(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
+static int rtc_read_alarm_internal(struct rtc_device *rtc,
+				   struct rtc_wkalrm *alarm)
 {
 	int err;
 
@@ -172,11 +173,11 @@ static int rtc_read_alarm_internal(struct rtc_device *rtc, struct rtc_wkalrm *al
 	if (err)
 		return err;
 
-	if (rtc->ops == NULL)
+	if (!rtc->ops) {
 		err = -ENODEV;
-	else if (!rtc->ops->read_alarm)
+	} else if (!rtc->ops->read_alarm) {
 		err = -EINVAL;
-	else {
+	} else {
 		alarm->enabled = 0;
 		alarm->pending = 0;
 		alarm->time.tm_sec = -1;
@@ -204,7 +205,7 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	int first_time = 1;
 	time64_t t_now, t_alm;
 	enum { none, day, month, year } missing = none;
-	unsigned days;
+	unsigned int days;
 
 	/* The lower level RTC driver may return -1 in some fields,
 	 * creating invalid alarm->time values, for reasons like:
@@ -273,10 +274,10 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 			return err;
 
 		/* note that tm_sec is a "don't care" value here: */
-	} while (   before.tm_min   != now.tm_min
-		 || before.tm_hour  != now.tm_hour
-		 || before.tm_mon   != now.tm_mon
-		 || before.tm_year  != now.tm_year);
+	} while (before.tm_min  != now.tm_min ||
+		 before.tm_hour != now.tm_hour ||
+		 before.tm_mon  != now.tm_mon ||
+		 before.tm_year != now.tm_year);
 
 	/* Fill in the missing alarm fields using the timestamp; we
 	 * know there's at least one since alarm->time is invalid.
@@ -293,7 +294,7 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 		alarm->time.tm_mday = now.tm_mday;
 		missing = day;
 	}
-	if ((unsigned)alarm->time.tm_mon >= 12) {
+	if ((unsigned int)alarm->time.tm_mon >= 12) {
 		alarm->time.tm_mon = now.tm_mon;
 		if (missing == none)
 			missing = month;
@@ -318,7 +319,6 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 		goto done;
 
 	switch (missing) {
-
 	/* 24 hour rollover ... if it's now 10am Monday, an alarm that
 	 * that will trigger at 5am will do so at 5am Tuesday, which
 	 * could also be in the next month or year.  This is a common
@@ -338,14 +338,14 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	case month:
 		dev_dbg(&rtc->dev, "alarm rollover: %s\n", "month");
 		do {
-			if (alarm->time.tm_mon < 11)
+			if (alarm->time.tm_mon < 11) {
 				alarm->time.tm_mon++;
-			else {
+			} else {
 				alarm->time.tm_mon = 0;
 				alarm->time.tm_year++;
 			}
 			days = rtc_month_days(alarm->time.tm_mon,
-					alarm->time.tm_year);
+					      alarm->time.tm_year);
 		} while (days < alarm->time.tm_mday);
 		break;
 
@@ -354,8 +354,8 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 		dev_dbg(&rtc->dev, "alarm rollover: %s\n", "year");
 		do {
 			alarm->time.tm_year++;
-		} while (!is_leap_year(alarm->time.tm_year + 1900)
-			&& rtc_valid_tm(&alarm->time) != 0);
+		} while (!is_leap_year(alarm->time.tm_year + 1900) &&
+			 rtc_valid_tm(&alarm->time) != 0);
 		break;
 
 	default:
@@ -366,7 +366,8 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 
 done:
 	if (err)
-		dev_warn(&rtc->dev, "invalid alarm value: %ptR\n", &alarm->time);
+		dev_warn(&rtc->dev, "invalid alarm value: %ptR\n",
+			 &alarm->time);
 
 	return err;
 }
@@ -378,11 +379,11 @@ int rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
 		return err;
-	if (rtc->ops == NULL)
+	if (!rtc->ops) {
 		err = -ENODEV;
-	else if (!rtc->ops->read_alarm)
+	} else if (!rtc->ops->read_alarm) {
 		err = -EINVAL;
-	else {
+	} else {
 		memset(alarm, 0, sizeof(struct rtc_wkalrm));
 		alarm->enabled = rtc->aie_timer.enabled;
 		alarm->time = rtc_ktime_to_tm(rtc->aie_timer.node.expires);
@@ -491,7 +492,6 @@ int rtc_initialize_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	/* Alarm has to be enabled & in the future for us to enqueue it */
 	if (alarm->enabled && (rtc_tm_to_ktime(now) <
 			 rtc->aie_timer.node.expires)) {
-
 		rtc->aie_timer.enabled = 1;
 		timerqueue_add(&rtc->timerqueue, &rtc->aie_timer.node);
 		trace_rtc_timer_enqueue(&rtc->aie_timer);
@@ -503,7 +503,9 @@ EXPORT_SYMBOL_GPL(rtc_initialize_alarm);
 
 int rtc_alarm_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 {
-	int err = mutex_lock_interruptible(&rtc->ops_lock);
+	int err;
+
+	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
 		return err;
 
@@ -532,7 +534,9 @@ EXPORT_SYMBOL_GPL(rtc_alarm_irq_enable);
 
 int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 {
-	int err = mutex_lock_interruptible(&rtc->ops_lock);
+	int err;
+
+	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
 		return err;
 
@@ -561,8 +565,9 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 		rtc->uie_rtctimer.node.expires = ktime_add(now, onesec);
 		rtc->uie_rtctimer.period = ktime_set(1, 0);
 		err = rtc_timer_enqueue(rtc, &rtc->uie_rtctimer);
-	} else
+	} else {
 		rtc_timer_remove(rtc, &rtc->uie_rtctimer);
+	}
 
 out:
 	mutex_unlock(&rtc->ops_lock);
@@ -577,11 +582,9 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 		err = rtc_dev_update_irq_enable_emul(rtc, enabled);
 #endif
 	return err;
-
 }
 EXPORT_SYMBOL_GPL(rtc_update_irq_enable);
 
-
 /**
  * rtc_handle_legacy_irq - AIE, UIE and PIE event hook
  * @rtc: pointer to the rtc device
@@ -596,14 +599,13 @@ void rtc_handle_legacy_irq(struct rtc_device *rtc, int num, int mode)
 
 	/* mark one irq of the appropriate mode */
 	spin_lock_irqsave(&rtc->irq_lock, flags);
-	rtc->irq_data = (rtc->irq_data + (num << 8)) | (RTC_IRQF|mode);
+	rtc->irq_data = (rtc->irq_data + (num << 8)) | (RTC_IRQF | mode);
 	spin_unlock_irqrestore(&rtc->irq_lock, flags);
 
 	wake_up_interruptible(&rtc->irq_queue);
 	kill_fasync(&rtc->async_queue, SIGIO, POLL_IN);
 }
 
-
 /**
  * rtc_aie_update_irq - AIE mode rtctimer hook
  * @rtc: pointer to the rtc_device
@@ -615,7 +617,6 @@ void rtc_aie_update_irq(struct rtc_device *rtc)
 	rtc_handle_legacy_irq(rtc, 1, RTC_AF);
 }
 
-
 /**
  * rtc_uie_update_irq - UIE mode rtctimer hook
  * @rtc: pointer to the rtc_device
@@ -627,7 +628,6 @@ void rtc_uie_update_irq(struct rtc_device *rtc)
 	rtc_handle_legacy_irq(rtc, 1,  RTC_UF);
 }
 
-
 /**
  * rtc_pie_update_irq - PIE mode hrtimer hook
  * @timer: pointer to the pie mode hrtimer
@@ -641,6 +641,7 @@ enum hrtimer_restart rtc_pie_update_irq(struct hrtimer *timer)
 	struct rtc_device *rtc;
 	ktime_t period;
 	int count;
+
 	rtc = container_of(timer, struct rtc_device, pie_timer);
 
 	period = NSEC_PER_SEC / rtc->irq_freq;
@@ -659,7 +660,7 @@ enum hrtimer_restart rtc_pie_update_irq(struct hrtimer *timer)
  * Context: any
  */
 void rtc_update_irq(struct rtc_device *rtc,
-		unsigned long num, unsigned long events)
+		    unsigned long num, unsigned long events)
 {
 	if (IS_ERR_OR_NULL(rtc))
 		return;
@@ -808,6 +809,7 @@ static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
 	if (!next || ktime_before(timer->node.expires, next->expires)) {
 		struct rtc_wkalrm alarm;
 		int err;
+
 		alarm.time = rtc_ktime_to_tm(timer->node.expires);
 		alarm.enabled = 1;
 		err = __rtc_set_alarm(rtc, &alarm);
@@ -848,12 +850,14 @@ static void rtc_alarm_disable(struct rtc_device *rtc)
 static void rtc_timer_remove(struct rtc_device *rtc, struct rtc_timer *timer)
 {
 	struct timerqueue_node *next = timerqueue_getnext(&rtc->timerqueue);
+
 	timerqueue_del(&rtc->timerqueue, &timer->node);
 	trace_rtc_timer_dequeue(timer);
 	timer->enabled = 0;
 	if (next == &timer->node) {
 		struct rtc_wkalrm alarm;
 		int err;
+
 		next = timerqueue_getnext(&rtc->timerqueue);
 		if (!next) {
 			rtc_alarm_disable(rtc);
@@ -926,9 +930,9 @@ void rtc_timer_do_work(struct work_struct *work)
 		alarm.enabled = 1;
 reprogram:
 		err = __rtc_set_alarm(rtc, &alarm);
-		if (err == -ETIME)
+		if (err == -ETIME) {
 			goto again;
-		else if (err) {
+		} else if (err) {
 			if (retry-- > 0)
 				goto reprogram;
 
@@ -939,14 +943,14 @@ void rtc_timer_do_work(struct work_struct *work)
 			dev_err(&rtc->dev, "__rtc_set_alarm: err=%d\n", err);
 			goto again;
 		}
-	} else
+	} else {
 		rtc_alarm_disable(rtc);
+	}
 
 	pm_relax(rtc->dev.parent);
 	mutex_unlock(&rtc->ops_lock);
 }
 
-
 /* rtc_timer_init - Initializes an rtc_timer
  * @timer: timer to be intiialized
  * @f: function pointer to be called when timer fires
@@ -972,9 +976,10 @@ void rtc_timer_init(struct rtc_timer *timer, void (*f)(struct rtc_device *r),
  * Kernel interface to set an rtc_timer
  */
 int rtc_timer_start(struct rtc_device *rtc, struct rtc_timer *timer,
-			ktime_t expires, ktime_t period)
+		    ktime_t expires, ktime_t period)
 {
 	int ret = 0;
+
 	mutex_lock(&rtc->ops_lock);
 	if (timer->enabled)
 		rtc_timer_remove(rtc, timer);
diff --git a/drivers/rtc/lib.c b/drivers/rtc/lib.c
index 3d0dc70ff7d8..e36c233455ee 100644
--- a/drivers/rtc/lib.c
+++ b/drivers/rtc/lib.c
@@ -22,7 +22,7 @@ static const unsigned short rtc_ydays[2][13] = {
 	{ 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366 }
 };
 
-#define LEAPS_THRU_END_OF(y) ((y)/4 - (y)/100 + (y)/400)
+#define LEAPS_THRU_END_OF(y) ((y) / 4 - (y) / 100 + (y) / 400)
 
 /*
  * The number of days in the month.
@@ -38,11 +38,10 @@ EXPORT_SYMBOL(rtc_month_days);
  */
 int rtc_year_days(unsigned int day, unsigned int month, unsigned int year)
 {
-	return rtc_ydays[is_leap_year(year)][month] + day-1;
+	return rtc_ydays[is_leap_year(year)][month] + day - 1;
 }
 EXPORT_SYMBOL(rtc_year_days);
 
-
 /*
  * rtc_time64_to_tm - Converts time64_t to rtc_time.
  * Convert seconds since 01-01-1970 00:00:00 to Gregorian date.
@@ -94,13 +93,14 @@ EXPORT_SYMBOL(rtc_time64_to_tm);
  */
 int rtc_valid_tm(struct rtc_time *tm)
 {
-	if (tm->tm_year < 70
-		|| ((unsigned)tm->tm_mon) >= 12
-		|| tm->tm_mday < 1
-		|| tm->tm_mday > rtc_month_days(tm->tm_mon, ((unsigned)tm->tm_year + 1900))
-		|| ((unsigned)tm->tm_hour) >= 24
-		|| ((unsigned)tm->tm_min) >= 60
-		|| ((unsigned)tm->tm_sec) >= 60)
+	if (tm->tm_year < 70 ||
+	    ((unsigned int)tm->tm_mon) >= 12 ||
+	    tm->tm_mday < 1 ||
+	    tm->tm_mday > rtc_month_days(tm->tm_mon,
+					 ((unsigned int)tm->tm_year + 1900)) ||
+	    ((unsigned int)tm->tm_hour) >= 24 ||
+	    ((unsigned int)tm->tm_min) >= 60 ||
+	    ((unsigned int)tm->tm_sec) >= 60)
 		return -EINVAL;
 
 	return 0;
@@ -113,7 +113,7 @@ EXPORT_SYMBOL(rtc_valid_tm);
  */
 time64_t rtc_tm_to_time64(struct rtc_time *tm)
 {
-	return mktime64(((unsigned)tm->tm_year + 1900), tm->tm_mon + 1,
+	return mktime64(((unsigned int)tm->tm_year + 1900), tm->tm_mon + 1,
 			tm->tm_mday, tm->tm_hour, tm->tm_min, tm->tm_sec);
 }
 EXPORT_SYMBOL(rtc_tm_to_time64);
diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index 7481a4cd2753..4312096c7738 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -43,7 +43,7 @@ static int rtc_nvram_register(struct rtc_device *rtc,
 {
 	int err;
 
-	rtc->nvram = kzalloc(sizeof(struct bin_attribute), GFP_KERNEL);
+	rtc->nvram = kzalloc(sizeof(*rtc->nvram), GFP_KERNEL);
 	if (!rtc->nvram)
 		return -ENOMEM;
 
diff --git a/drivers/rtc/proc.c b/drivers/rtc/proc.c
index a741c4d8f5a5..73344598fc1b 100644
--- a/drivers/rtc/proc.c
+++ b/drivers/rtc/proc.c
@@ -57,17 +57,17 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
 		seq_printf(seq, "alrm_time\t: %ptRt\n", &alrm.time);
 		seq_printf(seq, "alrm_date\t: %ptRd\n", &alrm.time);
 		seq_printf(seq, "alarm_IRQ\t: %s\n",
-				alrm.enabled ? "yes" : "no");
+			   alrm.enabled ? "yes" : "no");
 		seq_printf(seq, "alrm_pending\t: %s\n",
-				alrm.pending ? "yes" : "no");
+			   alrm.pending ? "yes" : "no");
 		seq_printf(seq, "update IRQ enabled\t: %s\n",
-			(rtc->uie_rtctimer.enabled) ? "yes" : "no");
+			   (rtc->uie_rtctimer.enabled) ? "yes" : "no");
 		seq_printf(seq, "periodic IRQ enabled\t: %s\n",
-			(rtc->pie_enabled) ? "yes" : "no");
+			   (rtc->pie_enabled) ? "yes" : "no");
 		seq_printf(seq, "periodic IRQ frequency\t: %d\n",
-			rtc->irq_freq);
+			   rtc->irq_freq);
 		seq_printf(seq, "max user IRQ frequency\t: %d\n",
-			rtc->max_user_freq);
+			   rtc->max_user_freq);
 	}
 
 	seq_printf(seq, "24hr\t\t: yes\n");
@@ -82,7 +82,7 @@ void rtc_proc_add_device(struct rtc_device *rtc)
 {
 	if (is_rtc_hctosys(rtc))
 		proc_create_single_data("driver/rtc", 0, NULL, rtc_proc_show,
-				rtc);
+					rtc);
 }
 
 void rtc_proc_del_device(struct rtc_device *rtc)
diff --git a/drivers/rtc/sysfs.c b/drivers/rtc/sysfs.c
index 0d3dac557df5..be3531e7f868 100644
--- a/drivers/rtc/sysfs.c
+++ b/drivers/rtc/sysfs.c
@@ -11,7 +11,6 @@
 
 #include "rtc-core.h"
 
-
 /* device attributes */
 
 /*
@@ -83,7 +82,7 @@ max_user_freq_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 static ssize_t
 max_user_freq_store(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t n)
+		    const char *buf, size_t n)
 {
 	struct rtc_device *rtc = to_rtc_device(dev);
 	unsigned long val;
@@ -113,12 +112,11 @@ hctosys_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 #ifdef CONFIG_RTC_HCTOSYS_DEVICE
 	if (rtc_hctosys_ret == 0 &&
-			strcmp(dev_name(&to_rtc_device(dev)->dev),
-				CONFIG_RTC_HCTOSYS_DEVICE) == 0)
+	    strcmp(dev_name(&to_rtc_device(dev)->dev),
+		   CONFIG_RTC_HCTOSYS_DEVICE) == 0)
 		return sprintf(buf, "1\n");
-	else
 #endif
-		return sprintf(buf, "0\n");
+	return sprintf(buf, "0\n");
 }
 static DEVICE_ATTR_RO(hctosys);
 
@@ -172,15 +170,15 @@ wakealarm_store(struct device *dev, struct device_attribute *attr,
 		if (*buf_ptr == '=') {
 			buf_ptr++;
 			push = 1;
-		} else
+		} else {
 			adjust = 1;
+		}
 	}
 	retval = kstrtos64(buf_ptr, 0, &alarm);
 	if (retval)
 		return retval;
-	if (adjust) {
+	if (adjust)
 		alarm += now;
-	}
 	if (alarm > now || push) {
 		/* Avoid accidentally clobbering active alarms; we can't
 		 * entirely prevent that here, without even the minimal
-- 
2.20.1

