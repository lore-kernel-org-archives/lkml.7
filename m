Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98150C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524AA22525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GKvlGkdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfLEQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:42:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39066 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbfLEQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:42:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so4427831wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 08:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zEeIaDD5wJYLZfhZ+Ia7RYblxopER+BjO5JLcDGnO6M=;
        b=GKvlGkdDpnUAOS/Dc8lUkqC18dBAt9sDE02gy+XW4yTuLxTF9VL01L1G7OLEKngHkL
         e9YSTfii+3c/P9VYGkuW8516ex72gwOwEykok3sB6lh9uGVUVJh2h7pGUTkYGJrPB/fX
         Yxk+tek934FyzbGoJM4zPPFj8JVUbakEDBCF8gstcXrqmIlz6xoVexqJI1XSPQfgv+vt
         emJ6iy/svOZanmQX15ACafpixGeffFrqt3CvVBFrbtX56fEVTzLcCu4bglt2E4SvdaF9
         foC27uVqyWCXDRkUwta4t2ric4ElHwhxFrOwTKeG8tVSDsw+6CnD6C2M1y71GmlAPRgu
         baAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zEeIaDD5wJYLZfhZ+Ia7RYblxopER+BjO5JLcDGnO6M=;
        b=OFjOB2qBXZjuVifstdfIdWk/EuLEGkAc5XI+Jk0OocqOl+JjM4WJE/ii2UE0lIP2jE
         viY8/2uH9uVxoZNO1VNLOjnHC+amW4Z3GT6nnfP6jh3aeiPP+DMNGfetHWVba+0yiPCq
         TCCzyiMngVnIh0OBNVSHH/Py7YlrzbjvDhn/mH+Z+wFAYjzubIxewFmZE8s6crwcb6Ht
         zY8qnEzf634su0Ldvx2a2blvFfr8B5uKwhSOYqiU6LA44AHSSnoth1hq1MizBelTUgy5
         2sENbcFkfbhDsvT3rcVF8q4NWbHEoOSVDGIXRsipN1eJCPTVW5BtK4dvfm2OhoPjlr6l
         jvPA==
X-Gm-Message-State: APjAAAXCRf5BTeiq6IZjUDE2Yf5jOtC+wRhG72eb9MW4zubY+FKa+hRd
        XFN+0NiibPaiEup994zom6wfPw==
X-Google-Smtp-Source: APXvYqwcpP58mnELJdkb789t4UHy5+8tY1o7+m1WF8Vd4NoKhsZ7QdLUwAFPJiTTfSAuNHs1rLQ+Ng==
X-Received: by 2002:adf:a141:: with SMTP id r1mr11435375wrr.285.1575564173570;
        Thu, 05 Dec 2019 08:42:53 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id d8sm12894558wre.13.2019.12.05.08.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 08:42:52 -0800 (PST)
Date:   Thu, 5 Dec 2019 16:42:52 +0000
From:   Matthias Maennich <maennich@google.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] export.h: reduce __ksymtab_strings string duplication
 by using "MS" section flags
Message-ID: <20191205164252.GD148072@google.com>
References: <20191120145110.8397-1-jeyu@kernel.org>
 <20191125154217.18640-1-jeyu@kernel.org>
 <CAK7LNASU9YysYNXuBKSU4WeUyE=2itfLDYzCupXL-49GUZuGnQ@mail.gmail.com>
 <20191126135620.GA38845@google.com>
 <20191126153153.GA3495@linux-8ccs>
 <CAK7LNAS9WoqJh2NR81QrYNGVAUhbgU0Y97791HYb1XeAuHCtWw@mail.gmail.com>
 <20191126164840.GA8011@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191126164840.GA8011@linux-8ccs>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 05:48:40PM +0100, Jessica Yu wrote:
>+++ Masahiro Yamada [27/11/19 01:12 +0900]:
>>On Wed, Nov 27, 2019 at 12:32 AM Jessica Yu <jeyu@kernel.org> wrote:
>>>
>>>+++ Matthias Maennich [26/11/19 13:56 +0000]:
>>>>On Tue, Nov 26, 2019 at 05:32:59PM +0900, Masahiro Yamada wrote:
>>>>>On Tue, Nov 26, 2019 at 12:42 AM Jessica Yu <jeyu@kernel.org> wrote:
>>>>>>
>>>>>>Commit c3a6cf19e695 ("export: avoid code duplication in
>>>>>>include/linux/export.h") refactors export.h quite nicely, but introduces
>>>>>>a slight increase in memory usage due to using the empty string ""
>>>>>>instead of NULL to indicate that an exported symbol has no namespace. As
>>>>>>mentioned in that commit, this meant an increase of 1 byte per exported
>>>>>>symbol without a namespace. For example, if a kernel configuration has
>>>>>>about 10k exported symbols, this would mean that the size of
>>>>>>__ksymtab_strings would increase by roughly 10kB.
>>>>>>
>>>>>>We can alleviate this situation by utilizing the SHF_MERGE and
>>>>>>SHF_STRING section flags. SHF_MERGE|SHF_STRING indicate to the linker
>>>>>>that the data in the section are null-terminated strings that can be
>>>>>>merged to eliminate duplication. More specifically, from the binutils
>>>>>>documentation - "for sections with both M and S, a string which is a
>>>>>>suffix of a larger string is considered a duplicate. Thus "def" will be
>>>>>>merged with "abcdef"; A reference to the first "def" will be changed to
>>>>>>a reference to "abcdef"+3". Thus, all the empty strings would be merged
>>>>>>as well as any strings that can be merged according to the cited method
>>>>>>above. For example, "memset" and "__memset" would be merged to just
>>>>>>"__memset" in __ksymtab_strings.
>>>>>>
>>>>>>As of v5.4-rc5, the following statistics were gathered with x86
>>>>>>defconfig with approximately 10.7k exported symbols.
>>>>>>
>>>>>>Size of __ksymtab_strings in vmlinux:
>>>>>>-------------------------------------
>>>>>>v5.4-rc5: 213834 bytes
>>>>>>v5.4-rc5 with commit c3a6cf19e695: 224455 bytes
>>>>>>v5.4-rc5 with this patch: 205759 bytes
>>>>>>
>>>>>>So, we already see memory savings of ~8kB compared to vanilla -rc5 and
>>>>>>savings of nearly 18.7kB compared to -rc5 with commit c3a6cf19e695 on top.
>>>>>>
>>>>>>Unfortunately, as of this writing, strings will not get deduplicated for
>>>>>>kernel modules, as ld does not do the deduplication for
>>>>>>SHF_MERGE|SHF_STRINGS sections for relocatable files (ld -r), which
>>>>>>kernel modules are. A patch for ld is currently being worked on to
>>>>>>hopefully allow for string deduplication in relocatable files in the
>>>>>>future.
>>>>>>
>>>>
>>>>Thanks for working on this!
>>>>
>>>>>>Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>>>>>Signed-off-by: Jessica Yu <jeyu@kernel.org>
>>>>>>---
>>>>>>
>>>>>>v2: use %progbits throughout and document the oddity in a comment.
>>>>>>
>>>>>> include/asm-generic/export.h |  8 +++++---
>>>>>> include/linux/export.h       | 27 +++++++++++++++++++++------
>>>>>> 2 files changed, 26 insertions(+), 9 deletions(-)
>>>>>>
>>>>>>diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
>>>>>>index fa577978fbbd..23bc98e97a66 100644
>>>>>>--- a/include/asm-generic/export.h
>>>>>>+++ b/include/asm-generic/export.h
>>>>>>@@ -26,9 +26,11 @@
>>>>>> .endm
>>>>>>
>>>>>> /*
>>>>>>- * note on .section use: @progbits vs %progbits nastiness doesn't matter,
>>>>>>- * since we immediately emit into those sections anyway.
>>>>>>+ * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
>>>>>>+ * section flag requires it. Use '%progbits' instead of '@progbits' since the
>>>>>>+ * former apparently works on all arches according to the binutils source.
>>>>>>  */
>>>>>>+
>>>>>> .macro ___EXPORT_SYMBOL name,val,sec
>>>>>> #ifdef CONFIG_MODULES
>>>>>>        .globl __ksymtab_\name
>>>>>>@@ -37,7 +39,7 @@
>>>>>> __ksymtab_\name:
>>>>>>        __put \val, __kstrtab_\name
>>>>>>        .previous
>>>>>>-       .section __ksymtab_strings,"a"
>>>>>>+       .section __ksymtab_strings,"aMS",%progbits,1
>>>>>> __kstrtab_\name:
>>>>>>        .asciz "\name"
>>>>>>        .previous
>>>>>>diff --git a/include/linux/export.h b/include/linux/export.h
>>>>>>index 201262793369..3d835ca34d33 100644
>>>>>>--- a/include/linux/export.h
>>>>>>+++ b/include/linux/export.h
>>>>>>@@ -81,16 +81,31 @@ struct kernel_symbol {
>>>>>>
>>>>>> #else
>>>>>>
>>>>>>+/*
>>>>>>+ * note on .section use: we specify progbits since usage of the "M" (SHF_MERGE)
>>>>>>+ * section flag requires it. Use '%progbits' instead of '@progbits' since the
>>>>>>+ * former apparently works on all arches according to the binutils source.
>>>>>>+ */
>>>>>>+#define __KSTRTAB_ENTRY(sym)                                                   \
>>>>>>+       asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1      \n"     \
>>>>>>+           "__kstrtab_" #sym ":                                        \n"     \
>>>>>>+           "   .asciz  \"" #sym "\"                                    \n"     \
>>>>>>+           "   .previous                                               \n")
>>>>>>+
>>>>>>+#define __KSTRTAB_NS_ENTRY(sym, ns)                                            \
>>>>>>+       asm("   .section \"__ksymtab_strings\",\"aMS\",%progbits,1      \n"     \
>>>>>>+           "__kstrtabns_" #sym ":                                      \n"     \
>>>>>>+           "   .asciz  " #ns "                                         \n"     \
>>>>>
>>>>>
>>>>>Hmm, it took some time for me to how this code works.
>>>>>
>>>>>ns is already a C string, then you added # to it,
>>>>>then I was confused.
>>>>>
>>>>>Personally, I prefer this code:
>>>>>" .asciz \"" ns "\" \n"
>>>>>
>>>>>so it looks in the same way as __KSTRTAB_ENTRY().
>>>>
>>>>I agree with this, these entries should be consistent.
>>>>
>>>>>
>>>>>
>>>>>
>>>>>BTW, you duplicated \"aMS\",%progbits,1" and ".previous"
>>>>>
>>>>>
>>>>>I would write it shorter, like this:
>>>>>
>>>>>
>>>>>#define ___EXPORT_SYMBOL(sym, sec, ns) \
>>>>>       extern typeof(sym) sym; \
>>>>>       extern const char __kstrtab_##sym[]; \
>>>>>       extern const char __kstrtabns_##sym[]; \
>>>>>       __CRC_SYMBOL(sym, sec); \
>>>>>       asm("    .section \"__ksymtab_strings\",\"aMS\",%progbits,1\n" \
>>>>>           "__kstrtab_" #sym ": \n" \
>>>>>           "     .asciz \"" #sym "\" \n" \
>>>>>           "__kstrtabns_" #sym ": \n" \
>>>>>           "     .asciz \"" ns "\" \n" \
>>>>>           "     .previous \n");    \
>>>>>      __KSYMTAB_ENTRY(sym, sec)
>>>>>
>>>>
>>>>I would prefer the separate macros though (as initially proposed) as I
>>>>find them much more readable. The code is already a bit tricky to reason
>>>>about and I don't think the shorter version is enough of a gain.
>>>
>>>Yeah, the macros were more readable IMO. But I could just squash them into one
>>>__KSTRTAB_ENTRY macro as a compromise for Masahiro maybe?
>>>
>>>Is this any better?
>>
>>I prefer opposite.
>>
>>
>>__CRC_SYMBOL() is macrofied because it is ifdef'ed by
>>CONFIG_MODVERSIONS and CONFIG_MOD_REL_CRCS.
>>
>>__KSYMTAB_ENTRY() is macrofied because it is ifdef'ed by
>>CONFIG_HAVE_ARCH_PREL32_RELOCATIONS.
>>
>>
>>
>>__KSTRTAB_ENTRY() does not depend on any CONFIG option,
>>so it can be expanded in ___EXPORT_SYMBOL().
>>
>>
>>You need to check multiple locations
>>to understand how it works as a whole.
>>I do not understand why increasing macro-chains is readable.
>
>I think it is "readable" in the sense that when someone is reading
>export.h for the first time, they know exactly what ___EXPORT_SYMBOL()
>is supposed to do, without requiring them to read too deeply into the
>asm and swim through the #ifdefs.  __CRC_SYMBOL(), depending on
>modversions, creates an entry in what would eventually be merged to
>become the __kcrctab section, __KSTRTAB_ENTRY() creates entries in
>__ksymtab_strings, and __KSYMTAB_ENTRY() creates an entry in (what
>would eventually become) the __ksymtab{,_gpl} section. It gives a
>general idea of what it's doing.

I agree with that thought. One option would be, though, to put a proper
comment there to explain what happens in the code. Splitting the
functionality across several macros has the effect that the code feels
easier to reason about and has some implicit documentation through the
macro names. If we could restore that in Masahiro's version, I am ok
with that.

Cheers,
Matthias

>
>However, I do understand your reasoning behind not having an extra
>macro. I'll wait a bit before respinning the patch to see if we can
>get at a consensus..
>
>
