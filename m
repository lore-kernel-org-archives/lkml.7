Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B46C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6F82084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfCKKF5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:05:57 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34499 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfCKKF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:05:57 -0400
Received: by mail-ua1-f68.google.com with SMTP id a42so1309282uad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 03:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L2HMx5KKQEe8WC+5Qb89o+URrteomOOaMW5YBpl6/bQ=;
        b=Y5r3Zn4exBXRpPbZ+mISKoo6UqW1+mZYMT5VpSi7klZAnWPilzQ9VVHpyoGquIhJC/
         4yEnksu+dnqEUbDGKt9tShKc9zexP3v7dgKX+onafYFLHTMsByOzPz/nGPrMOOSjccFZ
         u/sbAdPJA8okb3hlFcIDbQTWeHdp5eTd58x2QMYbYhjTyG7AMVhFH7XElUr/v38/QCj5
         j9+TAqRpMIAt44aKg+ty2/NENFM8+CfV6eErWphj6qWf0qnZvGQwQC64jqBhXhLUYitX
         fjcaANBO8WH+fwujPPjbXt4pxhI4fqDrVmgJSBL5kQ4ChQqNtrA9AvRRZBvxm9Lascvm
         FX9Q==
X-Gm-Message-State: APjAAAUOJqRH+1xD3xQlFUjJKOj3MkcSb8IlxhTloZ1W45DqxgrTPqsz
        FLeZAFKtKY2kr/Mor8AEnAJCC0weR6hxIgw+Rvw=
X-Google-Smtp-Source: APXvYqy7p1jDX7uFCf78bWyFjDNGLqBCEIlNi8boxIY7bkP0TDx4GiQlfLelEhCy2wInqUzVn2hgTjGjwRXpFo70Y+A=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr16160492uao.20.1552298755936;
 Mon, 11 Mar 2019 03:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <201903042049.npxcZzps%fengguang.wu@intel.com> <CAMuHMdX365qmWiii=gQLADpW49EMkdDrVJDPWNBpAZuZM0WQFQ@mail.gmail.com>
 <alpine.LNX.2.21.1903051154200.135@nippy.intranet> <alpine.LNX.2.21.1903051357410.135@nippy.intranet>
 <CAMuHMdUuwudbk15GUPPxL+-Gt4zhhSomk-wMAHeTOkoaDOCUAA@mail.gmail.com>
 <alpine.LNX.2.21.1903051948290.147@nippy.intranet> <mvmh8chzo7j.fsf@linux-m68k.org>
 <alpine.LNX.2.21.1903071329140.513@nippy.intranet> <CAMuHMdVzLTO-yYJJ=HqVySX6gqes9cnyspungsB5maduzNt0RA@mail.gmail.com>
 <alpine.LNX.2.21.1903080838260.595@nippy.intranet> <CAMuHMdWr-Y7mfH3gFXfK0fWpEhhdoW9VUkOEwf0nFN8kfr4zrg@mail.gmail.com>
 <mvmo96hvin9.fsf@linux-m68k.org>
In-Reply-To: <mvmo96hvin9.fsf@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Mar 2019 11:05:44 +0100
Message-ID: <CAMuHMdU9gke1=5PfjpJWuUbSBQ=bPQjpEVD3+t3F3tHvh9szWg@mail.gmail.com>
Subject: Re: [m68k:master 1174/1174] arch/m68k/include/asm/string.h:72:25:
 warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7]
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Mon, Mar 11, 2019 at 10:56 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Mär 11 2019, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Mar 7, 2019 at 10:42 PM Finn Thain <fthain@telegraphics.com.au> wrote:
> >> No, the link fails because the compiler still emits some references to
> >> strlen().
> >
> > Despite -ffreestanding?!?
>
> *Because* of -ffreestanding.  Without that, strlen would be recognized
> and turned into __builtin_strlen.

Now I'm confused: if we have a static inline or #define for strlen(), why
would the compiler still emit references to the strlen() symbol?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
