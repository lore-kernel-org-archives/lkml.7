Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32372C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01229217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnPnitFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfC1MXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:23:35 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33398 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfC1MXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:23:35 -0400
Received: by mail-qk1-f193.google.com with SMTP id k189so11980569qkc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 05:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Zfb1rKeBLtVHVUw32/S4m5WUS/BSiXJ/wEQMyqmIJBU=;
        b=jnPnitFsxjGqJZyK37N1W/MM23bZXgqCsFQ0HC6bjz314FXe4oMNXVi10c1oyvFf/Q
         8IRT/AflNOxI163Msxqi9i6Z8JC2iGm0Zol2Mm0NJH+1+Gwe5scITUnVk3vSUj4b9Qvy
         Nab67GoLOkEXEGtQv93Dk4m9VjX9Os0gW9LBDW3IynpfXApgnsAzBe0PDOC7w4HyjIYO
         FVcfaktfSY+UyAR7zDDDVnU0v+/wFA9oMNsGg7/BIEGLOer+d3V+mVg3qpWvnS+sCs4j
         mJ7/OjfhRK7lia5yY/m056UhCaCTPCfqeI+m3j9Ld1l/QQhAfVxefomgpKrAweru4Udc
         CxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zfb1rKeBLtVHVUw32/S4m5WUS/BSiXJ/wEQMyqmIJBU=;
        b=qXUJzBbQa3iS7we69DoJRz8W6zg525LMpqVzXIcAUGQE5jZAjK9CtY/+yhFsc8+fSs
         pZMdLt+W1q/EKl+bUTA5jwU685uViRlkxSU4tL2US1eV99+0ZRquNA58diqdFhG3P2MH
         q8goKu0XpFqncwMG+3DORHyJ0EWBBH3pYIfzErkS5/E0QNGsbBU5wnESsRrvImBucXn9
         OVFlCO2ZxrJeVodJDAcprLHDoTJVGKp4Dc7POruE9HgJlW6eZVxMGz7jlmxfcOcwuNsd
         1r9iPf26JdlunlW3aLBp/gR+6IRtjW7v/05aN3dpLC+qqsATXtz3bKLe3/3/1rFL3ehW
         +7uQ==
X-Gm-Message-State: APjAAAXc/mPmqnfcL10+XKjqsHTs0j39J0PlMcHrq+fIdd6c2IEdzNv4
        hQiYdIBoqgM2bTLSamCoIz2jploJWd8=
X-Google-Smtp-Source: APXvYqw0xAuq5pjK53NOZmfk0VkTufUErdqgrSygGob/95ifcXuNzNcH+Z7gacAA3aL1JOlABBFudg==
X-Received: by 2002:ae9:e894:: with SMTP id a142mr26224562qkg.14.1553775813891;
        Thu, 28 Mar 2019 05:23:33 -0700 (PDT)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id e15sm12092362qkl.80.2019.03.28.05.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 05:23:33 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     linux-kernel@vger.kernel.org, greg@kroah.com
Cc:     zbr@ioremap.net, manio@skyboo.net,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH v3] w1: ds2408: reset on output_write retry with readback
Date:   Thu, 28 Mar 2019 08:22:44 -0400
Message-Id: <20190328122244.32126-1-jeff.dagenais@gmail.com>
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

