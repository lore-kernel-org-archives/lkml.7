Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733E8C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F668218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aLewX3TL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfGXGx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:53:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38647 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfGXGx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:53:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id r9so43412613ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 23:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/C6SvXQ+6R/YS6/L/kVntLwubBzK8ruAflHed0nbReY=;
        b=aLewX3TLaQpEf+jG9eq9DR3rB2kCKnHWJojwSG6hMYifsXBJLDODudPpRS09tpfVA8
         k0qf8wDdhjVj9/qFMn1TyUVNwLz3iMFztt9kCH4NB59+ZB9e1XPhjA2jlWT4EK4xlH6L
         HcDzjQqhjYJ3JqYlFX+8m23zc0khbv+Ltlgho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/C6SvXQ+6R/YS6/L/kVntLwubBzK8ruAflHed0nbReY=;
        b=otquGURUoMwO5hqKoFdKdOFbZE8EvXswjC5G4cGsYUIFaZF3Swo/EEQINyAZ8LPUAj
         Q0C3+R2uh42vsnpMy8OqlSKqVuVCRIxASXBrG7EH4uFdviCZ5e+fEQnibXJ1gY9/EtHm
         R0YXlDc+IiBy5ARR1ludXAneFiZOGrDzo7DNB2Ql19kQcYfs0Mz0tRkzqpcHoPMnjI6w
         yMNDISxZPOChrMoAzy7Goatr9o2KgP7lNUsFF4UKcoRFHxJYOzfNG4kVSytw3jz9AHZt
         7q9wvJzmiNBnRSUM2v4xLMMacCt1VtkTZJB99qB0cWDAb8XS2P4wO/Ts5//k+s1fpZbg
         8hGQ==
X-Gm-Message-State: APjAAAW5PlvzNlcZBi98GMdN2FEezTpytVdp9V6GFjAf/oXKNcUIOknX
        rmmicVKUefKLUPp7yWZ5c6c=
X-Google-Smtp-Source: APXvYqzr9x7DR4WYz7BXPk/LyHKBpDLjCJDWYISOmQ5xhwv78XBLqqnFGP0JqxfK2W5Gk5p9CxqYMQ==
X-Received: by 2002:a2e:3008:: with SMTP id w8mr42706727ljw.13.1563951234307;
        Tue, 23 Jul 2019 23:53:54 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l11sm7812072lfc.18.2019.07.23.23.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 23:53:53 -0700 (PDT)
Subject: Re: [PATCH V2 1/2] string: Add stracpy and stracpy_pad mechanisms
To:     Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <cover.1563889130.git.joe@perches.com>
 <ed4611a4a96057bf8076856560bfbf9b5e95d390.1563889130.git.joe@perches.com>
 <ce1320d8-60df-7c54-2348-6aabac63c24d@rasmusvillemoes.dk>
 <c9ef2b56eaf36c8e5449b751ab6e5971b6b34311.camel@perches.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <dab1b433-93c0-09ab-cceb-3db91b6ef353@rasmusvillemoes.dk>
Date:   Wed, 24 Jul 2019 08:53:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c9ef2b56eaf36c8e5449b751ab6e5971b6b34311.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2019 17.39, Joe Perches wrote:
> On Tue, 2019-07-23 at 16:37 +0200, Rasmus Villemoes wrote:
>> On 23/07/2019 15.51, Joe Perches wrote:
>>>
>>> These mechanisms verify that the dest argument is an array of
>>> char or other compatible types like u8 or s8 or equivalent.
>> Sorry, but "compatible types" has a very specific meaning in C, so
>> please don't use that word.
> 
> I think you are being overly pedantic here but
> what wording do you actually suggest?

I'd just not support anything other than char[], but if you want,
perhaps say "related types", or some other informal description.

>>  And yes, the kernel disables -Wpointer-sign,
>> so passing an u8* or s8* when strscpy() expects a char* is silently
>> accepted, but does such code exist?
> 
> u8 definitely, s8 I'm not sure.

Example (i.e. of someone passing an u8* as destination to some string
copy/formatting function)? I believe you, I'd just like to see the context.

> I don't find via grep a use of s8 foo[] = "bar";
> or "signed char foo[] = "bar";
> 
> I don't think it bad to allow it.

Your patch.

>> count is just as bad as size in terms of "the expression src might
>> contain that identifier". But there's actually no reason to even declare
>> a local variable, just use ARRAY_SIZE() directly as the third argument
>> to strscpy().
> 
> I don't care about that myself.
> It's a macro local identifier and shadowing in a macro
> is common.  I'm not a big fan of useless underscores.

shadowing is not the problem. The identifier "count" appearing in one of
the "dest" or "src" expressions is. For something that's supposed to
help eliminate bugs, such a hidden footgun seems to be a silly thing to
include. No need for some hideous triple-underscore variable, just make
the whole thing

BUILD_BUG_ON(!__same_type())
strscpy(dst, src, ARRAY_SIZE(dst))

Rasmus
