Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F92DC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABE7214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 09:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="arJ0Fs/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbfIMJSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 05:18:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39611 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfIMJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 05:18:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id j16so26412142ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 02:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LO5l725TC7S+8bCG/4dlZNuzhvj1SgEvwbf4wk8dwd8=;
        b=arJ0Fs/vHF+gcMBpJjNkNDLsgoxMSHqEEUh4CAcOJx/bCcclBS7cePWfk9ty+QE/9I
         xgHrHWYYeVSIkBpMDoVmu5+PrVKWHhTD1Xli1RgsOdsW5Z+7jijjepiOXUPu2mRw8Fnb
         FI8w7lQ2nYeTf7n7BBW94AQho7z2s97LoBIbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LO5l725TC7S+8bCG/4dlZNuzhvj1SgEvwbf4wk8dwd8=;
        b=hayGIpkkOwfgGdd8bUtyy122WeZu/mM5+VYd6AJ6E1mvIjRmqJ/oM/ButYKvNiyiFA
         wc2vhe4EWVpJgM6W8qRiNU7ETZjL7e+BPJsYIoiXrWjk+Y3CVb+GCKuFGLgNwFArfVJ5
         9WEjPVNy5qmqNo9r/rmE2xI9eo/OAn68i2wTz9OuJOENUgukEbfOcF77IftQJfoaWhI1
         IRAxy1n1MPv6jbpavNehv/SKDFQF+0ndJT4Pis7Ok99+zMzqrF6I/40PXqwIiM8Fcrp0
         mT68mOPAlEPf6rJJf+lhil2t4Xqm5SpNfv+JvG42iq9nF8ycoB5KIU9xOvIuIX4SE/q0
         9h5A==
X-Gm-Message-State: APjAAAWMRcU3plqtXmYu190Byj0gcZtkcqMemHDr/rm1CjiKL57oPK+o
        nbPIJnAyMkSETdFKyA2bOeGcDr+TZfFZea+W
X-Google-Smtp-Source: APXvYqzpT53MLILzHFuzmHanZEve6tlT2KE65vsgohssuLXi3LYBNCNzWp17/dbT57XD+opcZa7OSQ==
X-Received: by 2002:a2e:141c:: with SMTP id u28mr12993624ljd.44.1568366281361;
        Fri, 13 Sep 2019 02:18:01 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q11sm3196811ljc.27.2019.09.13.02.18.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 02:18:00 -0700 (PDT)
Subject: Re: [RFC] Improve memset
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <20190913072237.GA12381@zn.tnic>
 <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
From:   Rasmus Villemoes <mail@rasmusvillemoes.dk>
Message-ID: <9dc9f1e6-5d19-167c-793d-2f4a5ebee097@rasmusvillemoes.dk>
Date:   Fri, 13 Sep 2019 11:18:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2019 11.00, Linus Torvalds wrote:
> On Fri, Sep 13, 2019 at 8:22 AM Borislav Petkov <bp@alien8.de> wrote:
>>
>> since the merge window is closing in and y'all are on a conference, I
>> thought I should take another stab at it. It being something which Ingo,
>> Linus and Peter have suggested in the past at least once.
>>
>> Instead of calling memset:
>>
>> ffffffff8100cd8d:       e8 0e 15 7a 00          callq  ffffffff817ae2a0 <__memset>
>>
>> and having a JMP inside it depending on the feature supported, let's simply
>> have the REP; STOSB directly in the code:
> 
> That's probably fine for when the memset *is* a call, but:
> 
>> The result is this:
>>
>> static __always_inline void *memset(void *dest, int c, size_t n)
>> {
>>         void *ret, *dummy;
>>
>>         asm volatile(ALTERNATIVE_2_REVERSE("rep; stosb",
> 
> Forcing this code means that if you do
> 
>      struct { long hi, low; } a;
>      memset(&a, 0, sizeof(a));
> 
> you force that "rep stosb". Which is HORRID.
> 
> The compiler should turn it into just one single 8-byte store. But
> because you took over all of memset(), now that doesn't happen.

OK, that answers my question.

> So we do need to have gcc do the __builtin_memset() for the simple cases..

Something like

	if (__builtin_constant_p(c) && __builtin_constant_p(n) && n <= 32)
		return __builtin_memset(dest, c, n);

might be enough? Of course it would be sad if 32 was so high that this
turned into a memset() call, but there's -mmemset-strategy= if one wants
complete control. Though that's of course build-time, so can't consider
differences between cpu models.

Rasmus


