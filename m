Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337F4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B4720679
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JZU5Egl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKSPVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:21:04 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33693 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfKSPVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:21:04 -0500
Received: by mail-io1-f65.google.com with SMTP id j13so404829ioe.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 07:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wLB89YSfgFbBGVbXR/ZLzoyZwIzs8AJRlNKdafMUlZc=;
        b=JZU5Egl9ZoaDwz0bdBgxNinwLYcLz3n+Hn0aSbO/AVFn/aCE1lLwcN1r/3QDejrEwj
         6kglXsZ4RySU2HEjz8jO/+dMfP0KzreCJJzgp6h7hlw6u+wxrZj6UwrfdYtdIGDWXGiR
         OYES5PwFK/+xSi0YVlN3UdH6klun9G6QoHg4Tc+ZnUsv6IMI/4muOABPexjk1oA0ADE5
         b3zj+/FHbBkydFhTf4a73F5C1bOOVr937pWuybe9hb0lgDZmy5CuNokkTpHWHs08/nD+
         f69g2JR9eA014LrlsmPjz5j30rtzeVJA7qw7ztGe066Nw7m/BfFu8Iv6+9T9ezL/N4tx
         eaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wLB89YSfgFbBGVbXR/ZLzoyZwIzs8AJRlNKdafMUlZc=;
        b=Dsn9tWXxJtz9pKR/QTvbJEW8P6GethL0wxk/BktROezEExSTVRVGdEgUIriRQHnUw8
         9amqwdcG0GVVAuKmMTQc4TOd+Ufzyy+zRcDz/AR0zlq7haaJOkHWl+5uURfVpZXJ8oi4
         bh3vQs2fSx3wWC2TB8Y2NNSiNErQTdmc2L6EBpJpINRBs+aoLC6cnNzVHTDduymxPO8w
         Bo9fuHu/NFNychntxlA+QzmzpQBW8VbD2ZLb8K4XvDb7pncqcDltDlIbA0mXPubUeSMi
         RPAADfPvw0H0E9HRJ9b/GY4XLWwIOBGMq/dQLvuR/To7BeoOY18aU3+Tj0ZmvANg4PIS
         ytNg==
X-Gm-Message-State: APjAAAX4Rv2NmBDQYCPctKEBenBf3QqWon44ursI1UXndfbshXYMOioM
        ADRwbY37uiTSyyydhUwZPtFxBw==
X-Google-Smtp-Source: APXvYqxS869fK817TTK5HMeIoHO8JiLIL3F6mOGHGin+8CiL/opZQabRZ2ZaAHZYToc+OJNCCgwA+A==
X-Received: by 2002:a02:70cb:: with SMTP id f194mr19334335jac.126.1574176861577;
        Tue, 19 Nov 2019 07:21:01 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t7sm4262873iog.85.2019.11.19.07.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 07:21:00 -0800 (PST)
Subject: Re: INFO: task hung in io_wq_destroy
From:   Jens Axboe <axboe@kernel.dk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+0f1cc17f85154f400465@syzkaller.appspotmail.com>,
        andriy.shevchenko@linux.intel.com, davem@davemloft.net,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org,
        idosch@mellanox.com, kimbrownkd@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, petrm@mellanox.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, wanghai26@huawei.com,
        yuehaibing@huawei.com
References: <000000000000f86a4f0595fdb152@google.com>
 <f1a79e81-b41f-ba48-9bf3-aeae708f73ba@kernel.dk>
 <20191119022330.GC3147@sol.localdomain>
 <bc52115c-3951-54c6-7810-86797d8c4644@kernel.dk>
 <c7b9c600-724b-6df1-84ba-b74999d6f4a6@kernel.dk>
Message-ID: <09cdf1d6-4660-9712-e374-4bbb120d6858@kernel.dk>
Date:   Tue, 19 Nov 2019 08:20:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c7b9c600-724b-6df1-84ba-b74999d6f4a6@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/19 9:34 PM, Jens Axboe wrote:
> On 11/18/19 8:15 PM, Jens Axboe wrote:
>> On 11/18/19 7:23 PM, Eric Biggers wrote:
>>> Hi Jens,
>>>
>>> On Mon, Oct 28, 2019 at 03:00:08PM -0600, Jens Axboe wrote:
>>>> This is fixed in my for-next branch for a few days at least, unfortunately
>>>> linux-next is still on the old one. Next version should be better.
>>>
>>> This is still occurring on linux-next.  Here's a report on next-20191115 from
>>> https://syzkaller.appspot.com/text?tag=CrashReport&x=16fa3d1ce00000
>>
>> Hmm, I'll take a look. Looking at the reproducer, it's got a massive
>> sleep at the end. I take it this triggers before that time actually
>> passes? Because that's around 11.5 days of sleep.
>>
>> No luck reproducing this so far, I'll try on linux-next.
> 
> I see what it is - if the io-wq is setup and torn down before the
> manager thread is started, then we won't create the workers we already
> expected. The manager thread will exit without doing anything, but
> teardown will wait for the expected workers to exit before being
> allowed to proceed. That never happens.
> 
> I've got a patch for this, but I'll test it a bit and send it out
> tomorrow.

This should fix it - wait until the manager is started and has created
the required fixed workers, then check if it failed or not. That closes
the gap between startup and teardown, as we have settled things before
anyone is allowed to call io_wq_destroy().


diff --git a/fs/io-wq.c b/fs/io-wq.c
index 9174007ce107..1f640c489f7c 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -33,6 +33,7 @@ enum {
 enum {
 	IO_WQ_BIT_EXIT		= 0,	/* wq exiting */
 	IO_WQ_BIT_CANCEL	= 1,	/* cancel work on list */
+	IO_WQ_BIT_ERROR		= 2,	/* error on setup */
 };
 
 enum {
@@ -562,14 +563,14 @@ void io_wq_worker_sleeping(struct task_struct *tsk)
 	spin_unlock_irq(&wqe->lock);
 }
 
-static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
+static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 {
 	struct io_wqe_acct *acct =&wqe->acct[index];
 	struct io_worker *worker;
 
 	worker = kcalloc_node(1, sizeof(*worker), GFP_KERNEL, wqe->node);
 	if (!worker)
-		return;
+		return false;
 
 	refcount_set(&worker->ref, 1);
 	worker->nulls_node.pprev = NULL;
@@ -581,7 +582,7 @@ static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 				"io_wqe_worker-%d/%d", index, wqe->node);
 	if (IS_ERR(worker->task)) {
 		kfree(worker);
-		return;
+		return false;
 	}
 
 	spin_lock_irq(&wqe->lock);
@@ -599,6 +600,7 @@ static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 		atomic_inc(&wq->user->processes);
 
 	wake_up_process(worker->task);
+	return true;
 }
 
 static inline bool io_wqe_need_worker(struct io_wqe *wqe, int index)
@@ -606,9 +608,6 @@ static inline bool io_wqe_need_worker(struct io_wqe *wqe, int index)
 {
 	struct io_wqe_acct *acct = &wqe->acct[index];
 
-	/* always ensure we have one bounded worker */
-	if (index == IO_WQ_ACCT_BOUND && !acct->nr_workers)
-		return true;
 	/* if we have available workers or no work, no need */
 	if (!hlist_nulls_empty(&wqe->free_list) || !io_wqe_run_queue(wqe))
 		return false;
@@ -621,10 +620,19 @@ static inline bool io_wqe_need_worker(struct io_wqe *wqe, int index)
 static int io_wq_manager(void *data)
 {
 	struct io_wq *wq = data;
+	int i;
 
-	while (!kthread_should_stop()) {
-		int i;
+	/* create fixed workers */
+	for (i = 0; i < wq->nr_wqes; i++) {
+		if (create_io_worker(wq, wq->wqes[i], IO_WQ_ACCT_BOUND))
+			continue;
+		goto err;
+	}
 
+	refcount_set(&wq->refs, wq->nr_wqes);
+	complete(&wq->done);
+
+	while (!kthread_should_stop()) {
 		for (i = 0; i < wq->nr_wqes; i++) {
 			struct io_wqe *wqe = wq->wqes[i];
 			bool fork_worker[2] = { false, false };
@@ -644,6 +652,10 @@ static int io_wq_manager(void *data)
 		schedule_timeout(HZ);
 	}
 
+	return 0;
+err:
+	set_bit(IO_WQ_BIT_ERROR, &wq->state);
+	complete(&wq->done);
 	return 0;
 }
 
@@ -982,7 +994,6 @@ struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
 	wq->user = user;
 
 	i = 0;
-	refcount_set(&wq->refs, wq->nr_wqes);
 	for_each_online_node(node) {
 		struct io_wqe *wqe;
 
@@ -1020,6 +1031,10 @@ struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
 	wq->manager = kthread_create(io_wq_manager, wq, "io_wq_manager");
 	if (!IS_ERR(wq->manager)) {
 		wake_up_process(wq->manager);
+		wait_for_completion(&wq->done);
+		if (test_bit(IO_WQ_BIT_ERROR, &wq->state))
+			goto err;
+		reinit_completion(&wq->done);
 		return wq;
 	}
 
@@ -1041,10 +1056,9 @@ void io_wq_destroy(struct io_wq *wq)
 {
 	int i;
 
-	if (wq->manager) {
-		set_bit(IO_WQ_BIT_EXIT, &wq->state);
+	set_bit(IO_WQ_BIT_EXIT, &wq->state);
+	if (wq->manager)
 		kthread_stop(wq->manager);
-	}
 
 	rcu_read_lock();
 	for (i = 0; i < wq->nr_wqes; i++) {

-- 
Jens Axboe

