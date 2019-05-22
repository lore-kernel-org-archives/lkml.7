Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED008C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B820121841
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553219;
	bh=eZoYOpEZZXBBGLzR1IIyocDg/nlN3NiCX+nI3TnIoso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ldT3YCD7W7clY/cHVaPdqPt3eclMNgVD8k2amxzUFxOLUswezD/5mMkKEey3irv5i
	 v87ZuQWbKzqmF0l66CG6od0nWZ/L7OD8l2EKXkxMnUDGQpVpR/TuJLzycIy3tV1v/8
	 1VqfbHm/n/EEYXbgdnmuiplEcMMmcp8Jg7qiZR/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbfEVT06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730262AbfEVT0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:26:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C91E21850;
        Wed, 22 May 2019 19:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553210;
        bh=eZoYOpEZZXBBGLzR1IIyocDg/nlN3NiCX+nI3TnIoso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPfIx6S0hhGYgtUv1I689FAmF1ik2c8xdXG/pCRQ4Xq9uulA2iSDq2Ws50YprFT6b
         Z/prwm3FuGmhflSPn8q4bB7K5YcMiRpLXi4zU4ZUWrhLhhM/iPyFpOan9/XmVkS37G
         blg8bi10rR80Z6XxEiQhmLUhiNqXFvG43DE1yq9I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Brandenburg <martin@omnibond.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Sasha Levin <sashal@kernel.org>, devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 4.19 014/244] orangefs: truncate before updating size
Date:   Wed, 22 May 2019 15:22:40 -0400
Message-Id: <20190522192630.24917-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192630.24917-1-sashal@kernel.org>
References: <20190522192630.24917-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Brandenburg <martin@omnibond.com>

[ Upstream commit 33713cd09ccdc1e01b10d0782ae60200d4989553 ]

Otherwise we race with orangefs_writepage/orangefs_writepages
which and does not expect i_size < page_offset.

Fixes xfstests generic/129.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/orangefs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 31932879b7162..9bf2ceed4f29b 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -172,7 +172,11 @@ static int orangefs_setattr_size(struct inode *inode, struct iattr *iattr)
 	}
 	orig_size = i_size_read(inode);
 
-	truncate_setsize(inode, iattr->ia_size);
+	/* This is truncate_setsize in a different order. */
+	truncate_pagecache(inode, iattr->ia_size);
+	i_size_write(inode, iattr->ia_size);
+	if (iattr->ia_size > orig_size)
+		pagecache_isize_extended(inode, orig_size, iattr->ia_size);
 
 	new_op = op_alloc(ORANGEFS_VFS_OP_TRUNCATE);
 	if (!new_op)
-- 
2.20.1

