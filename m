Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD61DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F4D20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfCFNAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:00:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729159AbfCFNAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:00:49 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8B13AF70B9D72C52A802;
        Wed,  6 Mar 2019 21:00:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Wed, 6 Mar 2019 21:00:36 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <tglx@linutronix.de>, <edumazet@google.com>,
        <linux-kernel@vger.kernel.org>, <yaohongbo@huawei.com>
Subject: [RFC PATCH 1/2] ktime: add ktime_sub_safe() to avoid undefined behaviour
Date:   Wed, 6 Mar 2019 21:13:25 +0800
Message-ID: <20190306131326.10275-2-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306131326.10275-1-yaohongbo@huawei.com>
References: <20190306131326.10275-1-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add a new ktime_sub_unsafe() helper which won't throw a
UBSAN warning when it does overflows, and then it add ktime_sub_safe()
which will check if the result of ktime_sub_unsafe overflows.This patch
modify the above functions to use ktime_sub_safe instead of ktime_sub();

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 include/linux/ktime.h |  8 ++++++++
 kernel/time/hrtimer.c | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index b2bb44f87f5a..325e794b0dd1 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -45,6 +45,12 @@ static inline ktime_t ktime_set(const s64 secs, const unsigned long nsecs)
 /* Subtract two ktime_t variables. rem = lhs -rhs: */
 #define ktime_sub(lhs, rhs)	((lhs) - (rhs))
 
+/*
+ * Same as ktime_sub(), but avoids undefined behaviour on overflow; however,
+ * this means that you must check the result for overflow yourself.
+ */
+#define ktime_sub_unsafe(lhs, rhs)      ((u64) (lhs) - (rhs))
+
 /* Add two ktime_t variables. res = lhs + rhs: */
 #define ktime_add(lhs, rhs)	((lhs) + (rhs))
 
@@ -215,6 +221,8 @@ static inline ktime_t ktime_sub_ms(const ktime_t kt, const u64 msec)
 
 extern ktime_t ktime_add_safe(const ktime_t lhs, const ktime_t rhs);
 
+extern ktime_t ktime_sub_safe(const ktime_t lhs, const ktime_t rhs);
+
 /**
  * ktime_to_timespec_cond - convert a ktime_t variable to timespec
  *			    format only if the variable contains data
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e1a549c9e399..cadc5bcbfc9e 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -317,6 +317,22 @@ s64 __ktime_divns(const ktime_t kt, s64 div)
 EXPORT_SYMBOL_GPL(__ktime_divns);
 #endif /* BITS_PER_LONG >= 64 */
 
+/*
+ * sub two ktime values and do a safety check for overflow:
+ */
+ktime_t ktime_sub_safe(const ktime_t lhs, const ktime_t rhs)
+{
+	ktime_t res = ktime_sub_unsafe(lhs, rhs);
+
+	if (lhs > 0 && rhs < 0 && res < 0)
+		res = ktime_set(KTIME_SEC_MAX, 0);
+	else if (lhs < 0 && rhs > 0 && res > 0)
+		res = ktime_set(-KTIME_SEC_MAX, 0);
+
+	return res;
+}
+EXPORT_SYMBOL_GPL(ktime_sub_safe);
+
 /*
  * Add two ktime values and do a safety check for overflow:
  */
-- 
2.20.1

