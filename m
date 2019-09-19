Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7373DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F9A217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931385;
	bh=3p4OOSAcRYb5vPiN8bwGYGwWOeUJyiCJfryDv8Hasb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QQkA+gvuSJB5cgSIPa5p4FspKsgwufSNgHb9Epdr6NBSezPMp8MDHtvzxg3I0t7c9
	 B6yMmcp1qPGL5ZtxgjR2q+Rh++t8AccoVxnhc/e3q8/LhbI0vJloXxQ6pyZ7mQ3Ry/
	 74xfictYRXa8pRhCM1C8T+mKFJBd40DoHl1+U4Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391244AbfISWQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406298AbfISWQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:16:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0CDD21924;
        Thu, 19 Sep 2019 22:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931378;
        bh=3p4OOSAcRYb5vPiN8bwGYGwWOeUJyiCJfryDv8Hasb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w//5IIQCjjNWph53WBVCcgxJhb5SCV12hLz8VCR1exxZauvrRq5lwky3L2pbkf0Xa
         a2WQonuzvbMrQcvVxcjrqdVa6+l1+L8hjvRUGxG1LRtFkBT2DI40I/3j9qnxYaAV7Q
         O5CNr839cO7F2vno3VhaWHfTwhtNlRh15/el5DXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 24/59] NFS: Fix initialisation of I/O result struct in nfs_pgio_rpcsetup
Date:   Fri, 20 Sep 2019 00:03:39 +0200
Message-Id: <20190919214804.437184368@linuxfoundation.org>
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

[ Upstream commit 17d8c5d145000070c581f2a8aa01edc7998582ab ]

Initialise the result count to 0 rather than initialising it to the
argument count. The reason is that we want to ensure we record the
I/O stats correctly in the case where an error is returned (for
instance in the layoutstats).

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/pagelist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 132e568524dff..ceb6892d9bbdc 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -566,7 +566,7 @@ static void nfs_pgio_rpcsetup(struct nfs_pgio_header *hdr,
 	}
 
 	hdr->res.fattr   = &hdr->fattr;
-	hdr->res.count   = count;
+	hdr->res.count   = 0;
 	hdr->res.eof     = 0;
 	hdr->res.verf    = &hdr->verf;
 	nfs_fattr_init(&hdr->fattr);
-- 
2.20.1



