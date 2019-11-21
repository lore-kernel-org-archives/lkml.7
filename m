Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD6DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2095A20674
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Njf17dlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfKUPWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:22:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35579 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfKUPWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:22:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id s5so4925970wrw.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 07:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tnDnOIJOp4bhxxEhpnCrk56KiIolEGhM1lXxvWF1Yfs=;
        b=Njf17dlIDKfV2byH3e0GQHvmzzKHj+qlEpG3eIgTifgr6S4ZsFLfFupXiUXVPh1zyS
         E0o9ivFpxJjuM5Hk1Jx420Yjm28LamJIhINnAEzMshQ4SzIJ1ZUQrBejnKTaT5j/SZTu
         rNmEXj/MQdOmXJPzAtqJMks8xKx4pt7KKLRni5M/GmKgMK4SinL6RqSV8al9WrYWOY0Q
         lDIauTS3GuPNN2PFbjKK8JKf04sFi//oS5iiV/Io1QN8HYsvvWS7QZT6EoxujNfYj2GN
         eO9XBYTUcN5i/DtYutkZTg0yWTLXMM1u9MbvXQWRzk2Rvq8cRY0/pa2TYX3ovgijk+Ra
         yyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tnDnOIJOp4bhxxEhpnCrk56KiIolEGhM1lXxvWF1Yfs=;
        b=tQ4Os35xjHsdC9LrFDx3TnwsE8JXEaZ3Yyr4XlKaPejYvtGlFzgbl86P42sW+1RzwM
         bOhwYo0DIRd13X1y0912G/1e4+O4O+5pvtN20N2RzkJtGybtEu6kYIrhac5f1NPs6dh4
         0H7my8ZEss1NnYoXn7VbxeKOEQ2y8xmnx04aijdU4wahHhR5SjCurcp2q7hrV5gXDsu0
         V/6XF5q/REPGhbMAVcYczNay0SbbhNzjXgP1OQmcLpktuCWXFlt82NgeWoSHwIgG6L5k
         SiBNIVUz+XVWa57JHL9du5Hni4sgMwjxEfOuk7DREDm9hKm7sp6cpzMbMV8W/oP7cdFp
         +yAQ==
X-Gm-Message-State: APjAAAWQX0GFE9Oo6avmSbi/uVqHZX6g94YjiMOTgEACqqVSeuONCM0R
        SJWNt73mqrC3GY3sLbs5FJk=
X-Google-Smtp-Source: APXvYqzTo55aX2fPFJ06M9s3fHezWv/B3I/lL8U9evGwdhv/3kquhVQVgxpkMdCJv7glOhRRg0syag==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr9766454wro.310.1574349762062;
        Thu, 21 Nov 2019 07:22:42 -0800 (PST)
Received: from debian.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id t12sm3499467wrx.93.2019.11.21.07.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:22:40 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2 1/2] tty: add retry capability to tty_init_dev()
Date:   Thu, 21 Nov 2019 15:22:38 +0000
Message-Id: <20191121152239.28405-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new function tty_init_dev_retry() which will have the capability
to return if 'tty->port' is not yet set and if we want to retry. There
is no change in behaviour if we do not want to retry and call
tty_init_dev().

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

v1 was a combined patch of this and the next 2/2 patch. Made them
separately now.

 drivers/tty/tty_io.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e3076ea01222..95d7abeca254 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1291,9 +1291,10 @@ static int tty_reopen(struct tty_struct *tty)
 }
 
 /**
- *	tty_init_dev		-	initialise a tty device
+ *	tty_init_dev_retry	-	initialise a tty device
  *	@driver: tty driver we are opening a device on
  *	@idx: device index
+ *	@retry: retry count if driver has not set tty->port yet
  *	@ret_tty: returned tty structure
  *
  *	Prepare a tty device. This may not be a "new" clean device but
@@ -1314,7 +1315,8 @@ static int tty_reopen(struct tty_struct *tty)
  * relaxed for the (most common) case of reopening a tty.
  */
 
-struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
+static struct tty_struct *tty_init_dev_retry(struct tty_driver *driver,
+					     int idx, int retry)
 {
 	struct tty_struct *tty;
 	int retval;
@@ -1343,6 +1345,10 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 
 	if (!tty->port)
 		tty->port = driver->ports[idx];
+	if (!tty->port && retry) {
+		retval = -EAGAIN;
+		goto err_release_driver;
+	}
 
 	WARN_RATELIMIT(!tty->port,
 			"%s: %s driver does not set tty->port. This will crash the kernel later. Fix the driver!\n",
@@ -1365,6 +1371,8 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 	/* Return the tty locked so that it cannot vanish under the caller */
 	return tty;
 
+err_release_driver:
+	tty_driver_remove_tty(driver, tty);
 err_free_tty:
 	tty_unlock(tty);
 	free_tty_struct(tty);
@@ -1384,6 +1392,19 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 }
 
 /**
+ *	tty_init_dev		-	initialise a tty device
+ *	@driver: tty driver we are opening a device on
+ *	@idx: device index
+ *	@ret_tty: returned tty structure
+ *
+ *	Calls tty_init_dev_retry() with retry count of 0.
+ */
+struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
+{
+	return tty_init_dev_retry(driver, idx, 0);
+}
+
+/**
  * tty_save_termios() - save tty termios data in driver table
  * @tty: tty whose termios data to save
  *
-- 
2.11.0

