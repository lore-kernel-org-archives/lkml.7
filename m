Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA59C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F52204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254954;
	bh=awdM5lDNcWmvtzG981GfI41qT1DjN9fJ7m2BfOyel94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PkGdZ51Kqmh+pleYuVPe8vT/3vj9eVJ9aqKkeC3y8zkcmtWma7Jncj6JcULD+q7yT
	 0X/0cEygNizteousk0D/8CtWgMoyMEV7HtWarPdSYgae9nIMuG4GUsr7r/wmTyzHwo
	 oY0+bXuLCGRaE2PxGQIW7aJwmSF2ffewkmfAa8dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfCVLmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731538AbfCVLm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:42:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1364D204FD;
        Fri, 22 Mar 2019 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254948;
        bh=awdM5lDNcWmvtzG981GfI41qT1DjN9fJ7m2BfOyel94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CcjQJH+5sO4g4GOUgJiKY5H35YJDm4cMnpl1i/cLW/ZFV54L9JLef1Pa3CMBYMYQC
         wNevG8Ds2yt7/RVG0hE9q1jnxqrWsWF8ixuY6oyukJpQuHi+cZ6KDvsTS73NZsOdtR
         +SSbwqC+bjOJsb+6eKjIg6aYo4bASnokSqgmrA/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Matej Kupljen <matej.kupljen@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 041/118] tmpfs: fix uninitialized return value in shmem_link
Date:   Fri, 22 Mar 2019 12:15:13 +0100
Message-Id: <20190322111219.152072824@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 29b00e609960ae0fcff382f4c7079dd0874a5311 ]

When we made the shmem_reserve_inode call in shmem_link conditional, we
forgot to update the declaration for ret so that it always has a known
value.  Dan Carpenter pointed out this deficiency in the original patch.

Fixes: 1062af920c07 ("tmpfs: fix link accounting when a tmpfile is linked in")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: Matej Kupljen <matej.kupljen@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 214773472530..944242491059 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2896,7 +2896,7 @@ static int shmem_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = d_inode(old_dentry);
-	int ret;
+	int ret = 0;
 
 	/*
 	 * No ordinary (disk based) filesystem counts links as inodes;
-- 
2.19.1



