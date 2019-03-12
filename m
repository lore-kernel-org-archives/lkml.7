Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1161214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411363;
	bh=qKzhmXVxPvtf3IWamqpvGLG7us/nyBImMJ8xfUVgrIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ny6OVNM5azjDk9Xzb2HEYgbeOLILU0UVeeY4ZxHBRO4frEpFc6zTtiZyXen6LReRd
	 ZvfCyIdS1899RGc28s4nQWKHmn+7nkILNXoVBMENRoQoLQVfWSeNHTs135Pemu9leY
	 Gx1y1wLpQSHHgyhgj9lMkjT4lidxXtHpdFOkauGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfCLRWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729928AbfCLRSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:18:07 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6648B218AE;
        Tue, 12 Mar 2019 17:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411086;
        bh=qKzhmXVxPvtf3IWamqpvGLG7us/nyBImMJ8xfUVgrIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=scyVDTI0bIC2zRpx2J+yzHUn/d0GP1z4Z4Rmy2u4RrAX0bQTfeCmPtgNE+elf8hlP
         a97h4LuU0H6FjxTrVdusKhVRpGcBoYnSXKyGOEoc4n4Uq1ASax5wgHZjRWv5NWkIWI
         8uXsXQ6XCOWeORB29MjGGzA6WWUjcHfcfWYFkkpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 64/96] autofs: fix error return in autofs_fill_super()
Date:   Tue, 12 Mar 2019 10:10:22 -0700
Message-Id: <20190312171039.374457711@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index ce0c6ea96a87..d9a3264909d0 100644
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



