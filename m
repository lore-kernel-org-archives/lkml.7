Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CDBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BB0218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907361;
	bh=DmawPRaMrk1HaIMhcxgDMlWe2Oo1jLyWLs30oNu+jug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Em6KVwSkpLo0ypTaNYacw5EuHODOIQNdERXIeH81v/UkERACJwp+rstAxnSplgs78
	 wD+eL9XndUMrYVPvqMgZI0I9iRSKyKN8dL+J0vR/oHHirJuJ9WYe2k9hArd3SIJ6vZ
	 OhPw8bWWiaiHtGdbUg0LKiA3KP9HPV9RS26SBgBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbfC3A4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:56:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731843AbfC3Azx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:55:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 622FF218AC;
        Sat, 30 Mar 2019 00:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907353;
        bh=DmawPRaMrk1HaIMhcxgDMlWe2Oo1jLyWLs30oNu+jug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oRuzwWW3uCofR2AFdjGHGL9aZyv7DN2+rlWxZr3oFFHyrSssJyo5l4SPmQmpGhDIq
         zwDYOi7UzEIwMDcVlCZigf5Ez1Swqw1Hrot+E6QkMBvNjk8suJnUJKyN9AD6J/YBzM
         TIZu7T1QlYcPwgIBRgf4spQFwD/SD0luIumQko1Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 37/37] ext4: prohibit fstrim in norecovery mode
Date:   Fri, 29 Mar 2019 20:54:38 -0400
Message-Id: <20190330005441.27540-37-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005441.27540-1-sashal@kernel.org>
References: <20190330005441.27540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Darrick J. Wong" <darrick.wong@oracle.com>

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
index 7917cc89ab21..3dbf4e414706 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -940,6 +940,13 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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

