Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D63C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3204E217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553909681;
	bh=zLdlzUhh2mHD0D1zMEKXc9r7VwXzLhL5pQV9R+VfJiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Un8Ynt0BFHGo6PLVIwYVt6m07f0Pt3AIaKnOe5MBA5afp2e4xgXmO+hStyJdgQyT7
	 FQMyyVHSHrgabBSA2rDDILavw0D9iT/u3AjEwwywDh0mCJhNl0em9vWXfwO7btmf5F
	 IMVebn48uGeIa/tIDAx6SmTHyFTWCDMrLK/KKUNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbfC3Bej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731356AbfC3BcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 21:32:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41FF52184C;
        Sat, 30 Mar 2019 01:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553909525;
        bh=zLdlzUhh2mHD0D1zMEKXc9r7VwXzLhL5pQV9R+VfJiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWjBYafDJRvWFQYUtmSIPhsr3wPSpnPyC7p0CYHJS1k2Y92KMIDTX9tZHAIrWO/Rw
         4C02+J87OmbPgckyjFg01O1tX5DAi33CnhAevsyUIxtCINTlSfibRfPkJMTVIKiOn4
         n2f1XpVd4cRQr+NnAD7J3/0EmBhSZqLtYcaq7mdo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dinu-Razvan Chis-Serban <justcsdr@gmail.com>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.4 03/16] 9p locks: add mount option for lock retry interval
Date:   Fri, 29 Mar 2019 21:31:47 -0400
Message-Id: <20190330013200.1130-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330013200.1130-1-sashal@kernel.org>
References: <20190330013200.1130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinu-Razvan Chis-Serban <justcsdr@gmail.com>

[ Upstream commit 5e172f75e51e3de1b4274146d9b990f803cb5c2a ]

The default P9_LOCK_TIMEOUT can be too long for some users exporting
a local file system to a guest VM (30s), make this configurable at
mount time.

Link: http://lkml.kernel.org/r/1536295827-3181-1-git-send-email-asmadeus@codewreck.org
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195727
Signed-off-by: Dinu-Razvan Chis-Serban <justcsdr@gmail.com>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/v9fs.c     | 21 +++++++++++++++++++++
 fs/9p/v9fs.h     |  1 +
 fs/9p/vfs_file.c |  6 +++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 6caca025019d..1e9bb8db7b48 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -59,6 +59,8 @@ enum {
 	Opt_cache_loose, Opt_fscache, Opt_mmap,
 	/* Access options */
 	Opt_access, Opt_posixacl,
+	/* Lock timeout option */
+	Opt_locktimeout,
 	/* Error token */
 	Opt_err
 };
@@ -78,6 +80,7 @@ static const match_table_t tokens = {
 	{Opt_cachetag, "cachetag=%s"},
 	{Opt_access, "access=%s"},
 	{Opt_posixacl, "posixacl"},
+	{Opt_locktimeout, "locktimeout=%u"},
 	{Opt_err, NULL}
 };
 
@@ -126,6 +129,7 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 #ifdef CONFIG_9P_FSCACHE
 	v9ses->cachetag = NULL;
 #endif
+	v9ses->session_lock_timeout = P9_LOCK_TIMEOUT;
 
 	if (!opts)
 		return 0;
@@ -298,6 +302,23 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 #endif
 			break;
 
+		case Opt_locktimeout:
+			r = match_int(&args[0], &option);
+			if (r < 0) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "integer field, but no integer?\n");
+				ret = r;
+				continue;
+			}
+			if (option < 1) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "locktimeout must be a greater than zero integer.\n");
+				ret = -EINVAL;
+				continue;
+			}
+			v9ses->session_lock_timeout = (long)option * HZ;
+			break;
+
 		default:
 			continue;
 		}
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 6877050384a1..3775f275ede3 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -116,6 +116,7 @@ struct v9fs_session_info {
 	struct list_head slist; /* list of sessions registered with v9fs */
 	struct backing_dev_info bdi;
 	struct rw_semaphore rename_sem;
+	long session_lock_timeout; /* retry interval for blocking locks */
 };
 
 /* cache_validity flags */
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 62ce8b4a7e5f..373cc50544e9 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -154,6 +154,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	uint8_t status = P9_LOCK_ERROR;
 	int res = 0;
 	unsigned char fl_type;
+	struct v9fs_session_info *v9ses;
 
 	fid = filp->private_data;
 	BUG_ON(fid == NULL);
@@ -189,6 +190,8 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 	if (IS_SETLKW(cmd))
 		flock.flags = P9_LOCK_FLAGS_BLOCK;
 
+	v9ses = v9fs_inode2v9ses(file_inode(filp));
+
 	/*
 	 * if its a blocked request and we get P9_LOCK_BLOCKED as the status
 	 * for lock request, keep on trying
@@ -202,7 +205,8 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 			break;
 		if (status == P9_LOCK_BLOCKED && !IS_SETLKW(cmd))
 			break;
-		if (schedule_timeout_interruptible(P9_LOCK_TIMEOUT) != 0)
+		if (schedule_timeout_interruptible(v9ses->session_lock_timeout)
+				!= 0)
 			break;
 		/*
 		 * p9_client_lock_dotl overwrites flock.client_id with the
-- 
2.19.1

