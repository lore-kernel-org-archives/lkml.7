Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4AFC43141
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 01:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682B42071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 01:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="fdiVaXFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKYBMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 20:12:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46889 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfKYBMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 20:12:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id 193so6467239pfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2019 17:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=fUxnjYVvwcgXB0p2/65XHwblJekP3byuP5LlZ092IOo=;
        b=fdiVaXFm4SFErN5LBs46ss2lcb9UcioTJsOpP5jwXMHthSV7SwNTKDK8vkJsUL9o9u
         fWrrOBOXE5fVoh3eSUi8pYXMcfOu57mpkE5xiuC6+wlLC/MjRaqPMC/2ftb4A5Aul0pP
         qGJpzO/giydCspj4CX9k4ULtYJO0Jz2XWFiPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fUxnjYVvwcgXB0p2/65XHwblJekP3byuP5LlZ092IOo=;
        b=pNok3zsgfCsbipqLMi42FGmxJfZaDv5hqxQvJa/BvwoXrATdsy95WzvVv9yK7dXTZS
         W+pEtaDvaECs0LxLCR8QTsUe2E82b9CDMnc46fb3pamsL30UUasxFiqwJVPIe4zHAIuT
         itDgmfN0BzVqusTApOJSDzp+FKLPwPMz8m3pqfY/8WLhkR++vvD7PDYCmB3hBXhOM2hh
         h6YrG6XWUQ4s3wZ8mKAE/92gx4YA7nP2DnxDj7oYEa9xvPDsDK3EJQ5Cx73K395/NI9l
         y77W1W6rCQ/DHFYphyiXGAjvTsL8bRBoWH92e5Dlx9I7zxee1pigymJdj+1v8ixQjtgt
         sueA==
X-Gm-Message-State: APjAAAXpx8qm63SdANLyZ5ar5IXnl3oPFqE7/zymHTO4+w2yPdVy259w
        6prbEIygBd1IZYr2x1XYSXMeWA==
X-Google-Smtp-Source: APXvYqwOMDDms24hepE4EzFIffoon4ml+adRTnU609UHYVCG2sJO86Xhzmv9lBcNYl6lxghjJSjUzw==
X-Received: by 2002:a63:e60e:: with SMTP id g14mr29153291pgh.80.1574644325696;
        Sun, 24 Nov 2019 17:12:05 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-c5e4-a8fb-2787-cd48.static.ipv6.internode.on.net. [2001:44b8:1113:6700:c5e4:a8fb:2787:cd48])
        by smtp.gmail.com with ESMTPSA id u9sm5692040pfm.102.2019.11.24.17.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 17:12:04 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Bart Van Assche <bvanassche@acm.org>, Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep warning while booting POWER9 PowerNV
In-Reply-To: <87ef0vpfbc.fsf@mpe.ellerman.id.au>
References: <1567199630.5576.39.camel@lca.pw> <9b8b287a-4ae1-ca9b-cff1-6d93672b6893@acm.org> <87ef0vpfbc.fsf@mpe.ellerman.id.au>
Date:   Mon, 25 Nov 2019 12:12:01 +1100
Message-ID: <87v9r8g3oe.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

>>> Once in a while, booting an IBM POWER9 PowerNV system (8335-GTH) would generate
>>> a warning in lockdep_register_key() at,
>>> 
>>> if (WARN_ON_ONCE(static_obj(key)))
>>> 
>>> because
>>> 
>>> key = 0xc0000000019ad118
>>> &_stext = 0xc000000000000000
>>> &_end = 0xc0000000049d0000
>>> 
>>> i.e., it will cause static_obj() returns 1.
>>
>> (back from a trip)
>>
>> Hi Qian,
>>
>> Does this mean that on POWER9 it can happen that a dynamically allocated 
>> object has an address that falls between &_stext and &_end?
>
> I thought that was true on all arches due to initmem, but seems not.
>
> I guess we have the same problem as s390 and we need to define
> arch_is_kernel_initmem_freed().
>
> Qian, can you try this:
>
> diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
> index 4a1664a8658d..616b1b7b7e52 100644
> --- a/arch/powerpc/include/asm/sections.h
> +++ b/arch/powerpc/include/asm/sections.h
> @@ -5,8 +5,22 @@
>  
>  #include <linux/elf.h>
>  #include <linux/uaccess.h>
> +
> +#define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
> +
>  #include <asm-generic/sections.h>
>  
> +extern bool init_mem_is_free;
> +
> +static inline int arch_is_kernel_initmem_freed(unsigned long addr)
> +{
> +	if (!init_mem_is_free)
> +		return 0;
> +
> +	return addr >= (unsigned long)__init_begin &&
> +		addr < (unsigned long)__init_end;
> +}
> +
>  extern char __head_end[];
>  
>  #ifdef __powerpc64__
>

This also fixes the following syzkaller bug:
https://syzkaller-ppc64.appspot.com/bug?id=cfdf75cd985012d0124cd41e6fa095d33e7d0f6b
https://github.com/linuxppc/issues/issues/284

Would you like me to do up a nice commit message for it?

Regards,
Daniel

>
> cheers
