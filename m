Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D47C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A98F208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="M+h+26EI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbfIMIvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:51:51 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:37511 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbfIMIvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:51:51 -0400
Received: by mail-lf1-f51.google.com with SMTP id w67so21515809lff.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oDGDD4cBBpzNeBwTORk2QebjXeQUa+UqEZ6Wy5A9w0g=;
        b=M+h+26EI2FTnwvnNbmYKX29MPdtgERi52twenKh/8tP8cpPmU7t61MtfadybILVbwL
         P5kvJGURcj05z/zDvSOawBEANjC2V2yqHwbQUzBAqOaHeYIq75vesFG22zv9v/w5cSxQ
         zGSQ6H43o5SK2Axzc9B44JwA8W+fzvr1pgWyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oDGDD4cBBpzNeBwTORk2QebjXeQUa+UqEZ6Wy5A9w0g=;
        b=H+l/IC1nQsr8NK9nN+FSbID3O+DB9zMF1CQ4VQuoDTD8UcNOoloSqsfmzEbXpoHPL5
         quvNIkloeFNXxtZ6LFNUlzoQQSqezopNm68dbkQADmYA2RJTlEe6JdO0EI37q0r2HUex
         DWx4zSSP2BZQS3S/Z/1DjGV9UrUe3+zt/NRpxllXW7hYlwTcHOCWv/nH8un3vPGrkctw
         zdTzE0EXF7WPXfCfvg3ZpHjMd7Hbj9Md9XPnqNXcTzouSgm1N3beeEsR4vWszZMsM2Hp
         zZwAquFA4yq6qmO7xXkfSxO/HOueY5dyEtB5LE8B1PmF6xhae8xJztRQLrXv3rvPUco3
         fQDg==
X-Gm-Message-State: APjAAAXEd4+pfX0eo81sDrzQrFLDPz2QUKaNQ0mGJAUZ9uwJZltvMQSc
        YDQccH2ZkWpBKv6Wst7Xx2sYpwBNJL+wBkg/
X-Google-Smtp-Source: APXvYqxqc0PQ7DCsR2CQq8LKXp21FiPhdAjemRBcKOKoA9C0ozOpD1n186ew04OddoLocIzv8kb4Ww==
X-Received: by 2002:a19:f512:: with SMTP id j18mr12220640lfb.169.1568364707849;
        Fri, 13 Sep 2019 01:51:47 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t3sm6883998lfd.92.2019.09.13.01.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 01:51:47 -0700 (PDT)
Subject: Re: [RFC] Improve memset
To:     Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20190913072237.GA12381@zn.tnic>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <51e0a92e-f976-2a3c-b583-cc7696e711bf@rasmusvillemoes.dk>
Date:   Fri, 13 Sep 2019 10:51:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913072237.GA12381@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2019 09.22, Borislav Petkov wrote:
> 
> Instead of calling memset:
> 
> ffffffff8100cd8d:       e8 0e 15 7a 00          callq  ffffffff817ae2a0 <__memset>
> 
> and having a JMP inside it depending on the feature supported, let's simply
> have the REP; STOSB directly in the code:
> 
> ...
> ffffffff81000442:       4c 89 d7                mov    %r10,%rdi
> ffffffff81000445:       b9 00 10 00 00          mov    $0x1000,%ecx
> 
> <---- new memset
> ffffffff8100044a:       f3 aa                   rep stos %al,%es:(%rdi)
> ffffffff8100044c:       90                      nop
> ffffffff8100044d:       90                      nop
> ffffffff8100044e:       90                      nop
> <----
> 

> The result is this:
> 
> static __always_inline void *memset(void *dest, int c, size_t n)
> {
>         void *ret, *dummy;

How is this going to affect cases like memset(p, 0, 4/8/16); where gcc
would normally just do one or two word stores? Is rep; stosb still
competitive in that case? It seems that gcc doesn't recognize memset as
a builtin with this always_inline definition present [1].

>         asm volatile(ALTERNATIVE_2_REVERSE("rep; stosb",
>                                            "call memset_rep",  X86_FEATURE_ERMS,
>                                            "call memset_orig", X86_FEATURE_REP_GOOD)
>                 : "=&D" (ret), "=a" (dummy)
>                 : "0" (dest), "a" (c), "c" (n)
>                 /* clobbers used by memset_orig() and memset_rep_good() */
>                 : "rsi", "rdx", "r8", "r9", "memory");
> 
>         return dest;
> }
> 

Also, am I reading this

>  #include <asm/export.h>
>  
> -.weak memset
> -
>  /*
>   */
> -ENTRY(memset)
> -ENTRY(__memset)

right so there's no longer an actual memset symbol in vmlinux? It seems
that despite the above always_inline definition of memset, gcc can still
emit calls to that to implement large initalizations. (The gcc docs are
actually explicit about that, even under -ffreestanding, "GCC requires
the freestanding environment provide 'memcpy', 'memmove', 'memset' and
'memcmp'.")

[1] I tried this silly stripped-down version with gcc-8:

//#include <string.h>
#include <stddef.h>

#if 1
#define always_inline __inline__ __attribute__((__always_inline__))
static always_inline void *memset(void *dest, int c, size_t n)
{
        void *ret, *dummy;

        asm volatile("rep; stosb"
                : "=&D" (ret), "=a" (dummy)
                : "0" (dest), "a" (c), "c" (n)
                /* clobbers used by memset_orig() and memset_rep_good() */
                : "rsi", "rdx", "r8", "r9", "memory");

        return dest;
}
#endif

struct s { long x; long y; };
int h(struct s *s);
int f(void)
{
	struct s s;
	memset(&s, 0, sizeof(s));
	return h(&s);
}

int g(void)
{
	struct s s[1024] = {};
	return h(s);
}

With or without the string.h include, the result was

0000000000000000 <f>:
   0:   48 83 ec 18             sub    $0x18,%rsp
   4:   31 c0                   xor    %eax,%eax
   6:   b9 10 00 00 00          mov    $0x10,%ecx
   b:   49 89 e2                mov    %rsp,%r10
   e:   4c 89 d7                mov    %r10,%rdi
  11:   f3 aa                   rep stos %al,%es:(%rdi)
  13:   4c 89 d7                mov    %r10,%rdi
  16:   e8 00 00 00 00          callq  1b <f+0x1b>
                        17: R_X86_64_PLT32      h-0x4
  1b:   48 83 c4 18             add    $0x18,%rsp
  1f:   c3                      retq

0000000000000020 <g>:
  20:   48 81 ec 08 40 00 00    sub    $0x4008,%rsp
  27:   ba 00 40 00 00          mov    $0x4000,%edx
  2c:   31 f6                   xor    %esi,%esi
  2e:   48 89 e1                mov    %rsp,%rcx
  31:   48 89 cf                mov    %rcx,%rdi
  34:   e8 00 00 00 00          callq  39 <g+0x19>
                        35: R_X86_64_PLT32      memset-0x4
  39:   48 89 c7                mov    %rax,%rdi
  3c:   e8 00 00 00 00          callq  41 <g+0x21>
                        3d: R_X86_64_PLT32      h-0x4
  41:   48 81 c4 08 40 00 00    add    $0x4008,%rsp
  48:   c3                      retq


With the asm version #if 0'ed out, f() uses two movq (and yields a
warning if the string.h include is omitted, but it still recognizes
memset()).

Rasmus
