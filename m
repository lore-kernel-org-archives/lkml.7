Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51DDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750F12186A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="c1SAxMus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfH3HpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:45:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41574 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfH3HpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:45:11 -0400
Received: by mail-lf1-f68.google.com with SMTP id j4so4590662lfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EAayauqBQaTSl6kGKSVw6Nau8X6fDyhB0ovLIE2umw8=;
        b=c1SAxMusIO647i5iw3U/EQjSrnnO24tYxiQKcA6oskBBJE+wndns+E0PAqNzw0vR7e
         2uFO3veAebXAF3PHZlGKuva6B64vCYAMNaD5mmzwLEWDT02OMo4xwh7GjCoWbP6CET0f
         8l4h7ZWFNWCYxwJUgJpkGYRjc/OPs/Se/uo9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EAayauqBQaTSl6kGKSVw6Nau8X6fDyhB0ovLIE2umw8=;
        b=smQk1m/TDWM+xgOUkZym03o7mQNv3FdQOP2p9XTOqV43l5/XOBpxTJQ+0BLJTUCMJw
         eJ8UneXTeAbacW5ai9tgs1MuXNRueWL80TqwN/BKRH7HFALfNs1HWbKi58ts7HSNv/LS
         muGa+at6+N4ZYWbSIVltQs+nL4OEq1Zpfl+lXMpk/9bcX27D+sES0boEn8lJspAzXlrT
         EvlgyROMV+i+eVz+3/Rx5REou9mUpz2H8CfDB9mhkq1hflmszNNJuT5Lj9I6SQCuNCrv
         y+35uiQ+3yZnM01pCexuHl4rZAzJB7VjtIUWSPINkkLjJk1WddyfvReh9/CMSJfUSO/w
         T4bw==
X-Gm-Message-State: APjAAAXBH3p6NQBZi5Fc0bEItIfPP0cNrTXlvQLei5RuBA30B0X/LXwW
        yr5XbMtn/s1iNUE94ylBg2alAQ==
X-Google-Smtp-Source: APXvYqzhAEiAkXBkA2OI3BIwl/VgpebFQiWWaKBQvq7AU8olva45KdQCZg3ngbI05bCqdgNdNyMLgA==
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr3484089lfc.28.1567151109019;
        Fri, 30 Aug 2019 00:45:09 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w1sm779837lfe.67.2019.08.30.00.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 00:45:08 -0700 (PDT)
Subject: Re: [RFC PATCH 0/5] make use of gcc 9's "asm inline()"
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <CAHk-=wihp7KZ_WjA16odsU7eGb-rUfg7J0rhqwhRoD0zjyGHpw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c3b71dff-c884-28b6-a4c7-ff2bf12720d4@rasmusvillemoes.dk>
Date:   Fri, 30 Aug 2019 09:45:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wihp7KZ_WjA16odsU7eGb-rUfg7J0rhqwhRoD0zjyGHpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2019 18.05, Linus Torvalds wrote:
> On Thu, Aug 29, 2019 at 1:32 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> But since we #define the identifier inline to attach some attributes,
>> we have to use the alternate spelling __inline__ of that
>> keyword. Unfortunately, we also currently #define that one (to
>> inline), so we first have to get rid of all (mis)uses of
>> __inline__. Hence the huge diffstat.
> 
> Ugh. Not pretty, but I guess we're stuck with it.
> 
> However, it worries me a bit that you excluide the UAPI headers where
> we still use "__inline__", and now the semantics of that will change
> for the kernel (for some odd gcc versions).

Yeah, as I wrote I was aware of that, but didn't have any good ideas, so
I was fishing. Doing

#ifdef __KERNEL__
#define __uapi_inline inline
#else
#define __uapi_inline __inline__
#endif

was one of the bad ideas...

> I suspect we should just bite the bullet and you should do it to the
> uapi headers too. We already use "inline" in a lot of them, so it's
> not the case that we're using __inline__ because of some namespace
> issue, as far as I can tell.
> 
> One option might be to just use "__inline" for the asm_inline thing.
> We have way fewer of those. That would make the noise much less for
> this patch series.

Ah, interesting. I didn't know that was also a compiler provided alias.
It seems to be entirely undocumented -
https://gcc.gnu.org/onlinedocs/gcc/Alternate-Keywords.html just mentions
the __inline__ (and __asm__) spellings. But it's clear as day in the gcc
sources

  { "__inline",         RID_INLINE,     0 },
  { "__inline__",       RID_INLINE,     0 },

and has been that way since forever, AFAICT.

So yes, let's just start by getting rid of the __inline define and fix
the staging (+acpi,zstd) users, to allow asm_inline to progress. I'll
respin.

Rasmus

