Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AC9C4320D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF5C21971
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 23:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nODLwMTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407792AbfIWXAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 19:00:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40691 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407756AbfIWXAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 19:00:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so8891108pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 16:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cxi307Bkpn4j+jiDXKsNJo43HrT9bZvKE+wlsNTb2vo=;
        b=nODLwMTRvcFnGrX/zrqVQmiRwJplI1RrjiEAU6Zj6tA0Y7w4ftRM/iNbtP2VVCojIx
         MKCGE/iJ7EYbTPMCb61gdelYNeeIWDaFwvmmm8fM53w3T8h0lZslkySjqG2pyvNxaVO+
         bjU8V3X9T+tUUE0boXjqVWqbmCRG75WNganvYsIH6qNh0o69xd7CmKX6u9Y1xzDENblT
         rkcyg5cAPU8wacBT9N8eNQlxXO4YdiMbfc/uZtMLO4i5tVHIPK7DQ5zqllka0gQEBD3z
         d9jGw34v0TCyCq1Pued+j5FYRJBFijr7Udm939aOXQHq7GM4xHQDTRghwrnqQxc/VAnN
         WYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cxi307Bkpn4j+jiDXKsNJo43HrT9bZvKE+wlsNTb2vo=;
        b=oIV0Hz3vMkvwC+Pup5bBVQQwJAS7fDkgqJHmvcAZYS7NiL00zzBe3tFxxbq8oy9h+o
         MBAXbzsaQIn/p2yJDc2e9L/7JJk+Z5wGH2VYyWq4NNM2cdpHsgyjkwmC1K5994GNUIe3
         MSIZXerjFZWVRoNoDzptb9aLKSo5+qKoFY3NuYM2HDqinKoWRgOp4hxrJp8kDxliwh+m
         mlr/XtiG1iW9PhJdlmRMHOY3vw/ny+L+Ocoy4/VCnMM44i4tGwkXeRw4JM6aG1Uylg9O
         UJ30oQrjkK3i3iYVfZ/0WfbraN6SzxuF2VgAkxd+dKK88+vrEM5pVT5z5vSuZIiEvtGw
         qklg==
X-Gm-Message-State: APjAAAWrNc8takywzLJpikv1b4Xrv2FLj8S2COELp6BtQr6XcqCBg11F
        ATzVAV1gK+Mc/5qBbciPMtURIdCMJYI=
X-Google-Smtp-Source: APXvYqyjbEye/XbSU187L1OdRVB7k7qjYrq7gfkFPmEuO36sQdB/ogRa8PveZWy3H4fXpgrq6zYpuA==
X-Received: by 2002:a17:90a:fc8c:: with SMTP id ci12mr1972096pjb.38.1569279629150;
        Mon, 23 Sep 2019 16:00:29 -0700 (PDT)
Received: from ?IPv6:2600:380:7421:c743:b137:2b87:43b6:a795? ([2600:380:7421:c743:b137:2b87:43b6:a795])
        by smtp.gmail.com with ESMTPSA id i37sm12006325pje.23.2019.09.23.16.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 16:00:28 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
Message-ID: <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
Date:   Mon, 23 Sep 2019 17:00:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 2:48 PM, Jens Axboe wrote:
> On 9/23/19 10:32 AM, Pavel Begunkov wrote:
>> Sorry, mixed the threads.
>>
>>>>
>>>> I'm not sure an extension is needed for such a special interface, why not
>>>> just put a ->threshold value next to the ctx->wait field and use either
>>>> the regular wait_event() APIs with the proper condition, or
>>>> wait_event_cmd() style APIs if you absolutely need something more complex
>>>> to happen inside?
>> Ingo,
>> io_uring works well without this patch just using wait_event_*() with
>> proper condition, but there are performance issues with spurious
>> wakeups. Detailed description in the previous mail.
>> Am I missing something?
> 
> I think we can do the same thing, just wrapping the waitqueue in a
> structure with a count in it, on the stack. Got some flight time
> coming up later today, let me try and cook up a patch.

Totally untested, and sent out 5 min before departure... But something
like this.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index ca7570aca430..c2f9e1da26dd 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2768,6 +2768,37 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 	return submit;
 }
 
+struct io_wait_queue {
+	struct wait_queue_entry wq;
+	struct io_ring_ctx *ctx;
+	struct task_struct *task;
+	unsigned to_wait;
+	unsigned nr_timeouts;
+};
+
+static inline bool io_should_wake(struct io_wait_queue *iowq)
+{
+	struct io_ring_ctx *ctx = iowq->ctx;
+
+	return io_cqring_events(ctx->rings) >= iowq->to_wait ||
+			atomic_read(&ctx->cq_timeouts) != iowq->nr_timeouts;
+}
+
+static int io_wake_function(struct wait_queue_entry *curr, unsigned int mode,
+			    int wake_flags, void *key)
+{
+	struct io_wait_queue *iowq = container_of(curr, struct io_wait_queue,
+							wq);
+
+	if (io_should_wake(iowq)) {
+		list_del_init(&curr->entry);
+		wake_up_process(iowq->task);
+		return 1;
+	}
+
+	return -1;
+}
+
 /*
  * Wait until events become available, if we don't already have some. The
  * application must reap them itself, as they reside on the shared cq ring.
@@ -2775,8 +2806,16 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			  const sigset_t __user *sig, size_t sigsz)
 {
+	struct io_wait_queue iowq = {
+		.wq = {
+			.func	= io_wake_function,
+			.entry	= LIST_HEAD_INIT(iowq.wq.entry),
+		},
+		.task		= current,
+		.ctx		= ctx,
+		.to_wait	= min_events,
+	};
 	struct io_rings *rings = ctx->rings;
-	unsigned nr_timeouts;
 	int ret;
 
 	if (io_cqring_events(rings) >= min_events)
@@ -2795,15 +2834,16 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 			return ret;
 	}
 
-	nr_timeouts = atomic_read(&ctx->cq_timeouts);
-	/*
-	 * Return if we have enough events, or if a timeout occured since
-	 * we started waiting. For timeouts, we always want to return to
-	 * userspace.
-	 */
-	ret = wait_event_interruptible(ctx->wait,
-				io_cqring_events(rings) >= min_events ||
-				atomic_read(&ctx->cq_timeouts) != nr_timeouts);
+	iowq.nr_timeouts = atomic_read(&ctx->cq_timeouts);
+	prepare_to_wait_exclusive(&ctx->wait, &iowq.wq, TASK_INTERRUPTIBLE);
+	do {
+		if (io_should_wake(&iowq))
+			break;
+		schedule();
+		set_current_state(TASK_INTERRUPTIBLE);
+	} while (1);
+	finish_wait(&ctx->wait, &iowq.wq);
+
 	restore_saved_sigmask_unless(ret == -ERESTARTSYS);
 	if (ret == -ERESTARTSYS)
 		ret = -EINTR;

-- 
Jens Axboe

