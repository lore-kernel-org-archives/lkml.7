Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA21CA9ED4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B1D204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572906332;
	bh=OyhXsx4XtH2ZdP5pHX68Ev2Em10iwdmYnfxc9c33zyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vzQFBBQNWxbCxYADi+dPQABnKiP58ggR/dPICTRLi/IeomFJddlp9zfk5ULLgTTCV
	 LeyS40CzAY/8qOBWMlXY8xvGRt6xRmw50kY9AfqELjHQ6acAxnxL5ihvoqTEHPfNjL
	 sCyCctP0W9CFu99SuEh1cuZB7xniADxebFMqWQyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbfKDWZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:25:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbfKDVvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:51:46 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 676C12053B;
        Mon,  4 Nov 2019 21:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904305;
        bh=OyhXsx4XtH2ZdP5pHX68Ev2Em10iwdmYnfxc9c33zyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1dL2elwqu48LSJwOTtFNzhQeCrHSIaOHS1Xp+gucQrbl/JlUCwbHI42p2YU6iZBg
         k7BBkNCvSobUguXCGgVgOAHEUS2XLIS8tCDhwUffug3qdnrD+T4agPXEVhBBZOHZq3
         p2eHgO2yZhEx3oKMrUaWTAF2QnNQnT0tZVekAFYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vratislav Bendel <vbendel@redhat.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Alex Lyakas <alex@zadara.com>
Subject: [PATCH 4.9 58/62] xfs: Correctly invert xfs_buftarg LRU isolation logic
Date:   Mon,  4 Nov 2019 22:45:20 +0100
Message-Id: <20191104211959.290977993@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104211901.387893698@linuxfoundation.org>
References: <20191104211901.387893698@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vratislav Bendel <vbendel@redhat.com>

commit 19957a181608d25c8f4136652d0ea00b3738972d upstream.

Due to an inverted logic mistake in xfs_buftarg_isolate()
the xfs_buffers with zero b_lru_ref will take another trip
around LRU, while isolating buffers with non-zero b_lru_ref.

Additionally those isolated buffers end up right back on the LRU
once they are released, because b_lru_ref remains elevated.

Fix that circuitous route by leaving them on the LRU
as originally intended.

Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Alex Lyakas <alex@zadara.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/xfs/xfs_buf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1674,7 +1674,7 @@ xfs_buftarg_isolate(
 	 * zero. If the value is already zero, we need to reclaim the
 	 * buffer, otherwise it gets another trip through the LRU.
 	 */
-	if (!atomic_add_unless(&bp->b_lru_ref, -1, 0)) {
+	if (atomic_add_unless(&bp->b_lru_ref, -1, 0)) {
 		spin_unlock(&bp->b_lock);
 		return LRU_ROTATE;
 	}


