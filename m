Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D20BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CFD2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574675167;
	bh=SmxMpsS12PjFHRDcNUQ51+o9OMvfqAy4ZRREUthu25g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pJ6zCf6CfuD9XqUZYCuREoKQjlBK/pLTcMeWYMZJd5r43PT0qcfeuHflcxeIF6Vy9
	 Eu3ZHsSax0Qm5+o/QSgvYi2Oa1tTsJYObdfSFJY5X+OSebo4cu5y8y92l66Fjo4MBM
	 pj/LKK5OQaNm8mDnHX6T3HlZNgH2e9F0l/ui5qd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfKYJqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfKYJqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:46:05 -0500
Received: from linux-8ccs (x2f7fe0e.dyn.telefonica.de [2.247.254.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57B33207FD;
        Mon, 25 Nov 2019 09:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574675165;
        bh=SmxMpsS12PjFHRDcNUQ51+o9OMvfqAy4ZRREUthu25g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xvWGAkj0GDfi1tdbON1LdGTuWpZ7O3xx+xtdatiaaVC5Z/ZP3CCu0JVVUdXk2md58
         DCS7MHQ6CfmFWRCEFgGQudELFUuHJgXYbbktG/PuB7DbCbEyMqZjvj2zpjEJCKHIPV
         U2gHjfoUmoswHcLmzhR82lhiIIJ7CeuS4ZQuTBQ4=
Date:   Mon, 25 Nov 2019 10:45:58 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "binutils@sourceware.org" <binutils@sourceware.org>
Subject: Re: [PATCH] export.h: reduce __ksymtab_strings string duplication by
 using "MS" section flags
Message-ID: <20191125094557.GA31961@linux-8ccs>
References: <20191120145110.8397-1-jeyu@kernel.org>
 <93d3936d-0bc4-9639-7544-42a324f01ac1@rasmusvillemoes.dk>
 <20191121160919.GB22213@linux-8ccs>
 <CAK7LNAT=+VMTpK3nBy3J-M9idf8MBi4dB4WKexYatiV2pNHvMg@mail.gmail.com>
 <b280c412-432b-ff54-acbd-a6bcc74b6e72@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b280c412-432b-ff54-acbd-a6bcc74b6e72@rasmusvillemoes.dk>
X-OS:   Linux linux-8ccs 5.4.0-rc5-lp150.12.61-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Rasmus Villemoes [25/11/19 10:29 +0100]:
>cc += binutils ML
>
>[on @progbits v %progbits in generic (data only) assembly code]
>
>On 22/11/2019 12.44, Masahiro Yamada wrote:
>> On Fri, Nov 22, 2019 at 1:09 AM Jessica Yu <jeyu@kernel.org> wrote:
>>>
>
>>> I think this would work, and it feels like the more correct solution
>>> especially if arm isn't the only one with the odd progbits char. It
>>> might be overkill if it's just arm that's affected though. I leave it
>>> to Masahiro to see what he prefers.
>>>
>>
>>
>> BTW, is there any reason why
>> not use %progbits all the time?
>>
>>
>> include/linux/init.h hard-codes %progbits
>>
>>    #define __INITDATA .section ".init.data","aw",%progbits
>>    #define __INITRODATA .section ".init.rodata","a",%progbits
>>
>>
>> So, my understanding is '%' works for all architectures,
>> but it is better to ask 0-day bot to test it.
>
>It seems that you're absolutely right. The binutils source has code like
>
>+             if (*input_line_pointer == '@' || *input_line_pointer == '%')
>+               {
>+                 ++input_line_pointer;
>+                 if (strncmp (input_line_pointer, "progbits",
>+                              sizeof "progbits" - 1) == 0)
>+                   {
>+                     type = SHT_PROGBITS;
>+                     input_line_pointer += sizeof "progbits" - 1;
>+                   }
>+                 else if (strncmp (input_line_pointer, "nobits",
>+                                   sizeof "nobits" - 1) == 0)
>+                   {
>+                     type = SHT_NOBITS;
>+                     input_line_pointer += sizeof "nobits" - 1;
>+                   }

Yeah, I saw this too while digging. I also came across this commit in
the binutils source:

commit ecc054c097e7ced281d02ef9632eb0261a410b96
Author: Thomas Preud'homme <thomas.preudhomme@arm.com>
Date:   Fri Mar 2 11:51:34 2018 +0000

    [GDB/testsuite] Use %progbits in watch-loc.c

    While using @progbits in .pushsection work on some targets, it does not
    work on arm target where this introduces a comment. This patch replaces
    its use in gdb.dlang/watch-loc.c and gdb.mi/dw2-ref-missing-frame-func.c
    by %progbits which should work on all targets since it is used in
    target-independent elf/section7.s GAS test.

    2018-03-02  Thomas Preud'homme  <thomas.preudhomme@arm.com>

    gdb/testsuite/
            * gdb.dlang/watch-loc.c: Use %progbits instead of @progbits.
            * gdb.mi/dw2-ref-missing-frame-func.c: Likewise.

So that seems to confirm this theory :-) I'm just surprised it isn't
documented anywhere it seems.

>The only reason I thought one needed to do it differently on ARM is this
>from the gas docs:
>
>===
>   The optional TYPE argument may contain one of the following
>constants:
>
>'@progbits'
>     section contains data
>...
>   Note on targets where the '@' character is the start of a comment (eg
>ARM) then another character is used instead.  For example the ARM port
>uses the '%' character.
>===
>
>That doesn't suggest the possibility that % or some other character
>might work on all architectures.
>
>Jessica, can you resend using just %progbits to let kbuild chew on that?
>Please include a comment about the misleading gas documentation.

Yup, sounds good. Thanks!

Jessica
