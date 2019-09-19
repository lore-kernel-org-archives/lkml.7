Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA22217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931636;
	bh=dz3ZAh8uhkziH89Cqtb57Ig1Dfn4IwRMxgvdjvoB64c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CTeS76KjjL6mYZyxI8iKCa5lB4/fyBSrgIUtpjb1xjJ12QGnas4bZBGA2sG0lh8Z7
	 kLoq9L5H+AZTnd6BEMopCF1GdqUrC40RKUMTo+pfUjV0vO3TAeOrU82SGwX/ZiME30
	 O8FmyBqHqoBKlAs2vfMdXUqf33vMLS7Zv+anoWQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbfISWUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733115AbfISWUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:20:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5033121924;
        Thu, 19 Sep 2019 22:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931632;
        bh=dz3ZAh8uhkziH89Cqtb57Ig1Dfn4IwRMxgvdjvoB64c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+mW05iRJRxKLkfMuwiS47JBEHqF+DtbdAXyKLIDi447Ydhsc7rK1VuMa8dgg33Wf
         7zoQG+e2OTAq5+4wbYghWM2Vh/nHo/qy3hBMGE+KO3oP493rDTdlHMRYcBxQxB4UuM
         x6TbfIgjQaSPU0oS5drydE3mybtiHWzNmfkzu0n4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 57/74] NFSv2: Fix eof handling
Date:   Fri, 20 Sep 2019 00:04:10 +0200
Message-Id: <20190919214810.227366238@linuxfoundation.org>
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

[ Upstream commit 71affe9be45a5c60b9772e1b2701710712637274 ]

If we received a reply from the server with a zero length read and
no error, then that implies we are at eof.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index b7bca83039895..f3e8bcbd29a09 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -588,7 +588,8 @@ static int nfs_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 		/* Emulate the eof flag, which isn't normally needed in NFSv2
 		 * as it is guaranteed to always return the file attributes
 		 */
-		if (hdr->args.offset + hdr->res.count >= hdr->res.fattr->size)
+		if ((hdr->res.count == 0 && hdr->args.count > 0) ||
+		    hdr->args.offset + hdr->res.count >= hdr->res.fattr->size)
 			hdr->res.eof = 1;
 	}
 	return 0;
-- 
2.20.1



