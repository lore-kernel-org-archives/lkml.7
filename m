Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C8CC2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEF2206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 02:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577154262;
	bh=SPQ7Bj4a4eNp21OAcqYrY8SxuFJJaC2a6yGdIeeRS1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vQcrHJ+TTCtV52zWVe94xfmdw8v40olyNstB0/zXufdb5ZRYRVEKOmGm9kp2gxTSh
	 chqgJ1Er2nZaE7ixSlz6UuIuoKy23ZMy0EKZWYVRZTD8QajnVxn0/9E8z4EOhhf44B
	 YLTopSZ5pWjgN8YulWo0RXW+rvUtwHrLTm0It1Cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfLXCYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 21:24:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfLXCYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:24:21 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E588207FF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 02:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577154260;
        bh=SPQ7Bj4a4eNp21OAcqYrY8SxuFJJaC2a6yGdIeeRS1o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oPvK6VPzi1k2yyEjQny+BqytBOGY+Pvm5TAIa+d74eS8hvsJFnqaOLMcPbR1MVHcg
         TJAbv69cwFBjDUU1LcTUwFGC1sdBHfjcRbhYXPuD/8fDpRJfQhxnnenWDdYNTNMhtK
         WQtdttyNyw+EIZ8phdY7Uk7eLt21kAD5fLV0wvro=
Received: by mail-wr1-f43.google.com with SMTP id z7so18555085wrl.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 18:24:20 -0800 (PST)
X-Gm-Message-State: APjAAAW1JxiWQjJVAB3U9FfL7rLzxRMp3O//aV7Azd16IzNUzjgyvKmZ
        McUBvNqxSPbC3ZlVvWP5v0ngoTSxFyaKW68Ijk7kLg==
X-Google-Smtp-Source: APXvYqxjzD58lmej1/f4cJSP7HhlmKnh8jXfi6lwDjHJL4b+9GZQPe+XjiFw3YmwCo3ewdHy4fkwT46pqN+EiY2Rfws=
X-Received: by 2002:adf:f491:: with SMTP id l17mr32117348wro.149.1577154258620;
 Mon, 23 Dec 2019 18:24:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577111363.git.christophe.leroy@c-s.fr> <de073962c1a5911343e13c183fbbdef0fe95449e.1577111365.git.christophe.leroy@c-s.fr>
In-Reply-To: <de073962c1a5911343e13c183fbbdef0fe95449e.1577111365.git.christophe.leroy@c-s.fr>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Dec 2019 18:24:05 -0800
X-Gmail-Original-Message-ID: <CALCETrXWHk9J-pYm+eopMuW3x7Jr_LnzRjr94gq8g66xOO6SBg@mail.gmail.com>
Message-ID: <CALCETrXWHk9J-pYm+eopMuW3x7Jr_LnzRjr94gq8g66xOO6SBg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/10] lib: vdso: move call to fallback out of
 common code.
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 6:31 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> On powerpc, VDSO functions and syscalls cannot be implemented in C
> because the Linux kernel ABI requires that CR[SO] bit is set in case
> of error and cleared when no error.
>
> As this cannot be done in C, C VDSO functions and syscall'based
> fallback need a trampoline in ASM.
>
> By moving the fallback calls out of the common code, arches like
> powerpc can implement both the call to C VDSO and the fallback call
> in a single trampoline function.

Maybe the issue is that I'm not a powerpc person, but I don't
understand this.  The common vDSO code is in C.  Presumably this means
that you need an asm trampoline no matter what to call the C code.  Is
the improvement that, with this change, you can have the asm
trampoline do a single branch, so it's logically:

ret = [call the C code];
if (ret == 0) {
 set success bit;
} else {
 ret = fallback;
 if (ret == 0)
  set success bit;
else
  set failure bit;
}

return ret;

instead of:

ret = [call the C code, which includes the fallback];
if (ret == 0)
  set success bit;
else
  set failure bit;

It's not obvious to me that the former ought to be faster.

>
> The two advantages are:
> - No need play back and forth with CR[SO] and negative return value.
> - No stack frame is required in VDSO C functions for the fallbacks.

How is no stack frame required?  Do you mean that the presence of the
fallback causes worse code generation?  Can you improve the fallback
instead?
