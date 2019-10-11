Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E24C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5639621835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="Jh974XNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfJKSxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:53:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40212 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfJKSxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:53:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so13041988wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 11:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=05KOvLjc5zFyzaBcZAgAR6rz8smCnLy1J7OW18pqNLk=;
        b=Jh974XNOv3aS3Msl4Ss2rDJoqG+fYkW6LI3XXtp4c47JLv0+0433gBN6VlVEqmoMOf
         0EQ23DKrt2Hyw4opT/Q0t+e/j+BgYAbaE9aAZJlKBGzPDXp/eRJG/OGvBjlQeAv5dVsR
         ZyFyoF2VBDx5zcdz0+45gRJaiMwd/RgI4CJD1Nys50QE7y0oSgrpc0nGbfYZ5GWMBFgO
         SqfY4s3VeswBAeaDjvzgrETnpfY6bgObCo/8DAxR87gdU1zJ9+bxgPQmt4QcArRTN1n/
         KcOTv9mvfv1bPDMBxXtH98j+AsvOEyF+Atf7dXyaqJXSq8uMjn0YbZSGhbEo7C9eMMbQ
         fqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=05KOvLjc5zFyzaBcZAgAR6rz8smCnLy1J7OW18pqNLk=;
        b=JcG2igLmFZ8UGpJ0TKOiqmfqDHLIlJMAZjVcU5t3La9SyMEMkVX2iW5auL4rGiPc9m
         XZY4/+zx7ty4PUigSsHsdRSE695VtXoOU8IDnmOhXk6LuPEaOBbHWvI6n9b1mHCq0v1z
         IfZIvpqwETMpqBpgiHWOOczahyZZHFOUK5BdL6WpOR9KV3Ok1NRIBUp2umYdFG1s51Im
         EzmMkqtGf3CWHN3rCOJvyc3YdqccPqkBNT7vTGRK/7jX+ahs77LJJZ/UBeSreVKMHW3n
         /dScHtxiFSp1FlnlYvo+Ri+E9D8MEsx43sVdD/a5TfJQOujNm1l1mEZKtAkzAMChkDF1
         mDRg==
X-Gm-Message-State: APjAAAVudE0EK9/idJhHIDjh8/+iawcMQTaMqXwszMYbYKunGuoYhKpk
        eoZpS0t3YkP/WWPgZCUibHti9w==
X-Google-Smtp-Source: APXvYqzcnC2JP/LaMxL34MrGkGvYEZKjWgAyUxw4W3Qw60xoE0+a+PgQO8+EMLdEXHw11aeqW398RQ==
X-Received: by 2002:adf:a35b:: with SMTP id d27mr105309wrb.358.1570820007959;
        Fri, 11 Oct 2019 11:53:27 -0700 (PDT)
Received: from linux-2.fritz.box (p200300D99705BE00E22045ECB41D901D.dip0.t-ipconnect.de. [2003:d9:9705:be00:e220:45ec:b41d:901d])
        by smtp.googlemail.com with ESMTPSA id q124sm17771401wma.5.2019.10.11.11.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 11:53:26 -0700 (PDT)
Subject: Re: [PATCH 2/5] ipc/mqueue.c: Update/document memory barriers
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, 1vier1@web.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20191011112009.2365-1-manfred@colorfullife.com>
 <20191011112009.2365-3-manfred@colorfullife.com>
 <20191011165527.bsdiw6gu2sk7yrnl@linux-p48b>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <5e08cb89-563c-4763-dd88-94edaf9d883b@colorfullife.com>
Date:   Fri, 11 Oct 2019 20:53:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011165527.bsdiw6gu2sk7yrnl@linux-p48b>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/19 6:55 PM, Davidlohr Bueso wrote:
> On Fri, 11 Oct 2019, Manfred Spraul wrote:
>
>> Update and document memory barriers for mqueue.c:
>> - ewp->state is read without any locks, thus READ_ONCE is required.
>
> In general we relied on the barrier for not needing READ/WRITE_ONCE,
> but I agree this scenario should be better documented with them.

After reading core-api/atomic_ops.rst:

 > _ONCE() should be used. [...] Alternatively, you can place a barrier.

So both approaches are ok.

Let's follow the "should", i.e.: all operations on the ->state variables 
to READ_ONCE()/WRITE_ONCE().

Then we have a standard, and since we can follow the "should", we should 
do that.

> Similarly imo, the 'state' should also need them for write, even if
> under the lock -- consistency and documentation, for example.
>
Ok, so let's convert everything to _ONCE. (assuming that my analysis 
below is incorrect)
> In addition, I think it makes sense to encapsulate some of the
> pipelined send/recv operations, that also can allow us to keep
> the barrier comments in pipelined_send(), which I wonder why
> you chose to remove. Something like so, before your changes:
>
I thought that the simple "memory barrier is provided" is enough, so I 
had removed the comment.


But you are right, there are two different scenarios:

1) thread already in another wake_q, wakeup happens immediately after 
the cmpxchg_relaxed().

This scenario is safe, due to the smp_mb__before_atomic() in wake_q_add()

2) thread woken up but e.g. a timeout, see ->state=STATE_READY, returns 
to user space, calls sys_exit.

This must not happen before get_task_struct acquired a reference.

And this appears to be unsafe: get_task_struct() is refcount_inc(), 
which is refcount_inc_checked(), which is according to lib/refcount.c 
fully unordered.

Thus: ->state=STATE_READY can execute before the refcount increase.

Thus: ->state=STATE_READY needs a smp_store_release(), correct?

> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 3d920ff15c80..be48c0ba92f7 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -918,17 +918,12 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, 
> u_name)
>  * The same algorithm is used for senders.
>  */
>
> -/* pipelined_send() - send a message directly to the task waiting in
> - * sys_mq_timedreceive() (without inserting message into a queue).
> - */
> -static inline void pipelined_send(struct wake_q_head *wake_q,
> +static inline void __pipelined_op(struct wake_q_head *wake_q,
>                   struct mqueue_inode_info *info,
> -                  struct msg_msg *message,
> -                  struct ext_wait_queue *receiver)
> +                  struct ext_wait_queue *this)
> {
> -    receiver->msg = message;
> -    list_del(&receiver->list);
> -    wake_q_add(wake_q, receiver->task);
> +    list_del(&this->list);
> +    wake_q_add(wake_q, this->task);
>     /*
>      * Rely on the implicit cmpxchg barrier from wake_q_add such
>      * that we can ensure that updating receiver->state is the last
> @@ -937,7 +932,19 @@ static inline void pipelined_send(struct 
> wake_q_head *wake_q,
>      * yet, at that point we can later have a use-after-free
>      * condition and bogus wakeup.
>      */
> -    receiver->state = STATE_READY;
> +        this->state = STATE_READY;
> +}
> +
> +/* pipelined_send() - send a message directly to the task waiting in
> + * sys_mq_timedreceive() (without inserting message into a queue).
> + */
> +static inline void pipelined_send(struct wake_q_head *wake_q,
> +                  struct mqueue_inode_info *info,
> +                  struct msg_msg *message,
> +                  struct ext_wait_queue *receiver)
> +{
> +    receiver->msg = message;
> +    __pipelined_op(wake_q, info, receiver);
> }
>
> /* pipelined_receive() - if there is task waiting in sys_mq_timedsend()
> @@ -955,9 +962,7 @@ static inline void pipelined_receive(struct 
> wake_q_head *wake_q,
>     if (msg_insert(sender->msg, info))
>         return;
>
> -    list_del(&sender->list);
> -    wake_q_add(wake_q, sender->task);
> -    sender->state = STATE_READY;
> +    __pipelined_op(wake_q, info, sender);
> }
>
> static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,

I would merge that into the series, ok?

--

     Manfred

