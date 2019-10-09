Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80C9ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AE4218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570655945;
	bh=6PP4aKyyuQeM0TuR08lc0FC+7l1l5FBRpKDaHNYM5XM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G7UWga5uESf/LfsMlvXy+98cIFoj0c8nEevmS5CxFJkJE1KbLWWXjmGkJyZik3P8Q
	 yOxrlzBpJdRy1VtT8blMeIPHuedwB4Kww1IQw05rIMzzNcoqxixo7BG5y4rLZHpV9a
	 VM9b/U2AFFWpR/kAE57nRI9SELwoVYAkLYq1kRLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfJIVTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 17:19:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41264 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfJIVTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 17:19:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id q7so2439297pfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIVzU+Q0uxcUt161uhYqfP3XsKR01P4YLhVu2FbVi3E=;
        b=IElwFySMYED1EECdhFj/UA9KqWeh68mdepLNVjqkB46MCKh7Vd0WHdQAc2HutK0/dn
         obYW+/5aA9BKVEeV63+7iBt07fKD/fIDojpUJWViLx7pYzR5BGz2g+beTgqBOCnVGs4x
         XKpKEkss0J+rprIl48Z9vUecQXatM2HGbIQi9mhwdsUPMZ+iqSwbIRmvshmkHCFHQ4iM
         P0WjQMcNRZVOYcNvp/HaYzE8VzGnbZEkOnge57htd+rG06/SHm88gyb0OcvWorQn2p+a
         MknWchyQFTctfA33GuFlgty0SenHEUEd6DWkBu+t6fJFq34XDxkyQySNjXRe6dC3GBp5
         pfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=yIVzU+Q0uxcUt161uhYqfP3XsKR01P4YLhVu2FbVi3E=;
        b=kiOaVdeKRPhOp0J0JZtCMIIQK8/arSTvQhp5DfWSQITww+t3V8ckXKBzSFwXRyiO7x
         qknDz5melm6s53eBIvvxWFJTVmtHt6GRcDO8RsbfzvTAgEf9bWITF7UbdCPJXOxoo1am
         UeEtVumvceJ4M/+yBe/kgSLMtD7ZEGadtelMWh600yTgZiCYMgM3sYtVR6jwu6NKFIvJ
         1S2IBKzFuEKqCbzUof844YPwLWnN8phnwvlrWABcdTjnIMx7RYmZzlVZ1fbY5tJ4lSEH
         KEq8OI4A1UW/cZfTUuqSgyAWoqwyWe9BItK990OpQ0/Dj4mbKZiTHsLwGRZZ/7u1YQ81
         PZcg==
X-Gm-Message-State: APjAAAXj7VHV22AVCx28csf4WbLVsJ3lvHPTEfwW5AmsnOCtPfQeEAHl
        2P+C/N9zV/vFBydLE3mZDiA=
X-Google-Smtp-Source: APXvYqw2sNXhHHFIyhGh+CGGz179BRZrGUzG1ZAnoUqCoueTnKRiqdz3ZodwQmvEnqnXzp/uG3No6g==
X-Received: by 2002:a63:a35f:: with SMTP id v31mr6539319pgn.51.1570655941446;
        Wed, 09 Oct 2019 14:19:01 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id e14sm2610659pjt.8.2019.10.09.14.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 14:19:00 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Minchan Kim <minchan@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH] fs: annotate refault stalls from bdev_read_page
Date:   Wed,  9 Oct 2019 14:18:57 -0700
Message-Id: <20191009211857.35587-1-minchan@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minchan Kim <minchan@google.com>

If block device supports rw_page operation, it doesn't submit bio
so annotation in submit_bio for refault stall doesn't work.
It happens with zram in android, especially swap read path which
could consume CPU cycle for decompress.

Annotate bdev_read_page() to account the synchronous IO overhead
to prevent underreport memory pressure.

Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Minchan Kim <minchan@google.com>
---
 fs/block_dev.c | 13 +++++++++++++
 mm/memory.c    |  1 +
 2 files changed, 14 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9c073dbdc1b0..82ca28eb9a57 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -26,6 +26,7 @@
 #include <linux/writeback.h>
 #include <linux/mpage.h>
 #include <linux/mount.h>
+#include <linux/psi.h>
 #include <linux/pseudo_fs.h>
 #include <linux/uio.h>
 #include <linux/namei.h>
@@ -701,6 +702,8 @@ int bdev_read_page(struct block_device *bdev, sector_t sector,
 {
 	const struct block_device_operations *ops = bdev->bd_disk->fops;
 	int result = -EOPNOTSUPP;
+	unsigned long pflags;
+	bool workingset_read;
 
 	if (!ops->rw_page || bdev_get_integrity(bdev))
 		return result;
@@ -708,9 +711,19 @@ int bdev_read_page(struct block_device *bdev, sector_t sector,
 	result = blk_queue_enter(bdev->bd_queue, 0);
 	if (result)
 		return result;
+
+	workingset_read = PageWorkingset(page);
+	if (workingset_read)
+		psi_memstall_enter(&pflags);
+
 	result = ops->rw_page(bdev, sector + get_start_sect(bdev), page,
 			      REQ_OP_READ);
+
+	if (workingset_read)
+		psi_memstall_leave(&pflags);
+
 	blk_queue_exit(bdev->bd_queue);
+
 	return result;
 }
 EXPORT_SYMBOL_GPL(bdev_read_page);
diff --git a/mm/memory.c b/mm/memory.c
index 06935826d71e..6357d5a0a2a5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2801,6 +2801,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			if (page) {
 				__SetPageLocked(page);
 				__SetPageSwapBacked(page);
+				SetPageWorkingset(page);
 				set_page_private(page, entry.val);
 				lru_cache_add_anon(page);
 				swap_readpage(page, true);
-- 
2.23.0.581.g78d2f28ef7-goog

