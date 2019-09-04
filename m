Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B406AC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4D220820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613181;
	bh=9bpHPLsDOpYikVS9tUwi031DN+m6WQ/rT07qfg7aNoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NDQOQeY5+/G/KRNMrN9UiOwfiRm9TxklRBh4YvMo8uxysI4ulva/RN4zDli5u2aTj
	 +PoWXT6EwBpcXCmja5mdI5KdAlEUayXwCPziCb0Sy5zBNwXGse0H/PZyzrMAXtBTBY
	 Fd/FvoOdo1bCwY0b5h4Ndq5v5u0FNU2xg2sR3RRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfIDQGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733301AbfIDQC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:02:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B7523404;
        Wed,  4 Sep 2019 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612949;
        bh=9bpHPLsDOpYikVS9tUwi031DN+m6WQ/rT07qfg7aNoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B6m0aE0LqroZRPM8dHLPXs0m/1ZVxY5I64E0rQ6Yn45YwogFaI1bDKLSXJI/YTOH9
         DJcWZl7z32w17SppoECKMY03xb85dhAlgKB/jh3wJa7qGcNZ9Qnty+crFQ7zeO9N89
         Oasr6jWGPahH9tDprpepVO6XLNMvaFI3mLNvg7P4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 07/27] NFS: Fix initialisation of I/O result struct in nfs_pgio_rpcsetup
Date:   Wed,  4 Sep 2019 12:02:00 -0400
Message-Id: <20190904160220.4545-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904160220.4545-1-sashal@kernel.org>
References: <20190904160220.4545-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

