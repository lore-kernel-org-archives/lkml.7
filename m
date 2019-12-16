Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0612DC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C712F2176D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522079;
	bh=O30rzoEFJ/04RocXkCd7ju8nhtYDtCID0jSDf58ZXz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jglbSO5P7Ch5GRfbMGhPaF3gPzsEVezcrI1KVI3laYkHuI+pgVwUf/YTLjqBfRhUp
	 YZl4DRvg8ydoI01TwTJLMk8HTeuLeMA7veOosZBfCpPsIn2vh/NMWFi1Deo8rUcBOB
	 gmf8UN2zeYZ1OvqHGNcS+RtqtRokukjduEeMUqo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLPRyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:54:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:50736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727934AbfLPRye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:54:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B81412053B;
        Mon, 16 Dec 2019 17:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518874;
        bh=O30rzoEFJ/04RocXkCd7ju8nhtYDtCID0jSDf58ZXz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MgmAiyeVOxhY/YtlK772sLpvHhixsEhxbUM+i32ZcoYI1fPcSooiJnTQdHw0Z5a2h
         44ky4XBrjhvuHNj6QZZWGkPXcpj/jHljiqGvWsKJXM+bRBlh7I9URZFm2CAQ0tYLdD
         8FIfQmDoqqlkmGCvzg9+FAumlQiGxGi8Xsmp1xgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunlong Song <yunlong.song@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 065/267] f2fs: fix count of seg_freed to make sec_freed correct
Date:   Mon, 16 Dec 2019 18:46:31 +0100
Message-Id: <20191216174855.973564665@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunlong Song <yunlong.song@huawei.com>

[ Upstream commit d6c66cd19ef322fe0d51ba09ce1b7f386acab04a ]

When sbi->segs_per_sec > 1, and if some segno has 0 valid blocks before
gc starts, do_garbage_collect will skip counting seg_freed++, and this
will cause seg_freed < sbi->segs_per_sec and finally skip sec_freed++.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 67120181dc2af..9865f6d52fe48 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -952,9 +952,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					GET_SUM_BLOCK(sbi, segno));
 		f2fs_put_page(sum_page, 0);
 
-		if (get_valid_blocks(sbi, segno, false) == 0 ||
-				!PageUptodate(sum_page) ||
-				unlikely(f2fs_cp_error(sbi)))
+		if (get_valid_blocks(sbi, segno, false) == 0)
+			goto freed;
+		if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi)))
 			goto next;
 
 		sum = page_address(sum_page);
@@ -981,6 +981,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 
 		stat_inc_seg_count(sbi, type, gc_type);
 
+freed:
 		if (gc_type == FG_GC &&
 				get_valid_blocks(sbi, segno, false) == 0)
 			seg_freed++;
-- 
2.20.1



