Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9E6C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1295E217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nJTYjQTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfDWWVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:21:14 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:42438 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWWVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:21:14 -0400
Received: by mail-ua1-f65.google.com with SMTP id h4so5333194uaj.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=SGExNPGBBrkzpGZzoaniNu2zDVBYeAmUMhHbH0577z8=;
        b=nJTYjQTp5XmUNHWXJC+qFqKjq3CKvBfPwBT7DIWGKMG9iOPsBL12rW3APj3SUqz3fe
         r1HdOu4FpdWJa3SvmSFDl+tCodpqnsj7nVmf1mKu+t8k+OfQm2GA7QHuJfwnHBW8gO9W
         7fAzYIPAKivo794ncAEdeeI1XoIw3NaSyqXyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=SGExNPGBBrkzpGZzoaniNu2zDVBYeAmUMhHbH0577z8=;
        b=LDFo0h3yh0iEsmBADrQWJnz/sy/2S1ji2FGu/w6LJVz4eQwAIV0qy67y+bhdnEO7jO
         CBbNjyVNnWS5a3y53XevPd78c1TUzwEAYMgga0alsZ4lGc1n1NOUzC+dqmUqQ0QdN2tZ
         kIi65BjsZ6EdMGTPr3VZM7zfEnIUXY7XBU6I9X5/OCJ3RAStvd/qAnBx36DTB/SjrSIj
         tIUTeFZDIl8J+T+0FZmSffAOwYVMibLd43sxfuFHy4japRGG8rbNMNpb7oGRHMQqDbSc
         IbvlrOr5SZRBEmTuLhLLFpaRnkiqOuIMy/mUrUjWyqtJ3vJwB4hJvy1vT4IQwY1N115z
         fMiw==
X-Gm-Message-State: APjAAAV/KIfp3+48Sjg13uzWQxaDUVwEp8b4NWQn/kal4mZ1ATPrWmB7
        DK0aDijbSVp8zyZ9rX/ryuC5UX6wWf4=
X-Google-Smtp-Source: APXvYqzIrnh05reMfzMCntftROz9tM6qcuf30jTOHdotUtHYgVmyGxLE91GsOwaihJ7lB4ILWruuVA==
X-Received: by 2002:ab0:2653:: with SMTP id q19mr13659909uao.76.1556058072553;
        Tue, 23 Apr 2019 15:21:12 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id t186sm1489177vkt.15.2019.04.23.15.21.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:21:11 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id f22so9253178vso.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:21:10 -0700 (PDT)
X-Received: by 2002:a67:eecb:: with SMTP id o11mr15261576vsp.66.1556058070230;
 Tue, 23 Apr 2019 15:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181011225421.GA21093@beast> <20181012142902.GD2420@thunk.org>
 <CAGXu5jLqg5sf=oCZ_mB+ozTF=kKS7y4SNBKb96a6sBR07BprNg@mail.gmail.com>
 <CAGXu5jJwLSRM4y-SK2d600ha2-ui8ibaGQa_qws8kmP=Yu1+oA@mail.gmail.com> <20190416160948.GE3004@mit.edu>
In-Reply-To: <20190416160948.GE3004@mit.edu>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 15:20:58 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLexxSyX4cVz=LrvQ-RDVK+JRfyBJuqTn2UDgqyPiwvMA@mail.gmail.com>
Message-ID: <CAGXu5jLexxSyX4cVz=LrvQ-RDVK+JRfyBJuqTn2UDgqyPiwvMA@mail.gmail.com>
Subject: Re: [PATCH] random: Move rand_initialize() earlier
To:     "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
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

On Tue, Apr 16, 2019 at 9:09 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Apr 15, 2019 at 10:46:34PM -0500, Kees Cook wrote:
> > On Fri, Oct 12, 2018 at 9:45 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Oct 12, 2018 at 7:29 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > > > On Thu, Oct 11, 2018 at 03:54:21PM -0700, Kees Cook wrote:
> > > >> Right now rand_initialize() is run as an early_initcall(), but it only
> > > >> depends on timekeeping_init() (for mixing ktime_get_real() into the
> > > >> pools). However, the call to boot_init_stack_canary() for stack canary
> > > >> initialization runs earlier, which triggers a warning at boot:
> > > >>
> > > >> random: get_random_bytes called from start_kernel+0x357/0x548 with crng_init=0
> > > >>
> > > >> Instead, this moves rand_initialize() to after timekeeping_init(), and moves
> > > >> canary initialization here as well.
> > > >>
> > > >> Note that this warning may still remain for machines that do not have
> > > >> UEFI RNG support (which initializes the RNG pools durting setup_arch()),
> > > >> or for x86 machines without RDRAND (or booting without "random.trust=on"
> > > >> or CONFIG_RANDOM_TRUST_CPU=y).
> > > >>
> > > >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > Hi Ted! Did this get lost? This has come up again, and I don't see it
> > having landed anywhere yet. Can you take this?
>
> Yeah, sorry, it got lost; my bad.  I'll take it and push it out at the
> next merge window.

Gentle poke. :) I still don't see this in -next...

-- 
Kees Cook
