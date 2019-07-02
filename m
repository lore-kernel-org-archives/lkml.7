Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71573C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4586F2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGBGTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 02:19:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfGBGTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:19:05 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C16D8DE93E71B9707C08
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2019 14:19:01 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 14:18:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tglx@linutronix.de>, <ferdinand.blomqvist@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] rslib: Make some functions static
Date:   Tue, 2 Jul 2019 14:18:47 +0800
Message-ID: <20190702061847.26060-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

lib/reed_solomon/test_rslib.c:313:5: warning: symbol 'ex_rs_helper' was not declared. Should it be static?
lib/reed_solomon/test_rslib.c:349:5: warning: symbol 'exercise_rs' was not declared. Should it be static?
lib/reed_solomon/test_rslib.c:407:5: warning: symbol 'exercise_rs_bc' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 lib/reed_solomon/test_rslib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index eb62e03..4eb29f3 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -310,8 +310,8 @@ static void test_uc(struct rs_control *rs, int len, int errs,
 	stat->nwords += trials;
 }
 
-int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
-		int len, int trials, int method)
+static int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
+			int len, int trials, int method)
 {
 	static const char * const desc[] = {
 		"Testing correction buffer interface...",
@@ -346,8 +346,8 @@ int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
 	return retval;
 }
 
-int exercise_rs(struct rs_control *rs, struct wspace *ws,
-		int len, int trials)
+static int exercise_rs(struct rs_control *rs, struct wspace *ws,
+		       int len, int trials)
 {
 
 	int retval = 0;
@@ -404,8 +404,8 @@ static void test_bc(struct rs_control *rs, int len, int errs,
 	stat->nwords += trials;
 }
 
-int exercise_rs_bc(struct rs_control *rs, struct wspace *ws,
-		int len, int trials)
+static int exercise_rs_bc(struct rs_control *rs, struct wspace *ws,
+			  int len, int trials)
 {
 	struct bcstat stat = {0, 0, 0, 0};
 	int nroots = rs->codec->nroots;
-- 
2.7.4


