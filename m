Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8E2C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E58222C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570067281;
	bh=4aOPyTJph2xYG0MK69zyCvwxb5I4yf1354D3Ac5DoPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I7hyuYMt1b/chGMhQ2O7lfFc+SUcyEtt1lgOP5uEtIbt2EMaeIUTijLFxkCG17AlN
	 SPX9FviwNVDXlYmyuyGNYsQBTiNwcJSZkFCcG0iSZ7Bksl41BPoWZ2W7KXjrV06fuD
	 kXmUCWJ/metMiNzF3Jc/2DsKTWX7nOIHQwYkUJgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfJCBsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfJCBrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:47:32 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3CB8222C4;
        Thu,  3 Oct 2019 01:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570067251;
        bh=4aOPyTJph2xYG0MK69zyCvwxb5I4yf1354D3Ac5DoPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ram4/adO9JSNrRigaxHPNB9ZBuARLCuLgvClsrX3waXCbMmiD1v8HWl5dHQk8FTUx
         yrXLXY9ZOx4CMoeGbu3FTMhU/PWCH3vPs4z20Hei/1rDVUZYVzcSU/SFxrTsOGgXjU
         qQLbWSMRhPJM/Q+0cy9QSakgnz74adwYyZJKpGkY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Chuhong Yuan <hslester96@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 2/9] locktorture: Replace strncmp() with str_has_prefix()
Date:   Wed,  2 Oct 2019 18:47:21 -0700
Message-Id: <20191003014728.13496-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003014710.GA13323@paulmck-ThinkPad-P72>
References: <20191003014710.GA13323@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

The strncmp() function is error-prone because it is easy to get the
length wrong, especially if the string is subject to change, especially
given the need to account for the terminating nul byte.  This commit
therefore substitutes the newly introduced str_has_prefix(), which
does not require a separately specified length.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
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
 
-- 
2.9.5

