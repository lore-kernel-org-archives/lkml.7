Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A8AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBB22068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403626;
	bh=bU8lHFm9OBXC+O3oT+aSOg/7u1TW8GHVR7WkQspLb68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w2RUbyFzfjZ570FVJ4LFTJeQvh2HVBI6cj6tmb7o9BlroO2zL2shxjSEriSAegcep
	 WUNBZOrIFXc7sIzN+/WaTjuvEoMjVcm9OU+uJp2zn/8V+rq14mM0IxrnSNLsi02aU8
	 GFrd27m6MpkUP7j6a2AHZSRt3GyxXguaYjnInEaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfKVGUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:20:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728652AbfKVFwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:52:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 505282071F;
        Fri, 22 Nov 2019 05:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401962;
        bh=bU8lHFm9OBXC+O3oT+aSOg/7u1TW8GHVR7WkQspLb68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Frk+KZg/YVcmIOjD7VsUhvCFtWFBx0p9zPrE454kmijE5cRDVe73lQRU1NUXxUP05
         XTyx1fb3Y1rsWJzIs1ehLUR/jOxdIhkbIvlUYlAwRdXk56RBL2omhoU6zoEq+FI6di
         kUrnnlXlTfeOE7D+lrEChw9mvpbzVinRz4Uk4FkI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 183/219] xfs: end sync buffer I/O properly on shutdown error
Date:   Fri, 22 Nov 2019 00:48:35 -0500
Message-Id: <20191122054911.1750-176-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Foster <bfoster@redhat.com>

[ Upstream commit 465fa17f4a303d9fdff9eac4d45f91ece92e96ca ]

As of commit e339dd8d8b ("xfs: use sync buffer I/O for sync delwri
queue submission"), the delwri submission code uses sync buffer I/O
for sync delwri I/O. Instead of waiting on async I/O to unlock the
buffer, it uses the underlying sync I/O completion mechanism.

If delwri buffer submission fails due to a shutdown scenario, an
error is set on the buffer and buffer completion never occurs. This
can cause xfs_buf_delwri_submit() to deadlock waiting on a
completion event.

We could check the error state before waiting on such buffers, but
that doesn't serialize against the case of an error set via a racing
I/O completion. Instead, invoke I/O completion in the shutdown case
regardless of buffer I/O type.

Signed-off-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_buf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index e839907e8492f..78173870502ce 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1470,8 +1470,7 @@ __xfs_buf_submit(
 		xfs_buf_ioerror(bp, -EIO);
 		bp->b_flags &= ~XBF_DONE;
 		xfs_buf_stale(bp);
-		if (bp->b_flags & XBF_ASYNC)
-			xfs_buf_ioend(bp);
+		xfs_buf_ioend(bp);
 		return -EIO;
 	}
 
-- 
2.20.1

