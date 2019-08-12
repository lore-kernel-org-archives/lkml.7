Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABBAC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BA8206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="EBV0Uff0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfHLVM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:12:56 -0400
Received: from first.geanix.com ([116.203.34.67]:58112 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfHLVM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:12:56 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 40E2DB79;
        Mon, 12 Aug 2019 21:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1565644311; bh=mgXsLQ8BeIBpyO91ZbJaEtRAx90yntfQUVQkhgQhhxo=;
        h=From:To:Cc:Subject:Date;
        b=EBV0Uff0M4pRmeJ4eKJ6QyEwW6ULI3N600WPpcPRXRezqO9T2wMQX8Lt+JKDJsJ8v
         PEva6rUpHURQAAAEGcgyZTDARFFlCOThnBNaVG0i/GfN86pvo/eeiJEYwaFak3fH/C
         bV1qhgbxZdhQE6ahGb90C2XGOn7/dk+Skf6/TEIVv/GZm2C87YTaIE6ekvFPEMvt+k
         5jVNrUFVpf0r5aH5EPqAh/wbOvteFAw/9stTy3OX+FAvMCN722lFJzBLFtQLBO1iBZ
         JnWYXYM1XrP9b5AyaEXT/HCuwBhWSwkHlpDomqjXGCDy6aD2cUoWW2CmQlTfqvhPj4
         nepLYu4u3M4sw==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: [PATCHv4] tty: n_gsm: add ioctl to map serial device to mux'ed tty
Date:   Mon, 12 Aug 2019 23:12:43 +0200
Message-Id: <20190812211243.98686-1-martin@geanix.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guessing the first tty for a gsm0710 multiplexed serial device is not
currently possible, which makes it racy to use with multiple modems.

Add a way to map the physical serial tty to its related mux devices
using an ioctl.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---

Changes since v3:
 * use __u32 instead of uint32_t

Changes since v2:
 * rename IOCTL from GSMIOC_GETBASE to GSMIOC_GETFIRST
 * return first usable line instead of private control line
 * return uint32_t instead of int

Changes since v1:
 * use put_user() instead of copy_to_user()
 * add missing opening quote

 Documentation/driver-api/serial/n_gsm.rst | 11 +++++++++--
 drivers/tty/n_gsm.c                       |  4 ++++
 include/uapi/linux/gsmmux.h               |  2 ++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/serial/n_gsm.rst b/Documentation/driver-api/serial/n_gsm.rst
index 0ba731ab00b2..286e7ff4d2d9 100644
--- a/Documentation/driver-api/serial/n_gsm.rst
+++ b/Documentation/driver-api/serial/n_gsm.rst
@@ -18,10 +18,13 @@ How to use it
 2. switch the serial line to using the n_gsm line discipline by using
    TIOCSETD ioctl,
 3. configure the mux using GSMIOC_GETCONF / GSMIOC_SETCONF ioctl,
+4. obtain base gsmtty number for the used serial port,
 
 Major parts of the initialization program :
 (a good starting point is util-linux-ng/sys-utils/ldattach.c)::
 
+  #include <stdio.h>
+  #include <stdint.h>
   #include <linux/gsmmux.h>
   #include <linux/tty.h>
   #define DEFAULT_SPEED	B115200
@@ -30,6 +33,7 @@ Major parts of the initialization program :
 	int ldisc = N_GSM0710;
 	struct gsm_config c;
 	struct termios configuration;
+	uint32_t first;
 
 	/* open the serial port connected to the modem */
 	fd = open(SERIAL_PORT, O_RDWR | O_NOCTTY | O_NDELAY);
@@ -58,19 +62,22 @@ Major parts of the initialization program :
 	c.mtu = 127;
 	/* set the new configuration */
 	ioctl(fd, GSMIOC_SETCONF, &c);
+	/* get first gsmtty device node */
+	ioctl(fd, GSMIOC_GETFIRST, &first);
+	printf("first muxed line: /dev/gsmtty%i\n", first);
 
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
index a60be591f1fc..d30525946892 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2613,6 +2613,7 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
 {
 	struct gsm_config c;
 	struct gsm_mux *gsm = tty->disc_data;
+	unsigned int base;
 
 	switch (cmd) {
 	case GSMIOC_GETCONF:
@@ -2624,6 +2625,9 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
 		if (copy_from_user(&c, (void *)arg, sizeof(c)))
 			return -EFAULT;
 		return gsm_config(gsm, &c);
+	case GSMIOC_GETFIRST:
+		base = mux_num_to_base(gsm);
+		return put_user(base + 1, (__u32 __user *)arg);
 	default:
 		return n_tty_ioctl_helper(tty, file, cmd, arg);
 	}
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index 101d3c469acb..cb8693b39cb7 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -37,5 +37,7 @@ struct gsm_netconfig {
 #define GSMIOC_ENABLE_NET      _IOW('G', 2, struct gsm_netconfig)
 #define GSMIOC_DISABLE_NET     _IO('G', 3)
 
+/* get the base tty number for a configured gsmmux tty */
+#define GSMIOC_GETFIRST		_IOR('G', 4, __u32)
 
 #endif
-- 
2.22.0

