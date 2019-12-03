Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A76C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF34215F2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413359;
	bh=k5xwEgIV4ziJaLKkSs+CpZaMBlRyfllb3ryncgJ5w1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CLqrq0FOGXFeGvlHGCXXApTl6A2nCkLjo4IJwb/5TLoOHgOyuc3Mourq1oJnS1Hoj
	 Uk24o2TgQ0bAaZgdjrFgMaqhWHNK4bbv2p9wNI7n0wKYpkWMhPVI5k50ZdNczn31mf
	 aIUeEkqIxAyRdQIF/7ZnUPRioIXfz15UAyAFh1us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfLCWtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:49:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbfLCWtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:49:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C00662080F;
        Tue,  3 Dec 2019 22:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413355;
        bh=k5xwEgIV4ziJaLKkSs+CpZaMBlRyfllb3ryncgJ5w1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eRJ1dzsS04kdY4n4sFD8nFcXNtUoU6ffUCXEoX5UB62HaFWWx0uAMKVwvgZ8szd6L
         hmTZh3R2Am3K0AQ2CqGIWKB2sJ/cNAREulbvqns/SGA7X0W49MrjcU0C2dMMbzKkVt
         f1rlbv+go2Aty4Tp7ppbEsWG9sW3A+Sfo2g7sPDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Bill ODonnell <billodo@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/321] xfs: require both realtime inodes to mount
Date:   Tue,  3 Dec 2019 23:32:43 +0100
Message-Id: <20191203223432.204775804@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

[ Upstream commit 64bafd2f1e484e27071e7584642005d56516cb77 ]

Since mkfs always formats the filesystem with the realtime bitmap and
summary inodes immediately after the root directory, we should expect
that both of them are present and loadable, even if there isn't a
realtime volume attached.  There's no reason to skip this if rbmino ==
NULLFSINO; in fact, this causes an immediate crash if the there /is/ a
realtime volume and someone writes to it.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Bill O'Donnell <billodo@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_rtalloc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 926ed314ffba1..484eb0adcefb2 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -1198,13 +1198,11 @@ xfs_rtmount_inodes(
 	xfs_sb_t	*sbp;
 
 	sbp = &mp->m_sb;
-	if (sbp->sb_rbmino == NULLFSINO)
-		return 0;
 	error = xfs_iget(mp, NULL, sbp->sb_rbmino, 0, 0, &mp->m_rbmip);
 	if (error)
 		return error;
 	ASSERT(mp->m_rbmip != NULL);
-	ASSERT(sbp->sb_rsumino != NULLFSINO);
+
 	error = xfs_iget(mp, NULL, sbp->sb_rsumino, 0, 0, &mp->m_rsumip);
 	if (error) {
 		xfs_irele(mp->m_rbmip);
-- 
2.20.1



