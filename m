Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFBEC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850C520693
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfFEOEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:04:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:3583 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfFEOEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:04:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 07:04:41 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jun 2019 07:04:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B8C5E28E; Wed,  5 Jun 2019 17:04:38 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] thunderbolt: Make sure device runtime resume completes before taking domain lock
Date:   Wed,  5 Jun 2019 17:04:38 +0300
Message-Id: <20190605140438.39000-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a device is authorized from userspace by writing to authorized
attribute we first take the domain lock and then runtime resume the
device in question. There are two issues with this.

First is that the device connected notifications are blocked during this
time which means we get them only after the authorization operation is
complete. Because of this the authorization needed flag from the
firmware notification is not reflecting the real authorization status
anymore. So what happens is that the "authorized" keeps returning 0 even
if the device was already authorized properly.

Second issue is that each time the controller is runtime resumed the
connection_id field of device connected notification may be different
than in the previous resume. We need to use the latest connection_id
otherwise the firmware rejects the authorization command.

Fix these by moving runtime resume operations to happen before the
domain lock is taken, and waiting for the updated device connected
notification from the firmware before we allow runtime resume of a
device to complete.

While there add missing locking to tb_switch_nvm_read().

Fixes: 09f11b6c99fe ("thunderbolt: Take domain lock in switch sysfs attribute callbacks")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c    | 54 +++++++++++++++++++++++++++++++++++-
 drivers/thunderbolt/switch.c | 45 ++++++++++++++++++++++--------
 drivers/thunderbolt/tb.h     |  7 +++++
 3 files changed, 93 insertions(+), 13 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index f1c10378fa3e..40a8960b9a7e 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -484,6 +484,7 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
 	sw->authorized = authorized;
 	sw->security_level = security_level;
 	sw->boot = boot;
+	init_completion(&sw->rpm_complete);
 
 	vss = parse_intel_vss(ep_name, ep_name_size);
 	if (vss)
@@ -523,6 +524,9 @@ static void update_switch(struct tb_switch *parent_sw, struct tb_switch *sw,
 
 	/* This switch still exists */
 	sw->is_unplugged = false;
+
+	/* Runtime resume is now complete */
+	complete(&sw->rpm_complete);
 }
 
 static void remove_switch(struct tb_switch *sw)
@@ -1770,6 +1774,32 @@ static void icm_unplug_children(struct tb_switch *sw)
 	}
 }
 
+static int complete_rpm(struct device *dev, void *data)
+{
+	struct tb_switch *sw = tb_to_switch(dev);
+
+	if (sw)
+		complete(&sw->rpm_complete);
+	return 0;
+}
+
+static void remove_unplugged_switch(struct tb_switch *sw)
+{
+	pm_runtime_get_sync(sw->dev.parent);
+
+	/*
+	 * Signal this and switches below for rpm_complete because
+	 * tb_switch_remove() calls pm_runtime_get_sync() that then waits
+	 * for it.
+	 */
+	complete_rpm(&sw->dev, NULL);
+	bus_for_each_dev(&tb_bus_type, &sw->dev, NULL, complete_rpm);
+	tb_switch_remove(sw);
+
+	pm_runtime_mark_last_busy(sw->dev.parent);
+	pm_runtime_put_autosuspend(sw->dev.parent);
+}
+
 static void icm_free_unplugged_children(struct tb_switch *sw)
 {
 	unsigned int i;
@@ -1782,7 +1812,7 @@ static void icm_free_unplugged_children(struct tb_switch *sw)
 			port->xdomain = NULL;
 		} else if (tb_port_has_remote(port)) {
 			if (port->remote->sw->is_unplugged) {
-				tb_switch_remove(port->remote->sw);
+				remove_unplugged_switch(port->remote->sw);
 				port->remote = NULL;
 			} else {
 				icm_free_unplugged_children(port->remote->sw);
@@ -1831,6 +1861,24 @@ static int icm_runtime_suspend(struct tb *tb)
 	return 0;
 }
 
+static int icm_runtime_suspend_switch(struct tb_switch *sw)
+{
+	if (tb_route(sw))
+		reinit_completion(&sw->rpm_complete);
+	return 0;
+}
+
+static int icm_runtime_resume_switch(struct tb_switch *sw)
+{
+	if (tb_route(sw)) {
+		if (!wait_for_completion_timeout(&sw->rpm_complete,
+						 msecs_to_jiffies(500))) {
+			dev_dbg(&sw->dev, "runtime resuming timed out\n");
+		}
+	}
+	return 0;
+}
+
 static int icm_runtime_resume(struct tb *tb)
 {
 	/*
@@ -1910,6 +1958,8 @@ static const struct tb_cm_ops icm_ar_ops = {
 	.complete = icm_complete,
 	.runtime_suspend = icm_runtime_suspend,
 	.runtime_resume = icm_runtime_resume,
+	.runtime_suspend_switch = icm_runtime_suspend_switch,
+	.runtime_resume_switch = icm_runtime_resume_switch,
 	.handle_event = icm_handle_event,
 	.get_boot_acl = icm_ar_get_boot_acl,
 	.set_boot_acl = icm_ar_set_boot_acl,
@@ -1930,6 +1980,8 @@ static const struct tb_cm_ops icm_tr_ops = {
 	.complete = icm_complete,
 	.runtime_suspend = icm_runtime_suspend,
 	.runtime_resume = icm_runtime_resume,
+	.runtime_suspend_switch = icm_runtime_suspend_switch,
+	.runtime_resume_switch = icm_runtime_resume_switch,
 	.handle_event = icm_handle_event,
 	.get_boot_acl = icm_ar_get_boot_acl,
 	.set_boot_acl = icm_ar_set_boot_acl,
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index c1b016574fb4..10b56c66fec3 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -239,7 +239,16 @@ static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
 	int ret;
 
 	pm_runtime_get_sync(&sw->dev);
+
+	if (!mutex_trylock(&sw->tb->lock)) {
+		ret = restart_syscall();
+		goto out;
+	}
+
 	ret = dma_port_flash_read(sw->dma_port, offset, val, bytes);
+	mutex_unlock(&sw->tb->lock);
+
+out:
 	pm_runtime_mark_last_busy(&sw->dev);
 	pm_runtime_put_autosuspend(&sw->dev);
 
@@ -1019,7 +1028,6 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 	 * the new tunnel too early.
 	 */
 	pci_lock_rescan_remove();
-	pm_runtime_get_sync(&sw->dev);
 
 	switch (val) {
 	/* Approve switch */
@@ -1040,8 +1048,6 @@ static int tb_switch_set_authorized(struct tb_switch *sw, unsigned int val)
 		break;
 	}
 
-	pm_runtime_mark_last_busy(&sw->dev);
-	pm_runtime_put_autosuspend(&sw->dev);
 	pci_unlock_rescan_remove();
 
 	if (!ret) {
@@ -1069,7 +1075,10 @@ static ssize_t authorized_store(struct device *dev,
 	if (val > 2)
 		return -EINVAL;
 
+	pm_runtime_get_sync(&sw->dev);
 	ret = tb_switch_set_authorized(sw, val);
+	pm_runtime_mark_last_busy(&sw->dev);
+	pm_runtime_put_autosuspend(&sw->dev);
 
 	return ret ? ret : count;
 }
@@ -1195,8 +1204,12 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 	bool val;
 	int ret;
 
-	if (!mutex_trylock(&sw->tb->lock))
-		return restart_syscall();
+	pm_runtime_get_sync(&sw->dev);
+
+	if (!mutex_trylock(&sw->tb->lock)) {
+		ret = restart_syscall();
+		goto exit_rpm;
+	}
 
 	/* If NVMem devices are not yet added */
 	if (!sw->nvm) {
@@ -1217,13 +1230,9 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 			goto exit_unlock;
 		}
 
-		pm_runtime_get_sync(&sw->dev);
 		ret = nvm_validate_and_write(sw);
-		if (ret) {
-			pm_runtime_mark_last_busy(&sw->dev);
-			pm_runtime_put_autosuspend(&sw->dev);
+		if (ret)
 			goto exit_unlock;
-		}
 
 		sw->nvm->authenticating = true;
 
@@ -1239,12 +1248,13 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 		} else {
 			ret = nvm_authenticate_device(sw);
 		}
-		pm_runtime_mark_last_busy(&sw->dev);
-		pm_runtime_put_autosuspend(&sw->dev);
 	}
 
 exit_unlock:
 	mutex_unlock(&sw->tb->lock);
+exit_rpm:
+	pm_runtime_mark_last_busy(&sw->dev);
+	pm_runtime_put_autosuspend(&sw->dev);
 
 	if (ret)
 		return ret;
@@ -1380,11 +1390,22 @@ static void tb_switch_release(struct device *dev)
  */
 static int __maybe_unused tb_switch_runtime_suspend(struct device *dev)
 {
+	struct tb_switch *sw = tb_to_switch(dev);
+	const struct tb_cm_ops *cm_ops = sw->tb->cm_ops;
+
+	if (cm_ops->runtime_suspend_switch)
+		return cm_ops->runtime_suspend_switch(sw);
+
 	return 0;
 }
 
 static int __maybe_unused tb_switch_runtime_resume(struct device *dev)
 {
+	struct tb_switch *sw = tb_to_switch(dev);
+	const struct tb_cm_ops *cm_ops = sw->tb->cm_ops;
+
+	if (cm_ops->runtime_resume_switch)
+		return cm_ops->runtime_resume_switch(sw);
 	return 0;
 }
 
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index b12c8f33d89c..6407d529871d 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -79,6 +79,8 @@ struct tb_switch_nvm {
  * @connection_key: Connection key used with ICM messaging
  * @link: Root switch link this switch is connected (ICM only)
  * @depth: Depth in the chain this switch is connected (ICM only)
+ * @rpm_complete: Completion used to wait for runtime resume to
+ *		  complete (ICM only)
  *
  * When the switch is being added or removed to the domain (other
  * switches) you need to have domain lock held.
@@ -112,6 +114,7 @@ struct tb_switch {
 	u8 connection_key;
 	u8 link;
 	u8 depth;
+	struct completion rpm_complete;
 };
 
 /**
@@ -250,6 +253,8 @@ struct tb_path {
  * @complete: Connection manager specific complete
  * @runtime_suspend: Connection manager specific runtime_suspend
  * @runtime_resume: Connection manager specific runtime_resume
+ * @runtime_suspend_switch: Runtime suspend a switch
+ * @runtime_resume_switch: Runtime resume a switch
  * @handle_event: Handle thunderbolt event
  * @get_boot_acl: Get boot ACL list
  * @set_boot_acl: Set boot ACL list
@@ -270,6 +275,8 @@ struct tb_cm_ops {
 	void (*complete)(struct tb *tb);
 	int (*runtime_suspend)(struct tb *tb);
 	int (*runtime_resume)(struct tb *tb);
+	int (*runtime_suspend_switch)(struct tb_switch *sw);
+	int (*runtime_resume_switch)(struct tb_switch *sw);
 	void (*handle_event)(struct tb *tb, enum tb_cfg_pkg_type,
 			     const void *buf, size_t size);
 	int (*get_boot_acl)(struct tb *tb, uuid_t *uuids, size_t nuuids);
-- 
2.20.1

