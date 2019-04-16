Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD27C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FCA20651
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfDPJeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:34:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:41626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728230AbfDPJeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:34:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 072BAAFC3;
        Tue, 16 Apr 2019 09:34:12 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtc: ds1685: use threaded interrupt
Date:   Tue, 16 Apr 2019 11:34:04 +0200
Message-Id: <20190416093404.6785-2-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190416093404.6785-1-tbogendoerfer@suse.de>
References: <20190416093404.6785-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handling of extended interrupts (kickstart, wake-up, ram-clear) was
moved off to a work queue, but the interrupts aren't acknowledged
in the interrupt handler. This leads to a deadlock, if driver
is used with interrupts. To fix this we use a threaded interrupt, get rid
of the work queue and do locking with just the rtc mutex lock.

Fixes: aaaf5fbf56f1 ("rtc: add driver for DS1685 family of real time clocks")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 drivers/rtc/rtc-ds1685.c   | 220 +++++++++++++++++++++------------------------
 include/linux/rtc/ds1685.h |   2 -
 2 files changed, 104 insertions(+), 118 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index 33781be58f16..5f4328524183 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -510,10 +510,6 @@ static int
 ds1685_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct ds1685_priv *rtc = dev_get_drvdata(dev);
-	unsigned long flags = 0;
-
-	/* Enable/disable the Alarm IRQ-Enable flag. */
-	spin_lock_irqsave(&rtc->lock, flags);
 
 	/* Flip the requisite interrupt-enable bit. */
 	if (enabled)
@@ -525,7 +521,6 @@ ds1685_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 	/* Read Control C to clear all the flag bits. */
 	rtc->read(rtc, RTC_CTRL_C);
-	spin_unlock_irqrestore(&rtc->lock, flags);
 
 	return 0;
 }
@@ -533,98 +528,18 @@ ds1685_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 
 /* ----------------------------------------------------------------------- */
-/* IRQ handler & workqueue. */
-
-/**
- * ds1685_rtc_irq_handler - IRQ handler.
- * @irq: IRQ number.
- * @dev_id: platform device pointer.
- */
-static irqreturn_t
-ds1685_rtc_irq_handler(int irq, void *dev_id)
-{
-	struct platform_device *pdev = dev_id;
-	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
-	u8 ctrlb, ctrlc;
-	unsigned long events = 0;
-	u8 num_irqs = 0;
-
-	/* Abort early if the device isn't ready yet (i.e., DEBUG_SHIRQ). */
-	if (unlikely(!rtc))
-		return IRQ_HANDLED;
-
-	/* Ctrlb holds the interrupt-enable bits and ctrlc the flag bits. */
-	spin_lock(&rtc->lock);
-	ctrlb = rtc->read(rtc, RTC_CTRL_B);
-	ctrlc = rtc->read(rtc, RTC_CTRL_C);
-
-	/* Is the IRQF bit set? */
-	if (likely(ctrlc & RTC_CTRL_C_IRQF)) {
-		/*
-		 * We need to determine if it was one of the standard
-		 * events: PF, AF, or UF.  If so, we handle them and
-		 * update the RTC core.
-		 */
-		if (likely(ctrlc & RTC_CTRL_B_PAU_MASK)) {
-			events = RTC_IRQF;
-
-			/* Check for a periodic interrupt. */
-			if ((ctrlb & RTC_CTRL_B_PIE) &&
-			    (ctrlc & RTC_CTRL_C_PF)) {
-				events |= RTC_PF;
-				num_irqs++;
-			}
-
-			/* Check for an alarm interrupt. */
-			if ((ctrlb & RTC_CTRL_B_AIE) &&
-			    (ctrlc & RTC_CTRL_C_AF)) {
-				events |= RTC_AF;
-				num_irqs++;
-			}
-
-			/* Check for an update interrupt. */
-			if ((ctrlb & RTC_CTRL_B_UIE) &&
-			    (ctrlc & RTC_CTRL_C_UF)) {
-				events |= RTC_UF;
-				num_irqs++;
-			}
-
-			rtc_update_irq(rtc->dev, num_irqs, events);
-		} else {
-			/*
-			 * One of the "extended" interrupts was received that
-			 * is not recognized by the RTC core.  These need to
-			 * be handled in task context as they can call other
-			 * functions and the time spent in irq context needs
-			 * to be minimized.  Schedule them into a workqueue
-			 * and inform the RTC core that the IRQs were handled.
-			 */
-			spin_unlock(&rtc->lock);
-			schedule_work(&rtc->work);
-			rtc_update_irq(rtc->dev, 0, 0);
-			return IRQ_HANDLED;
-		}
-	}
-	spin_unlock(&rtc->lock);
-
-	return events ? IRQ_HANDLED : IRQ_NONE;
-}
+/* IRQ handler */
 
 /**
- * ds1685_rtc_work_queue - work queue handler.
- * @work: work_struct containing data to work on in task context.
+ * ds1685_rtc_extended_irq - take care of extended interrupts
+ * @rtc: pointer to the ds1685 rtc structure.
+ * @pdev: platform device pointer.
  */
 static void
-ds1685_rtc_work_queue(struct work_struct *work)
+ds1685_rtc_extended_irq(struct ds1685_priv *rtc, struct platform_device *pdev)
 {
-	struct ds1685_priv *rtc = container_of(work,
-					       struct ds1685_priv, work);
-	struct platform_device *pdev = to_platform_device(&rtc->dev->dev);
-	struct mutex *rtc_mutex = &rtc->dev->ops_lock;
 	u8 ctrl4a, ctrl4b;
 
-	mutex_lock(rtc_mutex);
-
 	ds1685_rtc_switch_to_bank1(rtc);
 	ctrl4a = rtc->read(rtc, RTC_EXT_CTRL_4A);
 	ctrl4b = rtc->read(rtc, RTC_EXT_CTRL_4B);
@@ -703,8 +618,76 @@ ds1685_rtc_work_queue(struct work_struct *work)
 				 "RAM-Clear IRQ just occurred!\n");
 	}
 	ds1685_rtc_switch_to_bank0(rtc);
+}
+
+/**
+ * ds1685_rtc_irq_handler - IRQ handler.
+ * @irq: IRQ number.
+ * @dev_id: platform device pointer.
+ */
+static irqreturn_t
+ds1685_rtc_irq_handler(int irq, void *dev_id)
+{
+	struct platform_device *pdev = dev_id;
+	struct ds1685_priv *rtc = platform_get_drvdata(pdev);
+	struct mutex *rtc_mutex;
+	u8 ctrlb, ctrlc;
+	unsigned long events = 0;
+	u8 num_irqs = 0;
+
+	/* Abort early if the device isn't ready yet (i.e., DEBUG_SHIRQ). */
+	if (unlikely(!rtc))
+		return IRQ_HANDLED;
+
+	rtc_mutex = &rtc->dev->ops_lock;
+	mutex_lock(rtc_mutex);
+
+	/* Ctrlb holds the interrupt-enable bits and ctrlc the flag bits. */
+	ctrlb = rtc->read(rtc, RTC_CTRL_B);
+	ctrlc = rtc->read(rtc, RTC_CTRL_C);
+
+	/* Is the IRQF bit set? */
+	if (likely(ctrlc & RTC_CTRL_C_IRQF)) {
+		/*
+		 * We need to determine if it was one of the standard
+		 * events: PF, AF, or UF.  If so, we handle them and
+		 * update the RTC core.
+		 */
+		if (likely(ctrlc & RTC_CTRL_B_PAU_MASK)) {
+			events = RTC_IRQF;
+
+			/* Check for a periodic interrupt. */
+			if ((ctrlb & RTC_CTRL_B_PIE) &&
+			    (ctrlc & RTC_CTRL_C_PF)) {
+				events |= RTC_PF;
+				num_irqs++;
+			}
+
+			/* Check for an alarm interrupt. */
+			if ((ctrlb & RTC_CTRL_B_AIE) &&
+			    (ctrlc & RTC_CTRL_C_AF)) {
+				events |= RTC_AF;
+				num_irqs++;
+			}
 
+			/* Check for an update interrupt. */
+			if ((ctrlb & RTC_CTRL_B_UIE) &&
+			    (ctrlc & RTC_CTRL_C_UF)) {
+				events |= RTC_UF;
+				num_irqs++;
+			}
+		} else {
+			/*
+			 * One of the "extended" interrupts was received that
+			 * is not recognized by the RTC core.
+			 */
+			ds1685_rtc_extended_irq(rtc, pdev);
+		}
+	}
+	rtc_update_irq(rtc->dev, num_irqs, events);
 	mutex_unlock(rtc_mutex);
+
+	return events ? IRQ_HANDLED : IRQ_NONE;
 }
 /* ----------------------------------------------------------------------- */
 
@@ -833,11 +816,15 @@ static int ds1685_nvram_read(void *priv, unsigned int pos, void *val,
 			     size_t size)
 {
 	struct ds1685_priv *rtc = priv;
+	struct mutex *rtc_mutex = &rtc->dev->ops_lock;
 	ssize_t count;
-	unsigned long flags = 0;
 	u8 *buf = val;
+	int err;
+
+	err = mutex_lock_interruptible(rtc_mutex);
+	if (err)
+		return err;
 
-	spin_lock_irqsave(&rtc->lock, flags);
 	ds1685_rtc_switch_to_bank0(rtc);
 
 	/* Read NVRAM in time and bank0 registers. */
@@ -887,7 +874,7 @@ static int ds1685_nvram_read(void *priv, unsigned int pos, void *val,
 		ds1685_rtc_switch_to_bank0(rtc);
 	}
 #endif /* !CONFIG_RTC_DRV_DS1689 */
-	spin_unlock_irqrestore(&rtc->lock, flags);
+	mutex_unlock(rtc_mutex);
 
 	return 0;
 }
@@ -896,11 +883,15 @@ static int ds1685_nvram_write(void *priv, unsigned int pos, void *val,
 			      size_t size)
 {
 	struct ds1685_priv *rtc = priv;
+	struct mutex *rtc_mutex = &rtc->dev->ops_lock;
 	ssize_t count;
-	unsigned long flags = 0;
 	u8 *buf = val;
+	int err;
+
+	err = mutex_lock_interruptible(rtc_mutex);
+	if (err)
+		return err;
 
-	spin_lock_irqsave(&rtc->lock, flags);
 	ds1685_rtc_switch_to_bank0(rtc);
 
 	/* Write NVRAM in time and bank0 registers. */
@@ -950,7 +941,7 @@ static int ds1685_nvram_write(void *priv, unsigned int pos, void *val,
 		ds1685_rtc_switch_to_bank0(rtc);
 	}
 #endif /* !CONFIG_RTC_DRV_DS1689 */
-	spin_unlock_irqrestore(&rtc->lock, flags);
+	mutex_unlock(rtc_mutex);
 
 	return 0;
 }
@@ -1141,9 +1132,7 @@ ds1685_rtc_probe(struct platform_device *pdev)
 	if (pdata->plat_post_ram_clear)
 		rtc->post_ram_clear = pdata->plat_post_ram_clear;
 
-	/* Init the spinlock, workqueue, & set the driver data. */
-	spin_lock_init(&rtc->lock);
-	INIT_WORK(&rtc->work, ds1685_rtc_work_queue);
+	/* set the driver data. */
 	platform_set_drvdata(pdev, rtc);
 
 	/* Turn the oscillator on if is not already on (DV1 = 1). */
@@ -1299,22 +1288,23 @@ ds1685_rtc_probe(struct platform_device *pdev)
 	 */
 	if (!pdata->no_irq) {
 		ret = platform_get_irq(pdev, 0);
-		if (ret > 0) {
-			rtc->irq_num = ret;
-
-			/* Request an IRQ. */
-			ret = devm_request_irq(&pdev->dev, rtc->irq_num,
-					       ds1685_rtc_irq_handler,
-					       IRQF_SHARED, pdev->name, pdev);
-
-			/* Check to see if something came back. */
-			if (unlikely(ret)) {
-				dev_warn(&pdev->dev,
-					 "RTC interrupt not available\n");
-				rtc->irq_num = 0;
-			}
-		} else
+		if (ret <= 0)
 			return ret;
+
+		rtc->irq_num = ret;
+
+		/* Request an IRQ. */
+		ret = devm_request_threaded_irq(&pdev->dev, rtc->irq_num,
+				       NULL, ds1685_rtc_irq_handler,
+				       IRQF_SHARED | IRQF_ONESHOT,
+				       pdev->name, pdev);
+
+		/* Check to see if something came back. */
+		if (unlikely(ret)) {
+			dev_warn(&pdev->dev,
+				 "RTC interrupt not available\n");
+			rtc->irq_num = 0;
+		}
 	}
 	rtc->no_irq = pdata->no_irq;
 
@@ -1361,8 +1351,6 @@ ds1685_rtc_remove(struct platform_device *pdev)
 		   (rtc->read(rtc, RTC_EXT_CTRL_4A) &
 		    ~(RTC_CTRL_4A_RWK_MASK)));
 
-	cancel_work_sync(&rtc->work);
-
 	return 0;
 }
 
diff --git a/include/linux/rtc/ds1685.h b/include/linux/rtc/ds1685.h
index e6337a56d741..a00b332c505f 100644
--- a/include/linux/rtc/ds1685.h
+++ b/include/linux/rtc/ds1685.h
@@ -48,8 +48,6 @@ struct ds1685_priv {
 	u32 regstep;
 	resource_size_t baseaddr;
 	size_t size;
-	spinlock_t lock;
-	struct work_struct work;
 	int irq_num;
 	bool bcd_mode;
 	bool no_irq;
-- 
2.13.7

