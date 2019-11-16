Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18261C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 10:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E696920728
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 10:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwkKbHfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfKPKdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 05:33:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55622 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfKPKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 05:33:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so12122989wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 02:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u7sWlRTtJZbCyQnn5ZHc11ljJpmynwZ/nJM+RgdZP2o=;
        b=SwkKbHfaAbum+MGOrn+cu1cRUiYfp4mF3D4hRoQ4BXPVL0KijwmWXGHzxfzNOOSEvY
         Xo6ONhiK59Cbkka6EulGbXOOLtofXbqGXleV50w7YBJnjhYw7OuXBJBDGEF1zoFsrvAt
         +nHYUq0GCehSPjP1xvU2VdYZjvHpumFejmgQas2Yjj8thdVlFbR8R5LWqt8q0Ytmj0v1
         bVfJvBCUdPQFj8wv3ufidMFl8SD5IwUCT1NnzzQ085asGsm1q5FmHNfjzYMOaBYh11df
         8NmPjYFEq1USFgYHAcuDa/zvgZLbc4YptreNqQlUb4rleKs0j7gM13w+FL+bIShqQ5iw
         qjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u7sWlRTtJZbCyQnn5ZHc11ljJpmynwZ/nJM+RgdZP2o=;
        b=pVjDGLHFCZbJxRdUNcj2cBBS2PZW/YAF9yEAQjJ0tUdk/OEYuIbBFNPA++8q9V0ZPL
         rzjZV4zlocXhAiusAsxEIuVhO1rFntbj4OEfU+FU48C/lEICZv/Cb0ufw2pfSFMDvkVT
         niyPr25fZ3FS4gpsh0qlzog1WNArU9GdjL0GnH2aXvPhQn955iWn1dac0iF7vssLHi0s
         9Qt5QN2zwSF/vkVQcsYcYL4CR34/5Pw1UURu4EJH1/87VLOwLInbD1qrjhrL3S+aijts
         WDuWRQKuT1MfXmBsYuUy/Xy/cxSt+UEvGbJEQiFfHUXe2itqt4T14ne/oK/DVXNWYNy+
         X4pg==
X-Gm-Message-State: APjAAAU9XcRX8Sz8wICxp0nm28AiSxWV1eVFfvBP5JjLVxcIAOdr6TBZ
        rh5yA+ixVlmzNi1Py3H0MkcmkDy7JX0=
X-Google-Smtp-Source: APXvYqxZ8UVbB+zy1Bv0f9sgpKENicxNcTem6ozka/GXsxwDo7Qrr4xhih0i6K7EU8XjxPZ81lYEHg==
X-Received: by 2002:a05:600c:2253:: with SMTP id a19mr19706122wmm.97.1573900414620;
        Sat, 16 Nov 2019 02:33:34 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id t14sm14680522wrw.87.2019.11.16.02.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 02:33:34 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 3/3] habanalabs: make code more concise
Date:   Sat, 16 Nov 2019 12:33:29 +0200
Message-Id: <20191116103329.30171-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191116103329.30171-1-oded.gabbay@gmail.com>
References: <20191116103329.30171-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of doing if inside if, just write them with && operator.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs_ioctl.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 02d7491fa28f..5d9c269d99db 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -60,7 +60,7 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	hw_ip.tpc_enabled_mask = prop->tpc_enabled_mask;
 	hw_ip.sram_size = prop->sram_size - sram_kmd_size;
 	hw_ip.dram_size = prop->dram_size - dram_kmd_size;
-	if (hw_ip.dram_size > 0)
+	if (hw_ip.dram_size > PAGE_SIZE)
 		hw_ip.dram_enabled = 1;
 	hw_ip.num_of_events = prop->num_of_events;
 
@@ -184,17 +184,14 @@ static int debug_coresight(struct hl_device *hdev, struct hl_debug_args *args)
 		goto out;
 	}
 
-	if (output) {
-		if (copy_to_user((void __user *) (uintptr_t) args->output_ptr,
-					output,
-					args->output_size)) {
-			dev_err(hdev->dev,
-				"copy to user failed in debug ioctl\n");
-			rc = -EFAULT;
-			goto out;
-		}
+	if (output && copy_to_user((void __user *) (uintptr_t) args->output_ptr,
+					output, args->output_size)) {
+		dev_err(hdev->dev, "copy to user failed in debug ioctl\n");
+		rc = -EFAULT;
+		goto out;
 	}
 
+
 out:
 	kfree(params);
 	kfree(output);
@@ -434,9 +431,8 @@ static long _hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg,
 
 	retcode = func(hpriv, kdata);
 
-	if (cmd & IOC_OUT)
-		if (copy_to_user((void __user *)arg, kdata, usize))
-			retcode = -EFAULT;
+	if ((cmd & IOC_OUT) && copy_to_user((void __user *)arg, kdata, usize))
+		retcode = -EFAULT;
 
 out_err:
 	if (retcode)
-- 
2.17.1

