Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CA6C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5E920863
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="iQ/NftHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfI2UJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 16:09:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37017 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfI2UJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 16:09:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id r4so6772501edy.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 13:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vMpbpEn9OgDbzEgcHHH7EMmzlWsUyrT9xZBt/RkIANU=;
        b=iQ/NftHug8unU7o0pQG/+yMkcau5U4K4fIfJqM8jPXlaPaLsEbxQ8x33xuSuwaN583
         4fKS6rvBJmgrjRHfGlld/SbnM+PA29Vqtr9/JdSs7G1sNcM0MzH4GxjPHyGrbUF2nr6w
         /DuwpG0caHCchuibXsqm1X0PDmWR3VCM5R1ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vMpbpEn9OgDbzEgcHHH7EMmzlWsUyrT9xZBt/RkIANU=;
        b=fLUolgaSMb4OXGWB7yRjnVjd1wQFHLyInDc9Gxq/U/ay5PUF4gdSyCix/2o66RbvQu
         E6juYHWbrPdqDbq9tSEWWZYzuShAWKCviUQ/odHN0R9ELul8uCw8/sVpqvWRW88UxRw5
         KR4GMn8pP20nwcoEvzVnz404vhzwafLHKSomSE0MCNIm+Eff7INP5j/Ri/D0NrD2yIfb
         /Gtvsza8E2upQG0/DtxklEcNUfQpr20wgfMuncTDHWPWO/R0Q+KQ8A3jzFQ0MqKZQYhj
         ByGundKURRj4NiaDDa1hp4sXhPCbDQ+6vPWr4r5yx/qNIjaTo/DDcSm+SUrUEn5PIzB3
         CnKg==
X-Gm-Message-State: APjAAAXks81A7YFphQuDgY1aLu8VqA9ITsTwHEYLlSpC0ANn7DviqQju
        pO8HhVtrxjm42T1UwzVWtbPBsOXoX/my1A==
X-Google-Smtp-Source: APXvYqyafLtJty5UcKymnAYj9kNGX5FI2UBEEUaMwaq3QLxXwaJbwd3H/iSmz98eUIi1PwKKdj6R3Q==
X-Received: by 2002:aa7:d4c5:: with SMTP id t5mr16008573edr.154.1569787770093;
        Sun, 29 Sep 2019 13:09:30 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id ha2sm1234117ejb.63.2019.09.29.13.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 13:09:29 -0700 (PDT)
Subject: Re: [PATCH v3] printf: add support for printing symbolic error codes
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>, Pavel Machek <pavel@ucw.cz>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190909203826.22263-1-linux@rasmusvillemoes.dk>
 <20190917065959.5560-1-linux@rasmusvillemoes.dk>
 <20190925143612.3tryimrvyfcqb2ez@pathway.suse.cz>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0dc89711-fce0-0500-2476-950767b2202a@rasmusvillemoes.dk>
Date:   Sun, 29 Sep 2019 22:09:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925143612.3tryimrvyfcqb2ez@pathway.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2019 16.36, Petr Mladek wrote:
> First, I am sorry that I replay so late. I was traveling the previous
> two weeks and was not able to follow the discussion about this patch.
> 
> I am fine with adding this feature. But I would like to do it
> a cleaner way, see below.
> 
> 
> On Tue 2019-09-17 08:59:59, Rasmus Villemoes wrote:
>> With my embedded hat on, I've made it possible to remove this.
>>
>> I've tested that the #ifdeffery in errcode.c is sufficient to make
>> this compile on arm, arm64, mips, powerpc, s390, x86 - I'm sure the
>> 0day bot will tell me which ones I've missed.
> 
> Please, remove the above two paragraphs in the final patch. They make
> sense for review but not for git history.

Agree for the latter, but not the former - I do want to explain why it's
possible to configure out; see also below.

> This change would deserve to spend some time in linux-next. Anyway,
> it is already too late for 5.4.

Yes, it's of course way too late now. Perhaps I should ask you to take
it via the printk tree? Anyway, let's see what we can agree to.

> The word "code" is quite ambiguous. I am not sure if it is the name or
> the number. I think that it is actually both (the relation between
> the two.
> 
> Both "man 3 errno" and
> https://www.gnu.org/software/libc/manual/html_node/Checking-for-Errors.html#Checking-for-Errors
> talks about numbers and symbolic names.
> 
> Please use errname or so instead of errcode everywhere.

OK. I wasn't too happy about errcode anyway - but I wanted to avoid
"str" being in there to avoid anyone thinking it was a strerror(). So
"CONFIG_SYMBOLIC_ERRNAME" and errname() seems fine with the above
justification.

>> +config SYMBOLIC_ERRCODE
> 
> What is the exact reason to make this configurable, please?
> 
> Nobody was really against this feature. The only question
> was if it was worth the code complexity and maintenance.
> If we are going to have the code then we should use it.
> 
> Then there was a concerns that it might be too big for embedded
> people. But did it come from people working on embedded kernel
> or was it just theoretical?

I am one such person, and while 3K may not be a lot, death by a thousand
paper cuts...

> I would personally enable it when CONFIG_PRINTK is enabled.

Agree. So let's make it 'default y if PRINTK'? These are only/mostly
useful when destined for dmesg, I can't imagine any of the sysfs/procfs
uses of vsprintf() to want this. So if somebody has gone to the rather
extremely length of disabling printk (which even I rarely do), they
really want the absolute minimal kernel, and would not benefit from this
anyway. While for the common case, it gets enabled for anyone that just
updates their defconfig and accepts new default values.

> We could always introduce a new config option later when
> anyone really wants to disable it.

No, because by the time the kernel has grown too large for some target,
it's almost impossible to start figuring out which small pieces can be
chopped away with suitable config options, and even harder to get
upstream to accept such configurability ("why, that would only gain you
3K...").

>> --- /dev/null
>> +++ b/lib/errcode.c
>> @@ -0,0 +1,212 @@
>> +#define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = #err
>> +static const char *codes_0[] = {
>> +	E(E2BIG),
> 
> I really like the way how the array is initialized.

Thanks.

> 
>> diff --git a/lib/test_printf.c b/lib/test_printf.c
>> index 944eb50f3862..0401a2341245 100644
>> --- a/lib/test_printf.c
>> +++ b/lib/test_printf.c
>> +static void __init
>> +errptr(void)
>> +{
>> +	test("-1234", "%p", ERR_PTR(-1234));
>> +	test(FFFFS "ffffffff " FFFFS "ffffff00", "%px %px", ERR_PTR(-1), ERR_PTR(-256));
>> +#ifdef CONFIG_SYMBOLIC_ERRCODE
>> +	test("EIO EINVAL ENOSPC", "%p %p %p", ERR_PTR(-EIO), ERR_PTR(-EINVAL), ERR_PTR(-ENOSPC));
>> +	test("EAGAIN EAGAIN", "%p %p", ERR_PTR(-EAGAIN), ERR_PTR(-EWOULDBLOCK));
> 
> I like that you check more values. But please split it to check
> only one value per line to make it better readable.

Hm, ok, but I actually do it this way on purpose - I want to ensure that
the test where one passes a random not-zero-but-too-small buffer size
sometimes hits in the middle of the %p output, sometimes just before and
sometimes just after. The very reason I added test_printf was because
there were some %p extensions that violated the basic rule of
snprintf()'s return value and/or wrote beyond the provided buffer.

Not a big deal, so if you insist I'll break it up.

> 
>> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
>> index b0967cf17137..299fce317eb3 100644
>> --- a/lib/vsprintf.c
>> +++ b/lib/vsprintf.c
>> @@ -2111,6 +2112,31 @@ static noinline_for_stack
>>  char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>>  	      struct printf_spec spec)
>>  {
>> +	/*
>> +	 * If it's an ERR_PTR, try to print its symbolic
>> +	 * representation, except for %px, where the user explicitly
>> +	 * wanted the pointer formatted as a hex value.
>> +	 */
>> +	if (IS_ERR(ptr) && *fmt != 'x') {
> 
> We had similar code before the commit 3e5903eb9cff70730171 ("vsprintf:
> Prevent crash when dereferencing invalid pointers"). Note that the
> original code kept the original value also for *fmt == 'K'.
> 
> Anyway, the above commit tried to unify the handling of special
> values:
> 
>    + use the same strings for special values
>    + check for special values only when pointer is dereferenced
> 
> This patch makes it inconsistent again. I mean that the code will:
> 
>    + check for (null) and (efault) only when the pointer is
>      dereferenced
> 
>    + check for err codes in more situations but not in all
>      and not in %s
>
>    + use another style to print the error (uppercase without
>       brackets)
> 
> 
> I would like to keep it consistent. My proposal is:
> 
> 1. Print the plain error code name only when
>    a new %pe modifier is used. This will be useful
>    in the error messages, e.g.
> 
> 	void *p = ERR_PTR(-ENOMEM);
> 	if (IS_ERR(foo)) {
> 		pr_err("Sorry, can't do that: %pe\n", foo);
> 	return PTR_ERR(foo);
> 
>    would produce
> 
> 	Sorry, can't do that: -ENOMEM

Well, we can certainly do that. However, I didn't want that for two
reasons: (1) I want plain %p to be more useful when passed an ERR_PTR.
Printing the value, possibly symbolically, doesn't leak anything about
kernel addresses, so the hashing is pointless and just makes the
printk() less useful - and non-repeatable across reboots, making
debugging needlessly harder. (2) With a dedicated extension, we have to
define what happens if a non-ERR_PTR gets passed as %pe argument. [and
(3), we're running out of %p<foo> namespace].

So, if you have some good answer to (2) I can do that - but if the
answer is "fall through to handling it as just a normal %p", well, then
we haven't really won much. And I don't see what else we could do -
print "(!ERR_PTR)"?

> 2. Use error code names also in check_pointer_msg() instead
>    of (efault). But put it into brackets to distinguish it
>    from the expected value, for example:
> 
>       /* valid pointer */
>       phys_addr_t addr = 0xab;
>       printk("value: %pa\n", &addr);
>       /* known error code */
>       printk("value: %pa\n", ERR_PTR(-ENOMEM));
>       /* unknown error code */
>       printk("value: %pa\n", ERR_PTR(-1234));
> 
>    would produce:
> 
>      value: 0xab
>      value: (-ENOMEM)
>      value: (-1234)

Yes, I think this is a good idea. But only for ERR_PTRs, for other
obviously-not-a-kernel-address pointer values (i.e. the < PAGE_SIZE
case) we still need some other string.

So how about I try to add something like this so that
would-be-dereferenced ERR_PTRs get printed symbolically in brackets,
while I move the check for IS_ERR() to after the switch() (i.e. before
handing over to do the hashing)? Then all ERR_PTRs get printed
symbolically - except for %px and possibly %pK which are explicitly
"print this value".

> 3. Unify the style for the null pointer:
> 
>     + use (NULL) instead of (null)

Yes, that's better. But somewhat out of scope for this patch.

> 4. Do not use error code names for internal vsprintf error
>    to avoid confusion. For example:
> 
>     + replace the one (einval) with (%piS-err) or so
> 
> How does that sound, please?

Oh, yes, I never was a fan of the (einval) (efault) strings.

Rasmus
