Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF41C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9236C20844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="XwZcbkTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfGJT1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:27:13 -0400
Received: from first.geanix.com ([116.203.34.67]:39924 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfGJT1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:27:07 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 8098AE752;
        Wed, 10 Jul 2019 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1562786822; bh=ILqtxYtATybWf2oh+2HQCxnfZwc0z0hE9pMs8n5bHqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XwZcbkThNkw6mQ7sKtA6B5TnccPhIEYEGHZo7/GQZZbCDQGQgFOVZTiVCR3OV0b4e
         1J1wsH9/6+TyK88gIy2sYbjSB5xMnFnaWTtlS5xQnR5/nriQGRm7HojBsLsJkuXS6A
         O60VApose2P5J73VzsucZdEgN1VAE7XcGcZRSnzfKkbKi6qgXUDo2Zu2ng52sRvXuU
         1H2tmX1OjVUraXm3NvlZGGOea+/XRhse7o/zQsQ5XOEQonWeq8aCwFKyC28GC9o23z
         eI30qiqZIDIlZbejawp5l1u+aI2tGbiZ8J1qHMbSQNLB8lAS3oKVNwslCyRkk0jC0I
         4bkNIx6j5OGXg==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: [PATCHv3 4/4] tty: n_gsm: add ioctl to map serial device to mux'ed tty
Date:   Wed, 10 Jul 2019 21:26:56 +0200
Message-Id: <20190710192656.60381-4-martin@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190710192656.60381-1-martin@geanix.com>
References: <20190710192656.60381-1-martin@geanix.com>
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

Changes since v2:
 * rename IOCTL from GSMIOC_GETBASE to GSMIOC_GETFIRST
 * return first usable line instead of private control line
 * return uint32_t instead of int

Changes since v1:
 * use put_user() instead of copy_to_user()
 * add missing opening quote

 Documentation/serial/n_gsm.rst | 11 +++++++++--
 drivers/tty/n_gsm.c            |  4 ++++
 include/uapi/linux/gsmmux.h    |  2 ++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/serial/n_gsm.rst b/Documentation/serial/n_gsm.rst
index 0ba731ab00b2..286e7ff4d2d9 100644
--- a/Documentation/serial/n_gsm.rst
+++ b/Documentation/serial/n_gsm.rst
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
index a60be591f1fc..dac98f3ead3d 100644
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
+		return put_user(base + 1, (uint32_t __user *)arg);
 	default:
 		return n_tty_ioctl_helper(tty, file, cmd, arg);
 	}
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index 101d3c469acb..e292869245dc 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -37,5 +37,7 @@ struct gsm_netconfig {
 #define GSMIOC_ENABLE_NET      _IOW('G', 2, struct gsm_netconfig)
 #define GSMIOC_DISABLE_NET     _IO('G', 3)
 
+/* get the base tty number for a configured gsmmux tty */
+#define GSMIOC_GETFIRST		_IOR('G', 4, uint32_t)
 
 #endif
-- 
2.22.0

