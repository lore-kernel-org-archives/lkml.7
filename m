Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB70C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0730D20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556128897;
	bh=ml0S4Iuy8sZWzos0nWe01WIqHpo2tudPhIS0AgZL+T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fEZm/fR/rjCE2a5JGY2eB8VIr1/s4rQ7LT9PZu5PvfNtW6tvWzemqkYArqhGavoOs
	 sFV7qAvyx63wOFz6KOnTqlJS5jGh44RvSjhTXPfSYBvvxDNQ/mH3gYhHRICuBRA4+G
	 6tnoaIPa9mFmnBA3no73AZfmkdKvv+5B6xbYiE+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389690AbfDXSBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389473AbfDXRWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:22:00 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54A0C20835;
        Wed, 24 Apr 2019 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126519;
        bh=ml0S4Iuy8sZWzos0nWe01WIqHpo2tudPhIS0AgZL+T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvJ+6cMUMp8eZedyC/LYzLN0BN/RivAZdl4L+OR3Qo/PADFtVxxd9QHpXvUgFB8+k
         DTNISToSyRTg0qKhLPRmYpSMF0RipfpLEOGjjEAeiUiBltLtQLbJZhxYfIMhDj63su
         UwFbXQCEA7n7s9J9TvLnbgJDwD1OanHkCj5a4o78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.4 135/168] ovl: fix uid/gid when creating over whiteout
Date:   Wed, 24 Apr 2019 19:09:39 +0200
Message-Id: <20190424170931.278773930@linuxfoundation.org>
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

[ Upstream commit d0e13f5bbe4be7c8f27736fc40503dcec04b7de0 ]

Fix a regression when creating a file over a whiteout.  The new
file/directory needs to use the current fsuid/fsgid, not the ones from the
mounter's credentials.

The refcounting is a bit tricky: prepare_creds() sets an original refcount,
override_creds() gets one more, which revert_cred() drops.  So

  1) we need to expicitly put the mounter's credentials when overriding
     with the updated one

  2) we need to put the original ref to the updated creds (and this can
     safely be done before revert_creds(), since we'll still have the ref
     from override_creds()).

Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
Fixes: 3fe6e52f0626 ("ovl: override creds with the ones from the superblock mounter")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 fs/overlayfs/dir.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index f8aa54272121..eedacae889b9 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -408,12 +408,21 @@ static int ovl_create_or_link(struct dentry *dentry, int mode, dev_t rdev,
 		err = ovl_create_upper(dentry, inode, &stat, link, hardlink);
 	} else {
 		const struct cred *old_cred;
+		struct cred *override_cred;
 
 		old_cred = ovl_override_creds(dentry->d_sb);
 
-		err = ovl_create_over_whiteout(dentry, inode, &stat, link,
-					       hardlink);
+		err = -ENOMEM;
+		override_cred = prepare_creds();
+		if (override_cred) {
+			override_cred->fsuid = old_cred->fsuid;
+			override_cred->fsgid = old_cred->fsgid;
+			put_cred(override_creds(override_cred));
+			put_cred(override_cred);
 
+			err = ovl_create_over_whiteout(dentry, inode, &stat,
+						       link, hardlink);
+		}
 		revert_creds(old_cred);
 	}
 
-- 
2.19.1



