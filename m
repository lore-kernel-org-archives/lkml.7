Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96496C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6428020675
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126468;
	bh=Ds1oojnBGsQNQ+iYXmbmDvOhEzEojySNMj+ONeSRgME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UWQrwXq94D8CAnb06gvR4L2Di6lHYVThgitSaAFzDnbYNGijBNFqgtnvsX0Iy/OAu
	 hbkGWXo9f1avBfgwy4k1KkmTU2ljTxBUpRfhE5sk5/1/Iz5mTome6/PB+pdTOAWYWH
	 9lKlh7nS5PHAoRnEwtX4+329TonBTFPcza0xw0nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389287AbfDXRVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389273AbfDXRVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:21:03 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93DCD2190C;
        Wed, 24 Apr 2019 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126463;
        bh=Ds1oojnBGsQNQ+iYXmbmDvOhEzEojySNMj+ONeSRgME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/nocBALQfhFREcj81zmIzDXi2e+Nb2qjyK6PqTqtJFpxZhRbTAULTxViVk38REso
         mu1NP6wo37I9gNTSo6VPNyM9tj4s5tjjpjbh/ewdjHq/oOiM35X3Ob0VFB/RCvOOOk
         VCu+Xj4+KR/W+PTQ/MYG52q0tnmyUx+02Y4b3LYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 118/168] ext4: prohibit fstrim in norecovery mode
Date:   Wed, 24 Apr 2019 19:09:22 +0200
Message-Id: <20190424170930.414015047@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
index bcd7c4788903..e44e3cd738b6 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -599,6 +599,13 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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



