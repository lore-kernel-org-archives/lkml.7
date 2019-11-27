Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6A9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F1020869
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574891100;
	bh=99+ozqhw15jcn46i8tnsS5mRIbqSjBnEL4IOQNmNxSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BJ3QjgIX7tdPDRHMzdRtb0Va1wKyleCYfDbRykPC6jrdG5e0iDnfSXvDVbImLIQp0
	 FgfSJVpG0gG9Y0G7cYt4je7SXGSCx48wdFh19KZrRyPWo9cjuZrnPaGh3caQNibWD/
	 Nhy3P/t+UZE1PXlQopigizd1NL+X6YTR1UBH7x20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfK0Vo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:44:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbfK0UgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:36:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99CBD20862;
        Wed, 27 Nov 2019 20:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574886984;
        bh=99+ozqhw15jcn46i8tnsS5mRIbqSjBnEL4IOQNmNxSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t884y0xNTUumBiBVYJPnjQrOR+7ceF5Dj10sNkMnVfxPLtx0YjlfJehhrq8WehWvk
         dQx571YnIDTz+4+8aH8UNKHScuJsE8AFDp7Fs8gR1OrPWkOGdNgoF1nT93pWmPnIyU
         A1LGOUc+iLc4YeBVw5mFpU4HEEBAhJVA8EfSUHxQ=
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
Subject: [PATCH 4.4 066/132] hfsplus: fix BUG on bnode parent update
Date:   Wed, 27 Nov 2019 21:30:57 +0100
Message-Id: <20191127203002.676708703@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
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
index 1002a0c08319b..20ce698251ad1 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -447,6 +447,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			/* restore search_key */
 			hfs_bnode_read_key(node, fd->search_key, 14);
 		}
+		new_node = NULL;
 	}
 
 	if (!rec && node->parent)
-- 
2.20.1



