Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFAAC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04012087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 11:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho6n77uA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfG1L2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 07:28:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46637 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfG1L23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 07:28:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so58768135wru.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 04:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=b48O77rlmYJggm30DJLULoovvkEKLkR/f3hQot6wKyg=;
        b=Ho6n77uAmDQCFA/QzgGA+VtOLEsYn/9vOjr5/yN2BiYDmLU8u6mxImSzp9uLwPcXiF
         IT65bW7TtI8NL9zz4KrTrHwI0FhwLdv77cxAiAmEJfDTHpmtC3AXB1B8jkeFU5ekGj5G
         9eed30in26/EpnidldBPfZkpm2DTNmtq25blbHAWXF0Ak+/cgdBjtVLF3GkDE8deOWtG
         rDrL+aO+87mANC2/mTr5cwKGsXAkbe7PPaT0scEo7xPeEfA0VoNzp4wAb1n7+abj3pUI
         nDzm0ZLla21I4kGh+40YUy0zb8Y3uLqDQc52BmiU3y/K9p1ch2a+9h2JtpmIm1eIWH3z
         zy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=b48O77rlmYJggm30DJLULoovvkEKLkR/f3hQot6wKyg=;
        b=BEUMFLwB1lu3DUtNZdxf3ThQgXhg+CIhkgoJYPLtLho+ql7mnDgtR6h0qzU1F4n0wZ
         g+ZRukdpm1mv/QaowgwYRWGCJw8lb1u33HokQxQJI7G7UVpE18n5AZS4GARqap97Jw4Q
         OyLtG81qtMUoUpO6iDmSAhVi99ICFb/KqqTfDfRuwicM5opcNEQZbdPUzDSlObVdrw+D
         0M3hkumpOKhEhZiTZMyNXQIp/guMVpLwTtVN7zHxtwnR6M/pFUpmw3LC0RTex6WscBok
         un7kCeUuHxkn8JbymVD+aY1auv9x2UJq0zRbl2aYPgiEhzEIWZ33XIKCfBhV7cF7qvOc
         P+4A==
X-Gm-Message-State: APjAAAW6qvR5b0ws9bKMSGFQhDEcQ/b5tEoPADOY/fcclWOY8Q3j4sx+
        kPGImtW+WwjdyCzfQbqvT6pemfmhPZE=
X-Google-Smtp-Source: APXvYqxopqUE1nTFOyJnsW/MdbWQUzTIvC77rKGpY7+2VM3hJmyhVvl0SgfbNJvnTXmH0W15q0AcbQ==
X-Received: by 2002:adf:f601:: with SMTP id t1mr17809653wrp.337.1564313306355;
        Sun, 28 Jul 2019 04:28:26 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r12sm69805174wrt.95.2019.07.28.04.28.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 04:28:25 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 4/9] habanalabs: don't change frequency if user context is valid
Date:   Sun, 28 Jul 2019 14:28:13 +0300
Message-Id: <20190728112818.30397-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190728112818.30397-1-oded.gabbay@gmail.com>
References: <20190728112818.30397-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using the FD open counter to check if there is a user opened on
the device, check if there is a valid user context.

Use the new lazy context creation mutex to protect against multiple calls
to change the frequency.

This is in preparation for removing the FD open counter.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/context.c         |  9 +++++
 drivers/misc/habanalabs/device.c          | 40 +++++++++--------------
 drivers/misc/habanalabs/goya/goya_hwmgr.c | 11 +++----
 drivers/misc/habanalabs/habanalabs.h      |  4 +--
 drivers/misc/habanalabs/habanalabs_drv.c  | 34 ++++++++-----------
 5 files changed, 45 insertions(+), 53 deletions(-)

diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 3c1f7c29e908..a4cd47ced94d 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -220,9 +220,18 @@ bool hl_ctx_is_valid(struct hl_fpriv *hpriv)
 		if (rc) {
 			dev_err(hdev->dev, "Failed to create context %d\n", rc);
 			valid = false;
+			goto unlock_mutex;
 		}
+
+		/* Device is IDLE at this point so it is legal to change PLLs.
+		 * There is no need to check anything because if the PLL is
+		 * already HIGH, the set function will return without doing
+		 * anything
+		 */
+		hl_device_set_frequency(hdev, PLL_HIGH);
 	}
 
+unlock_mutex:
 	mutex_unlock(&hdev->lazy_ctx_creation_lock);
 
 	return valid;
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index b63beb73ec76..a791a1b58215 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -289,9 +289,13 @@ static void set_freq_to_low_job(struct work_struct *work)
 	struct hl_device *hdev = container_of(work, struct hl_device,
 						work_freq.work);
 
-	if (atomic_read(&hdev->fd_open_cnt) == 0)
+	mutex_lock(&hdev->lazy_ctx_creation_lock);
+
+	if (!hdev->user_ctx)
 		hl_device_set_frequency(hdev, PLL_LOW);
 
+	mutex_unlock(&hdev->lazy_ctx_creation_lock);
+
 	schedule_delayed_work(&hdev->work_freq,
 			usecs_to_jiffies(HL_PLL_LOW_JOB_FREQ_USEC));
 }
@@ -341,7 +345,7 @@ static int device_late_init(struct hl_device *hdev)
 	hdev->high_pll = hdev->asic_prop.high_pll;
 
 	/* force setting to low frequency */
-	atomic_set(&hdev->curr_pll_profile, PLL_LOW);
+	hdev->curr_pll_profile = PLL_LOW;
 
 	if (hdev->pm_mng_profile == PM_AUTO)
 		hdev->asic_funcs->set_pll_profile(hdev, PLL_LOW);
@@ -390,38 +394,26 @@ static void device_late_fini(struct hl_device *hdev)
  * @hdev: pointer to habanalabs device structure
  * @freq: the new frequency value
  *
- * Change the frequency if needed.
- * We allose to set PLL to low only if there is no user process
- * Returns 0 if no change was done, otherwise returns 1;
+ * Change the frequency if needed. This function has no protection against
+ * concurrency, therefore it is assumed that the calling function has protected
+ * itself against the case of calling this function from multiple threads with
+ * different values
+ *
+ * Returns 0 if no change was done, otherwise returns 1
  */
 int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq)
 {
-	enum hl_pll_frequency old_freq =
-			(freq == PLL_HIGH) ? PLL_LOW : PLL_HIGH;
-	int ret;
-
-	if (hdev->pm_mng_profile == PM_MANUAL)
-		return 0;
-
-	ret = atomic_cmpxchg(&hdev->curr_pll_profile, old_freq, freq);
-	if (ret == freq)
+	if ((hdev->pm_mng_profile == PM_MANUAL) ||
+			(hdev->curr_pll_profile == freq))
 		return 0;
 
-	/*
-	 * in case we want to lower frequency, check if device is not
-	 * opened. We must have a check here to workaround race condition with
-	 * hl_device_open
-	 */
-	if ((freq == PLL_LOW) && (atomic_read(&hdev->fd_open_cnt) > 0)) {
-		atomic_set(&hdev->curr_pll_profile, PLL_HIGH);
-		return 0;
-	}
-
 	dev_dbg(hdev->dev, "Changing device frequency to %s\n",
 		freq == PLL_HIGH ? "high" : "low");
 
 	hdev->asic_funcs->set_pll_profile(hdev, freq);
 
+	hdev->curr_pll_profile = freq;
+
 	return 1;
 }
 
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index a51d836542a1..8522c6e0a25e 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -254,11 +254,11 @@ static ssize_t pm_mng_profile_store(struct device *dev,
 		goto out;
 	}
 
-	mutex_lock(&hdev->fd_open_cnt_lock);
+	mutex_lock(&hdev->lazy_ctx_creation_lock);
 
-	if (atomic_read(&hdev->fd_open_cnt) > 0) {
+	if (hdev->user_ctx) {
 		dev_err(hdev->dev,
-			"Can't change PM profile while user process is opened on the device\n");
+			"Can't change PM profile while user context is opened on the device\n");
 		count = -EPERM;
 		goto unlock_mutex;
 	}
@@ -266,7 +266,7 @@ static ssize_t pm_mng_profile_store(struct device *dev,
 	if (strncmp("auto", buf, strlen("auto")) == 0) {
 		/* Make sure we are in LOW PLL when changing modes */
 		if (hdev->pm_mng_profile == PM_MANUAL) {
-			atomic_set(&hdev->curr_pll_profile, PLL_HIGH);
+			hdev->curr_pll_profile = PLL_HIGH;
 			hl_device_set_frequency(hdev, PLL_LOW);
 			hdev->pm_mng_profile = PM_AUTO;
 		}
@@ -279,11 +279,10 @@ static ssize_t pm_mng_profile_store(struct device *dev,
 	} else {
 		dev_err(hdev->dev, "value should be auto or manual\n");
 		count = -EINVAL;
-		goto unlock_mutex;
 	}
 
 unlock_mutex:
-	mutex_unlock(&hdev->fd_open_cnt_lock);
+	mutex_unlock(&hdev->lazy_ctx_creation_lock);
 out:
 	return count;
 }
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index d0e55839d673..6354fc88ef8a 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1190,10 +1190,10 @@ struct hl_device_reset_work {
  *             value is saved so in case of hard-reset, KMD will restore this
  *             value and update the F/W after the re-initialization
  * @in_reset: is device in reset flow.
- * @curr_pll_profile: current PLL profile.
  * @fd_open_cnt: number of open user processes.
  * @cs_active_cnt: number of active command submissions on this device (active
  *                 means already in H/W queues)
+ * @curr_pll_profile: current PLL profile.
  * @major: habanalabs KMD major.
  * @high_pll: high PLL profile frequency.
  * @soft_reset_cnt: number of soft reset since KMD loading.
@@ -1268,9 +1268,9 @@ struct hl_device {
 	u64				timeout_jiffies;
 	u64				max_power;
 	atomic_t			in_reset;
-	atomic_t			curr_pll_profile;
 	atomic_t			fd_open_cnt;
 	atomic_t			cs_active_cnt;
+	enum hl_pll_frequency		curr_pll_profile;
 	u32				major;
 	u32				high_pll;
 	u32				soft_reset_cnt;
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index b2c52e46e130..a781aa936160 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -95,42 +95,40 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		return -ENXIO;
 	}
 
+	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv)
+		return -ENOMEM;
+
 	mutex_lock(&hdev->fd_open_cnt_lock);
 
 	if (hl_device_disabled_or_in_reset(hdev)) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't open %s because it is disabled or in reset\n",
 			dev_name(hdev->dev));
-		mutex_unlock(&hdev->fd_open_cnt_lock);
-		return -EPERM;
+		rc = -EPERM;
+		goto out_err;
 	}
 
 	if (hdev->in_debug) {
 		dev_err_ratelimited(hdev->dev,
 			"Can't open %s because it is being debugged by another user\n",
 			dev_name(hdev->dev));
-		mutex_unlock(&hdev->fd_open_cnt_lock);
-		return -EPERM;
+		rc = -EPERM;
+		goto out_err;
 	}
 
 	if (atomic_read(&hdev->fd_open_cnt)) {
 		dev_info_ratelimited(hdev->dev,
 			"Can't open %s because another user is working on it\n",
 			dev_name(hdev->dev));
-		mutex_unlock(&hdev->fd_open_cnt_lock);
-		return -EBUSY;
+		rc = -EBUSY;
+		goto out_err;
 	}
 
 	atomic_inc(&hdev->fd_open_cnt);
 
 	mutex_unlock(&hdev->fd_open_cnt_lock);
 
-	hpriv = kzalloc(sizeof(*hpriv), GFP_KERNEL);
-	if (!hpriv) {
-		rc = -ENOMEM;
-		goto close_device;
-	}
-
 	hpriv->hdev = hdev;
 	filp->private_data = hpriv;
 	hpriv->filp = filp;
@@ -143,19 +141,13 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	hpriv->taskpid = find_get_pid(current->pid);
 
-	/*
-	 * Device is IDLE at this point so it is legal to change PLLs. There
-	 * is no need to check anything because if the PLL is already HIGH, the
-	 * set function will return without doing anything
-	 */
-	hl_device_set_frequency(hdev, PLL_HIGH);
-
 	hl_debugfs_add_file(hpriv);
 
 	return 0;
 
-close_device:
-	atomic_dec(&hdev->fd_open_cnt);
+out_err:
+	mutex_unlock(&hdev->fd_open_cnt_lock);
+	kfree(hpriv);
 	return rc;
 }
 
-- 
2.17.1

