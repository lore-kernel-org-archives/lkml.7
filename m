Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39589C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02846218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576852697;
	bh=UcV7Gb+OBxV6ZHwmz2TtZAk06MIKyAu8ifT5T6dHKFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AkD1PaHwrRd/CXot8DaZXl1u90mT8Q9FKyHx9f2YUhx0ssOqPpHCHrhS3rvLN3Hdr
	 mnhQd13Vom4u6ajRLLb6x4BN0E9AOWnc+TGYLduvum5DhCtTxGjprrYhzuainxhLsY
	 NrIZ0ap0HWPCFEXH1DYvlU+nrOMnm6ZH4VffFdQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfLTOiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:38:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:42122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbfLTOh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:37:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA1552468A;
        Fri, 20 Dec 2019 14:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852678;
        bh=UcV7Gb+OBxV6ZHwmz2TtZAk06MIKyAu8ifT5T6dHKFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QZnPrYJ37vo9lY11HNbMwzayLT+LansLnO+jxRufoX5bSCNhamQALjhgJnvgPA46E
         30wjVjLW9QOcOjpm5gwYqZmAWX49FvYax/+/LjnHqMhHqrxcK0E+HHVQfN1OJ5qH2a
         pne8Pe77dHirVwgCCPWEaYEbIzVkic+HFnsiht5g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 13/19] md: raid1: check rdev before reference in raid1_sync_request func
Date:   Fri, 20 Dec 2019 09:37:34 -0500
Message-Id: <20191220143741.10220-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220143741.10220-1-sashal@kernel.org>
References: <20191220143741.10220-1-sashal@kernel.org>
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
index f46ac9db9edb2..0a9d623b13c27 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2749,7 +2749,7 @@ static sector_t raid1_sync_request(struct mddev *mddev, sector_t sector_nr,
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

