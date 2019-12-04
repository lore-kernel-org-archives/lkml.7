Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2E1C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68674205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483797;
	bh=RlJ+wxX/xxhokqFDvuet9MnBPhu1UN6/NnINSGlszmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MU86sUEi9Ou2MV4EHrut2vCECrs6hVb00HFpiDUoo3BHkkN5WfVmooK3whK47xwFy
	 +6rRwaqxGc+3C15yo+B4UtDDMfWYBnHpFXXcSwHYtQ0bdGsxJEdjTzhwuliwGpYTRQ
	 3rbegMR63nONJSswwP7LMHBInONE3CUo7Zws/Tr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfLDSXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbfLDSEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:04:23 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5692073B;
        Wed,  4 Dec 2019 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482663;
        bh=RlJ+wxX/xxhokqFDvuet9MnBPhu1UN6/NnINSGlszmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3oU/IV22AOxXQtcF2S4+yrgulZDw/Xlfzn+3xSAVc2fd1D3rMsSo99DOC6hHOVR3
         zOdwUeZgW5FCEgeFq3RsoKSY52sbS6wAsvGksYW21aOdEeTADztqLJBFoQ/dkdJVvo
         J0JM9R/aoCcSloZbpZ+TXADr+OUeBqStgDc1CG4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Bill ODonnell <billodo@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 049/209] xfs: require both realtime inodes to mount
Date:   Wed,  4 Dec 2019 18:54:21 +0100
Message-Id: <20191204175324.745523898@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
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
index 488719d43ca82..cdcb7235e41ae 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -1214,13 +1214,11 @@ xfs_rtmount_inodes(
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
 		IRELE(mp->m_rbmip);
-- 
2.20.1



