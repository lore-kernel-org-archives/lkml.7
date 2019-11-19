Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89199C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDCC21823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141367;
	bh=hRy+MxDLZVv/UkdR00foaWGPcN5I0PYFblmkSiDxReA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jb2HWvXxzali6HfyxHmq9cvYna5DT63MApLvnfHp8GGmVQzhJW0G3zXZqg5HOKyRy
	 gCflYrRfLxsD0OUPloqLEMFlUX1NQru2xSe/FuphOJKZ6qwu5vrOooC1zFX2HujVmn
	 CDugucGr97cOx6z0entp4ivWR96JV9VaHNt+xdgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfKSF3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:29:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728251AbfKSF3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:29:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 557C921939;
        Tue, 19 Nov 2019 05:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141359;
        bh=hRy+MxDLZVv/UkdR00foaWGPcN5I0PYFblmkSiDxReA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dx1PWXkDDmIp1gckSFPvZinDUcP56lEU9vqQMs0Nna+llzjOKT8p48IMNkLkSV7si
         Q+pyRdYEdipPQvSIpmovfLnOqBLz4wkXlAUcUY3F6SCYXYyqa46krAfSv2LRq4PWmG
         KZS3dNvZjBZpEW08r0TCkK0Zix79+iB3WrZSBc70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 133/422] udf: Fix crash during mount
Date:   Tue, 19 Nov 2019 06:15:30 +0100
Message-Id: <20191119051407.485249774@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

[ Upstream commit b085fbe2ef7fa7489903c45271ae7b7a52b0f9ab ]

Fix a crash during an attempt to mount a filesystem that has both
Unallocated Space Table and Unallocated Space Bitmap. Such filesystem
actually violates the UDF standard so we just have to properly detect
such situation and refuse to mount such filesystem read-write. When we
are at it, verify also other constraints on the allocation information
mandated by the standard.

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/super.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 5 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index c495db7165aee..7af011dc9ae8a 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -989,12 +989,62 @@ static struct udf_bitmap *udf_sb_alloc_bitmap(struct super_block *sb, u32 index)
 	return bitmap;
 }
 
+static int check_partition_desc(struct super_block *sb,
+				struct partitionDesc *p,
+				struct udf_part_map *map)
+{
+	bool umap, utable, fmap, ftable;
+	struct partitionHeaderDesc *phd;
+
+	switch (le32_to_cpu(p->accessType)) {
+	case PD_ACCESS_TYPE_READ_ONLY:
+	case PD_ACCESS_TYPE_WRITE_ONCE:
+	case PD_ACCESS_TYPE_REWRITABLE:
+	case PD_ACCESS_TYPE_NONE:
+		goto force_ro;
+	}
+
+	/* No Partition Header Descriptor? */
+	if (strcmp(p->partitionContents.ident, PD_PARTITION_CONTENTS_NSR02) &&
+	    strcmp(p->partitionContents.ident, PD_PARTITION_CONTENTS_NSR03))
+		goto force_ro;
+
+	phd = (struct partitionHeaderDesc *)p->partitionContentsUse;
+	utable = phd->unallocSpaceTable.extLength;
+	umap = phd->unallocSpaceBitmap.extLength;
+	ftable = phd->freedSpaceTable.extLength;
+	fmap = phd->freedSpaceBitmap.extLength;
+
+	/* No allocation info? */
+	if (!utable && !umap && !ftable && !fmap)
+		goto force_ro;
+
+	/* We don't support blocks that require erasing before overwrite */
+	if (ftable || fmap)
+		goto force_ro;
+	/* UDF 2.60: 2.3.3 - no mixing of tables & bitmaps, no VAT. */
+	if (utable && umap)
+		goto force_ro;
+
+	if (map->s_partition_type == UDF_VIRTUAL_MAP15 ||
+	    map->s_partition_type == UDF_VIRTUAL_MAP20)
+		goto force_ro;
+
+	return 0;
+force_ro:
+	if (!sb_rdonly(sb))
+		return -EACCES;
+	UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
+	return 0;
+}
+
 static int udf_fill_partdesc_info(struct super_block *sb,
 		struct partitionDesc *p, int p_index)
 {
 	struct udf_part_map *map;
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct partitionHeaderDesc *phd;
+	int err;
 
 	map = &sbi->s_partmaps[p_index];
 
@@ -1014,8 +1064,16 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 		  p_index, map->s_partition_type,
 		  map->s_partition_root, map->s_partition_len);
 
-	if (strcmp(p->partitionContents.ident, PD_PARTITION_CONTENTS_NSR02) &&
-	    strcmp(p->partitionContents.ident, PD_PARTITION_CONTENTS_NSR03))
+	err = check_partition_desc(sb, p, map);
+	if (err)
+		return err;
+
+	/*
+	 * Skip loading allocation info it we cannot ever write to the fs.
+	 * This is a correctness thing as we may have decided to force ro mount
+	 * to avoid allocation info we don't support.
+	 */
+	if (UDF_QUERY_FLAG(sb, UDF_FLAG_RW_INCOMPAT))
 		return 0;
 
 	phd = (struct partitionHeaderDesc *)p->partitionContentsUse;
@@ -1051,9 +1109,6 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 			  p_index, bitmap->s_extPosition);
 	}
 
-	if (phd->partitionIntegrityTable.extLength)
-		udf_debug("partitionIntegrityTable (part %d)\n", p_index);
-
 	if (phd->freedSpaceTable.extLength) {
 		struct kernel_lb_addr loc = {
 			.logicalBlockNum = le32_to_cpu(
-- 
2.20.1



