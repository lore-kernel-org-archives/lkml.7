Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0912C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1F9222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576852356;
	bh=3gwg+3s135YkjMS6ArKsWvNUOZm+NDSmiy1a8biK980=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TDEEVHnEDoaalcyV2ne+4LMDrPVpOlfQaUuFpXdoel7qO9QA1lYiCiHJ498Icfoc7
	 iFt9z/5YGThxuYLq5/BsXve3s4qzIKSNEppRQbVlZ8Hfl61L/yU2dLu7o0DMNvMGg8
	 zbOqfQbdcWlqUX7l/kRirqXrets/xvpg/d3OJ0/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfLTOcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:32:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbfLTOay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:30:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D47A721D7E;
        Fri, 20 Dec 2019 14:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852253;
        bh=3gwg+3s135YkjMS6ArKsWvNUOZm+NDSmiy1a8biK980=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+mxDJDUAFq+LtPiZFBTuwfnN/3kPYWc52tZ6toTyryR2NPakRanGTG9GxGbhU8lf
         eciQWAzMgIuFCixxIDrNgKd593+QAwJcfUGzpG1Y2wXvy6YTAP9mWZbgjeu8tpP6Va
         LsglyUALbOKLCS9yorQZdB0mbeUnNPMQbMrjWm/k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 44/52] md: raid1: check rdev before reference in raid1_sync_request func
Date:   Fri, 20 Dec 2019 09:29:46 -0500
Message-Id: <20191220142954.9500-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142954.9500-1-sashal@kernel.org>
References: <20191220142954.9500-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

[ Upstream commit 028288df635f5a9addd48ac4677b720192747944 ]

In raid1_sync_request func, rdev should be checked before reference.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index bb29aeefcbd0f..c7137f50bd1d3 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2781,7 +2781,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
 				write_targets++;
 			}
 		}
-		if (bio->bi_end_io) {
+		if (rdev && bio->bi_end_io) {
 			atomic_inc(&rdev->nr_pending);
 			bio->bi_iter.bi_sector = sector_nr + rdev->data_offset;
 			bio_set_dev(bio, rdev->bdev);
-- 
2.20.1

