Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EDCC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302AA2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN5h89mX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389034AbfCAQIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:08:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34952 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388766AbfCAQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:08:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id t18so26467518wrx.2;
        Fri, 01 Mar 2019 08:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4gggITcMgod2Lm/zGJNQ1je7KPeeuFnHTHGaIHCh1mE=;
        b=lN5h89mX8Ntc/2X82oFqDJDspyRfViSOwHYiWO00thkfZRkX75NAS/r8Sv9m3l5ozs
         6UYnzpLtF/17ZPc5HDxxj6U161TzMoMs03ylmeCfBbXIltRTqHyxBRyAf/YHDNAj/s99
         mxSO9KCD6eLoORepKHhERVaxundOGCkF3POa34gctHcAAtep6KvyF99iigxwSB5Zvjfc
         yzyT0toVAF719jGiaKwZLcZuEhJIqWWicodbxDn4jWEvFZEFn7R2RInZT39SsQbB9r+Q
         FLXwK9UHcqX1gMjtSkavCFNiTHZE4Y8VdER5PvinBrnKkL0VtUZAm1jthSht6I/Kr73Y
         WdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gggITcMgod2Lm/zGJNQ1je7KPeeuFnHTHGaIHCh1mE=;
        b=JmJFDEZO6FSfNhR+XWeQ2P2Mr5m2JwEfyWpa+EXOq8QGoL31/dN+IDuTKpaY8aZRwS
         Ws+4jID1+t8TB96pMoAatBVLiatSFnIUc8ATcj2llflaLo1HoRRGLoszARwviz2MfNtQ
         EfNhEYZtyi2KUi2CZyTruqpxUIH6wfFnJnIsm5Fvm2dQH2pasG6ARrhALVmGkEWn1WmK
         eeTYUQ2SyEnBSs23XBExgA3TcXMfIwWl+EclMkh2sDiv3C0/Z8r7W41eiC6MbrMZNbSj
         xdbdGJLbtGIpkhkzx/KwHzXrnznWU93DcxCFvZVBEkCTwMUlUtYOplpfjAM1fkPAenCJ
         RBcA==
X-Gm-Message-State: APjAAAUFJRQQQIEq9a3WZP45PZDjpSPrzHwzeJAWVze2S+wmNYgMT90z
        1AJmL7SbSnF12Hz6L9c07+bO2fJxpsw=
X-Google-Smtp-Source: APXvYqzhaxHXnXOszFzWOlcg/FKOjYmbZ+KqOSJW4gAyvQM3WX1aHUVh5d4pphlpTXqD7YLx5wg9Sw==
X-Received: by 2002:adf:e5cc:: with SMTP id a12mr4270383wrn.130.1551456495003;
        Fri, 01 Mar 2019 08:08:15 -0800 (PST)
Received: from laptop.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id c126sm14850713wma.0.2019.03.01.08.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 08:08:13 -0800 (PST)
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
Subject: [PATCH v3] scsi: smartpqi_init: Reporting 'logical unit failure'
Date:   Fri,  1 Mar 2019 17:08:06 +0100
Message-Id: <20190301160806.16099-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1551455797.3334.6.camel@linux.ibm.com>
References: <1551455797.3334.6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the HARDWARE_ERROR/0x3e/0x1 case is triggered, the logical volume is offlined.
When reading the kernel log, the reason why the device got offlined isn't reported to the user.
This situation makes difficult for admins to estimate the root cause of the issue they analize.

Reading this part of the code makes clear this is because driver received a HARDWARE_ERROR/0x3e/0x1 which is a 'logical unit failure'.
This patch is just about reporting the reason behind the offlining to ease the analyse.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index f564af8949e8..adebafe56b5b 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2764,6 +2764,12 @@ static void pqi_process_raid_io_error(struct pqi_io_request *io_request)
 				sshdr.sense_key == HARDWARE_ERROR &&
 				sshdr.asc == 0x3e &&
 				sshdr.ascq == 0x1) {
+			struct pqi_ctrl_info *ctrl_info = shost_to_hba(scmd->device->host);
+			struct pqi_scsi_dev *device = scmd->device->hostdata;
+
+			if (printk_ratelimit())
+				scmd_printk(KERN_ERR, scmd, "received 'logical unit failure' from controller for scsi %d:%d:%d:%d\n",
+					ctrl_info->scsi_host->host_no, device->bus, device->target, device->lun);
 			pqi_take_device_offline(scmd->device, "RAID");
 			host_byte = DID_NO_CONNECT;
 		}
-- 
2.20.1

