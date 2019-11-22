Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B599C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEAA2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKVKRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:17:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:46886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbfKVKRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:17:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C43EBAC46;
        Fri, 22 Nov 2019 10:17:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] tty: don't crash in tty_init_dev when missing tty_port
Date:   Fri, 22 Nov 2019 11:17:21 +0100
Message-Id: <20191122101721.7222-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently warn the user when tty->port is not set in tty_init_dev
yet. The warning says that the kernel will crash later. And it really
will only few lines below at:
tty->port->itty = tty;

So be nice and avoid the crash -- return an error instead. And update
the warning.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/tty/tty_io.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index cb6370906a6d..d9f54c7d94f2 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1345,9 +1345,12 @@ struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
 	if (!tty->port)
 		tty->port = driver->ports[idx];
 
-	WARN_RATELIMIT(!tty->port,
-			"%s: %s driver does not set tty->port. This will crash the kernel later. Fix the driver!\n",
-			__func__, tty->driver->name);
+	if (WARN_RATELIMIT(!tty->port,
+			"%s: %s driver does not set tty->port. This would crash the kernel. Fix the driver!\n",
+			__func__, tty->driver->name)) {
+		retval = -EINVAL;
+		goto err_release_lock;
+	}
 
 	retval = tty_ldisc_lock(tty, 5 * HZ);
 	if (retval)
-- 
2.24.0

