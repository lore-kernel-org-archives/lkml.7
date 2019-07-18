Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0FBC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2D421841
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1xi765P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389310AbfGRHpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:45:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40223 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRHpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:45:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so12488039pgj.7;
        Thu, 18 Jul 2019 00:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYg175Do8ulNmF1GihD7s07sa1JEEtvEBEJHzo1oiXs=;
        b=U1xi765P5BHoCVO87bBSYGBNnHnNnLhMVvRX26T15rQit+QyLMQsVJmI5gO1jYh4+i
         SXGLCt2B/OgZwEsrlaZXfdOJQFeopTCjWrJYO6mbYnDCZJfnsIiAGgPd0mijuCYjfgvp
         CIodNtNHFgdlx+JuesbmiYhb5oY9iAl5ysdZoj+vT9M9GqdQ0L9StOHdMidHJk7O43FM
         E9WmXW6IrnIUoVC/CIy2ATn7en2FHBTM1YLfTn+uH31ylDE2Gb376kVEJBKgL//g6blj
         ZMniJVQ+JsUOGJ+tYPhUhVcmWhRFMyl5D2pGbMbDCEeptcSxwyIWv21awiOdYq94S/5E
         ZD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYg175Do8ulNmF1GihD7s07sa1JEEtvEBEJHzo1oiXs=;
        b=quhCIUXcYYxE/c9WVH0Fp2QvOVhUidNng9zzsv0ig5AFlbiqcrJJCD3Dbr+3z+v7eP
         8f/TaioZKD1h2BW9b00FFbvK1FKeSAca582HBwMykA6tvmeLsXG8lHVSYbrPTAMCQbg8
         4pumSnplnoyjRaEKzyJ79xB/DVSkuw5zOTYHgu31nsR+FppnkOOJLLB2HrwgsNfMvlU7
         9pjmD5B7JozwWi/tnfd43ED5yJrmxDxP0FgHhYTp6xX4Yf9XpyvllRDQXPDh84pM2npu
         FKM0lfs2sJNKxV1MCCIFBkAoxJtXy/SFeyYG7m4Z625tdrIheTqS/N3SbZAtkWZ7tufE
         E13w==
X-Gm-Message-State: APjAAAUvHncBxTmtv5KlAKVWMfbaEhrs+S1CCr5Ao3W3xSl55B7N41ZA
        NFB1UeGPq5POq9oMLhYPLX0=
X-Google-Smtp-Source: APXvYqzK7nB7cyQB8dbgD8opmtY/G40dqXGy1mNVncPwxvZXhsWzp3qBDIsPYPzQpv+VFb6jdRyYdQ==
X-Received: by 2002:a65:6281:: with SMTP id f1mr43590875pgv.400.1563435940226;
        Thu, 18 Jul 2019 00:45:40 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id y128sm42349646pgy.41.2019.07.18.00.45.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 00:45:39 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     qla2xxx-upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 1/3] scsi: qla2xxx: Replace vmalloc + memset with vzalloc
Date:   Thu, 18 Jul 2019 15:45:18 +0800
Message-Id: <20190718074518.16273-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vzalloc instead of using vmalloc to allocate memory
and then zeroing it with memset.
This simplifies the code.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---

 drivers/scsi/qla2xxx/qla_attr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 8d560c562e9c..2b92d4659934 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -382,7 +382,7 @@ qla2x00_sysfs_write_optrom_ctl(struct file *filp, struct kobject *kobj,
 		ha->optrom_region_size = size;
 
 		ha->optrom_state = QLA_SREADING;
-		ha->optrom_buffer = vmalloc(ha->optrom_region_size);
+		ha->optrom_buffer = vzalloc(ha->optrom_region_size);
 		if (ha->optrom_buffer == NULL) {
 			ql_log(ql_log_warn, vha, 0x7062,
 			    "Unable to allocate memory for optrom retrieval "
@@ -404,7 +404,6 @@ qla2x00_sysfs_write_optrom_ctl(struct file *filp, struct kobject *kobj,
 		    "Reading flash region -- 0x%x/0x%x.\n",
 		    ha->optrom_region_start, ha->optrom_region_size);
 
-		memset(ha->optrom_buffer, 0, ha->optrom_region_size);
 		ha->isp_ops->read_optrom(vha, ha->optrom_buffer,
 		    ha->optrom_region_start, ha->optrom_region_size);
 		break;
@@ -457,7 +456,7 @@ qla2x00_sysfs_write_optrom_ctl(struct file *filp, struct kobject *kobj,
 		ha->optrom_region_size = size;
 
 		ha->optrom_state = QLA_SWRITING;
-		ha->optrom_buffer = vmalloc(ha->optrom_region_size);
+		ha->optrom_buffer = vzalloc(ha->optrom_region_size);
 		if (ha->optrom_buffer == NULL) {
 			ql_log(ql_log_warn, vha, 0x7066,
 			    "Unable to allocate memory for optrom update "
@@ -472,7 +471,6 @@ qla2x00_sysfs_write_optrom_ctl(struct file *filp, struct kobject *kobj,
 		    "Staging flash region write -- 0x%x/0x%x.\n",
 		    ha->optrom_region_start, ha->optrom_region_size);
 
-		memset(ha->optrom_buffer, 0, ha->optrom_region_size);
 		break;
 	case 3:
 		if (ha->optrom_state != QLA_SWRITING) {
-- 
2.20.1

