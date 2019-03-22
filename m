Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127AFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41182070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388595AbfCVMnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:43:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41687 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbfCVMnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:43:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MChC3F579181
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 05:43:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MChCNT579178;
        Fri, 22 Mar 2019 05:43:12 -0700
Date:   Fri, 22 Mar 2019 05:43:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valdis Kletnieks <tipbot@zytor.com>
Message-ID: <tip-e8750053d64a3317cbc15f8341f0f11ca751bfeb@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org,
        valdis.kletnieks@vt.edu, tglx@linutronix.de, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          valdis.kletnieks@vt.edu, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <32342.1552379915@turing-police>
References: <32342.1552379915@turing-police>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] time/jiffies: Make refined_jiffies static
Git-Commit-ID: e8750053d64a3317cbc15f8341f0f11ca751bfeb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e8750053d64a3317cbc15f8341f0f11ca751bfeb
Gitweb:     https://git.kernel.org/tip/e8750053d64a3317cbc15f8341f0f11ca751bfeb
Author:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
AuthorDate: Tue, 12 Mar 2019 04:38:35 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 13:38:26 +0100

time/jiffies: Make refined_jiffies static

sparse complains:

  CHECK   kernel/time/jiffies.c
kernel/time/jiffies.c:92:20: warning: symbol 'refined_jiffies' was not
			     	      declared. Should it be static?

Its only used in file scope. Make it static.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/32342.1552379915@turing-police

---
 kernel/time/jiffies.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index dc1b6f1929f9..ac9c03dd6c7d 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -89,7 +89,7 @@ struct clocksource * __init __weak clocksource_default_clock(void)
 	return &clocksource_jiffies;
 }
 
-struct clocksource refined_jiffies;
+static struct clocksource refined_jiffies;
 
 int register_refined_jiffies(long cycles_per_second)
 {
