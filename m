Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFE9C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C822190F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570605584;
	bh=98OfNYTmd0ZJ5b8/Q20kF+ue5inCBGi/sdE7mC+Z6QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BYclXHZrHbH3ksVU/JGP9Ttrjv+wNQrG43T0CuW8mSluTb7f/vITRyPQsoPywyjkN
	 yi4vVqaMTSfChf02YNXaDmu1VC4gQSK42/Q7mwfZbLyPvvEJaN/bolqnoScnaSEE4t
	 EcbI+PGoV/xRtAW2mS7PbQv3wVeCqHLMqAnW2b00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfJIHTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfJIHTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:19:42 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E323D21835;
        Wed,  9 Oct 2019 07:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570605582;
        bh=98OfNYTmd0ZJ5b8/Q20kF+ue5inCBGi/sdE7mC+Z6QY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfnB75/bX831YM/IPk/sTW4JoHaL+a43/uazEHpZWKRC7EA5iMrR/NcEmkMlCnfpW
         ME4DFV34DcPxwanPZMsM77nLjrQcY67uSTeIhT8j2XPS/JF/hf1N328nKaMZeEj8Jz
         IUxCzqZJcn5FniBnva4q1B8d5LBLTKgyv1nphhHE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH] fs/namespace.c: fix use-after-free of mount in mnt_warn_timestamp_expiry()
Date:   Wed,  9 Oct 2019 00:18:50 -0700
Message-Id: <20191009071850.258463-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <000000000000805e5505945a234b@google.com>
References: <000000000000805e5505945a234b@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

After do_add_mount() returns success, the caller doesn't hold a
reference to the 'struct mount' anymore.  So it's invalid to access it
in mnt_warn_timestamp_expiry().

Fix it by instead passing the super_block and the mnt_flags.  It's safe
to access the super_block because it's pinned by fs_context::root.

Reported-by: syzbot+da4f525235510683d855@syzkaller.appspotmail.com
Fixes: f8b92ba67c5d ("mount: Add mount warning for impending timestamp expiry")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/namespace.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fe0e9e1410fe..7ef8edaaed69 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2466,12 +2466,11 @@ static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 	unlock_mount_hash();
 }
 
-static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *mnt)
+static void mnt_warn_timestamp_expiry(struct path *mountpoint,
+				      struct super_block *sb, int mnt_flags)
 {
-	struct super_block *sb = mnt->mnt_sb;
-
-	if (!__mnt_is_readonly(mnt) &&
-	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
+	if (!(mnt_flags & MNT_READONLY) && !sb_rdonly(sb) &&
+	    (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
 		char *buf = (char *)__get_free_page(GFP_KERNEL);
 		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
 		struct tm tm;
@@ -2512,7 +2511,7 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 		set_mount_attributes(mnt, mnt_flags);
 	up_write(&sb->s_umount);
 
-	mnt_warn_timestamp_expiry(path, &mnt->mnt);
+	mnt_warn_timestamp_expiry(path, sb, mnt_flags);
 
 	return ret;
 }
@@ -2555,7 +2554,7 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 		up_write(&sb->s_umount);
 	}
 
-	mnt_warn_timestamp_expiry(path, &mnt->mnt);
+	mnt_warn_timestamp_expiry(path, sb, mnt_flags);
 
 	put_fs_context(fc);
 	return err;
@@ -2770,7 +2769,7 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 		return error;
 	}
 
-	mnt_warn_timestamp_expiry(mountpoint, mnt);
+	mnt_warn_timestamp_expiry(mountpoint, sb, mnt_flags);
 
 	return error;
 }
-- 
2.23.0

