Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB36C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7958218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfGEJJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:09:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727503AbfGEJJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:09:15 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CEC26CCE59887E7B56B8;
        Fri,  5 Jul 2019 17:09:12 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 5 Jul 2019
 17:09:02 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <john.stultz@linaro.org>, <tglx@linutronix.de>, <sboyd@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH] time: compat settimeofday: Validate the values of tv from user
Date:   Fri, 5 Jul 2019 17:14:48 +0800
Message-ID: <1562318088-37669-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 6ada1fc0e1c4
("time: settimeofday: Validate the values of tv from user"),
an unvalidated user input is multiplied by a constant, which can result
in an undefined behaviour for large values. While this is validated
later, we should avoid triggering undefined behaviour.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 kernel/time/time.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 7f7d691..5c54ca6 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -251,6 +251,10 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
 	if (tv) {
 		if (compat_get_timeval(&user_tv, tv))
 			return -EFAULT;
+
+		if (!timeval_valid(&user_tv))
+			return -EINVAL;
+
 		new_ts.tv_sec = user_tv.tv_sec;
 		new_ts.tv_nsec = user_tv.tv_usec * NSEC_PER_USEC;
 	}
--
2.7.4

