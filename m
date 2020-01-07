Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9A6C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB322080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431698;
	bh=Zc4ApMctl6TyoWZtewkmG80a7vVNS+VEH44ujjNZKgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aJbqY7x6qOZ18sBolzMhYouC/SHn9+LBgGcx/NR9G2lJxtYEsTGKUOVUcOM4xxjYb
	 WnPkhjw+39+lf79zahNjToEgO5bIeJpRpd9plq83ft4wsxBLIlIXPSWk9GpOxv8byb
	 9Cqh5SJ9Tvk9X/TJM0XwkJsw3k2ssubdr3kQPY4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbgAGVO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:14:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729573AbgAGVIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:08:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4898420678;
        Tue,  7 Jan 2020 21:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431330;
        bh=Zc4ApMctl6TyoWZtewkmG80a7vVNS+VEH44ujjNZKgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dt5IwfPVjHxsHYWppzRGqUNKlgcxLPzObsqS4Co6IlB8ZOm3JotWhLH/f/OJO+ulQ
         fF8kC3Qt12l3lQmKL313CAAf/Q9ZjLwIlr0habe8OIlXHAG2TodkeAUo3Q6bLrcZey
         1BljmzJqXMXLe1KaZZQiNqZ9qbOeOs5ugco1TNHA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 13/74] md: raid1: check rdev before reference in raid1_sync_request func
Date:   Tue,  7 Jan 2020 21:54:38 +0100
Message-Id: <20200107205144.478287924@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205135.369001641@linuxfoundation.org>
References: <20200107205135.369001641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index f46ac9db9edb..0a9d623b13c2 100644
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



