Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55330C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2463522CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Boo6OqKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbfIEJpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:45:45 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36615 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731806AbfIEJpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:45:44 -0400
Received: by mail-lj1-f195.google.com with SMTP id l20so1765964ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 02:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TY/VAMXSgKUK1/PqoRLKLXcdBHJ5xdp8p/A6hRUlgeQ=;
        b=Boo6OqKmqCSgWJ+melMhgT/nvrdsiffQ9ZYYfkj/WSYGAGyflvROS/oKLnJpS9EVEn
         iKFLTWKI6iTzQDM56jO7C+RLGiPG3svRe/kgKCtYxjQ4YLMADZA7hs6q8QgdHeAeov3E
         GhwbanV0Lg+PHabWSmwMYWkOz71QRNdUm9dnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TY/VAMXSgKUK1/PqoRLKLXcdBHJ5xdp8p/A6hRUlgeQ=;
        b=Uyp8E0r5b7ItbdhdQLnuOYhuaszkGk2U9yCwEbES0Flr/a/90Veq1b6jg3Ic1jEf8c
         WKRkYPxZP5s2dPEwdKBtXhWHSuvBPlbTznuuLCaBmCF17awNF+H347KykXKo5AU9Xykm
         9ERvMg5/g5Qkx0FJObaWzugDccMnC5nso/FItKVEsYp82rRIDk4s9XGPad3FBFJvcGkD
         wD1Z51BJIZxzBFmBW4d3cnU6Ky3BlhDA6vgBI173wCn8IjCPQToMva7g/4D0XdIlL12Z
         k0LAKReAMr4OiBLWks1pTkEqKicrmfWZOHj3NQ6cNs6my9Q99S+8JqxQoVzvEStpSCtF
         r04A==
X-Gm-Message-State: APjAAAWlC+fVyDudWoMJtFboQ0Q6P/X1VAXA7WX4O1jxJ5bv9osMEOpi
        TX9bVXKkA7s8CuUFwz/RC7l/M9GBz5+v6LZglMg=
X-Google-Smtp-Source: APXvYqxtbpDGzOrTsl646TScqM698QP59n4fIimIm9TjmaNb/OkdFlRfJFs7DmxiCihxnMuQhKeeFA==
X-Received: by 2002:a2e:9104:: with SMTP id m4mr1433674ljg.28.1567676742759;
        Thu, 05 Sep 2019 02:45:42 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h5sm281820ljf.83.2019.09.05.02.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 02:45:42 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] compiler_types.h: don't #define __inline
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-4-linux@rasmusvillemoes.dk>
 <CAKwvOdn2zbRCL+L92zjjuyhj4NLLtOEWd3pjady9KyYb7PAbmw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d13a9088-e17a-0bae-9bf3-5ea334c18aa1@rasmusvillemoes.dk>
Date:   Thu, 5 Sep 2019 11:45:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdn2zbRCL+L92zjjuyhj4NLLtOEWd3pjady9KyYb7PAbmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2019 02.13, Nick Desaulniers wrote:
> On Fri, Aug 30, 2019 at 4:15 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
> 
> Besides patch 1 and 2 of this series, I also see:
> Documentation/trace/tracepoint-analysis.rst
> 318:         :      extern __inline void
> __attribute__((__gnu_inline__, __always_inline__, _
> 

That seems to be copy-pasted output from some command, so I won't edit that.

> scripts/kernel-doc
> 1574:    $prototype =~ s/^__inline +//;

That one can indeed go once all uses of __inline in the source code is gone.

>> The exception is include/acpi/platform/acintel.h. However, that header
>> is only included when using the intel compiler (does anybody actually
>> build the kernel with that?), and the ACPI_INLINE macro is only used
> 
> In my effort to make the kernel slightly more compiler-portable, I
> have not yet found anyone building with ICC.  I would love to be
> proven wrong.  Let me go ask some of my Intel friends.

Yeah, the whole compiler-attributes.h only deal with gcc and clang, and
a lot of the attributes are unconditionally defined, so I assume either
ICC implements them all, or perhaps simply ignores (unknown) attributes?
It would be lovely if we could just throw out all the icc stuff.

>> in the definition of utterly trivial stub functions, where I doubt a
> 
> See:
> include/acpi/platform/acenv.h
> 146 #elif defined(__INTEL_COMPILER)
> 147 #include <acpi/platform/acintel.h>
> 
>> small change of semantics (lack of __gnu_inline) changes anything.
> 
> include/acpi/platform/acintel.h
> 25:#define ACPI_INLINE                 __inline
> include/acpi/platform/acgcc.h
> 29:#define ACPI_INLINE             __inline__
> 
> lol wut
> 
> I mean, you just would have to change that one line in
> include/acpi/platform/acintel.h, right?  I'd sign off on this patch
> with such a patch added to the series.

I'm not sure what you mean. Just switch the above __inline to inline?
It's annoying not being able to test it.

Rasmus
