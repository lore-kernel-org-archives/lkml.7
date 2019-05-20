Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC5EC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D516620815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 07:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfETHGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 03:06:11 -0400
Received: from skyboo.net ([94.40.87.198]:51452 "EHLO skyboo.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfETHGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 03:06:10 -0400
Received: from manio by skyboo.net with local (Exim 4.91)
        (envelope-from <manio@skyboo.net>)
        id 1hScN5-0005o5-F5; Mon, 20 May 2019 09:06:07 +0200
From:   Mariusz Bialonczyk <manio@skyboo.net>
To:     linux-kernel@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>
Cc:     Mariusz Bialonczyk <manio@skyboo.net>
Date:   Mon, 20 May 2019 09:05:55 +0200
Message-Id: <20190520070558.20142-1-manio@skyboo.net>
X-Mailer: git-send-email 2.19.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, greg@kroah.com, manio@skyboo.net
X-SA-Exim-Mail-From: manio@skyboo.net
Subject: [PATCH 1/4] w1: ds2413: output_write() cosmetic fixes / simplify
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on skyboo.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the output_write simpler.
Based on Jean-Francois Dagenais code from:
49695ac46861 ("w1: ds2408: reset on output_write retry with readback")

Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
---
 drivers/w1/slaves/w1_ds2413.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2413.c b/drivers/w1/slaves/w1_ds2413.c
index 492e3d010321..cd3763df69ac 100644
--- a/drivers/w1/slaves/w1_ds2413.c
+++ b/drivers/w1/slaves/w1_ds2413.c
@@ -69,6 +69,7 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	u8 w1_buf[3];
 	unsigned int retries = W1_F3A_RETRIES;
+	ssize_t bytes_written = -EIO;
 
 	if (count != 1 || off != 0)
 		return -EFAULT;
@@ -78,7 +79,7 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
 	dev_dbg(&sl->dev, "mutex locked");
 
 	if (w1_reset_select_slave(sl))
-		goto error;
+		goto out;
 
 	/* according to the DS2413 datasheet the most significant 6 bits
 	   should be set to "1"s, so do it now */
@@ -91,18 +92,20 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
 		w1_write_block(sl->master, w1_buf, 3);
 
 		if (w1_read_8(sl->master) == W1_F3A_SUCCESS_CONFIRM_BYTE) {
-			mutex_unlock(&sl->master->bus_mutex);
-			dev_dbg(&sl->dev, "mutex unlocked, retries:%d", retries);
-			return 1;
+			bytes_written = 1;
+			goto out;
 		}
 		if (w1_reset_resume_command(sl->master))
-			goto error;
+			goto out; /* unrecoverable error */
+
+		dev_warn(&sl->dev, "PIO_ACCESS_WRITE error, retries left: %d\n", retries);
 	}
 
-error:
+out:
 	mutex_unlock(&sl->master->bus_mutex);
-	dev_dbg(&sl->dev, "mutex unlocked in error, retries:%d", retries);
-	return -EIO;
+	dev_dbg(&sl->dev, "%s, mutex unlocked, retries: %d\n",
+		(bytes_written > 0) ? "succeeded" : "error", retries);
+	return bytes_written;
 }
 
 static BIN_ATTR(output, S_IRUGO | S_IWUSR | S_IWGRP, NULL, output_write, 1);
-- 
2.19.0.rc1

