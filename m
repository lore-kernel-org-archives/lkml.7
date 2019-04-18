Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC1EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E145C214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611586;
	bh=6bjEM3pmgT2cRz29tYS5RPm3uF0XxyGwnwx6+z6ZCEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D8aiK1dNoQCMp23QkfR916fkKSbGspdRK1q0kEE1KOsbuUYowxrRpRg4cvxAsW6ep
	 Ma+f/EqnNf2KCKQ/gWqBhnioSwzIsgIulQSb40qEl4tcOvaFcW2soyxiLfdMdC6iFL
	 ZcuQzWGvG1MRDknYjR1AnoxaSFY6huw7c5Lwcoe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392139AbfDRSTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403904AbfDRSJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:09:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4DF220652;
        Thu, 18 Apr 2019 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610964;
        bh=6bjEM3pmgT2cRz29tYS5RPm3uF0XxyGwnwx6+z6ZCEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mUG/NfVWftIe6qxxkVld9ubhGTddcA/y6na0oEMoBTKb9RgWw2g+wqNgy58Hukydy
         J6brtJB+gDdninbixzYKQ+GWVS5yAbhdA96mq/Ptv7x3/GHa8+IBM9z+2c9YIsAfSd
         jMyPnnBg2qIhH5QxOsHpHvsiThJ/iTLTbSDawdaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dinu-Razvan Chis-Serban <justcsdr@gmail.com>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 31/50] 9p locks: add mount option for lock retry interval
Date:   Thu, 18 Apr 2019 19:57:42 +0200
Message-Id: <20190418160426.544542410@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 072e7599583a..a8ff43068619 100644
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
index 443d12e02043..ce6ca9f4f683 100644
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
index 2f035b15180e..79ff727254bb 100644
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



