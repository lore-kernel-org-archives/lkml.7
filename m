Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE77CC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C44020815
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920011;
	bh=5XTVctNyzk6Pgxq8rjqvXvZW0PO39MZ7Adbv+jjPc3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xj3y/aPtBevitNSnxVET5YaC6IRS+hjHmUnNysWXDULskHVPvicjYt2PrDj4zTNeH
	 bAllWy6atx7wtuAyj5E2KMbVtqYOpXfB+glO1zjXTPnX9+s9e4W7HpNdWmjY5dGWrl
	 2FZ6g8jg/illekEeKw72JNtqYOK/N7vmipJq7sBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbfKPQAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731281AbfKPPxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:53:43 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC4D32184B;
        Sat, 16 Nov 2019 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919622;
        bh=5XTVctNyzk6Pgxq8rjqvXvZW0PO39MZ7Adbv+jjPc3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ts8Ja9qe5An7knPP+Z6EqnyCtd7puk+woZNdySX+6vob245c51ojR5IAmBNn55urO
         plYpwy8OO2Y28O4e9jrHHPFB3vdluzGMIDZJdJxs6y1iYvE+xk0sw0O+bxKrA+hZks
         wBF8t8YXwzQnLOFMe4nzxiF5tJjOHAQz5jbUCuSk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 04/77] synclink_gt(): fix compat_ioctl()
Date:   Sat, 16 Nov 2019 10:52:26 -0500
Message-Id: <20191116155339.11909-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155339.11909-1-sashal@kernel.org>
References: <20191116155339.11909-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

