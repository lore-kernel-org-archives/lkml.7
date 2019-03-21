Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05462C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E8A21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR4mJhvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfCUPSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:18:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41854 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbfCUPSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:18:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id w30so6995964qta.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=28yzvLx8CWbN2oAbjieDKxIuRJUsi8Fc56fdxzsiWzs=;
        b=bR4mJhvSf3Bij2y6EO1cfxCfUeD/fXIPWrFrsBDqsIf7vtcDH7rVz8GAoZ2seuvzpn
         Kv+4/QXIgWuuFZJztTRd84fOuiPIZ2r2zI+A0T77yH+HiESBPsHxyDxE7BNEXGGHa9W0
         T7dJ9o6aMcNeg+0btQji2xZXAhAKQYcgY9uuJNm5J4fuf1LSEvh9CT/ohKLTUSI56DUE
         N1qM2Z3+9IiCKYLCirxHHmA0My1xBLlepbSWFEBIwJjXP/twKmXuUvuDoF3XD/Q+16QO
         AfjrCUvapKRrUl/z1MbeGHbv79YJh9EAaMMwzqZtApP+XiMePhrPx7zuasgSPUijPEzK
         RYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=28yzvLx8CWbN2oAbjieDKxIuRJUsi8Fc56fdxzsiWzs=;
        b=UQDWEl15Vow6s8yV+TcifCZsrYcCJOxKFZzPltMNDkCsS+X2P2DZZyHAbJNbTHBUar
         PAqct+p9pzV+YHH2OaSuVFgIuTZTun9U42HS/LWfOoJ8hjbzUZ5K1GjMiFnMJT/waFAP
         LY95UHeOSX6hubsCi9nOxcSbYujEg1N4gdLLJhFDgA9eNK36+bAQVG0khVUezqRUnEYT
         x/SQEbBmNVuFd+lTmK+L1IlKZSPnfUMuqacnG2gCAkIIO72F93aYUh8ZsV9CoDrMQLwY
         jpYGVvZOHMwQmWmhNE4W+l4g50SoO4bhKsf0j8acqxUYXiQEIy7NkyB2cMmeDCxp4vJU
         oYjA==
X-Gm-Message-State: APjAAAUPzNowuWCME02OVqMO8cDRDctLEwyZdWdGnGqLEXlyoZRFBi/f
        /apizOKEWvzSNIbBTAsU7rGY2mu7
X-Google-Smtp-Source: APXvYqxaIjDiiF+KaTWWVzHYGbENnUP+6LV8mrli1q23Mio+EsOqnKTJ2Z/b34+xoiZcTuz33F4AIA==
X-Received: by 2002:ac8:2539:: with SMTP id 54mr3397294qtm.387.1553181511338;
        Thu, 21 Mar 2019 08:18:31 -0700 (PDT)
Received: from [192.168.0.153] (modemcable235.181-200-24.mc.videotron.ca. [24.200.181.235])
        by smtp.gmail.com with ESMTPSA id t55sm3423826qtt.57.2019.03.21.08.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 08:18:30 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v2] w1: ds2408: reset on output_write retry with readback
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
In-Reply-To: <20190318092737.8170-2-manio@skyboo.net>
Date:   Thu, 21 Mar 2019 11:18:27 -0400
Cc:     Greg Kroah-Hartman <greg@kroah.com>,
        Mariusz Bialonczyk <manio@skyboo.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <10244730-36A8-4DAC-95E5-AD7BDEA32F43@gmail.com>
References: <20190318092737.8170-1-manio@skyboo.net>
 <20190318092737.8170-2-manio@skyboo.net>
To:     open list <linux-kernel@vger.kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally
Reported-by: Mariusz Bialonczyk <manio@skyboo.net>

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

Tested-by: Mariusz Bialonczyk <manio@skyboo.net>
Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/w1/slaves/w1_ds2408.c | 76 =
++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2408.c =
b/drivers/w1/slaves/w1_ds2408.c
index b535d5ec35b6..92e8f0755b9a 100644
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -138,14 +138,37 @@ static ssize_t status_control_read(struct file =
*filp, struct kobject *kobj,
 		W1_F29_REG_CONTROL_AND_STATUS, buf);
 }
=20
+#ifdef fCONFIG_W1_SLAVE_DS2408_READBACK
+static bool optional_read_back_valid(struct w1_slave *sl, u8 expected)
+{
+	u8 w1_buf[3];
+
+	if (w1_reset_resume_command(sl->master))
+		return false;
+
+	w1_buf[0] =3D W1_F29_FUNC_READ_PIO_REGS;
+	w1_buf[1] =3D W1_F29_REG_OUTPUT_LATCH_STATE;
+	w1_buf[2] =3D 0;
+
+	w1_write_block(sl->master, w1_buf, 3);
+
+	return (w1_read_8(sl->master) =3D=3D expected);
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
 	struct w1_slave *sl =3D kobj_to_w1_slave(kobj);
 	u8 w1_buf[3];
-	u8 readBack;
 	unsigned int retries =3D W1_F29_RETRIES;
+	ssize_t bytes_written =3D -EIO;
=20
 	if (count !=3D 1 || off !=3D 0)
 		return -EFAULT;
@@ -155,54 +178,33 @@ static ssize_t output_write(struct file *filp, =
struct kobject *kobj,
 	dev_dbg(&sl->dev, "mutex locked");
=20
 	if (w1_reset_select_slave(sl))
-		goto error;
+		goto out;
=20
-	while (retries--) {
+	do {
 		w1_buf[0] =3D W1_F29_FUNC_CHANN_ACCESS_WRITE;
 		w1_buf[1] =3D *buf;
 		w1_buf[2] =3D ~(*buf);
-		w1_write_block(sl->master, w1_buf, 3);
=20
-		readBack =3D w1_read_8(sl->master);
+		w1_write_block(sl->master, w1_buf, 3);
=20
-		if (readBack !=3D W1_F29_SUCCESS_CONFIRM_BYTE) {
-			if (w1_reset_resume_command(sl->master))
-				goto error;
-			/* try again, the slave is ready for a command =
*/
-			continue;
+		if (w1_read_8(sl->master) =3D=3D =
W1_F29_SUCCESS_CONFIRM_BYTE &&
+		    optional_read_back_valid(sl, *buf)) {
+			bytes_written =3D 1;
+			goto out;
 		}
=20
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
=20
-		/* go read back the output latches */
-		/* (the direct effect of the write above) */
-		w1_buf[0] =3D W1_F29_FUNC_READ_PIO_REGS;
-		w1_buf[1] =3D W1_F29_REG_OUTPUT_LATCH_STATE;
-		w1_buf[2] =3D 0;
-		w1_write_block(sl->master, w1_buf, 3);
-		/* read the result of the READ_PIO_REGS command */
-		if (w1_read_8(sl->master) =3D=3D *buf)
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
-	dev_dbg(&sl->dev, "mutex unlocked in error, retries:%d", =
retries);
=20
-	return -EIO;
+	dev_dbg(&sl->dev, "%s, mutex unlocked retries:%d\n",
+		(bytes_written > 0) ? "succeeded" : "error", retries);
+
+	return bytes_written;
 }
=20
=20
--=20
2.11.0=
