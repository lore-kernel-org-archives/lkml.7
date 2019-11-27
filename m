Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED100C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B892620869
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574891147;
	bh=5XTVctNyzk6Pgxq8rjqvXvZW0PO39MZ7Adbv+jjPc3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j3qJP5hSUzDQpGcxyNUG81yCFvvfhtcFZy+eEUNjpMXoWVZnWlnD9kiycneTEvQ6i
	 wEvytESp/1XRWeVTgPkqTpzbifgAK3KH54uzy2d7jqXLjqM58US8XP/6g2F692xK8K
	 4HDG1fKJZKK7HxXj50dC60t8IwpEW9BX1aw52Cn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfK0Vpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:45:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbfK0UfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:35:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D387920866;
        Wed, 27 Nov 2019 20:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574886913;
        bh=5XTVctNyzk6Pgxq8rjqvXvZW0PO39MZ7Adbv+jjPc3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LRSLpa7RFoK3MJg2JlmOVtEQi5TQp3WqykReIPICRRtltmfPz/uiXxbEfZL4SBgIH
         yOZVDmfbpCYFjhIty2jbqCZeLPx+b8fZ5jqbB+0YD8Tfxz3JOtsRhFAF/3NLRh/lTk
         20h2hXoJDD21FkiefyMW1PwKKP5sB1dodH7lPrrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 024/132] synclink_gt(): fix compat_ioctl()
Date:   Wed, 27 Nov 2019 21:30:15 +0100
Message-Id: <20191127202920.953069607@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 27230e51349fde075598c1b59d15e1ff802f3f6e ]

compat_ptr() for pointer-taking ones...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/synclink_gt.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 6fc39fbfc2755..b5145e8bdf0a2 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -1192,14 +1192,13 @@ static long slgt_compat_ioctl(struct tty_struct *tty,
 			 unsigned int cmd, unsigned long arg)
 {
 	struct slgt_info *info = tty->driver_data;
-	int rc = -ENOIOCTLCMD;
+	int rc;
 
 	if (sanity_check(info, tty->name, "compat_ioctl"))
 		return -ENODEV;
 	DBGINFO(("%s compat_ioctl() cmd=%08X\n", info->device_name, cmd));
 
 	switch (cmd) {
-
 	case MGSL_IOCSPARAMS32:
 		rc = set_params32(info, compat_ptr(arg));
 		break;
@@ -1219,18 +1218,11 @@ static long slgt_compat_ioctl(struct tty_struct *tty,
 	case MGSL_IOCWAITGPIO:
 	case MGSL_IOCGXSYNC:
 	case MGSL_IOCGXCTRL:
-	case MGSL_IOCSTXIDLE:
-	case MGSL_IOCTXENABLE:
-	case MGSL_IOCRXENABLE:
-	case MGSL_IOCTXABORT:
-	case TIOCMIWAIT:
-	case MGSL_IOCSIF:
-	case MGSL_IOCSXSYNC:
-	case MGSL_IOCSXCTRL:
-		rc = ioctl(tty, cmd, arg);
+		rc = ioctl(tty, cmd, (unsigned long)compat_ptr(arg));
 		break;
+	default:
+		rc = ioctl(tty, cmd, arg);
 	}
-
 	DBGINFO(("%s compat_ioctl() cmd=%08X rc=%d\n", info->device_name, cmd, rc));
 	return rc;
 }
-- 
2.20.1



