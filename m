Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E33C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A430520840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQY8GeKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCGSMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:12:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35459 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCGSMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:12:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id e17so11891508pgd.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TohO5bCy2C29bwYKDAneAX4fhE431b/r0k7Uv6KFvI=;
        b=hQY8GeKS27ims/24PG1dVIM5DwOHzj1rKCjQIIkdtPFwnmpOGzgq7gdHMa8Q30rqmQ
         kJ2DMpLIaHg4gm7fkXpoFwuYKw+qvrrxtbYN38L2/UsiC+EemDaQCSFVeb92LxhS+Fyz
         KH5+iJyLEr3LYKtedD/y850rNdP8+PajlYJRQv4vZeI7a6XdIH0knI//OTEdITM4CQ0o
         2LhETDOVpB9j2/4nqzoLkRZAaEzkimaWQ2dLSV1OYuzsuL753Qin7JxWyKVx+oh91GiA
         EdO1/iIvkFNg68OL/vayGO87/upH8/TddAL6P0F/4vmVNPtYHqFYujf2PPi1qUFbdNkS
         TOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TohO5bCy2C29bwYKDAneAX4fhE431b/r0k7Uv6KFvI=;
        b=QYJuDmPRcPfXT4NsqqZD7bnDq/AaGO0/twtt/5mExco3v9QjDX2O3LMOjL4BUFq83B
         uaS4um6+2U0mmbuse9ZBH1d2mqkaaLenKsezdjiohuS8iZh2yyZ2AHvBVWzKwc3xip1e
         dQ8hG/VTWJqPaXFWupO3NdAOzdsRhreOTdUdHap5Hp8Wk40W2JAhDzDZwmY21nfStes3
         b1RVF7Cu6exWC+1ntxQfksXaiMdxa+4Oa5bSDwwswaJIAKnLH/aiaqOJDgNi68joZlKN
         xgO6F4sAYiD0fUTKjaF7CoqeMlhEXgdNKmuujCbEdnr5tqQTWLQ2IPUw9+q2kRGwn76v
         hLPg==
X-Gm-Message-State: APjAAAU6RNTVoyL6f6Er2aW0Are1VKrrEiPnP5LAOz5j3PYA7xLrlJa+
        OzChJ3K8x/sh1lGRFtHMEhtzOTpSs+UtwdfxUOLCIQ==
X-Google-Smtp-Source: APXvYqzgJJNazaW4fD76z/4SMP6RukboSz7kPAp6sjBergz5m2azVxEM6fE4SVdDToyiMxwFIPuoUt3v5jmOIfPDhSM=
X-Received: by 2002:a62:f20d:: with SMTP id m13mr13878818pfh.174.1551982342542;
 Thu, 07 Mar 2019 10:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de>
In-Reply-To: <20190307091514.2489338-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 10:12:11 -0800
Message-ID: <CAKwvOdkr+a1F1VJ=Gc44WfrBnhnDNkvgQ=byz+N++xQ6VPdc2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 1:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 32-bit ARM, I got a link failure in futex_init() when building
> with clang in some random configurations:
>
> kernel/futex.o:(.text.fixup+0x5c): relocation truncated to fit: R_ARM_JUMP24 against `.init.text'

Do we know what function from the fixup text section is calling
futex_detect_cmpxchg?  I'm curious if this is maybe another case of
-Wsection where some function may be in the wrong section?

>
> As far as I can tell, the problem is that a branch is over 16MB
> apart in those configurations, but only if it branches back to
> the init text.
>
> Marking the futex_detect_cmpxchg() function as noinline and
> not __init avoids the problem for me.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/futex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/futex.c b/kernel/futex.c
> index c3b73b0311bc..dda77ed9f445 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -3849,7 +3849,7 @@ SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
>  }
>  #endif /* CONFIG_COMPAT_32BIT_TIME */
>
> -static void __init futex_detect_cmpxchg(void)
> +static noinline void futex_detect_cmpxchg(void)
>  {
>  #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
>         u32 curval;
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
