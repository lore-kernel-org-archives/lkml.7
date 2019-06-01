Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611EEC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C83827428
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395729;
	bh=UNuKEqGv1phTlS2mkIZ57l/ivlTnengkZI+UYIKW4ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=be1x2O2nMSQb0dO3KEvuMBlxT7qKyR677DuCTIAN0k3Zqo7eZGjdxCk0L1bHygdJf
	 XRtEh1HoQa1tNtqVhUK+57e9mdBd6OgYczsGfYvf+EYUnztwRcfPVCCKEcZETvN3Hk
	 sHd5qDwrxe46GvuV0fXSQBCn1jVscnzMQtVeeE5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfFAN2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbfFAN0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:26:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C27F273BD;
        Sat,  1 Jun 2019 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395604;
        bh=UNuKEqGv1phTlS2mkIZ57l/ivlTnengkZI+UYIKW4ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WH4izXtShZLpjTMFTqbHrfsg16SY+WwzDt9xgR4Uof7srw+ZJIV/X1m2YGJp/c/bw
         RsHX0kV0kTwfo1fYSm2C5XQJ+vPWItQduC7s5e6DvjizC10B5MeCbxg+YvjoLotba1
         GzaQmAKZ0sN6QSoUBJR2J3sxIfPgp8/WyBT5apJA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liu Bo <bo.liu@linux.alibaba.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 23/56] fuse: honor RLIMIT_FSIZE in fuse_file_fallocate
Date:   Sat,  1 Jun 2019 09:25:27 -0400
Message-Id: <20190601132600.27427-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132600.27427-1-sashal@kernel.org>
References: <20190601132600.27427-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Bo <bo.liu@linux.alibaba.com>

[ Upstream commit 0cbade024ba501313da3b7e5dd2a188a6bc491b5 ]

fstests generic/228 reported this failure that fuse fallocate does not
honor what 'ulimit -f' has set.

This adds the necessary inode_newsize_ok() check.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Fixes: 05ba1f082300 ("fuse: add FALLOCATE operation")
Cc: <stable@vger.kernel.org> # v3.5
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d40c2451487cb..3ba45758e0938 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2947,6 +2947,13 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		}
 	}
 
+	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
+	    offset + length > i_size_read(inode)) {
+		err = inode_newsize_ok(inode, offset + length);
+		if (err)
+			return err;
+	}
+
 	if (!(mode & FALLOC_FL_KEEP_SIZE))
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 
-- 
2.20.1

