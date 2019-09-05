Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D81FC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC422184B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="btHT7GGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbfIELHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:07:16 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34200 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388210AbfIELHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:07:16 -0400
Received: by mail-lj1-f193.google.com with SMTP id x18so2035258ljh.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 04:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=awgGG7PoehyEFjxIOMZzO82Py8AU0HzM0+1fNVh8Nek=;
        b=btHT7GGqzGrm1wNvvUgF7ReN983yTJv20r++3a81YmdaYCUtLuLXMg5FEkOINUFfH3
         B1LoEbas2kd9E6f6mIe4JmHN1eXIwUcX3o0HiK6RElvTu5+2O9byq3MVghNq/yC4KuiH
         EHGJdLEAmcTgwyOk0tQupREnLQVij3L6M6U0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=awgGG7PoehyEFjxIOMZzO82Py8AU0HzM0+1fNVh8Nek=;
        b=edJ/HnnGJeZ4+/BJ6Ma/PulJJHtSL7E/uE/x9Sa2AFtM6B/dbwOJn/MBPrbk76aScH
         uMW97WtPTEc4FkiAgrq//g6LU2Qs586+s+GNIOR2xtTg5cWT3B5ik8zj71xA3qAarJ/g
         gyugXCxZp5PxMV67z64mluMXjoUrbIQb/uc8+yWXVp9QIqZ6PTXNnTQOB1ZqrpLuagRV
         IwsWJh/tvFJLmpZ311tJkdNwRxqs4QNVcagLbkXepo04Qoi57LJM0elDwyd5ts6X9k7Y
         2Uo7xE0bzqM5TcJwWdZBR+732qfKZhAUOn1lCjZbfVh3qi+pmUC1GS+35ko7g+ldXzbM
         o5kA==
X-Gm-Message-State: APjAAAU9+1WwmYF+EfBZImc/U5eSj0C1m40Ab19/z2m1eG5Ru/fu82L6
        rvw5V8Dhi4+qUdkL3hK3zSiavQ==
X-Google-Smtp-Source: APXvYqzmTD/daq/Fw2gpo8A24bIobH6jRq2E7/vrdw2MFtDRcZqN9kZKWZKI/Q1smrKhpGAnB0ZuLA==
X-Received: by 2002:a2e:8507:: with SMTP id j7mr1714520lji.156.1567681633894;
        Thu, 05 Sep 2019 04:07:13 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l23sm313049lje.106.2019.09.05.04.07.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 04:07:13 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-5-linux@rasmusvillemoes.dk>
 <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk>
Date:   Thu, 5 Sep 2019 13:07:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2019 02.18, Nick Desaulniers wrote:
> On Fri, Aug 30, 2019 at 4:15 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> This adds an asm_inline macro which expands to "asm inline" [1] when gcc
>> is new enough (>= 9.1), and just asm for older gccs and other
>> compilers.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  include/linux/compiler-gcc.h   | 4 ++++
>>  include/linux/compiler_types.h | 4 ++++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>> index d7ee4c6bad48..544b87b41b58 100644
>> --- a/include/linux/compiler-gcc.h
>> +++ b/include/linux/compiler-gcc.h
>> @@ -172,3 +172,7 @@
>>  #endif
>>
>>  #define __no_fgcse __attribute__((optimize("-fno-gcse")))
>> +
>> +#if GCC_VERSION >= 90100
> 
> Is it too late to ask for a feature test macro? Maybe one already
> exists? 

No, not as far as I know. Perhaps something like below, though that
won't affect the already released gcc 9.1 and 9.2, of course.

gcc maintainers, WDYT? Can we add a feature test macro for asm inline()?
For context, I'm trying to add an asm_inline macro to the kernel source
that will fall back to asm when "asm inline" is not supported - see
https://lore.kernel.org/lkml/20190830231527.22304-1-linux@rasmusvillemoes.dk/
for the whole thread.

From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH] add feature test macro for "asm inline"

Allow users to check availability of "asm inline()" via a feature test
macro. If and when clang implements support for "asm inline()", it's
easier for users if they can just test __HAVE_ASM_INLINE rather than
juggling different version checks for different compilers.

Changelog:

gcc/c-family/

	* c-cppbuiltin.c (c_cpp_builtins): Add pre-define for
	__HAVE_ASM_INLINE.

gcc/

	* doc/cpp.texi: Document predefine __HAVE_ASM_INLINE.
---
 gcc/c-family/c-cppbuiltin.c | 3 +++
 gcc/doc/cpp.texi            | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/gcc/c-family/c-cppbuiltin.c b/gcc/c-family/c-cppbuiltin.c
index fc68bc4d0c4..163f3058741 100644
--- a/gcc/c-family/c-cppbuiltin.c
+++ b/gcc/c-family/c-cppbuiltin.c
@@ -1383,6 +1383,9 @@ c_cpp_builtins (cpp_reader *pfile)
   if (targetm.have_speculation_safe_value (false))
     cpp_define (pfile, "__HAVE_SPECULATION_SAFE_VALUE");

+  /* Show the availability of "asm inline()".  */
+  cpp_define (pfile, "__HAVE_ASM_INLINE");
+
 #ifdef DWARF2_UNWIND_INFO
   if (dwarf2out_do_cfi_asm ())
     cpp_define (pfile, "__GCC_HAVE_DWARF2_CFI_ASM");
diff --git a/gcc/doc/cpp.texi b/gcc/doc/cpp.texi
index e271f5180d8..98f6d625857 100644
--- a/gcc/doc/cpp.texi
+++ b/gcc/doc/cpp.texi
@@ -2386,6 +2386,11 @@ and swap operations on operands 1, 2, 4, 8 or 16
bytes in length, respectively.
 This macro is defined with the value 1 to show that this version of GCC
 supports @code{__builtin_speculation_safe_value}.

+@item __HAVE_ASM_INLINE
+This macro is defined with the value 1 to show that this version of GCC
+supports @code{asm inline()}.  @xref{Size of an asm,,, gcc, Using
+the GNU Compiler Collection (GCC)}.
+
 @item __GCC_HAVE_DWARF2_CFI_ASM
 This macro is defined when the compiler is emitting DWARF CFI directives
 to the assembler.  When this is defined, it is possible to emit those same

