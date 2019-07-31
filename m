Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A163C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204C5206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG41tlaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfGaM7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:59:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35193 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbfGaM7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:59:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so59713165wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=btumgzYkhHpCUX5KK3pciksGHnoHCcgXySLqpg2BqIM=;
        b=HG41tlaTZ6mWC40sOZdNq74aF2pQ6WmGyT8TvccPQ/YxKRYDxSiGtiC3tSYQ9ifNEt
         IHeBx3BVzhRLsxnpOIDtLvk4teklVHqJdkJD5PvQuQbFvddHoRMJV+jncRxcDtFpKsku
         gxzEcCFcImihZkd5LOVnDFBZxwvanNwnKfzx1ACI+cS17WDAyDmyRsT2hISVH/uDp7Re
         9Rs/4ixQHsfvFzg0BVJpJGGNk47WipVdcRvEhplJpKH1ZVQWc/hWG6akBYtzfbgQBpF9
         Jzj4Tcs92UkBeLrcLLhgXH54tpGxoBH+8j0/8zoCBg7dzQs7zfs4VMmxnp+PXGhF3dMi
         k/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=btumgzYkhHpCUX5KK3pciksGHnoHCcgXySLqpg2BqIM=;
        b=YpfdkZmnmeOBHFsnmVsEhSC45aKjTjhP6r0z7B/V9Ctbljb0hVRJwpmmvYgXMXZnYy
         2U3XwHnPiQyu036L/Q+CSd0prb51FVHwpe7Y2DfdH4HhZ5vtLCp3EAemnXSiz+bCgZCw
         vGia/g950qmHgyf4Pdk0O7F7ZQuj/iql+/TXB0R7ZIsT4TCh88KjrX2wYvcKbu+1oJ23
         CBf9AJ6gW5Igv/CqVw/KRvuQ4/j5oOB+EvOud+rV43lFnr5vk4ZQrAdTHOAcmv4F6GKx
         AYijFc7YlHQl8fVjt9zJYuMpGk1ToO15/O1bHFsKglxf4KGokOTNxzSbqdGH56BJrQiy
         9BMQ==
X-Gm-Message-State: APjAAAUrsmkDkC20S2N/2KJC3KVi6WGjqHMEJZLrvn+1EZhinCm9Vg/x
        21Y+OhL36mwY4Mnc7lB/EJG8Xzs3kVw=
X-Google-Smtp-Source: APXvYqwcUTRTDMYX9yIQb/VaNoRBBYWo8h9dEs6lngMgbZ0SOpaHNuwgM2RY6oL4Oxixu8jzpnWcNQ==
X-Received: by 2002:a1c:35c2:: with SMTP id c185mr109246216wma.58.1564577953162;
        Wed, 31 Jul 2019 05:59:13 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c6sm69247800wma.25.2019.07.31.05.59.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:59:12 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v3 7/7] habanalabs: create two char devices per ASIC
Date:   Wed, 31 Jul 2019 15:59:01 +0300
Message-Id: <20190731125901.20709-8-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731125901.20709-1-oded.gabbay@gmail.com>
References: <20190731125901.20709-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the driver to create two char devices for each ASIC
it discovers. This is done to allow system/monitoring applications to
query the device for stats, information, idle state and more, while also
allowing the deep-learning application to send work to the ASIC.

One char device is the original device, hlX. IOCTL calls through this
device file can perform any task on the device (compute, memory, queries).
The open function for this device will fail if it was called before but
the file-descriptor it created was not completely released yet (the
release callback function is not called from the kernel until all
instances of that FD are closed). The driver needs to keep this behavior
to support backward compatibility with existing userspace, which count
that the open will fail if the device is "occupied".

The second char device is called "hl_controlDx", where x is the same index
of the main device with a minor number of the original char device + 1.
Applications that open this device can only call the INFO IOCTL. There is
no limitation on the number of applications opening this device.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v3:
- control device use minor of main + 1
- remove simulator code
 
 drivers/misc/habanalabs/device.c           | 53 +++++++++++-
 drivers/misc/habanalabs/habanalabs.h       | 14 +++-
 drivers/misc/habanalabs/habanalabs_drv.c   | 89 +++++++++++++++-----
 drivers/misc/habanalabs/habanalabs_ioctl.c | 95 +++++++++++++++-------
 4 files changed, 199 insertions(+), 52 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 60c779648f92..efde1fe7d286 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -95,6 +95,24 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static int hl_device_release_ctrl(struct inode *inode, struct file *filp)
+{
+	struct hl_fpriv *hpriv = filp->private_data;
+	struct hl_device *hdev;
+
+	filp->private_data = NULL;
+
+	hdev = hpriv->hdev;
+
+	mutex_lock(&hdev->fpriv_list_lock);
+	list_del(&hpriv->dev_node);
+	mutex_unlock(&hdev->fpriv_list_lock);
+
+	kfree(hpriv);
+
+	return 0;
+}
+
 /*
  * hl_mmap - mmap function for habanalabs device
  *
@@ -125,6 +143,14 @@ static const struct file_operations hl_ops = {
 	.compat_ioctl = hl_ioctl
 };
 
+static const struct file_operations hl_ctrl_ops = {
+	.owner = THIS_MODULE,
+	.open = hl_device_open_ctrl,
+	.release = hl_device_release_ctrl,
+	.unlocked_ioctl = hl_ioctl_control,
+	.compat_ioctl = hl_ioctl_control
+};
+
 /*
  * device_setup_cdev - setup cdev and device for habanalabs device
  *
@@ -567,7 +593,8 @@ static void device_kill_open_processes(struct hl_device *hdev)
 	list_for_each_entry(hpriv, &hdev->fpriv_list, dev_node) {
 		task = get_pid_task(hpriv->taskpid, PIDTYPE_PID);
 		if (task) {
-			dev_info(hdev->dev, "Killing user process\n");
+			dev_info(hdev->dev, "Killing user process pid=%d\n",
+				task_pid_nr(task));
 			send_sig(SIGKILL, task, 1);
 			usleep_range(1000, 10000);
 
@@ -872,7 +899,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	int i, rc, cq_ready_cnt;
 	char *name;
 
-	name = kasprintf(GFP_KERNEL, "hl%d", hdev->id);
+	name = kasprintf(GFP_KERNEL, "hl%d", hdev->id / 2);
 	if (!name)
 		return -ENOMEM;
 
@@ -885,10 +912,25 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	if (rc)
 		goto out_disabled;
 
+	name = kasprintf(GFP_KERNEL, "hl_controlD%d", hdev->id / 2);
+	if (!name) {
+		rc = -ENOMEM;
+		goto release_device;
+	}
+
+	/* Create control device */
+	rc = device_setup_cdev(hdev, hclass, hdev->id_control, &hl_ctrl_ops,
+				name, &hdev->cdev_ctrl, &hdev->dev_ctrl);
+
+	kfree(name);
+
+	if (rc)
+		goto release_device;
+
 	/* Initialize ASIC function pointers and perform early init */
 	rc = device_early_init(hdev);
 	if (rc)
-		goto release_device;
+		goto release_control_device;
 
 	/*
 	 * Start calling ASIC initialization. First S/W then H/W and finally
@@ -1064,6 +1106,9 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	hdev->asic_funcs->sw_fini(hdev);
 early_fini:
 	device_early_fini(hdev);
+release_control_device:
+	device_destroy(hclass, hdev->dev_ctrl->devt);
+	cdev_del(&hdev->cdev_ctrl);
 release_device:
 	device_destroy(hclass, hdev->dev->devt);
 	cdev_del(&hdev->cdev);
@@ -1179,6 +1224,8 @@ void hl_device_fini(struct hl_device *hdev)
 	device_early_fini(hdev);
 
 	/* Hide device from user */
+	device_destroy(hdev->dev_ctrl->class, hdev->dev_ctrl->devt);
+	cdev_del(&hdev->cdev_ctrl);
 	device_destroy(hdev->dev->class, hdev->dev->devt);
 	cdev_del(&hdev->cdev);
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index f2ca06b2c155..aaaa29d98901 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -912,6 +912,7 @@ struct hl_debug_params {
  * @dev_node: node in the device list of file private data
  * @refcount: number of related contexts.
  * @restore_phase_mutex: lock for context switch and restore phase.
+ * @is_control: true for control device, false otherwise
  */
 struct hl_fpriv {
 	struct hl_device	*hdev;
@@ -924,6 +925,7 @@ struct hl_fpriv {
 	struct list_head	dev_node;
 	struct kref		refcount;
 	struct mutex		restore_phase_mutex;
+	u8			is_control;
 };
 
 
@@ -1010,7 +1012,7 @@ struct hl_dbg_device_entry {
  */
 
 /* Theoretical limit only. A single host can only contain up to 4 or 8 PCIe
- * x16 cards. In extereme cases, there are hosts that can accommodate 16 cards
+ * x16 cards. In extreme cases, there are hosts that can accommodate 16 cards.
  */
 #define HL_MAX_MINORS	256
 
@@ -1143,7 +1145,9 @@ struct hl_device_reset_work {
  * @pcie_bar: array of available PCIe bars.
  * @rmmio: configuration area address on SRAM.
  * @cdev: related char device.
- * @dev: realted kernel basic device structure.
+ * @cdev_ctrl: char device for control operations only (INFO IOCTL)
+ * @dev: related kernel basic device structure.
+ * @dev_ctrl: related kernel device structure for the control device
  * @work_freq: delayed work to lower device frequency if possible.
  * @work_heartbeat: delayed work for ArmCP is-alive check.
  * @asic_name: ASIC specific nmae.
@@ -1196,6 +1200,7 @@ struct hl_device_reset_work {
  * @soft_reset_cnt: number of soft reset since KMD loading.
  * @hard_reset_cnt: number of hard reset since KMD loading.
  * @id: device minor.
+ * @id_control: minor of the control device
  * @disabled: is device disabled.
  * @late_init_done: is late init stage was done during initialization.
  * @hwmon_initialized: is H/W monitor sensors was initialized.
@@ -1217,7 +1222,9 @@ struct hl_device {
 	void __iomem			*pcie_bar[6];
 	void __iomem			*rmmio;
 	struct cdev			cdev;
+	struct cdev			cdev_ctrl;
 	struct device			*dev;
+	struct device			*dev_ctrl;
 	struct delayed_work		work_freq;
 	struct delayed_work		work_heartbeat;
 	char				asic_name[16];
@@ -1271,6 +1278,7 @@ struct hl_device {
 	u32				soft_reset_cnt;
 	u32				hard_reset_cnt;
 	u16				id;
+	u16				id_control;
 	u8				disabled;
 	u8				late_init_done;
 	u8				hwmon_initialized;
@@ -1376,6 +1384,7 @@ static inline bool hl_mem_area_crosses_range(u64 address, u32 size,
 }
 
 int hl_device_open(struct inode *inode, struct file *filp);
+int hl_device_open_ctrl(struct inode *inode, struct file *filp);
 bool hl_device_disabled_or_in_reset(struct hl_device *hdev);
 enum hl_device_status hl_device_status(struct hl_device *hdev);
 int hl_device_set_debug_mode(struct hl_device *hdev, bool enable);
@@ -1615,6 +1624,7 @@ static inline void hl_debugfs_remove_ctx_mem_hash(struct hl_device *hdev,
 
 /* IOCTLs */
 long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
+long hl_ioctl_control(struct file *filep, unsigned int cmd, unsigned long arg);
 int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data);
 int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data);
 int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data);
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 802c6ca7c604..8c342fb499ca 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -130,7 +130,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	}
 
 	if (hdev->compute_ctx) {
-		dev_info_ratelimited(hdev->dev,
+		dev_dbg_ratelimited(hdev->dev,
 			"Can't open %s because another user is working on it\n",
 			dev_name(hdev->dev));
 		rc = -EBUSY;
@@ -170,6 +170,55 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	return rc;
 }
 
+int hl_device_open_ctrl(struct inode *inode, struct file *filp)
+{
+	struct hl_device *hdev;
+	struct hl_fpriv *hpriv;
+	int rc;
+
+	mutex_lock(&hl_devs_idr_lock);
+	hdev = idr_find(&hl_devs_idr, iminor(inode));
+	mutex_unlock(&hl_devs_idr_lock);
+
+	if (!hdev) {
+		pr_err("Couldn't find device %d:%d\n",
+			imajor(inode), iminor(inode));
+		return -ENXIO;
+	}
+
+	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		return -ENOMEM;
+
+	mutex_lock(&hdev->fpriv_list_lock);
+
+	if (hl_device_disabled_or_in_reset(hdev)) {
+		dev_err_ratelimited(hdev->dev_ctrl,
+			"Can't open %s because it is disabled or in reset\n",
+			dev_name(hdev->dev_ctrl));
+		rc = -EPERM;
+		goto out_err;
+	}
+
+	list_add(&hpriv->dev_node, &hdev->fpriv_list);
+	mutex_unlock(&hdev->fpriv_list_lock);
+
+	hpriv->hdev = hdev;
+	filp->private_data = hpriv;
+	hpriv->filp = filp;
+	hpriv->is_control = true;
+	nonseekable_open(inode, filp);
+
+	hpriv->taskpid = find_get_pid(current->pid);
+
+	return 0;
+
+out_err:
+	mutex_unlock(&hdev->fpriv_list_lock);
+	kfree(hpriv);
+	return rc;
+}
+
 static void set_driver_behavior_per_device(struct hl_device *hdev)
 {
 	hdev->mmu_enable = 1;
@@ -197,7 +246,7 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 		enum hl_asic_type asic_type, int minor)
 {
 	struct hl_device *hdev;
-	int rc;
+	int rc, main_id, ctrl_id = 0;
 
 	*dev = NULL;
 
@@ -238,33 +287,34 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 
 	mutex_lock(&hl_devs_idr_lock);
 
-	if (minor == -1) {
-		rc = idr_alloc(&hl_devs_idr, hdev, 0, HL_MAX_MINORS,
+	/* Always save 2 numbers, 1 for main device and 1 for control.
+	 * They must be consecutive
+	 */
+	main_id = idr_alloc(&hl_devs_idr, hdev, 0, HL_MAX_MINORS,
 				GFP_KERNEL);
-	} else {
-		void *old_idr = idr_replace(&hl_devs_idr, hdev, minor);
 
-		if (IS_ERR_VALUE(old_idr)) {
-			rc = PTR_ERR(old_idr);
-			pr_err("Error %d when trying to replace minor %d\n",
-				rc, minor);
-			mutex_unlock(&hl_devs_idr_lock);
-			goto free_hdev;
-		}
-		rc = minor;
-	}
+	if (main_id >= 0)
+		ctrl_id = idr_alloc(&hl_devs_idr, hdev, main_id + 1,
+					main_id + 2, GFP_KERNEL);
 
 	mutex_unlock(&hl_devs_idr_lock);
 
-	if (rc < 0) {
-		if (rc == -ENOSPC) {
+	if ((main_id < 0) || (ctrl_id < 0)) {
+		if ((main_id == -ENOSPC) || (ctrl_id == -ENOSPC))
 			pr_err("too many devices in the system\n");
-			rc = -EBUSY;
+
+		if (main_id >= 0) {
+			mutex_lock(&hl_devs_idr_lock);
+			idr_remove(&hl_devs_idr, main_id);
+			mutex_unlock(&hl_devs_idr_lock);
 		}
+
+		rc = -EBUSY;
 		goto free_hdev;
 	}
 
-	hdev->id = rc;
+	hdev->id = main_id;
+	hdev->id_control = ctrl_id;
 
 	*dev = hdev;
 
@@ -286,6 +336,7 @@ void destroy_hdev(struct hl_device *hdev)
 	/* Remove device from the device list */
 	mutex_lock(&hl_devs_idr_lock);
 	idr_remove(&hl_devs_idr, hdev->id);
+	idr_remove(&hl_devs_idr, hdev->id_control);
 	mutex_unlock(&hl_devs_idr_lock);
 
 	kfree(hdev);
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index c9a4799eb251..ce0cd93a8421 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -194,7 +194,8 @@ static int debug_coresight(struct hl_device *hdev, struct hl_debug_args *args)
 	return rc;
 }
 
-static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
+static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
+				struct device *dev)
 {
 	struct hl_info_args *args = data;
 	struct hl_device *hdev = hpriv->hdev;
@@ -205,7 +206,7 @@ static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
 		return device_status_info(hdev, args);
 
 	if (hl_device_disabled_or_in_reset(hdev)) {
-		dev_warn_ratelimited(hdev->dev,
+		dev_warn_ratelimited(dev,
 			"Device is %s. Can't execute INFO IOCTL\n",
 			atomic_read(&hdev->in_reset) ? "in_reset" : "disabled");
 		return -EBUSY;
@@ -229,7 +230,7 @@ static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
 		break;
 
 	default:
-		dev_err(hdev->dev, "Invalid request %d\n", args->op);
+		dev_err(dev, "Invalid request %d\n", args->op);
 		rc = -ENOTTY;
 		break;
 	}
@@ -237,6 +238,16 @@ static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
 	return rc;
 }
 
+static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
+{
+	return _hl_info_ioctl(hpriv, data, hpriv->hdev->dev);
+}
+
+static int hl_info_ioctl_control(struct hl_fpriv *hpriv, void *data)
+{
+	return _hl_info_ioctl(hpriv, data, hpriv->hdev->dev_ctrl);
+}
+
 static int hl_debug_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	struct hl_debug_args *args = data;
@@ -291,52 +302,45 @@ static const struct hl_ioctl_desc hl_ioctls[] = {
 	HL_IOCTL_DEF(HL_IOCTL_DEBUG, hl_debug_ioctl)
 };
 
-#define HL_CORE_IOCTL_COUNT	ARRAY_SIZE(hl_ioctls)
+static const struct hl_ioctl_desc hl_ioctls_control[] = {
+	HL_IOCTL_DEF(HL_IOCTL_INFO, hl_info_ioctl_control)
+};
 
-long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+long _hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg,
+		const struct hl_ioctl_desc *ioctl, struct device *dev)
 {
 	struct hl_fpriv *hpriv = filep->private_data;
 	struct hl_device *hdev = hpriv->hdev;
-	hl_ioctl_t *func;
-	const struct hl_ioctl_desc *ioctl = NULL;
 	unsigned int nr = _IOC_NR(cmd);
 	char stack_kdata[128] = {0};
 	char *kdata = NULL;
 	unsigned int usize, asize;
+	hl_ioctl_t *func;
+	u32 hl_size;
 	int retcode;
 
 	if (hdev->hard_reset_pending) {
-		dev_crit_ratelimited(hdev->dev,
+		dev_crit_ratelimited(hdev->dev_ctrl,
 			"Device HARD reset pending! Please close FD\n");
 		return -ENODEV;
 	}
 
-	if ((nr >= HL_COMMAND_START) && (nr < HL_COMMAND_END)) {
-		u32 hl_size;
-
-		ioctl = &hl_ioctls[nr];
-
-		hl_size = _IOC_SIZE(ioctl->cmd);
-		usize = asize = _IOC_SIZE(cmd);
-		if (hl_size > asize)
-			asize = hl_size;
-
-		cmd = ioctl->cmd;
-	} else {
-		dev_err(hdev->dev, "invalid ioctl: pid=%d, nr=0x%02x\n",
-			task_pid_nr(current), nr);
-		return -ENOTTY;
-	}
-
 	/* Do not trust userspace, use our own definition */
 	func = ioctl->func;
 
 	if (unlikely(!func)) {
-		dev_dbg(hdev->dev, "no function\n");
+		dev_dbg(dev, "no function\n");
 		retcode = -ENOTTY;
 		goto out_err;
 	}
 
+	hl_size = _IOC_SIZE(ioctl->cmd);
+	usize = asize = _IOC_SIZE(cmd);
+	if (hl_size > asize)
+		asize = hl_size;
+
+	cmd = ioctl->cmd;
+
 	if (cmd & (IOC_IN | IOC_OUT)) {
 		if (asize <= sizeof(stack_kdata)) {
 			kdata = stack_kdata;
@@ -366,8 +370,7 @@ long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 
 out_err:
 	if (retcode)
-		dev_dbg(hdev->dev,
-			"error in ioctl: pid=%d, cmd=0x%02x, nr=0x%02x\n",
+		dev_dbg(dev, "error in ioctl: pid=%d, cmd=0x%02x, nr=0x%02x\n",
 			  task_pid_nr(current), cmd, nr);
 
 	if (kdata != stack_kdata)
@@ -375,3 +378,39 @@ long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 
 	return retcode;
 }
+
+long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	struct hl_fpriv *hpriv = filep->private_data;
+	struct hl_device *hdev = hpriv->hdev;
+	const struct hl_ioctl_desc *ioctl = NULL;
+	unsigned int nr = _IOC_NR(cmd);
+
+	if ((nr >= HL_COMMAND_START) && (nr < HL_COMMAND_END)) {
+		ioctl = &hl_ioctls[nr];
+	} else {
+		dev_err(hdev->dev, "invalid ioctl: pid=%d, nr=0x%02x\n",
+			task_pid_nr(current), nr);
+		return -ENOTTY;
+	}
+
+	return _hl_ioctl(filep, cmd, arg, ioctl, hdev->dev);
+}
+
+long hl_ioctl_control(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	struct hl_fpriv *hpriv = filep->private_data;
+	struct hl_device *hdev = hpriv->hdev;
+	const struct hl_ioctl_desc *ioctl = NULL;
+	unsigned int nr = _IOC_NR(cmd);
+
+	if (nr == _IOC_NR(HL_IOCTL_INFO)) {
+		ioctl = &hl_ioctls_control[nr];
+	} else {
+		dev_err(hdev->dev_ctrl, "invalid ioctl: pid=%d, nr=0x%02x\n",
+			task_pid_nr(current), nr);
+		return -ENOTTY;
+	}
+
+	return _hl_ioctl(filep, cmd, arg, ioctl, hdev->dev_ctrl);
+}
-- 
2.17.1

