Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA2CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC95A218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 13:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSSHzTWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLTNvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 08:51:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22573 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727344AbfLTNvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 08:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576849910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=U7mQnCuZydftKAk49wAI4WdHzawy0qILE1REt91bCOk=;
        b=hSSHzTWnQG0GtYLrkV+a0mFIK9rNiXEicJwKeLouCWSfw76VTuV1NDVznq5cWIphXgJePR
        66jJiUgB53220pEbOaPnCAkqtnI3MfIuB1RxzlRzh6CuqzZ/eo7Rs1Sx/fYeHLEhRLOTP0
        WhQpIqxbSYXCoIOf0AIRWPZTwct7WiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-_ZdHm-ygM-KF68RdeZN3DQ-1; Fri, 20 Dec 2019 08:51:46 -0500
X-MC-Unique: _ZdHm-ygM-KF68RdeZN3DQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C091100550E;
        Fri, 20 Dec 2019 13:51:45 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31B4C541FC;
        Fri, 20 Dec 2019 13:51:42 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] locking/lockdep: Fix buffer overrun problem in stack_trace[]
Date:   Fri, 20 Dec 2019 08:51:28 -0500
Message-Id: <20191220135128.14876-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the lockdep code is really running out of the stack_trace entries,
it is likely that buffer overrun can happen and the data immediately
after stack_trace[] will be corrupted.

If there is less than LOCK_TRACE_SIZE_IN_LONGS entries left before
the call to save_trace(), the max_entries computation will leave it
with a very large positive number because of its unsigned nature. The
subsequent call to stack_trace_save() will then corrupt the data after
stack_trace[]. Fix that by changing max_entries to a signed integer
and check for negative value before calling stack_trace_save().

Fixes: 12593b7467f9 ("locking/lockdep: Reduce space occupied by stack traces")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 32282e7112d3..32406ef0d6a2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -482,7 +482,7 @@ static struct lock_trace *save_trace(void)
 	struct lock_trace *trace, *t2;
 	struct hlist_head *hash_head;
 	u32 hash;
-	unsigned int max_entries;
+	int max_entries;
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(STACK_TRACE_HASH_SIZE);
 	BUILD_BUG_ON(LOCK_TRACE_SIZE_IN_LONGS >= MAX_STACK_TRACE_ENTRIES);
@@ -490,10 +490,8 @@ static struct lock_trace *save_trace(void)
 	trace = (struct lock_trace *)(stack_trace + nr_stack_trace_entries);
 	max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries -
 		LOCK_TRACE_SIZE_IN_LONGS;
-	trace->nr_entries = stack_trace_save(trace->entries, max_entries, 3);
 
-	if (nr_stack_trace_entries >= MAX_STACK_TRACE_ENTRIES -
-	    LOCK_TRACE_SIZE_IN_LONGS - 1) {
+	if (max_entries <= 0) {
 		if (!debug_locks_off_graph_unlock())
 			return NULL;
 
@@ -502,6 +500,7 @@ static struct lock_trace *save_trace(void)
 
 		return NULL;
 	}
+	trace->nr_entries = stack_trace_save(trace->entries, max_entries, 3);
 
 	hash = jhash(trace->entries, trace->nr_entries *
 		     sizeof(trace->entries[0]), 0);
-- 
2.18.1

