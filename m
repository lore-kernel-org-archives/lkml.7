Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067B7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9C62075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mprWfI9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfC1OOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:14:25 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40015 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfC1OOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:14:25 -0400
Received: by mail-vs1-f68.google.com with SMTP id f22so8499214vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Dk3hdTbij2Au0MH5knobY1JlxJKgLSyinoZspJf6oLc=;
        b=mprWfI9i8VxhHngvvbaXfhphznpR93dnJ0i0FqQDr1gC930tbL8FSi09J0xPNIX3q8
         M+LAx9sLYCDKoTViVqkX5XeTPBRaWAiO881yqbzaFUS1/bX2zP0WVLyV9CF9gOzX9ptO
         oHq+c+ST4A4z0LpG0RqeUxQ+YxOdEYqeSTBQTf6mxxgwN+fMMZplGMYzCUy0eR67YU8j
         NFyt0d5N9lx5YsydPl4II0oUN5NXRSxoNroaFqZDAJ75ciq3JQDKqmakRJE5hfMoW7Gb
         2RbIUv8Mv3yzn5ZRbTRnozgBbidk3VYaO1VKL3wUY1qYNwgzvrU/VmRaOBEcnyoxHUmc
         d82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Dk3hdTbij2Au0MH5knobY1JlxJKgLSyinoZspJf6oLc=;
        b=Ynjuq2+SlIO227Uaf82DlbwRGK1u8bah8VCJF0sNmqzDOtQ5JHsSmI2eQkPv81dO/u
         hXC3DSr1QXyfYb6OnQBa3WHQCZXF3Qdh4714LD1wcgBcZde3AzEKxz8dJuQxBO+g96DI
         M3iyLg9KDFI9DbJQQ2TNjPAYwbAECAzhVqZtTn7x7ZdmovWqeBQIDId/zP3XaWTrkkp0
         Bzuqz/YyUzXm9G5VgXsu8IOPSdLkj8m7CsKTWZQyb2XRvQihTWrIDMnPdwlMJCf8+A4J
         mv4uDskO7uQxalY5mdh/8Yh/hyaMMoRernwk7A+vw1SvwsyZOtznfowOa33tYACHBTuY
         xzwA==
X-Gm-Message-State: APjAAAVvxK6Z1eVqmek+15iDetxkMMPpzcNKfOnYSRrmRrMa2I0eqzIo
        TILcCu4R+Nk4AeA2jKb48WT3GSSvKwW7M9S0c0wgXg==
X-Google-Smtp-Source: APXvYqzWC4VV8CRURB3AW0H7U/CH8riMnAvYw1OkRh8G6uKnLfL7MSNfGQMrqbh+mBQg9q3yHejlSP7f2yDYoODi56g=
X-Received: by 2002:a67:eeda:: with SMTP id o26mr8610425vsp.209.1553782463767;
 Thu, 28 Mar 2019 07:14:23 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 28 Mar 2019 15:14:12 +0100
Message-ID: <CAG_fn=X9tpSW6jvJd_COk_RU8zvcr-cxSWuJ05qcV0LotTxEEQ@mail.gmail.com>
Subject: Potentially missing "memory" clobbers in bitops.h for x86
To:     Paul McKenney <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        James Y Knight <jyknight@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

arch/x86/include/asm/bitops.h defines clear_bit(nr, addr) for
non-constant |nr| values as follows:

void clear_bit(long nr, volatile unsigned long *addr) {
  asm volatile("lock; btr %1,%0"
    : "+m"(*(volatile long *)addr)
    : "Ir" (nr));
  }
(https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/bitops=
.h#L111)

According to the comments in the file, |nr| may be arbitrarily large.
However the assembly constraints only imply that the first unsigned
long value at |addr| is written to.
This may result in the compiler ignoring the effect of the asm directive.

Consider the following example (https://godbolt.org/z/naTmjn):

  #include <stdio.h>
  void clear_bit(long nr, volatile unsigned long *addr) {
    asm volatile("lock; btr %1,%0"
      : "+m"(*(volatile long *)addr)
      : "Ir" (nr));
  }

  unsigned long foo() {
    unsigned long addr[2] =3D {1, 2};
    clear_bit(65, addr);
    return addr[0] + addr[1];
  }

  int main() {
    printf("foo: %lu\n", foo());
  }

Depending on the optimization level, the program may print either 1
(for -O0 and -O1) or 3 (for -O2 and -O3).
This is because on higher optimization levels GCC assumes that addr[1]
is unchanged and directly propagates the constant to the result.

I suspect the definitions of clear_bit() and similar functions are
lacking the "memory" clobber.
But the whole file tends to be very picky about whether this clobber
needs to be applied in each case, so in the case of a performance
penalty we may need to consider alternative approaches to fixing this
code.


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
