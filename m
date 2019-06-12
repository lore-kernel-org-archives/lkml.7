Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8E1C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040BB208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICl7eGjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439787AbfFLO1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:27:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33951 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439772AbfFLO1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:27:41 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so6708030plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nnpmiCMeAmdAQr713slWaKghXz5R3u7jgcXTJpDfpmQ=;
        b=ICl7eGjVNV7y/AxGAlYPcdDC8W1RmGqrb2exRej2zIW9f3+pWozoiu+SuIBAWactg1
         oNNHT7BzmgMkV8i2Lc8ApqeMXKA8HqRNoSX0+Q88uYd8/YMWh4ieiO1ABpgEAR7r3DPm
         tsLP/FacbyuuPZjijre9T4mKbJu+IxT6BfsBjuFpdR79Guon/K2NUejEgGoBMLOnZk7v
         lv1lt3jNDYhm8lt8iCq3kOUTqzlOI/Fn8x8CW6FCNKjnqBPSUksi6jMjz8FxJSJnSyAF
         g2Z1ulhMyzbQgEDXF1U8gywAUPq9GcJ4d5cDBaPSyZizuNJDUymdc1gb+nt2vZveOqWK
         KpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nnpmiCMeAmdAQr713slWaKghXz5R3u7jgcXTJpDfpmQ=;
        b=I7lLxIsa0hold2NVqtOQZ12G7rsYX1VS6nDor6tpY3JlCTSM3YWRNlEaJJJMoXy75V
         aMHp1OLBsMTeNuuf0tkBJuSKKWdXV+n26jzTwMMaFOqzJuhDB2xOVnAzKvp1HwGv8b1/
         IibDHjbYjqelJUFDVV+IoO6SUFXAfENRDVUWBU6zp4LrNynOIsEHEVv9xQcag5QV3POy
         6q8+hVx6FmtA4Taje/XjzzpS+dykaHEC0fZTk50QtQfY2WVwS1FYko0uuvkz1zFi4y1r
         Z+V8wm+HKDDasQa+g0sC8GA7iYuloxCvE3VarQfD60/Mvi/joy62wy5PRUTunNH6sNzG
         gi4w==
X-Gm-Message-State: APjAAAX6e3tDeOXwtmY6xKLe1n7jYbAufgmxMo0fpYq11TYJ33jq7/KC
        a63I5e4FoFf0ix2MOx4J7x0=
X-Google-Smtp-Source: APXvYqybtAjl1Hnz8LNcsEWJVANixUAc5DXXdaAQ0FV40oqAZExgdtoONgyBg4IZpTfGPL4UOXWzoQ==
X-Received: by 2002:a17:902:f095:: with SMTP id go21mr6831787plb.58.1560349660293;
        Wed, 12 Jun 2019 07:27:40 -0700 (PDT)
Received: from ahmlpt0706 ([219.65.62.52])
        by smtp.gmail.com with ESMTPSA id 131sm21146086pfx.57.2019.06.12.07.27.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 07:27:39 -0700 (PDT)
Date:   Wed, 12 Jun 2019 19:57:27 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     adurbin@chromium.org, groeck@chromium.org, dlaurie@chromium.org
Subject: [PATCH] gsmi: Replace printk with relevant pr_<level>
Message-ID: <20190612142727.GA1710@ahmlpt0706>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="0001-gsmi-Replace-printk-with-relevant-pr_-level.patch"
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 3a9cec48147b24fd9d793e0fdf20058461445646 Mon Sep 17 00:00:00 2001
From: Saiyam Doshi <saiyamdoshi.in@gmail.com>
Date: Tue, 11 Jun 2019 19:21:50 +0530
Subject: [PATCH] gsmi: Replace printk with relevant pr_<level>

Replace printk() with pr_* macros for logging consistency.
This also helps avoid checkpatch warnings.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 drivers/firmware/google/gsmi.c | 59 ++++++++++++++++------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index edaa4e5d84ad..e4e7f04bced8 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -151,7 +151,7 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
 
 	smibuf = kzalloc(sizeof(*smibuf), GFP_KERNEL);
 	if (!smibuf) {
-		printk(KERN_ERR "gsmi: out of memory\n");
+		pr_err("gsmi: out of memory\n");
 		return NULL;
 	}
 
@@ -159,7 +159,7 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
 	smibuf->start = dma_pool_alloc(gsmi_dev.dma_pool, GFP_KERNEL,
 				       &smibuf->handle);
 	if (!smibuf->start) {
-		printk(KERN_ERR "gsmi: failed to allocate name buffer\n");
+		pr_err("gsmi: failed to allocate name buffer\n");
 		kfree(smibuf);
 		return NULL;
 	}
@@ -257,34 +257,33 @@ static int gsmi_exec(u8 func, u8 sub)
 		rc = 1;
 		break;
 	case GSMI_INVALID_PARAMETER:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Invalid parameter\n", cmd);
+		pr_err("gsmi: exec 0x%04x: Invalid parameter\n", cmd);
 		rc = -EINVAL;
 		break;
 	case GSMI_BUFFER_TOO_SMALL:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Buffer too small\n", cmd);
+		pr_err("gsmi: exec 0x%04x: Buffer too small\n", cmd);
 		rc = -ENOMEM;
 		break;
 	case GSMI_UNSUPPORTED:
 	case GSMI_UNSUPPORTED2:
 		if (sub != GSMI_CMD_HANDSHAKE_TYPE)
-			printk(KERN_ERR "gsmi: exec 0x%04x: Not supported\n",
-			       cmd);
+			pr_err("gsmi: exec 0x%04x: Not supported\n", cmd);
 		rc = -ENOSYS;
 		break;
 	case GSMI_NOT_READY:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Not ready\n", cmd);
+		pr_err("gsmi: exec 0x%04x: Not ready\n", cmd);
 		rc = -EBUSY;
 		break;
 	case GSMI_DEVICE_ERROR:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Device error\n", cmd);
+		pr_err("gsmi: exec 0x%04x: Device error\n", cmd);
 		rc = -EFAULT;
 		break;
 	case GSMI_NOT_FOUND:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Data not found\n", cmd);
+		pr_err("gsmi: exec 0x%04x: Data not found\n", cmd);
 		rc = -ENOENT;
 		break;
 	case GSMI_LOG_FULL:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Log full\n", cmd);
+		pr_err("gsmi: exec 0x%04x: Log full\n", cmd);
 		rc = -ENOSPC;
 		break;
 	case GSMI_HANDSHAKE_CF:
@@ -293,7 +292,7 @@ static int gsmi_exec(u8 func, u8 sub)
 		rc = result;
 		break;
 	default:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Unknown error 0x%04x\n",
+		pr_err("gsmi: exec 0x%04x: Unknown error 0x%04x\n",
 		       cmd, result);
 		rc = -ENXIO;
 	}
@@ -341,7 +340,7 @@ static efi_status_t gsmi_get_variable(efi_char16_t *name,
 
 	rc = gsmi_exec(GSMI_CALLBACK, GSMI_CMD_GET_NVRAM_VAR);
 	if (rc < 0) {
-		printk(KERN_ERR "gsmi: Get Variable failed\n");
+		pr_err("gsmi: Get Variable failed\n");
 		ret = EFI_LOAD_ERROR;
 	} else if (rc == 1) {
 		/* variable was not found */
@@ -403,7 +402,7 @@ static efi_status_t gsmi_get_next_variable(unsigned long *name_size,
 
 	rc = gsmi_exec(GSMI_CALLBACK, GSMI_CMD_GET_NEXT_VAR);
 	if (rc < 0) {
-		printk(KERN_ERR "gsmi: Get Next Variable Name failed\n");
+		pr_err("gsmi: Get Next Variable Name failed\n");
 		ret = EFI_LOAD_ERROR;
 	} else if (rc == 1) {
 		/* variable not found -- end of list */
@@ -467,7 +466,7 @@ static efi_status_t gsmi_set_variable(efi_char16_t *name,
 
 	rc = gsmi_exec(GSMI_CALLBACK, GSMI_CMD_SET_NVRAM_VAR);
 	if (rc < 0) {
-		printk(KERN_ERR "gsmi: Set Variable failed\n");
+		pr_err("gsmi: Set Variable failed\n");
 		ret = EFI_INVALID_PARAMETER;
 	}
 
@@ -517,7 +516,7 @@ static ssize_t eventlog_write(struct file *filp, struct kobject *kobj,
 
 	rc = gsmi_exec(GSMI_CALLBACK, GSMI_CMD_SET_EVENT_LOG);
 	if (rc < 0)
-		printk(KERN_ERR "gsmi: Set Event Log failed\n");
+		pr_err("gsmi: Set Event Log failed\n");
 
 	spin_unlock_irqrestore(&gsmi_dev.lock, flags);
 
@@ -645,10 +644,9 @@ static int gsmi_shutdown_reason(int reason)
 	spin_unlock_irqrestore(&gsmi_dev.lock, flags);
 
 	if (rc < 0)
-		printk(KERN_ERR "gsmi: Log Shutdown Reason failed\n");
+		pr_err("gsmi: Log Shutdown Reason failed\n");
 	else
-		printk(KERN_EMERG "gsmi: Log Shutdown Reason 0x%02x\n",
-		       reason);
+		pr_emerg("gsmi: Log Shutdown Reason 0x%02x\n", reason);
 
 	return rc;
 }
@@ -759,7 +757,7 @@ static __init int gsmi_system_valid(void)
 	 * whitewash our board names out of the public driver.
 	 */
 	if (!strncmp(acpi_gbl_FADT.header.oem_table_id, "FACP", 4)) {
-		printk(KERN_INFO "gsmi: Board is too old\n");
+		pr_info("gsmi: Board is too old\n");
 		return -ENODEV;
 	}
 
@@ -879,7 +877,7 @@ static __init int gsmi_init(void)
 #ifdef CONFIG_PM
 	ret = platform_driver_register(&gsmi_driver_info);
 	if (unlikely(ret)) {
-		printk(KERN_ERR "gsmi: unable to register platform driver\n");
+		pr_err("gsmi: unable to register platform driver\n");
 		return ret;
 	}
 #endif
@@ -887,7 +885,7 @@ static __init int gsmi_init(void)
 	/* register device */
 	gsmi_dev.pdev = platform_device_register_full(&gsmi_dev_info);
 	if (IS_ERR(gsmi_dev.pdev)) {
-		printk(KERN_ERR "gsmi: unable to register platform device\n");
+		pr_err("gsmi: unable to register platform device\n");
 		return PTR_ERR(gsmi_dev.pdev);
 	}
 
@@ -906,19 +904,19 @@ static __init int gsmi_init(void)
 	 */
 	gsmi_dev.name_buf = gsmi_buf_alloc();
 	if (!gsmi_dev.name_buf) {
-		printk(KERN_ERR "gsmi: failed to allocate name buffer\n");
+		pr_err("gsmi: failed to allocate name buffer\n");
 		goto out_err;
 	}
 
 	gsmi_dev.data_buf = gsmi_buf_alloc();
 	if (!gsmi_dev.data_buf) {
-		printk(KERN_ERR "gsmi: failed to allocate data buffer\n");
+		pr_err("gsmi: failed to allocate data buffer\n");
 		goto out_err;
 	}
 
 	gsmi_dev.param_buf = gsmi_buf_alloc();
 	if (!gsmi_dev.param_buf) {
-		printk(KERN_ERR "gsmi: failed to allocate param buffer\n");
+		pr_err("gsmi: failed to allocate param buffer\n");
 		goto out_err;
 	}
 
@@ -960,8 +958,7 @@ static __init int gsmi_init(void)
 
 	/* Remove and clean up gsmi if the handshake could not complete. */
 	if (gsmi_dev.handshake_type == -ENXIO) {
-		printk(KERN_INFO "gsmi version " DRIVER_VERSION
-		       " failed to load\n");
+		pr_info("gsmi version " DRIVER_VERSION " failed to load\n");
 		ret = -ENODEV;
 		goto out_err;
 	}
@@ -970,28 +967,28 @@ static __init int gsmi_init(void)
 	ret = -ENOMEM;
 	gsmi_kobj = kobject_create_and_add("gsmi", firmware_kobj);
 	if (!gsmi_kobj) {
-		printk(KERN_INFO "gsmi: Failed to create firmware kobj\n");
+		pr_info("gsmi: Failed to create firmware kobj\n");
 		goto out_err;
 	}
 
 	/* Setup eventlog access */
 	ret = sysfs_create_bin_file(gsmi_kobj, &eventlog_bin_attr);
 	if (ret) {
-		printk(KERN_INFO "gsmi: Failed to setup eventlog");
+		pr_info("gsmi: Failed to setup eventlog");
 		goto out_err;
 	}
 
 	/* Other attributes */
 	ret = sysfs_create_files(gsmi_kobj, gsmi_attrs);
 	if (ret) {
-		printk(KERN_INFO "gsmi: Failed to add attrs");
+		pr_info("gsmi: Failed to add attrs");
 		goto out_remove_bin_file;
 	}
 
 #ifdef CONFIG_EFI_VARS
 	ret = efivars_register(&efivars, &efivar_ops, gsmi_kobj);
 	if (ret) {
-		printk(KERN_INFO "gsmi: Failed to register efivars\n");
+		pr_info("gsmi: Failed to register efivars\n");
 		sysfs_remove_files(gsmi_kobj, gsmi_attrs);
 		goto out_remove_bin_file;
 	}
@@ -1002,7 +999,7 @@ static __init int gsmi_init(void)
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &gsmi_panic_notifier);
 
-	printk(KERN_INFO "gsmi version " DRIVER_VERSION " loaded\n");
+	pr_info("gsmi version " DRIVER_VERSION " loaded\n");
 
 	return 0;
 
-- 
2.20.1

