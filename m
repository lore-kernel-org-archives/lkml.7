Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B00BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C257218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLio0A+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfC2TZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:25:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43583 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbfC2TZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:25:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id t81so2540533oig.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 12:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ai7XKZgRt/T3cY2YiqZQIBXBs886rmhRgPWUQtcZRmw=;
        b=TLio0A+INOKKREAsE1LDLQAHeBVetckhWH+5DWHTuyvRvW6Ck7KbM0gqkP9s5xt77k
         qd1LGFuk4AwyTM7y5iAAp/uGyUHpS7TsLvSHtTtXRb61Trplugz4S1LyWc1vIPYC5J2F
         CcJXj+Z6zh8+QGIj6FfhVuvdgG/AsfaJETfS9HJtu0qy2sHuEBqsdiY5pAVywoYAVFwj
         8qngIKOV2QX3W1AdcZugOaX86+RBey5nIbQq53geTzmOW321cme4a7PjnmXW4Zut7H3a
         l9tV0J7cY/rCKpcI+C6V4hR5DPKKxC+DCo1ihKibB5dR1uRZPHq4M0NnWOKSLtpm51Z9
         Dpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ai7XKZgRt/T3cY2YiqZQIBXBs886rmhRgPWUQtcZRmw=;
        b=sUsuoOKsR+o4KfYJjVn9Q02dQ6MwAbk1dIdcc5eueeDf9uQyLBO3IRvq3fmSjhC2MT
         Cwk/GkfzNp3pG1oNR4KX8TBFOi8UrI8Nv8hTIijpVnpKtXMVcCWabA4/e0T3hAk2vmKN
         bjSG8z/m1GDe6nX/brD0ENfMqgE0IHWLgHOU2smxaKfslbUcJ97eILuKE71523nm6HX2
         2rzAinDoEdoteQVA4QNLXdXfXotH9RDA6v5PZu7SpblKvbSH6TNSskGUIGPVAR8noYo+
         5V7V4PHEYoNV7Tr7Nzl1cCC1JF5xmVgmsVp0z2WOEwuz9ApDuMQk6ga03yt83hB3WuzN
         hI2A==
X-Gm-Message-State: APjAAAXmdh4xnlOWffJ4Pash/sD4QEP1zdunvp+2hIUakMQksgaaTJ4v
        CjJ0R5tj9mRNZKySB8ZspsDBr7VHP1+tAzwfmkcQyA==
X-Google-Smtp-Source: APXvYqyzm9mO5oQz/F/r6d6IQOCj8U1UfVArb/USgGsXKBMrCHPbvU8jeSCkSNejuVspHRP5OfZTQMB8dd1wh2nuY/s=
X-Received: by 2002:aca:3806:: with SMTP id f6mr4628564oia.47.1553887551354;
 Fri, 29 Mar 2019 12:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190329163047.223508-1-jannh@google.com> <20190329163047.223508-3-jannh@google.com>
 <20190329180329.hl3t7a43sg3sshsf@ltop.local>
In-Reply-To: <20190329180329.hl3t7a43sg3sshsf@ltop.local>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 29 Mar 2019 20:25:25 +0100
Message-ID: <CAG48ez2+AeBuJ8i8RKL3THc1Nq1_vPyqLTXep8CvJgqVtGYCig@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] x86/fpu: Fix __user annotations
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+sparse list

On Fri, Mar 29, 2019 at 7:03 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Fri, Mar 29, 2019 at 05:30:46PM +0100, Jann Horn wrote:
> > In save_xstate_epilog(), use __user when type-casting userspace pointers.
> >
> > In setup_sigcontext() and x32_setup_rt_frame(), perform explicit __force
> > casts for converting userspace pointers to unsigned long; put_user_ex()
> > already performs a cast, but without __force, which is required by sparse
> > for conversions from userspace pointers to numbers.
>
> ...
>
> > diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> > index 08dfd4c1a4f9..e13cd972f9af 100644
> > --- a/arch/x86/kernel/signal.c
> > +++ b/arch/x86/kernel/signal.c
> > @@ -206,7 +206,7 @@ int setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
> >               put_user_ex(regs->ss, &sc->ss);
> >  #endif /* CONFIG_X86_32 */
> >
> > -             put_user_ex(fpstate, &sc->fpstate);
> > +             put_user_ex((unsigned long __force)fpstate, &sc->fpstate);
>
> The __force here is not needed and in fact meaningless as the address
> space annotations and checks only concern pointers. By casting a
> pointer to an unsigned long, all type info is lost anyway and thus
> no address-space checks are performed. It's a bit like such casts
> always have an implicit __force already included.

Oooh, it's a sparse bug.

So, without this, sparse complains:

  CHECK   arch/x86/kernel/signal.c
arch/x86/kernel/signal.c:209:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:209:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:209:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:209:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:572:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:572:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:572:17: warning: cast removes address space
'<asn:1>' of expression
arch/x86/kernel/signal.c:572:17: warning: cast removes address space
'<asn:1>' of expression

Apparently it's significant that the user pointer is stored as a
__u64, and __u64 is defined as unsigned long long.

By reducing this to a small testcase, I arrived at this:

sparse-master$ nl jannh-typeof-number.c
     1 #define __user __attribute__((noderef, address_space(1)))
     2 static unsigned long a(void __user *fpstate) {
     3   return (unsigned long long)fpstate;
     4 }
     5 static unsigned long b(void __user *fpstate) {
     6   return (unsigned long)fpstate;
     7 }
     8 static unsigned long c(void __user *fpstate) {
     9   return (unsigned int)fpstate;
    10 }
sparse-master$ ./sparse -Wall jannh-typeof-number.c
jannh-typeof-number.c:3:11: warning: cast removes address space
'<asn:1>' of expression
jannh-typeof-number.c:9:11: warning: cast removes address space
'<asn:1>' of expression
sparse-master$

I'll have a look at sparse and try to come up with a patch if I can
figure out what's going wrong.
