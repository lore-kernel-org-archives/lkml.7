Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3AAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17281218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfCVOQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:16:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727719AbfCVOQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:16:51 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9181E1318E345DECD17A;
        Fri, 22 Mar 2019 22:16:49 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Mar 2019
 22:16:40 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <agk@redhat.com>, <snitzer@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <dm-devel@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] dm integrity: Make dm_integrity_init and dm_integrity_exit static
Date:   Fri, 22 Mar 2019 22:16:34 +0800
Message-ID: <20190322141634.20664-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

drivers/md/dm-integrity.c:3619:12: warning:
 symbol 'dm_integrity_init' was not declared. Should it be static?
drivers/md/dm-integrity.c:3638:6: warning:
 symbol 'dm_integrity_exit' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/md/dm-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index d57d997..0932c32 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3616,7 +3616,7 @@ static struct target_type integrity_target = {
 	.io_hints		= dm_integrity_io_hints,
 };
 
-int __init dm_integrity_init(void)
+static int __init dm_integrity_init(void)
 {
 	int r;
 
@@ -3635,7 +3635,7 @@ int __init dm_integrity_init(void)
 	return r;
 }
 
-void dm_integrity_exit(void)
+static void dm_integrity_exit(void)
 {
 	dm_unregister_target(&integrity_target);
 	kmem_cache_destroy(journal_io_cache);
-- 
2.7.0


