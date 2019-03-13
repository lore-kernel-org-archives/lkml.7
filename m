Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11243C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D103B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gLHiVNRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfCMTeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:34:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39711 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfCMTeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:34:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so2573668edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 12:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HvXvDdDuhnnD+/KUb4dLVxTH1+3vfWp3fUQig2GamBc=;
        b=gLHiVNRE2/ux1T+za1R8SLNWfvfdV2xEVeQHmaC3NPW0HZOShc8OUIzzdzMR9wvv+K
         Zc8UJFrlx9sFmLaPSqsbaD053YFKcxd+MHOKToR4wokLQRAKkon2CVGodvRQWJtBNUOm
         LI9YonQwGVBz9+RU/1sAdODRv0bvCISr80DeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HvXvDdDuhnnD+/KUb4dLVxTH1+3vfWp3fUQig2GamBc=;
        b=fqFEC3fWchXF7ULYD0gwMUelNiZpHppJNn+KS98s98tB5xBaMyyA98HY0wkmPzPfhx
         +ibC8XN8SEPaDhqVARWaSC4j4KIIOcaLJGmzEMOCRY7+0CnCdQWop5sui50EIZYQEDCh
         Kox3hMCAVq7pRh+QWGTI76EmQCzxYRGsYDFkqYYR2bE92MTWOerZjIKj3Dnkk7WQoZN5
         og8b5j66dwBjvperHAVLs/xKUowQm5pe2XchI+vYZfs3klQNzSGSKhClDClKh7wqyeGR
         +sfpWotfu9+vuz/SbP9nIc01vDVzgeF9tUYB67WJOfNQBPvybgdB7BGHhzl66QVSsyVf
         I2Fg==
X-Gm-Message-State: APjAAAUYYrLdjtVp//D5lspvmc+r3wCYPm/49fKWvFFzX98YuMvAi2gz
        EanpNHcqNtzDpz7AUN5obuqNNRDEFBF7qxdO
X-Google-Smtp-Source: APXvYqwOG/gfpKi/wOomE3IY4nYk7uwdHdLgCa0xEHWmzZbr3uc+lpvgQeMVlSVQQLLlJv8dVer7/g==
X-Received: by 2002:a50:d508:: with SMTP id u8mr8981647edi.51.1552505653461;
        Wed, 13 Mar 2019 12:34:13 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-119-202.cgn.fibianet.dk. [5.186.119.202])
        by smtp.gmail.com with ESMTPSA id n10sm647627ejl.22.2019.03.13.12.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 12:34:12 -0700 (PDT)
Subject: Re: [PATCH v2] lib/string.c: implement a basic bcmp
To:     Steven Rostedt <rostedt@goodmis.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux@googlegroups.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Y Knight <jyknight@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAKwvOdmdEH1U9vOmVKo2Fn+hMPF9AB1enZ2rkpJcU9XHgR8Wng@mail.gmail.com>
 <20190313181719.87859-1-ndesaulniers@google.com>
 <20190313144013.37cab5c7@gandalf.local.home>
 <CAKwvOdnheUi6Ho5u4akTLGa-tBeUq94hQJH0+a4ROe_aEUgo7g@mail.gmail.com>
 <20190313150133.117e2b63@gandalf.local.home>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <65c69aac-696c-0534-2243-679db926d527@rasmusvillemoes.dk>
Date:   Wed, 13 Mar 2019 20:34:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190313150133.117e2b63@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2019 20.01, Steven Rostedt wrote:
> On Wed, 13 Mar 2019 11:51:09 -0700
> Nick Desaulniers <ndesaulniers@google.com> wrote:
> 
>>>
>>> or have a better comment explaining why its the same.  
>>
>> I could add something about "the signedness of the return code not
>> providing any meaning."  What would you like to see in such a comment?
> 
> I think it's the wording that bothers me:
> 
> + * bcmp - Like memcmp but a non-zero return code simply indicates a non-match.
> 
> What about:
> 
>   * bcmp - Like memcmp but non-zero only means a non-match
> 
> Then in the description say that bcmp() callers must not expect
> anything more than zero and non-zero,

Yes, but let's completely avoid mentioning memcmp in the summary.

bcmp - return 0 if and only if the buffers have identical contents
@a: pointer to first buffer
@b: pointer to second buffer
@len: size of buffers

The sign or magnitude of a non-zero return value has no particular
meaning, and architectures may implement their own more efficient
bcmp(). So while this particular implementation is a simple (tail) call
to memcmp, do not rely on anything but whether the return value is zero
or non-zero.

Rasmus
