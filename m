Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39571C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F408120863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qL2sbyGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfCRQyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:54:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32880 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfCRQyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:54:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so11679046pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTTTDsmzZRxE0P4UD+1ikNPbtlS4Dyc6/3yBg27ixDQ=;
        b=qL2sbyGFEclrtQPUA6LVmMhwOgE9ZrDgMW6Yf0szQXcjCN8uVFclD6Agav2oG/HaIH
         tt+Y2mHDCoddFKSu8Zy4+3UpfZZ7SmbEpgE0cwANONzfIFjpTwwIM+e92N9XMSRRWHoH
         PxF+RlzsqmGVQHybjhaImaimN17+872PGPB3vCwmBpKws2yHzSmXHY74ILhBEtFUAPZC
         ZvI5cWjIE/Xp9Y+h7052jpM79vanjEebGQOinpddGY5fyw7tCnhdUPSnrMHlG9O0r3NS
         7j+QGp+4xtUxFT/lBj7jefQ9mZPAHUuw6v1QjZFT5Vjqdwgm4b+IedSWlUu5f+FbiQK2
         9n2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTTTDsmzZRxE0P4UD+1ikNPbtlS4Dyc6/3yBg27ixDQ=;
        b=fc8/TQSMpgD5E2GBX6lPgMmG5vZyw0wyLbXJXTGDvJrn3Ge+8LVwMs6vNVeYk+DIxq
         vCNjKRDQHm5AVjyOTVTtoGiEDGDqrM1Hz94fQk87wsWoHgb6mrASBPr8nJmzUuhbMZuu
         ITKVzv+e+oQXIyKh7InthlOZrsc/al0Yopft9EYFydAc44p1RP2pbSVwKoyEQFuFGkXK
         SkQlRTcF6nowERKzNa0zt+0lxwqp6UiDFhW6QttMab0Frp7rAhOedQshmMrh0H9RCwaw
         rO7KbTsz3mWUph10wbi/1k1jfTrwlXkgiX67UoPUhKi2tavrqFuRCLw4gbTPy9kRi4VA
         ha/A==
X-Gm-Message-State: APjAAAUuFxUj4cz930w2ExEi0wTFTkCylR2+6PkLz4yaYLKz2jUGVUXk
        Keue0KxLGTvpC8epMl3L+AFyZkjK+W5pyj+zCbwjrw==
X-Google-Smtp-Source: APXvYqwtoSENSqe0flkUh8DZSgYEqtIQ0XKdJGpbQGPZjtv967mBGLrNb/wGEHW2f3Co8+OtTDYgx1PZKLh949N1HIQ=
X-Received: by 2002:a17:902:d24:: with SMTP id 33mr13090976plu.246.1552928047514;
 Mon, 18 Mar 2019 09:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552679409.git.andreyknvl@google.com> <c4d65de9867cb3349af6800242da0de751260c6c.1552679409.git.andreyknvl@google.com>
 <96675b72-d325-0682-4864-b6a96f63f8fd@arm.com>
In-Reply-To: <96675b72-d325-0682-4864-b6a96f63f8fd@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 18 Mar 2019 17:53:56 +0100
Message-ID: <CAAeHK+wwpDX5pc2P++7noGU0b8qWWYVP5=O5Vr5Fqm6NRQJmFA@mail.gmail.com>
Subject: Re: [PATCH v11 09/14] kernel, arm64: untag user pointers in prctl_set_mm*
To:     Kevin Brodsky <kevin.brodsky@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 12:47 PM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>
> On 15/03/2019 19:51, Andrey Konovalov wrote:
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > prctl_set_mm() and prctl_set_mm_map() use provided user pointers for vma
> > lookups, which can only by done with untagged pointers.
> >
> > Untag user pointers in these functions.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >   kernel/sys.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index 12df0e5434b8..8e56d87cc6db 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -1993,6 +1993,18 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
> >       if (copy_from_user(&prctl_map, addr, sizeof(prctl_map)))
> >               return -EFAULT;
> >
> > +     prctl_map->start_code   = untagged_addr(prctl_map.start_code);
> > +     prctl_map->end_code     = untagged_addr(prctl_map.end_code);
> > +     prctl_map->start_data   = untagged_addr(prctl_map.start_data);
> > +     prctl_map->end_data     = untagged_addr(prctl_map.end_data);
> > +     prctl_map->start_brk    = untagged_addr(prctl_map.start_brk);
> > +     prctl_map->brk          = untagged_addr(prctl_map.brk);
> > +     prctl_map->start_stack  = untagged_addr(prctl_map.start_stack);
> > +     prctl_map->arg_start    = untagged_addr(prctl_map.arg_start);
> > +     prctl_map->arg_end      = untagged_addr(prctl_map.arg_end);
> > +     prctl_map->env_start    = untagged_addr(prctl_map.env_start);
> > +     prctl_map->env_end      = untagged_addr(prctl_map.env_end);
>
> As the buildbot suggests, those -> should be . instead :) You might want to check
> your local build with CONFIG_CHECKPOINT_RESTORE=y.

Oops :)

>
> > +
> >       error = validate_prctl_map(&prctl_map);
> >       if (error)
> >               return error;
> > @@ -2106,6 +2118,8 @@ static int prctl_set_mm(int opt, unsigned long addr,
> >                             opt != PR_SET_MM_MAP_SIZE)))
> >               return -EINVAL;
> >
> > +     addr = untagged_addr(addr);
>
> This is a bit too coarse, addr is indeed used for find_vma() later on, but it is also
> used to access memory, by prctl_set_mm_mmap() and prctl_set_auxv().

Yes, I wrote this patch before our Friday discussion and forgot about
it. I'll fix it in v12, thanks!

>
> Kevin
>
> > +
> >   #ifdef CONFIG_CHECKPOINT_RESTORE
> >       if (opt == PR_SET_MM_MAP || opt == PR_SET_MM_MAP_SIZE)
> >               return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
>
