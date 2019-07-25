Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C86C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C3520840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387795AbfGYHPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:15:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53990 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfGYHPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:15:48 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 72718E9FBD22B4E19D65;
        Thu, 25 Jul 2019 15:15:45 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 25 Jul 2019
 15:15:36 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bcrl@kvack.org>, <viro@zeniv.linux.org.uk>, <yi.zhang@huawei.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH] aio: add timeout validity check for io_[p]getevents
Date:   Thu, 25 Jul 2019 15:21:29 +0800
Message-ID: <1564039289-7672-1-git-send-email-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

io_[p]getevents syscall should return -EINVAL if if timeout is out of
range, add this validity check.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/aio.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 01e0fb9..dd967a0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2031,10 +2031,17 @@ static long do_io_getevents(aio_context_t ctx_id,
 		struct io_event __user *events,
 		struct timespec64 *ts)
 {
-	ktime_t until = ts ? timespec64_to_ktime(*ts) : KTIME_MAX;
-	struct kioctx *ioctx = lookup_ioctx(ctx_id);
+	ktime_t until = KTIME_MAX;
+	struct kioctx *ioctx = NULL;
 	long ret = -EINVAL;
 
+	if (ts) {
+		if (!timespec64_valid(ts))
+			return ret;
+		until = timespec64_to_ktime(*ts);
+	}
+
+	ioctx = lookup_ioctx(ctx_id);
 	if (likely(ioctx)) {
 		if (likely(min_nr <= nr && min_nr >= 0))
 			ret = read_events(ioctx, min_nr, nr, events, until);
-- 
2.7.4

