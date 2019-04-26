Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E12EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073DB20679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfDZQqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:46:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41010 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbfDZQqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:46:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4814E7A4F517A71618B6;
        Sat, 27 Apr 2019 00:46:41 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sat, 27 Apr 2019
 00:46:34 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <geert+renesas@glider.be>,
        <rostedt@goodmis.org>, <me@tobin.cc>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] lib/vsprintf: Make function pointer_string static
Date:   Sat, 27 Apr 2019 00:46:30 +0800
Message-ID: <20190426164630.22104-1-yuehaibing@huawei.com>
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

Fix sparse warning:

lib/vsprintf.c:673:6: warning:
 symbol 'pointer_string' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 lib/vsprintf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 1f367f3..7b0a614 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -670,8 +670,9 @@ char *string(char *buf, char *end, const char *s,
 	return string_nocheck(buf, end, s, spec);
 }
 
-char *pointer_string(char *buf, char *end, const void *ptr,
-		     struct printf_spec spec)
+static char *pointer_string(char *buf, char *end,
+			    const void *ptr,
+			    struct printf_spec spec)
 {
 	spec.base = 16;
 	spec.flags |= SMALL;
-- 
2.7.4


