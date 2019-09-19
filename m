Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A21C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7BE21920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931611;
	bh=o66SKGWdVKDfAkB7FtfJ9Gt9OTioTM7C2cJAnN6iwqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LbfEJPfNhNIEzyFSDN6tbaZSSUVD+q06HOrv2iC9gXxuhOaGWJ1FdR2x0vDcIEmPp
	 fXviSYv5mEHuakba53wGqIW84gZscFKhXU+C/qOswlgrcA8SjrDFI7MRBbPQTZK5aP
	 s0fSoFAIMeA7xsPKh4Q65fM1Npx7EGNM65/58VnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393985AbfISWUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404604AbfISWUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:20:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B3EF217D6;
        Thu, 19 Sep 2019 22:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931605;
        bh=o66SKGWdVKDfAkB7FtfJ9Gt9OTioTM7C2cJAnN6iwqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2KwQspWwAyXxx3ZAf+nAlgzmSMEdx3HgPxSqm3FOoYZSZ6yDYGOfuzogis2A20ZbH
         Yc3PNiKOwB6QP3pNQkOasmTJ8J3hqtEiLk4KbZaUeWFiuzrIOBnz4PnSzoj4xhZRyt
         hxbdCmCdNC9ciMebG2JIjRBQ+6tDHfyNI8YWODVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 48/74] NFSv4: Fix return values for nfs4_file_open()
Date:   Fri, 20 Sep 2019 00:04:01 +0200
Message-Id: <20190919214809.435827055@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
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
index 8a0c301b0c699..7138383382ff1 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -73,13 +73,13 @@ nfs4_file_open(struct inode *inode, struct file *filp)
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



