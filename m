Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756D0C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED3A2229A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfGWDbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:31:05 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49973 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726610AbfGWDbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:31:05 -0400
X-IronPort-AV: E=Sophos;i="5.64,297,1559491200"; 
   d="scan'208";a="71998694"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jul 2019 11:31:03 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id B8E3B4CDCEBD;
        Tue, 23 Jul 2019 11:30:59 +0800 (CST)
Received: from localhost.localdomain (10.167.215.46) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 23 Jul 2019 11:30:57 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <akpm@linux-foundation.org>, <gorcunov@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] sys_prctl(): simplify arg2 judgment when calling PR_SET_TIMERSLACK
Date:   Tue, 23 Jul 2019 11:30:53 +0800
Message-ID: <1563852653-2382-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.46]
X-yoursite-MailScanner-ID: B8E3B4CDCEBD.A3A49
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arg2 will never < 0, for its type is 'unsigned long'. So negative
judgment is meaningless.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 kernel/sys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 2969304c29fe..399457d26bef 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2372,11 +2372,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			error = current->timer_slack_ns;
 		break;
 	case PR_SET_TIMERSLACK:
-		if (arg2 <= 0)
+		if (arg2)
+			current->timer_slack_ns = arg2;
+		else
 			current->timer_slack_ns =
 					current->default_timer_slack_ns;
-		else
-			current->timer_slack_ns = arg2;
 		break;
 	case PR_MCE_KILL:
 		if (arg4 | arg5)
-- 
2.18.1



