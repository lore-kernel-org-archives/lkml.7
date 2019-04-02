Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C46C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125522133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfDBNnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:43:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43636 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731514AbfDBNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:11 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0002nV-3v; Tue, 02 Apr 2019 14:40:00 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdv-0004sl-4c; Tue, 02 Apr 2019 14:39:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Sasha Levin" <sashal@kernel.org>,
        "Waiman Long" <longman@redhat.com>, tj@kernel.org,
        "Sasha Levin" <sasha.levin@oracle.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Bart Van Assche" <bvanassche@acm.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>, johannes.berg@intel.com,
        "Ingo Molnar" <mingo@kernel.org>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.443334155@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 29/99] tools/lib/lockdep: Rename "trywlock" into
 "trywrlock"
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

commit 7f3c7952d111ac93573fb86f4d5aeff527a07fcc upstream.

This patch avoids that the following compiler warning is reported while
compiling the lockdep unit tests:

include/liblockdep/rwlock.h: In function 'liblockdep_pthread_rwlock_trywlock':
include/liblockdep/rwlock.h:66:9: warning: implicit declaration of function 'pthread_rwlock_trywlock'; did you mean 'pthread_rwlock_trywrlock'? [-Wimplicit-function-declaration]
  return pthread_rwlock_trywlock(&lock->rwlock) == 0 ? 1 : 0;
         ^~~~~~~~~~~~~~~~~~~~~~~
         pthread_rwlock_trywrlock

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Fixes: 5a52c9b480e0 ("liblockdep: Add public headers for pthread_rwlock_t implementation")
Link: https://lkml.kernel.org/r/20181207011148.251812-6-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/lib/lockdep/include/liblockdep/rwlock.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/tools/lib/lockdep/include/liblockdep/rwlock.h
+++ b/tools/lib/lockdep/include/liblockdep/rwlock.h
@@ -59,10 +59,10 @@ static inline int liblockdep_pthread_rwl
 	return pthread_rwlock_tryrdlock(&lock->rwlock) == 0 ? 1 : 0;
 }
 
-static inline int liblockdep_pthread_rwlock_trywlock(liblockdep_pthread_rwlock_t *lock)
+static inline int liblockdep_pthread_rwlock_trywrlock(liblockdep_pthread_rwlock_t *lock)
 {
 	lock_acquire(&lock->dep_map, 0, 1, 0, 1, NULL, (unsigned long)_RET_IP_);
-	return pthread_rwlock_trywlock(&lock->rwlock) == 0 ? 1 : 0;
+	return pthread_rwlock_trywrlock(&lock->rwlock) == 0 ? 1 : 0;
 }
 
 static inline int liblockdep_rwlock_destroy(liblockdep_pthread_rwlock_t *lock)
@@ -78,7 +78,7 @@ static inline int liblockdep_rwlock_dest
 #define pthread_rwlock_unlock		liblockdep_pthread_rwlock_unlock
 #define pthread_rwlock_wrlock		liblockdep_pthread_rwlock_wrlock
 #define pthread_rwlock_tryrdlock	liblockdep_pthread_rwlock_tryrdlock
-#define pthread_rwlock_trywlock		liblockdep_pthread_rwlock_trywlock
+#define pthread_rwlock_trywrlock	liblockdep_pthread_rwlock_trywrlock
 #define pthread_rwlock_destroy		liblockdep_rwlock_destroy
 
 #endif

