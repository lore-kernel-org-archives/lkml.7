Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F025AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D2220721
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142822;
	bh=zruDnVJMljDs/bDjpZySQhScOXxkBULXSigdRF4c80A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cMv/Xl1GuYeeZMOUZlvfkFQEd5dPYAmggNEc+J8t/bjsVnf/vFEwdG/59/hrnJJ0Q
	 xt3JEH0AdzAQk60Z4JuIUNpE9Y+tTJNvh6cBE6BGmeitByAIPgW5rpGK9NY/FcC/J3
	 191L2//EgKM1/mgIoC2Jqo86JhSJ7swI8uU5jlYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbfKSFxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:53:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731387AbfKSFxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:53:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02F4F21783;
        Tue, 19 Nov 2019 05:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142817;
        bh=zruDnVJMljDs/bDjpZySQhScOXxkBULXSigdRF4c80A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTMfnJntCb8HUAhZdMqO30+fgQwC0jCMJQHBy+JwgSLOdUTgnrKV/iVhLcoamQjXH
         NW5VKtF8TO+1ucwVfhfm+x0VLh/Fch1Uj/PdmdeEaMzb4b3XR/Ani3ueeXw3nRxGV2
         TAIqK+8vDvK4HF5bbEsAk7cXvjEzm0Y78hGnXXuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 208/239] f2fs: mark inode dirty explicitly in recover_inode()
Date:   Tue, 19 Nov 2019 06:20:08 +0100
Message-Id: <20191119051337.619888748@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 4a1728cad6340bfbe17bd17fd158b2165cd99508 ]

Mark inode dirty explicitly in the end of recover_inode() to make sure
that all recoverable fields can be persisted later.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 87942cf2afe1f..2eef266b656b5 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -227,6 +227,8 @@ static void recover_inode(struct inode *inode, struct page *page)
 	F2FS_I(inode)->i_advise = raw->i_advise;
 	F2FS_I(inode)->i_flags = le32_to_cpu(raw->i_flags);
 
+	f2fs_mark_inode_dirty_sync(inode, true);
+
 	if (file_enc_name(inode))
 		name = "<encrypted>";
 	else
-- 
2.20.1



