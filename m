Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD9EC4360C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 01:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2B120862
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 01:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570411044;
	bh=8/ZZiv48vrsJuzb0/4x0hPP7Z2+G/ntRSc6VjUgj3dA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xTh6z0cBJ4ygYck0ecTD3Wv127sX2felLlHv3CDWmxtOURoM5kPZygiiwNYRYlB+A
	 rldRRqyVGZGRiYvevaFFw+N+X+O0/DoQpsVg7GR7CgKYN8xQ/lTgMZ1smPWVhEVjHZ
	 Z5LfEM1aVtIZwOvm668wIIXZ2XwGUFctOGxROV5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfJGBRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 21:17:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45026 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfJGBRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 21:17:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id q12so3076086lfc.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 18:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPEu43x9a4PkvKn0Oyshu4QOaWijlTG7bfT8Hr7fHfs=;
        b=f6Ncrhe7S7dXzO+O2ayfO34RS2WQe42zqTeE1J9e5gyPVQI7WmKX4jrNVerl3l/Jql
         KdRAZUJMD4rgRQmFIkC5TcRf0QJ+PyiPmL9JxsEADXqN8Qjfw2t5YT83/NWGujsIGsO0
         MVzA0b891YKEEXwYA+lM6t+Kg+idL/2VltwOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPEu43x9a4PkvKn0Oyshu4QOaWijlTG7bfT8Hr7fHfs=;
        b=S77STZA9pdm3gel6Ev7MTDrL4/aWmKO43JuiVzyh0Qe6p9vL2bfoA4y7QU88fkZzt6
         3iwO+KtHY+kt8kqTNM3vXBT5rMl01phq9UsT8llizMoXkRud/sSOPCkfV409kOIwEMpH
         FejMoRHi+ltZUQ8AmgvGuVALyiPCA1ERVwr0rYbv/pDqrGH8P8LG76kQXUKnnZYL4ltW
         APLQKHFFJtdQw1QsIPDGbtZ8lTss8RbjnI+bAQF73B3vkMqZ4M28CN90JHgnA/SNSxrD
         MgGN4/cIx/OgcyeRUxh2xuC7bRV5eNK36uZu7vofD8Yk1K5sUXgOZ7qQ5szfwuXiGrP5
         wVeA==
X-Gm-Message-State: APjAAAVVs8JgYyWY5WOyM3gw1TJ/xZXM0dnSJixsiZkJNv+WzdSMax3s
        6EZ03EzACPoGVQdnKwqXz1JTCdyLPjw=
X-Google-Smtp-Source: APXvYqwhntmd0keTbBZmII/w5+sOma1ZnuNSKLePN0lZ7ZoORKP8m/HXh1RzP8CZ1cfw5cKEOoHoZw==
X-Received: by 2002:a05:6512:25b:: with SMTP id b27mr15564032lfo.60.1570411039914;
        Sun, 06 Oct 2019 18:17:19 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id r75sm2412475lff.7.2019.10.06.18.17.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2019 18:17:18 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id q12so3076048lfc.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 18:17:18 -0700 (PDT)
X-Received: by 2002:a19:2489:: with SMTP id k131mr14719103lfk.52.1570411038329;
 Sun, 06 Oct 2019 18:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191006222046.GA18027@roeck-us.net> <CAHk-=wgrqwuZJmwbrjhjCFeSUu2i57unaGOnP4qZAmSyuGwMZA@mail.gmail.com>
 <CAHk-=wjRPerXedTDoBbJL=tHBpH+=sP6pX_9NfgWxpnmHC5RtQ@mail.gmail.com> <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
In-Reply-To: <5f06c138-d59a-d811-c886-9e73ce51924c@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Oct 2019 18:17:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
Message-ID: <CAHk-=whAQWEMADgxb_qAw=nEY4OnuDn6HU4UCSDMNT5ULKvg3g@mail.gmail.com>
Subject: Re: [PATCH] Convert filldir[64]() from __put_user() to unsafe_put_user()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 6, 2019 at 5:04 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> All my alpha, sparc64, and xtensa tests pass with the attached patch
> applied on top of v5.4-rc2. I didn't test any others.

Okay... I really wish my guess had been wrong.

Because fixing filldir64 isn't the problem. I can come up with
multiple ways to avoid the unaligned issues if that was the problem.

But it does look to me like the fundamental problem is that unaligned
__put_user() calls might just be broken on alpha (and likely sparc
too). Because that looks to be the only difference between the
__copy_to_user() approach and using unsafe_put_user() in a loop.

Now, I should have handled unaligned things differently in the first
place, and in that sense I think commit 9f79b78ef744 ("Convert
filldir[64]() from __put_user() to unsafe_put_user()") really is
non-optimal on architectures with alignment issues.

And I'll fix it.

But at the same time, the fact that "non-optimal" turns into "doesn't
work" is a fairly nasty issue.

> I'll (try to) send you some disassembly next.

Thanks, verified.

The "ra is at filldir64+0x64/0x320" is indeed right at the return
point of the "jsr verify_dirent_name".

But the problem isn't there - that's just left-over state. I'm pretty
sure that function worked fine, and returned.

The problem is that "pc is at 0x4" and the page fault that then
happens at that address as a result.

And that seems to be due to this:

 8c0:   00 00 29 2c     ldq_u   t0,0(s0)
 8c4:   07 00 89 2c     ldq_u   t3,7(s0)
 8c8:   03 04 e7 47     mov     t6,t2
 8cc:   c1 06 29 48     extql   t0,s0,t0
 8d0:   44 0f 89 48     extqh   t3,s0,t3
 8d4:   01 04 24 44     or      t0,t3,t0
 8d8:   00 00 22 b4     stq     t0,0(t1)

that's the "get_unaligned((type *)src)" (the first six instructions)
followed by the "unsafe_put_user()" done with a single "stq". That's
the guts of the unsafe_copy_loop() as part of
unsafe_copy_dirent_name()

And what I think happens is that it is writing to user memory that is

 (a) unaligned

 (b) not currently mapped in user space

so then the do_entUna() function tries to handle the unaligned trap,
but then it takes an exception while doing that (due to the unmapped
page), and then something in that nested exception mess causes it to
mess up badly and corrupt the register contents on stack, and it
returns with garbage in 'pc', and then you finally die with that

   Unable to handle kernel paging request at virtual address 0000000000000004
   pc is at 0x4

thing.

And yes, I'll fix that name copy loop in filldir to align the
destination first, *but* if I'm right, it means that something like
this should also likely cause issues:

  #define _GNU_SOURCE
  #include <unistd.h>
  #include <sys/mman.h>

  int main(int argc, char **argv)
  {
        void *mymap;
        uid_t *bad_ptr = (void *) 0x01;

        /* Create unpopulated memory area */
        mymap = mmap(NULL, 16384, PROT_READ | PROT_WRITE, MAP_PRIVATE
| MAP_ANONYMOUS, -1, 0);

        /* Unaligned uidpointer in that memory area */
        bad_ptr = mymap+1;

        /* Make the kernel do put_user() on it */
        return getresuid(bad_ptr, bad_ptr+1, bad_ptr+2);
  }

because that simple user mode program should cause that same "page
fault on unaligned put_user()" behavior as far as I can tell.

Mind humoring me and trying that on your alpha machine (or emulator,
or whatever)?

               Linus
