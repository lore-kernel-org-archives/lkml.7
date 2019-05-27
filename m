Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFC6C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6C120665
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfE0PmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:42:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17582 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbfE0PmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:42:15 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8D3B2B8DE12E89E191CE;
        Mon, 27 May 2019 23:42:06 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 27 May 2019
 23:41:57 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alexander.shishkin@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] intel_th: msu: Remove set but not used variable 'last'
Date:   Mon, 27 May 2019 23:41:28 +0800
Message-ID: <20190527154128.22328-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/hwtracing/intel_th/msu.c: In function msc_win_switch:
drivers/hwtracing/intel_th/msu.c:1389:21: warning: variable last set but not used [-Wunused-but-set-variable]

It is never used since introduction in commit
aad14ad3cf3a ("intel_th: msu: Add current window tracking")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/hwtracing/intel_th/msu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 81bb54fa3ce8..33072ca5fc4d 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1386,10 +1386,9 @@ static int intel_th_msc_init(struct msc *msc)
 
 static void msc_win_switch(struct msc *msc)
 {
-	struct msc_window *last, *first;
+	struct msc_window *first;
 
 	first = list_first_entry(&msc->win_list, struct msc_window, entry);
-	last = list_last_entry(&msc->win_list, struct msc_window, entry);
 
 	if (msc_is_last_win(msc->cur_win))
 		msc->cur_win = first;
-- 
2.17.1


