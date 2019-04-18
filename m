Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8C1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3501D2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611217;
	bh=2B7WEXNUQiFETZRN6SGBNeT5lvglUMdmZJmO+wzNi28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zINZW+kqj/GmsajdXVzmG0V7G2B51RmDc4PBHwQVxZNtfT/wV0008+sok2PgRyxU/
	 i/KoWrlxsxuUdimvOCuZeRR7BWkHFVGshl3hCquzA+o1A4dWPAYiJQi9OZ7rOxFjv5
	 CzbgvLpqNoV9ATog2wDh8XCs3uEb4Jx/TixicovA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404431AbfDRSNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404405AbfDRSNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:13:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367AD21872;
        Thu, 18 Apr 2019 18:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611196;
        bh=2B7WEXNUQiFETZRN6SGBNeT5lvglUMdmZJmO+wzNi28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SjYVDSENfN/QLPejL3b/rlvOxE0AMF0KQoPkdbcv8QG4G8CK0vaO9wocxK9JTVDAR
         fgl0QEfj6ACYPyzaqWaSYkIw7jx7VVRugLctk2J4Fp2mcAHLbOSkoKxXyxhkeXFwcI
         Dqd70yn2tStVMtQV4BSHxXu0WpIUFuKDiZfckAqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 67/93] ext4: prohibit fstrim in norecovery mode
Date:   Thu, 18 Apr 2019 19:57:45 +0200
Message-Id: <20190418160444.080203740@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 18915b5873f07e5030e6fb108a050fa7c71c59fb ]

The ext4 fstrim implementation uses the block bitmaps to find free space
that can be discarded.  If we haven't replayed the journal, the bitmaps
will be stale and we absolutely *cannot* use stale metadata to zap the
underlying storage.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 2e76fb55d94a..5f24fdc140ad 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -999,6 +999,13 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (!blk_queue_discard(q))
 			return -EOPNOTSUPP;
 
+		/*
+		 * We haven't replayed the journal, so we cannot use our
+		 * block-bitmap-guided storage zapping commands.
+		 */
+		if (test_opt(sb, NOLOAD) && ext4_has_feature_journal(sb))
+			return -EROFS;
+
 		if (copy_from_user(&range, (struct fstrim_range __user *)arg,
 		    sizeof(range)))
 			return -EFAULT;
-- 
2.19.1



