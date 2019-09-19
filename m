Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436B5C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBCF20640
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932231;
	bh=gJ+j8xvF3QHkqRQXLGe2LZiL1kQ2dtxg0eY4AnzEdXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hiG+mOL/XfS0bIg7jMczsk0lWJ5QU2oUw8Uw3GvVMU/JiHa0vDBnt6olb/FeOijqj
	 njC0e6fGRG8zVOwWqDSy76KGw6rd2wdzk5bNZx2v2DfK51XXTMae0GwZdFPIjCSAcn
	 K07/CaUr6k1mzSwq3ZFQp65BpFEeLsH4ILuyrdHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407343AbfISWaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406287AbfISWQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:16:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E6C720678;
        Thu, 19 Sep 2019 22:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931372;
        bh=gJ+j8xvF3QHkqRQXLGe2LZiL1kQ2dtxg0eY4AnzEdXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2hrZfcpysb3fs014OoERLJ94gP1SiscdfX9rf4ZTxuofHZzQJ9Jq00wmZmYiY7vA7
         YBj6R4k3XFUdigiXCjD5WvAtXV7GkZtMJ7KlPyf7xtSo1exbBoVlu5gAtyU/EiDtnQ
         yjMl5FkGZN2j7K7vyINy2IiURfoGnilW285eh33c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 22/59] NFSv4: Fix return values for nfs4_file_open()
Date:   Fri, 20 Sep 2019 00:03:37 +0200
Message-Id: <20190919214803.778716576@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
References: <20190919214755.852282682@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 90cf500e338ab3f3c0f126ba37e36fb6a9058441 ]

Currently, we are translating RPC level errors such as timeouts,
as well as interrupts etc into EOPENSTALE, which forces a single
replay of the open attempt. What we actually want to do is
force the replay only in the cases where the returned error
indicates that the file may have changed on the server.

So the fix is to spell out the exact set of errors where we want
to return EOPENSTALE.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 2b3e0f1ca572f..b8d316a338bc9 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -74,13 +74,13 @@ nfs4_file_open(struct inode *inode, struct file *filp)
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		switch (err) {
-		case -EPERM:
-		case -EACCES:
-		case -EDQUOT:
-		case -ENOSPC:
-		case -EROFS:
-			goto out_put_ctx;
 		default:
+			goto out_put_ctx;
+		case -ENOENT:
+		case -ESTALE:
+		case -EISDIR:
+		case -ENOTDIR:
+		case -ELOOP:
 			goto out_drop;
 		}
 	}
-- 
2.20.1



