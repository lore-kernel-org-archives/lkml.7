Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768C9C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490AB2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 15:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXgANChn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbgAIPi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 10:38:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32754 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728098AbgAIPi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578584335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=kaZZfCScJJ1U9Wwt+ibxKqsbsVeTXB5b3nkPC6eQ04A=;
        b=OXgANChnzuvP0+nKENcT0VS5RIJuMcSe8l+dFxGEp1JJSytXcvlla1AT4U0Yk02c3OatfN
        p9EETa2oIlxQsFwZ8f38OxfsJKAzuVlAQ+/IldYg/KcycWeNY4hbXjS1QytlSZnhCmY3dO
        0UzuY03bv2klLbA13EZa3S+1xkApD/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-1m3DtsQVMs6laQTYvWIyPA-1; Thu, 09 Jan 2020 10:38:51 -0500
X-MC-Unique: 1m3DtsQVMs6laQTYvWIyPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92839593C6;
        Thu,  9 Jan 2020 15:38:50 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 701A57FB5C;
        Thu,  9 Jan 2020 15:38:47 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/osq: Use more optimized spinning for arm64
Date:   Thu,  9 Jan 2020 10:38:31 -0500
Message-Id: <20200109153831.29993-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm64 has a more optimized spinning loop (atomic_cond_read_acquire)
for spinlock that can boost performance of sibling threads by putting
the current cpu to a shallow sleep state that is woken up when the
monitored variable changes or an external event happens.

OSQ has a more complicated spinning loop. Besides the lock value, it
also checks for need_resched() and vcpu_is_preempted(). The check for
need_resched() is not a problem as it is only set by the tick interrupt
handler. That will be detected by the spinning cpu right after iret.

The vcpu_is_preempted() check, however, is a problem as changes to
the state of of previous node will not affect the sleep state. For
ARM64, vcpu_is_preempted is not defined and so we can just skip the
vcpu_is_preempted() check and use smp_cond_load_relaxed() instead.

On a 2-socket 56-core 224-thread ARM64 system, a kernel mutex locking
microbenchmark was run for 10s with and without the patch. The
performance numbers before patch were:

Running locktest with mutex [runtime = 10s, load = 1]
Threads = 224, Min/Mean/Max = 316/123,143/2,121,269
Threads = 224, Total Rate = 2,757 kop/s; Percpu Rate = 12 kop/s

After patch, the numbers were:

Running locktest with mutex [runtime = 10s, load = 1]
Threads = 224, Min/Mean/Max = 334/147,836/1,304,787
Threads = 224, Total Rate = 3,311 kop/s; Percpu Rate = 15 kop/s

So there was about 20% performance improvement.

Longer term, we may have to define and use a static_key to indicate
that vcpu_is_preempted is defined and it may return a value of true.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/osq_lock.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 6ef600aa0f47..129e8f56ae71 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -134,6 +134,27 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 * cmpxchg in an attempt to undo our queueing.
 	 */
 
+	/*
+	 * If vcpu_is_preempted is not defined, we can skip the check
+	 * and use smp_cond_load_relaxed() instead. For arm64, this
+	 * could lead to the use of the more optimized wfe instruction.
+	 * As need_sched() is set by interrupt handler, it will break
+	 * out and do the unqueue in a timely manner.
+	 *
+	 * TODO: We may need to add a static_key like vcpu_is_preemptible
+	 *	 as vcpu_is_preempted() will always return false with
+	 *	 bare metal even if it is defined.
+	 */
+#ifndef vcpu_is_preempted
+	{
+		int locked = smp_cond_load_relaxed(&node->locked,
+						   VAL || need_resched());
+		if (!locked)
+			goto unqueue;
+		return true;
+	}
+#endif
+
 	while (!READ_ONCE(node->locked)) {
 		/*
 		 * If we need to reschedule bail... so we can block.
-- 
2.18.1

