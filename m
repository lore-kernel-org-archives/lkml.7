Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010CEC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C286020825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="bEy8USgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbfIELk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:40:29 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38128 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbfIELk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:40:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id c12so1740202lfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XcJcXjGOB/i8nxHcfDcVFa8PSJXHp4wNqu19LnvH6Hg=;
        b=bEy8USgxFpZtqBtIfoh649kkQQ54zhaqNctgGNrKNLvjmfClOeGlUMJC1ozgq4j0X0
         Iao8qXIYmsCkdVE6z/fthHJApi3Qj7vk6XOBv+F50dOayLY7wFm2krEza0hPcuoj86Wg
         /tY56GTGk2oyJCYlCQFBqzHPIjff3i1U3echw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XcJcXjGOB/i8nxHcfDcVFa8PSJXHp4wNqu19LnvH6Hg=;
        b=N3ucvxShWMBFbuc1hmTA3FkVGxGtcn4gyvJ1cBZmaqEpYVIq+/cqgPls0MX7/dB3zs
         KjrMS9do0fKcmOkQrvfDDzslw1coi4aj1tARrUtP+uSXSTfsEQKXu7koIoxVmvbHfx6L
         uB+7W3PiCXuqtuOKQUbNBoeomyAnOsWkrD60mxWQnr9oPRp1CVdwDUsnMuOmxK+XKGvP
         4YqCXDdvqlIP12YuKbh6SebYh986lU+/5RN4OQBnWcNBHvQr6PTKoBi5B24vGfHbUF6s
         O3uQoRIjnlHYa418vyduzFqE3/yVR+ee/OepBfGPoZbtibtrRiqSvo/mxJ0ZJhQDGaJr
         8n0A==
X-Gm-Message-State: APjAAAU83f5kgPbersxNdf+DB6rRVjqnbOnDWF/2WVEOroKpnSJ+P/Eb
        6nQ/F8P7D/k1VdRjAaTzx71J7R+mLK9ULquorFg=
X-Google-Smtp-Source: APXvYqzv+Qz5B65Ps7DpYW5dztp1EeERO93zac29yMaB/pAcgJAddcnATTkDO6LVFxF0m2oSna6g+w==
X-Received: by 2002:ac2:4289:: with SMTP id m9mr1817066lfh.139.1567683625539;
        Thu, 05 Sep 2019 04:40:25 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 134sm383066lfk.70.2019.09.05.04.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 04:40:25 -0700 (PDT)
Subject: Re: [PATCH] printf: add support for printing symbolic error codes
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joe Perches <joe@perches.com>, Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190830214655.6625-1-linux@rasmusvillemoes.dk>
 <CAHp75VcAEK0KioX-mvHeRqpX+c8Y7_A5X8RqmtHUT-MU-dXy6A@mail.gmail.com>
 <bf898c97-5f72-93c4-e6b7-be81c6903b50@kleine-koenig.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <30ffb8a4-1fdb-5260-f6e5-57ea78a85174@rasmusvillemoes.dk>
Date:   Thu, 5 Sep 2019 13:40:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bf898c97-5f72-93c4-e6b7-be81c6903b50@kleine-koenig.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2019 18.28, Uwe Kleine-König wrote:
> On 9/4/19 6:19 PM, Andy Shevchenko wrote:
>> On Sat, Aug 31, 2019 at 12:48 AM Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:
>>>
>>
>>> +/*
>>> + * Ensure these tables to not accidentally become gigantic if some
>>> + * huge errno makes it in. On most architectures, the first table will
>>> + * only have about 140 entries, but mips and parisc have more sparsely
>>> + * allocated errnos (with EHWPOISON = 257 on parisc, and EDQUOT = 1133
>>> + * on mips), so this wastes a bit of space on those - though we
>>> + * special case the EDQUOT case.
>>> + */
>>> +#define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = #err
>>
>> Hmm... Perhaps better to define the upper boundary with something like
>>
>> #define __E_POSIX_UPPER_BOUNDARY 300 // name sucks, I know
>>
>>> +#define E(err) [err - 512 + BUILD_BUG_ON_ZERO(err < 512 || err > 550)] = #err
>>
>> Similar to 550?
> 
> I'd not add "POSIX" in the name. Given that the arrays are called
> codes_0 and codes_512 I don't think using plain numbers hurts much and
> choosing a good name is hard, so I suggest to keep the explicit numbers.

I agree, adding random macro names for these essentially arbitrary (and
one-time use) numbers doesn't make sense. Remember that the sizing of
the arrays is done automatically by gcc. I suppose an alternative is to
drop the BUILD_BUG_ON_ZEROs from the E() defines and then just have some
static_assert(ARRAY_SIZE(codes_0) < 300) - but the advantage of the
above is that one gets to know _which_ E* has a huge value (that is how
I caught EDQUOT on MIPS).

>>> +const char *errcode(int err)
>>> +{
>>> +       /* Might as well accept both -EIO and EIO. */
>>> +       if (err < 0)
>>> +               err = -err;
>>> +       if (err <= 0) /* INT_MIN or 0 */
>>> +               return NULL;
>>> +       if (err < ARRAY_SIZE(codes_0))
>>> +               return codes_0[err];
>>> +       if (err >= 512 && err - 512 < ARRAY_SIZE(codes_512))
>>> +               return codes_512[err - 512];
>>> +       /* But why? */
>>> +       if (IS_ENABLED(CONFIG_MIPS) && err == EDQUOT) /* 1133 */
>>> +               return "EDQUOT";
>>
>> Another possibility is to initialize the errors at run time with radix tree.
> 
> The idea was to save space. But when using a radix tree this has
> overhead compared to the lists here, and you still need a map for
> error-code -> error-name to initialize the radix tree. Also a lookup is
> slower than with the idea implemented here. So it's bigger, slower and
> more complicated ... I don't think we should do that.

Yes, a radix tree is unlikely to end up saving space at all.
Moreover, any initialization at run-time means there's some window where
we don't have them, and printk() should work as early as possible (and I
really don't want to add any kind of synchronization "are we initialized
yet", just see what that did to the pointer hashing). So I'll stick with
the arrays.

>>> @@ -2111,6 +2112,31 @@ static noinline_for_stack
>>>  char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>>>               struct printf_spec spec)
>>>  {
>>> +       /* %px means the user explicitly wanted the pointer formatted as a hex value. */
>>> +       if (*fmt == 'x')
>>> +               return pointer_string(buf, end, ptr, spec);
>>
>> But instead of breaking switch case apart can we use...
>>
>>> +
>>> +       /* If it's an ERR_PTR, try to print its symbolic representation. */
>>> +       if (IS_ERR(ptr)) {
>>
>> ...  if (IS_ERR() && *fmt != 'x') {
>> here?

This makes sense, I think I'll do it that way. Thanks.

Rasmus
