Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950AFC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5713D206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780928;
	bh=tawO3EiEOzoXBA5escWcgSKwcPu0Xc1V1YBXwfOTuws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hqmUgAzsyyR/g1SCjYaaznTQx7cCz3OMSDh4ff46XAxr6Y5D/wy8ktfJm1oCYi5E7
	 eDyTR4iBYsQ8jZeqOQa1selbz8LY4pBMYN3/Y+ZITcZr6HzEBRmStqZzQyeSweaCLm
	 2DC4JCiG1A/+AIFbREan22hMsxMqykM7wQiDrnJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfLSSmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:42:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbfLSSmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:42:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60D3222C2;
        Thu, 19 Dec 2019 18:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780924;
        bh=tawO3EiEOzoXBA5escWcgSKwcPu0Xc1V1YBXwfOTuws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYhz9vsoQxdqERoVQrrhcvNnUAVIiVeWzh6HJjgxsPSqPy4AuviJVtoywBZ+W3Tqd
         hnBeD8K6Y9u/193ZguhOMBfkqgcR0DahflqFUQ85CEFHjbwSipaOMPQMgt/+j7ZJL2
         4SKgB9regngPk+JJdm4kX+wY4nEN2MKB8Fwxzc5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 011/199] audit_get_nd(): dont unlock parent too early
Date:   Thu, 19 Dec 2019 19:31:33 +0100
Message-Id: <20191219183215.348027418@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 69924b89687a2923e88cc42144aea27868913d0e ]

if the child has been negative and just went positive
under us, we want coherent d_is_positive() and ->d_inode.
Don't unlock the parent until we'd done that work...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/audit_watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index f036b6ada6efc..712469a3103ac 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -365,12 +365,12 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 	struct dentry *d = kern_path_locked(watch->path, parent);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
-	inode_unlock(d_backing_inode(parent->dentry));
 	if (d_is_positive(d)) {
 		/* update watch filter fields */
 		watch->dev = d->d_sb->s_dev;
 		watch->ino = d_backing_inode(d)->i_ino;
 	}
+	inode_unlock(d_backing_inode(parent->dentry));
 	dput(d);
 	return 0;
 }
-- 
2.20.1



