Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E77C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55BB20656
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 13:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvgLuCZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfKZN4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 08:56:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34814 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfKZN4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 08:56:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so22570226wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 05:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JswOlyb589G5w0IyVqcAkuxRTz98L7X87/526rSzH90=;
        b=LvgLuCZ+bhZm5MLQI1rq6S+nQ/bToTNfA//brKMg1x7qMzUkjnxj/I7DjT8Cd0YntI
         IjhMgroQuTMrfW0ZsRSZZ6RoUKLejQoE77Ye3O3F7d2QNSvWtaxI1C4WSx8hFWpwMPop
         zQRxI8ZMm91JC6lkaSrX5HfIhuSpDYG/bJezDO/Ppdvx3sct+sXqdAlqQDahUpaREvWl
         lcpa+4NLqnxVY2n74fNoGxN3ANBNUMlNbfqxdjqFW0r0M2kDo9hqlqeIhsr/Db1uZYFN
         cxs/9Q3bMwLJyvV9UfL8JXDZIzkpvP/Pck9fS5ZE+n+FLR+d03GAyijQ4QoeTb8pz5pJ
         8U9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JswOlyb589G5w0IyVqcAkuxRTz98L7X87/526rSzH90=;
        b=q+UzDJAmeKYgpjkzFnfKpMwgmDruHwR9ZmXvN3VF+G1CIrwDp5cgNPZPPcdFQg8O1p
         qVGEuCjO6vi3+E65zZeiWQwo5jDCi00zt5YtGVoFOFFWwWGJ4gYtD2ZdnphHrjrK3f5i
         IaTKKS9diKzHwcyNvagd3u/aZ3Yn6cGq2ef0kHsP3OZ7k1NCVViPbsoH999cxkQCEHm9
         HJtBXjHjBPfDHhpynqJIUA6CBbfnaWJYo7XdKxNaqLDwVnpS6GUXRvjG9skQFiL7TfQK
         H7H7Ewlz+ihSk8n6O2E/lHgUKqBz/ik/FoGWdZmwm9gIquaYyU1/kHSUzjRBMUnw2knY
         EEOw==
X-Gm-Message-State: APjAAAXQHHk2A2CKTuTd0Eo4TTJ9orMHbAl9Af9Ze/9Uei1suF8JuT+U
        FEqaV+Ot0zvqqYBgSWVx7DXUSg==
X-Google-Smtp-Source: APXvYqxQrCZlFMRleSBbqM1E4bvKiDqWFY03vVccQWzSJGr1+Nn8KR5QKv4RmCTOXDI6FMhTUUO56w==
X-Received: by 2002:a5d:6651:: with SMTP id f17mr34347543wrw.208.1574776581665;
        Tue, 26 Nov 2019 05:56:21 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id x8sm3069529wmi.10.2019.11.26.05.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 05:56:21 -0800 (PST)
Date:   Tue, 26 Nov 2019 13:56:20 +0000
From:   Matthias Maennich <maennich@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] export.h: reduce __ksymtab_strings string duplication
 by using "MS" section flags
Message-ID: <20191126135620.GA38845@google.com>
References: <20191120145110.8397-1-jeyu@kernel.org>
 <20191125154217.18640-1-jeyu@kernel.org>
 <CAK7LNASU9YysYNXuBKSU4WeUyE=2itfLDYzCupXL-49GUZuGnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNASU9YysYNXuBKSU4WeUyE=2itfLDYzCupXL-49GUZuGnQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 05:32:59PM +0900, Masahiro Yamada wrote:
>On Tue, Nov 26, 2019 at 12:42 AM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> Commit c3a6cf19e695 ("export: avoid code duplication in
>> include/linux/export.h") refactors export.h quite nicely, but introduces
>> a slight increase in memory usage due to using the empty string ""
>> instead of NULL to indicate that an exported symbol has no namespace. As
>> mentioned in that commit, this meant an increase of 1 byte per exported
>> symbol without a namespace. For example, if a kernel configuration has
>> about 10k exported symbols, this would mean that the size of
>> __ksymtab_strings would increase by roughly 10kB.
>>
>> We can alleviate this situation by utilizing the SHF_MERGE and
>> SHF_STRING section flags. SHF_MERGE|SHF_STRING indicate to the linker
>> that the data in the section are null-terminated strings that can be
>> merged to eliminate duplication. More specifically, from the binutils
>> documentation - "for sections with both M and S, a string which is a
>> suffix of a larger string is considered a duplicate. Thus "def" will be
>> merged with "abcdef"; A reference to the first "def" will be changed to
>> a reference to "abcdef"+3". Thus, all the empty strings would be merged
>> as well as any strings that can be merged according to the cited method
>> above. For example, "memset" and "__memset" would be merged to just
>> "__memset" in __ksymtab_strings.
>>
>> As of v5.4-rc5, the following statistics were gathered with x86
>> defconfig with approximately 10.7k exported symbols.
>>
>> Size of __ksymtab_strings in vmlinux:
>> -------------------------------------
>> v5.4-rc5: 213834 bytes
>> v5.4-rc5 with commit c3a6cf19e695: 224455 bytes
>> v5.4-rc5 with this patch: 205759 bytes
>>
>> So, we already see memory savings of ~8kB compared to vanilla -rc5 and
>> savings of nearly 18.7kB compared to -rc5 with commit c3a6cf19e695 on top.
>>
>> Unfortunately, as of this writing, strings will not get deduplicated for
>> kernel modules, as ld does not do the deduplication for
>> SHF_MERGE|SHF_STRINGS sections for relocatable files (ld -r), which
>> kernel modules are. A patch for ld is currently being worked on to
>> hopefully allow for string deduplication in relocatable files in the
>> future.
>>

Thanks for working on this!

>> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>> ---
>>
>> v2: use %progbits throughout and document the oddity in a comment.
>>
>>  include/asm-generic/export.h |  8 +++++---
>>  include/linux/export.h       | 27 +++++++++++++++++++++------
>>  2 files changed, 26 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
>> index fa577978fbbd..23bc98e97a66 100644
>> --- a/include/asm-generic/export.h
>> +++ b/include/asm-generic/export.h
>> @@ -26,9 +26,11 @@
>>  .endm
>>
>>  /*
>> - * note on .section use: @progbits vs %progbits nastiness doesn't matter,
>> - * since we immediately emit into those sections anyway.
>> + * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
>> + * section flag requires it. Use '%progbits' instead of '@progbits' since the
>> + * former apparently works on all arches according to the binutils source.
>>   */
>> +
>>  .macro ___EXPORT_SYMBOL name,val,sec
>>  #ifdef CONFIG_MODULES
>>         .globl __ksymtab_\name
>> @@ -37,7 +39,7 @@
>>  __ksymtab_\name:
>>         __put \val, __kstrtab_\name
>>         .previous
>> -       .section __ksymtab_strings,"a"
>> +       .section __ksymtab_strings,"aMS",%progbits,1
>>  __kstrtab_\name:
>>         .asciz "\name"
>>         .previous
>> diff --git a/include/linux/export.h b/include/linux/export.h
>> index 201262793369..3d835ca34d33 100644
>> --- a/include/linux/export.h
>> +++ b/include/linux/export.h
>> @@ -81,16 +81,31 @@ struct kernel_symbol {
>>
>>  #else
>>
>> +/*
>> + * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
>> + * section flag requires it. Use '%progbits' instead of '@progbits' since the
>> + * former apparently works on all arches according to the binutils source.
>> + */
>> +#define __KSTRTAB_ENTRY(sym)                                                   \
>> +       asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1      \n"     \
>> +           "__kstrtab_" #sym ":                                        \n"     \
>> +           "   .asciz  \"" #sym "\"                                    \n"     \
>> +           "   .previous                                               \n")
>> +
>> +#define __KSTRTAB_NS_ENTRY(sym, ns)                                            \
>> +       asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1      \n"     \
>> +           "__kstrtabns_" #sym ":                                      \n"     \
>> +           "   .asciz  " #ns "                                         \n"     \
>
>
>Hmm, it took some time for me to how this code works.
>
>ns is already a C string, then you added # to it,
>then I was confused.
>
>Personally, I prefer this code:
>" .asciz \"" ns "\" \n"
>
>so it looks in the same way as __KSTRTAB_ENTRY().

I agree with this, these entries should be consistent.

>
>
>
>BTW, you duplicated \"aMS\",%progbits,1" and ".previous"
>
>
>I would write it shorter, like this:
>
>
>#define ___EXPORT_SYMBOL(sym, sec, ns) \
>        extern typeof(sym) sym; \
>        extern const char __kstrtab_##sym[]; \
>        extern const char __kstrtabns_##sym[]; \
>        __CRC_SYMBOL(sym, sec); \
>        asm("    .section \"__ksymtab_strings\",\"aMS\",%progbits,1\n" \
>            "__kstrtab_" #sym ": \n" \
>            "     .asciz \"" #sym "\" \n" \
>            "__kstrtabns_" #sym ": \n" \
>            "     .asciz \"" ns "\" \n" \
>            "     .previous \n");    \
>       __KSYMTAB_ENTRY(sym, sec)
>

I would prefer the separate macros though (as initially proposed) as I
find them much more readable. The code is already a bit tricky to reason
about and I don't think the shorter version is enough of a gain.

>
>
>
>
>
>
>
>> +           "   .previous                                               \n")
>> +
>>  /* For every exported symbol, place a struct in the __ksymtab section */
>>  #define ___EXPORT_SYMBOL(sym, sec, ns)                                 \
>>         extern typeof(sym) sym;                                         \
>> +       extern const char __kstrtab_##sym[];                            \
>> +       extern const char __kstrtabns_##sym[];                          \
>>         __CRC_SYMBOL(sym, sec);                                         \
>> -       static const char __kstrtab_##sym[]                             \
>> -       __attribute__((section("__ksymtab_strings"), used, aligned(1))) \
>> -       = #sym;                                                         \

You could keep simplified versions of these statements as comment for
the above macros to increase readability.

>> -       static const char __kstrtabns_##sym[]                           \
>> -       __attribute__((section("__ksymtab_strings"), used, aligned(1))) \
>> -       = ns;                                                           \
>> +       __KSTRTAB_ENTRY(sym);                                           \
>> +       __KSTRTAB_NS_ENTRY(sym, ns);                                    \
>>         __KSYMTAB_ENTRY(sym, sec)
>>
>>  #endif
>> --
>> 2.16.4
>>

With the above addressed, please feel free to add

Reviewed-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias

>
>
>-- 
>Best Regards
>Masahiro Yamada
