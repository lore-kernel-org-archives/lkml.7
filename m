Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8EAC17498
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638DE217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572965762;
	bh=5hcg8ghxSHxPjlGqTjjIe+i79uK3s5zbWA5ceL1DZRI=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=IVEkAFrGfvCmhCzrUOU73XfSmHNVyxEnh04Dm4JAoeDhCy+PbVIPu8rPYnwwillc2
	 T5iAqcM8XPva84eNrgTmJjH1+tw2jgQkiUpejZtxOUsYytnMAG3KAxD3fD8ykyNeyn
	 ZxibXHXTmqCw4WRO2aA4YIO1gpk55megmVAJhwVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389464AbfKEO4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:56:01 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:42262 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389138AbfKEO4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:56:00 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iS0Ew-0000Z9-LF; Tue, 05 Nov 2019 15:55:26 +0100
To:     Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v4 13/17] arm64: preserve x18 when CPU is suspended
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Nov 2019 16:04:47 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <dave.martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CABCJKueN+Op8xm+L3aSFgCL9BLC8b-WHj3oBYhf1W=OcX2aqCg@mail.gmail.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com>
 <20191101221150.116536-14-samitolvanen@google.com>
 <02c56a5273f94e9d832182f1b3cb5097@www.loen.fr>
 <CABCJKucVON6uUMH6hVP7RODqH8u63AP3SgTCBWirrS30yDOmdA@mail.gmail.com>
 <CAKwvOdkDbX4zLChH_DKrnOah1sJjTA-e3uZOXUP6nUs-EaJreg@mail.gmail.com>
 <CABCJKueN+Op8xm+L3aSFgCL9BLC8b-WHj3oBYhf1W=OcX2aqCg@mail.gmail.com>
Message-ID: <5486328a221c9eaef8956983f70380f1@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: samitolvanen@google.com, ndesaulniers@google.com, will@kernel.org, catalin.marinas@arm.com, rostedt@goodmis.org, mhiramat@kernel.org, ard.biesheuvel@linaro.org, dave.martin@arm.com, keescook@chromium.org, labbott@redhat.com, mark.rutland@arm.com, jannh@google.com, miguel.ojeda.sandonis@gmail.com, yamada.masahiro@socionext.com, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-05 01:11, Sami Tolvanen wrote:
> On Mon, Nov 4, 2019 at 1:59 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> On Mon, Nov 4, 2019 at 1:38 PM Sami Tolvanen 
>> <samitolvanen@google.com> wrote:
>> >
>> > On Mon, Nov 4, 2019 at 5:20 AM Marc Zyngier <maz@kernel.org> 
>> wrote:
>> > > >  ENTRY(cpu_do_suspend)
>> > > >       mrs     x2, tpidr_el0
>> > > > @@ -73,6 +75,9 @@ alternative_endif
>> > > >       stp     x8, x9, [x0, #48]
>> > > >       stp     x10, x11, [x0, #64]
>> > > >       stp     x12, x13, [x0, #80]
>> > > > +#ifdef CONFIG_SHADOW_CALL_STACK
>> > > > +     str     x18, [x0, #96]
>> > > > +#endif
>> > >
>> > > Do we need the #ifdefery here? We didn't add that to the KVM 
>> path,
>> > > and I'd feel better having a single behaviour, specially when
>> > > NR_CTX_REGS is unconditionally sized to hold 13 regs.
>> >
>> > I'm fine with dropping the ifdefs here in v5 unless someone 
>> objects to this.
>>
>> Oh, yeah I guess it would be good to be consistent.  Rather than 
>> drop
>> the ifdefs, would you (Marc) be ok with conditionally setting
>> NR_CTX_REGS based on CONFIG_SHADOW_CALL_STACK, and doing so in KVM?
>> (So 3 ifdefs, rather than 0)?
>>
>> Without any conditionals or comments, it's not clear why x18 is 
>> being
>> saved and restored (unless git blame survives, or a comment is added
>> in place of the ifdefs in v6).
>
> True. Clearing the sleep state buffer in cpu_do_resume is also
> pointless without CONFIG_SHADOW_CALL_STACK, so if the ifdefs are
> removed, some kind of an explanation is needed there.

I can't imagine the overhead being noticeable, and I certainly value
minimizing the testing space. Sticking a comment there should be
enough for people hacking on this to understand that this isn't
entirely dead code.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
