Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EDDC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5223D20651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbfGXCZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:25:03 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:50043 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726606AbfGXCZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:25:02 -0400
X-IronPort-AV: E=Sophos;i="5.64,300,1559491200"; 
   d="scan'208";a="72058067"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Jul 2019 10:25:00 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id B9FB44CDE933;
        Wed, 24 Jul 2019 10:15:04 +0800 (CST)
Received: from localhost.localdomain (10.167.215.46) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 24 Jul 2019 10:15:04 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <akpm@linux-foundation.org>, <gorcunov@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH v2] sys_prctl(): remove unsigned comparision with less than zero
Date:   Wed, 24 Jul 2019 10:11:48 +0800
Message-ID: <1563934308-20833-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20190723094809.GE4832@uranus.lan>
References: <20190723094809.GE4832@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.46]
X-yoursite-MailScanner-ID: B9FB44CDE933.AECF0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when calling prctl(PR_SET_TIMERSLACK, arg2), arg2 is an
unsigned long value, arg2 will never < 0. Negative judgment is
meaningless, so remove it.

Fixes: 6976675d9404 ("hrtimer: create a "timer_slack" field in the task struct")
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>
---
 kernel/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 2969304c29fe..701b5f00651d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2372,7 +2372,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			error = current->timer_slack_ns;
 		break;
 	case PR_SET_TIMERSLACK:
-		if (arg2 <= 0)
+		if (arg2 == 0)
 			current->timer_slack_ns =
 					current->default_timer_slack_ns;
 		else
-- 
2.18.1



