Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18FBC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B169421843
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919691;
	bh=99+ozqhw15jcn46i8tnsS5mRIbqSjBnEL4IOQNmNxSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B1FPsm8gfDrkCaKXBV/cGojvI82mRYXD0511S1R6PIUqb6P/55C+5FcaPu1jq6gxH
	 GPEwyAGNvSAuwqB32cpcMk3m31tkiORpVZamIInis/UQf0gYio5ySbLxUyCidKsSM1
	 mItJLP4PDSiAqp+QdtXHdlVSmg3i130hgzjJOeG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbfKPPyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:54:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbfKPPyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:54:45 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF0B021844;
        Sat, 16 Nov 2019 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919684;
        bh=99+ozqhw15jcn46i8tnsS5mRIbqSjBnEL4IOQNmNxSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f16t7rGe5YDPOxH9LaGmi6DJT+xeFjKNAWMY37OeyXT+BR/spsmRuEN27VQEKLVbv
         EuSNT/2ejx1I6WyWHkcQvcHMVravGVpME0+9YKpSYm+tDexzoi7T/hlUoIfegg9Had
         wLcBWCSFFTYnUoUntv6l9tU3uV9NQnI4mQm/Ek7k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 46/77] hfsplus: fix BUG on bnode parent update
Date:   Sat, 16 Nov 2019 10:53:08 -0500
Message-Id: <20191116155339.11909-46-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155339.11909-1-sashal@kernel.org>
References: <20191116155339.11909-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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

