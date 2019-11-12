Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21924C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACFD206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573575394;
	bh=TRwPZGlH//bhlgDF+Wk5v6jKkDq4rxd0924VenCbDbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xA6Vkw9jNu9HRP4QXQGtAOVjLUFURf7wWbwHQZLGpUA4/30pNErvsdYClV9J4Adls
	 RLlxadXH5e+ibFkrhOS2rc+TX6NWJI/OL9P1IQ+yNcQLG3u9FNPedrm7IjPCtEmIyq
	 +T4CC7kMHrWcV/vpF7E3uhPpgAic7SF/IfRrzG5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKLQQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 11:16:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfKLQQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 11:16:32 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9476B21A49
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573575391;
        bh=TRwPZGlH//bhlgDF+Wk5v6jKkDq4rxd0924VenCbDbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y6WZxlIOMJWiuGYviWMAoGZuPgnos5KR1qJYnzL80B9ilyST4TVy7IF8IdS6wPe8q
         6trP8hkm1BMPgmzDI3Ukmz2HJ903bGFX4GyJ3xmLyFt/N6wIGDqLH9LSssqGO5yzVY
         B3SF56jlFHrfzQhhGtDZRldM3Y6xHEED8wRP2K80=
Received: by mail-wm1-f52.google.com with SMTP id b11so3836210wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 08:16:31 -0800 (PST)
X-Gm-Message-State: APjAAAUprDNR8zkoSoy05uvIQ2i5B5jKLRs9uhcLILIwHHxpYcavwp8C
        6fmlz8WZQXzGf1nLcIXKzpADjHyVwdqtNenToZIlpA==
X-Google-Smtp-Source: APXvYqzpJQ9PY/KWxX9UgBBVfbsbmsttUlmKmnDSyvt/OQnhgEqdCpruY+qVAoqbmOeB89wLZwhIyMuY7J+LPnt8lhs=
X-Received: by 2002:a7b:c1ca:: with SMTP id a10mr5089137wmj.161.1573575390074;
 Tue, 12 Nov 2019 08:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20191111220314.519933535@linutronix.de> <20191111223052.400498664@linutronix.de>
In-Reply-To: <20191111223052.400498664@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Nov 2019 08:16:19 -0800
X-Gmail-Original-Message-ID: <CALCETrU1i4_N8M0o=8hxxPFYisLsxpmDqM-GTsymORp9UeZYSg@mail.gmail.com>
Message-ID: <CALCETrU1i4_N8M0o=8hxxPFYisLsxpmDqM-GTsymORp9UeZYSg@mail.gmail.com>
Subject: Re: [patch V2 09/16] x86/ioperm: Move TSS bitmap update to exit to
 user work
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 2:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> There is no point to update the TSS bitmap for tasks which use I/O bitmaps
> on every context switch. It's enough to update it right before exiting to
> user space.
>

+
> +static inline void switch_to_bitmap(unsigned long tifp)
> +{
> +       /*
> +        * Invalidate I/O bitmap if the previous task used it. If the next
> +        * task has an I/O bitmap it will handle it on exit to user mode.
> +        */
> +       if (tifp & _TIF_IO_BITMAP)
> +               tss_invalidate_io_bitmap(this_cpu_ptr(&cpu_tss_rw));
> +}

Shouldn't you be invalidating the io bitmap if the *next* task doesn't
use?  Or is the rule that, when a non-io-bitmap-using task is running,
even in kernel mode, the io bitmap is always invalid.

As it stands, you need exit_thread() to invalidate the bitmap.  I
assume it does, but I can't easily see it in the middle of the series
like this.

IOW your code might be fine, but it could at least use some comments
in appropriate places (exit_to_usermode_loop()?) that we guarantee
that, if the bit is *clear*, then the TSS has the io bitmap marked
invalid.  And add an assertion under CONFIG_DEBUG_ENTRY.

Also, do you need to update EXIT_TO_USERMODE_LOOP_FLAGS?
