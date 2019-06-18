Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3485C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C886B206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 10:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfFRKBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 06:01:17 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6937 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfFRKBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 06:01:16 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id D8C6C14A0692539BE311;
        Tue, 18 Jun 2019 18:01:14 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Jun 2019 18:01:11 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 18 Jun 2019 18:01:10 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: avoid get_valid_blocks() for cleanup
Date:   Tue, 18 Jun 2019 18:00:09 +0800
Message-ID: <20190618100009.20583-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme717-chm.china.huawei.com (10.1.199.113) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/sysfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index fa184880cff3..50f38054b648 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -582,8 +582,7 @@ static int __maybe_unused segment_info_seq_show(struct seq_file *seq,
 
 		if ((i % 10) == 0)
 			seq_printf(seq, "%-10d", i);
-		seq_printf(seq, "%d|%-3u", se->type,
-					get_valid_blocks(sbi, i, false));
+		seq_printf(seq, "%d|%-3u", se->type, se->valid_blocks);
 		if ((i % 10) == 9 || i == (total_segs - 1))
 			seq_putc(seq, '\n');
 		else
@@ -609,8 +608,7 @@ static int __maybe_unused segment_bits_seq_show(struct seq_file *seq,
 		struct seg_entry *se = get_seg_entry(sbi, i);
 
 		seq_printf(seq, "%-10d", i);
-		seq_printf(seq, "%d|%-3u|", se->type,
-					get_valid_blocks(sbi, i, false));
+		seq_printf(seq, "%d|%-3u|", se->type, se->valid_blocks);
 		for (j = 0; j < SIT_VBLOCK_MAP_SIZE; j++)
 			seq_printf(seq, " %.2x", se->cur_valid_map[j]);
 		seq_putc(seq, '\n');
-- 
2.18.0.rc1

