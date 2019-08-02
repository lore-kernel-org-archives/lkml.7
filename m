Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F68C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829D020679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738653;
	bh=GEH+uPofXaxBZWYuFfTZ7w7GMA0dFFwr7imYVc2tTAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wVF46mlFicnFC4JJrS6tn6lpWIAq7m6mKyxQb2+Y2QUuA86PcVF5zsAbgv1da64wv
	 Atx8EMwojipRy6rdLwrrd2+ablzOgdq/sebF5q8NolbRfIYBjSF8KjiUoY0UaXjqxd
	 PujctYCt7er7Of4Vd+w/4VSqr4UfeZLpw4L3n1sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404052AbfHBJfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:35:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403951AbfHBJfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:35:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C43F217D4;
        Fri,  2 Aug 2019 09:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738547;
        bh=GEH+uPofXaxBZWYuFfTZ7w7GMA0dFFwr7imYVc2tTAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stZB2COi7fQkfq5viOq0Atw1q+thgVZraacZMddMIgqb7eIfNclDryD2gMDDwkgfl
         niSNV4Ga5J9xrfPJzgxg42j4889xwZfX74yPreKJLGy3ks29Y58K27pHelcvQ3jXpB
         +TV0sQOZtoL/KUTaceyLRG6Z9Ls48S/oSroxI/30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ocean Chen <oceanchen@google.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 130/158] f2fs: avoid out-of-range memory access
Date:   Fri,  2 Aug 2019 11:29:11 +0200
Message-Id: <20190802092229.871546373@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 56f3ce675103e3fb9e631cfb4131fc768bc23e9a ]

blkoff_off might over 512 due to fs corrupt or security
vulnerability. That should be checked before being using.

Use ENTRIES_IN_SUM to protect invalid value in cur_data_blkoff.

Signed-off-by: Ocean Chen <oceanchen@google.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6802cd754eda..014bee5c0e75 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1510,6 +1510,11 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 		seg_i = CURSEG_I(sbi, i);
 		segno = le32_to_cpu(ckpt->cur_data_segno[i]);
 		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
+		if (blk_off > ENTRIES_IN_SUM) {
+			f2fs_bug_on(sbi, 1);
+			f2fs_put_page(page, 1);
+			return -EFAULT;
+		}
 		seg_i->next_segno = segno;
 		reset_curseg(sbi, i, 0);
 		seg_i->alloc_type = ckpt->alloc_type[i];
-- 
2.20.1



