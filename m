Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6B3C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D554C214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YB/sVjBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504494AbfIXKNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 06:13:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43274 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504469AbfIXKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:13:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so1039112pfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 03:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pSTgriKJNgmX5Rc0fJtp+pWsVT9o6O3siTcCvlXE4dw=;
        b=YB/sVjBf7KZ4EBxVVFC8/8ODo+n5KpeufErANBmh2RfYSJQzGsgNPIVMEe5wb03pqj
         pmEd6WPD7IppVgWxFSuwhznkbLdZA0UseiVQyH2CZEYRBjFTah3g9zKbhgWQfSc7PlYu
         WcFDrtlmOl5VW761un+e9fTjRekVu3iPxLWccvbwr/QEvfZPRTwNRJa6ZeniOsh13wTf
         dlZG9KZYSQA+65KXNEhITksMV4HZpbnueraXhRciVOse+SbTE0LylnoxY9uP009R46aF
         zMySOQ95F+4RYJVY+4l6eA32WJ3Fk1kUCuLjMHb3xoiZPG4TEIzAk6yZzo/XYy10kAbn
         iagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pSTgriKJNgmX5Rc0fJtp+pWsVT9o6O3siTcCvlXE4dw=;
        b=QhaIanb/tjDYAx7yUNsfbon9IYkHjkbNapBU2sgzl7lxri+aqulqeV7/SnIbEgjw4Z
         w9wC3WP/oj7ridOE+2ibYsyutwoU9HTRkrWFRVr3ry4KATKiBfFYZ/tY3Wp44UgRQ3MS
         wlNws4akT3f5pbtfM8Z7elp22aQKbs0+Zg/oMfUyIGlWWR+TLBUitIkae64MCGRKor9y
         uCwdQmhH0iEA2BnzEa6HJKzm1QCcwNif9eOGXGbUkYO2T489gNc3lsjVbSl+IKQCrFF4
         GuB06DzFNmt/EaG7qUMUAz0EU0sL27hxGvFNQ1fpOkNd79X42HTVLS9RJX3Pu75j2L28
         YVpw==
X-Gm-Message-State: APjAAAU6MR/Q/Tq1OlkuogLKJVkA3GRnhcCOZ13HtXsUp93mF6mlt2HI
        t5MtXIuA/i4Esxm9dkD8VUcAHZ201xJpdxQM
X-Google-Smtp-Source: APXvYqweazjmEju55VXD0RllktwyRYydBgMkc4jcOqtDFOr8PQbaRBLzSfC62b9w9K38QQRQ1YiDqg==
X-Received: by 2002:aa7:9a92:: with SMTP id w18mr2543158pfi.244.1569320001778;
        Tue, 24 Sep 2019 03:13:21 -0700 (PDT)
Received: from ?IPv6:2600:380:8419:743e:6023:99b1:fa9f:a39c? ([2600:380:8419:743e:6023:99b1:fa9f:a39c])
        by smtp.gmail.com with ESMTPSA id n66sm2984430pfn.90.2019.09.24.03.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 03:13:21 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <20190924094942.GN2349@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
Date:   Tue, 24 Sep 2019 12:13:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924094942.GN2349@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/19 3:49 AM, Peter Zijlstra wrote:
> On Tue, Sep 24, 2019 at 10:36:28AM +0200, Jens Axboe wrote:
> 
>> +struct io_wait_queue {
>> +	struct wait_queue_entry wq;
>> +	struct io_ring_ctx *ctx;
>> +	struct task_struct *task;
> 
> wq.private is where the normal waitqueue stores the task pointer.
> 
> (I'm going to rename that)

If you do that, then we can just base the io_uring parts on that. 

>> +	unsigned to_wait;
>> +	unsigned nr_timeouts;
>> +};
>> +
>> +static inline bool io_should_wake(struct io_wait_queue *iowq)
>> +{
>> +	struct io_ring_ctx *ctx = iowq->ctx;
>> +
>> +	/*
>> +	 * Wake up if we have enough events, or if a timeout occured since we
>> +	 * started waiting. For timeouts, we always want to return to userspace,
>> +	 * regardless of event count.
>> +	 */
>> +	return io_cqring_events(ctx->rings) >= iowq->to_wait ||
>> +			atomic_read(&ctx->cq_timeouts) != iowq->nr_timeouts;
>> +}
>> +
>> +static int io_wake_function(struct wait_queue_entry *curr, unsigned int mode,
>> +			    int wake_flags, void *key)
>> +{
>> +	struct io_wait_queue *iowq = container_of(curr, struct io_wait_queue,
>> +							wq);
>> +
>> +	if (io_should_wake(iowq)) {
>> +		list_del_init(&curr->entry);
>> +		wake_up_process(iowq->task);
> 
> Then you can use autoremove_wake_function() here.
> 
>> +		return 1;
>> +	}
>> +
>> +	return -1;
>> +}
> 
> Ideally we'd get wait_event()'s @cond in a custom wake function. Then we
> can _always_ do this.
> 
> This is one I'd love to have lambda functions for. It would actually
> work with GCC nested functions, because the wake function will always be
> in scope, but we can't use those in the kernel for other reasons :/

I'll be happy enough if I can just call autoremove_wake_function(), I
think that will simplify the case enough for io_uring to not really make
me care too much about going further. I'll leave that to you, if you
have the desire :-)

-- 
Jens Axboe

