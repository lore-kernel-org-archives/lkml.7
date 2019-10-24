Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7258ACA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4897C21655
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 03:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="l5kJGcsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437228AbfJXDc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 23:32:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35542 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392870AbfJXDcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 23:32:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id c8so8544526pgb.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 20:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x9yyQ2FOaYcmSfcpOJxtcwGG2Qu1XU68PHFcRqzXa3M=;
        b=l5kJGcsHDzkhBVaQTnz47UD9J1r2EmTtlolEqaO5EjuBlCtue3iG0RvKqmtBm2YwXR
         +8xepoTs24e/xk4M/s+f7E7+EwKKKZp/FE5YERFeXwtjz1auyqSYxDJUMg8UbLlaPFdB
         3VffsRs0Ugwj+erGFiWCyDNCi9CJRFmgsh7fQHFjQ9wNJPwdh/k2PXzAOk0VFHWDHWu+
         IajaTpK1/Gk7IONkVrWywQ/wiPOs4C5HohianltFhvm24sSeWfmeoRgxEk9olnOESANF
         O6TMAkmFj5lXneRX4r7OL4lDekc3wS/p1piBZzlQcYYcdTguBhAAsN5e4jrx1Bc5YZT1
         OK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x9yyQ2FOaYcmSfcpOJxtcwGG2Qu1XU68PHFcRqzXa3M=;
        b=OdPP2J5ALBsneCRzmIsFkj5j0Nw4OLyIuwFY4ESjcLrgzNWtXX/DM8yfbMLzt3jYCm
         Lg17GsrmcZsKorYbqq6tvSJ6NuRROqWlzGVMODbn01biMweYkdJyL5ZaAXW4+JQ4MWUo
         AmiiOTQSGLvT6glTDTOzhx0bU7KLqA5DdbaHvzjpAVpgWJMI2o6KSiLmKb8SpfJlQlTc
         eWq72czsGJ9jB3PRMMQiUP9UiXd+gV6hzovSH9QxgLgN1TWsb1v4fd1PuujV7ymc2P//
         Q5dMQ4eUkqjSBDnINrfB+8zJ5Ft+r9dyssPXGtan+XYcfVlNRvh4CoQ8ZAF65Xhba9WS
         kAYA==
X-Gm-Message-State: APjAAAUXrNP6a+XHNw9e+n1sYEy70jzrPEyfFMk5j9HnBwQt5y/9vRW1
        2ppM6BZrVTYggqqUthQeaxFkKw==
X-Google-Smtp-Source: APXvYqxbNeSTJySZFCyFfN/ef676Nbp3ELs2xUm7ue0KSYLuBZnSumm7Lik1hNs0oOuY7TDT2WmUdg==
X-Received: by 2002:a63:c40e:: with SMTP id h14mr13966574pgd.254.1571887975017;
        Wed, 23 Oct 2019 20:32:55 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id n2sm25393079pgg.77.2019.10.23.20.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 20:32:54 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: remove needless goto from blk_mq_get_driver_tag
To:     Bart Van Assche <bvanassche@acm.org>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, krisman@collabora.com
References: <20191022174108.15554-1-andrealmeid@collabora.com>
 <2a8a99a6-4b39-e459-988a-ba9502919044@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f3e19c37-2430-81d5-ed5b-bc15d93e93c2@kernel.dk>
Date:   Wed, 23 Oct 2019 21:32:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2a8a99a6-4b39-e459-988a-ba9502919044@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/19 7:34 PM, Bart Van Assche wrote:
> On 2019-10-22 10:41, André Almeida wrote:
>> The only usage of the label "done" is when (rq->tag != -1) at the
>> begging of the function. Rather than jumping to label, we can just
>> remove this label and execute the code at the "if". Besides that,
>> the code that would be executed after the label "done" is the return of
>> the logical expression (rq->tag != -1) but since we are already inside
>> the if, we now that this is true. Remove the label and replace the goto
>> with the proper result of the label.
>>
>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
>> ---
>> Hello,
>>
>> I've used `blktest` to check if this change add any regression. I have
>> used `./check block` and I got the same results with and without this
>> patch (a bunch of "passed" and three "not run" because of the virtual
>> scsi capabilities). Please let me know if there would be a better way to
>> test changes at block stack.
>>
>> This commit was rebase at linux-block/for-5.5/block.
>>
>> Thanks,
>> 	André
>> ---
>>   block/blk-mq.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8538dc415499..1e067b78ab97 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1036,7 +1036,7 @@ bool blk_mq_get_driver_tag(struct request *rq)
>>   	bool shared;
>>   
>>   	if (rq->tag != -1)
>> -		goto done;
>> +		return true;
>>   
>>   	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
>>   		data.flags |= BLK_MQ_REQ_RESERVED;
>> @@ -1051,7 +1051,6 @@ bool blk_mq_get_driver_tag(struct request *rq)
>>   		data.hctx->tags->rqs[rq->tag] = rq;
>>   	}
>>   
>> -done:
>>   	return rq->tag != -1;
>>   }
> 
> Do we really need code changes like the above? I'm not aware of any text
> in the Documentation/ directory that forbids the use of goto statements.

Agree, it looks fine as-is. It's also a fast path, so I'd never get rid
of that without looking at the generated code.

-- 
Jens Axboe

