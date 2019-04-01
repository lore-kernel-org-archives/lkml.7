Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E782FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B598F2171F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139922;
	bh=EoGaq4gB+bVANjMzdq90a2/yA4nHMPbWAVcQNw8gXPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s0/630vQYQq9c7HN69LCG0uqu+11LPzsmxIgVmY5wL8AlfalaXJ9LD9UOUYHfJipn
	 rbUOXQne3GtgZLA6KOtsssfaUaISy3kzzvwaf68Zn/OYkKGLXGnhQLFbwk1W00moVt
	 xN6vn0lmoLDN5+lLxh9X+WDJcOG22PYYGR2A3bxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbfDARcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733060AbfDARb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:31:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9184620856;
        Mon,  1 Apr 2019 17:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139918;
        bh=EoGaq4gB+bVANjMzdq90a2/yA4nHMPbWAVcQNw8gXPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dvs/c0WGFwNjB6POxUmLwl48Gg1fsClRzhAH5XZlglKzsuYWHLnlwKJoWop5FplaY
         ScL8gHdLf3GkdvrGrWXwD5I8i4wBlFMIcmT1+RSYnA9EUJV80Z+M5g64b+4BKyt+tr
         /bHbBHndAqJb2ofIrRZGgCxYM++L9EoAYLRrLP8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tahsin Erdogan <tahsin@google.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 053/131] writeback: initialize inode members that track writeback history
Date:   Mon,  1 Apr 2019 19:02:03 +0200
Message-Id: <20190401170056.764925105@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3d65ae4634ed8350aee98a4e6f4e41fe40c7d282 ]

inode struct members that track cgroup writeback information
should be reinitialized when inode gets allocated from
kmem_cache. Otherwise, their values remain and get used by the
new inode.

Signed-off-by: Tahsin Erdogan <tahsin@google.com>
Acked-by: Tejun Heo <tj@kernel.org>
Fixes: d10c80955265 ("writeback: implement foreign cgroup inode bdi_writeback switching")
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index a39c2724d8a0..b5c3a6473aaa 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -154,6 +154,12 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_rdev = 0;
 	inode->dirtied_when = 0;
 
+#ifdef CONFIG_CGROUP_WRITEBACK
+	inode->i_wb_frn_winner = 0;
+	inode->i_wb_frn_avg_time = 0;
+	inode->i_wb_frn_history = 0;
+#endif
+
 	if (security_inode_alloc(inode))
 		goto out;
 	spin_lock_init(&inode->i_lock);
-- 
2.19.1



