Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7953FC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFF8208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 17:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfFGRy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 13:54:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfFGRy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:54:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCB3730F1BA6;
        Fri,  7 Jun 2019 17:54:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 743CE5C896;
        Fri,  7 Jun 2019 17:54:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  7 Jun 2019 19:54:21 +0200 (CEST)
Date:   Fri, 7 Jun 2019 19:54:13 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Benjamin LaHaise <bcrl@kvack.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Laight <David.Laight@ACULAB.COM>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Wong <e@80x24.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] aio: simplify read_events()
Message-ID: <20190607175413.GA29187@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 07 Jun 2019 17:54:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change wait_event_hrtimeout() to not call __wait_event_hrtimeout()
if timeout == 0, this matches other _timeout() helpers in wait.h.

This allows to simplify its only user, read_events(), it no longer
needs to optimize the "until == 0" case by hand.

Note: this patch doesn't use ___wait_cond_timeout because _hrtimeout()
also differs in that it returns 0 if succeeds and -ETIME on timeout.
Perhaps we should change this to make it fully compatible with other
helpers.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/aio.c             | 9 +++------
 include/linux/wait.h | 4 ++--
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5bdbef0..2bb3f2e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1289,12 +1289,9 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 	 * the ringbuffer empty. So in practice we should be ok, but it's
 	 * something to be aware of when touching this code.
 	 */
-	if (until == 0)
-		aio_read_events(ctx, min_nr, nr, event, &ret);
-	else
-		wait_event_interruptible_hrtimeout(ctx->wait,
-				aio_read_events(ctx, min_nr, nr, event, &ret),
-				until);
+	wait_event_interruptible_hrtimeout(ctx->wait,
+			aio_read_events(ctx, min_nr, nr, event, &ret),
+			until);
 	return ret;
 }
 
diff --git a/include/linux/wait.h b/include/linux/wait.h
index b6f77cf..ddb9596 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -527,7 +527,7 @@ do {										\
 ({										\
 	int __ret = 0;								\
 	might_sleep();								\
-	if (!(condition))							\
+	if (!(condition) && (timeout))						\
 		__ret = __wait_event_hrtimeout(wq_head, condition, timeout,	\
 					       TASK_UNINTERRUPTIBLE);		\
 	__ret;									\
@@ -553,7 +553,7 @@ do {										\
 ({										\
 	long __ret = 0;								\
 	might_sleep();								\
-	if (!(condition))							\
+	if (!(condition) && (timeout))						\
 		__ret = __wait_event_hrtimeout(wq, condition, timeout,		\
 					       TASK_INTERRUPTIBLE);		\
 	__ret;									\
-- 
2.5.0


