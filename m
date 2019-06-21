Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CE0C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB722083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="bh3KhdOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfFUNHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:07:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39931 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFUNHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:07:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so5895020ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 06:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVCd7IM94kgrsu/Yv7f6wO5b46wgz2NUp+wKu6X3WWs=;
        b=bh3KhdObg8D6t3pFPfo82I+WgXWKJv4G/TsizdGYb0daA49HCACx94aagx/rw6jaqw
         /ZzfGfVqRjlnDv1HZhNcCNyzKArU3/hZFwQ7MPiUzuBWLfF6Ux728pFvpTmkq3lMDBX0
         HBKgvsvZyrLyLgpgWGTt/LhFGvwi1bgHEfF9WxT5x99CvhDkO14Cemg706vbghHEog2i
         8H/QSVs3K7J9inUJMijKmrYt4Mjvi93SgUgwlwll1NDy1EaYQ/TlnaNsgHZ0xzR25O+e
         i7C9XEPsIw0HJvQwp9Djf7w/xTjNHEy2wOCWz/4tBq7YkpngS5zdV39v0j1B5uGNW77r
         JUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVCd7IM94kgrsu/Yv7f6wO5b46wgz2NUp+wKu6X3WWs=;
        b=Lg+u7JI6azWUHYgeHmkdzbMeBHizmxt/hPVYrpTOz3K2AR1f7jZbR3k3teKsDVEcfV
         S4aCOVNxlz8y21pb+TWMIynheT7i4zx2HRu6dI9Ouxs2W2w3PHFhY0Vy/4ZJvN+OfNhX
         /ie9cgIkQ4MW8zWyz4Bi0Rgpv4XKPBjWMWp3xcGLuPO99i4GK3NgFmIysrOT7tlZTVI6
         RtK9GL5IfrUZZmqW12Lj7PGZ5CqIJlsLurf+nxG3HE2UTr9zzzCFGr/dhVwoUFbaw7oe
         u32+HCDdR8koJ70jP21/vMccxJfI2vDSPoYl2VBJoAYlxS5QvQYWYx1dWAQa7y4XHs5D
         cPlw==
X-Gm-Message-State: APjAAAWHfKCHeiJhswwmjWwUcuplavllNLi3y6n16ZkkF7tLf7BZHE9t
        W5jVq72zcUHspXmGqIpzCTdiuQ==
X-Google-Smtp-Source: APXvYqwPhCxAWSqz1UWNxNr2CLd1C+Iim3YPxHMo0WKMl0NrncG/ekCweu9ZZy7aeqkjvNbWfd1WUQ==
X-Received: by 2002:a2e:5548:: with SMTP id j69mr26896248ljb.48.1561122452415;
        Fri, 21 Jun 2019 06:07:32 -0700 (PDT)
Received: from skyninja.webspeed.dk (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.gmail.com with ESMTPSA id r2sm387100lfi.51.2019.06.21.06.07.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 06:07:31 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com, hch@lst.de, damien.lemoal@wdc.com,
        chaitanya.kulkarni@wdc.com, dmitry.fomichev@wdc.com,
        ajay.joshi@wdc.com, aravind.ramesh@wdc.com,
        martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        agk@redhat.com, snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 3/4] scsi: sd_zbc: add zone open, close, and finish support
Date:   Fri, 21 Jun 2019 15:07:10 +0200
Message-Id: <20190621130711.21986-4-mb@lightnvm.io>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190621130711.21986-1-mb@lightnvm.io>
References: <20190621130711.21986-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajay Joshi <ajay.joshi@wdc.com>

Implement REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH
support to allow explicit control of zone states.

Signed-off-by: Ajay Joshi <ajay.joshi@wdc.com>
---
 drivers/scsi/sd.c     | 15 ++++++++++++++-
 drivers/scsi/sd.h     |  6 ++++--
 drivers/scsi/sd_zbc.c | 18 +++++++++++++-----
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a3406bd62391..89f955a01d44 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1292,7 +1292,17 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
 	case REQ_OP_WRITE:
 		return sd_setup_read_write_cmnd(cmd);
 	case REQ_OP_ZONE_RESET:
-		return sd_zbc_setup_reset_cmnd(cmd);
+		return sd_zbc_setup_zone_mgmt_op_cmnd(cmd,
+					ZO_RESET_WRITE_POINTER);
+	case REQ_OP_ZONE_OPEN:
+		return sd_zbc_setup_zone_mgmt_op_cmnd(cmd,
+					ZO_OPEN_ZONE);
+	case REQ_OP_ZONE_CLOSE:
+		return sd_zbc_setup_zone_mgmt_op_cmnd(cmd,
+					ZO_CLOSE_ZONE);
+	case REQ_OP_ZONE_FINISH:
+		return sd_zbc_setup_zone_mgmt_op_cmnd(cmd,
+					ZO_FINISH_ZONE);
 	default:
 		WARN_ON_ONCE(1);
 		return BLK_STS_NOTSUPP;
@@ -1958,6 +1968,9 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 	case REQ_OP_WRITE_ZEROES:
 	case REQ_OP_WRITE_SAME:
 	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_OPEN:
+	case REQ_OP_ZONE_CLOSE:
+	case REQ_OP_ZONE_FINISH:
 		if (!result) {
 			good_bytes = blk_rq_bytes(req);
 			scsi_set_resid(SCpnt, 0);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 5796ace76225..9a20633caefa 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -209,7 +209,8 @@ static inline int sd_is_zoned(struct scsi_disk *sdkp)
 
 extern int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buffer);
 extern void sd_zbc_print_zones(struct scsi_disk *sdkp);
-extern blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd);
+extern blk_status_t sd_zbc_setup_zone_mgmt_op_cmnd(struct scsi_cmnd *cmd,
+						   unsigned char op);
 extern void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
 			    struct scsi_sense_hdr *sshdr);
 extern int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,
@@ -226,7 +227,8 @@ static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,
 
 static inline void sd_zbc_print_zones(struct scsi_disk *sdkp) {}
 
-static inline blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
+static inline blk_status_t sd_zbc_setup_zone_mgmt_op_cmnd(struct scsi_cmnd *cmd,
+							  unsigned char op)
 {
 	return BLK_STS_TARGET;
 }
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 7334024b64f1..41020db5353a 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -168,12 +168,17 @@ static inline sector_t sd_zbc_zone_sectors(struct scsi_disk *sdkp)
 }
 
 /**
- * sd_zbc_setup_reset_cmnd - Prepare a RESET WRITE POINTER scsi command.
- * @cmd: the command to setup
+ * sd_zbc_setup_zone_mgmt_op_cmnd - Prepare a zone ZBC_OUT command. The
+ *                                  operations can be RESET WRITE POINTER,
+ *                                  OPEN, CLOSE or FINISH.
+ * @cmd: The command to setup
+ * @op: Operation to be performed
  *
- * Called from sd_init_command() for a REQ_OP_ZONE_RESET request.
+ * Called from sd_init_command() for REQ_OP_ZONE_RESET, REQ_OP_ZONE_OPEN,
+ * REQ_OP_ZONE_CLOSE or REQ_OP_ZONE_FINISH requests.
  */
-blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
+blk_status_t sd_zbc_setup_zone_mgmt_op_cmnd(struct scsi_cmnd *cmd,
+					    unsigned char op)
 {
 	struct request *rq = cmd->request;
 	struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
@@ -194,7 +199,7 @@ blk_status_t sd_zbc_setup_reset_cmnd(struct scsi_cmnd *cmd)
 	cmd->cmd_len = 16;
 	memset(cmd->cmnd, 0, cmd->cmd_len);
 	cmd->cmnd[0] = ZBC_OUT;
-	cmd->cmnd[1] = ZO_RESET_WRITE_POINTER;
+	cmd->cmnd[1] = op;
 	put_unaligned_be64(block, &cmd->cmnd[2]);
 
 	rq->timeout = SD_TIMEOUT;
@@ -222,6 +227,9 @@ void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,
 
 	switch (req_op(rq)) {
 	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_OPEN:
+	case REQ_OP_ZONE_CLOSE:
+	case REQ_OP_ZONE_FINISH:
 
 		if (result &&
 		    sshdr->sense_key == ILLEGAL_REQUEST &&
-- 
2.19.1

