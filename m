Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20F6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F51820989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="F8tUcTR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfCXVRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:17:53 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:42361 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXVRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:17:53 -0400
Received: by mail-ed1-f49.google.com with SMTP id x61so154400edc.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 14:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=05pyF6VbEaYK/e8wi3Oo3ugdDVWqpiN//LJZRzu4WDM=;
        b=F8tUcTR5coKhfGOF3k/+mD0cm2Xs/9OYXA7i6rVLvIUSNIp/tuuhQGDX4NKZMQcrKv
         ENAt7nh/lA+tpL3mWVj+6MKhvC7eY3EZYlLWv41M8Lb6zNmWCAXzuwRKnbVju285L2Vl
         RXB+93+8tMV7hCx/NPXox9Rg9sI885iLAWEKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=05pyF6VbEaYK/e8wi3Oo3ugdDVWqpiN//LJZRzu4WDM=;
        b=NWBa8+ITsV8LgLMJhqz00UpmFlwidwDx+gRMHJjvLPjAqxjkxpj3Q0NZDEEH621Hmf
         beQHCHGmwAWFye9tG/IxHzRVtUbbrPb6zBWZV3Eo4Ycqm4GkehAltx/D483PfRuxuKBA
         xh4Yqph29dGeLD5US4NkR0eb3aUgGu+dtc9G57SdA60AU5XGO6AzTu1uasoYkIWkn6Sn
         H2JhWXx+BTZnsGw+g4yP495Z2vfaUMUTHduVOhHQUjRA4UwWp8fGDUG8DDrKXzPMXZG+
         YZ9xIMVgGwv8EXKOMbBdoYMD0reBb6VLM+tJKgD+d6eE6sdTDFqRxWGCFgLKambRqrFG
         ZHKw==
X-Gm-Message-State: APjAAAVW9Q1zm9FENywjWhPUouhVEAPqYjWBo2vasRBCT+/Wi4pEjJpX
        j6alIxEXcPR7Mr4RN2VwuHDQyA==
X-Google-Smtp-Source: APXvYqxoXpP7yoa1b5vPiIf6O6W0i/t0ArBwxmsI5oKEIrXk0g7355iBaVuRMHHof1W8iUHWrbPToA==
X-Received: by 2002:a17:906:7254:: with SMTP id n20mr12134629ejk.168.1553462271358;
        Sun, 24 Mar 2019 14:17:51 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-118-63.cgn.fibianet.dk. [5.186.118.63])
        by smtp.gmail.com with ESMTPSA id y2sm3608615eda.11.2019.03.24.14.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 14:17:50 -0700 (PDT)
Subject: Re: [RFCv2] string: Use faster alternatives when constant arguments
 are used
To:     Sultan Alsawaf <sultan@kerneltoast.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20190324014445.28688-1-sultan@kerneltoast.com>
 <20190324022406.GA18988@sultan-box.localdomain>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nathan Chancellor <natechancellor@gmail.com>
Message-ID: <2293c54f-40b1-1e59-665a-bd8f2cb957d2@rasmusvillemoes.dk>
Date:   Sun, 24 Mar 2019 22:17:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190324022406.GA18988@sultan-box.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2019 03.24, Sultan Alsawaf wrote:
> I messed up the return value for strcat in the first patch. Here's a fixed
> version, ready for some scathing reviews.
> 
> From: Sultan Alsawaf <sultan@kerneltoast.com>
> 
> When strcpy, strcat, and strcmp are used with a literal string, they can
> be optimized to memcpy or memcmp calls.

gcc already knows the semantics of these functions and can optimize
accordingly. E.g. for strcpy() of a literal to a buffer, gcc readily
compiles

void f(char *buf) { strcpy(buf, "1"); }
void g(char *buf) { strcpy(buf, "12"); }
void h(char *buf) { strcpy(buf, "123456"); }

into

0000000000000000 <f>:
   0:   b8 31 00 00 00          mov    $0x31,%eax
   5:   66 89 07                mov    %ax,(%rdi)
   8:   c3                      retq
   9:   0f 1f 80 00 00 00 00    nopl   0x0(%rax)

0000000000000010 <g>:
  10:   b8 31 32 00 00          mov    $0x3231,%eax
  15:   c6 47 02 00             movb   $0x0,0x2(%rdi)
  19:   66 89 07                mov    %ax,(%rdi)
  1c:   c3                      retq
  1d:   0f 1f 00                nopl   (%rax)

0000000000000020 <h>:
  20:   b8 35 36 00 00          mov    $0x3635,%eax
  25:   c7 07 31 32 33 34       movl   $0x34333231,(%rdi)
  2b:   c6 47 06 00             movb   $0x0,0x6(%rdi)
  2f:   66 89 47 04             mov    %ax,0x4(%rdi)
  33:   c3                      retq

These alternatives are faster
> since knowing the length of a string argument beforehand allows
> traversal through the string word at a time

For strcmp(string, "someliteral"), gcc cannot (generate code that does)
read from string beyond a/the first nul byte

>  
> +/*
> + * Replace some common string helpers with faster alternatives when one of the
> + * arguments is a constant (i.e., literal string). This uses strlen instead of
> + * sizeof for calculating the string length in order to silence compiler
> + * warnings that may arise due to what the compiler thinks is incorrect sizeof
> + * usage. The strlen calls on constants are folded into scalar values at compile
> + * time, so performance is not reduced by using strlen.
> + */
> +#define strcpy(dest, src)							\
> +	__builtin_choose_expr(__builtin_constant_p(src),			\
> +		memcpy((dest), (src), strlen(src) + 1),				\
> +		(strcpy)((dest), (src)))

Does this even compile? It's a well-known (or perhaps
not-so-well-known?) pitfall that __builtin_constant_p() is not
guaranteed to be usable in __builtin_choose_expr() - the latter only
accepts bona fide integer constant expressions, while evaluation of
__builtin_constant_p can be delayed until various optimization phases.

> +#define strcat(dest, src)							\
> +	__builtin_choose_expr(__builtin_constant_p(src),			\
> +		({								\
> +			memcpy(strchr((dest), '\0'), (src), strlen(src) + 1);	\
> +			(dest);							\
> +		}),								\
> +		(strcat)((dest), (src)))
> +
> +#define strcmp(dest, src)							\
> +	__builtin_choose_expr(__builtin_constant_p(dest),			\
> +		__builtin_choose_expr(__builtin_constant_p(src),		\
> +			(strcmp)((dest), (src)),				\
> +			memcmp((dest), (src), strlen(dest) + 1)),		\

This seems to be buggy - you don't know that src is at least as long as
dest. And arguing "if it's shorter, there's a nul byte, which will
differ from dest at that point, so memcmp will/should stop" means that
the whole word-at-a-time argument would be out.

Aside from all that, you'd need multiple-evaluation guards. Also, it's a
good idea to give an example of some piece of actual kernel code that
would be compiled differently/better, by simply showing the difference
in disassembly. But even just a toy example as above would be good -
then you might have seen yourself that gcc already recognizes these
functions.

Rasmus
