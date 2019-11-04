Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68601CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39656214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904696;
	bh=MoM63U9fIL/AW03fDiyVHX9B4WUl0OJn03LJfTOOcXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=weZ+6oXFImbQnbfyXTZKnk/f9g+q7uhEFwodyeWPhgi7LCV9HqJoenUBo13N8c8AT
	 Jffw1T3+55Wiry+YnN0QHERHqvG4iBNidibdUHzAk438Rs0bTSSfM3qqQPJN/h0cZp
	 F8yPYY014TaKViqYK0UfWNO7gXHzsgVPtFjFfHf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfKDV6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:58:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730348AbfKDV6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:58:11 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB6C214D8;
        Mon,  4 Nov 2019 21:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904690;
        bh=MoM63U9fIL/AW03fDiyVHX9B4WUl0OJn03LJfTOOcXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLkgeCCuPnjOrBOMD5MIXJaVNmXuQ1Knqk5kcosPGnYVnZzJKFDiIa8ZVy42mpC9n
         8r9+wqe8QagPfl+ElQmGKGXcsd9NkXQ3k3Q/JqpmagmJBqE9fijf5+MHSGwcyPFT62
         kfoqZBblWuAbRaTBVmp8RULgT0NllvpT+BPKw9vM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/149] NFSv4: Ensure that the state manager exits the loop on SIGKILL
Date:   Mon,  4 Nov 2019 22:43:47 +0100
Message-Id: <20191104212138.173839330@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit a1aa09be21fa344d1f5585aab8164bfae55f57e3 ]

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index c36ef75f2054b..b3086e99420c7 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2613,7 +2613,7 @@ static void nfs4_state_manager(struct nfs_client *clp)
 			return;
 		if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) != 0)
 			return;
-	} while (refcount_read(&clp->cl_count) > 1);
+	} while (refcount_read(&clp->cl_count) > 1 && !signalled());
 	goto out_drain;
 
 out_error:
-- 
2.20.1



