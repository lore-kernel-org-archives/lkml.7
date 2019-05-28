Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA76BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963782081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gp3O9MMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfE1LdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:33:17 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45795 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1LdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:33:17 -0400
Received: by mail-lj1-f195.google.com with SMTP id r76so6551781lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 04:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MABWQ31ON0TR0IpKjWED0HazwKzgQ/WMHokiAHc03aw=;
        b=gp3O9MMh8feHVMlWj5VYKJcykIPIicL9qftBC/g9U0fwewHKMqLl/MofGdBtVkNQkn
         IVMlKW8Hg9P4j1I/cAMJa9HrB4mM0IErnXAPx5uimKXNozFbkOZjW9Pd6yh7lq5cNuXf
         doEylPmDq6h3Idyz947RnLdOZ827Ft3PUcSi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MABWQ31ON0TR0IpKjWED0HazwKzgQ/WMHokiAHc03aw=;
        b=temy441mgyLHJ2ks8rkjI5qkCQ07yTkQ2QYCuF2t/g33CryBlzdGj+RDnZf3fR2yHZ
         SGyP91puN3B1kmz/8/AdKB2YRvXTfr9IbB9OTj5mlAv9DLuyqoxQHqNISIsTQZqpcBiI
         fhQoIJ2aoSzwc3hzLCgPKbXhcx1qTpSnA19OARb+kfEUnL9h11NT4i0aFup0wnI6QN29
         cuAK89LQSl0LFPNwgQp+wRhCQwAbWkqjim7fdL2imPfOsRftqvudod+B7QVJsWNXVleR
         X/lYnbi79dvNwAxQlqB+hePbd3kSjADudfizmqS+44xhf2PU1JNDPjqUIABX41IF3opR
         8Mxw==
X-Gm-Message-State: APjAAAU3KV4P/fQ+Atg/uTtwyy91XjcK3xWHmZFQaTDqFyqW23Jq9stz
        ROWwPWjnUtlKNxYN72FrtgF3mw==
X-Google-Smtp-Source: APXvYqzAlj8nXBkXY9tXvwNZyhuuVjUcaz9St3nOjjKOjPyJt3ZdpGQUcyp52yMvVHPwvG4kJ/5Sbw==
X-Received: by 2002:a2e:12ce:: with SMTP id 75mr35464957ljs.7.1559043194790;
        Tue, 28 May 2019 04:33:14 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d2sm2177643lfj.0.2019.05.28.04.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 04:33:13 -0700 (PDT)
Subject: Re: LZ4 decompressor broken on ARM due to missing strchrnul() string
 traverse in cpumask_parse"
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Yury Norov <ynorov@marvell.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190528110412.gg66fl67yahtwb6i@linutronix.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ffc779fe-3735-9665-8ee2-6a3ff1a7dd83@rasmusvillemoes.dk>
Date:   Tue, 28 May 2019 13:33:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528110412.gg66fl67yahtwb6i@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2019 13.04, Sebastian Andrzej Siewior wrote:
> |  CC      arch/arm/boot/compressed/decompress.o
> |In file included from include/linux/mm_types_task.h:14,
> |                 from include/linux/mm_types.h:5,
> |                 from include/linux/mmzone.h:21,
> |                 from include/linux/gfp.h:6,
> |                 from include/linux/umh.h:4,
> |                 from include/linux/kmod.h:22,
> |                 from include/linux/module.h:13,
> |                 from arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:39,
> |                 from arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:13,
> |                 from arch/arm/boot/compressed/decompress.c:55:
> |include/linux/cpumask.h: In function ‘cpumask_parse’:
> |include/linux/cpumask.h:636:21: error: implicit declaration of function ‘strchrnul’; did you mean ‘strchr’? [-Werror=implicit-function-declaration]
> |  unsigned int len = strchrnul(buf, '\n') - buf;
> |                     ^~~~~~~~~
> |                     strchr
> |include/linux/cpumask.h:636:42: error: invalid operands to binary - (have ‘int’ and ‘const char *’)
> |  unsigned int len = strchrnul(buf, '\n') - buf;
> |                     ~~~~~~~~~~~~~~~~~~~~ ^
> |cc1: some warnings being treated as errors
> 
> 3713a4e1fdb8da86f96a3e770b08e278d97529b4 is the first bad commit
> commit 3713a4e1fdb8da86f96a3e770b08e278d97529b4
> Author: Yury Norov <ynorov@marvell.com>
> Date:   Tue May 14 15:44:46 2019 -0700
> 
>     include/linux/cpumask.h: fix double string traverse in cpumask_parse
> 
>     cpumask_parse() finds first occurrence of either or strchr() and
>     strlen().  We can do it better with a single call of strchrnul().
> 
>     [akpm@linux-foundation.org: remove unneeded cast]
>     Link: http://lkml.kernel.org/r/20190409204208.12190-1-ynorov@marvell.com
>     Signed-off-by: Yury Norov <ynorov@marvell.com>
>     Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> :040000 040000 f20d8a9ec1755b3981520ecf015248f6a0d9f116 db67caf64f99a9be808cd73e413c106c5aee15b7 M      include
> 
> This commit is v5.2-rc1~62^2~49.
> How do we deal with this one?

Urgh. The problem is really in arch/arm/boot/compressed/decompress.c
which does

#define _LINUX_STRING_H_

preventing linux/string.h from providing strchrnul. It also #includes
asm/string.h, which for arm has a declaration of strchr(), explaining
why this didn't use to fail.

However, the solution is also in the same file, it already has a section

/* Not needed, but used in some headers pulled in by decompressors */
extern char * strstr(const char * s1, const char *s2);
extern size_t strlen(const char *s);
extern int memcmp(const void *cs, const void *ct, size_t count);

so just add another declaration to that list - I strongly assume we
won't get a link failure since I find it hard to believe the
decompressor would actually call cpumask_parse...

I'm wondering why this wasn't caught by 0day and/or while in -next?

Rasmus
