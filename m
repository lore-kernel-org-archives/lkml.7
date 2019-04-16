Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693A4C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3907A20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y9JbqmUu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDPDqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:46:50 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44693 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfDPDqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:46:49 -0400
Received: by mail-vs1-f66.google.com with SMTP id j184so10727515vsd.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 20:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Mao5pi/l5fkS95i8k2loMOQbxnEWUPdMW2dYCHzPPNc=;
        b=Y9JbqmUuZYhmwejg72OKQemF1qTmivtUBhTwIVZIsivP19X961t2DQLLTuDx8zBpRj
         LBBMuCLJYIZmr4iwD/uNfRlR8v/Cn1mvJA5KrMKGh+gP308LYHNK1tc46ytNCNgGpFXo
         feKJXK5CDN2zeNP2+QI7XisrFMEGxnN39GN2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Mao5pi/l5fkS95i8k2loMOQbxnEWUPdMW2dYCHzPPNc=;
        b=ZCPIgpNZduQAvljGiWm/nsHHqM8ANu8CHONRSI1O/mjsCY5sa7U9vBCs/tpklCZEUc
         ObR8Zw+PZx+M24OE5gT5pPr4fx2bUlZoOfKI+x4BwivwJGm4rfO5eHso+E7RdzAZUL8l
         DDDCbEuwbh5sgPsEnLrDIaLxUqL8xRmxO2nniVq4aO2O0PxxDlfDQXjxDrWZNQeZZnte
         eXqtCuA7/Y7cyVY+mRyMv4jybtgWREnm3VGMIBcg9wswopmw29qvFA1EF9bADLBuDCRb
         WvhYakSNr9kfaM/p9gAYmQeGa/U4kfW4qkp+1orwHsMVvDmtwh4e+THP9xPmspRqK7vm
         cTaw==
X-Gm-Message-State: APjAAAUW55FCI++/8K6wuL18f4K1r6mtgzVx4ga+eihcn7rjdoDVU3fv
        OsCEnXzkzwDvFfYOs2P6acqktcruaBg=
X-Google-Smtp-Source: APXvYqwvKMnHRqlw6YnW/3vZuwm7kUhsNXD51oI1VM0nTBYmHWkjAOjiM2zG97oLvJTv67s1Fj+cBg==
X-Received: by 2002:a67:f582:: with SMTP id i2mr44404028vso.33.1555386407671;
        Mon, 15 Apr 2019 20:46:47 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id m23sm86041309vsl.24.2019.04.15.20.46.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 20:46:46 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id s80so4124172vke.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 20:46:45 -0700 (PDT)
X-Received: by 2002:a1f:ab8d:: with SMTP id u135mr39524587vke.80.1555386405467;
 Mon, 15 Apr 2019 20:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181011225421.GA21093@beast> <20181012142902.GD2420@thunk.org> <CAGXu5jLqg5sf=oCZ_mB+ozTF=kKS7y4SNBKb96a6sBR07BprNg@mail.gmail.com>
In-Reply-To: <CAGXu5jLqg5sf=oCZ_mB+ozTF=kKS7y4SNBKb96a6sBR07BprNg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Apr 2019 22:46:34 -0500
X-Gmail-Original-Message-ID: <CAGXu5jJwLSRM4y-SK2d600ha2-ui8ibaGQa_qws8kmP=Yu1+oA@mail.gmail.com>
Message-ID: <CAGXu5jJwLSRM4y-SK2d600ha2-ui8ibaGQa_qws8kmP=Yu1+oA@mail.gmail.com>
Subject: Re: [PATCH] random: Move rand_initialize() earlier
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Daniel Micay <danielmicay@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Tobin C. Harding" <me@tobin.cc>, Arnd Bergmann <arnd@arndb.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 9:45 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Oct 12, 2018 at 7:29 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > On Thu, Oct 11, 2018 at 03:54:21PM -0700, Kees Cook wrote:
> >> Right now rand_initialize() is run as an early_initcall(), but it only
> >> depends on timekeeping_init() (for mixing ktime_get_real() into the
> >> pools). However, the call to boot_init_stack_canary() for stack canary
> >> initialization runs earlier, which triggers a warning at boot:
> >>
> >> random: get_random_bytes called from start_kernel+0x357/0x548 with crng_init=0
> >>
> >> Instead, this moves rand_initialize() to after timekeeping_init(), and moves
> >> canary initialization here as well.
> >>
> >> Note that this warning may still remain for machines that do not have
> >> UEFI RNG support (which initializes the RNG pools durting setup_arch()),
> >> or for x86 machines without RDRAND (or booting without "random.trust=on"
> >> or CONFIG_RANDOM_TRUST_CPU=y).
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > This seems reasonable to me.  Were you hoping to get this in for -rc8?
> > It looks sane, and I don't see any _obvious_ unintended consequences
> > of such a change, but it's rather late in the development cycle, and
> > it isn't regression fix.
>
> Yeah, for sure. I didn't mean this for 4.19. I assumed -next, and
> likely further changes based on discussion, etc etc.

Hi Ted! Did this get lost? This has come up again, and I don't see it
having landed anywhere yet. Can you take this?

-- 
Kees Cook
