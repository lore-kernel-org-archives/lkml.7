Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038E7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84022077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbsRzQwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfDPOxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:53:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34024 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfDPOx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:53:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so10494486plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x2ThqjywQB/qJ8k8Ag1YKIlcbxniqo5LsfI0zmgM6F0=;
        b=bbsRzQwXkbN7MeM0cGVVerpWnK27+louLQLGSKpEHtYFuxb2sDF2weMeOQDbnOkgLq
         QuB1GKL8OxI+utJt5csPjrw4oSE9no6YHiRiTXe2GbtgOxXzybUe8xpzpS2U2m8CwrDC
         2RcOpPFOMfZfJ4fEgbLv5/YC3m93fWL0wMeZvYWrOookOULintLzm2Z60kwdssPBKfw4
         9qbcGFGfQLtiJM20GCAYO4+1lpWrt86nAAc5j6cAPNFCF2x5NGPVjdkCJATE/XNztu5T
         XHstY96IiTN9nqdKXTCkyE7r934iJhOnGzzdRWFrtWRcMU0lvfWR5a9HyjLTcLbTQA4S
         SGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x2ThqjywQB/qJ8k8Ag1YKIlcbxniqo5LsfI0zmgM6F0=;
        b=lTeGubwDhzynIrROFQ12704Y63hWIBbfCvTvewSyztySmrwfRV7gG20EYylufI6tYZ
         gHWWBPczlC+wRH3Sfp6cT88Q+kt3CmiG2LreZZ/bsoInQbzdhnGVhLEo4GGHcJFe6o4h
         a4tWTC7kK2GhwavInZlEt08cBhWlRpeUgRB/Xp5IS2Mezp4KLgrF4oi8MhUBmN+slR6o
         rIUDXgikCa4L7EnxCknuVApkYfDRnc50/6Fb7zAiA/hseipslhFOEC9eafaucQgJaz8P
         CqUuU2fH9n25+L+DG90xIACESgn40itwcY8rHC8uSwpNujIGlZUh/eGhwNYjkwc8DTmx
         2j8w==
X-Gm-Message-State: APjAAAWtipaWCU/ovdmlpeF3LldsKjuqpT82SvJzHaKDwBqliV3s/Utf
        uYVwJRsHHkdzRJTHnsVogHo=
X-Google-Smtp-Source: APXvYqyQFac676roXSip05rTorgc4m0c/4VS/FJgIUvEHWc7mVjqH10eaUUtAam0Qz/qXFuJiO4sSA==
X-Received: by 2002:a17:902:442:: with SMTP id 60mr83512846ple.107.1555426409211;
        Tue, 16 Apr 2019 07:53:29 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id k65sm131695593pfb.68.2019.04.16.07.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 07:53:28 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4] tty: rocket: Remove the rp_ioctl
Date:   Tue, 16 Apr 2019 22:53:00 +0800
Message-Id: <20190416145300.28212-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the cmd is RCPK_GET_STRUCT, copy_to_user will copy
info to user space. As info->port.ops is the address of
a constant object rocket_port_ops (assigned in init_r_port),
a kernel address leakage happens.

The rp_ioctl seems will be not used by anybody.
Delete the rp_ioctl completely.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/tty/rocket.c | 154 +--------------------------------------------------
 drivers/tty/rocket.h |  10 ----
 2 files changed, 1 insertion(+), 163 deletions(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index b121d8f8f3d7..e3b4e8bc2d7a 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -90,10 +90,6 @@ static void rp_do_poll(struct timer_list *unused);
 
 static struct tty_driver *rocket_driver;
 
-static struct rocket_version driver_version = {	
-	ROCKET_VERSION, ROCKET_DATE
-};
-
 static struct r_port *rp_table[MAX_RP_PORTS];	       /*  The main repository of serial port state information. */
 static unsigned int xmit_flags[NUM_BOARDS];	       /*  Bit significant, indicates port had data to transmit. */
 						       /*  eg.  Bit 0 indicates port 0 has xmit data, ...        */
@@ -1160,154 +1156,6 @@ static int rp_tiocmset(struct tty_struct *tty,
 	return 0;
 }
 
-static int get_config(struct r_port *info, struct rocket_config __user *retinfo)
-{
-	struct rocket_config tmp;
-
-	memset(&tmp, 0, sizeof (tmp));
-	mutex_lock(&info->port.mutex);
-	tmp.line = info->line;
-	tmp.flags = info->flags;
-	tmp.close_delay = info->port.close_delay;
-	tmp.closing_wait = info->port.closing_wait;
-	tmp.port = rcktpt_io_addr[(info->line >> 5) & 3];
-	mutex_unlock(&info->port.mutex);
-
-	if (copy_to_user(retinfo, &tmp, sizeof (*retinfo)))
-		return -EFAULT;
-	return 0;
-}
-
-static int set_config(struct tty_struct *tty, struct r_port *info,
-					struct rocket_config __user *new_info)
-{
-	struct rocket_config new_serial;
-
-	if (copy_from_user(&new_serial, new_info, sizeof (new_serial)))
-		return -EFAULT;
-
-	mutex_lock(&info->port.mutex);
-	if (!capable(CAP_SYS_ADMIN))
-	{
-		if ((new_serial.flags & ~ROCKET_USR_MASK) != (info->flags & ~ROCKET_USR_MASK)) {
-			mutex_unlock(&info->port.mutex);
-			return -EPERM;
-		}
-		info->flags = ((info->flags & ~ROCKET_USR_MASK) | (new_serial.flags & ROCKET_USR_MASK));
-		mutex_unlock(&info->port.mutex);
-		return 0;
-	}
-
-	if ((new_serial.flags ^ info->flags) & ROCKET_SPD_MASK) {
-		/* warn about deprecation, unless clearing */
-		if (new_serial.flags & ROCKET_SPD_MASK)
-			dev_warn_ratelimited(tty->dev, "use of SPD flags is deprecated\n");
-	}
-
-	info->flags = ((info->flags & ~ROCKET_FLAGS) | (new_serial.flags & ROCKET_FLAGS));
-	info->port.close_delay = new_serial.close_delay;
-	info->port.closing_wait = new_serial.closing_wait;
-
-	mutex_unlock(&info->port.mutex);
-
-	configure_r_port(tty, info, NULL);
-	return 0;
-}
-
-/*
- *  This function fills in a rocket_ports struct with information
- *  about what boards/ports are in the system.  This info is passed
- *  to user space.  See setrocket.c where the info is used to create
- *  the /dev/ttyRx ports.
- */
-static int get_ports(struct r_port *info, struct rocket_ports __user *retports)
-{
-	struct rocket_ports tmp;
-	int board;
-
-	memset(&tmp, 0, sizeof (tmp));
-	tmp.tty_major = rocket_driver->major;
-
-	for (board = 0; board < 4; board++) {
-		tmp.rocketModel[board].model = rocketModel[board].model;
-		strcpy(tmp.rocketModel[board].modelString, rocketModel[board].modelString);
-		tmp.rocketModel[board].numPorts = rocketModel[board].numPorts;
-		tmp.rocketModel[board].loadrm2 = rocketModel[board].loadrm2;
-		tmp.rocketModel[board].startingPortNumber = rocketModel[board].startingPortNumber;
-	}
-	if (copy_to_user(retports, &tmp, sizeof (*retports)))
-		return -EFAULT;
-	return 0;
-}
-
-static int reset_rm2(struct r_port *info, void __user *arg)
-{
-	int reset;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	if (copy_from_user(&reset, arg, sizeof (int)))
-		return -EFAULT;
-	if (reset)
-		reset = 1;
-
-	if (rcktpt_type[info->board] != ROCKET_TYPE_MODEMII &&
-            rcktpt_type[info->board] != ROCKET_TYPE_MODEMIII)
-		return -EINVAL;
-
-	if (info->ctlp->BusType == isISA)
-		sModemReset(info->ctlp, info->chan, reset);
-	else
-		sPCIModemReset(info->ctlp, info->chan, reset);
-
-	return 0;
-}
-
-static int get_version(struct r_port *info, struct rocket_version __user *retvers)
-{
-	if (copy_to_user(retvers, &driver_version, sizeof (*retvers)))
-		return -EFAULT;
-	return 0;
-}
-
-/*  IOCTL call handler into the driver */
-static int rp_ioctl(struct tty_struct *tty,
-		    unsigned int cmd, unsigned long arg)
-{
-	struct r_port *info = tty->driver_data;
-	void __user *argp = (void __user *)arg;
-	int ret = 0;
-
-	if (cmd != RCKP_GET_PORTS && rocket_paranoia_check(info, "rp_ioctl"))
-		return -ENXIO;
-
-	switch (cmd) {
-	case RCKP_GET_STRUCT:
-		if (copy_to_user(argp, info, sizeof (struct r_port)))
-			ret = -EFAULT;
-		break;
-	case RCKP_GET_CONFIG:
-		ret = get_config(info, argp);
-		break;
-	case RCKP_SET_CONFIG:
-		ret = set_config(tty, info, argp);
-		break;
-	case RCKP_GET_PORTS:
-		ret = get_ports(info, argp);
-		break;
-	case RCKP_RESET_RM2:
-		ret = reset_rm2(info, argp);
-		break;
-	case RCKP_GET_VERSION:
-		ret = get_version(info, argp);
-		break;
-	default:
-		ret = -ENOIOCTLCMD;
-	}
-	return ret;
-}
-
 static void rp_send_xchar(struct tty_struct *tty, char ch)
 {
 	struct r_port *info = tty->driver_data;
@@ -2305,7 +2153,7 @@ static const struct tty_operations rocket_ops = {
 	.write_room = rp_write_room,
 	.chars_in_buffer = rp_chars_in_buffer,
 	.flush_buffer = rp_flush_buffer,
-	.ioctl = rp_ioctl,
+	.ioctl = NULL,
 	.throttle = rp_throttle,
 	.unthrottle = rp_unthrottle,
 	.set_termios = rp_set_termios,
diff --git a/drivers/tty/rocket.h b/drivers/tty/rocket.h
index d0560203f215..98d20475365b 100644
--- a/drivers/tty/rocket.h
+++ b/drivers/tty/rocket.h
@@ -68,16 +68,6 @@ struct rocket_version {
 #define ROCKET_CLOSING_WAIT_NONE	ASYNC_CLOSING_WAIT_NONE
 #define ROCKET_CLOSING_WAIT_INF		ASYNC_CLOSING_WAIT_INF
 
-/*
- * Rocketport ioctls -- "RP"
- */
-#define RCKP_GET_STRUCT		0x00525001
-#define RCKP_GET_CONFIG		0x00525002
-#define RCKP_SET_CONFIG		0x00525003
-#define RCKP_GET_PORTS		0x00525004
-#define RCKP_RESET_RM2		0x00525005
-#define RCKP_GET_VERSION	0x00525006
-
 /*  Rocketport Models */
 #define MODEL_RP32INTF        0x0001	/* RP 32 port w/external I/F   */
 #define MODEL_RP8INTF         0x0002	/* RP 8 port w/external I/F    */
-- 
2.11.0

