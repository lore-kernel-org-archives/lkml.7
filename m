Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6244CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1CA206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1DQ6a/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKNUDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 15:03:41 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44506 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfKNUDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:03:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id c19so5959318otr.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 12:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=De12QG3/ymw5hWl2Jg59C4M8muYieV0byC9HL46vsws=;
        b=g1DQ6a/bKQJ9jh4ZAuZSeuP/bWPasJY5vEjr5vY8yu1VACJvXiIa2KGD+DTnEl377n
         XO+CTX5508u4CJzryz928jo7aThZU29BTcc6zIf5W6DriWRWfabGrKNKYQZF9k5tgV5B
         MfN7ICKtNmTKIzW8N4BdADuKYqE3M/+taapCZZaqJBP1Ztr5TruIYannvnO4X7Y8PaFB
         ymTc0P1y+TopIOd1kLB8gljSyo9A+FqNmJOZwv1lMifKrO6v4NS+H2nvlgHHhvbymIKb
         fUDLNqOgm8JYrzMnrGgqArKI8lHC7StjDrrlpCEIG1T5S0NRsRbPIZunjnouSLqqkxhh
         /gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=De12QG3/ymw5hWl2Jg59C4M8muYieV0byC9HL46vsws=;
        b=QmLsgm5uEpk1YYV6K7KsM7wFrz3wY5mBNSOn/ihkJqF/fbB93A/GZUUwhTA8OscW92
         xwuO6bCYAM7icBl1/b5lassupIiHvEYHkL4ZDIwfI0Lq5GLxk5eRxhVM/BQk9ekw8GXC
         4Q6nqmeUAKT7lRlNWBIsP7H9iggx7E5yYAeFha3V8MB2bG4LDsIqRTl/OHRjoFxNHrUI
         oE+cF48pzyGfA9kL/VmTABZdtcegCV9BntJ7tqmZEbTUrysgeacodBIFoLyU7amKPJaz
         tKldz0moBnUBgsphKNntBwwY/s80r6yexzHhbjdoBxGKaGdleA7WXLH+4oW8pkt9JwTF
         srWQ==
X-Gm-Message-State: APjAAAWKcmxF7YOfWZ3Xn+iRGn55RLbxNqPRP30DHcx5ZDg0U0L61nTV
        7EJA5z9MC89LwNfYrVUbtKedBi+0PDLKxnb/CNoG4w==
X-Google-Smtp-Source: APXvYqx5kQfnnBgIkpqgNKsOacMhcMEzjYRnt0jIh2ZBYenrMgPh2ga5nWxILU5BsdoFnDULXQqTHiTcAbfg3/YR48A=
X-Received: by 2002:a9d:4801:: with SMTP id c1mr8756763otf.32.1573761819399;
 Thu, 14 Nov 2019 12:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20191112211002.128278-1-jannh@google.com> <20191112211002.128278-2-jannh@google.com>
 <20191114174630.GF24045@linux.intel.com> <CALCETrVmaN4BgvUdsuTJ8vdkaN1JrAfBzs+W7aS2cxxDYkqn_Q@mail.gmail.com>
In-Reply-To: <CALCETrVmaN4BgvUdsuTJ8vdkaN1JrAfBzs+W7aS2cxxDYkqn_Q@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 14 Nov 2019 21:03:13 +0100
Message-ID: <CAG48ez3fzJ_GP42XEPvXEiUmBtEc1zVtXaGRMavr==sSgF772w@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/traps: Print non-canonical address on #GP
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 7:00 PM Andy Lutomirski <luto@kernel.org> wrote:
> On Thu, Nov 14, 2019 at 9:46 AM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> > On Tue, Nov 12, 2019 at 10:10:01PM +0100, Jann Horn wrote:
> > > A frequent cause of #GP exceptions are memory accesses to non-canonical
> > > addresses. Unlike #PF, #GP doesn't come with a fault address in CR2, so
> > > the kernel doesn't currently print the fault address for #GP.
> > > Luckily, we already have the necessary infrastructure for decoding X86
> > > instructions and computing the memory address that is being accessed;
> > > hook it up to the #GP handler so that we can figure out whether the #GP
> > > looks like it was caused by a non-canonical address, and if so, print
> > > that address.
[...]
> > > +     /*
> > > +      * If insn_get_addr_ref() failed or we got a canonical address in the
> > > +      * kernel half, bail out.
> > > +      */
> > > +     if ((addr_ref | __VIRTUAL_MASK) == ~0UL)
> > > +             return;
> > > +     /*
> > > +      * For the user half, check against TASK_SIZE_MAX; this way, if the
> > > +      * access crosses the canonical address boundary, we don't miss it.
> > > +      */
> > > +     if (addr_ref <= TASK_SIZE_MAX)
> >
> > Any objection to open coding the upper bound instead of using
> > TASK_SIZE_MASK to make the threshold more obvious?
> >
> > > +             return;
> > > +
> > > +     pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
> >
> > Printing the raw address will confuse users in the case where the access
> > straddles the lower canonical boundary.  Maybe combine this with open
> > coding the straddle case?  With a rough heuristic to hedge a bit for
> > instructions whose operand size isn't accurately reflected in opnd_bytes.
> >
> >         if (addr_ref > __VIRTUAL_MASK)
> >                 pr_alert("dereferencing non-canonical address 0x%016lx\n", addr_ref);
> >         else if ((addr_ref + insn->opnd_bytes - 1) > __VIRTUAL_MASK)
> >                 pr_alert("straddling non-canonical boundary 0x%016lx - 0x%016lx\n",
> >                          addr_ref, addr_ref + insn->opnd_bytes - 1);
> >         else if ((addr_ref + PAGE_SIZE - 1) > __VIRTUAL_MASK)
> >                 pr_alert("potentially straddling non-canonical boundary 0x%016lx - 0x%016lx\n",
> >                          addr_ref, addr_ref + PAGE_SIZE - 1);
>
> This is unnecessarily complicated, and I suspect that Jann had the
> right idea but just didn't quite explain it enough.  The secret here
> is that TASK_SIZE_MAX is a full page below the canonical boundary
> (thanks, Intel, for screwing up SYSRET), so, if we get #GP for an
> address above TASK_SIZE_MAX, then it's either a #GP for a different
> reason or it's a genuine non-canonical access.
>
> So I think that just a comment about this would be enough.

Ah, I didn't realize that insn->opnd_bytes exists. Since I already
have that available, I guess using that is cleaner than being clever
with TASK_SIZE_MAX.

> *However*, the printout should at least hedge a bit and say something
> like "probably dereferencing non-canonical address", since there are
> plenty of ways to get #GP with an operand that is nominally
> non-canonical but where the actual cause of #GP is different.

Ah, yeah, I'll change that.

> And I think this code should be skipped entirely if error_code != 0.

Makes sense. As Borislav suggested, I'll add some code to
do_general_protection() to instead print a hint about it being a
segment-related problem.
