Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5879C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E74C2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412318;
	bh=GD9B8qPQED74Gfn2qIolDm9KcrhGwNnvgjj5J+ZR2p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wV4Ydew50EtsAD0jaiCl+aLvjcV0PLH6zVNoOndL5fGjSZLuxxMKPN+J0SVbrxoLA
	 wLWNGk9rw4kkYUrS8CA75hxFEVmeaQVYq5o4oabprZEbiu4Hm7yPPJ+A0LkBl51In5
	 hkRl9N+C1+eWT6YrBGpr3uRbCW5yqtUTofEU+Abo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfCLRih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbfCLRQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:30 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C41D62184E;
        Tue, 12 Mar 2019 17:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410989;
        bh=GD9B8qPQED74Gfn2qIolDm9KcrhGwNnvgjj5J+ZR2p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8vVLbTgRVKxflGPTUMNB1yohMUjeXdCL9KmWs6/vUROueMWBjo/X8GjXoWAZizJR
         moGAF+fgarVkNaXNHQijUMx9jLpHRzDdv6hOZAy2aBpBEZw62BKcjEpO94yON0Jq3x
         hEpCdEn4cH0/Qmooi5+nbyYqNqXaXqor8uu8miwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 086/135] autofs: fix error return in autofs_fill_super()
Date:   Tue, 12 Mar 2019 10:08:53 -0700
Message-Id: <20190312170349.100515223@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 3c7e727612fa..e455388a939c 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -259,8 +259,10 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
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



