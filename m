Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB00C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7888A206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfEDKax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 06:30:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7721 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727424AbfEDKat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:30:49 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0AED3270C2C608783DE6;
        Sat,  4 May 2019 18:30:47 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sat, 4 May 2019
 18:30:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <agk@redhat.com>, <snitzer@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <dm-devel@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] dm dust: Make dm_dust_init and dm_dust_exit static
Date:   Sat, 4 May 2019 18:30:36 +0800
Message-ID: <20190504103036.34436-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/md/dm-dust.c:495:12: warning: symbol 'dm_dust_init' was not declared. Should it be static?
drivers/md/dm-dust.c:505:13: warning: symbol 'dm_dust_exit' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/md/dm-dust.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-dust.c b/drivers/md/dm-dust.c
index 178587b..3d42e40 100644
--- a/drivers/md/dm-dust.c
+++ b/drivers/md/dm-dust.c
@@ -492,7 +492,7 @@ static struct target_type dust_target = {
 	.prepare_ioctl = dust_prepare_ioctl,
 };
 
-int __init dm_dust_init(void)
+static int __init dm_dust_init(void)
 {
 	int result = dm_register_target(&dust_target);
 
@@ -502,7 +502,7 @@ int __init dm_dust_init(void)
 	return result;
 }
 
-void __exit dm_dust_exit(void)
+static void __exit dm_dust_exit(void)
 {
 	dm_unregister_target(&dust_target);
 }
-- 
2.7.4


