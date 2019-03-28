Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBEB2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLolzccJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfC1Qlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:41:37 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35457 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfC1Qlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:41:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id h39so23890728qte.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JSQMF8f8p1skfrB3NWGa3+izoK9d8/RcuBuyqyMFEu8=;
        b=FLolzccJMs96B3cKlwW53qxrF1qGa5TEqobRjFt9lCV1P450yQzGoLx/qXwthckaOH
         PHZqEDECMx0AMMZP0et87BplmwX/mD7ozuuQludWc1ryxLPR/cm6k9lsfzyPcuOe84IT
         gde/8A0WrmPA1Zcs4jC3g+3tzBcw+uOYYjNZOLm0yJdHalY2YKUG3vQTVTXFTno1hzDc
         mJh7/NrSAu5g3DgKsH+4F+llx/VNjzorJ5IEk+1OAPUQ2udFirF2ryLXb0R61NpXLzSw
         5+uQogIPF5SLQXRZFubl0lrGxarhgxoYnpayn7rF1LPmC9xkiHAEyWbNDs8Nojz1N5z6
         sp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JSQMF8f8p1skfrB3NWGa3+izoK9d8/RcuBuyqyMFEu8=;
        b=CL56dPQBjgCN5lXXxY0zLthtJ+Q1djj+Q7i2LbX8u8FvyY/OFSaIlOZDb1/7GsxG7y
         u9bcA1HbqUm2mLvEfMZ0VSmpsAWOOJ9jYwo8bZGJVefvCSh/FprMIjU/k3Xg3B3ZXtU1
         K7bOE6y1Hp65eru3NqO7IJ3HkCY6cKOIBIRdr9+Rpa6esT7cCUe7iQYoaRxdGHEV9tml
         k82wwBAEYiyeihEXMS75syB5qkHETVpU6CMasDKMFAMdn65gT7+/HQEPZcRasEQ4ZOpa
         nphOW1mVB8cTIyK6Ub6SraaxSE7iLvXjwWUmvH+72nA3AoK+Z2vwgGIwvWk8wP07b9fB
         Pwzw==
X-Gm-Message-State: APjAAAUV6F2lNsQIkyaxGKT0CIq1vMlmgDzorBlP8X54GMSpo6pV/6Gr
        DMlXO+aS13W8hwt2K9b+GXjssGbJDeM=
X-Google-Smtp-Source: APXvYqwrlLBl3ndxf0ItcCrJnQKoMCAs/Jh/GkgQAhQYvvgJn9KrRpk9njTZu+/dYNfgswHUy0f1og==
X-Received: by 2002:ac8:2207:: with SMTP id o7mr36719635qto.376.1553791294918;
        Thu, 28 Mar 2019 09:41:34 -0700 (PDT)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id u57sm17733055qta.12.2019.03.28.09.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:41:33 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     linux-kernel@vger.kernel.org, greg@kroah.com
Cc:     zbr@ioremap.net, manio@skyboo.net,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH v4] w1: ds2408: reset on output_write retry with readback
Date:   Thu, 28 Mar 2019 12:41:11 -0400
Message-Id: <20190328164111.24041-1-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we have success in 'Channel Access Write' but reading back latch
states fails, a write is retried without doing a proper slave reset.
This leads to protocol errors as the slave treats the next 'Channel
Access Write' as the continuation of previous command.

This commit is fixing this by making sure if the retry loop re-runs, a
reset is performed, whatever the failure (CONFIRM_BYTE or the read
back).

The loop was quite due for a cleanup and this change mandated it. By
isolating the CONFIG_W1_SLAVE_DS2408_READBACK case into it's own
function, we vastly reduce the visual and branching(runtime and
compile-time) noise.

Reported-by: Mariusz Bialonczyk <manio@skyboo.net>
Tested-by: Mariusz Bialonczyk <manio@skyboo.net>
Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
Changes in v1:
	- Original Mariusz series submission called 
	  [PATCH 1/2] w1: ds2408: add a missing reset when retrying in
	  output_write()
Changes in v2:
	- Re-implement Mariusz' first submission to refactor the affected
	  code which had become too weird.
	- Re-phrase the commit message.
	- Patch submitted as stand-alone, but was sent as reply to above
	  series.
Changes in v3:
	- Moved Reported-by line with the other *-by lines.
Changes in v4:
	- Added this "changes" section.

 drivers/w1/slaves/w1_ds2408.c | 76 ++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2408.c b/drivers/w1/slaves/w1_ds2408.c
index b535d5ec35b6..92e8f0755b9a 100644
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -138,14 +138,37 @@ static ssize_t status_control_read(struct file *filp, struct kobject *kobj,
 		W1_F29_REG_CONTROL_AND_STATUS, buf);
 }
 
+#ifdef fCONFIG_W1_SLAVE_DS2408_READBACK
+static bool optional_read_back_valid(struct w1_slave *sl, u8 expected)
+{
+	u8 w1_buf[3];
+
+	if (w1_reset_resume_command(sl->master))
+		return false;
+
+	w1_buf[0] = W1_F29_FUNC_READ_PIO_REGS;
+	w1_buf[1] = W1_F29_REG_OUTPUT_LATCH_STATE;
+	w1_buf[2] = 0;
+
+	w1_write_block(sl->master, w1_buf, 3);
+
+	return (w1_read_8(sl->master) == expected);
+}
+#else
+static bool optional_read_back_valid(struct w1_slave *sl, u8 expected)
+{
+	return true;
+}
+#endif
+
 static ssize_t output_write(struct file *filp, struct kobject *kobj,
 			    struct bin_attribute *bin_attr, char *buf,
 			    loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	u8 w1_buf[3];
-	u8 readBack;
 	unsigned int retries = W1_F29_RETRIES;
+	ssize_t bytes_written = -EIO;
 
 	if (count != 1 || off != 0)
 		return -EFAULT;
@@ -155,54 +178,33 @@ static ssize_t output_write(struct file *filp, struct kobject *kobj,
 	dev_dbg(&sl->dev, "mutex locked");
 
 	if (w1_reset_select_slave(sl))
-		goto error;
+		goto out;
 
-	while (retries--) {
+	do {
 		w1_buf[0] = W1_F29_FUNC_CHANN_ACCESS_WRITE;
 		w1_buf[1] = *buf;
 		w1_buf[2] = ~(*buf);
-		w1_write_block(sl->master, w1_buf, 3);
 
-		readBack = w1_read_8(sl->master);
+		w1_write_block(sl->master, w1_buf, 3);
 
-		if (readBack != W1_F29_SUCCESS_CONFIRM_BYTE) {
-			if (w1_reset_resume_command(sl->master))
-				goto error;
-			/* try again, the slave is ready for a command */
-			continue;
+		if (w1_read_8(sl->master) == W1_F29_SUCCESS_CONFIRM_BYTE &&
+		    optional_read_back_valid(sl, *buf)) {
+			bytes_written = 1;
+			goto out;
 		}
 
-#ifdef CONFIG_W1_SLAVE_DS2408_READBACK
-		/* here the master could read another byte which
-		   would be the PIO reg (the actual pin logic state)
-		   since in this driver we don't know which pins are
-		   in and outs, there's no value to read the state and
-		   compare. with (*buf) so end this command abruptly: */
 		if (w1_reset_resume_command(sl->master))
-			goto error;
+			goto out; /* unrecoverable error */
+		/* try again, the slave is ready for a command */
+	} while (--retries);
 
-		/* go read back the output latches */
-		/* (the direct effect of the write above) */
-		w1_buf[0] = W1_F29_FUNC_READ_PIO_REGS;
-		w1_buf[1] = W1_F29_REG_OUTPUT_LATCH_STATE;
-		w1_buf[2] = 0;
-		w1_write_block(sl->master, w1_buf, 3);
-		/* read the result of the READ_PIO_REGS command */
-		if (w1_read_8(sl->master) == *buf)
-#endif
-		{
-			/* success! */
-			mutex_unlock(&sl->master->bus_mutex);
-			dev_dbg(&sl->dev,
-				"mutex unlocked, retries:%d", retries);
-			return 1;
-		}
-	}
-error:
+out:
 	mutex_unlock(&sl->master->bus_mutex);
-	dev_dbg(&sl->dev, "mutex unlocked in error, retries:%d", retries);
 
-	return -EIO;
+	dev_dbg(&sl->dev, "%s, mutex unlocked retries:%d\n",
+		(bytes_written > 0) ? "succeeded" : "error", retries);
+
+	return bytes_written;
 }
 
 
-- 
2.11.0

