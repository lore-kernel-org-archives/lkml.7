Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFF3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF44020675
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126479;
	bh=0bTFuc5R1h+IIRtWIQSiaVAdk/UHer8eQqNQaVzakAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=POyiQFoXpzpBnoZMSWv23KnMVamoPb86EeSyk63w+fyZOqXWKoDvXSIy5qvNNycV3
	 GC5yD5HpE0kSGtDQIkgY4B9vorbyRmEHdVustVJ6or5Dy0Modz5fL8oSl6ZZsiEQcH
	 mmn36PlNFvt3GRfeNzkQ5Y+dNX4SvwGZUprhEZB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbfDXRVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:21:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389283AbfDXRVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:21:12 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4612B20675;
        Wed, 24 Apr 2019 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126471;
        bh=0bTFuc5R1h+IIRtWIQSiaVAdk/UHer8eQqNQaVzakAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOqcF9z1LmDVpX/+zSqcf0aVZXUh7coJ7376NfilzbBen7zVKG0N7GpHRcuXRiVtq
         GMgynjrCkp5Av20FAkqSIhhUzhgK3h17uz3p2xu4dbnS3/CSvdFdLCSN6bHzyKky21
         jdEgQIfvstJSV8icvECNCo7zPAIbUtBmQt4DVVGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dinu-Razvan Chis-Serban <justcsdr@gmail.com>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 121/168] 9p locks: add mount option for lock retry interval
Date:   Wed, 24 Apr 2019 19:09:25 +0200
Message-Id: <20190424170930.566380876@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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



