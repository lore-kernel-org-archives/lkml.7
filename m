Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27422C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EC52133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A58bLwx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfCSOVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:21:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39621 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfCSOVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:21:35 -0400
Received: by mail-qt1-f196.google.com with SMTP id t28so22292564qte.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gnr9sn2PbmUnDDxyv0YS0Zaj+dimt19m4HxDy9V5ZSw=;
        b=A58bLwx8HXhP6CLli+cSbfoaBD/E07xnYLzPI88Rq1/vfcRxuoobJNvJVQ903dMhaC
         31mvAvcSNKA/3Ne35omQebVZhii0DDMt8dX+riHEpWC0rxH9tWrmI8KnE3TKVXW4FbHv
         UIhYOiA7CHRuUxDDPfauVCXutiqRojGpOyXH8BemAMj7tsWt7OYQV+MUod1+YqtgVLz6
         94okkvhE5ZmU6x+yFu2WoyQpLPIjXHkQgun9h3IYH4aI5sAJ2GD+KI3YbZzG5rDxtDNb
         qaeTTLR5S9VICrLPrn5fybqcfW38DIQ18riz63SPw0Z/4E7kNidl/40SuTwzjPHVBmJL
         f5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Gnr9sn2PbmUnDDxyv0YS0Zaj+dimt19m4HxDy9V5ZSw=;
        b=ActM7yyodmOYf6Lp+K6ewEvIfg2yrbNQCkH/d5bSj9HCiLP9FL2gobjRMJCmKKBxko
         4GLaep3isDGv3l93HwERZGIj6XvTF1YReyT3Ye51oZklDsAEYWk1DZAkRCKm4rkpyyS0
         geNcbsDJtNcGYjtPeG3WcxHzJySOW7eGMaPsxB/mQ5hAfXVDEYeb4BY3Z/T8n27WFrQ3
         uhcJ43L2phV6uWOaVHW0zmX4LIZlpa9UPNz/5C02VYhFwo0EhJWxVuYTqit4uqRt2nQQ
         Px7q3tgffODk5yPHXtUsRibtBzK6SI1wmfSxqXPHDneOxhW+atlpdp+UGJAXV1VU9DUg
         I2Fw==
X-Gm-Message-State: APjAAAU1TNZE+/1UjUONnw7TCZKXUR2iaLS8x564j2+OXbWz6YZUKehm
        ENc+Uy2RmcojmsguiTMkNWmWxJd7
X-Google-Smtp-Source: APXvYqxKt6yCAixYRuGF+I1HEtlFebwZ1BtYR4lfpCz2yS/k1dCHEMgCoC0CzuDoK5p4M+4QYoyV4g==
X-Received: by 2002:ac8:3585:: with SMTP id k5mr2182473qtb.55.1553005294155;
        Tue, 19 Mar 2019 07:21:34 -0700 (PDT)
Received: from jfdmac.sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id 92sm7036854qtc.97.2019.03.19.07.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 07:21:33 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/2] w1: ds2408: add a missing reset when retrying in
 output_write()
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
In-Reply-To: <20190318092737.8170-2-manio@skyboo.net>
Date:   Tue, 19 Mar 2019 10:21:32 -0400
Cc:     linux-kernel@vger.kernel.org, Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <greg@kroah.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF2ABF87-116D-4287-8A18-89C2C59124AF@gmail.com>
References: <20190318092737.8170-1-manio@skyboo.net>
 <20190318092737.8170-2-manio@skyboo.net>
To:     Mariusz Bialonczyk <manio@skyboo.net>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 18, 2019, at 05:27, Mariusz Bialonczyk <manio@skyboo.net> =
wrote:
>=20
> When we have success in 'Channel Access Write' but reading back the =
latch
> state has failed, then the code continues but without doing a proper
> slave reset. This was leading to protocol errors as the slave treats
> the next 'Channel Access Write' as the continuation of previous =
command.
>=20
> This commit is fixing this, and because we have to reset no matter if
> the actual write or the readback checking is failing then the =
resetting
> is done on the beginning of the loop.
>=20
> Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
> Cc: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
> ---
> drivers/w1/slaves/w1_ds2408.c | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/w1/slaves/w1_ds2408.c =
b/drivers/w1/slaves/w1_ds2408.c
> index b535d5ec35b6..562ee2d861e8 100644
> --- a/drivers/w1/slaves/w1_ds2408.c
> +++ b/drivers/w1/slaves/w1_ds2408.c
> @@ -158,6 +158,13 @@ static ssize_t output_write(struct file *filp, =
struct kobject *kobj,
> 		goto error;
>=20
> 	while (retries--) {
> +		/* do a reset/resume on every new retry call
> +		   except the first one */
> +		if (retries < W1_F29_RETRIES - 1) {
> +			if (w1_reset_resume_command(sl->master))
> +				goto error;
> +		}
> +

The case being solved here is strictly restricted to the
CONFIG_W1_SLAVE_DS2408_READBACK case and should be confined to this =
macro being
defined. I think my original code here is to blame. Although I =
appreciate what
you are trying to fix and that this does it, I don't really appreciate =
the
resulting style as it puts the improbable case of the retry in the =
forefront of
the loop using a non-obvious condition.

This adds burden to the reader. Since this is an error handling case, it =
should
like like so and be handled lower in the loop. May I suggest a cleaned =
up
version my original klunky code with your fix in it (Note: this is =
untested, it
compiles on arm64, that's all):

 drivers/w1/slaves/w1_ds2408.c | 78 =
++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2408.c =
b/drivers/w1/slaves/w1_ds2408.c
index b535d5ec35b6..bf308660f6ae 100644
--- a/drivers/w1/slaves/w1_ds2408.c
+++ b/drivers/w1/slaves/w1_ds2408.c
@@ -138,6 +138,34 @@ static ssize_t status_control_read(struct file =
*filp, struct kobject *kobj,
 		W1_F29_REG_CONTROL_AND_STATUS, buf);
 }
=20
+#ifdef CONFIG_W1_SLAVE_DS2408_READBACK
+static bool optional_read_back_valid(struct w1_slave *sl, u8 expected)
+{
+	u8 w1_buf[3];
+	/* here the master could read another byte which
+	   would be the PIO reg (the actual pin logic state)
+	   since in this driver we don't know which pins are
+	   in and outs, there's no value to read the state and
+	   compare. with (*buf) so end this command abruptly: */
+	if (w1_reset_resume_command(sl->master))
+		return false;
+	/* go read back the output latches */
+	/* (the direct effect of the write access) */
+	w1_buf[0] =3D W1_F29_FUNC_READ_PIO_REGS;
+	w1_buf[1] =3D W1_F29_REG_OUTPUT_LATCH_STATE;
+	w1_buf[2] =3D 0;
+	w1_write_block(sl->master, w1_buf, 3);
+
+	/* read the result of the READ_PIO_REGS command */
+	return w1_read_8(sl->master) =3D=3D expected;
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
@@ -146,6 +174,7 @@ static ssize_t output_write(struct file *filp, =
struct kobject *kobj,
 	u8 w1_buf[3];
 	u8 readBack;
 	unsigned int retries =3D W1_F29_RETRIES;
+	ssize_t bytes_written =3D -EIO;
=20
 	if (count !=3D 1 || off !=3D 0)
 		return -EFAULT;
@@ -155,9 +184,9 @@ static ssize_t output_write(struct file *filp, =
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
@@ -165,44 +194,23 @@ static ssize_t output_write(struct file *filp, =
struct kobject *kobj,
=20
 		readBack =3D w1_read_8(sl->master);
=20
-		if (readBack !=3D W1_F29_SUCCESS_CONFIRM_BYTE) {
-			if (w1_reset_resume_command(sl->master))
-				goto error;
-			/* try again, the slave is ready for a command =
*/
-			continue;
+		if (readBack =3D=3D W1_F29_SUCCESS_CONFIRM_BYTE &&
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
-
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
+			goto out; /* unrecoverable error */
+		/* try again, the slave is ready for a command */
+	} while (--retries);
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

I can do a proper patch submission if you guys provide positive response =
on this
early RFC. Or better yet, you can take it and own it yourself as your v2
Mariusz. ;)



> 		w1_buf[0] =3D W1_F29_FUNC_CHANN_ACCESS_WRITE;
> 		w1_buf[1] =3D *buf;
> 		w1_buf[2] =3D ~(*buf);
> @@ -165,12 +172,8 @@ static ssize_t output_write(struct file *filp, =
struct kobject *kobj,
>=20
> 		readBack =3D w1_read_8(sl->master);
>=20
> -		if (readBack !=3D W1_F29_SUCCESS_CONFIRM_BYTE) {
> -			if (w1_reset_resume_command(sl->master))
> -				goto error;
> -			/* try again, the slave is ready for a command =
*/
> +		if (readBack !=3D W1_F29_SUCCESS_CONFIRM_BYTE)
> 			continue;
> -		}
>=20
> #ifdef CONFIG_W1_SLAVE_DS2408_READBACK
> 		/* here the master could read another byte which
> --=20
> 2.19.0.rc1
>=20

