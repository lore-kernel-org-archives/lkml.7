Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E075BC7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3032239E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbfGWLTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:19:35 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:57447 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726709AbfGWLTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:19:34 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from haswell.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 17532000-1500050 
        for multiple; Tue, 23 Jul 2019 12:19:15 +0100
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH] mei: Abort writes if incomplete after 1s
Date:   Tue, 23 Jul 2019 12:19:13 +0100
Message-Id: <20190723111913.20475-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During i915 unload, it appears that it may get stuck waiting on a
workqueue being hogged by mei:

<7> [212.666912] i915 0000:00:02.0: [drm:drm_client_release] drm_fb_helper
<3> [308.544943] INFO: task i915_module_loa:2612 blocked for more than 61 seconds.
<3> [308.545047]       Tainted: G     U  W         5.3.0-rc1-CI-CI_DRM_6537+ #1
<3> [308.545085] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
<6> [308.545128] i915_module_loa D13256  2612    960 0x00004004
<4> [308.545137] Call Trace:
<4> [308.545150]  ? __schedule+0x326/0x890
<4> [308.545159]  ? wait_for_common+0x116/0x1f0
<4> [308.545164]  schedule+0x2b/0xb0
<4> [308.545169]  schedule_timeout+0x219/0x3c0
<4> [308.545176]  ? wait_for_common+0x132/0x1f0
<4> [308.545183]  ? _raw_spin_unlock_irq+0x24/0x30
<4> [308.545189]  ? wait_for_common+0x116/0x1f0
<4> [308.545193]  wait_for_common+0x13a/0x1f0
<4> [308.545200]  ? wake_up_q+0x80/0x80
<4> [308.545209]  flush_workqueue+0x19d/0x540
<4> [308.545334]  ? intel_modeset_driver_remove+0xb3/0x140 [i915]
<4> [308.545407]  intel_modeset_driver_remove+0xb3/0x140 [i915]
<4> [308.545464]  i915_driver_remove+0xae/0x110 [i915]
<4> [308.545522]  i915_pci_remove+0x19/0x30 [i915]
<4> [308.545529]  pci_device_remove+0x36/0xb0

<6> [308.565422] Showing busy workqueues and worker pools:
<6> [308.565425] workqueue events: flags=0x0
<6> [308.565572]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=2/256
<6> [308.565635]     in-flight: 441:mei_cl_bus_rescan_work [mei]
<6> [308.565641]     pending: dbs_work_handler
<6> [308.565686] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=0s workers=5 idle: 2248 21 17 169

<6> [308.553788] Workqueue: events mei_cl_bus_rescan_work [mei]
<4> [308.553792] Call Trace:
<4> [308.553799]  ? __schedule+0x326/0x890
<4> [308.553808]  schedule+0x2b/0xb0
<4> [308.553815]  mei_cl_write+0x430/0x5a0 [mei]
<4> [308.553820]  ? __kmalloc+0x2b6/0x330
<4> [308.553824]  ? wait_woken+0xa0/0xa0
<4> [308.553835]  __mei_cl_send+0x1f4/0x240 [mei]
<4> [308.553848]  mei_mkhi_fix+0x91/0x280 [mei]
<4> [308.553859]  mei_cl_bus_dev_fixup+0xba/0x100 [mei]
<4> [308.553868]  ? device_add+0x156/0x670
<4> [308.553889]  ? mei_cl_bus_rescan_work+0x1bc/0x350 [mei]
<4> [308.553896]  mei_cl_bus_rescan_work+0x1bc/0x350 [mei]
<4> [308.553905]  process_one_work+0x245/0x5f0
<4> [308.553915]  worker_thread+0x37/0x380
<4> [308.553921]  ? process_one_work+0x5f0/0x5f0
<4> [308.553924]  kthread+0x119/0x130
<4> [308.553928]  ? kthread_park+0xa0/0xa0
<4> [308.553934]  ret_from_fork+0x3a/0x50

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c    |  9 +++++++--
 drivers/misc/mei/client.c |  5 +++--
 drivers/misc/mei/main.c   | 18 ++++++++++++++----
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 985bd4fd3328..5b2db77d48db 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -66,9 +66,10 @@ ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length,
 
 	while (cl->tx_cb_queued >= bus->tx_queue_limit) {
 		mutex_unlock(&bus->device_lock);
-		rets = wait_event_interruptible(cl->tx_wait,
+		rets = wait_event_interruptible_timeout(cl->tx_wait,
 				cl->writing_state == MEI_WRITE_COMPLETE ||
-				(!mei_cl_is_connected(cl)));
+				!mei_cl_is_connected(cl),
+				HZ);
 		mutex_lock(&bus->device_lock);
 		if (rets) {
 			if (signal_pending(current))
@@ -79,6 +80,10 @@ ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length,
 			rets = -ENODEV;
 			goto out;
 		}
+		if (cl->writing_state != MEI_WRITE_COMPLETE) {
+			rets = -EFAULT;
+			goto out;
+		}
 	}
 
 	cb = mei_cl_alloc_cb(cl, length, MEI_FOP_WRITE, NULL);
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 1e3edbbacb1e..e7acc8aa9b15 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1767,9 +1767,10 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb)
 	if (blocking && cl->writing_state != MEI_WRITE_COMPLETE) {
 
 		mutex_unlock(&dev->device_lock);
-		rets = wait_event_interruptible(cl->tx_wait,
+		rets = wait_event_interruptible_timeout(cl->tx_wait,
 				cl->writing_state == MEI_WRITE_COMPLETE ||
-				(!mei_cl_is_connected(cl)));
+				!mei_cl_is_connected(cl),
+				HZ);
 		mutex_lock(&dev->device_lock);
 		/* wait_event_interruptible returns -ERESTARTSYS */
 		if (rets) {
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index f894d1f8a53e..0eb7bfd89a90 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -294,9 +294,10 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 			goto out;
 		}
 		mutex_unlock(&dev->device_lock);
-		rets = wait_event_interruptible(cl->tx_wait,
+		rets = wait_event_interruptible_timeout(cl->tx_wait,
 				cl->writing_state == MEI_WRITE_COMPLETE ||
-				(!mei_cl_is_connected(cl)));
+				!mei_cl_is_connected(cl),
+				HZ);
 		mutex_lock(&dev->device_lock);
 		if (rets) {
 			if (signal_pending(current))
@@ -307,6 +308,10 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 			rets = -ENODEV;
 			goto out;
 		}
+		if (cl->writing_state != MEI_WRITE_COMPLETE) {
+			rets = -EFAULT;
+			goto out;
+		}
 	}
 
 	cb = mei_cl_alloc_cb(cl, length, MEI_FOP_WRITE, file);
@@ -658,9 +663,10 @@ static int mei_fsync(struct file *fp, loff_t start, loff_t end, int datasync)
 
 	while (mei_cl_is_write_queued(cl)) {
 		mutex_unlock(&dev->device_lock);
-		rets = wait_event_interruptible(cl->tx_wait,
+		rets = wait_event_interruptible_timeout(cl->tx_wait,
 				cl->writing_state == MEI_WRITE_COMPLETE ||
-				!mei_cl_is_connected(cl));
+				!mei_cl_is_connected(cl),
+				HZ);
 		mutex_lock(&dev->device_lock);
 		if (rets) {
 			if (signal_pending(current))
@@ -671,6 +677,10 @@ static int mei_fsync(struct file *fp, loff_t start, loff_t end, int datasync)
 			rets = -ENODEV;
 			goto out;
 		}
+		if (cl->writing_state != MEI_WRITE_COMPLETE) {
+			rets = -EFAULT;
+			goto out;
+		}
 	}
 	rets = 0;
 out:
-- 
2.22.0

