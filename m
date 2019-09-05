Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76777C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842BC207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="G/YNik1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbfIEOXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:23:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42175 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfIEOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:23:15 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so2683293lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LPztoN3Fg0/PfSpfw7cEnAqEPRh799k2jxpgxiRRCHA=;
        b=G/YNik1GclJrN7gztCf7hQqyrJqZWIjZGJzI03IDYHeBt1xOf4ipze7k1Cshr1Wrbn
         i2jTsLWNR+WfE14XyajTmah+0LaTGevGCdBRh1VVcnQY8X8Om7LI4DNAeU8gEc1W5pfy
         X+5+w1m6czJiMAsp+UuN9nmL2XtOz2M0wMqro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LPztoN3Fg0/PfSpfw7cEnAqEPRh799k2jxpgxiRRCHA=;
        b=NCqsUtErCWVIqzKXvHy3Myu1ja+sIfyk9WYTovoq3X2WqF/s0hlVG3rzCHYOplVzLG
         wwlfcwbK2nuXO9TZYjbu+g33NJjOHwtPyoSHudTkhjQRDLay7vk6+z7SvLe2qavgi16Y
         LjFR3PGCusz7Aw5OpPocOMSM3EdWI/Nbf/En2E9huw/VGFbNg8fvmczp639ksRGLZEqN
         OZTxk+13b066VGiy5lmjTrzExIZwrUxPp8QXCb6a/Qan4cPHCOahbn+r5UP1E3f3E1rn
         W0BwgxgkKzIeBKedo11gjLMNgDDYBCxidBQ1MiU/YYEDUMRUKbNWcor3fViR7toe6LBl
         hqoQ==
X-Gm-Message-State: APjAAAW4KKwsb+zOhfEBoe3fSf6Yit+67ytXjs9LdIe9V6WpeiG1ox6y
        azJ/oypu8PWIcj0uBD6nTnLNNcrHOpzIvA+0FJU=
X-Google-Smtp-Source: APXvYqwK6hlDidvoX1XHjLEpXeyyZfiGakyOZcQDFwkD7Cs9G8HHGLzX1fwlEnJzQpe0RldEwtI2Pw==
X-Received: by 2002:a2e:93d7:: with SMTP id p23mr2363500ljh.100.1567693393910;
        Thu, 05 Sep 2019 07:23:13 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u26sm462173lfd.19.2019.09.05.07.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 07:23:12 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-5-linux@rasmusvillemoes.dk>
 <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com>
 <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk>
 <20190905134535.GP9749@gate.crashing.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ceb01e88-b172-d6e7-98d4-c14ddeae87d9@rasmusvillemoes.dk>
Date:   Thu, 5 Sep 2019 16:23:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905134535.GP9749@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2019 15.45, Segher Boessenkool wrote:
> Hi Rasmus,
> 
> On Thu, Sep 05, 2019 at 01:07:11PM +0200, Rasmus Villemoes wrote:
>> On 05/09/2019 02.18, Nick Desaulniers wrote:
>>> Is it too late to ask for a feature test macro? Maybe one already
>>> exists? 
>>
>> No, not as far as I know.
> 
> [ That's not what a feature test macro is; a feature test macro allows the
>   user to select some optional behaviour.  Things like _GNU_SOURCE.  ]
> 
>> Perhaps something like below, though that
>> won't affect the already released gcc 9.1 and 9.2, of course.
> 
> That is one reason to not want such a predefined macro.  Another reason
> is that you usually need to compile some test programs *anyway*, to see if
> some bug is present for example, or to see if the exact implementation of
> the feature is beneficial (or harmful) to your program in some way.

OK, I think I'll just use a version check for now, and then switch to a
Kconfig test if and when clang grows support.

>> gcc maintainers, WDYT? Can we add a feature test macro for asm inline()?
> 
> 
> Why would GCC want to have macros for all features it has? 

Well, gcc has implemented __has_attribute() which is similar - one could
detect support by compiling a trivial test program. Or the same could be
said for many of the predefined macros that are conditionally defined,
e.g. __HAVE_SPECULATION_SAFE_VALUE.

But I was just throwing the question into the air, I won't pursue this
further.

Thanks,
Rasmus
