Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C87C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F39206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 01:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbfG3BqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 21:46:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730676AbfG3BqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:46:02 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 827B250DC70000F6DD4F;
        Tue, 30 Jul 2019 09:46:00 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 30 Jul 2019
 09:45:50 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bcrl@kvack.org>, <viro@zeniv.linux.org.uk>, <jmoyer@redhat.com>,
        <arnd@arndb.de>, <deepa.kernel@gmail.com>, <yi.zhang@huawei.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] aio: add timeout validity check for io_[p]getevents
Date:   Tue, 30 Jul 2019 09:51:44 +0800
Message-ID: <1564451504-27906-1-git-send-email-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

io_[p]getevents syscall should return -EINVAL if timeout is out of
range, add this validity check.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
---
Changes since v1:
 - add Reviewed-by and Cc tags.

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

