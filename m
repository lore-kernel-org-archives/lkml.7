Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340A4C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053FC20823
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WBq9O9Pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKYJ3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:29:37 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37092 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfKYJ3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:29:36 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so10438404lfp.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 01:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dq6Uw1jKSbn9rliCiVAT4FUxr/UlE/ilqLJWwsbbhdc=;
        b=WBq9O9PuExFV9HTFziWaBCgQvt3JH6f2e8r4vyVfefdR29OvYXIlTOl1inLzuXFkHA
         Cge7Ia89Z879Z6DRmmlBYpJ2rArHVGLuNmyqjNAfj4yCC3PXc1rJFABDydW1nQOsQJUH
         09mYMVHEJzr6yb9asW1zm6h/Zh2T+LsyO1nN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dq6Uw1jKSbn9rliCiVAT4FUxr/UlE/ilqLJWwsbbhdc=;
        b=nU1bC/oMBdVY2Wslhfs7FnwT2II/VPppyitFDdqMrQCvMpWhDExzUp47pqDipgi5He
         aeJTjRBJQdDg7IGG9AzrBCHSvc2TxzcmqpDyNsKY+CmxxTJnY2T5G4b11MD02MozOSLF
         WAjNFGsWV/bIZAVMNPpxc69M1bks3cYpwIKPwzUtI/BdzT8QX5/6xZ+7Yq9FZ1ul10N2
         LdlgPDfr7Dgp+MQbAc+1AiZkEJmZqeQHb7WxQI2S31IuGT2GP/uY3G+/H2oNhlJbqWYi
         T3/uCQ8y5eheuKFIL7GndveiHuvDuhG0t2UrcAB37+M3xasUlM6pcXXGaNEMw+1Mtx+e
         kKbA==
X-Gm-Message-State: APjAAAVEa5hUfeVv9V0zxJA8GZHd7HOYHWn4L7Aq0zphvARepSChRDyE
        cZDgiiUYvZsAQYRz0hQIJcd7dnA1EKkagONO
X-Google-Smtp-Source: APXvYqySWnXzS1fvpw55EUuXRWyEzUWp9mKbL19/EBAI+oL2WjX/ZoWRXY6kKf6lZWis34X1eWRbkw==
X-Received: by 2002:ac2:4882:: with SMTP id x2mr994015lfc.103.1574674172665;
        Mon, 25 Nov 2019 01:29:32 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q20sm3588896ljg.104.2019.11.25.01.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 01:29:32 -0800 (PST)
Subject: Re: [PATCH] export.h: reduce __ksymtab_strings string duplication by
 using "MS" section flags
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "binutils@sourceware.org" <binutils@sourceware.org>
References: <20191120145110.8397-1-jeyu@kernel.org>
 <93d3936d-0bc4-9639-7544-42a324f01ac1@rasmusvillemoes.dk>
 <20191121160919.GB22213@linux-8ccs>
 <CAK7LNAT=+VMTpK3nBy3J-M9idf8MBi4dB4WKexYatiV2pNHvMg@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <b280c412-432b-ff54-acbd-a6bcc74b6e72@rasmusvillemoes.dk>
Date:   Mon, 25 Nov 2019 10:29:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAT=+VMTpK3nBy3J-M9idf8MBi4dB4WKexYatiV2pNHvMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc += binutils ML

[on @progbits v %progbits in generic (data only) assembly code]

On 22/11/2019 12.44, Masahiro Yamada wrote:
> On Fri, Nov 22, 2019 at 1:09 AM Jessica Yu <jeyu@kernel.org> wrote:
>>

>> I think this would work, and it feels like the more correct solution
>> especially if arm isn't the only one with the odd progbits char. It
>> might be overkill if it's just arm that's affected though. I leave it
>> to Masahiro to see what he prefers.
>>
> 
> 
> BTW, is there any reason why
> not use %progbits all the time?
> 
> 
> include/linux/init.h hard-codes %progbits
> 
>    #define __INITDATA .section ".init.data","aw",%progbits
>    #define __INITRODATA .section ".init.rodata","a",%progbits
> 
> 
> So, my understanding is '%' works for all architectures,
> but it is better to ask 0-day bot to test it.

It seems that you're absolutely right. The binutils source has code like

+             if (*input_line_pointer == '@' || *input_line_pointer == '%')
+               {
+                 ++input_line_pointer;
+                 if (strncmp (input_line_pointer, "progbits",
+                              sizeof "progbits" - 1) == 0)
+                   {
+                     type = SHT_PROGBITS;
+                     input_line_pointer += sizeof "progbits" - 1;
+                   }
+                 else if (strncmp (input_line_pointer, "nobits",
+                                   sizeof "nobits" - 1) == 0)
+                   {
+                     type = SHT_NOBITS;
+                     input_line_pointer += sizeof "nobits" - 1;
+                   }


all the way back from

commit 252b5132c753830d5fd56823373aed85f2a0db63 (tag: binu_ss_19990502)
Author: Richard Henderson <rth@redhat.com>
Date:   Mon May 3 07:29:11 1999 +0000

    19990502 sourceware import

So yes, let's just try unconditionally using %progbits, that makes
everything much simpler.

The only reason I thought one needed to do it differently on ARM is this
from the gas docs:

===
   The optional TYPE argument may contain one of the following
constants:

'@progbits'
     section contains data
...
   Note on targets where the '@' character is the start of a comment (eg
ARM) then another character is used instead.  For example the ARM port
uses the '%' character.
===

That doesn't suggest the possibility that % or some other character
might work on all architectures.

Jessica, can you resend using just %progbits to let kbuild chew on that?
Please include a comment about the misleading gas documentation.

Rasmus

