Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0143C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AEB218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="eS6BwuOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfDXGqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:46:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39058 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDXGqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:46:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id d12so13724246lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 23:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+DGUqjoCrDfp5F6ZJ/aJXzIUf0QAsTMXcihi5jieQHU=;
        b=eS6BwuOpFxo4AGLk+dWPGZVp5SZ6diE7JHQkOhzpNeZyBrBcfzem5PJ8VsYeXe19wo
         SuvzRMh0GQgedKOaEfziUAIl8h10F3s2ZQptniYHNYwco8gPAwPPp+Wa/obFfUqHqONC
         lC1j56a30Kw5SCi/qaMAcnh7HlkYWDiQT8aSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+DGUqjoCrDfp5F6ZJ/aJXzIUf0QAsTMXcihi5jieQHU=;
        b=VnexlF7hO5YswsrwuDY8sIZK/ZxyemULsyesod6AWLcYi7hSg3X+ruT8vBvYxKTSi/
         IGpN9xpwPWMnxC4Hb2em/0LAxarFYvX3ng7qlAcm91fTdaY6dFFNv2GDyV5Fhs4awue5
         5KPSh/LenymR6Ylg8x4RV7eyaoVDW9jPFt/F6YURW6mp7V1OCr8+NC4D58vhJvC8BelO
         Lu7/KyCwrHXCKFx221Mgk6Koq6k7T2EJQN9qDdrMIgJ5LZBm3FhXYo0UU0Woqf+pVTtF
         0doratnZ65RCQ18P5n1qh0blDQI4rRTnP7CsFtXhRzsOKao5uFvdcLQ1Ym/NXkpDH6bp
         ddJA==
X-Gm-Message-State: APjAAAXaw65cNz+FDZzP9Jb+iIlRKQDP/mkHBxFx8MS9NbmqYZlxfG7c
        AGIyzpTkuIlwZ6hqf/LNaN6R15lDKFJC/hGp
X-Google-Smtp-Source: APXvYqyt7du1ZpItlD2H1oCeywUqc1PcrY5PGA49A7C18M7lK800MaxpTakCPog3d2z0uBNSObzqfA==
X-Received: by 2002:a19:2d57:: with SMTP id t23mr14979726lft.99.1556088402257;
        Tue, 23 Apr 2019 23:46:42 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z2sm144803lji.77.2019.04.23.23.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 23:46:41 -0700 (PDT)
Subject: Re: [PATCH 10/10] powerpc: select DYNAMIC_DEBUG_RELATIVE_POINTERS for
 PPC64
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, Jason Baron <jbaron@akamai.com>,
        linux-kernel@vger.kernel.org
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk>
 <20190409212517.7321-11-linux@rasmusvillemoes.dk>
 <b5304c4c-736a-fd8b-e025-4ea040f5c346@c-s.fr>
 <20190423123611.1f7276cc4eb9f7a7005899a9@linux-foundation.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0fbffd5d-7e2a-1b12-5c94-b75f3f5d7ac1@rasmusvillemoes.dk>
Date:   Wed, 24 Apr 2019 08:46:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423123611.1f7276cc4eb9f7a7005899a9@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2019 21.36, Andrew Morton wrote:
> On Tue, 23 Apr 2019 17:37:33 +0200 Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -155,6 +155,7 @@ config PPC
>>>   	select BUILDTIME_EXTABLE_SORT
>>>   	select CLONE_BACKWARDS
>>>   	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
>>> +	select DYNAMIC_DEBUG_RELATIVE_POINTERS	if PPC64
>>
>> Why only PPC64 ? Won't it work with PPC32 ? Or would it be 
>> counter-performant on 32 bits ?
> 
> Ditto arm and i386?
> 

It's pointless on 32-bit platforms - I'm replacing absolute const char*
pointers with a relative s32 offset from the _ddebug descriptor, so if
sizeof(void*)==4 there's no gain.

And yes, the current implementation also wouldn't work out-of-the-box
for 32-bit platforms, since the asm needs to know how to properly
initialize a whole struct _ddebug, which (often) contains a static_key,
which in turn contains a pointer member, which both affects its size as
well as its placement inside _ddebug. The C code in dynamic_debug.c
would likely Just Work, but there's no point in complicating the asm
part for no gain, so there are static_assert()s in place to ensure
BITS_PER_LONG==64 (as well as checking the various offsetof()s etc.).

[I don't think performance matters at all, it's one extra addition to
access these fields, and that is only done in the rare cases where
someone interacts with the dynamic_debug/control sysfs file, and when
one of the activated pr_debug()s is actually hit (so a few extra
instructions drown in the printk overhead).]

I do now see that PPC64 does not select GENERIC_BUG_RELATIVE_POINTERS,
so maybe this scheme simply doesn't work on PPC64, or nobody has done
the work to reduce the sizeof(struct bug_entry) on PPC64? As I said,
I've only compile-tested arm64 and ppc64.

Rasmus
