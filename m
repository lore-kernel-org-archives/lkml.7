Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AEFC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD69206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 15:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v67e0bbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfGaPaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:30:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42145 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfGaPaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:30:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so20264697wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bcjRCxVJvUuH6o4mR9oi0ph2KHZ3JtuvHfGJLyd+Vxo=;
        b=v67e0bbhh5erh8euEd/f9MMmmgZjfkdw/uwHPjgds0C6BEQF5LAiI9ySbc9ASvhdzk
         xu97HRuYT40GWmeA14gf2NKzJeMVKbCrsCWqxK6JjagLoo9RaUc/yRXTQV8IbzCcLHo2
         Nmi466SNxFtYIpaoUjZaTEl5l5HoNqFRSWKCbYpY/OEiHzvU6H4shqmiP4Pf09jRl0R5
         OUsBzqIPxKM3pdRg2XxNU/5z8OXDPwvEDApjik/JWImhMrE6vJEeYhqFxTkyqQHobgta
         FSqgPmMx+iE9dRaMQlFPKS32soZUmckdCxJXylk86BVILfoU5mD5TeZCAyaemvcuOgE7
         9Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bcjRCxVJvUuH6o4mR9oi0ph2KHZ3JtuvHfGJLyd+Vxo=;
        b=DilQ5pVPWTXTVEp1g6Ct9886MI+StKfPZlskk2l1fGiaNosfkfwgiJlm3vEC/pRsie
         +QEIgKOcxaWKpB6RYNCo/xetYlDfDaax55Qtjgdbbm0YtWlV9izUfgSeiFBVzQz74m+c
         DhVRce21VjNz9KtYBdFLaMN2F3tUgW8sMjmvCLXpt8kP/ETCgwGgTSLugTgEm0TmouWA
         FAgbbjIFAEbI5RV5qT0mmYs7Pcr+HFhw8tUwYnLTiE0LU5Ays62ngs0Aw4j2ja4OAuYz
         PVXdKZw7mj2s7eC6Fop7bNJJjeYy79chKfIwWmJ1UaJ+zjokN8e4pAIQDW/UI5acqTcv
         RHrA==
X-Gm-Message-State: APjAAAVYZ6ce03YMbG7AZ+Nx1tw3Agb5lwchKYGmarbrALKpupsB+Atg
        xTTpUUQ8+TnsSEtT9zrE0zxVs8LYNOpaxdQnNv2EFQ==
X-Google-Smtp-Source: APXvYqx26M8uBW6aKSEXqRRb2REVY+ufeceS13bWV/b0Nzs7V+Sv7Kl/VooGympZLSKR/ZZOlBoEsDX3lG/P4bUkJdk=
X-Received: by 2002:a5d:518f:: with SMTP id k15mr76209607wrv.321.1564587023225;
 Wed, 31 Jul 2019 08:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190729094316.GN22106@shao2-debian> <538637ba-f4e3-0dfa-cb13-3aee51c659bd@redhat.com>
In-Reply-To: <538637ba-f4e3-0dfa-cb13-3aee51c659bd@redhat.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 31 Jul 2019 17:30:10 +0200
Message-ID: <CAG_fn=VBGE=YvkZX0C45qu29zqfvLMP10w_owj4vfFxPcK5iow@mail.gmail.com>
Subject: Re: [mm] 6471384af2: kernel_BUG_at_mm/slub.c
To:     Laura Abbott <labbott@redhat.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:39 AM Laura Abbott <labbott@redhat.com> wrote:
>
> On 7/29/19 5:43 AM, kernel test robot wrote:
> > FYI, we noticed the following commit (built with gcc-7):
> >
> > commit: 6471384af2a6530696fc0203bafe4de41a23c9ef ("mm: security: introd=
uce init_on_alloc=3D1 and init_on_free=3D1 boot options")
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux=
.git master
> >
> > in testcase: trinity
> > with following parameters:
> >
> >       runtime: 300s
> >
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> >
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2=
 -m 8G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
> >
> >
> > +------------------------------------------+------------+------------+
> > |                                          | ba5c5e4a5d | 6471384af2 |
> > +------------------------------------------+------------+------------+
> > | boot_successes                           | 8          | 0          |
> > | boot_failures                            | 2          | 15         |
> > | invoked_oom-killer:gfp_mask=3D0x           | 1          |            =
|
> > | Mem-Info                                 | 1          |            |
> > | kernel_BUG_at_security/keys/keyring.c    | 1          |            |
> > | invalid_opcode:#[##]                     | 1          | 15         |
> > | RIP:__key_link_begin                     | 1          |            |
> > | Kernel_panic-not_syncing:Fatal_exception | 1          | 15         |
> > | kernel_BUG_at_mm/slub.c                  | 0          | 15         |
> > | RIP:kfree                                | 0          | 15         |
> > +------------------------------------------+------------+------------+
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> >
> >
> > [    4.478342] kernel BUG at mm/slub.c:306!
> > [    4.482437] invalid opcode: 0000 [#1] PREEMPT PTI
> > [    4.485750] CPU: 0 PID: 0 Comm: swapper Not tainted 5.2.0-05754-g647=
1384a #4
> > [    4.490635] RIP: 0010:kfree+0x58a/0x5c0
> > [    4.493679] Code: 48 83 05 78 37 51 02 01 0f 0b 48 83 05 7e 37 51 02=
 01 48 83 05 7e 37 51 02 01 48 83 05 7e 37 51 02 01 48 83 05 d6 37 51 02 01=
 <0f> 0b 48 83 05 d4 37 51 02 01 48 83 05 d4 37 51 02 01 48 83 05 d4
> > [    4.506827] RSP: 0000:ffffffff82603d90 EFLAGS: 00010002
> > [    4.510475] RAX: ffff8c3976c04320 RBX: ffff8c3976c04300 RCX: 0000000=
000000000
> > [    4.515420] RDX: ffff8c3976c04300 RSI: 0000000000000000 RDI: ffff8c3=
976c04320
> > [    4.520331] RBP: ffffffff82603db8 R08: 0000000000000000 R09: 0000000=
000000000
> > [    4.525288] R10: ffff8c3976c04320 R11: ffffffff8289e1e0 R12: ffffd52=
cc8db0100
> > [    4.530180] R13: ffff8c3976c01a00 R14: ffffffff810f10d4 R15: ffff8c3=
976c04300
> > [    4.535079] FS:  0000000000000000(0000) GS:ffffffff8266b000(0000) kn=
lGS:0000000000000000
> > [    4.540628] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    4.544593] CR2: ffff8c397ffff000 CR3: 0000000125020000 CR4: 0000000=
0000406b0
> > [    4.549558] Call Trace:
> > [    4.551266]  apply_wqattrs_prepare+0x154/0x280
> > [    4.554357]  apply_workqueue_attrs_locked+0x4e/0xe0
> > [    4.557728]  apply_workqueue_attrs+0x36/0x60
> > [    4.560654]  alloc_workqueue+0x25a/0x6d0
> > [    4.563381]  ? kmem_cache_alloc_trace+0x1e3/0x500
> > [    4.566628]  ? __mutex_unlock_slowpath+0x44/0x3f0
> > [    4.569875]  workqueue_init_early+0x246/0x348
> > [    4.573025]  start_kernel+0x3c7/0x7ec
> > [    4.575558]  x86_64_start_reservations+0x40/0x49
> > [    4.578738]  x86_64_start_kernel+0xda/0xe4
> > [    4.581600]  secondary_startup_64+0xb6/0xc0
> > [    4.584473] Modules linked in:
> > [    4.586620] ---[ end trace f67eb9af4d8d492b ]---
>
> I think this is catching an edge case with the freelist walking code
> in slab_free_freelist_hook. If we're not doing a bulk free,
> getting the free pointer from the object is going to be bogus so
> there's a chance it could trigger the bug in set_freepointer even
> if we don't actually care about it since it's going to get
> overwritten when we actually free. It's probably more robust
> to make sure we're terminating it with NULL. Lightly tested:
I see, my understanding was that it's safe to write the value we've
previously read with get_freepointer().
But chances are that the random data from this pointer simply matches
the object pointer.

> diff --git a/mm/slub.c b/mm/slub.c
> index e6c030e47364..8834563cdb4b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1432,7 +1432,9 @@ static inline bool slab_free_freelist_hook(struct k=
mem_cache *s,
>         void *old_tail =3D *tail ? *tail : *head;
>         int rsize;
>
> -       if (slab_want_init_on_free(s))
> +       if (slab_want_init_on_free(s)) {
> +               void *p =3D NULL;
> +
>                 do {
>                         object =3D next;
>                         next =3D get_freepointer(s, object);
> @@ -1445,8 +1447,10 @@ static inline bool slab_free_freelist_hook(struct =
kmem_cache *s,
>                                                            : 0;
>                         memset((char *)object + s->inuse, 0,
>                                s->size - s->inuse - rsize);
> -                       set_freepointer(s, object, next);
> +                       set_freepointer(s, object, p);
> +                       p =3D object;
>                 } while (object !=3D old_tail);
> +       }
>
>   /*
>    * Compiler cannot detect this function can be removed if slab_free_hoo=
k()
>
This one looks good, care to send a patch? Otherwise I can do that for you.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
