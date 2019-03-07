Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDBAC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2823C20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="foRTTzwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfCGTjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:39:21 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35146 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfCGTjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:39:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id j5so12227012pfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 11:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FeTSJufRB2Kaeo4M1FkwnRluTUaoprG0uPauuvIMYYg=;
        b=foRTTzwXO7jqlkzE2P9o9Y8ivjI8Ly0OAb1U7jXnicU06djzhxwVaCP+5EYoSg3dKA
         OZUelKJNmJZA8T7oAZzubjwXlmykJRZ2yiJEx8otlsmacPDwXafQwD/rOw4BUd84/eqH
         ebZo2Aupj1TeGhcY4IJ0Hqgk3ROAC7oZa1Kb2Bc8g7pxuT1ZzivGylRKblbsy1DDN1CM
         IXXjGzNMo4+QL7ojq870zYvYl2HSkFcUmwGrU1Y0+VU85ig7EPkZYPBcR2GKsZMxJxUk
         ioQPJwhUNvPHqqONQSJe4cxAnfWMO98L3VZbAIdDAELQVQIETfw+sU9I3xMFXpmchmXE
         VYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FeTSJufRB2Kaeo4M1FkwnRluTUaoprG0uPauuvIMYYg=;
        b=G7ubX7rwFpDRr/7LWXzSOlSAGfCnjnyK/D6Tw4EXHoyXilSuL755H0qLd7YKJmUVsl
         Fl23ljbuOm+iJv8uRElO4t+Vj4psaSYIF1ncNAOtPgku0JLwoM2aOfipt43GQmXgG8pB
         opDOyDODsb/qySc9hSx1eYGDKUEghIswd6/4k/iB7KbPEeXN5oiSa951yBCMNok6Cv7E
         BPJHbqtGH/hpAtwOi73Ne5Dmlx+53n0lS6oPjM3HUnAvithAx1vcqJUpW1GU7CO2RSiN
         wspdzvUSFDu6L0JtcL2IcKA4LbpTYfdxh4cgVB6VeN279skGd3tUACwBLHPHgxm6l1Gy
         vRaw==
X-Gm-Message-State: APjAAAXIE9XkuiRIv2dzga5MECZqFn1Sa9mxXZUsOfFPzOsWh6aRUcRQ
        Tac2Yain0F+U5M4/EP5eS1lg2ELtdDjVoj+Bo/0yGA==
X-Google-Smtp-Source: APXvYqy/Yqv0R+IBFwWKTexF2BTDj2X6vc1JzF7MLA8k3cigc4YssdVdq9qm7evrHRMOfU5GOvYfkZY0jcj7Lliz7Mc=
X-Received: by 2002:a62:a113:: with SMTP id b19mr14205403pff.227.1551987559933;
 Thu, 07 Mar 2019 11:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <20190307091514.2489338-2-arnd@arndb.de>
In-Reply-To: <20190307091514.2489338-2-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 11:39:08 -0800
Message-ID: <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Mikael Pettersson <mikpe@it.uu.se>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 1:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Passing registers containing zero as both the address (NULL pointer)
> and data into cmpxchg_futex_value_locked() leads clang to assign
> the same register for both inputs on ARM, which triggers a warning
> explaining that this instruction has unpredictable behavior on ARMv5.
>
> /tmp/futex-7e740e.s: Assembler messages:
> /tmp/futex-7e740e.s:12713: Warning: source register same as write-back base
>
> This patch was suggested by Mikael Pettersson back in 2011 (!) with gcc-4.4,
> as Mikael wrote:
>  "One way of fixing this is to make uaddr an input/output register, since
>  "that prevents it from overlapping any other input or output."
>
> but then withdrawn as the warning was determined to be harmless, and it
> apparently never showed up again with later gcc versions.
>
> Now the same problem is back when compiling with clang, and we are trying
> to get clang to build the kernel without warnings, as gcc normally does.
>
> Cc: Mikael Pettersson <mikpe@it.uu.se>
> Cc: Mikael Pettersson <mikpelinux@gmail.com>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Link: https://lore.kernel.org/linux-arm-kernel/20009.45690.158286.161591@pilspetsen.it.uu.se/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/include/asm/futex.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
> index 0a46676b4245..79790912974e 100644
> --- a/arch/arm/include/asm/futex.h
> +++ b/arch/arm/include/asm/futex.h
> @@ -110,13 +110,13 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>         preempt_disable();
>         __ua_flags = uaccess_save_and_enable();
>         __asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
> -       "1:     " TUSER(ldr) "  %1, [%4]\n"
> -       "       teq     %1, %2\n"
> +       "1:     " TUSER(ldr) "  %1, [%2]\n"
> +       "       teq     %1, %3\n"
>         "       it      eq      @ explicit IT needed for the 2b label\n"
> -       "2:     " TUSER(streq) "        %3, [%4]\n"
> +       "2:     " TUSER(streq) "        %4, [%2]\n"
>         __futex_atomic_ex_table("%5")
> -       : "+r" (ret), "=&r" (val)
> -       : "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
> +       : "+&r" (ret), "=&r" (val), "+&r" (uaddr)
> +       : "r" (oldval), "r" (newval), "Ir" (-EFAULT)
>         : "cc", "memory");
>         uaccess_restore(__ua_flags);

Underspecification of constraints to extended inline assembly is a
common issue exposed by other compilers (and possibly but in-effect
infrequently compiler upgrades).
So the reordering of the constraints means the in the assembly (notes
for other reviewers):
%2 -> %3
%3 -> %4
%4 -> %2
Yep, looks good to me, thanks for finding this old patch and resending, Arnd!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I think it would be good to further credit Mikael with reported by and
suggested by tags, but not sure which email address is preferred?

-- 
Thanks,
~Nick Desaulniers
