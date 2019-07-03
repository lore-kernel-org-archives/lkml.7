Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78471C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCDB218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMVUZFjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfGCNRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:17:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42032 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCNRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:17:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so1267611pff.9;
        Wed, 03 Jul 2019 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LEzHlm28gGet2lhOMmasiQomKY8boopFZ+WIZBJDyvs=;
        b=WMVUZFjzHMTx1SiFC6QqBmLu5L/8GKw7D8NU1p+UR8LRgD472Wu+CccWaogEDGjQHh
         F9o84urBZVUOCt33V94Vrh5dt3/hS80w5vHz9HWFDEFkSMFlUlqZ0ZxjDYw78RMVQAuB
         6gGNd2H5uIr+PTzDp7WgEVUQih6Sb1wi2Q3sF3bOSSOLplYvVq/YjEAhdGsCb9oRJgYx
         tVGT7BHsYdlIe6eVZvG9U9ecxpFc8/PpCQtzwOX3goMknaYj49cfjnH0b8hfm/HguVj5
         oFr9PGbe39OIrYSwZ+R5F/RBxrSalthAfS8/jIyw8FYCx7wbW1MRXSmfLs9nEmzJ04do
         9HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LEzHlm28gGet2lhOMmasiQomKY8boopFZ+WIZBJDyvs=;
        b=Jixd7sFwKU0gHZPsLYc0TYmPbo+tiHxRlSviQSMsXdlLU0RqstD2W1sqw4njlrYxwd
         mPrjwTawvjawvdJ/C8gRY8n1urXz9jj3ZrDJO50jsX8P0HK3bd5neF1QoP8dfmIx9Rru
         vKtyb+GeSea4qJn4iglV4ZaOHzBtqarNM/7oxqiuh5aIcUE0d95bfi+7LbP7kz2Iq7H7
         4SKof0v3ngH/znhjmcMH5mLRMtotYNyvVJiOMWhz7VIx1XX+jmYx8t32dUKQvBYvWySQ
         zibvA9iZ9zwYKc39vvxBNUpIXxvixknx+rlywCD6zcBld/qIILpbnPVZBJKGunnAgsuG
         ikgw==
X-Gm-Message-State: APjAAAVHqE3w1mGHe0DJUiN8Fpu8mMYBbA+BTOEwfGn8FLTpFbkHMaml
        Ea0TgiSWzEyzadzlQX8xajI=
X-Google-Smtp-Source: APXvYqzxURePBgEEl4xflBI3no+G3GDCoImlDugCHhH2Oydl5/KfT4D2v859t+LRm7mLilxqrqVW0Q==
X-Received: by 2002:a63:211c:: with SMTP id h28mr24226183pgh.438.1562159824265;
        Wed, 03 Jul 2019 06:17:04 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 22sm2434929pfu.179.2019.07.03.06.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:17:03 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Hannes Reinecke <hare@suse.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        QLogic-Storage-Upstream@qlogic.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 20/30] scsi: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:16:55 +0800
Message-Id: <20190703131655.25594-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/scsi/aic7xxx/aic79xx_core.c | 3 +--
 drivers/scsi/aic7xxx/aic7xxx_core.c | 3 +--
 drivers/scsi/myrb.c                 | 4 +---
 drivers/scsi/qla4xxx/ql4_os.c       | 7 ++-----
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 7e5044bf05c0..f4bc88c50dcd 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -9442,10 +9442,9 @@ ahd_loadseq(struct ahd_softc *ahd)
 	if (cs_count != 0) {
 
 		cs_count *= sizeof(struct cs);
-		ahd->critical_sections = kmalloc(cs_count, GFP_ATOMIC);
+		ahd->critical_sections = kmemdup(cs_table, cs_count, GFP_ATOMIC);
 		if (ahd->critical_sections == NULL)
 			panic("ahd_loadseq: Could not malloc");
-		memcpy(ahd->critical_sections, cs_table, cs_count);
 	}
 	ahd_outb(ahd, SEQCTL0, PERRORDIS|FAILDIS|FASTMODE);
 
diff --git a/drivers/scsi/aic7xxx/aic7xxx_core.c b/drivers/scsi/aic7xxx/aic7xxx_core.c
index a9d40d3b90ef..7ea4e45309ff 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_core.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_core.c
@@ -6907,10 +6907,9 @@ ahc_loadseq(struct ahc_softc *ahc)
 	if (cs_count != 0) {
 
 		cs_count *= sizeof(struct cs);
-		ahc->critical_sections = kmalloc(cs_count, GFP_ATOMIC);
+		ahc->critical_sections = kmemdup(cs_table, cs_count, GFP_ATOMIC);
 		if (ahc->critical_sections == NULL)
 			panic("ahc_loadseq: Could not malloc");
-		memcpy(ahc->critical_sections, cs_table, cs_count);
 	}
 	ahc_outb(ahc, SEQCTL, PERRORDIS|FAILDIS|FASTMODE);
 
diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index 539ac8ce4fcd..5e6b5e7ae93a 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1658,14 +1658,12 @@ static int myrb_ldev_slave_alloc(struct scsi_device *sdev)
 	if (!ldev_info)
 		return -ENXIO;
 
-	sdev->hostdata = kzalloc(sizeof(*ldev_info), GFP_KERNEL);
+	sdev->hostdata = kmemdup(ldev_info, sizeof(*ldev_info), GFP_KERNEL);
 	if (!sdev->hostdata)
 		return -ENOMEM;
 	dev_dbg(&sdev->sdev_gendev,
 		"slave alloc ldev %d state %x\n",
 		ldev_num, ldev_info->state);
-	memcpy(sdev->hostdata, ldev_info,
-	       sizeof(*ldev_info));
 	switch (ldev_info->raid_level) {
 	case MYRB_RAID_LEVEL0:
 		level = RAID_LEVEL_LINEAR;
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 8c674eca09f1..8f8c64e5f02d 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -3559,21 +3559,18 @@ static int qla4xxx_copy_from_fwddb_param(struct iscsi_bus_flash_session *sess,
 	conn->port = le16_to_cpu(fw_ddb_entry->port);
 
 	options = le16_to_cpu(fw_ddb_entry->options);
-	conn->ipaddress = kzalloc(IPv6_ADDR_LEN, GFP_KERNEL);
+	conn->ipaddress = kmemdup(fw_ddb_entry->ip_addr, IPv6_ADDR_LEN, GFP_KERNEL);
 	if (!conn->ipaddress) {
 		rc = -ENOMEM;
 		goto exit_copy;
 	}
 
-	conn->redirect_ipaddr = kzalloc(IPv6_ADDR_LEN, GFP_KERNEL);
+	conn->redirect_ipaddr = kmemdup(fw_ddb_entry->tgt_addr, IPv6_ADDR_LEN, GFP_KERNEL);
 	if (!conn->redirect_ipaddr) {
 		rc = -ENOMEM;
 		goto exit_copy;
 	}
 
-	memcpy(conn->ipaddress, fw_ddb_entry->ip_addr, IPv6_ADDR_LEN);
-	memcpy(conn->redirect_ipaddr, fw_ddb_entry->tgt_addr, IPv6_ADDR_LEN);
-
 	if (test_bit(OPT_IPV6_DEVICE, &options)) {
 		conn->ipv6_traffic_class = fw_ddb_entry->ipv4_tos;
 
-- 
2.11.0

