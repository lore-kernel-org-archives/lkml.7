Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8F6C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4256F206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfLPKbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:31:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47092 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfLPKbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:31:20 -0500
Received: from [79.140.120.2] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1igneo-00073p-7n; Mon, 16 Dec 2019 10:31:18 +0000
Date:   Mon, 16 Dec 2019 11:31:17 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kars de Jong <jongk@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [PATCH] m68k: Wire up clone3() syscall
Message-ID: <20191216103117.7sdyjol6ifkxow2h@wittgenstein>
References: <20191124195225.31230-1-jongk@linux-m68k.org>
 <CAMuHMdVv9FU+kTf7RDd=AFKL12tJxzmGbX4jZZ8Av3VCZUzwhA@mail.gmail.com>
 <20191126144121.kzkujr27ga36gqnf@wittgenstein>
 <CACz-3riWp1fWCaAJtMgRx9VRVAJ+ktdbAqHBobQUXR9XpHrVcQ@mail.gmail.com>
 <CAMuHMdVLQF_KyWDn=HxmLAp6Vy3jyw=JLDQWryLt809sCecosA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdVLQF_KyWDn=HxmLAp6Vy3jyw=JLDQWryLt809sCecosA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 15, 2019 at 05:48:10PM +0100, Geert Uytterhoeven wrote:
> Hi Kars,
> 
> On Tue, Nov 26, 2019 at 4:29 PM Kars de Jong <jongk@linux-m68k.org> wrote:
> > Op di 26 nov. 2019 om 15:41 schreef Christian Brauner
> > <christian.brauner@ubuntu.com>:
> > > On Mon, Nov 25, 2019 at 10:12:25AM +0100, Geert Uytterhoeven wrote:
> > > > On Sun, Nov 24, 2019 at 8:52 PM Kars de Jong <jongk@linux-m68k.org> wrote:
> > > > > Wire up the clone3() syscall for m68k. The special entry point is done in
> > > > > assembler as was done for clone() as well. This is needed because all
> > > > > registers need to be saved. The C wrapper then calls the generic
> > > > > sys_clone3() with the correct arguments.
> > > > >
> > > > > Tested on A1200 using the simple test program from:
> > > > >
> > > > >   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/
> > >
> > > Please note that we now have a growing test-suite for the clone3()
> > > syscall under
> > > tools/testing/selftests/clone3/*
> > >
> > > You can test on a suitable kernel with
> > >
> > > make TARGETS=clone3 kselftest
> >
> > I'm afraid my user space is almost prehistoric. I have a homebrewn
> > root filesystem of about 2001 vintage, and another one with Debian
> > 3.1.
> > So until I have bootstrapped a more recent one, I'll leave that to others ;-)
> 
> With Ubuntu's libc6-m68k-cross installed, the selftest binaries cross-build
> fine.  Running them on a very old Debian requires some hackery:
> 
>   1. Copy ld.so.1, ld-2.27.so, libc.so.6, and libc-2.27.so from
>      /usr/m68k-linux-gnu/lib/ to /tmp/lib on the m68k target,
>   2. mkdir /tmp/proc && mount proc /tmp/proc -t proc,
>   3. chroot /tmp /tmp/<test-binary>.
> 
> Unfortunately some tests failed:

Thanks for going through the trouble of testing this, Geert!
Christian
