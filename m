Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9DEC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD342216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RKKl14EP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbfIPNXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:23:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44851 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfIPNXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:23:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id m13so5781242ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CF3OW7d/Rf3ORtiJgzWO74mrNFNVyAWFkt1EsQbcVHY=;
        b=RKKl14EP9mpR3RvZCNbLM4UQh6i2X3PW21Kd2QhzoRmtPRBsTKJZTaQ3t0mx22RAug
         MqOqyWeIqLf82PDtEHyMoXIe75Uf2wOUl3bG9wOl55XpqUXYMeCei+MsJXshXKnuQ3Bt
         23Mw3AXsV/Lm+mTHb4MpCMM2akp2z5SMEF9Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CF3OW7d/Rf3ORtiJgzWO74mrNFNVyAWFkt1EsQbcVHY=;
        b=CQIXgXeFmKMivJIdnpCUdETlF9baP7U4GXygEIK+gq6boZVI3z/dN4HYwNe59ieyxP
         yrETyExo9X1jLaH8zMXylham8D9wytHyAtXvzaR6hCPN4aPMWSjcrm6n/QJbby4Ef7SX
         YS3Wt19x0CuBPHtpx3Z3DTS2LxGXFPy4nhr//mHDwGCqAfRcTT4tSHKkGFg64L0SXFkI
         nvGb7u0u7ixg+dOPKbkGdk2kRoKlF9dotB02Ck+tHDEG7h3+bNyhi4/D1A8MDdX+/ch7
         u9xB1/UFdC9+gm0s/Q91vSyYa4LxIKj/AqYjcDxkgofMqNHpJGixN3/t2kiQDh+7lzQg
         G3zw==
X-Gm-Message-State: APjAAAVJ9DTZ5gyFAC1EIdKecVCMvUXaUK2UryqwjaHYJUM+c2cJCWeg
        bWLrfaZ9RPsHAVoRQWHvl8VCCERGRT5IfeoP
X-Google-Smtp-Source: APXvYqxsub36ELINpkxe/5dJkTmV6qsEd7F0EC4r6abUXemDeoJgioxe7n3c4h9uWZNUJF8XlDbXuw==
X-Received: by 2002:a2e:9a18:: with SMTP id o24mr37351897lji.123.1568640223385;
        Mon, 16 Sep 2019 06:23:43 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d26sm1067639ljc.64.2019.09.16.06.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 06:23:42 -0700 (PDT)
Subject: Re: [PATCH v2] printf: add support for printing symbolic error codes
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
 <20190909203826.22263-1-linux@rasmusvillemoes.dk>
 <33592303-091c-c480-460f-e2acd89e99be@kleine-koenig.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <53331f01-dd77-b448-33ab-cb26dd4b9380@rasmusvillemoes.dk>
Date:   Mon, 16 Sep 2019 15:23:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <33592303-091c-c480-460f-e2acd89e99be@kleine-koenig.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2019 14.23, Uwe Kleine-König wrote:
> Hello Rasmus,
> 
> On 9/9/19 10:38 PM, Rasmus Villemoes wrote:
>> It has been suggested several times to extend vsnprintf() to be able
>> to convert the numeric value of ENOSPC to print "ENOSPC". This is yet
>> another attempt. Rather than adding another %p extension, simply teach
>> plain %p to convert ERR_PTRs. While the primary use case is
>>
>>   if (IS_ERR(foo)) {
>>     pr_err("Sorry, can't do that: %p\n", foo);
>>     return PTR_ERR(foo);
>>   }
>>
>> it is also more helpful to get a symbolic error code (or, worst case,
>> a decimal number) in case an ERR_PTR is accidentally passed to some
>> %p<something>, rather than the (efault) that check_pointer() would
>> result in.
>>
>> With my embedded hat on, I've made it possible to remove this.
>>
>> I've tested that the #ifdeffery in errcode.c is sufficient to make
>> this compile on arm, arm64, mips, powerpc, s390, x86 - I'm sure the
>> 0day bot will tell me which ones I've missed.
>>
>> The symbols to include have been found by massaging the output of
>>
>>   find arch include -iname 'errno*.h' | xargs grep -E 'define\s*E'
>>
>> In the cases where some common aliasing exists
>> (e.g. EAGAIN=EWOULDBLOCK on all platforms, EDEADLOCK=EDEADLK on most),
>> I've moved the more popular one (in terms of 'git grep -w Efoo | wc)
>> to the bottom so that one takes precedence.
>>
>> Acked-by: Uwe Kleine-König <uwe@kleine-koenig.org>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Even with my ack already given I still think having %pE (or %pe) for
> ints holding an error code is sensible. 

I don't understand why you'd want an explicit %p<something> to do what
%p does by itself - in fact, with the current vsnprintf implementation,
"%pe", ERR_PTR(-EFOO) would already do what you want (since after %p is
processed, all alphanumeric are skipped whether they were interpreted or
not). So we could "reserve" %pe perhaps in order to make the call sites
a little more readable, but no code change in vsnprintf.c would be
necessary.

Or did you mean %pe with the argument being an (int*), so one would do

  if (err < 0)
    pr_err("bad: %pe\n", &err);

Maybe I'd buy that one, though I don't think it's much worse to do

  if (err < 0)
    pr_err("bad: %p\n", ERR_PTR(err));

Also, the former has less type safety/type genericity than the latter;
if err happens to be a long (or s8 or s16) the former won't work while
the latter will.

Or perhaps you meant introduce a %d<something> extension? I still think
that's a bad idea, and I've in the meantime found another reason
(covering %d in particular): Netdevices can be given a name containing
exactly one occurrence of %d (or no % at all), and then the actual name
will be determined based on that pattern. These patterns are settable
from userspace. And everything of course breaks horribly if somebody set
a name to "bla%deth" and that got turned into "blaEPERMth".

> So I wonder if it would be a
> good idea to split this patch into one that introduces errcode() and
> then the patch that teaches vsprintf about emitting its return value for
> error valued pointers. Then I could rebase my initial patch for %pe on
> top of your first one.

Well, I think my patch as-is is simple enough, there's not much point
separating the few lines in vsnprintf() from the introduction of
errcode() (which, realistically, will never have other callers).

> Other than that I wonder how we can go forward from here. So I think it
> is time for v3 which picks up the few suggestions.

Yes, I have actually prepared a v3, was just waiting for additional
comments on my responses to the v2 review comments.

Rasmus
