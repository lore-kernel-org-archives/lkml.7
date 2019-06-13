Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9F8C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512AC20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t92XLV2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfFMS5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:57:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35933 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfFMS5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:57:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so8527128plr.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=P1pdlLdm9KtvlkZGzA4eYZG9saeKJuP3nZzZZhMXVNM=;
        b=t92XLV2q4blKHfz+WTpefrpKRvYSWqQM/lIkv2+un9gpwGlnPKOOKN6sAKab9cyyrn
         /pAeTq02tFJJpL+yPNwZZnhuBtZ+c/tUO23nlcildLZqOeq4c12uOUrEImxiq5sjYrHf
         TXEyo6Wi2O41YcauaBj5mFXZ5vbINxzekf5nGty7p96TWMnWhS8Nom5HOm/jgSBKEXWJ
         Kh33sqgSjasTlI0jkO95uULAPYmScCDR38GEzOxCHs8MlTfv6SA0skO1x4f1WUMH2tQx
         QdJoENuP+59IXRoYuYMtO8AK5HiW3Ewvt+kNq/Zw9cEDeSJJMZdjw5frYpCfKQq5LLW1
         Aw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=P1pdlLdm9KtvlkZGzA4eYZG9saeKJuP3nZzZZhMXVNM=;
        b=B//wRhm9V4G5qh7Eeb5wxImwQBdrQlzadvCpOIvmfKqvXKL73k1L0gp0H1K6CQie2V
         wK+vyL4hUbHIZ0YnKbNZkga5DPjpO0fgmeOCRzRPJUAm0iYh+A3h5ACS99GLtNeNkVtd
         R0uLkQ7FnIybWSyX0vixPW9xry72YcMzV82gzCU/woOqXbGj5QhBGWXwd6VpS/LxalsX
         gKnmdehfybKeAriIIA0DrdiaB6WXyjJL7KQl6afSmW61Bjz7rW54+erxRuWQOvjUl4Qi
         QajH9ml92AGJ2ymvo4iWHMVPmZ+dAclbfOow7Y/0GIYqQ28rsWckjSE2681q4lnKc0na
         y6sQ==
X-Gm-Message-State: APjAAAWUPPXUlBXkOQ41CeH+7WWR0PGYjmVbFMvJ8OIUKHRihWwyTH32
        LZu2KP6vFmh78T54HAF9zmmKPNWua1I=
X-Google-Smtp-Source: APXvYqxtCNW2UWTIT3xtGiV3vuzF4GdlBwjOWdtkpggbmxJ6ifhjBjdjyE4wAAMGRFg22/uI0Vgezw==
X-Received: by 2002:a17:902:2ae7:: with SMTP id j94mr5149526plb.270.1560452243530;
        Thu, 13 Jun 2019 11:57:23 -0700 (PDT)
Received: from ahmlpt0706 ([106.213.193.147])
        by smtp.gmail.com with ESMTPSA id g5sm498853pfm.54.2019.06.13.11.57.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 11:57:22 -0700 (PDT)
Date:   Fri, 14 Jun 2019 00:27:05 +0530
From:   Saiyam Doshi <saiyamdoshi.in@gmail.com>
To:     gregkh@linuxfoundation.org, groeck@google.com
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        adurbin@chromium.org, dlaurie@chromium.org
Subject: [PATCH] gsmi: replace printk with relevant dev_<level>
Message-ID: <20190613185705.GA16951@ahmlpt0706>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace printk() with dev_* macros for logging consistency.
In process of replacing printk with dev_err, dev_info etc.,
removed unnecessary "out of memory" debug message.

This also fixes checkpatch.pl warnings.

Signed-off-by: Saiyam Doshi <saiyamdoshi.in@gmail.com>
---
 drivers/firmware/google/gsmi.c | 68 ++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index edaa4e5d84ad..db11fc896c42 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -151,7 +151,6 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
 
 	smibuf = kzalloc(sizeof(*smibuf), GFP_KERNEL);
 	if (!smibuf) {
-		printk(KERN_ERR "gsmi: out of memory\n");
 		return NULL;
 	}
 
@@ -159,7 +158,7 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
 	smibuf->start = dma_pool_alloc(gsmi_dev.dma_pool, GFP_KERNEL,
 				       &smibuf->handle);
 	if (!smibuf->start) {
-		printk(KERN_ERR "gsmi: failed to allocate name buffer\n");
+		dev_err(&gsmi_dev.pdev->dev, "failed to allocate name buffer\n");
 		kfree(smibuf);
 		return NULL;
 	}
@@ -257,34 +256,40 @@ static int gsmi_exec(u8 func, u8 sub)
 		rc = 1;
 		break;
 	case GSMI_INVALID_PARAMETER:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Invalid parameter\n", cmd);
+		dev_err(&gsmi_dev.pdev->dev,
+			"exec 0x%04x: Invalid parameter\n", cmd);
 		rc = -EINVAL;
 		break;
 	case GSMI_BUFFER_TOO_SMALL:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Buffer too small\n", cmd);
+		dev_err(&gsmi_dev.pdev->dev,
+			"exec 0x%04x: Buffer too small\n", cmd);
 		rc = -ENOMEM;
 		break;
 	case GSMI_UNSUPPORTED:
 	case GSMI_UNSUPPORTED2:
 		if (sub != GSMI_CMD_HANDSHAKE_TYPE)
-			printk(KERN_ERR "gsmi: exec 0x%04x: Not supported\n",
-			       cmd);
+			dev_err(&gsmi_dev.pdev->dev,
+				"exec 0x%04x: Not supported\n", cmd);
 		rc = -ENOSYS;
 		break;
 	case GSMI_NOT_READY:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Not ready\n", cmd);
+		dev_err(&gsmi_dev.pdev->dev,
+			"exec 0x%04x: Not ready\n", cmd);
 		rc = -EBUSY;
 		break;
 	case GSMI_DEVICE_ERROR:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Device error\n", cmd);
+		dev_err(&gsmi_dev.pdev->dev,
+			"exec 0x%04x: Device error\n", cmd);
 		rc = -EFAULT;
 		break;
 	case GSMI_NOT_FOUND:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Data not found\n", cmd);
+		dev_err(&gsmi_dev.pdev->dev,
+			"exec 0x%04x: Data not found\n", cmd);
 		rc = -ENOENT;
 		break;
 	case GSMI_LOG_FULL:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Log full\n", cmd);
+		dev_err(&gsmi_dev.pdev->dev,
+			"exec 0x%04x: Log full\n", cmd);
 		rc = -ENOSPC;
 		break;
 	case GSMI_HANDSHAKE_CF:
@@ -293,8 +298,8 @@ static int gsmi_exec(u8 func, u8 sub)
 		rc = result;
 		break;
 	default:
-		printk(KERN_ERR "gsmi: exec 0x%04x: Unknown error 0x%04x\n",
-		       cmd, result);
+		dev_err(&gsmi_dev.pdev->dev,
+			"exec 0x%04x: Unknown error 0x%04x\n", cmd, result);
 		rc = -ENXIO;
 	}
 
@@ -341,7 +346,7 @@ static efi_status_t gsmi_get_variable(efi_char16_t *name,
 
 	rc = gsmi_exec(GSMI_CALLBACK, GSMI_CMD_GET_NVRAM_VAR);
 	if (rc < 0) {
-		printk(KERN_ERR "gsmi: Get Variable failed\n");
+		dev_err(&gsmi_dev.pdev->dev, "Get Variable failed\n");
 		ret = EFI_LOAD_ERROR;
 	} else if (rc == 1) {
 		/* variable was not found */
@@ -403,7 +408,7 @@ static efi_status_t gsmi_get_next_variable(unsigned long *name_size,
 
 	rc = gsmi_exec(GSMI_CALLBACK, GSMI_CMD_GET_NEXT_VAR);
 	if (rc < 0) {
-		printk(KERN_ERR "gsmi: Get Next Variable Name failed\n");
+		dev_err(&gsmi_dev.pdev->dev, "Get Next Variable Name failed\n");
 		ret = EFI_LOAD_ERROR;
 	} else if (rc == 1) {
 		/* variable not found -- end of list */
@@ -467,7 +472,7 @@ static efi_status_t gsmi_set_variable(efi_char16_t *name,
 
 	rc = gsmi_exec(GSMI_CALLBACK, GSMI_CMD_SET_NVRAM_VAR);
 	if (rc < 0) {
-		printk(KERN_ERR "gsmi: Set Variable failed\n");
+		dev_err(&gsmi_dev.pdev->dev, "Set Variable failed\n");
 		ret = EFI_INVALID_PARAMETER;
 	}
 
@@ -517,7 +522,7 @@ static ssize_t eventlog_write(struct file *filp, struct kobject *kobj,
 
 	rc = gsmi_exec(GSMI_CALLBACK, GSMI_CMD_SET_EVENT_LOG);
 	if (rc < 0)
-		printk(KERN_ERR "gsmi: Set Event Log failed\n");
+		dev_err(&gsmi_dev.pdev->dev, "Set Event Log failed\n");
 
 	spin_unlock_irqrestore(&gsmi_dev.lock, flags);
 
@@ -645,10 +650,10 @@ static int gsmi_shutdown_reason(int reason)
 	spin_unlock_irqrestore(&gsmi_dev.lock, flags);
 
 	if (rc < 0)
-		printk(KERN_ERR "gsmi: Log Shutdown Reason failed\n");
+		dev_err(&gsmi_dev.pdev->dev, "Log Shutdown Reason failed\n");
 	else
-		printk(KERN_EMERG "gsmi: Log Shutdown Reason 0x%02x\n",
-		       reason);
+		dev_emerg(&gsmi_dev.pdev->dev, "Log Shutdown Reason 0x%02x\n",
+			  reason);
 
 	return rc;
 }
@@ -759,7 +764,7 @@ static __init int gsmi_system_valid(void)
 	 * whitewash our board names out of the public driver.
 	 */
 	if (!strncmp(acpi_gbl_FADT.header.oem_table_id, "FACP", 4)) {
-		printk(KERN_INFO "gsmi: Board is too old\n");
+		dev_info(&gsmi_dev.pdev->dev, "Board is too old\n");
 		return -ENODEV;
 	}
 
@@ -879,7 +884,7 @@ static __init int gsmi_init(void)
 #ifdef CONFIG_PM
 	ret = platform_driver_register(&gsmi_driver_info);
 	if (unlikely(ret)) {
-		printk(KERN_ERR "gsmi: unable to register platform driver\n");
+		dev_err(&gsmi_dev.pdev->dev, "unable to register platform driver\n");
 		return ret;
 	}
 #endif
@@ -887,7 +892,7 @@ static __init int gsmi_init(void)
 	/* register device */
 	gsmi_dev.pdev = platform_device_register_full(&gsmi_dev_info);
 	if (IS_ERR(gsmi_dev.pdev)) {
-		printk(KERN_ERR "gsmi: unable to register platform device\n");
+		dev_err(&gsmi_dev.pdev->dev, "unable to register platform device\n");
 		return PTR_ERR(gsmi_dev.pdev);
 	}
 
@@ -906,19 +911,19 @@ static __init int gsmi_init(void)
 	 */
 	gsmi_dev.name_buf = gsmi_buf_alloc();
 	if (!gsmi_dev.name_buf) {
-		printk(KERN_ERR "gsmi: failed to allocate name buffer\n");
+		dev_err(&gsmi_dev.pdev->dev, "failed to allocate name buffer\n");
 		goto out_err;
 	}
 
 	gsmi_dev.data_buf = gsmi_buf_alloc();
 	if (!gsmi_dev.data_buf) {
-		printk(KERN_ERR "gsmi: failed to allocate data buffer\n");
+		dev_err(&gsmi_dev.pdev->dev, "failed to allocate data buffer\n");
 		goto out_err;
 	}
 
 	gsmi_dev.param_buf = gsmi_buf_alloc();
 	if (!gsmi_dev.param_buf) {
-		printk(KERN_ERR "gsmi: failed to allocate param buffer\n");
+		dev_err(&gsmi_dev.pdev->dev, "failed to allocate param buffer\n");
 		goto out_err;
 	}
 
@@ -960,7 +965,7 @@ static __init int gsmi_init(void)
 
 	/* Remove and clean up gsmi if the handshake could not complete. */
 	if (gsmi_dev.handshake_type == -ENXIO) {
-		printk(KERN_INFO "gsmi version " DRIVER_VERSION
+		dev_info(&gsmi_dev.pdev->dev, "gsmi version " DRIVER_VERSION
 		       " failed to load\n");
 		ret = -ENODEV;
 		goto out_err;
@@ -970,28 +975,28 @@ static __init int gsmi_init(void)
 	ret = -ENOMEM;
 	gsmi_kobj = kobject_create_and_add("gsmi", firmware_kobj);
 	if (!gsmi_kobj) {
-		printk(KERN_INFO "gsmi: Failed to create firmware kobj\n");
+		dev_info(&gsmi_dev.pdev->dev, "Failed to create firmware kobj\n");
 		goto out_err;
 	}
 
 	/* Setup eventlog access */
 	ret = sysfs_create_bin_file(gsmi_kobj, &eventlog_bin_attr);
 	if (ret) {
-		printk(KERN_INFO "gsmi: Failed to setup eventlog");
+		dev_info(&gsmi_dev.pdev->dev, "Failed to setup eventlog");
 		goto out_err;
 	}
 
 	/* Other attributes */
 	ret = sysfs_create_files(gsmi_kobj, gsmi_attrs);
 	if (ret) {
-		printk(KERN_INFO "gsmi: Failed to add attrs");
+		dev_info(&gsmi_dev.pdev->dev, "Failed to add attrs");
 		goto out_remove_bin_file;
 	}
 
 #ifdef CONFIG_EFI_VARS
 	ret = efivars_register(&efivars, &efivar_ops, gsmi_kobj);
 	if (ret) {
-		printk(KERN_INFO "gsmi: Failed to register efivars\n");
+		dev_info(&gsmi_dev.pdev->dev, "Failed to register efivars\n");
 		sysfs_remove_files(gsmi_kobj, gsmi_attrs);
 		goto out_remove_bin_file;
 	}
@@ -1002,7 +1007,8 @@ static __init int gsmi_init(void)
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &gsmi_panic_notifier);
 
-	printk(KERN_INFO "gsmi version " DRIVER_VERSION " loaded\n");
+	dev_info(&gsmi_dev.pdev->dev,
+		 "gsmi version " DRIVER_VERSION " loaded\n");
 
 	return 0;
 
-- 
2.20.1

