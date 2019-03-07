Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDED2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33F720675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPn53MN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfCGSVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:21:08 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37138 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:21:07 -0500
Received: by mail-ed1-f67.google.com with SMTP id m12so14293295edv.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mv2sVwkvOpOsKziBy6PS3WwnrK94oVNASHk9Btsx/9s=;
        b=qPn53MN/I08THXX9Z7mQttZAfKk+9dtH6bef4Vze3DTxMvoLXn/nHPtxsqGRbGfy7O
         hk4aX40EX0xaxQjNOgGVoyPdR+Frl82BJE6MYzcKg7s8ewc2IExXpBg1N1EsQC2WiCEs
         VRiS71968smrR/Elm8kp9zti8LrgmP4t2jCGEI5CqhvyTBkfskcLinLwzPvRmDdtF1xx
         qa94PY3wTLC5T+0u8/z7kq+xIzlm+/PfpK9A8XeZCml/eOWuXm2g4AWWf8LpnWrkz5jo
         coo81x+Xo+cq57+RU0zowBRrKfjHmTpYricQ1z81N1XQVIa0xmvrlwPuMqfnAIXfhl06
         kACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mv2sVwkvOpOsKziBy6PS3WwnrK94oVNASHk9Btsx/9s=;
        b=bilywUfjDbWKWstnF27wGNcQYxA1yR25hGNT4eG5lUrnGy2c4CmBUOTbkpFVKICI0D
         DhvqDdmGTI09e/SZzmG2AKou4C9768/aCfEN31KKp8KNzyznKMUguDTU6N5sxedcq/Dj
         nQ8krb9rtWXDoqtvUW9P8naKYm/1CxRff/MVGepvnhuoDK4oFjthCORasjXdYzOdEMi/
         jyvF0OmHZZP+quBE+sHH+wuONXymYol4pdIxR3oAUS26P7/lb+zxEd+TAiob41wMoBsa
         K3YwD3pLc4U6UAeXuYIBtJbluLomBvmateuBzkIDsJ/0TWhEV59QHeOTaS2zx5pkmgR3
         9D/g==
X-Gm-Message-State: APjAAAUeA8aHk0cZfxyE5qE1yfCu29g1Yy6lyVlXKhuPPRNHapoXdk/w
        VghYDp6J02HinLUeH7wXtOA=
X-Google-Smtp-Source: APXvYqyimD9kskLoL1Il9oURYocIrsogOw2QUltLa7NSMTdMcQlwK4Wo31BJK/5bnzT1x2S868vIwA==
X-Received: by 2002:a50:b646:: with SMTP id c6mr29549509ede.149.1551982865969;
        Thu, 07 Mar 2019 10:21:05 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id g24sm1540943edc.67.2019.03.07.10.21.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 10:21:04 -0800 (PST)
Date:   Thu, 7 Mar 2019 11:21:02 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
Message-ID: <20190307182102.GA12466@archlinux-ryzen>
References: <20190307091514.2489338-1-arnd@arndb.de>
 <CAKwvOdkr+a1F1VJ=Gc44WfrBnhnDNkvgQ=byz+N++xQ6VPdc2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkr+a1F1VJ=Gc44WfrBnhnDNkvgQ=byz+N++xQ6VPdc2g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:12:11AM -0800, Nick Desaulniers wrote:
> On Thu, Mar 7, 2019 at 1:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On 32-bit ARM, I got a link failure in futex_init() when building
> > with clang in some random configurations:
> >
> > kernel/futex.o:(.text.fixup+0x5c): relocation truncated to fit: R_ARM_JUMP24 against `.init.text'
> 
> Do we know what function from the fixup text section is calling
> futex_detect_cmpxchg?  I'm curious if this is maybe another case of
> -Wsection where some function may be in the wrong section?
> 

Looks like this is the call stack:

futex_init ->
    futex_detect_cmpxchg ->
        cmpxchg_futex_value_locked ->
            futex_atomic_cmpxchg_inatomic

This is the same issue I reported: https://github.com/ClangBuiltLinux/linux/issues/325

Marking arm's futex_atomic_cmpxchg_inatomic as noinline also fixes this
so maybe that's it?

Cheers,
Nathan

> >
> > As far as I can tell, the problem is that a branch is over 16MB
> > apart in those configurations, but only if it branches back to
> > the init text.
> >
> > Marking the futex_detect_cmpxchg() function as noinline and
> > not __init avoids the problem for me.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  kernel/futex.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/futex.c b/kernel/futex.c
> > index c3b73b0311bc..dda77ed9f445 100644
> > --- a/kernel/futex.c
> > +++ b/kernel/futex.c
> > @@ -3849,7 +3849,7 @@ SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
> >  }
> >  #endif /* CONFIG_COMPAT_32BIT_TIME */
> >
> > -static void __init futex_detect_cmpxchg(void)
> > +static noinline void futex_detect_cmpxchg(void)
> >  {
> >  #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
> >         u32 curval;
> > --
> > 2.20.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
