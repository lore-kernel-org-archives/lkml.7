Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E848EC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9F9216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="f8nqL4Qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfGIGqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:46:47 -0400
Received: from first.geanix.com ([116.203.34.67]:46434 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbfGIGqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:46:44 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 18CA0A74F;
        Tue,  9 Jul 2019 06:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1562654713; bh=//FC8cP/LBlrTVTEX+Si3DQLq5jHCa1lNoWmCf1K6tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=f8nqL4Qvf0BtE5vqLb7BmyM6Jirv1I0Dhbb1il4D/3fsfqMS6i+oI8EsCRY8KhnRO
         cz4L+c6qzaHemRUFNW1IexOFYFPv4jtJvuIDdhAp6WGf3F0I1GYA6/FT3WlVujWoql
         Bd1rcM8sg1Og7unlUEZKQA132N1hdOBrppCXT8p4IeNUa7fHXtcEvhE8b4EpQSQvGW
         qnCvUdOa0/r9Rix/HVxw5bs19QEV1+gRjkgXgDMLub/80fe8CrLsptV0SdMgYdNgRK
         iGwHNHqKL5Uncw0RtxqN42lX95WUS3aODi4t5KSqCtyMB+NJrs345Ar7zGHdiNh6ND
         6uHa05GL6Xu5Q==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: [PATCHv2 4/4] tty: n_gsm: add ioctl to map serial device to mux'ed tty
Date:   Tue,  9 Jul 2019 08:46:33 +0200
Message-Id: <20190709064633.45411-4-martin@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190709064633.45411-1-martin@geanix.com>
References: <20190709064633.45411-1-martin@geanix.com>
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

Changes since v1:
 * use put_user() instead of copy_to_user()
 * add missing opening quote

 Documentation/serial/n_gsm.rst | 12 ++++++++++--
 drivers/tty/n_gsm.c            |  4 ++++
 include/uapi/linux/gsmmux.h    |  2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/serial/n_gsm.rst b/Documentation/serial/n_gsm.rst
index 0ba731ab00b2..4a52499567f5 100644
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
@@ -58,19 +61,24 @@ Major parts of the initialization program :
 	c.mtu = 127;
 	/* set the new configuration */
 	ioctl(fd, GSMIOC_SETCONF, &c);
+	/* get base gsmtty device node */
+	ioctl(fd, GSMIOC_GETBASE, &base);
+	/* the base node is used for mux control by the driver */
+	printf("first muxed line: /dev/gsmtty%i\n", base + 1);
+
 
 	/* and wait for ever to keep the line discipline enabled */
 	daemon(0,0);
 	pause();
 
-4. use these devices as plain serial ports.
+5. use these devices as plain serial ports.
 
    for example, it's possible:
 
    - and to use gnokii to send / receive SMS on ttygsm1
    - to use ppp to establish a datalink on ttygsm2
 
-5. first close all virtual ports before closing the physical port.
+6. first close all virtual ports before closing the physical port.
 
    Note that after closing the physical port the modem is still in multiplexing
    mode. This may prevent a successful re-opening of the port later. To avoid
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index cba06063c44a..e7aea4ccbebd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2612,6 +2612,7 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
 {
 	struct gsm_config c;
 	struct gsm_mux *gsm = tty->disc_data;
+	int base;
 
 	switch (cmd) {
 	case GSMIOC_GETCONF:
@@ -2623,6 +2624,9 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
 		if (copy_from_user(&c, (void *)arg, sizeof(c)))
 			return -EFAULT;
 		return gsm_config(gsm, &c);
+	case GSMIOC_GETBASE:
+		base = mux_num_to_base(gsm);
+		return put_user(base, (int __user *)arg);
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

