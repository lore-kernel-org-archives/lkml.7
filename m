Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C50C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5109021920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932081;
	bh=9bpHPLsDOpYikVS9tUwi031DN+m6WQ/rT07qfg7aNoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hhFBBaCzTW25VEYRi2dtzUM3fNbgPeKDfskiBf6BTRWRPfHcyOxLf2qv1sP6rFPmi
	 8WDQbzUdnSZGsyZ+xfAxDcvDlIs80ag1EcOpa3/FQxgrSvL6Y97FBzXlqLkFnyvFIB
	 W7wDcXPRgxyTaURzVydzRyjwOGFuK87a0zKNPbfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407290AbfISW2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393974AbfISWUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:20:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E9F021924;
        Thu, 19 Sep 2019 22:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931608;
        bh=9bpHPLsDOpYikVS9tUwi031DN+m6WQ/rT07qfg7aNoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JhxxtlGYuMqptdjIBcaJgKjrvtVR6RcHGZb9PaxmMiPq9sVPft5uA9dY/klj6WdlT
         80BAiL+HXVoylJMHNrUySV4FEL2ChkhS2+da9XNmio8OTO+LyEvwLT3HbQ70/z8/89
         R2htj+vOb/IZ5BTfAdXROE71jRkydjBttJre63+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 49/74] NFS: Fix initialisation of I/O result struct in nfs_pgio_rpcsetup
Date:   Fri, 20 Sep 2019 00:04:02 +0200
Message-Id: <20190919214809.516240428@linuxfoundation.org>
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
index fad4d5188aafa..b6e25126a0b0f 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -562,7 +562,7 @@ static void nfs_pgio_rpcsetup(struct nfs_pgio_header *hdr,
 	}
 
 	hdr->res.fattr   = &hdr->fattr;
-	hdr->res.count   = count;
+	hdr->res.count   = 0;
 	hdr->res.eof     = 0;
 	hdr->res.verf    = &hdr->verf;
 	nfs_fattr_init(&hdr->fattr);
-- 
2.20.1



