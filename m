Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70F0C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAB42064C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564324653;
	bh=N9wq1E/HquH4VxKibyh0Xk1LhplvO32iq3CEBuqAVWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XLEqu++V/HpWrFz4JhyoJ2hhrWoQ9+UwMYKKfOxpNteqmjARbSAexCBFHC01np5Wa
	 jzE5NaYAqDzAhFt0WklBpDry+W79Tlt2wEheUjT/iCmueYCDxsxu1onXczI+Ofqo3x
	 MZ6KCXGcimlXUS3xYpgNw/DqvJHtHEucjuCSobpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfG1Ohc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 10:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfG1Ohc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 10:37:32 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECF20216B7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564324651;
        bh=N9wq1E/HquH4VxKibyh0Xk1LhplvO32iq3CEBuqAVWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AoM+LRLoFy1Q/8/GCIhERvnjrv03YUKqcjItxuvI3uQFdkZOwCyEXWVykGj4h/Oy0
         ItUDDEcgWU4K6lXW1GazAzjcBa8KtYRnz9MjO5TlttNemlLZuCsb+C2/ZyX3kxK4L0
         tO3iQ3I0HHJStcuEDcxsCMpPvzaprYZHbjgVu6Zo=
Received: by mail-wr1-f49.google.com with SMTP id z1so59047386wru.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 07:37:30 -0700 (PDT)
X-Gm-Message-State: APjAAAWAopDQNj0Iwz8BryRmLU5ni0mL5b1eNzouD6u4QrJ9tJn4VQzz
        HU/gdPvubsPuFmXZkdDUslSrYFOUZB5vTYOi6ue6/A==
X-Google-Smtp-Source: APXvYqxqjJp3XvQiEZhET9n8ZMGY72nI8z8fMmxWbnzKLjgNDVeJMtZj2llThVjXB90XfqsG/ghs0AyLAPj+2Fl15sc=
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr27171962wrm.265.1564324649417;
 Sun, 28 Jul 2019 07:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190728131251.622415456@linutronix.de> <20190728131648.695579736@linutronix.de>
In-Reply-To: <20190728131648.695579736@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 28 Jul 2019 07:37:18 -0700
X-Gmail-Original-Message-ID: <CALCETrWvxV9NnmFpdNiAHqf4Anz-Q4wdF0hTXwFg9q3g7cEKhw@mail.gmail.com>
Message-ID: <CALCETrWvxV9NnmFpdNiAHqf4Anz-Q4wdF0hTXwFg9q3g7cEKhw@mail.gmail.com>
Subject: Re: [patch 2/5] lib/vdso: Move fallback invocation to the callers
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 6:20 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> To allow syscall fallbacks using the legacy 32bit syscall for 32bit VDSO
> builds, move the fallback invocation out into the callers.
>
> Split the common code out of __cvdso_clock_gettime/getres() and invoke the
> syscall fallback in the 64bit and 32bit variants.
>
> Preparatory work for using legacy syscalls in 32bit VDSO. No functional
> change.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
