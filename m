Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E44C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1C320850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW1FwlFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfCUJtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:49:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40026 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfCUJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:49:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id u10so1969022wmj.5;
        Thu, 21 Mar 2019 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MR0uk8pASKV8lQAfJTqZUgDpc9OwlmwmE8dwWlnCgw=;
        b=WW1FwlFdEGnesXSfKzucS9Oz9YkDmR3RjfI5IP/NKFaryxicahpStfptneQWpZXgLz
         ikJghjoa8OOcucSTWvFp0+0sR7enMWtG/4I4BkyReKqLDVPAXEOAfb/N0E8vraL5a7sO
         7yBZ/TVRPvpMFI674GvhIFJ10/uOiDzTi9Z4u2Z3bBFObIPA3a5Jeif3XHLVtr12pEaO
         jIFD4a5jwxEuYowzDG2Lsk2DEULNjRtZztdg9xqmJwuY81CYa6SSAEGNvwwaJ68Xf++C
         MckcWvsDll/9P6F7RY4hpFwo63Joo2uQkAVrJrGuFEtHBniGaCO+2mfuKeFF+FwPxohs
         CqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MR0uk8pASKV8lQAfJTqZUgDpc9OwlmwmE8dwWlnCgw=;
        b=TzYFp9eNr7/N3/pVq3P7n8/QzbbiAJ8Vjta8v2HR47wkSDC8RjHRKLrFCPrRnaPdK3
         FDltBj7ic/3jTdn6oy1qQ4Z1P9TWAcUyXWdaoLPSLknwuE43MClMkGXlbFvdWTuVpqNY
         kFdlCwCIcUQBTpP15jBLHRB5ul9LjvfvzTxJpntdM/XZFSRCQ7dQVUx6zcEb7uiWSZD/
         euInofmSbBtv9Xg+Cr8gu0p6PgHO+xXfpypPUWtdPRZzt1wxvEd94/yTNxrGnpbGgent
         IZMDtJorLbaAU+7OByItdkclFIthlHHHnysTtu9HWUaM6Fymr1n2nepSqrr5zJePK6Cv
         6jXg==
X-Gm-Message-State: APjAAAWL8HKw3m06LtYV96DU0BP5PStVVeMs44ivTpjoRbmmNw6w7xHT
        e98Ol3OszcBzUEH1kjBfYJI6qHEUdws=
X-Google-Smtp-Source: APXvYqz40wjjfQ1HpNjqZnoWrVqX2snEprU5sSm394pYanEdu3T397uf5JMNcsJ+LLRwjJL2GVl9OA==
X-Received: by 2002:a1c:3845:: with SMTP id f66mr1893095wma.41.1553161776455;
        Thu, 21 Mar 2019 02:49:36 -0700 (PDT)
Received: from laptop.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id e12sm5900656wrt.94.2019.03.21.02.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 02:49:34 -0700 (PDT)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     Erwan Velu <e.velu@criteo.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com (open list:MICROSEMI SMART ARRAY SMARTPQI
        DRIVER (smartpqi)),
        linux-scsi@vger.kernel.org (open list:MICROSEMI SMART ARRAY SMARTPQI
        DRIVER (smartpqi)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: smartpqi: Reporting unhandled SCSI errors
Date:   Thu, 21 Mar 2019 10:49:27 +0100
Message-Id: <20190321094928.4198-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a HARDWARE_ERROR is triggered for asc=0x3e, the actual code is only considering the case where ascq=0x1.

Following the http://www.t10.org/lists/asc-num.htm#ASC_3E specification, other values may occur like a timeout (ascq=0x2).

This patch is about printing an error message when a non-handled message is received.
This could help diagnose a possible miss-behavior of the controller and/or a missing implementation in the Linux Kernel.

This patch keeps the exact same error handling but prints a message if an ascq != 1 income.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 75ec43aa8df3..baf16c138800 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2762,16 +2762,25 @@ static void pqi_process_raid_io_error(struct pqi_io_request *io_request)
 			scsi_normalize_sense(error_info->data,
 				sense_data_length, &sshdr) &&
 				sshdr.sense_key == HARDWARE_ERROR &&
-				sshdr.asc == 0x3e &&
-				sshdr.ascq == 0x1) {
+				sshdr.asc == 0x3e) {
 			struct pqi_ctrl_info *ctrl_info = shost_to_hba(scmd->device->host);
 			struct pqi_scsi_dev *device = scmd->device->hostdata;
 
-			if (printk_ratelimit())
-				scmd_printk(KERN_ERR, scmd, "received 'logical unit failure' from controller for scsi %d:%d:%d:%d\n",
-					ctrl_info->scsi_host->host_no, device->bus, device->target, device->lun);
-			pqi_take_device_offline(scmd->device, "RAID");
-			host_byte = DID_NO_CONNECT;
+			switch (sshdr.ascq) {
+			case 0x1: /*LOGICAL UNIT FAILURE */
+				if (printk_ratelimit())
+					scmd_printk(KERN_ERR, scmd, "received 'logical unit failure' from controller for scsi %d:%d:%d:%d\n",
+						ctrl_info->scsi_host->host_no, device->bus, device->target, device->lun);
+				pqi_take_device_offline(scmd->device, "RAID");
+				host_byte = DID_NO_CONNECT;
+				break;
+
+			default: /* See http://www.t10.org/lists/asc-num.htm#ASC_3E */
+				if (printk_ratelimit())
+					scmd_printk(KERN_ERR, scmd, "received unhandled error %d from controller for scsi %d:%d:%d:%d\n",
+						sshdr.ascq, ctrl_info->scsi_host->host_no, device->bus, device->target, device->lun);
+				break;
+			}
 		}
 
 		if (sense_data_length > SCSI_SENSE_BUFFERSIZE)
-- 
2.20.1

