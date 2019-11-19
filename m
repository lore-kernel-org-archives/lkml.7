Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAD8C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1913208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142077;
	bh=CtT6uTW0IPM2Nq6HBc1wilGUrLZyI4sUEyoHHr7e/+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qvdwM4dcnltReuMLwX7cX1L44BFJ+UTbUpKANwI5+DyjThJhJlzKlyXW3pvtzdNFH
	 sW8QQ34HuoxKZ14a9DVcmTTLRMp2PGb3zYR4hC/c8iWliQ108xbcr8yllioYnwD1tU
	 4BGF+QpJl/rPZVsoIXgkWbIDiUxCVf6ofmcGPNWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfKSFlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:41:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730504AbfKSFlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:41:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D3B208C3;
        Tue, 19 Nov 2019 05:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142074;
        bh=CtT6uTW0IPM2Nq6HBc1wilGUrLZyI4sUEyoHHr7e/+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=07Yo3q9mc1lnEL8/Z9gEMZDxmId1WiD0CIXSDHHemtm4jDY0kzChh7lSGGIKT9k2X
         nAjW4n+dYDvdWgQLwd9wq0iQ/aFjoaVxAA5hK/8tlsIlYRgA4wUsLVh1a/b4MNwJza
         odze3IEzUA3aXVIUoPSi6x3w8CYZzKbTaV2/0lxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 379/422] f2fs: mark inode dirty explicitly in recover_inode()
Date:   Tue, 19 Nov 2019 06:19:36 +0100
Message-Id: <20191119051423.606527864@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
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
index 01636d996ba41..733f005b85d65 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -247,6 +247,8 @@ static void recover_inode(struct inode *inode, struct page *page)
 
 	recover_inline_flags(inode, raw);
 
+	f2fs_mark_inode_dirty_sync(inode, true);
+
 	if (file_enc_name(inode))
 		name = "<encrypted>";
 	else
-- 
2.20.1



