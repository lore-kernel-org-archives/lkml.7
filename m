Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628E1C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F8120815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558022511;
	bh=pTZJNmrK3qHmjNETmt3Q4qcHsJ/NKfSDE5e7tYhYteA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Ywfj9VWiTHRo6xPuoG2ZdanDvXAGTOYe/F3reteLQdn/WifIE0XHKf8Gk0strMMej
	 2h6sXOlochNbfLGS1cK6uAnn0H9HIgi3T9iISI/g6E08hoKG+TKjDdujkFf9QvGQLR
	 j05rL/MSlDulCQWLybiekKa4JA5AovQbChXb0u7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfEPQBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:01:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34154 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfEPQBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:01:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8so2612622wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NjEnWJ5FrU96h4klas5/ssz+xotQMsKitrAgqXcy4/U=;
        b=QFfMWuW0Ed/iCD2yKTt50eJ/lNADKLFy0QRV0+8UplTj/NttIh/eWnZ+wC58KApY6N
         2rsTaXqUWZfoh3yTfLtM3YZds7mCxv4aGaW3gRi11pIuSJ96viJyaZkMVZmD7S59/mRI
         KTHQX51Iz+VE3IsLgtQ1MHjtev7PYGoKh9Gh/L/LROUUbB8pw/Vt1qDw8qRkRPQzQhVV
         qnuFSyC04ukTZkZHGuEgsoGkqgQE9SZxbQs8WlMHnkL0PNOOdgmdiAcey54ghRRztB4Q
         EeyO/aIhCJoZ6/sCXT5y8CY+oOUqufNI8HEVznj6i+oiAFhbNaaGxYERZK5Fv3rkfdXS
         c7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=NjEnWJ5FrU96h4klas5/ssz+xotQMsKitrAgqXcy4/U=;
        b=JBo+28bfL9ZD29TnSml9Sj8M9H+s9GGBAZz5yI7LbvtIUg+KdU56G1lZ1WfwDvQJE6
         NCO6TnDoLrWxUWVuhElc/vPP7lMD2zIx270npM20PKCD40xPOcnKLlxDVReXCvwna0Mp
         R06YbRPqaaCsw26ODhsDsW8/tWoFBjN9b10rfTMii/K20aFHlRlc+PjrXfTmpvQDZKIl
         b3wC7h3z13zMZezPL8j76aWVMnifRGPIxjzUutr6ozbJqwOIFZKPDbvw7cUsvGulrHMJ
         6gBkYoBL2qeYt/FsolmN1OrpYt4AJdI+xW4I+Psn1cwEP/lAMF9Hj4bUsOYv5v3qr11e
         D0KA==
X-Gm-Message-State: APjAAAX4w9BeKc0WZ2FwscX2bYZ5of3yhbClpy8Iq73OGieUi7qXn7d1
        e1aAcXZbDJ7uArkj/et4fFU=
X-Google-Smtp-Source: APXvYqxbkVBm4UM2Y1+qWlTcXUny74bXGZVFCoqUqEV8bJCMYW9dnGAqiKhtXH8WA1WzSDyVrx/OPA==
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr5408880wrv.163.1558022498426;
        Thu, 16 May 2019 09:01:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h8sm9138310wmf.5.2019.05.16.09.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 09:01:37 -0700 (PDT)
Date:   Thu, 16 May 2019 18:01:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking fix
Message-ID: <20190516160135.GA45760@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

   # HEAD: a9e9bcb45b1525ba7aea26ed9441e8632aeeda58 locking/rwsem: Prevent decrement of reader count before increment

A single rwsem fix.

 Thanks,

	Ingo

------------------>
Waiman Long (1):
      locking/rwsem: Prevent decrement of reader count before increment


 kernel/locking/rwsem-xadd.c | 46 ++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 6b3ee9948bf1..0b1f77957240 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -130,6 +130,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 {
 	struct rwsem_waiter *waiter, *tmp;
 	long oldcount, woken = 0, adjustment = 0;
+	struct list_head wlist;
 
 	/*
 	 * Take a peek at the queue head waiter such that we can determine
@@ -188,18 +189,43 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	 * of the queue. We know that woken will be at least 1 as we accounted
 	 * for above. Note we increment the 'active part' of the count by the
 	 * number of readers before waking any processes up.
+	 *
+	 * We have to do wakeup in 2 passes to prevent the possibility that
+	 * the reader count may be decremented before it is incremented. It
+	 * is because the to-be-woken waiter may not have slept yet. So it
+	 * may see waiter->task got cleared, finish its critical section and
+	 * do an unlock before the reader count increment.
+	 *
+	 * 1) Collect the read-waiters in a separate list, count them and
+	 *    fully increment the reader count in rwsem.
+	 * 2) For each waiters in the new list, clear waiter->task and
+	 *    put them into wake_q to be woken up later.
 	 */
-	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
-		struct task_struct *tsk;
-
+	list_for_each_entry(waiter, &sem->wait_list, list) {
 		if (waiter->type == RWSEM_WAITING_FOR_WRITE)
 			break;
 
 		woken++;
-		tsk = waiter->task;
+	}
+	list_cut_before(&wlist, &sem->wait_list, &waiter->list);
+
+	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
+	lockevent_cond_inc(rwsem_wake_reader, woken);
+	if (list_empty(&sem->wait_list)) {
+		/* hit end of list above */
+		adjustment -= RWSEM_WAITING_BIAS;
+	}
+
+	if (adjustment)
+		atomic_long_add(adjustment, &sem->count);
+
+	/* 2nd pass */
+	list_for_each_entry_safe(waiter, tmp, &wlist, list) {
+		struct task_struct *tsk;
 
+		tsk = waiter->task;
 		get_task_struct(tsk);
-		list_del(&waiter->list);
+
 		/*
 		 * Ensure calling get_task_struct() before setting the reader
 		 * waiter to nil such that rwsem_down_read_failed() cannot
@@ -213,16 +239,6 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		 */
 		wake_q_add_safe(wake_q, tsk);
 	}
-
-	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
-	lockevent_cond_inc(rwsem_wake_reader, woken);
-	if (list_empty(&sem->wait_list)) {
-		/* hit end of list above */
-		adjustment -= RWSEM_WAITING_BIAS;
-	}
-
-	if (adjustment)
-		atomic_long_add(adjustment, &sem->count);
 }
 
 /*
