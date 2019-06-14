Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF67DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73EA21473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8ez7ksV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfFNNES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:04:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35033 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfFNNER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:04:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so2271504wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0NGjcl1PhlTmlQBKEhNO/pymQvOq38RKXeHujLyAlas=;
        b=e8ez7ksVhiJ18DJ65ZpwPSf6E9BocN6yFfNcjCot3noqD1yJPBKEJ1x2p4y9BeqO76
         kYAiI9jaXE/GtuEOuwDJOvJhjdipBns58hum/Li41XJED4CzNY8MA44B9wq1AghrLR6g
         RCddSFxRhZo5paQ2OnFAngFDuf6PGlmSzzTKX957UySWGMgYdoHS+sCiORaDLDifGKCu
         h7MYZzqAIO5y4xj1Zs2o9FfCAobAIhSdD6G7Cs6KqfPeYYLE+EFPc9d9nzhyuIXrKsC3
         4RmYsRuTMgEa4HhNmuOoNmHtjm7xkCeWy62+Mcikj0JtZ3W55V5VkTBX9Izp9b9iR8zT
         PD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=0NGjcl1PhlTmlQBKEhNO/pymQvOq38RKXeHujLyAlas=;
        b=ewbI+HczHIOunIJ7s6XDWk93j1M+5SisNXpZZvBXJAqXZjw3hscuPR3br7OoE21zaC
         Y5Of/CDzHDQHh65kCx693/UswNWvyDIK8PxIDY2nbs+VOwnXEnpSDVeH/TFaLKFU3z7F
         ROM5uO3uuqx6niS5Pekp5NyCJAUxdSE7gafCltHoD2HU0Wuy1eNfLn3jlH76po3ddV1L
         wBZTagiy/PktslCK8nmv3ReEXYsgJz71kc6QF//59gcdeELUFvGzh/SYbwi1oOYpCuWY
         AmzyH2hNqtuLNkZvFPAJUL9/9Zz9iyxIxt6PLuvkISnjdMesf63ZnS8vDOLDQa/wskpg
         RxgQ==
X-Gm-Message-State: APjAAAXQtQ150XmXKAyJNnNIWMz2CMaBM71xrRZmYwNQXfJYrZHuzcD0
        3SR0usi9izEzoV26vzt0vRg=
X-Google-Smtp-Source: APXvYqyu4Oawg6gRA3/hOdjcOUIRQ961xVeRRP8AdU9F+i/cmxi57BsGq+perAWgZZ29rrFSv/9Jew==
X-Received: by 2002:a05:600c:1008:: with SMTP id c8mr8148825wmc.133.1560517455555;
        Fri, 14 Jun 2019 06:04:15 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id v3sm1815533wmh.31.2019.06.14.06.04.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:04:14 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 1/6] locking: add ww_mutex_(un)lock_for_each helpers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     daniel@ffwll.ch, l.stach@pengutronix.de,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        yuq825@gmail.com, eric@anholt.net, thellstrom@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, lima@lists.freedesktop.org
References: <20190614124125.124181-1-christian.koenig@amd.com>
 <20190614124125.124181-2-christian.koenig@amd.com>
 <20190614125641.GO3436@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <dce0c3c0-fd10-4d40-5815-cf91ddcc2d13@gmail.com>
Date:   Fri, 14 Jun 2019 15:04:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614125641.GO3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.06.19 um 14:56 schrieb Peter Zijlstra:
> On Fri, Jun 14, 2019 at 02:41:20PM +0200, Christian König wrote:
>> The ww_mutex implementation allows for detection deadlocks when multiple
>> threads try to acquire the same set of locks in different order.
>>
>> The problem is that handling those deadlocks was the burden of the user of
>> the ww_mutex implementation and at least some users didn't got that right
>> on the first try.
>>
>> I'm not a big fan of macros, but it still better then implementing the same
>> logic at least halve a dozen times. So this patch adds two macros to lock
>> and unlock multiple ww_mutex instances with the necessary deadlock handling.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   include/linux/ww_mutex.h | 75 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>
>> diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
>> index 3af7c0e03be5..a0d893b5b114 100644
>> --- a/include/linux/ww_mutex.h
>> +++ b/include/linux/ww_mutex.h
>> @@ -369,4 +369,79 @@ static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
>>   	return mutex_is_locked(&lock->base);
>>   }
>>   
>> +/**
>> + * ww_mutex_unlock_for_each - cleanup after error or contention
>> + * @loop: for loop code fragment iterating over all the locks
>> + * @pos: code fragment returning the currently handled lock
>> + * @contended: the last contended ww_mutex or NULL or ERR_PTR
>> + *
>> + * Helper to make cleanup after error or lock contention easier.
>> + * First unlock the last contended lock and then all other locked ones.
>> + */
>> +#define ww_mutex_unlock_for_each(loop, pos, contended)	\
>> +	if (!IS_ERR(contended)) {			\
>> +		if (contended)				\
>> +			ww_mutex_unlock(contended);	\
>> +		contended = (pos);			\
>> +		loop {					\
>> +			if (contended == (pos))		\
>> +				break;			\
>> +			ww_mutex_unlock(pos);		\
>> +		}					\
>> +	}
>> +
>> +/**
>> + * ww_mutex_lock_for_each - implement ww_mutex deadlock handling
>> + * @loop: for loop code fragment iterating over all the locks
>> + * @pos: code fragment returning the currently handled lock
>> + * @contended: ww_mutex pointer variable for state handling
>> + * @ret: int variable to store the return value of ww_mutex_lock()
>> + * @intr: If true ww_mutex_lock_interruptible() is used
>> + * @ctx: ww_acquire_ctx pointer for the locking
>> + *
>> + * This macro implements the necessary logic to lock multiple ww_mutex
>> + * instances. Lock contention with backoff and re-locking is handled by the
>> + * macro so that the loop body only need to handle other errors and
>> + * successfully acquired locks.
>> + *
>> + * With the @loop and @pos code fragment it is possible to apply this logic
>> + * to all kind of containers (array, list, tree, etc...) holding multiple
>> + * ww_mutex instances.
>> + *
>> + * @contended is used to hold the current state we are in. -ENOENT is used to
>> + * signal that we are just starting the handling. -EDEADLK means that the
>> + * current position is contended and we need to restart the loop after locking
>> + * it. NULL means that there is no contention to be handled. Any other value is
>> + * the last contended ww_mutex.
>> + */
>> +#define ww_mutex_lock_for_each(loop, pos, contended, ret, intr, ctx)	\
>> +	for (contended = ERR_PTR(-ENOENT); ({				\
>> +		__label__ relock, next;					\
>> +		ret = -ENOENT;						\
>> +		if (contended == ERR_PTR(-ENOENT))			\
>> +			contended = NULL;				\
>> +		else if (contended == ERR_PTR(-EDEADLK))		\
>> +			contended = (pos);				\
>> +		else							\
>> +			goto next;					\
>> +		loop {							\
>> +			if (contended == (pos))	{			\
>> +				contended = NULL;			\
>> +				continue;				\
>> +			}						\
>> +relock:									\
>> +			ret = !(intr) ? ww_mutex_lock(pos, ctx) :	\
>> +				ww_mutex_lock_interruptible(pos, ctx);	\
>> +			if (ret == -EDEADLK) {				\
>> +				ww_mutex_unlock_for_each(loop, pos,	\
>> +							 contended);	\
>> +				contended = ERR_PTR(-EDEADLK);		\
>> +				goto relock;				\
>> +			}						\
>> +			break;						\
>> +next:									\
>> +			continue;					\
>> +		}							\
>> +	}), ret != -ENOENT;)
>> +
> Yea gawds, that's eyebleeding bad, even for macros :/

Yeah, I actually don't like it that much either.

But we have at least 8 implementations of this and I'm going to add 
number 9 rather soon.

> It also breaks with pretty much all other *for_each*() macros in
> existence by not actually including the loop itself but farming that out
> to an argument statement (@loop), suggesting these really should not be
> called for_each.

How about ww_mutex_lock_multiple? If not feel free to suggest anything.

Also I'm open to suggestions how to approach that differently, but my 
other tries (callback functions mostly) just somehow suck badly as well.

Thanks,
Christian.
