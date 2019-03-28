Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4416C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5202082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfC1Mkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:40:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:34145 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbfC1Mgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:36:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2019 05:36:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,280,1549958400"; 
   d="scan'208";a="138009638"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2019 05:36:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 08D086AA; Thu, 28 Mar 2019 14:36:34 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH v3 05/36] thunderbolt: Take domain lock in switch sysfs attribute callbacks
Date:   Thu, 28 Mar 2019 15:36:02 +0300
Message-Id: <20190328123633.42882-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
References: <20190328123633.42882-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

switch_lock was introduced because it allowed serialization of device
authorization requests from userspace without need to take the big
domain lock (tb->lock). This was fine because device authorization with
ICM is just one command that is sent to the firmware. Now that we start
to handle all tunneling in the driver switch_lock is not enough because
we need to walk over the topology to establish paths.

For this reason drop switch_lock from the driver completely in favour of
big domain lock.

There is one complication, though. If userspace is waiting for the lock
in tb_switch_set_authorized(), it keeps the device_del() from removing
the sysfs attribute because it waits for active users to release the
attribute first which leads into following splat:

    INFO: task kworker/u8:3:73 blocked for more than 61 seconds.
          Tainted: G        W         5.1.0-rc1+ #244
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    kworker/u8:3    D12976    73      2 0x80000000
    Workqueue: thunderbolt0 tb_handle_hotplug [thunderbolt]
    Call Trace:
     ? __schedule+0x2e5/0x740
     ? _raw_spin_lock_irqsave+0x12/0x40
     ? prepare_to_wait_event+0xc5/0x160
     schedule+0x2d/0x80
     __kernfs_remove.part.17+0x183/0x1f0
     ? finish_wait+0x80/0x80
     kernfs_remove_by_name_ns+0x4a/0x90
     remove_files.isra.1+0x2b/0x60
     sysfs_remove_group+0x38/0x80
     sysfs_remove_groups+0x24/0x40
     device_remove_attrs+0x3d/0x70
     device_del+0x14c/0x360
     device_unregister+0x15/0x50
     tb_switch_remove+0x9e/0x1d0 [thunderbolt]
     tb_handle_hotplug+0x119/0x5a0 [thunderbolt]
     ? process_one_work+0x1b7/0x420
     process_one_work+0x1b7/0x420
     worker_thread+0x37/0x380
     ? _raw_spin_unlock_irqrestore+0xf/0x30
     ? process_one_work+0x420/0x420
     kthread+0x118/0x130
     ? kthread_create_on_node+0x60/0x60
     ret_from_fork+0x35/0x40

We deal this by following what network stack did for some of their
attributes and use mutex_trylock() with restart_syscall(). This makes
userspace release the attribute allowing sysfs attribute removal to
progress before the write is restarted and eventually fail when the
attribute is removed.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/switch.c | 45 +++++++++++++++---------------------
 drivers/thunderbolt/tb.h     |  3 +--
 2 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 5c2c0201ae7f..7fa4ab076404 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -10,15 +10,13 @@
 #include <linux/idr.h>
 #include <linux/nvmem-provider.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched/signal.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
 #include "tb.h"
 
-/* Switch authorization from userspace is serialized by this lock */
-static DEFINE_MUTEX(switch_lock);
-
 /* Switch NVM support */
 
 #define NVM_DEVID		0x05
@@ -254,8 +252,8 @@ static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
 	struct tb_switch *sw = priv;
 	int ret = 0;
 
-	if (mutex_lock_interruptible(&switch_lock))
-		return -ERESTARTSYS;
+	if (!mutex_trylock(&sw->tb->lock))
+		return restart_syscall();
 
 	/*
 	 * Since writing the NVM image might require some special steps,
@@ -275,7 +273,7 @@ static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
 	memcpy(sw->nvm->buf + offset, val, bytes);
 
 unlock:
-	mutex_unlock(&switch_lock);
+	mutex_unlock(&sw->tb->lock);
 
 	return ret;
 }
@@ -364,10 +362,7 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
 	}
 	nvm->non_active = nvm_dev;
 
-	mutex_lock(&switch_lock);
 	sw->nvm = nvm;
-	mutex_unlock(&switch_lock);
-
 	return 0;
 
 err_nvm_active:
@@ -384,10 +379,8 @@ static void tb_switch_nvm_remove(struct tb_switch *sw)
 {
 	struct tb_switch_nvm *nvm;
 
-	mutex_lock(&switch_lock);
 	nvm = sw->nvm;
 	sw->nvm = NULL;
-	mutex_unlock(&switch_lock);
 
 	if (!nvm)
 		return;
@@ -698,8 +691,8 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 {
 	int ret = -EINVAL;
 
-	if (mutex_lock_interruptible(&switch_lock))
-		return -ERESTARTSYS;
+	if (!mutex_trylock(&sw->tb->lock))
+		return restart_syscall();
 
 	if (sw->authorized)
 		goto unlock;
@@ -742,7 +735,7 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 	}
 
 unlock:
-	mutex_unlock(&switch_lock);
+	mutex_unlock(&sw->tb->lock);
 	return ret;
 }
 
@@ -799,15 +792,15 @@ static ssize_t key_show(struct device *dev, struct device_attribute *attr,
 	struct tb_switch *sw = tb_to_switch(dev);
 	ssize_t ret;
 
-	if (mutex_lock_interruptible(&switch_lock))
-		return -ERESTARTSYS;
+	if (!mutex_trylock(&sw->tb->lock))
+		return restart_syscall();
 
 	if (sw->key)
 		ret = sprintf(buf, "%*phN\n", TB_SWITCH_KEY_SIZE, sw->key);
 	else
 		ret = sprintf(buf, "\n");
 
-	mutex_unlock(&switch_lock);
+	mutex_unlock(&sw->tb->lock);
 	return ret;
 }
 
@@ -824,8 +817,8 @@ static ssize_t key_store(struct device *dev, struct device_attribute *attr,
 	else if (hex2bin(key, buf, sizeof(key)))
 		return -EINVAL;
 
-	if (mutex_lock_interruptible(&switch_lock))
-		return -ERESTARTSYS;
+	if (!mutex_trylock(&sw->tb->lock))
+		return restart_syscall();
 
 	if (sw->authorized) {
 		ret = -EBUSY;
@@ -840,7 +833,7 @@ static ssize_t key_store(struct device *dev, struct device_attribute *attr,
 		}
 	}
 
-	mutex_unlock(&switch_lock);
+	mutex_unlock(&sw->tb->lock);
 	return ret;
 }
 static DEVICE_ATTR(key, 0600, key_show, key_store);
@@ -886,8 +879,8 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 	bool val;
 	int ret;
 
-	if (mutex_lock_interruptible(&switch_lock))
-		return -ERESTARTSYS;
+	if (!mutex_trylock(&sw->tb->lock))
+		return restart_syscall();
 
 	/* If NVMem devices are not yet added */
 	if (!sw->nvm) {
@@ -935,7 +928,7 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 	}
 
 exit_unlock:
-	mutex_unlock(&switch_lock);
+	mutex_unlock(&sw->tb->lock);
 
 	if (ret)
 		return ret;
@@ -949,8 +942,8 @@ static ssize_t nvm_version_show(struct device *dev,
 	struct tb_switch *sw = tb_to_switch(dev);
 	int ret;
 
-	if (mutex_lock_interruptible(&switch_lock))
-		return -ERESTARTSYS;
+	if (!mutex_trylock(&sw->tb->lock))
+		return restart_syscall();
 
 	if (sw->safe_mode)
 		ret = -ENODATA;
@@ -959,7 +952,7 @@ static ssize_t nvm_version_show(struct device *dev,
 	else
 		ret = sprintf(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);
 
-	mutex_unlock(&switch_lock);
+	mutex_unlock(&sw->tb->lock);
 
 	return ret;
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 496dcd03ede1..f7b0c43c29a7 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -79,8 +79,7 @@ struct tb_switch_nvm {
  * @depth: Depth in the chain this switch is connected (ICM only)
  *
  * When the switch is being added or removed to the domain (other
- * switches) you need to have domain lock held. For switch authorization
- * internal switch_lock is enough.
+ * switches) you need to have domain lock held.
  */
 struct tb_switch {
 	struct device dev;
-- 
2.20.1

