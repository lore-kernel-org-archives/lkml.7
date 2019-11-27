Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0E4C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1792070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jv-coder.de header.i=@jv-coder.de header.b="CatkMYWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfK0HfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:35:04 -0500
Received: from mail.jv-coder.de ([5.9.79.73]:40818 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfK0HfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 02:35:03 -0500
Received: from [10.61.40.7] (unknown [37.156.92.209])
        by mail.jv-coder.de (Postfix) with ESMTPSA id AB6619F73F;
        Wed, 27 Nov 2019 07:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1574840101; bh=21uHLITcKotKZHWu+5wn+8F7nkw3137394TzTbzd/zY=;
        h=Subject:To:From:Message-ID:Date:MIME-Version;
        b=CatkMYWChImV2Ha5IoUJETDkacT7BbaLjlKVqR7iOd5gZ8aSJoz46GMdeNgDY1yp/
         Y9ryjEIifOBcripPocr1NLOu+nPqgoVYsWNMMgcAQ/ZDFYH9qeq5f3epPu7J9Eg/ar
         kHLy/a+9Q3KHjQdX9J+mIiwBqbrurKh6dUj6CzqM=
Subject: Re: [PATCH RT v3] net/xfrm/input: Protect queue with lock
To:     Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
Cc:     Joerg Vehlow <joerg.vehlow@aox-tech.de>
References: <20191126071335.34661-1-lkml@jv-coder.de>
 <46d5e7ea-011b-a384-ac7a-9ba63bbe9ea5@redhat.com>
From:   Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <30b9da41-437a-3b00-8306-82c7c44d1a91@jv-coder.de>
Date:   Wed, 27 Nov 2019 08:35:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <46d5e7ea-011b-a384-ac7a-9ba63bbe9ea5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

I didn't remove it, I just posted my patch again.
I think it is up to the maintainers to decide if
it is required or not. Most people using the rt
patches will probably have PREEMPT_RT_FULL enabled anyway.
It will never be integrated into mainline kernel, because
the bug is already fixed in 5.0.19.

Jörg


Am 26.11.2019 um 16:31 schrieb Tom Rix:
> Why remove the #ifdef CONFIG_PREEMPT.. ?
>
>
>> +	spin_lock_irqsave(&trans->queue.lock, flags);
>>   	skb_queue_splice_init(&trans->queue, &queue);
>> +	spin_unlock_irqrestore(&trans->queue.lock, flags);
>>   
> Fine otherwise.
>
> Tom
>
>

