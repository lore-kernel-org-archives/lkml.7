Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB33C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2649620640
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932226;
	bh=dLATFpVow7aojoKfxCGuwrnTgzpLrr1z4QSTjwV1B5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p2oCBPJFJXIJc9Z/RR+KROzZX5SAr4NeTAuov/AoUpzUJVJNVWzr04QpMLVQx9liB
	 98/LH+9b5Z+TOzgjmPSZPplsL2kpH7eeusjo2K5qqsHo8A4wW6mUp+/fmXTK3jmZ6D
	 gcL3pHRcCID+qeVv9QOQXGbhzYKfxc2p2gkyjqXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407334AbfISWaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404443AbfISWQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:16:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DE15218AF;
        Thu, 19 Sep 2019 22:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931375;
        bh=dLATFpVow7aojoKfxCGuwrnTgzpLrr1z4QSTjwV1B5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzeMSQJ6HuOs+UNwYPKk28dAvdohi7k0/5/pyXZoUYuGxY2SA6TKEflOhimUo3r2o
         zMWjHKJmYc7wBeGfXAPyQuAQSc+nUcC61VJJhPS4+12adIoUc6N8GJ3ohlYOUU5Ef6
         kgNnq86vy2NB+nzF2MDpIot+7z0cnE4BRPuLz4M8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 23/59] NFSv4: Fix return value in nfs_finish_open()
Date:   Fri, 20 Sep 2019 00:03:38 +0200
Message-Id: <20190919214803.970032400@linuxfoundation.org>
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

[ Upstream commit 9821421a291b548ef4369c6998745baa36ddecd5 ]

If the file turns out to be of the wrong type after opening, we want
to revalidate the path and retry, so return EOPENSTALE rather than
ESTALE.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 85a6fdd76e20b..50c181fa00251 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1470,7 +1470,7 @@ static int nfs_finish_open(struct nfs_open_context *ctx,
 	if (S_ISREG(file->f_path.dentry->d_inode->i_mode))
 		nfs_file_set_open_context(file, ctx);
 	else
-		err = -ESTALE;
+		err = -EOPENSTALE;
 out:
 	return err;
 }
-- 
2.20.1



