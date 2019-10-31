Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2625DCA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0630C21734
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfJaL5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:57:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55415 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfJaLzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92s-00037c-V4; Thu, 31 Oct 2019 12:55:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8D0C91C0482;
        Thu, 31 Oct 2019 12:55:09 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:09 -0000
From:   "tip-bot2 for Chuhong Yuan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] locktorture: Replace strncmp() with str_has_prefix()
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290923.29376.637270160970929616.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c5d3c8ca22d487ad9a18da9a7722a76e9bdbf4fd
Gitweb:        https://git.kernel.org/tip/c5d3c8ca22d487ad9a18da9a7722a76e9bdbf4fd
Author:        Chuhong Yuan <hslester96@gmail.com>
AuthorDate:    Fri, 02 Aug 2019 09:46:56 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 11:48:38 -07:00

locktorture: Replace strncmp() with str_has_prefix()

The strncmp() function is error-prone because it is easy to get the
length wrong, especially if the string is subject to change, especially
given the need to account for the terminating nul byte.  This commit
therefore substitutes the newly introduced str_has_prefix(), which
does not require a separately specified length.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index c513031..8dd9002 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -889,16 +889,16 @@ static int __init lock_torture_init(void)
 		cxt.nrealwriters_stress = 2 * num_online_cpus();
 
 #ifdef CONFIG_DEBUG_MUTEXES
-	if (strncmp(torture_type, "mutex", 5) == 0)
+	if (str_has_prefix(torture_type, "mutex"))
 		cxt.debug_lock = true;
 #endif
 #ifdef CONFIG_DEBUG_RT_MUTEXES
-	if (strncmp(torture_type, "rtmutex", 7) == 0)
+	if (str_has_prefix(torture_type, "rtmutex"))
 		cxt.debug_lock = true;
 #endif
 #ifdef CONFIG_DEBUG_SPINLOCK
-	if ((strncmp(torture_type, "spin", 4) == 0) ||
-	    (strncmp(torture_type, "rw_lock", 7) == 0))
+	if ((str_has_prefix(torture_type, "spin")) ||
+	    (str_has_prefix(torture_type, "rw_lock")))
 		cxt.debug_lock = true;
 #endif
 
