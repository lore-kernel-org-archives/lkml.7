Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4F0C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D422184C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hanCNMW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbfGAOWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:22:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41208 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfGAOWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:22:36 -0400
Received: by mail-io1-f65.google.com with SMTP id w25so29175807ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=btB19IKd1k8U8AFXegKGIuJCLiqvpxzyOkY8GOJfQnQ=;
        b=hanCNMW6XBQ9ko0So04XIcjf8oRLewRZVmW9+7bcPtobH+yCIR2NkbuTQwq3XoVPUe
         L/bcXt7K5MxSM0o+nEwVyEspze7MxmsxVl3F54sn5FH4QYXfL4W2duJ6JixaMCo5j963
         sqfhZwq2EWLsJSwho7hJPy5VUvnyPRpDnLCvGxpI0Hpocf7NdOjZFcNuOJiiTkVPRAsL
         iTfzBsqM3PRdettAwvdJwz9tYgQd8V214v6BS5UFlSd9pzGDFjBQ+kONre+m94D5wbdR
         nvFOF5FdBUGblmAA6UFbWB335aso2amFqL+WWr2z3FMMuhG3YBgv0qerKRmLT82zT+KZ
         HJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=btB19IKd1k8U8AFXegKGIuJCLiqvpxzyOkY8GOJfQnQ=;
        b=WHledQs6B9yAAFihPc/bX0VIEv4k8uhsW964FIJIaPM/6OlSJrFj0cGR8e2jVDo1L9
         WvPlCj4+dGcDHTegl7sc/nWjhX6JCNryqQBpGKYEIeL0R9UXow08/KjJnWxt0e2dMK2g
         AXVgRev/c4Sviwlp7sXepfqS2ouo88gUICai1xoBbtHHKoAmuJ1UdfvyK6l3KG5maQG4
         7QuWq9hhtFPiFcF51P/Uk1P7ou5lxkf2OVYt1MnADJs9UX/P6CIaXFaNQaQNhIu0/mFp
         vplFRC9FFdtq8MevMzD26sOzyQNHUsqkMBfdGYCEP3WEnJmzLdy4acxA+RIQChn2hraT
         UT5A==
X-Gm-Message-State: APjAAAWL30MHBY3nsSwkdACq8U5atHfdufy5OtKQcAq/GeFrALb/jEGF
        xbd1Af0V6rGOOzpPJqGxKyapIigUFiErQEOl
X-Google-Smtp-Source: APXvYqzWSCyKremeC+uWScZlpj90RzZsz6orOU/jtDmTV5iUCLcQrENtk3Y2DtKHKviMqHbGkTVi0Q==
X-Received: by 2002:a6b:ce19:: with SMTP id p25mr27241142iob.201.1561990954936;
        Mon, 01 Jul 2019 07:22:34 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q15sm10426451ioi.15.2019.07.01.07.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 07:22:33 -0700 (PDT)
Subject: Re: [PATCH] block: fix a crash in do_task_dead()
To:     Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, hch@lst.de, gkohli@codeaurora.org,
        mingo@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1559161526-618-1-git-send-email-cai@lca.pw>
 <20190530080358.GG2623@hirez.programming.kicks-ass.net>
 <82e88482-1b53-9423-baad-484312957e48@kernel.dk>
 <20190603123705.GB3419@hirez.programming.kicks-ass.net>
 <ddf9ee34-cd97-a62b-6e91-6b4511586339@kernel.dk>
 <alpine.LSU.2.11.1906301542410.1105@eggly.anvils>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <97d2f5cc-fe98-f28e-86ce-6fbdeb8b67bd@kernel.dk>
Date:   Mon, 1 Jul 2019 08:22:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1906301542410.1105@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/19 5:06 PM, Hugh Dickins wrote:
> On Wed, 5 Jun 2019, Jens Axboe wrote:
>>
>> How about the following plan - if folks are happy with this sched patch,
>> we can queue it up for 5.3. Once that is in, I'll kill the block change
>> that special cases the polled task wakeup. For 5.2, we go with Oleg's
>> patch for the swap case.
> 
> I just hit the do_task_dead() kernel BUG at kernel/sched/core.c:3463!
> while heavy swapping on 5.2-rc7: it looks like Oleg's patch intended
> for 5.2 was not signed off, and got forgotten.
> 
> I did hit the do_task_dead() BUG (but not at all easily) on early -rcs
> before seeing Oleg's patch, then folded it in and and didn't hit the BUG
> again; then just tried again without it, and luckily hit in a few hours.
> 
> So I can give it an enthusiastic
> Acked-by: Hugh Dickins <hughd@google.com>
> because it makes good sense to avoid the get/blk_wake/put overhead on
> the asynch path anyway, even if it didn't work around a bug; but only
> Half-Tested-by: Hugh Dickins <hughd@google.com>
> since I have not been exercising the synchronous path at all.

I'll take the blame for that, went away on vacation for 3 weeks...
But yes, for 5.2, the patch from Oleg looks fine. Once Peter's other
change is in mainline, I'll go through and remove these special cases.

Andrew, can you queue Oleg's patch for 5.2? You can also add my:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

to it.

> 
> Hugh, requoting Oleg:
> 
>>
>> I don't understand this code at all but I am just curious, can we do
>> something like incomplete patch below ?
>>
>> Oleg.
>>
>> --- x/mm/page_io.c
>> +++ x/mm/page_io.c
>> @@ -140,8 +140,10 @@ int swap_readpage(struct page *page, bool synchronous)
>>   	unlock_page(page);
>>   	WRITE_ONCE(bio->bi_private, NULL);
>>   	bio_put(bio);
>> -	blk_wake_io_task(waiter);
>> -	put_task_struct(waiter);
>> +	if (waiter) {
>> +		blk_wake_io_task(waiter);
>> +		put_task_struct(waiter);
>> +	}
>>   }
>>   
>>   int generic_swapfile_activate(struct swap_info_struct *sis,
>> @@ -398,11 +400,12 @@ int swap_readpage(struct page *page, boo
>>   	 * Keep this task valid during swap readpage because the oom killer may
>>   	 * attempt to access it in the page fault retry time check.
>>   	 */
>> -	get_task_struct(current);
>> -	bio->bi_private = current;
>>   	bio_set_op_attrs(bio, REQ_OP_READ, 0);
>> -	if (synchronous)
>> +	if (synchronous) {
>>   		bio->bi_opf |= REQ_HIPRI;
>> +		get_task_struct(current);
>> +		bio->bi_private = current;
>> +	}
>>   	count_vm_event(PSWPIN);
>>   	bio_get(bio);
>>   	qc = submit_bio(bio);


-- 
Jens Axboe

