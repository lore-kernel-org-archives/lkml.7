Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1209C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF8421845
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887830;
	bh=jVnLETnGPfxAFSTB/kINL/wkeobz7QLCRb02W0EwSyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OgpPbYu0ryfaIL5AbLqwSvxyoibguLw2pXBgHU/dKP57pw4K+zhOh6yUkeNjvasPP
	 1b2+0w0hJZVOYy1fengSHjUFIYM5nSesjHiwuTgh9afQ4NY4L+yfqLel3JREjTf380
	 Qm/m8hdCia1hEkTF6rM+w4S3a7EVMDsVNzX/rHhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbfK0Uua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:50:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730347AbfK0UuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:50:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA6D621847;
        Wed, 27 Nov 2019 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887823;
        bh=jVnLETnGPfxAFSTB/kINL/wkeobz7QLCRb02W0EwSyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6VMJaGs7kLw0yDs+UL10oag1fsxwUKhtM1PuWZp90ZLY/hScObGhj/crmGb3JlRA
         bLBye1twCa+o5WeQ7cz60tKj46k1pxeQYdgVupNXkG+Y56xZqqRweIjqaSgq7i3Fwe
         PHAh3dswJH4oMUxmn7O07r5UVPcHpW5dZrCf05I4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "=?UTF-8?q?Ernesto=20A . =20Fern=C3=A1ndez?=" 
        <ernesto.mnd.fernandez@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 109/211] hfsplus: fix BUG on bnode parent update
Date:   Wed, 27 Nov 2019 21:30:42 +0100
Message-Id: <20191127203104.397602489@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

[ Upstream commit 19a9d0f1acf75e8be8cfba19c1a34e941846fa2b ]

Creating, renaming or deleting a file may hit BUG_ON() if the first
record of both a leaf node and its parent are changed, and if this
forces the parent to be split.  This bug is triggered by xfstests
generic/027, somewhat rarely; here is a more reliable reproducer:

  truncate -s 50M fs.iso
  mkfs.hfsplus fs.iso
  mount fs.iso /mnt
  i=1000
  while [ $i -le 2400 ]; do
    touch /mnt/$i &>/dev/null
    ((++i))
  done
  i=2400
  while [ $i -ge 1000 ]; do
    mv /mnt/$i /mnt/$(perl -e "print $i x61") &>/dev/null
    ((--i))
  done

The issue is that a newly created bnode is being put twice.  Reset
new_node to NULL in hfs_brec_update_parent() before reaching goto again.

Link: http://lkml.kernel.org/r/5ee1db09b60373a15890f6a7c835d00e76bf601d.1535682461.git.ernesto.mnd.fernandez@gmail.com
Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/brec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index d3f36982f6858..0f53a486d2c18 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -448,6 +448,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			/* restore search_key */
 			hfs_bnode_read_key(node, fd->search_key, 14);
 		}
+		new_node = NULL;
 	}
 
 	if (!rec && node->parent)
-- 
2.20.1



