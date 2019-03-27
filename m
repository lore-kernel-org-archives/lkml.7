Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284ADC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C0E205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712739;
	bh=FYMtKjHmBTqNTrOMBJX7ZRwd93MDXAZLnKlWJmMW6XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OeMV3oPeU0GBMOpG0/Qp57vauIdMwz1c8CsfPqkV7izr3FIQHnj16h/7EYihJJQ6b
	 2fMXzogLAXV1LRPROA9fZvL0t/59Bwwx/jgPjjrKsKPR5QAd00ApmOOU2khfUmT4pk
	 TtxbQoiJHfhkyYovQv0fa4vN5FObmQPA8K/V9ytI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390729AbfC0SwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390371AbfC0SRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:17:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B1922087C;
        Wed, 27 Mar 2019 18:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710668;
        bh=FYMtKjHmBTqNTrOMBJX7ZRwd93MDXAZLnKlWJmMW6XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMQW32wZXlSTJnoXokTRBFT5XebEhFwMVBesF0mTRJqEYDCfuuek/f0fVvV+Rg7Nk
         hNnTLZiTN8GbU4mVdaGQMewLqK+BmOC1QVEn+BudrvLaWfhBGY8YZrF3nCrt1C0KmZ
         DZFkFfU1YGHfwi4yaSX7cKJZbyW67ShnWlG7coN8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.14 042/123] iommu/io-pgtable-arm-v7s: Only kmemleak_ignore L2 tables
Date:   Wed, 27 Mar 2019 14:15:06 -0400
Message-Id: <20190327181628.15899-42-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Boichat <drinkcat@chromium.org>

[ Upstream commit 032ebd8548c9d05e8d2bdc7a7ec2fe29454b0ad0 ]

L1 tables are allocated with __get_dma_pages, and therefore already
ignored by kmemleak.

Without this, the kernel would print this error message on boot,
when the first L1 table is allocated:

[    2.810533] kmemleak: Trying to color unknown object at 0xffffffd652388000 as Black
[    2.818190] CPU: 5 PID: 39 Comm: kworker/5:0 Tainted: G S                4.19.16 #8
[    2.831227] Workqueue: events deferred_probe_work_func
[    2.836353] Call trace:
...
[    2.852532]  paint_ptr+0xa0/0xa8
[    2.855750]  kmemleak_ignore+0x38/0x6c
[    2.859490]  __arm_v7s_alloc_table+0x168/0x1f4
[    2.863922]  arm_v7s_alloc_pgtable+0x114/0x17c
[    2.868354]  alloc_io_pgtable_ops+0x3c/0x78
...

Fixes: e5fc9753b1a8314 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 29b7a6755fcd..56368c8bd791 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -217,7 +217,8 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 		if (dma != phys)
 			goto out_unmap;
 	}
-	kmemleak_ignore(table);
+	if (lvl == 2)
+		kmemleak_ignore(table);
 	return table;
 
 out_unmap:
-- 
2.19.1

