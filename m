Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C4EC31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB6120883
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6aLRINz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408381AbfFLCI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 22:08:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40059 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406597AbfFLCIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 22:08:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id c70so9003372qkg.7;
        Tue, 11 Jun 2019 19:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1Es5Api2DcjMjvwsXPpKHwLUKPhoxaSmvaXu8HsUCg=;
        b=Z6aLRINzBF+QeVOxTh02DZf8c9SQ7413TJl1G8EQclmzHHQD6TCTPPGl7eZGBlkG7y
         t4EBRpwd5kgJPHi87XvnxYETfntTWo8sAblq16brAAu5XtNxs1Gy1sFkWEAWPeqtlMFW
         PW+cwMA6FjmdtasKdEfogU7PgTxsZ9d+6f8b+/74rMQt390boDlbmjXhVjOMiRKJyroM
         3DnnToLVqaeJJ5VWlvXwykv161ju3z5HLvTGVZXvvuQ8L1NHKbuy+qxuQCfDVOCQBnyU
         ENu2Gdaoc4O/e9T8oot5FiwBVFBguvZP1V9DdSk5VPLZNuhadF3j9rv03mUty0/kmYq5
         DeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J1Es5Api2DcjMjvwsXPpKHwLUKPhoxaSmvaXu8HsUCg=;
        b=jUtcf14Qz1O06Ag1gNACX+tEk6CggJJ5dyLZfnKfaq1uzxEIgNpJzLDrvx2pYZLxQm
         LoEQR7DBdogCjXSb9KckUnvHGhIYNQtXgbhxXKrn3EwAgP1YtalMZzov91BoVZtalvIN
         EzeZJ6cGsDmD4EAcAjjl9lZvvqo8mm73/8YrVc/QiFUrVyY6pdFQfpp2ft99Wuo1SN9s
         hkhivGTSvOOUxNrMogV9hIAHXtd+MsNRSGsawM4wC80g5wpdftjW35FVp8HiBpJhZUVs
         5h7UGSbSlrUIYRKIuEuxsanczBAOCfdsKlszBPCRArhb8zZYkgultuAORMFZp0iJW9XZ
         OQzg==
X-Gm-Message-State: APjAAAUzWtfXXwcgo9i/jJN8RPwHjB/SM1m9u/9Wco+Dqk+l/DYQpBMr
        z93DtrYA8BiLXgMOmWf4y3jAK0ia
X-Google-Smtp-Source: APXvYqz8lsuKQKseN3hGn/Iwm5FNUEFDU4zHL/zuBoQgHfO/e64RsEFDEMoH31yd+Q1p+l3zjHShwA==
X-Received: by 2002:ae9:c108:: with SMTP id z8mr2277618qki.57.1560305304304;
        Tue, 11 Jun 2019 19:08:24 -0700 (PDT)
Received: from localhost.localdomain ([191.35.236.118])
        by smtp.gmail.com with ESMTPSA id k40sm9870379qta.50.2019.06.11.19.08.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 19:08:23 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM)
Subject: [PATCH] scsi: scsi_sysfs.c: Hide wwid sdev attr if VPD is not supported
Date:   Tue, 11 Jun 2019 23:08:28 -0300
Message-Id: <20190612020828.8140-1-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWID composed from VPD data from device, specifically page 0x83. So,
when a device does not have VPD support, for example USB storage devices
where VPD is specifically disabled, a read into <blk device>/device/wwid
file will always return ENXIO. To avoid this, change the
scsi_sdev_attr_is_visible function to hide wwid sysfs file when the
devices does not support VPD.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/scsi/scsi_sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index dbb206c90ecf..bfd890fa0c69 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1159,6 +1159,9 @@ static umode_t scsi_sdev_attr_is_visible(struct kobject *kobj,
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct scsi_device *sdev = to_scsi_device(dev);
 
+	/* do not present wwid if the device does not support VPD */
+	if (attr == &dev_attr_wwid.attr && sdev->skip_vpd_pages)
+		return 0;
 
 	if (attr == &dev_attr_queue_depth.attr &&
 	    !sdev->host->hostt->change_queue_depth)
-- 
2.21.0

