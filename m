Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE8BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF63F2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574762118;
	bh=MzKgqKCa7NaA8Djx5qejgsOtT2+/H2cyYVcKH3ql0Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nc+TjbMFTWJNrau9W1uM9GiVRL6myaPhvHTTKCh3Nydu5/Zhb7plmY3wfkBjpC11G
	 SjbGl7WfWXlMWxhVknEoktnxqB/2bOwklZgKSQvcJnOpqwW5idGaEhtfz4uQiGVnKb
	 NpoGiLan5ig1LD650H9YL+lGvoOt9McM2q9VWcQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfKZJzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:55:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727557AbfKZJzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:55:17 -0500
Received: from linux-8ccs (x2f7fc62.dyn.telefonica.de [2.247.252.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5C42075C;
        Tue, 26 Nov 2019 09:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574762116;
        bh=MzKgqKCa7NaA8Djx5qejgsOtT2+/H2cyYVcKH3ql0Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GdGD6tkDzZas/Y4hkk9UHE5NsbTPmf86gXupJNtx0Vgt/WN0rWMS2sPrKZn6FTvsU
         OvbZzZSB6HJaXSD9T+iiGNpButycABEAI1g/M/MQzp0B3sYbMyjRp9eLUVVAPQ21VE
         bwQAAEdaHAlwa5MOVaClVN2R424QphdxVNm0kRoU=
Date:   Tue, 26 Nov 2019 10:55:10 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] export.h: reduce __ksymtab_strings string duplication
 by using "MS" section flags
Message-ID: <20191126095510.GA30181@linux-8ccs>
References: <20191120145110.8397-1-jeyu@kernel.org>
 <20191125154217.18640-1-jeyu@kernel.org>
 <CAK7LNASU9YysYNXuBKSU4WeUyE=2itfLDYzCupXL-49GUZuGnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNASU9YysYNXuBKSU4WeUyE=2itfLDYzCupXL-49GUZuGnQ@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.4.0-rc5-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [26/11/19 17:32 +0900]:
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

Sure, I can change that. Just thought it'd be easier to read with the
separate macros. Thanks for your comments!

