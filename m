Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54CBC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 02:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3ACA20730
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 02:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfKPCGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 21:06:47 -0500
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:48291 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727159AbfKPCGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 21:06:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 251A41804E55A;
        Sat, 16 Nov 2019 02:06:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: comb52_b943ff6c03d
X-Filterd-Recvd-Size: 5082
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sat, 16 Nov 2019 02:06:44 +0000 (UTC)
Message-ID: <4586e574ab5b598938cb2dfa65ea63ff40a136a7.camel@perches.com>
Subject: Re: [RFC PATCH] media: bcm3510.c: Fix checkpatch.pl errors
From:   Joe Perches <joe@perches.com>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, mchehab@kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Nov 2019 18:06:25 -0800
In-Reply-To: <20191112195504.36952-1-dwlsalmeida@gmail.com>
References: <20191112195504.36952-1-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-12 at 16:55 -0300, Daniel W. S. Almeida wrote:
[]
> diff --git a/drivers/media/dvb-frontends/bcm3510.c b/drivers/media/dvb-frontends/bcm3510.c
[]
> @@ -67,31 +67,37 @@ static int debug;
>  module_param(debug, int, 0644);
>  MODULE_PARM_DESC(debug, "set debugging level (1=info,2=i2c (|-able)).");
>  
> -#define dprintk(level,x...) if (level & debug) printk(x)
> -#define dbufout(b,l,m) {\
> -	    int i; \
> -	    for (i = 0; i < l; i++) \
> -		m("%02x ",b[i]); \
> +#define dprintk(level, x...) if (level & debug) printk(KERN_DEBUG x)
> +#define dbufout(b, l, m) {\
> +	int i; \
> +	for (i = 0; i < l; i++) \
> +		m("%02x ", b[i]); \
>  }
> -#define deb_info(args...) dprintk(0x01,args)
> -#define deb_i2c(args...)  dprintk(0x02,args)
> -#define deb_hab(args...)  dprintk(0x04,args)
> +#define deb_info(args...) dprintk(0x01, args)
> +#define deb_i2c(args...)  dprintk(0x02, args)
> +#define deb_hab(args...)  dprintk(0x04, args)

These debug functions, if used, will make a mess of the
actual output and these will all print on single lines.

The dbufout macro will really make a mess of the logging.

This should really be something like:
---
 drivers/media/dvb-frontends/bcm3510.c | 51 +++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/media/dvb-frontends/bcm3510.c b/drivers/media/dvb-frontends/bcm3510.c
index e92542..7bb560a7 100644
--- a/drivers/media/dvb-frontends/bcm3510.c
+++ b/drivers/media/dvb-frontends/bcm3510.c
@@ -67,15 +67,29 @@ static int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "set debugging level (1=info,2=i2c (|-able)).");
 
-#define dprintk(level,x...) if (level & debug) printk(x)
-#define dbufout(b,l,m) {\
-	    int i; \
-	    for (i = 0; i < l; i++) \
-		m("%02x ",b[i]); \
-}
-#define deb_info(args...) dprintk(0x01,args)
-#define deb_i2c(args...)  dprintk(0x02,args)
-#define deb_hab(args...)  dprintk(0x04,args)
+#define DBG_INFO	0x01
+#define DBG_I2C		0x02
+#define DBG_HAB		0x04
+
+#define dprintk(level, fmt, ...)					\
+do {									\
+	if ((level) & debug)						\
+		printk(KERN_DEBUG fmt, ##__VA_ARGS__);			\
+} while (0)
+
+#define dbufout(level, buf, count)					\
+do {									\
+	if ((level) & debug) {						\
+		int i;							\
+		for (i = 0; i < (count); i++)				\
+			pr_cont(" %02x", buf[i]);			\
+		pr_cont("\n");						\
+	}								\
+} while (0)
+
+#define deb_info(fmt, ...) dprintk(DBG_INFO, fmt, ##__VA_ARGS__)
+#define deb_i2c(fmt, ...)  dprintk(DBG_I2C, fmt, ##__VA_ARGS__)
+#define deb_hab(fmt, ...)  dprintk(DBG_HAB, fmt, ##__VA_ARGS__)
 
 /* transfer functions */
 static int bcm3510_writebytes (struct bcm3510_state *state, u8 reg, u8 *buf, u8 len)
@@ -87,9 +101,8 @@ static int bcm3510_writebytes (struct bcm3510_state *state, u8 reg, u8 *buf, u8
 	b[0] = reg;
 	memcpy(&b[1],buf,len);
 
-	deb_i2c("i2c wr %02x: ",reg);
-	dbufout(buf,len,deb_i2c);
-	deb_i2c("\n");
+	deb_i2c("i2c wr %02x:", reg);
+	dbufout(DBG_I2C, buf, len);
 
 	if ((err = i2c_transfer (state->i2c, &msg, 1)) != 1) {
 
@@ -116,8 +129,8 @@ static int bcm3510_readbytes (struct bcm3510_state *state, u8 reg, u8 *buf, u8 l
 			__func__, state->config->demod_address, reg,  err);
 		return -EREMOTEIO;
 	}
-	deb_i2c("i2c rd %02x: ",reg);
-	dbufout(buf,len,deb_i2c);
+	deb_i2c("i2c rd %02x:", reg);
+	dbufout(DBG_I2C, buf, len);
 	deb_i2c("\n");
 
 	return 0;
@@ -221,9 +234,8 @@ static int bcm3510_do_hab_cmd(struct bcm3510_state *st, u8 cmd, u8 msgid, u8 *ob
 	ob[1] = msgid;
 	memcpy(&ob[2],obuf,olen);
 
-	deb_hab("hab snd: ");
-	dbufout(ob,olen+2,deb_hab);
-	deb_hab("\n");
+	deb_hab("hab snd:");
+	dbufout(DBG_HAB, ob, olen + 2);
 
 	if (mutex_lock_interruptible(&st->hab_mutex) < 0)
 		return -EAGAIN;
@@ -232,9 +244,8 @@ static int bcm3510_do_hab_cmd(struct bcm3510_state *st, u8 cmd, u8 msgid, u8 *ob
 		(ret = bcm3510_hab_get_response(st, ib, ilen+2)) < 0)
 		goto error;
 
-	deb_hab("hab get: ");
-	dbufout(ib,ilen+2,deb_hab);
-	deb_hab("\n");
+	deb_hab("hab get:");
+	dbufout(DBG_HAB, ib, ilen + 2);
 
 	memcpy(ibuf,&ib[2],ilen);
 error:


