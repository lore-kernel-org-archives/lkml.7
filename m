Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96514C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD7220850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uISqou4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfFNNGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:06:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37176 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFNNGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:06:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so2479556wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=nTZn4SPyaDhTYZFH09HWgAuSrH1KouQZuk7dsEDnlqQ=;
        b=uISqou4LxLmTnnqWGFBqhAPO23d6mu/AW9eI3GyVLhFvndewDRgAq3Z3hihsyOV6nw
         PAyJ22JEJgAhKt/b6bITbIuyIyHqgOdW/xO1MaGFlUV42mE8kBzJFPE/VuMtqupIIs+F
         Yip+tv9YQSVjxWIUyPSxtR5yljKyAR3M3aad7xGy6TnEuuJ5HjTZu7u0UiPuWO/TEu4D
         3bcQfE6QxvixdTHZDw57Z0EUDmb81DbAz9zP28yEOXC4GZ1/A67W23wqJcbeg4voQCxe
         mXp1HY0/EhcGBQArOTP+V+dtGh1JqDezG0AhaJQjojdbC9In9I6u06mtqnFRxe7Dubda
         Mo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=nTZn4SPyaDhTYZFH09HWgAuSrH1KouQZuk7dsEDnlqQ=;
        b=QYoejdx7NUU0jF3D5vP/xOfmEqKXt9nclTxiDHu0RLM18KO1LW1FEsPiEJDwLik6ZA
         I8cay+Nzn2yyWYtXwNpTrLDjmKvzB1Bs5nfQp0lDIkhHClGk19OnkI0VA8pu4uXWjvOK
         q6ciWES/5MPSaJZmtZ0yxYnf6IZ1sEix8MWsQbUMGJujY2KTUVELO5k1fXP5D8/uvCkM
         47UCj1VOA4D5dLf+r3sDHYuBZa4Fc4C4Jw5PjYRhNMSS1RUuY/m7TfdRcC6eue6GocUY
         NYTbJpxlk5XyPuWDAGC5kYpbFZJKgZI3neo5xdIyagpABvMVzysw/mKCmNW3niEIj+aK
         ESnQ==
X-Gm-Message-State: APjAAAVu1CkmfxdT3QTGBHdY9iigtobBiSW5fF9ULJGruxFD5k7PK2Wa
        O4PXMMzPNDSVePQHNUko6Mc=
X-Google-Smtp-Source: APXvYqwjBP7EiFJtJl6Gd+2P+l2hqIJIJCystRgVNNoAwdLgZYK4Fqtr/av2vHBXDXXip9t6AMeKWw==
X-Received: by 2002:adf:8044:: with SMTP id 62mr16770652wrk.20.1560517572880;
        Fri, 14 Jun 2019 06:06:12 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id w2sm1692473wrr.31.2019.06.14.06.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:06:12 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 3/6] drm/gem: use new ww_mutex_(un)lock_for_each macros
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     daniel@ffwll.ch, l.stach@pengutronix.de,
        linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        yuq825@gmail.com, eric@anholt.net, thellstrom@vmware.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, lima@lists.freedesktop.org
References: <20190614124125.124181-1-christian.koenig@amd.com>
 <20190614124125.124181-4-christian.koenig@amd.com>
 <20190614125940.GP3436@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6f2084ae-61d5-8cb9-c975-901456eed7e3@gmail.com>
Date:   Fri, 14 Jun 2019 15:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614125940.GP3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.06.19 um 14:59 schrieb Peter Zijlstra:
> On Fri, Jun 14, 2019 at 02:41:22PM +0200, Christian König wrote:
>> Use the provided macros instead of implementing deadlock handling on our own.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/drm_gem.c | 49 ++++++++++-----------------------------
>>   1 file changed, 12 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
>> index 50de138c89e0..6e4623d3bee2 100644
>> --- a/drivers/gpu/drm/drm_gem.c
>> +++ b/drivers/gpu/drm/drm_gem.c
>> @@ -1307,51 +1307,26 @@ int
>>   drm_gem_lock_reservations(struct drm_gem_object **objs, int count,
>>   			  struct ww_acquire_ctx *acquire_ctx)
>>   {
>> -	int contended = -1;
>> +	struct ww_mutex *contended;
>>   	int i, ret;
>>   
>>   	ww_acquire_init(acquire_ctx, &reservation_ww_class);
>>   
>> -retry:
>> -	if (contended != -1) {
>> -		struct drm_gem_object *obj = objs[contended];
>> -
>> -		ret = ww_mutex_lock_slow_interruptible(&obj->resv->lock,
>> -						       acquire_ctx);
>> -		if (ret) {
>> -			ww_acquire_done(acquire_ctx);
>> -			return ret;
>> -		}
>> -	}
>> -
>> -	for (i = 0; i < count; i++) {
>> -		if (i == contended)
>> -			continue;
>> -
>> -		ret = ww_mutex_lock_interruptible(&objs[i]->resv->lock,
>> -						  acquire_ctx);
>> -		if (ret) {
>> -			int j;
>> -
>> -			for (j = 0; j < i; j++)
>> -				ww_mutex_unlock(&objs[j]->resv->lock);
>> -
>> -			if (contended != -1 && contended >= i)
>> -				ww_mutex_unlock(&objs[contended]->resv->lock);
>> -
>> -			if (ret == -EDEADLK) {
>> -				contended = i;
>> -				goto retry;
> retry here, starts the whole locking loop.
>
>> -			}
>> -
>> -			ww_acquire_done(acquire_ctx);
>> -			return ret;
>> -		}
>> -	}
> +#define ww_mutex_unlock_for_each(loop, pos, contended) \
> +       if (!IS_ERR(contended)) {                       \
> +               if (contended)                          \
> +                       ww_mutex_unlock(contended);     \
> +               contended = (pos);                      \
> +               loop {                                  \
> +                       if (contended == (pos))         \
> +                               break;                  \
> +                       ww_mutex_unlock(pos);           \
> +               }                                       \
> +       }
> +
>
> +#define ww_mutex_lock_for_each(loop, pos, contended, ret, intr, ctx)   \
> +       for (contended = ERR_PTR(-ENOENT); ({                           \
> +               __label__ relock, next;                                 \
> +               ret = -ENOENT;                                          \
> +               if (contended == ERR_PTR(-ENOENT))                      \
> +                       contended = NULL;                               \
> +               else if (contended == ERR_PTR(-EDEADLK))                \
> +                       contended = (pos);                              \
> +               else                                                    \
> +                       goto next;                                      \
> +               loop {                                                  \
> +                       if (contended == (pos)) {                       \
> +                               contended = NULL;                       \
> +                               continue;                               \
> +                       }                                               \
> +relock:                                                                        \
> +                       ret = !(intr) ? ww_mutex_lock(pos, ctx) :       \
> +                               ww_mutex_lock_interruptible(pos, ctx);  \
> +                       if (ret == -EDEADLK) {                          \
> +                               ww_mutex_unlock_for_each(loop, pos,     \
> +                                                        contended);    \
> +                               contended = ERR_PTR(-EDEADLK);          \
> +                               goto relock;                            \
>
> while relock here continues where it left of and doesn't restart @loop.
> Or am I reading this monstrosity the wrong way?

contended = ERR_PTR(-EDEADLK) makes sure that the whole loop is 
restarted after retrying to acquire the lock.

See the "if" above "loop".

Christian.

>
> +                       }                                               \
> +                       break;                                          \
> +next:                                                                  \
> +                       continue;                                       \
> +               }                                                       \
> +       }), ret != -ENOENT;)
> +
>
>> +	ww_mutex_lock_for_each(for (i = 0; i < count; i++),
>> +			       &objs[i]->resv->lock, contended, ret, true,
>> +			       acquire_ctx)
>> +		if (ret)
>> +			goto error;
>>   
>>   	ww_acquire_done(acquire_ctx);
>>   
>>   	return 0;
>> +
>> +error:
>> +	ww_mutex_unlock_for_each(for (i = 0; i < count; i++),
>> +				 &objs[i]->resv->lock, contended);
>> +	ww_acquire_done(acquire_ctx);
>> +	return ret;
>>   }
>>   EXPORT_SYMBOL(drm_gem_lock_reservations);

