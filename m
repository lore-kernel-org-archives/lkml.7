Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832E5C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581CF21775
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576518987;
	bh=E7QH1DALMVMiTDVbaIxq+PDoDMC7JVVXWQNHq71LvSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ncFsHNW7SIFkKXnZYhRYb+x8G4/RfZN6ZEfo1Z8viz8kRnx3JRq/CskJV6M4bwBS5
	 /h7EVlM1A82qbu7hVqp19fnz53CBBxU6jvyRJ6V1qDHqaSPN9sVsmF0WIbAwaTBPy6
	 l4UwVq0EOqA29ko6Ug+0Q4jRhP6+WEBiGT+dlRU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfLPR40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:56:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbfLPR4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:56:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ED5824672;
        Mon, 16 Dec 2019 17:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518978;
        bh=E7QH1DALMVMiTDVbaIxq+PDoDMC7JVVXWQNHq71LvSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=otN4W2zG7Clj13EpjWgnZRCwM0fi2kZE4xq1XFlV0Ie8J8+o/7w/2HaLRmHKDjxrH
         qDwfQx3/Y9AEHg6eaVKNJDKRb0AbtNrsaQaVCezQZk/HdYEL7b8JiWH3r71LW9jpoQ
         1icQGSURLYYg5NT2c1i+OZ0U8czebI8KYvsbBoPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhengbin <zhengbin13@huawei.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 107/267] nfsd: Return EPERM, not EACCES, in some SETATTR cases
Date:   Mon, 16 Dec 2019 18:47:13 +0100
Message-Id: <20191216174902.581497762@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit 255fbca65137e25b12bced18ec9a014dc77ecda0 ]

As the man(2) page for utime/utimes states, EPERM is returned when the
second parameter of utime or utimes is not NULL, the caller's effective UID
does not match the owner of the file, and the caller is not privileged.

However, in a NFS directory mounted from knfsd, it will return EACCES
(from nfsd_setattr-> fh_verify->nfsd_permission).  This patch fixes
that.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/vfs.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f55527ef21e84..06d1f2edf2ec6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -396,10 +396,23 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 	bool		get_write_count;
 	bool		size_change = (iap->ia_valid & ATTR_SIZE);
 
-	if (iap->ia_valid & (ATTR_ATIME | ATTR_MTIME | ATTR_SIZE))
+	if (iap->ia_valid & ATTR_SIZE) {
 		accmode |= NFSD_MAY_WRITE|NFSD_MAY_OWNER_OVERRIDE;
-	if (iap->ia_valid & ATTR_SIZE)
 		ftype = S_IFREG;
+	}
+
+	/*
+	 * If utimes(2) and friends are called with times not NULL, we should
+	 * not set NFSD_MAY_WRITE bit. Otherwise fh_verify->nfsd_permission
+	 * will return EACCESS, when the caller's effective UID does not match
+	 * the owner of the file, and the caller is not privileged. In this
+	 * situation, we should return EPERM(notify_change will return this).
+	 */
+	if (iap->ia_valid & (ATTR_ATIME | ATTR_MTIME)) {
+		accmode |= NFSD_MAY_OWNER_OVERRIDE;
+		if (!(iap->ia_valid & (ATTR_ATIME_SET | ATTR_MTIME_SET)))
+			accmode |= NFSD_MAY_WRITE;
+	}
 
 	/* Callers that do fh_verify should do the fh_want_write: */
 	get_write_count = !fhp->fh_dentry;
-- 
2.20.1



