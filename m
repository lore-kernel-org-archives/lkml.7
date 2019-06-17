Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4C6C31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4D2208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfFQT31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:29:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34418 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFQT31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:29:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id m29so12256201qtu.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 12:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xlNlelotM+Dvc+xUSx9X17ASwHKHoVnlctg4TDQCb8=;
        b=pnIKUK0yhUXApNPupv14FMaBkIH2OiOH6Sf3J5/ObemWPZtqBijS03f4MJgNGxY+uU
         PhJtz6FV0/CPcYo0Yz989d5/JA13jRL4Zl5D3ohpxPH6pJG1XIr342CzeEVKwMhbj9kT
         41KPSLxODNy8PDXnhqKeSesxdRJ5rqbbO0Jq2k1aB6SlG0LdsA/4O/UlXjmfS+jp7ODh
         YcN/1qBq/82nId3P6X1y9+E28RctV/19t4rKqzwMaz2OpoSimP6wjxxp8Mdlzmv2Xtk/
         c5fAYJm0AYrrJAWbFivZJ3vbr4dCYW5t7Z4dQAsyOoyyLYkR3QuZyDN0Cgl1/C6U4giC
         sXBA==
X-Gm-Message-State: APjAAAUuGgBlVANVGlYka7W7Sll3XIYusjpo2O1YNwTO9Pkn7eSEgJ2s
        nzGxbuJ4L/62e1TAuCl7juX6SMa/02FIjsncfEg=
X-Google-Smtp-Source: APXvYqzmfEEp6gZuCeDUa3GncclqO8Dliciq18czTA1lJjjPkfklni0CHo+I/ASPntOHr7eDK1ToeB1Yu+l+Zozbcl4=
X-Received: by 2002:ac8:3485:: with SMTP id w5mr18630643qtb.142.1560799765930;
 Mon, 17 Jun 2019 12:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190617121427.77565-1-arnd@arndb.de> <20190617141244.5x22nrylw7hodafp@pc636>
 <CAK8P3a3sjuyeQBUprGFGCXUSDAJN_+c+2z=pCR5J05rByBVByQ@mail.gmail.com>
 <CAK8P3a0pnEnzfMkCi7Nb97-nG4vnAj7fOepfOaW0OtywP8TLpw@mail.gmail.com> <20190617165730.5l7z47n3vg73q7mp@pc636>
In-Reply-To: <20190617165730.5l7z47n3vg73q7mp@pc636>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jun 2019 21:29:08 +0200
Message-ID: <CAK8P3a1Ab2MVVgSh4EW0Yef_BsxcRbkxarknMzV7tOA+s79qsA@mail.gmail.com>
Subject: Re: [BUG]: mm/vmalloc: uninitialized variable access in pcpu_get_vm_areas
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Penyaev <rpenyaev@suse.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 6:57 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index a9213fc3802d..5b7e50de008b 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -915,7 +915,8 @@ adjust_va_to_fit_type(struct vmap_area *va,
> >  {
> >         struct vmap_area *lva;
> >
> > -       if (type == FL_FIT_TYPE) {
> > +       switch (type) {
> > +       case FL_FIT_TYPE:
> >                 /*
> >                  * No need to split VA, it fully fits.
> >                  *
> > @@ -925,7 +926,8 @@ adjust_va_to_fit_type(struct vmap_area *va,
> >                  */
> >                 unlink_va(va, &free_vmap_area_root);
> >                 kmem_cache_free(vmap_area_cachep, va);
> > -       } else if (type == LE_FIT_TYPE) {
> > +               break;
> > +       case LE_FIT_TYPE:
> >                 /*
> >                  * Split left edge of fit VA.
> >                  *
> > @@ -934,7 +936,8 @@ adjust_va_to_fit_type(struct vmap_area *va,
> >                  * |-------|-------|
> >                  */
> >                 va->va_start += size;
> > -       } else if (type == RE_FIT_TYPE) {
> > +               break;
> > +       case RE_FIT_TYPE:
> >                 /*
> >                  * Split right edge of fit VA.
> >                  *
> > @@ -943,7 +946,8 @@ adjust_va_to_fit_type(struct vmap_area *va,
> >                  * |-------|-------|
> >                  */
> >                 va->va_end = nva_start_addr;
> > -       } else if (type == NE_FIT_TYPE) {
> > +               break;
> > +       case NE_FIT_TYPE:
> >                 /*
> >                  * Split no edge of fit VA.
> >                  *
> > @@ -980,7 +984,8 @@ adjust_va_to_fit_type(struct vmap_area *va,
> >                  * Shrink this VA to remaining size.
> >                  */
> >                 va->va_start = nva_start_addr + size;
> > -       } else {
> > +               break;
> > +       default:
> >                 return -1;
> >         }
> >
> To me it is not clear how it would solve the warning. It sounds like
> your GCC after this change is able to keep track of that variable
> probably because of less generated code. But i am not sure about
> other versions. For example i have:
>
> gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)
>
> and it totally OK, i.e. it does not emit any related warning.

To provide some background here, I'm doing randconfig tests, and
this warning might be one that only shows up with a specific combination
of options that add complexity to the build.

I do run into a lot -Wmaybe-uninitialized warnings, and most of the time
can figure out to change the code to be more readable by both
humans and compilers in a way that shuts up the warning. The
underlying algorithm in the compiler is NP-complete, so it can't
ever get it right 100%, but it is a valuable warning in general.

Using switch/case makes it easier for the compiler because it
seems to turn this into a single conditional instead of a set of
conditions. It also seems to be the much more common style
in the kernel.

> Another thing is that, if we add mode code there or change the function
> prototype, we might run into the same warning. Therefore i proposed that
> we just set the variable to NULL, i.e. Initialize it.

The problem with adding explicit NULL initializations is that this is
more likely to hide actual bugs if the code changes again, and the
compiler no longer notices the problem, so I try to avoid ever
initializing a variable to something that would cause a runtime
bug in place of a compile time warning later.

       Arnd
