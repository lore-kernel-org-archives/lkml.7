Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF15C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33B1218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117604;
	bh=k6s6SPrZ+cpDv9wyl8UcPCxG02ovHVKjVxP7dVfr3pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DUR35VvfpyvtBTM5+Xr3iCgHZtg3U2JhOR1zAipECCuSSHG5qzuCc5cSKe0ekqWs7
	 m3Eb6LJDdw4/759oEps+IdF1YcAL1kmuSFokoMojfKyDX9X+dZwrwDNY6fks75E4iE
	 vnbCP/FVhvtNRHZEKkGfEUVvubMVDJ4s2G0dlUFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbfDXOxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730765AbfDXOxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:53:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4342B21903;
        Wed, 24 Apr 2019 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117599;
        bh=k6s6SPrZ+cpDv9wyl8UcPCxG02ovHVKjVxP7dVfr3pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cah+1d0+oBMT1MwF7EOoiTyWCDDrxcBJ88Wgea5vDTRKLRDapucTephYVNeRC0u5f
         zPdS5xOHjsQ3YsjfjEQXVzDqJVPmJiYJOBJUHUyfzqP5pSroeoRjgRURSzQ225CcWJ
         ZW8wUhTnbaf2JmnGeCODoKTjK5snkiKlxWoHIIzA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org
Subject: [PATCH AUTOSEL 3.18 07/10] hugetlbfs: fix memory leak for resv_map
Date:   Wed, 24 Apr 2019 10:52:56 -0400
Message-Id: <20190424145259.31639-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145259.31639-1-sashal@kernel.org>
References: <20190424145259.31639-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Kravetz <mike.kravetz@oracle.com>

[ Upstream commit 58b6e5e8f1addd44583d61b0a03c0f5519527e35 ]

When mknod is used to create a block special file in hugetlbfs, it will
allocate an inode and kmalloc a 'struct resv_map' via resv_map_alloc().
inode->i_mapping->private_data will point the newly allocated resv_map.
However, when the device special file is opened bd_acquire() will set
inode->i_mapping to bd_inode->i_mapping.  Thus the pointer to the
allocated resv_map is lost and the structure is leaked.

Programs to reproduce:
        mount -t hugetlbfs nodev hugetlbfs
        mknod hugetlbfs/dev b 0 0
        exec 30<> hugetlbfs/dev
        umount hugetlbfs/

resv_map structures are only needed for inodes which can have associated
page allocations.  To fix the leak, only allocate resv_map for those
inodes which could possibly be associated with page allocations.

Link: http://lkml.kernel.org/r/20190401213101.16476-1-mike.kravetz@oracle.com
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Yufen Yu <yuyufen@huawei.com>
Suggested-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hugetlbfs/inode.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index ec1ed7e4b8f3..c3a03f5a1b49 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -484,11 +484,17 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 					umode_t mode, dev_t dev)
 {
 	struct inode *inode;
-	struct resv_map *resv_map;
+	struct resv_map *resv_map = NULL;
 
-	resv_map = resv_map_alloc();
-	if (!resv_map)
-		return NULL;
+	/*
+	 * Reserve maps are only needed for inodes that can have associated
+	 * page allocations.
+	 */
+	if (S_ISREG(mode) || S_ISLNK(mode)) {
+		resv_map = resv_map_alloc();
+		if (!resv_map)
+			return NULL;
+	}
 
 	inode = new_inode(sb);
 	if (inode) {
@@ -530,8 +536,10 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 			break;
 		}
 		lockdep_annotate_inode_mutex_key(inode);
-	} else
-		kref_put(&resv_map->refs, resv_map_release);
+	} else {
+		if (resv_map)
+			kref_put(&resv_map->refs, resv_map_release);
+	}
 
 	return inode;
 }
-- 
2.19.1

