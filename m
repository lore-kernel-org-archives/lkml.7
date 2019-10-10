Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593ADC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8AA20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netrounds-com.20150623.gappssmtp.com header.i=@netrounds-com.20150623.gappssmtp.com header.b="CgY1dBiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfJJG2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 02:28:01 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40909 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfJJG2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 02:28:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so4941760ljw.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 23:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netrounds-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FiE63Jf0+YKrajX+a/6ereKGsQ9R9ph2lTRjBJOT88A=;
        b=CgY1dBiEMb98NQ/At9u26khShIHa54HFYd24qpfRhl58R7WD6fhM90irNgl/CX5d4d
         HP2cnwy5/XeyG/qAANZXTH0NDr4UO08Jm2FWN1Kn6aQYsp0qVzQAwM/I7J0a6LNwMHdo
         NmZdWlv4ymo8P7jElxCNRnKkDcyYtDHSf75MeYqHamlsEf1P83lTOhgnWIbBb9sczx5B
         iiKVlYHogkMOlNbl6PnmQvW90SsUlLFsqRd2Zd1PBxXbwBSZqP6Dg3+7q3LFTAl6Cgvj
         WdoA1i8sTSHe+0D+INEx6wnJCxVMkL0HUBl3JW0pgn+Optq8dYqM6pQmjApVthj8sJLz
         mArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FiE63Jf0+YKrajX+a/6ereKGsQ9R9ph2lTRjBJOT88A=;
        b=e13s1GfHDH+Oq8eNbpMFV0DJDBHtDiYEiJ8YVkTyODu4u9Qv0TPpbqZNGNbOL+ASSp
         sk/b4SgfbxUwOMLMq2rMC3qwQWsoGGs8pHTFkVcrNSjKseQdXG1W7gkpON3GChL4hdWH
         Gq4BFw0PEJUWBozfd5eOt9z3ap26LhBFow8vg+Tu5sZlmhe4sgyrx+rhjD+kOCMa2nz2
         DLvNQpZ9HVxMuu7YtNJxh8q2lLfDcaLsMLEj+SZ+XmjurHVs7vVxakBHJZTL/A1ujdFx
         gtXGFpMBDuCtFvmBeamb8NBgawRbSknvAWQMWMeM8xeJHR2egePknPmqwEMCt7m7asr+
         IOYg==
X-Gm-Message-State: APjAAAXLfigwuYc6gGfCB6Im7pFJBmd06H/8wXcXDO70Uyfkz6xoUrYW
        qeIL9Z+bJFEBKKaWHn+goKg3Ww==
X-Google-Smtp-Source: APXvYqxotN273Jma0cjDfGOmGpDy+7PPz1s8PTIBAU1+t1GdknJwYANdAEzTA16fCFrmVjrN4k/xmA==
X-Received: by 2002:a2e:a415:: with SMTP id p21mr5009509ljn.59.1570688877789;
        Wed, 09 Oct 2019 23:27:57 -0700 (PDT)
Received: from [10.0.156.104] ([195.22.87.57])
        by smtp.gmail.com with ESMTPSA id v1sm988319lfe.34.2019.10.09.23.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 23:27:56 -0700 (PDT)
Subject: Re: Packet gets stuck in NOLOCK pfifo_fast qdisc
To:     Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>
References: <d102074f-7489-e35a-98cf-e2cad7efd8a2@netrounds.com>
 <95c5a697932e19ebd6577b5dac4d7052fe8c4255.camel@redhat.com>
From:   Jonas Bonn <jonas.bonn@netrounds.com>
Message-ID: <18f58ddc-f16e-600f-02de-29c79332d945@netrounds.com>
Date:   Thu, 10 Oct 2019 08:27:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <95c5a697932e19ebd6577b5dac4d7052fe8c4255.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

On 09/10/2019 21:14, Paolo Abeni wrote:
> On Wed, 2019-10-09 at 08:46 +0200, Jonas Bonn wrote:
>> Hi,
>>
>> The lockless pfifo_fast qdisc has an issue with packets getting stuck in
>> the queue.  What appears to happen is:
>>
>> i)  Thread 1 holds the 'seqlock' on the qdisc and dequeues packets.
>> ii)  Thread 1 dequeues the last packet in the queue.
>> iii)  Thread 1 iterates through the qdisc->dequeue function again and
>> determines that the queue is empty.
>>
>> iv)  Thread 2 queues up a packet.  Since 'seqlock' is busy, it just
>> assumes the packet will be dequeued by whoever is holding the lock.
>>
>> v)  Thread 1 releases 'seqlock'.
>>
>> After v), nobody will check if there are packets in the queue until a
>> new packet is enqueued.  Thereby, the packet enqueued by Thread 2 may be
>> delayed indefinitely.
> 
> I think you are right.
> 
> It looks like this possible race is present since the initial lockless
> implementation - commit 6b3ba9146fe6 ("net: sched: allow qdiscs to
> handle locking")
> 
> Anyhow the racing windows looks quite tiny - I never observed that
> issue in my tests. Do you have a working reproducer?

Yes, it's reliably reproducible.  We do network latency measurements and 
latency spikes for these packets that get stuck in the queue.

> 
> Something alike the following code - completely untested - can possibly
> address the issue, but it's a bit rough and I would prefer not adding
> additonal complexity to the lockless qdiscs, can you please have a spin
> a it?

Your change looks reasonable.  I'll give it a try.


> 
> Thanks,
> 
> Paolo
> ---
> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> index 6a70845bd9ab..65a1c03330d6 100644
> --- a/include/net/pkt_sched.h
> +++ b/include/net/pkt_sched.h
> @@ -113,18 +113,23 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
>   		     struct net_device *dev, struct netdev_queue *txq,
>   		     spinlock_t *root_lock, bool validate);
>   
> -void __qdisc_run(struct Qdisc *q);
> +int __qdisc_run(struct Qdisc *q);
>   
>   static inline void qdisc_run(struct Qdisc *q)
>   {
> +	int quota = 0;
> +
>   	if (qdisc_run_begin(q)) {
>   		/* NOLOCK qdisc must check 'state' under the qdisc seqlock
>   		 * to avoid racing with dev_qdisc_reset()
>   		 */
>   		if (!(q->flags & TCQ_F_NOLOCK) ||
>   		    likely(!test_bit(__QDISC_STATE_DEACTIVATED, &q->state)))
> -			__qdisc_run(q);
> +			quota = __qdisc_run(q);
>   		qdisc_run_end(q);
> +
> +		if (quota > 0 && q->flags & TCQ_F_NOLOCK && q->ops->peek(q))
> +			__netif_schedule(q);

Not sure this is relevant, but there's a subtle difference in the way 
that the underlying ptr_ring peeks at the queue head and checks whether 
the queue is empty.

For peek it's:

READ_ONCE(r->queue[r->consumer_head]);

For is_empty it's:

!r->queue[READ_ONCE(r->consumer_head)];

The placement of the READ_ONCE changes here.  I can't get my head around 
whether this difference is significant or not.  If it is, then perhaps 
an is_empty() method is needed on the qdisc_ops...???

/Jonas
