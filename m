Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531A9C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2087F2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564324756;
	bh=lCfL0JdIrTUO801HegwwTrN18MqwJBgPDFYfRszjWoE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JnOv5L9GBzbmNiYQgH4CEz05i5G7Ej1Et+mJmlhRLSki22proINmFPSz61vYsPtUJ
	 Nqx9B6fog6zcXLek0FuBhXSmTBxNktR8bSzGr47hR1ixVZvySYlAy+HjZwlPCC9vGq
	 9oTG41ttqGuj9n401rLGXr6I08idZUjMJa3JCO8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfG1OjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 10:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfG1OjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 10:39:14 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8028216F4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564324754;
        bh=lCfL0JdIrTUO801HegwwTrN18MqwJBgPDFYfRszjWoE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TaYjbI4K7ngbG4enkfJjfrQB3On6MHzfmr269GOm/SbEF5G/BVv90hNv7O9XvlkL0
         8/36ve8U/05dvpK/zwSlPP8CAOwEiwaKr68mQk/daIrxSjZTC6DR1TnYAm99ntQToP
         faqObshG+GfmWD+wOGXGItJL3GF1K5Tzlc/ameTg=
Received: by mail-wm1-f48.google.com with SMTP id p74so51609274wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 07:39:13 -0700 (PDT)
X-Gm-Message-State: APjAAAWlszSwpjn8YqX1HvToGWt1Ufhj/dBaXUaIMjaSH6BEYpsiojZ+
        eLSlp96X+HHzjrIAXTRvKX3K/dIzjucpFnK7daOOnA==
X-Google-Smtp-Source: APXvYqwrT6VghjvoT5F4nguyGnG9FNdj3/nFT1Dlf8kgEsku6lgd0P68s/576YH0XZW8Wtns/8ehY32rDriRSC4PwiE=
X-Received: by 2002:a7b:c149:: with SMTP id z9mr98310289wmi.0.1564324752124;
 Sun, 28 Jul 2019 07:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190728131251.622415456@linutronix.de> <20190728131648.786513965@linutronix.de>
In-Reply-To: <20190728131648.786513965@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 28 Jul 2019 07:39:01 -0700
X-Gmail-Original-Message-ID: <CALCETrX2UA=XOyP0Npnk5R1ix-GTvms9ES3RG-gP6vijFBpB=Q@mail.gmail.com>
Message-ID: <CALCETrX2UA=XOyP0Npnk5R1ix-GTvms9ES3RG-gP6vijFBpB=Q@mail.gmail.com>
Subject: Re: [patch 3/5] lib/vdso/32: Provide legacy syscall fallbacks
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
> To address the regression which causes seccomp to deny applications the
> access to clock_gettime64() and clock_getres64() syscalls because they
> are not enabled in the existing filters.
>
> That trips over the fact that 32bit VDSOs use the new clock_gettime64() and
> clock_getres64() syscalls in the fallback path.
>
> Implement a __cvdso_clock_get*time32() variants which invokes the legacy
> 32bit syscalls when the architecture requests it.
>
> The conditional can go away once all architectures are converted.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
