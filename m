Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309EBC2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0764F2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482667;
	bh=JgZyYSBf2SW/EqWNhdaCW9RzKKTKsfeBvai0anq+xy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yK19kavEHcaAlZoJodljfb1/7EC6XvApgFCGKYIGxHTamEqbIW4QZbFCXpN67MTRR
	 vHIWSG08vRdnknASvWm657g5RMkNcFyEE7BMbg0Jvy3tBqLBeviyM2SBV5r0AlefZL
	 3mhZD38Gh8kIP6JVs8J2Hs44F01nihCM1HXEuwvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfLDSEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:04:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:48990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729773AbfLDSEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:04:07 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 057742073B;
        Wed,  4 Dec 2019 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482646;
        bh=JgZyYSBf2SW/EqWNhdaCW9RzKKTKsfeBvai0anq+xy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cotR2jr4a2Osiz0WF0UZ9pf+CyKNT8TEFqH8Nc0AuN9EiPuVg9JTYWNTaMc0PvXbG
         GtyHiuWXmBa1dPX1hfjVNLBM06u6+x2srNvRxO3+DgwRZNVedq/0gTEYgrUBY8XI2E
         r7LTg7N740Z59eMGweg2RwKtI1e8utUvMDtTeZus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Bowler <nbowler@draconx.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 078/209] xfs: Fix bulkstat compat ioctls on x32 userspace.
Date:   Wed,  4 Dec 2019 18:54:50 +0100
Message-Id: <20191204175326.826209283@linuxfoundation.org>
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

From: Nick Bowler <nbowler@draconx.ca>

[ Upstream commit 7ca860e3c1a74ad6bd8949364073ef1044cad758 ]

The bulkstat family of ioctls are problematic on x32, because there is
a mixup of native 32-bit and 64-bit conventions.  The xfs_fsop_bulkreq
struct contains pointers and 32-bit integers so that matches the native
32-bit layout, and that means the ioctl implementation goes into the
regular compat path on x32.

However, the 'ubuffer' member of that struct in turn refers to either
struct xfs_inogrp or xfs_bstat (or an array of these).  On x32, those
structures match the native 64-bit layout.  The compat implementation
writes out the 32-bit version of these structures.  This is not the
expected format for x32 userspace, causing problems.

Fortunately the functions which actually output these xfs_inogrp and
xfs_bstat structures have an easy way to select which output format
is required, so we just need a little tweak to select the right format
on x32.

Signed-off-by: Nick Bowler <nbowler@draconx.ca>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_ioctl32.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
index d3c0e4b8bf421..5f616a6a5358d 100644
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -252,6 +252,32 @@ xfs_compat_ioc_bulkstat(
 	int			done;
 	int			error;
 
+	/*
+	 * Output structure handling functions.  Depending on the command,
+	 * either the xfs_bstat and xfs_inogrp structures are written out
+	 * to userpace memory via bulkreq.ubuffer.  Normally the compat
+	 * functions and structure size are the correct ones to use ...
+	 */
+	inumbers_fmt_pf inumbers_func = xfs_inumbers_fmt_compat;
+	bulkstat_one_pf	bs_one_func = xfs_bulkstat_one_compat;
+	size_t bs_one_size = sizeof(struct compat_xfs_bstat);
+
+#ifdef CONFIG_X86_X32
+	if (in_x32_syscall()) {
+		/*
+		 * ... but on x32 the input xfs_fsop_bulkreq has pointers
+		 * which must be handled in the "compat" (32-bit) way, while
+		 * the xfs_bstat and xfs_inogrp structures follow native 64-
+		 * bit layout convention.  So adjust accordingly, otherwise
+		 * the data written out in compat layout will not match what
+		 * x32 userspace expects.
+		 */
+		inumbers_func = xfs_inumbers_fmt;
+		bs_one_func = xfs_bulkstat_one;
+		bs_one_size = sizeof(struct xfs_bstat);
+	}
+#endif
+
 	/* done = 1 if there are more stats to get and if bulkstat */
 	/* should be called again (unused here, but used in dmapi) */
 
@@ -283,15 +309,15 @@ xfs_compat_ioc_bulkstat(
 
 	if (cmd == XFS_IOC_FSINUMBERS_32) {
 		error = xfs_inumbers(mp, &inlast, &count,
-				bulkreq.ubuffer, xfs_inumbers_fmt_compat);
+				bulkreq.ubuffer, inumbers_func);
 	} else if (cmd == XFS_IOC_FSBULKSTAT_SINGLE_32) {
 		int res;
 
-		error = xfs_bulkstat_one_compat(mp, inlast, bulkreq.ubuffer,
-				sizeof(compat_xfs_bstat_t), NULL, &res);
+		error = bs_one_func(mp, inlast, bulkreq.ubuffer,
+				bs_one_size, NULL, &res);
 	} else if (cmd == XFS_IOC_FSBULKSTAT_32) {
 		error = xfs_bulkstat(mp, &inlast, &count,
-			xfs_bulkstat_one_compat, sizeof(compat_xfs_bstat_t),
+			bs_one_func, bs_one_size,
 			bulkreq.ubuffer, &done);
 	} else
 		error = -EINVAL;
-- 
2.20.1



