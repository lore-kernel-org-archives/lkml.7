Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137ADC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A0520693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="O4ESAcVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbfDRIFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:05:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733205AbfDRIFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:05:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3I84NHI099552
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Apr 2019 01:04:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3I84NHI099552
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555574664;
        bh=M6aVtusw+S1Aa9wkQtldIwwvG6lESklUWQB/VbEFDwU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=O4ESAcVzmiVcYMwVexZRn5meltPolESW+rGIAXbfmTWMNfPRjQ/nJs1dW3fYCJCSc
         WPAAWm39L8GN4DnQEv3Kmqqk3rScIuMqIfjgvCInSBRttyVD/UUHugxOGnKIo+J3GT
         wAVAJYvBEJcxuUCJPbGKXiU5piX/ryGcTe0MVpZ0kxQsHZKh1uejWxPFPO20rmxzNq
         8iXVD2lZKsD20ftGpfEBqe6oyTPA14cOiDg8d6ebJDsdagwZxqkR/lEduJk+Dt/W1N
         oQaKjfiHwdxHY7Gf6EQCi/1sYrWAi1j7iOZ1iprEN6ZqQNhzrmJMwtuw/4t4ilCkTL
         KDP1ROjypayjw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3I84N5n099549;
        Thu, 18 Apr 2019 01:04:23 -0700
Date:   Thu, 18 Apr 2019 01:04:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-26536e7c242e2b0f73c25c46fc50d2525ebe400b@git.kernel.org>
Cc:     tglx@linutronix.de, huang.ying.caritas@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        dave@stgolabs.net, torvalds@linux-foundation.org, mingo@kernel.org,
        hpa@zytor.com, tim.c.chen@linux.intel.com, longman@redhat.com,
        will.deacon@arm.com
Reply-To: mingo@kernel.org, longman@redhat.com, tim.c.chen@linux.intel.com,
          hpa@zytor.com, will.deacon@arm.com, tglx@linutronix.de,
          huang.ying.caritas@gmail.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          dave@stgolabs.net
In-Reply-To: <20190413172259.2740-2-longman@redhat.com>
References: <20190413172259.2740-2-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Prevent unneeded warning during
 locking selftest
Git-Commit-ID: 26536e7c242e2b0f73c25c46fc50d2525ebe400b
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

Commit-ID:  26536e7c242e2b0f73c25c46fc50d2525ebe400b
Gitweb:     https://git.kernel.org/tip/26536e7c242e2b0f73c25c46fc50d2525ebe400b
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Sat, 13 Apr 2019 13:22:44 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 14 Apr 2019 11:09:35 +0200

locking/rwsem: Prevent unneeded warning during locking selftest

Disable the DEBUG_RWSEMS check when locking selftest is running with
debug_locks_silent flag set.

Signed-off-by: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: huang ying <huang.ying.caritas@gmail.com>
Link: http://lkml.kernel.org/r/20190413172259.2740-2-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/rwsem.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 37db17890e36..64877f5294e3 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -30,7 +30,8 @@
 
 #ifdef CONFIG_DEBUG_RWSEMS
 # define DEBUG_RWSEMS_WARN_ON(c, sem)	do {			\
-	if (WARN_ONCE(c, "DEBUG_RWSEMS_WARN_ON(%s): count = 0x%lx, owner = 0x%lx, curr 0x%lx, list %sempty\n",\
+	if (!debug_locks_silent &&				\
+	    WARN_ONCE(c, "DEBUG_RWSEMS_WARN_ON(%s): count = 0x%lx, owner = 0x%lx, curr 0x%lx, list %sempty\n",\
 		#c, atomic_long_read(&(sem)->count),		\
 		(long)((sem)->owner), (long)current,		\
 		list_empty(&(sem)->wait_list) ? "" : "not "))	\
