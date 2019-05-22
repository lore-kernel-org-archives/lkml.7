Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEB3C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A572C2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ICzs9dpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfEVGV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 02:21:29 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36250 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfEVGV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 02:21:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id z1so946790ljb.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 23:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LkdVbSgatcGwczh6eAGRf6VHadP0mk+06B0muIRxKIU=;
        b=ICzs9dpN5XXzVN8rmyfo2IJn+R5HtTvExYpwpqWJWab/7gu0WPdlP/G3D5lPfli5Mu
         WimBSkKUeSQg3QYj/qco1CHawScbKljiu6ukkEb5YhAkH0iY7aaczfYJtg4WOJG4Tt7m
         cQxaWy4imJTL7ODTdN7h7X5rg7rUb29sFZYKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LkdVbSgatcGwczh6eAGRf6VHadP0mk+06B0muIRxKIU=;
        b=n+fbN/hK7AnTMrF+TyZIkj+ZyNHIrIBG9UvHxkyCQqqN4QBSm/aomyNhvkW9h9AgfW
         3RQQHSwv1Dvf+SnYBkmm+rs3Z/X0Jy6yUnF86PVEZZYMfg7xUWtl9t+EC1tHpaOvwUyA
         D4tGT1awWynGRxezlzdoMJ6RvbqXWOdtMs3rLtSmtIfu2MptrL+n7JzOqEI3CM6YKvbG
         4CTqKYuK1N95loJHBPVfIjzPXwpuWshhQkNllFLNasxFmgDsJPqn02GXRTINpPSeItJj
         fuysmXEl5WgC9cRxMZppu346wQcxWA8SgFtH6FkdeIXd4FSSNKD0FKaKUwEx+o8qjYJw
         D+vg==
X-Gm-Message-State: APjAAAXMfNskUmGBxmaj5ldP/byTD3n8UNhUv9UlWlGFU0QigeUB01lf
        2xaB7Gt0H8v0wkqjibgCDxRNi1/adOLVCSkl
X-Google-Smtp-Source: APXvYqzRyRNV9hRaiGnLMg7s7N+trCFqWJXk8Chbj/RmLE+wVTSJlF+JaWvWabid+LBq5eiUdSxjLg==
X-Received: by 2002:a2e:8988:: with SMTP id c8mr36005549lji.99.1558506086916;
        Tue, 21 May 2019 23:21:26 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d10sm271105lfn.91.2019.05.21.23.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 23:21:26 -0700 (PDT)
Subject: Re: arm64 patch
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAKwvOd=r3x7Z-4M-xY-+G9HhHeMFbizsSWvNLGK+DSfoaY_wjQ@mail.gmail.com>
 <20190515033158.GA31802@archlinux-i9>
 <20190521224209.d33c11d59eaabcbb44d28b2a@linux-foundation.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <245ffcf0-6e0f-18ed-9c5f-1362a77c4097@rasmusvillemoes.dk>
Date:   Wed, 22 May 2019 08:21:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521224209.d33c11d59eaabcbb44d28b2a@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2019 07.42, Andrew Morton wrote:
> On Tue, 14 May 2019 20:31:58 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:
> 
>> On Tue, May 14, 2019 at 04:16:19PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
>>> do we know if
>>> https://lkml.org/lkml/2019/4/29/743
>>> https://lkml.org/lkml/2019/4/29/747
>>> got picked up?
>>> I just saw akpm send a PR, but didn't get any emails related to those
>>> (maybe I'm not cc'ed).
>>>
>>> -- 
>>> Thanks,
>>> ~Nick Desaulniers
>>>
>>
>> It doesn't look like it according to -next.
> 
> I don't normally do arm64 or powerpc things.  And I usually take a pass
> if cc'ed on a fraction of a patch series.
> 
> Anyway, if there's something you want me to do here, please send fresh
> patches at me?
> 

So, this is of course already too late for 5.2. Since there were also
problems with old compilers for x86 [1], I think I'll try to change this
to an opt-in model (the arch says HAVE_..., but then actually choosing
DYNAMIC_DEBUG_RELATIVE_POINTERS is up to whoever does the .config, with
a warning in the help text that it may fail to compile/link depending on
toolchain).

Andrew, please drop the following five patches from your tree (sha1s as
per next-20190522):

f418571688c5 powerpc: select DYNAMIC_DEBUG_RELATIVE_POINTERS for PPC64
0dd95e972ef8 arm64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
1a086a6f12ca x86_64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
a6e9afb84c99 lib/dynamic_debug.c: add asm-generic implementation for
DYNAMIC_DEBUG_RELATIVE_POINTERS
e301d47f9756 lib/dynamic_debug.c: introduce
CONFIG_DYNAMIC_DEBUG_RELATIVE_POINTERS

Thanks,
Rasmus

[1]
https://lore.kernel.org/lkml/1afb0702-3cc5-ba4f-2bdd-604d9da2b846@rasmusvillemoes.dk/
