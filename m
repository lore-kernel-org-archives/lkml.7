Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209B1C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 12:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AA52175B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 12:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Auov+xPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDFMpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 08:45:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39558 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfDFMpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 08:45:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so10992759wrn.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UdK3qZXat9h2a4tdDMUL1MbTv0V/1BzKbcw6a+rKFa8=;
        b=Auov+xPLiy7UBJF1salBPVODM/5MiUTSIoBwQZAGys5tbMmXC0S5qIwJKFVF+MIzAO
         /NqJKAv07Kk5ut6Nl8FJRKJpEVdE0NRO1i/aSVmfd4pFbDyT+cTdI2VPVaffb2N6FATs
         QTBxZTepfzrnBsdVzghRxF9Eg6J5ab/EP9rh0X3MTLygD1xrMxIhEUtXyCz62vX/L3DX
         4mJblgpl7cxCuAVDatHeZoWj7GNYHBmk2PTPTx/AwHw6sh18lozhT2YlQe3DTYua7x8Y
         4IdxfBatq0mcm9ASyEfBjQiACN0eKSY4T2SS9C1L7aaw3YcCqKm36B2i3BSIN5tpv1cP
         N5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UdK3qZXat9h2a4tdDMUL1MbTv0V/1BzKbcw6a+rKFa8=;
        b=BlvZzryu+0ROLqgpewAH3ObhydPrk9ttJn5kbNnOUFtybUT5eudb6V9Pb/MlklM3mD
         3+gjW/sWQh+3WG0WMOP9CYFQeUNi3dVPEVd64Uv8JzdIfMMPuJrXZYoTWCrka+iVzZvR
         5HEyaK7rzE28j609Y3GkEbkVkzO4WpqKJWzoinfB3dYPrAn1ReCOqWjRyo9orq0ozObi
         lj/mYyx3mqwJM5E181iV/j5Iyu2NS7tgkQgomLhookrr804mUSTbAk+JV9eatKUhgW+z
         wA2tdIl7+EZG1J8KAHGQtxpoYp36Rv21T/DknyTBKjACSo41vVaBHFGVKOiZB078S+S4
         4xiA==
X-Gm-Message-State: APjAAAWrOm6tYFTZCSCLogIslqojcaabin8wJ9OXb3Gge/jz/6h5dGdr
        Cb0zCwxJmTTDX2ykYl9AXuXcUJmV
X-Google-Smtp-Source: APXvYqxmGgO7QXOJacFW3ZPxwTE2ZgGypTsDG9QHc44iRnZBR34FjeMcmJomss+MHSROSaoZrwJWhw==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr12614916wrj.16.1554554715150;
        Sat, 06 Apr 2019 05:45:15 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id f15sm29230576wru.21.2019.04.06.05.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 05:45:14 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/3] habanalabs: improve IOCTLs behavior when disabled or reset
Date:   Sat,  6 Apr 2019 15:45:10 +0300
Message-Id: <20190406124511.7535-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190406124511.7535-1-oded.gabbay@gmail.com>
References: <20190406124511.7535-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some improvement in how IOCTLs behave when the device is
disabled or under reset.

The new code checks, at the start of every IOCTL, if the device is
disabled or in reset. If so, it prints an appropriate kernel message and
returns -EBUSY to user-space.

In addition, the code modifies the location of where the
hard_reset_pending flag is being set or cleared:

1. It is now cleared immediately after the reset *tear-down* flow is
   finished but before the re-initialization flow begins.

2. It is being set in the remove function of the device, to make the
   behavior the same with the hard-reset flow

There are two exceptions to the disable or in reset check:

1. The HL_INFO_DEVICE_STATUS opcode in the INFO IOCTL. This opcode allows
   the user to inquire about the status of the device, whether it is
   operational, in reset or malfunction (disabled). If the driver will
   block this IOCTL, the user won't be able to retrieve the status in
   case of malfunction or in reset.

2. The WAIT_FOR_CS IOCTL. This IOCTL allows the user to inquire about the
   status of a CS. We want to allow the user to continue to do so, even if
   we started a soft-reset process because it will allow the user to get
   the correct error code for each CS he submitted.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_buffer.c   | 7 +++++++
 drivers/misc/habanalabs/device.c           | 9 +++++----
 drivers/misc/habanalabs/habanalabs_ioctl.c | 3 ++-
 drivers/misc/habanalabs/memory.c           | 3 ++-
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
index 85f75806a9a7..b1ffca47d748 100644
--- a/drivers/misc/habanalabs/command_buffer.c
+++ b/drivers/misc/habanalabs/command_buffer.c
@@ -214,6 +214,13 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 	u64 handle;
 	int rc;
 
+	if (hl_device_disabled_or_in_reset(hdev)) {
+		dev_warn_ratelimited(hdev->dev,
+			"Device is %s. Can't execute CB IOCTL\n",
+			atomic_read(&hdev->in_reset) ? "in_reset" : "disabled");
+		return -EBUSY;
+	}
+
 	switch (args->in.op) {
 	case HL_CB_OP_CREATE:
 		rc = hl_cb_create(hdev, &hpriv->cb_mgr, args->in.cb_size,
diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 56d3ba53c661..25bfb093ff26 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -641,6 +641,8 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 	if ((hard_reset) && (!from_hard_reset_thread)) {
 		struct hl_device_reset_work *device_reset_work;
 
+		hdev->hard_reset_pending = true;
+
 		if (!hdev->pdev) {
 			dev_err(hdev->dev,
 				"Reset action is NOT supported in simulator\n");
@@ -648,8 +650,6 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 			goto out_err;
 		}
 
-		hdev->hard_reset_pending = true;
-
 		device_reset_work = kzalloc(sizeof(*device_reset_work),
 						GFP_ATOMIC);
 		if (!device_reset_work) {
@@ -718,6 +718,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 
 	if (hard_reset) {
 		hdev->device_cpu_disabled = false;
+		hdev->hard_reset_pending = false;
 
 		if (hdev->kernel_ctx) {
 			dev_crit(hdev->dev,
@@ -779,8 +780,6 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		}
 
 		hl_set_max_power(hdev, hdev->max_power);
-
-		hdev->hard_reset_pending = false;
 	} else {
 		rc = hdev->asic_funcs->soft_reset_late_init(hdev);
 		if (rc) {
@@ -1069,6 +1068,8 @@ void hl_device_fini(struct hl_device *hdev)
 	hdev->asic_funcs->hw_queues_lock(hdev);
 	hdev->asic_funcs->hw_queues_unlock(hdev);
 
+	hdev->hard_reset_pending = true;
+
 	device_kill_open_processes(hdev);
 
 	hl_hwmon_fini(hdev);
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 17abd94bb54f..2d579858bd6f 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -207,7 +207,8 @@ static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	if (hl_device_disabled_or_in_reset(hdev)) {
 		dev_warn_ratelimited(hdev->dev,
-			"Device is disabled or in reset. Can't execute INFO IOCTL\n");
+			"Device is %s. Can't execute INFO IOCTL\n",
+			atomic_read(&hdev->in_reset) ? "in_reset" : "disabled");
 		return -EBUSY;
 	}
 
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 05919f913300..43ef3ad8438a 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1159,7 +1159,8 @@ int hl_mem_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	if (hl_device_disabled_or_in_reset(hdev)) {
 		dev_warn_ratelimited(hdev->dev,
-			"Device is disabled or in reset. Can't execute memory IOCTL\n");
+			"Device is %s. Can't execute MEMORY IOCTL\n",
+			atomic_read(&hdev->in_reset) ? "in_reset" : "disabled");
 		return -EBUSY;
 	}
 
-- 
2.17.1

