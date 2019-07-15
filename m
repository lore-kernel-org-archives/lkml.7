Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68056C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE48206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Za/EnM8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbfGORYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:24:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36266 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731677AbfGORYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:24:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id l21so8035812pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuoYNxM5h1ZEPhER25qr5iln50lzVJav2rjE6dpCcQ4=;
        b=Za/EnM8eqdtjLue+0U3+kmxaKT9n/1aJEBMXNNGdzJcDlyCJ8lxRIPH7ZknsmloEcN
         jYCOua2QiM5MO63jtQKoBiJhODIc91YK5NdPnvm6DqbZm7gG3+uKOggHWvGcX6ovKeZV
         xx4bSc+FStFIWFrSD4AbpHzcfZWJ8s1TswAPIlpfoGMz8ErD1R4/Jmkxad7YCbPEUEkH
         dnSJXScId1wX3o1/MYToJQFODB0nUMKoDeAAtAof+GB/aEhj3NfXZkQQZl4Y4lJoLopq
         6mUXZhWiMqO5V/nza7c6p/hzNAeIKL6e5qFaVUvAEP4knxAcZSkprkyO282s/ez4NpEv
         qyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuoYNxM5h1ZEPhER25qr5iln50lzVJav2rjE6dpCcQ4=;
        b=pLWcigW3+b82jiKmiIWFNdEsijY5zv6XgXY0DpJAmGPe2q/isdcIsv3n7BETV64dyP
         2djjdA00Cnhbx7eMFzbtGZQ59SB8q69UnB+h0ppvZx9BHUFRCRy0jyDMcV6XFSjkLbV6
         tEFLDKxb03PQJF7dJD2AG7+05TqQ7SZQkliysIiB+bqyM5381rPVw4wW3cfxqeKWRoNw
         xelv1yYbw3YF0a8ZAxNuhB4efP707ugt+loQRI4gMt5tSq7+vuJLJJM0S4sPl4/0pgRy
         b/kXezdVCwTEr7Jk5ZvVG4CfhVqS73sf2ZLo3oHfxef5LFvJYtcMYR0whM36hP666cAC
         csAw==
X-Gm-Message-State: APjAAAVVYSKotLaR87fc9pVGbQ25HTJ/kq/32SNVVTXPDNos994akheh
        7iewBJGIlNw+QAwgLVAU3JL3EnZpPP2WtmleMOqWyA==
X-Google-Smtp-Source: APXvYqxh1wATVMvkRbc1YKRvHz4VxagIxPekxI/WQvU7LVyiBf5wKJ0Nt/oy+MV+v04tzDlesM1FGiM0DNO5Lc6BlR8=
X-Received: by 2002:a63:52:: with SMTP id 79mr27785478pga.381.1563211476053;
 Mon, 15 Jul 2019 10:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563150885.git.jpoimboe@redhat.com> <9f67aa11794e9eebe5a3249529d1ecf60abf370f.1563150885.git.jpoimboe@redhat.com>
In-Reply-To: <9f67aa11794e9eebe5a3249529d1ecf60abf370f.1563150885.git.jpoimboe@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 15 Jul 2019 10:24:24 -0700
Message-ID: <CAKwvOdmUX31KcvDpdzOkrO=Jw+FFQ8MuiQkVFFnNeG9n28k5Aw@mail.gmail.com>
Subject: Re: [PATCH 20/22] objtool: Fix seg fault on bad switch table entry
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 5:37 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> In one rare case, Clang generated the following code:
>
>  5ca:       83 e0 21                and    $0x21,%eax
>  5cd:       b9 04 00 00 00          mov    $0x4,%ecx
>  5d2:       ff 24 c5 00 00 00 00    jmpq   *0x0(,%rax,8)
>                     5d5: R_X86_64_32S       .rodata+0x38
>
> which uses the corresponding jump table relocations:
>
>   000000000038  000200000001 R_X86_64_64       0000000000000000 .text + 834
>   000000000040  000200000001 R_X86_64_64       0000000000000000 .text + 5d9
>   000000000048  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000050  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000058  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000060  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000068  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000070  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000078  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000080  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000088  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000090  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000098  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   0000000000a0  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   0000000000a8  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   0000000000b0  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   0000000000b8  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   0000000000c0  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   0000000000c8  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   0000000000d0  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   0000000000d8  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   0000000000e0  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   0000000000e8  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   0000000000f0  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   0000000000f8  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000100  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000108  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000110  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000118  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000120  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000128  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000130  000200000001 R_X86_64_64       0000000000000000 .text + b96
>   000000000138  000200000001 R_X86_64_64       0000000000000000 .text + 82f
>   000000000140  000200000001 R_X86_64_64       0000000000000000 .text + 828
>
> Since %eax was masked with 0x21, only the first two and the last two
> entries are possible.
>
> Objtool doesn't actually emulate all the code, so it isn't smart enough
> to know that all the middle entries aren't reachable.  They point to the
> NOP padding area after the end of the function, so objtool seg faulted
> when it tried to dereference a NULL insn->func.
>
> After this fix, objtool still gives an "unreachable" error because it
> stops reading the jump table when it encounters the bad addresses:
>
>   /home/jpoimboe/objtool-tests/adm1275.o: warning: objtool: adm1275_probe()+0x828: unreachable instruction
>
> While the above code is technically correct, it's very wasteful of
> memory -- it uses 34 jump table entries when only 4 are needed.  It's
> also not possible for objtool to validate this type of switch table
> because the unused entries point outside the function and objtool has no
> way of determining if that's intentional.  Hopefully the Clang folks can
> fix it.

So this came from
drivers/hwmon/pmbus/adm1275.c ?
Any special configuration?
-- 
Thanks,
~Nick Desaulniers
