Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA692C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639302146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R5S4yBdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfCMW61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:58:27 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39615 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMW60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:58:26 -0400
Received: by mail-vs1-f67.google.com with SMTP id w14so2088300vso.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 15:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pw4Vuq3TzOLDE/NhyBJ4D931rldDgs2N1sir0Z7lN90=;
        b=R5S4yBdhd04EqoZz/cIf1yuuOss5j9AlEZBodoAKxgsceG1zk9W/hAvs4hI+7kuztr
         XCtMp6PzfPvvm+zEk+lh0GQoCoFH+B8mCITEdO3j3YBFyQYeflFnBeimcrRjJiBFmXkj
         9bvrYvKNnX/M1dk9biTc7iJLjZxls2k/uzrs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pw4Vuq3TzOLDE/NhyBJ4D931rldDgs2N1sir0Z7lN90=;
        b=udk4AMFJby3oIEZSANXOsviZQ8ETC3gskdsQRAHns2a00Y1Sk4YoEjODwvupxrs7QA
         liy3hpxd09QdQJHEHgxAht+JqdQqHNOnEBBSKRvggT8gdQp3rO3JzaWQqNXBky5KZZbp
         WdUgFx64o8exZQHwDkkHmeL/CKeX8lQ5hN9Y8GFDAeaEhfPXoO78Bo7Jz+NVNsOm8DkK
         m1XvBGkI+bX3EXyrj1fn7gLosvK3qaMFR1Fbe+4Tce/xDkO+qxe19kjZH65uBLxcTEBE
         JdAeDhjqS4xPn2c/I0kqLLo0YP1GCdVS2w47ipVOZT/IGMr2DJMcRx0pQ9C7vURFKXpW
         qjGg==
X-Gm-Message-State: APjAAAU59mcEytqFcjuLdzD2waXJ1vbQ+aB1a4OpztlVn5RYUs9+6B9A
        BURr2+dcdTcnKQ5QosjTMtrWwLlXIrU=
X-Google-Smtp-Source: APXvYqzcVfwbQwqUw6D4ITwq5xRUwLfWogVHdhtulZhyfrsOLj39hRfw0ES5jXnSOx2poaO/bHm9VA==
X-Received: by 2002:a67:cb19:: with SMTP id b25mr25040683vsl.145.1552517904455;
        Wed, 13 Mar 2019 15:58:24 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id w68sm6155589vkw.9.2019.03.13.15.58.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 15:58:23 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id u6so2085062vso.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 15:58:23 -0700 (PDT)
X-Received: by 2002:a67:ed0c:: with SMTP id l12mr6241086vsp.66.1552517902631;
 Wed, 13 Mar 2019 15:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190312173248.13490-1-alisaidi@amazon.com> <20190312173248.13490-3-alisaidi@amazon.com>
In-Reply-To: <20190312173248.13490-3-alisaidi@amazon.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 13 Mar 2019 15:58:10 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ5sj3emOT2QPxQkNQk0qbU6zEfu9=Omfhx_p0nCKPSjA@mail.gmail.com>
Message-ID: <CAGXu5jJ5sj3emOT2QPxQkNQk0qbU6zEfu9=Omfhx_p0nCKPSjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/mmap: handle worst-case heap randomization in mmap_base
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Anthony Liguori <aliguori@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:33 AM Ali Saidi <alisaidi@amazon.com> wrote:
>
> Increase mmap_base by the worst-case brk randomization so that
> the stack and heap remain apart.
>
> In Linux 4.13 a change was committed that special cased the kernel ELF
> loader when the loader is invoked directly (eab09532d400; binfmt_elf: use
> ELF_ET_DYN_BASE only for PIE). Generally, the loader isn=E2=80=99t invoke=
d
> directly and this issue is limited to cases where it is, (e.g to set a
> non-inheritable LD_LIBRARY_PATH, testing new versions of the loader). In
> those rare cases, the loader doesn't take into account the amount of brk
> randomization that will be applied by arch_randomize_brk(). This can
> lead to the stack and heap being arbitrarily close to each other.

In the case of using the loader directly, brk (so helpfully identified
as "[heap]") is allocated with the _loader_ not the binary. For
example, with ASLR entirely disabled, you can see this more clearly:

$ /bin/cat /proc/self/maps
555555554000-55555555c000 r-xp 00000000 fd:02 34603015
  /bin/cat
55555575b000-55555575c000 r--p 00007000 fd:02 34603015
  /bin/cat
55555575c000-55555575d000 rw-p 00008000 fd:02 34603015
  /bin/cat
55555575d000-55555577e000 rw-p 00000000 00:00 0                          [h=
eap]
...
7ffff7ff7000-7ffff7ffa000 r--p 00000000 00:00 0                          [v=
var]
7ffff7ffa000-7ffff7ffc000 r-xp 00000000 00:00 0                          [v=
dso]
7ffff7ffc000-7ffff7ffd000 r--p 00027000 fd:02 49287483
  /lib/x86_64-linux-gnu/ld-2.27.so
7ffff7ffd000-7ffff7ffe000 rw-p 00028000 fd:02 49287483
  /lib/x86_64-linux-gnu/ld-2.27.so
7ffff7ffe000-7ffff7fff000 rw-p 00000000 00:00 0
7ffffffde000-7ffffffff000 rw-p 00000000 00:00 0                          [s=
tack]

$ /lib/x86_64-linux-gnu/ld-2.27.so /bin/cat /proc/self/maps
...
7ffff7bcc000-7ffff7bd4000 r-xp 00000000 fd:02 34603015
  /bin/cat
7ffff7bd4000-7ffff7dd3000 ---p 00008000 fd:02 34603015
  /bin/cat
7ffff7dd3000-7ffff7dd4000 r--p 00007000 fd:02 34603015
  /bin/cat
7ffff7dd4000-7ffff7dd5000 rw-p 00008000 fd:02 34603015
  /bin/cat
7ffff7dd5000-7ffff7dfc000 r-xp 00000000 fd:02 49287483
  /lib/x86_64-linux-gnu/ld-2.27.so
7ffff7fb2000-7ffff7fd6000 rw-p 00000000 00:00 0
7ffff7ff7000-7ffff7ffa000 r--p 00000000 00:00 0                          [v=
var]
7ffff7ffa000-7ffff7ffc000 r-xp 00000000 00:00 0                          [v=
dso]
7ffff7ffc000-7ffff7ffd000 r--p 00027000 fd:02 49287483
  /lib/x86_64-linux-gnu/ld-2.27.so
7ffff7ffd000-7ffff7ffe000 rw-p 00028000 fd:02 49287483
  /lib/x86_64-linux-gnu/ld-2.27.so
7ffff7ffe000-7ffff8020000 rw-p 00000000 00:00 0                          [h=
eap]
7ffffffde000-7ffffffff000 rw-p 00000000 00:00 0                          [s=
tack]

So I think changing this globally isn't the right solution (normally
brk is between text and mmap). Adjusting the mmap base padding means
we lose even more memory space. Perhaps it would be better if brk
allocation would be placed before the mmap region (i.e. use
ELF_ET_DYN_BASE). This seems to work for me:

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 7d09d125f148..cdaa33f4a3ef 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1131,6 +1131,15 @@ static int load_elf_binary(struct linux_binprm *bprm=
)
        current->mm->end_data =3D end_data;
        current->mm->start_stack =3D bprm->p;

+       /*
+        * When executing a loader directly (ET_DYN without Interp), move
+        * the brk area out of the mmap region (since it grows up, and may
+        * collide early with the stack growing down), and into the unused
+        * ELF_ET_DYN_BASE region.
+        */
+       if (!elf_interpreter)
+               current->mm->brk =3D current->mm->start_brk =3D ELF_ET_DYN_=
BASE;
+
        if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
                current->mm->brk =3D current->mm->start_brk =3D
                        arch_randomize_brk(current->mm);

$ /lib/x86_64-linux-gnu/ld-2.27.so /bin/cat /proc/self/maps
555556de3000-555556e04000 rw-p 00000000 00:00 0                          [h=
eap]
7f8467da9000-7f8467f90000 r-xp 00000000 fd:01 399295
  /lib/x86_64-linux-gnu/libc-2.27.so
...
7f846819a000-7f84681a2000 r-xp 00000000 fd:01 263229
  /bin/cat
...
7f84685cb000-7f84685cc000 rw-p 00028000 fd:01 399286
  /lib/x86_64-linux-gnu/ld-2.27.so
7f84685cc000-7f84685cd000 rw-p 00000000 00:00 0
7ffce68f8000-7ffce6919000 rw-p 00000000 00:00 0                          [s=
tack]
7ffce69f0000-7ffce69f3000 r--p 00000000 00:00 0                          [v=
var]
7ffce69f3000-7ffce69f4000 r-xp 00000000 00:00 0                          [v=
dso]

Does anyone see problems with this? (Note that ET_EXEC base is
0x400000, so no collision there...)

--=20
Kees Cook
