Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E226C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C908620873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YXaZz+Io"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfEOQso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:48:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46893 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfEOQsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:48:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id y11so242385pfm.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 09:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SA6XP/SrU8GBZ8LK7dIo2QEJ5JuM6ZumrrXEJ51rAOE=;
        b=YXaZz+IoxGdKE+T1gOBvgUoKE3yqyYvIEElIJJ2ZvcGPRltTapq3G/F7WAguAOumrB
         0yStrldQ5nxxNKG3cvucVEBVVelb5LSA07Xoeu29t0S/3RxQTT1wGKRgC2vmVpehJmny
         dlxrdfiwU2JltUbrzlihXwUYNFOZUi23q+ggY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SA6XP/SrU8GBZ8LK7dIo2QEJ5JuM6ZumrrXEJ51rAOE=;
        b=XIKcKu+6q7R9THmplHXpT5NzAKeV63f/4Pb3hEoZAZPn0BSGp4xGigkb+aCheuYUd7
         yy3M5Xv38GJIa5HRY5uK/jbIT0laFDJFfsXcMqCJnOaUSiywFIk4cATKxFdFmU2iPScd
         teRDkRlVNp+srqchb8spkMLoTo35jFeDIMhQdGooLnDmOll/BB6m8MUiyubuMiWz6/TQ
         XnCrAMUnQmaqllKx0qHDbIXJ0t+HlOpo/5WxrVU+FTAjoYkdGTMzN+fXt7YoeayDaXw9
         +XNcVwdJShDdSRj1tfxuai5kaHpruL0lzqcrHLOed6ox6CH8iRDDeZgC0Y+2pHHYtq9K
         iMQQ==
X-Gm-Message-State: APjAAAU2ylzECNF2fPeHSLukEn90Wm4F5vckGRbY+4umphhANWLMmX9F
        7doASa+XWV11YnVWKFLXmSvogQ==
X-Google-Smtp-Source: APXvYqyHs9DEjBIX/dI8GwaBa0j/exwXgUtBTc1Opagli/OHd9G8fSXnqCLRUWhB3JerSQ90pCWaOA==
X-Received: by 2002:a63:4346:: with SMTP id q67mr45004460pga.241.1557938922003;
        Wed, 15 May 2019 09:48:42 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id h16sm6914595pfj.114.2019.05.15.09.48.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 09:48:41 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, drinkcat@chromium.org,
        Guenter Roeck <groeck@chromium.org>, briannorris@chromium.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] platform/chrome: cros_ec_spi: Move to real time priority for transfers
Date:   Wed, 15 May 2019 09:48:11 -0700
Message-Id: <20190515164814.258898-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190515164814.258898-1-dianders@chromium.org>
References: <20190515164814.258898-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 37a186225a0c ("platform/chrome: cros_ec_spi: Transfer
messages at high priority") we moved transfers to a high priority
workqueue.  This helped make them much more reliable.

...but, we still saw failures.

We were actually finding ourselves competing for time with dm-crypt
which also scheduled work on HIGHPRI workqueues.  While we can
consider reverting the change that made dm-crypt run its work at
HIGHPRI, the argument in commit a1b89132dc4f ("dm crypt: use
WQ_HIGHPRI for the IO and crypt workqueues") is somewhat compelling.
It does make sense for IO to be scheduled at a priority that's higher
than the default user priority.  It also turns out that dm-crypt isn't
alone in using high priority like this.  loop_prepare_queue() does
something similar for loopback devices.

Looking in more detail, it can be seen that the high priority
workqueue isn't actually that high of a priority.  It runs at MIN_NICE
which is _fairly_ high priority but still below all real time
priority.

Should we move cros_ec_spi to real time priority to fix our problems,
or is this just escalating a priority war?  I'll argue here that
cros_ec_spi _does_ belong at real time priority.  Specifically
cros_ec_spi actually needs to run quickly for correctness.  As I
understand this is exactly what real time priority is for.

There currently doesn't appear to be any way to use the standard
workqueue APIs with a real time priority, so we'll switch over to
using using a kthread worker.  We'll match the priority that the SPI
core uses when it wants to do things on a realtime thread and just use
"MAX_RT_PRIO - 1".

This commit plus the patch ("platform/chrome: cros_ec_spi: Request the
SPI thread be realtime") are enough to get communications very close
to 100% reliable (the only known problem left is when serial console
is turned on, which isn't something that happens in shipping devices).
Specifically this test case now passes (tested on rk3288-veyron-jerry):

  dd if=/dev/zero of=/var/log/foo.txt bs=4M count=512&
  while true; do
    ectool version > /dev/null;
  done

It should be noted that "/var/log" is encrypted (and goes through
dm-crypt) and also passes through a loopback device.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- No needless init of err in cros_ec_spi_devm_high_pri_alloc (Guenter).
- Removed blank lines near #includes (Guenter).
- Switch to kthread_create_worker() and fix error handling (Guenter).
- Cleaner devm code (Guenter).

Changes in v3:
- cros_ec realtime patch replaces revert; now patch #1

Changes in v2: None

 drivers/platform/chrome/cros_ec_spi.c | 65 ++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 8e9451720e73..1e38a885c539 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -12,7 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
-
+#include <uapi/linux/sched/types.h>
 
 /* The header byte, which follows the preamble */
 #define EC_MSG_HEADER			0xec
@@ -67,12 +67,14 @@
  *      is sent when we want to turn on CS at the start of a transaction.
  * @end_of_msg_delay: used to set the delay_usecs on the spi_transfer that
  *      is sent when we want to turn off CS at the end of a transaction.
+ * @high_pri_worker: Used to schedule high priority work.
  */
 struct cros_ec_spi {
 	struct spi_device *spi;
 	s64 last_transfer_ns;
 	unsigned int start_of_msg_delay;
 	unsigned int end_of_msg_delay;
+	struct kthread_worker *high_pri_worker;
 };
 
 typedef int (*cros_ec_xfer_fn_t) (struct cros_ec_device *ec_dev,
@@ -89,7 +91,7 @@ typedef int (*cros_ec_xfer_fn_t) (struct cros_ec_device *ec_dev,
  */
 
 struct cros_ec_xfer_work_params {
-	struct work_struct work;
+	struct kthread_work work;
 	cros_ec_xfer_fn_t fn;
 	struct cros_ec_device *ec_dev;
 	struct cros_ec_command *ec_msg;
@@ -632,7 +634,7 @@ static int do_cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	return ret;
 }
 
-static void cros_ec_xfer_high_pri_work(struct work_struct *work)
+static void cros_ec_xfer_high_pri_work(struct kthread_work *work)
 {
 	struct cros_ec_xfer_work_params *params;
 
@@ -644,12 +646,14 @@ static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,
 				 struct cros_ec_command *ec_msg,
 				 cros_ec_xfer_fn_t fn)
 {
-	struct cros_ec_xfer_work_params params;
-
-	INIT_WORK_ONSTACK(&params.work, cros_ec_xfer_high_pri_work);
-	params.ec_dev = ec_dev;
-	params.ec_msg = ec_msg;
-	params.fn = fn;
+	struct cros_ec_spi *ec_spi = ec_dev->priv;
+	struct cros_ec_xfer_work_params params = {
+		.work = KTHREAD_WORK_INIT(params.work,
+					  cros_ec_xfer_high_pri_work),
+		.ec_dev = ec_dev,
+		.ec_msg = ec_msg,
+		.fn = fn,
+	};
 
 	/*
 	 * This looks a bit ridiculous.  Why do the work on a
@@ -660,9 +664,8 @@ static int cros_ec_xfer_high_pri(struct cros_ec_device *ec_dev,
 	 * context switched out for too long and the EC giving up on
 	 * the transfer.
 	 */
-	queue_work(system_highpri_wq, &params.work);
-	flush_work(&params.work);
-	destroy_work_on_stack(&params.work);
+	kthread_queue_work(ec_spi->high_pri_worker, &params.work);
+	kthread_flush_work(&params.work);
 
 	return params.ret;
 }
@@ -694,6 +697,40 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
 		ec_spi->end_of_msg_delay = val;
 }
 
+static void cros_ec_spi_high_pri_release(void *worker)
+{
+	kthread_destroy_worker(worker);
+}
+
+static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
+					   struct cros_ec_spi *ec_spi)
+{
+	struct sched_param sched_priority = {
+		.sched_priority = MAX_RT_PRIO - 1,
+	};
+	int err;
+
+	ec_spi->high_pri_worker =
+		kthread_create_worker(0, "cros_ec_spi_high_pri");
+
+	if (IS_ERR(ec_spi->high_pri_worker)) {
+		err = PTR_ERR(ec_spi->high_pri_worker);
+		dev_err(dev, "Can't create cros_ec high pri worker: %d\n", err);
+		return err;
+	}
+
+	err = devm_add_action_or_reset(dev, cros_ec_spi_high_pri_release,
+				       ec_spi->high_pri_worker);
+	if (err)
+		return err;
+
+	err = sched_setscheduler_nocheck(ec_spi->high_pri_worker->task,
+					 SCHED_FIFO, &sched_priority);
+	if (err)
+		dev_err(dev, "Can't set cros_ec high pri priority: %d\n", err);
+	return err;
+}
+
 static int cros_ec_spi_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -732,6 +769,10 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 
 	ec_spi->last_transfer_ns = ktime_get_ns();
 
+	err = cros_ec_spi_devm_high_pri_alloc(dev, ec_spi);
+	if (err)
+		return err;
+
 	err = cros_ec_register(ec_dev);
 	if (err) {
 		dev_err(dev, "cannot register EC\n");
-- 
2.21.0.1020.gf2820cf01a-goog

