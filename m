Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8F1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD189217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbfDJSm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:42:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfDJSmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:42:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D086B3001A84;
        Wed, 10 Apr 2019 18:42:54 +0000 (UTC)
Received: from llong.com (ovpn-120-189.rdu2.redhat.com [10.10.120.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E30FA1001E89;
        Wed, 10 Apr 2019 18:42:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v3 01/14] locking/rwsem: Prevent unneeded warning during locking selftest
Date:   Wed, 10 Apr 2019 14:42:18 -0400
Message-Id: <20190410184231.6748-2-longman@redhat.com>
In-Reply-To: <20190410184231.6748-1-longman@redhat.com>
References: <20190410184231.6748-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 10 Apr 2019 18:42:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the DEBUG_RWSEMS check when locking selftest is running with
debug_locks_silent flag set.

Signed-off-by: Waiman Long <longman@redhat.com>
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
-- 
2.18.1

