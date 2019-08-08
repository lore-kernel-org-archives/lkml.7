Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BC3C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCEF2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6OSZhcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404543AbfHHUOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:14:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42471 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389974AbfHHUOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:14:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so44694111pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 13:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0p3Ly8nHWKqpQa5LOcPd33JTDmAKsWV1WiLmHuKK/c=;
        b=O6OSZhcXBZgZyNdlY3s601J/EcxhsFbK3UKxJbI8Q1ZH0FannIN7EVr4dW9DOOTAlJ
         +xYvBUx+rlrd+yHDDR+bw570HAkKPGVIO7Q4GE8HhvOtce/kyIWwsFsmJChnRbaM6jkl
         tRUp230O99CEXKGfY5vZdH1K9leNz5fbDziAGrHBmVwqROY8mo+D5064GSUDCw0h0BvR
         eDLhGZQwASVBZpnnjsyQ6cZwizRK2ao3vyBm+oEj6w8wgZkwqn6kBjm5rT72qv9noeBI
         7vjn5PVeN4gpKEK24UIwsAFsJBTma3KMC5vLd6qSh2q0a9XMjqpyaPKEMvROGYPKl1Il
         kw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0p3Ly8nHWKqpQa5LOcPd33JTDmAKsWV1WiLmHuKK/c=;
        b=MU6mif4HBqrJd3JeGyFIQmAJSLFFslhvXhHIiatlNlcauJqViGv1SU+O6PRqZ9dHFQ
         VfZ/UVKaxVpfkMXIdlMSy50B+UEL3Hercjzrxwk6DoFajbgHZl+kP72bIkh4/XdTM7cm
         6BZncjO9acNxCeEYqek1tMybGm/dVL3p2hjnQWXMUbJTAtWDOsGee4UWZ/cl2mo3EviC
         kobxzwSQrEHJZ03V52QpN7IHxS7nSvN81k3d3PVJylOCFauxMUay3XafbOwDNWPLqTjy
         Avmp4vOANR41ejq0OFWyhNz1XQq8s8DybSinRqrB04yLx9duyrOjsC2XVLlFR38d/ItQ
         lGWQ==
X-Gm-Message-State: APjAAAWTVBjOWZmApX10KzQj1N1LSI8kjTp4bIi9eZTgb1wk0Kjt+A4W
        TVDM+XDmLzKZFys8Ls0YNzM56dF+jAVQJrs3OcT//g==
X-Google-Smtp-Source: APXvYqwMM3bTe1a8X7/bk1WvabwkVJjsrAV6LWJJGuK6xqAGZEZTlfxaSe6xG9A6Drpo6Z7vi0QRRwKq9aUYg1i5KRg=
X-Received: by 2002:a62:cec4:: with SMTP id y187mr17258563pfg.84.1565295259452;
 Thu, 08 Aug 2019 13:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <51a4155c5bc2ca847a9cbe85c1c11918bb193141.1564086017.git.jpoimboe@redhat.com>
 <alpine.DEB.2.21.1907252355150.1791@nanos.tec.linutronix.de>
 <156416793450.30723.5556760526480191131@skylake-alporthouse-com>
 <alpine.DEB.2.21.1907262116530.1791@nanos.tec.linutronix.de>
 <156416944205.21451.12269136304831943624@skylake-alporthouse-com>
 <CA+icZUXwBFS-6e+Qp4e3PhnRzEHvwdzWtS6OfVsgy85R5YNGOg@mail.gmail.com>
 <CA+icZUWA6e0Zsio6sthRUC=Ehb2-mw_9U76UnvwGc_tOnOqt7w@mail.gmail.com> <20190806125931.oqeqateyzqikusku@treble>
In-Reply-To: <20190806125931.oqeqateyzqikusku@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 8 Aug 2019 13:14:07 -0700
Message-ID: <CAKwvOd=wa-XPCpoLQoQJH8Me7S=fXLfog0XsiKyFZKu8ojW_UQ@mail.gmail.com>
Subject: Re: [PATCH] drm/i915: Remove redundant user_access_end() from
 __copy_from_user() error path
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 5:59 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Aug 05, 2019 at 09:29:53PM +0200, Sedat Dilek wrote:
> > On Wed, Jul 31, 2019 at 2:25 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Fri, Jul 26, 2019 at 9:30 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > > >
> > > > Quoting Thomas Gleixner (2019-07-26 20:18:32)
> > > > > On Fri, 26 Jul 2019, Chris Wilson wrote:
> > > > > > Quoting Thomas Gleixner (2019-07-25 22:55:45)
> > > > > > > On Thu, 25 Jul 2019, Josh Poimboeuf wrote:
> > > > > > >
> > > > > > > > Objtool reports:
> > > > > > > >
> > > > > > > >   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x36: redundant UACCESS disable
> > > > > > > >
> > > > > > > > __copy_from_user() already does both STAC and CLAC, so the
> > > > > > > > user_access_end() in its error path adds an extra unnecessary CLAC.
> > > > > > > >
> > > > > > > > Fixes: 0b2c8f8b6b0c ("i915: fix missing user_access_end() in page fault exception case")
> > > > > > > > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > > > > > > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > > > > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > > > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > > > > > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > > > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/617
> > > > > > > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > > > >
> > > > > > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > > > > >
> > > > > > Which tree do you plan to apply it to? I can put in drm-intel, and with
> > > > > > the fixes tag it will percolate through to 5.3 and beyond, but if you
> > > > > > want to apply it directly to squash the build warnings, feel free.
> > > > >
> > > > > It would be nice to get it into 5.3. I can route it linuxwards if you give
> > > > > an Acked-by, but I'm happy to hand it to you :)
> > > >
> > > > Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
> > >
> > > Thomas did you take this through tip tree after Chris' ACK?
> > >
> >
> > Hi,
> >
> > Gentle ping...
> > Thomas and Chris: Will someone of you pick this up?
> > As "objtool: Improve UACCESS coverage" [1] went trough tip tree I
> > highly appreciate to do so with this one.
>
> I think Thomas has gone on holiday, so hopefully Chris can pick it up
> after all.

tglx just picked up 2 other patches of mine, bumping just in case he's
not picking up patches while on vacation. ;)
-- 
Thanks,
~Nick Desaulniers
