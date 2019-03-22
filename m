Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43B8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7581421925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253788;
	bh=9FffrXrr5zwvEVgB1Y+UhtcAW3CBLM6bazHnolYnt44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BNnDcacVM64BKRSHnm/O2yJ8S6ftyazNoaVWks5f+oZskF6cpBuP/OBdMbXUJru6E
	 /ZOK2gskeiHxxLqjBpT04QwCrybzkCHCyMVgiKGkhas4lnL6bcVP1Fe+VtKOQj5ZRg
	 8vLnDlvFNMP2HtelBoRGK5Ok2xekzh6HNK2EmWgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfCVLXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbfCVLXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:23:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2057D21916;
        Fri, 22 Mar 2019 11:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253784;
        bh=9FffrXrr5zwvEVgB1Y+UhtcAW3CBLM6bazHnolYnt44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4JKgYq0FlUh295Sr5Ix/TOh9UPkXuvZQPAM6mSmf2ZSJZtgyXexmG+mmEloQ3YHI
         Wr3qQ2NCoqXAshwz/uNaaw6sGYGL0fL5u9fGRFdkYkpo6zSsqM6ej/DXPVTvgcIWMS
         T4C4T0AptpyTAqwIsnXVT5DXwxKoiURIkwTGFUDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 071/134] autofs: fix error return in autofs_fill_super()
Date:   Fri, 22 Mar 2019 12:14:44 +0100
Message-Id: <20190322111215.219451094@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f585b283e3f025754c45bbe7533fc6e5c4643700 ]

In autofs_fill_super() on error of get inode/make root dentry the return
should be ENOMEM as this is the only failure case of the called
functions.

Link: http://lkml.kernel.org/r/154725123240.11260.796773942606871359.stgit@pluto-themaw-net
Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/autofs4/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index 1c55388ae633..512f70fade24 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -256,8 +256,10 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	}
 	root_inode = autofs4_get_inode(s, S_IFDIR | 0755);
 	root = d_make_root(root_inode);
-	if (!root)
+	if (!root) {
+		ret = -ENOMEM;
 		goto fail_ino;
+	}
 	pipe = NULL;
 
 	root->d_fsdata = ino;
-- 
2.19.1



