Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3CDC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB6720650
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="AIclLN2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbfIPJSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:18:39 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:43917 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfIPJSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:18:39 -0400
Received: by mail-lj1-f178.google.com with SMTP id d5so33005787lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 02:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qkDCdm015VHztmknrPE7J07mB1i0Dmas5Y8N7jHwsJk=;
        b=AIclLN2eRXc4xJH425AbVQ/TXYDBslcMt/6RE71rddOkrKAm6iqip+UFuX/ExkX0YT
         JfLBjuqBeOG8YAog5WPW9X0hmfQ9RhNXmPzwPg5zrMGUMSfhQvwK2Yu4cTQBMMZNggm3
         VkoA9hjLhslalHFkTZk0TghF6QMATTLvYOszk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qkDCdm015VHztmknrPE7J07mB1i0Dmas5Y8N7jHwsJk=;
        b=OSIMc2vsx+U+8nErIvv5XbOBrZlZDGKyKStSMSVzA3NJ9/cKqIqJAEy4vM6I2azm3B
         sNYu+9Oj4FP8AgiSXA9j79EJeXHKuaWktAcfeVG2AZ8o7FGg91wUdANB89H1iHFghPD+
         5GnGihqkXfkcZ5ME7RISfhEQKjTZpRpzuIrhvaDS7nT8kpCel9+mkZpce0ag/pprroqK
         vIsoW3jyF0L+ELA6ynlDY9/fZJNzVrZ2koQMz7CHLtBEs2afwxABORnlle+R+pXj9iZh
         TRFKXictRqUq3Wt6BeLUWNhLnUI8EDLVXrurrh4kUSlOWgLJv/JIIsiAHe5b4G37bWta
         P77Q==
X-Gm-Message-State: APjAAAVGfriKdODTWzQ+31TwJ6ZDU4o6J9VmGzT3CIq9MCeTihJCTKD4
        qw7G/2Sch8vMYKNocz5nSHmCjzxAeTXrWBDT
X-Google-Smtp-Source: APXvYqwisb0U7YRN/ZrNf4c4CUHY6m3to+JyOQX1a/wRZJJx5wBNf0pEXnt/kN11EhPAsLCD9850pQ==
X-Received: by 2002:a2e:91d9:: with SMTP id u25mr7210723ljg.85.1568625514902;
        Mon, 16 Sep 2019 02:18:34 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z7sm3527382ljc.9.2019.09.16.02.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 02:18:34 -0700 (PDT)
Subject: Re: [RFC] Improve memset
To:     Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <mail@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <20190913072237.GA12381@zn.tnic>
 <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
 <9dc9f1e6-5d19-167c-793d-2f4a5ebee097@rasmusvillemoes.dk>
 <20190913104232.GA4190@zn.tnic> <20190913163645.GC4190@zn.tnic>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <3fc31917-9452-3a10-d11d-056bf2d8b97d@rasmusvillemoes.dk>
Date:   Mon, 16 Sep 2019 11:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913163645.GC4190@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2019 18.36, Borislav Petkov wrote:
> On Fri, Sep 13, 2019 at 12:42:32PM +0200, Borislav Petkov wrote:
>> Or should we talk to Intel hw folks about it...
> 
> Or, I can do something like this, while waiting. Benchmark at the end.
> 
> The numbers are from a KBL box:
> 
> model           : 158
> model name      : Intel(R) Core(TM) i5-9600K CPU @ 3.70GHz
> stepping        : 12
> 
> and if I'm not doing anything wrong with the benchmark 

Eh, this benchmark doesn't seem to provide any hints on where to set the
cut-off for a compile-time constant n, i.e. the 32 in

  __b_c_p(n) && n <= 32

- unless gcc has unrolled your loop completely, which I find highly
unlikely.

(the asm looks
> ok

By "looks ok", do you mean the the builtin_memset() have been made into
calls to libc memset(), or how has gcc expanded that? And if so, what's
the disassembly of your libc's memset()? The thing is, what needs to be
compared is how a rep;stosb of 32 bytes compares to 4 immediate stores.

In fact, perhaps we shouldn't even try to find a cutoff. If __b_c_p(n),
just use __builtin_memset unconditionally. If n is smallish, gcc will do
a few stores, and if n is largish and gcc ends up emitting a call to
memset(), well, we can optimize memset() itself based on cpu
capabilities _and_ it's not the call/ret that will dominate. There are
also optimization and diagnostic advantages of having gcc know the
semantics of the memset() call (e.g. the tr.b DSE you showed).

but I could very well be missing something), the numbers say that
> the REP; STOSB is better from sizes of 8 and upwards and up to two
> cachelines we're pretty much on-par with the builtin variant.

I don't think that's what the numbers say.

Rasmus
