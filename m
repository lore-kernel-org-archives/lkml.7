Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA9DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A81B20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="feDSQEgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfDPXOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:14:15 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44873 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDPXOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:14:15 -0400
Received: by mail-ua1-f65.google.com with SMTP id p13so7288317uaa.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 16:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypsQMgePAKxZuEqECB22Fl32IQ1nGGqK4THufGdpBQE=;
        b=feDSQEgo8svBfuUX8OAUrGPZvDYyfdpDfNwAjaivYqfIx2kZ2VJnvzN7qOZZzw5bpK
         5TXRX9gHD4domVhVOtJbMAkuQXMY2nsh/cmoNQQ4f8m0lNfeqaGU22lG2bRKJys9O6Q0
         ddusRCxtziWyBdD81A5uVVyFUSSeWidgI9arw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypsQMgePAKxZuEqECB22Fl32IQ1nGGqK4THufGdpBQE=;
        b=GyPjhni5tKNTPXJwcjt9i9Xhiy/AFkIuP4dtzMmIVib0dZxWpBJZWPIkPPhkfl069S
         7/OyAy4j6fiiIcdC2KmHJ8SdsYJFLgvinP6wrhy8UBlits9Fwgar+gf4U2aftqCUb+Xm
         dzeY8lX4+ppPPKWN9GjdVapm61e1Q9Grb9d8jIlHA0YJ2Y1DWdsUNkL7VGr/XHNMBgub
         JIrX8X4BNuSv3n0jv5z25PZHSLajO7KoaFuktHPpL7oIT1Q04150ahCEloqKl8ECqAuO
         8mnLdFy0hFCmOJR6etHVsETeHuavtbR3fXnMXbc8UsQfpMwf3GxhxY1wxYrDWBb2wbjB
         d1Zg==
X-Gm-Message-State: APjAAAU92beMmZ7SD+nrMe0RAyFYb6ltyFSHWsa9OMXFubv/VHE6t9EV
        6QC5js9aGhtLMUaaTDvzIRNdTJZlEKA=
X-Google-Smtp-Source: APXvYqzedf2wfpJlGZTTHAdiM+QlTZaz63MvsJNk2mzhe5lSxTQxOlqZwq+w0WTdpH008NVRx0UD+Q==
X-Received: by 2002:ab0:340a:: with SMTP id z10mr35575924uap.10.1555456453876;
        Tue, 16 Apr 2019 16:14:13 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id m23sm91600588vsl.24.2019.04.16.16.14.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 16:14:13 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id s2so12550505vsi.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 16:14:12 -0700 (PDT)
X-Received: by 2002:a67:7e12:: with SMTP id z18mr23509937vsc.82.1555456452273;
 Tue, 16 Apr 2019 16:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190416042320.GA36924@beast> <20190416160407.0e398a086507b811d7e95bbf@linux-foundation.org>
In-Reply-To: <20190416160407.0e398a086507b811d7e95bbf@linux-foundation.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 16 Apr 2019 18:14:00 -0500
X-Gmail-Original-Message-ID: <CAGXu5j+z7craEPiDYRjgYo4JBEum965JC_xSajv8TyPM09eaXQ@mail.gmail.com>
Message-ID: <CAGXu5j+z7craEPiDYRjgYo4JBEum965JC_xSajv8TyPM09eaXQ@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Move brk out of mmap when doing direct loader exec
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 6:04 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 15 Apr 2019 21:23:20 -0700 Kees Cook <keescook@chromium.org> wrote:
>
> > Commit eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE"),
> > made changes in the rare case when the ELF loader was directly invoked
> > (e.g to set a non-inheritable LD_LIBRARY_PATH, testing new versions of
> > the loader), by moving into the mmap region to avoid both ET_EXEC and PIE
> > binaries. This had the effect of also moving the brk region into mmap,
> > which could lead to the stack and brk being arbitrarily close to each
> > other. An unlucky process wouldn't get its requested stack size and stack
> > allocations could end up scribbling on the heap.
> >
> > This is illustrated here. In the case of using the loader directly, brk
> > (so helpfully identified as "[heap]") is allocated with the _loader_
> > not the binary. For example, with ASLR entirely disabled, you can see
> > this more clearly:
> >
> > $ /bin/cat /proc/self/maps
> > 555555554000-55555555c000 r-xp 00000000 ... /bin/cat
> > 55555575b000-55555575c000 r--p 00007000 ... /bin/cat
> > 55555575c000-55555575d000 rw-p 00008000 ... /bin/cat
> > 55555575d000-55555577e000 rw-p 00000000 ... [heap]
> > ...
> > 7ffff7ff7000-7ffff7ffa000 r--p 00000000 ... [vvar]
> > 7ffff7ffa000-7ffff7ffc000 r-xp 00000000 ... [vdso]
> > 7ffff7ffc000-7ffff7ffd000 r--p 00027000 ... /lib/x86_64-linux-gnu/ld-2.27.so
> > 7ffff7ffd000-7ffff7ffe000 rw-p 00028000 ... /lib/x86_64-linux-gnu/ld-2.27.so
> > 7ffff7ffe000-7ffff7fff000 rw-p 00000000 ...
> > 7ffffffde000-7ffffffff000 rw-p 00000000 ... [stack]
> >
> > $ /lib/x86_64-linux-gnu/ld-2.27.so /bin/cat /proc/self/maps
> > ...
> > 7ffff7bcc000-7ffff7bd4000 r-xp 00000000 ... /bin/cat
> > 7ffff7bd4000-7ffff7dd3000 ---p 00008000 ... /bin/cat
> > 7ffff7dd3000-7ffff7dd4000 r--p 00007000 ... /bin/cat
> > 7ffff7dd4000-7ffff7dd5000 rw-p 00008000 ... /bin/cat
> > 7ffff7dd5000-7ffff7dfc000 r-xp 00000000 ... /lib/x86_64-linux-gnu/ld-2.27.so
> > 7ffff7fb2000-7ffff7fd6000 rw-p 00000000 ...
> > 7ffff7ff7000-7ffff7ffa000 r--p 00000000 ... [vvar]
> > 7ffff7ffa000-7ffff7ffc000 r-xp 00000000 ... [vdso]
> > 7ffff7ffc000-7ffff7ffd000 r--p 00027000 ... /lib/x86_64-linux-gnu/ld-2.27.so
> > 7ffff7ffd000-7ffff7ffe000 rw-p 00028000 ... /lib/x86_64-linux-gnu/ld-2.27.so
> > 7ffff7ffe000-7ffff8020000 rw-p 00000000 ... [heap]
> > 7ffffffde000-7ffffffff000 rw-p 00000000 ... [stack]
> >
> > The solution is to move brk out of mmap and into ELF_ET_DYN_BASE since
> > nothing is there in this direct loader case (and ET_EXEC still far
> > away at 0x400000). Anything that ran before should still work (i.e. the
> > ultimately-launched binary already had the brk very far from its text,
> > so this should be no different from a COMPAT_BRK standpoint). The only
> > risk I see here is that if someone started to suddenly depend on the
> > entire memory space above the mmap region being available when launching
> > binaries via a direct loader execs which seems highly unlikely, I'd hope:
> > this would mean a binary would _not_ work when execed normally.
> >
> > Reported-by: Ali Saidi <alisaidi@amazon.com>
> > Link: https://lkml.kernel.org/r/CAGXu5jJ5sj3emOT2QPxQkNQk0qbU6zEfu9=Omfhx_p0nCKPSjA@mail.gmail.com
> > Fixes: eab09532d400 ("binfmt_elf: use ELF_ET_DYN_BASE only for PIE")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> No cc:stable?

Probably it should be, yes. I think I'm just shy about that when
poking ELF mappings. :)

-- 
Kees Cook
