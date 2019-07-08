Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90DEC606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C03521783
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="VF113G5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390363AbfGHTDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:03:20 -0400
Received: from first.geanix.com ([116.203.34.67]:59856 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390083AbfGHTDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:03:18 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 5B270A726;
        Mon,  8 Jul 2019 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1562612509; bh=ud0aXp4N/AaUmiTsySCC5hZftAWDCVXMPfBAoYSXslY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VF113G5nkhKt1hGfYhosCZe47ErfODfdSGUPXx/X/xxt5JjQgpP7gi1PAx3DZtNEL
         cQes1L5wd8F0nm6UfT0rDAJ9plHpG1lJ38lIJTKtwQbqrAPp2ZV0qJHIlgWd0nJ/aS
         U9ssMb30WUULYxOfFtKo5WztK7ZDkSHGtyJ7zXwsxDTmMrX1+NOyXLU5MXEbsRA3v4
         w4SsdsrSkyDWHb60SaE1ABUl1CKi4BeHpVJPuh7SHPzceg1E5MpE56b44G4FPm9MeH
         a6s6E/Rw3KRtfwLdD5pvUL38kofkPkLYLPXLjgctNg5BeYqW2fSjuMUPL10ZTkD7Sx
         yfagiGO3M6qLA==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: [PATCH 4/4] tty: n_gsm: add ioctl to map serial device to mux'ed tty
Date:   Mon,  8 Jul 2019 21:02:52 +0200
Message-Id: <20190708190252.24628-4-martin@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708190252.24628-1-martin@geanix.com>
References: <20190708190252.24628-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guessing the base tty for a gsm0710 multiplexed serial device is not
currently possible, which makes it racy to use with multiple modems.

Add a way to map the physical serial tty to its related mux devices
using a ioctl.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 Documentation/serial/n_gsm.rst | 8 ++++++++
 drivers/tty/n_gsm.c            | 6 ++++++
 include/uapi/linux/gsmmux.h    | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/serial/n_gsm.rst b/Documentation/serial/n_gsm.rst
index a3ce1b269018..bf5d7f82b5af 100644
--- a/Documentation/serial/n_gsm.rst
+++ b/Documentation/serial/n_gsm.rst
@@ -18,10 +18,12 @@ How to use it
 2. switch the serial line to using the n_gsm line discipline by using
    TIOCSETD ioctl,
 3. configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl,
+4. obtain base gsmtty number for the used serial port,
 
 Major parts of the initialization program :
 (a good starting point is util-linux-ng/sys-utils/ldattach.c)::
 
+  #include <stdio.h>
   #include <linux/gsmmux.h>
   #include <linux/tty.h>
   #define DEFAULT_SPEED	B115200
@@ -30,6 +32,7 @@ Major parts of the initialization program :
 	int ldisc = N_GSM0710;
 	struct gsm_config c;
 	struct termios configuration;
+	int base;
 
 	/* open the serial port connected to the modem */
 	fd = open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NDELAY);
@@ -58,6 +61,11 @@ Major parts of the initialization program :
 	c.mtu = 127;
 	/* set the new configuration */
 	ioctl(fd, GSMIOC_SETCONF, &c);
+	/* get and print base gsmtty device node */
+	ioctl(fd, GSMIOC_GETBASE, &base);
+	/* the base node is used for mux control by the driver */
+	printf(first muxed line: /dev/gsmtty%i\n", base + 1);
+
 
 	/* and wait for ever to keep the line discipline enabled */
 	daemon(0,0);
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index cba06063c44a..93c24d9b582b 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2612,6 +2612,7 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
 {
 	struct gsm_config c;
 	struct gsm_mux *gsm = tty->disc_data;
+	int base;
 
 	switch (cmd) {
 	case GSMIOC_GETCONF:
@@ -2623,6 +2624,11 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
 		if (copy_from_user(&c, (void *)arg, sizeof(c)))
 			return -EFAULT;
 		return gsm_config(gsm, &c);
+	case GSMIOC_GETBASE:
+		base = mux_num_to_base(gsm);
+		if (copy_to_user((void *)arg, &base, sizeof(base)))
+			return -EFAULT;
+		return 0;
 	default:
 		return n_tty_ioctl_helper(tty, file, cmd, arg);
 	}
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index 101d3c469acb..6eb63be3ed9e 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -37,5 +37,7 @@ struct gsm_netconfig {
 #define GSMIOC_ENABLE_NET      _IOW('G', 2, struct gsm_netconfig)
 #define GSMIOC_DISABLE_NET     _IO('G', 3)
 
+/* get the base tty number for a configured gsmmux tty */
+#define GSMIOC_GETBASE		_IOR('G', 4, int)
 
 #endif
-- 
2.22.0

