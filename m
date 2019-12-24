Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7598BC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 16:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCF120722
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 16:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nz81BWD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfLXQNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 11:13:34 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35029 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfLXQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 11:13:33 -0500
Received: by mail-pj1-f65.google.com with SMTP id s7so1395378pjc.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 08:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nMi7a9jSqUZMAu/b8TapOOHFxEObE8A/Xz8veWpg0BM=;
        b=nz81BWD2b0msWRjjlepOFGHqrgBHt0hep2ADeZWnWUkyZJjdlA3EQLMpF38mafIy5V
         H8hYU0DLpr0zG++oViAZrYUt56iJUwvOSGYoumm0Pr1GaWSwjVZVMhAJfpS3zUUG6rYd
         Trb7OPRwowEFY1WxLBo57NsIMTYS9crGaL75lsrJ60a550Er2AggeBzoaXfenrLI5pJl
         WdOnVU3Er87Qvlnq2WuWXsQlkgzgILhLo9eEOdEPOYaIxpDiM41a671lYIHfndBhxq6v
         ErFJ8W7CJfr2SeEvJ6Z7L+hLSRUApdjZPzawACw62S1pFTcQ2txOzQ9ZfvOgDHtzsK4a
         My8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nMi7a9jSqUZMAu/b8TapOOHFxEObE8A/Xz8veWpg0BM=;
        b=SINwy4+FTJWB5Ilp2Isxi/1lnD2C1oCId6qpnjrjAZiyVxl7VfscC1tEjNW5dIr6iI
         vT7uXv/XjYtCRg4+u8sLSOOI916A0Xmx30HfyZDYwx9Y3rCMQvzoeIo86u6fRajflJ+Y
         kDw7x0bXFsnD7bAfhH53zB9NyOu8PCR0NAXKsbjc2OG4ho57IQkwGDhfPB8fmva32hMe
         eR7Fa5kzcQDc4g7HF3CY5BZR+ZlLt3p9zQnsx9q2yeITi0lhDASJIFjYXoSYn3iqvun4
         rWEh11hYLcTnzQ49VXpuxwJWOdPAOwSCn5kVFF+AabtTE+f8S6K/O4OafTOtusKMG8Eo
         4aFQ==
X-Gm-Message-State: APjAAAUjcdtdtdGphV/0iWqBhdL17Bf0ou2VgcHIFM8J3uHhsz9D7b6p
        p6kfNcLzEb4d1JXJfcY4DqA0AxsgU0Y22w==
X-Google-Smtp-Source: APXvYqy1k33O0k6F6ENbx6WIu6dnM0hipGrM41CdQmUPPJ0Ih+tPafK+KJ2wsudsTu8wyJoHps5deQ==
X-Received: by 2002:a17:90a:1b4d:: with SMTP id q71mr6679503pjq.82.1577204012697;
        Tue, 24 Dec 2019 08:13:32 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id s131sm9738627pfs.135.2019.12.24.08.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2019 08:13:32 -0800 (PST)
Subject: Re: [RFC PATCH] io-wq: kill cpu hog worker
To:     Hillf Danton <hdanton@sina.com>
Cc:     io-uring@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
References: <20191223024145.11580-1-hdanton@sina.com>
 <20191224115415.1360-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b91775e3-e6f4-d5dc-0790-60599c96dfd3@kernel.dk>
Date:   Tue, 24 Dec 2019 09:13:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191224115415.1360-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/19 4:54 AM, Hillf Danton wrote:
> 
> On Mon, 23 Dec 2019 08:15:00 -0700 Jens Axboe wrote:
>>
>> On 12/22/19 7:41 PM, Hillf Danton wrote:
>>>
>>> Reschedule the current IO worker if it is becoming a cpu hog.
>>
>> Might make more sense to put this a bit earlier, to avoid the
>> awkward lock juggle. In theory it shouldn't make a difference
>> if we do it _before_ doing new work, or _after_ doing work. We
>> should only be rescheduling if it's running for quite a while.
>>
>> How about putting it after the flushing of signals instead?
> 
> 
> All right, thanks.
> 
> Hillf
> --->8---
> From: Hillf Danton <hdanton@sina.com>
> Subject: [RFC PATCH] io-wq: kill cpu hog worker
> 
> Reschedule the current IO worker to cut the risk that it is becoming
> a cpu hog.
> 
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -432,6 +432,8 @@ next:
>  		if (signal_pending(current))
>  			flush_signals(current);
>  
> +		cond_resched();
> +
>  		spin_lock_irq(&worker->lock);
>  		worker->cur_work = work;
>  		spin_unlock_irq(&worker->lock);
> --

That looks better, applied.

-- 
Jens Axboe

