Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FC82171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfCLHTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:19:55 -0400
Received: from smtp-3.orcon.net.nz ([60.234.4.44]:45953 "EHLO
        smtp-3.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfCLHTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:19:55 -0400
X-Greylist: delayed 2436 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2019 03:19:53 EDT
Received: from [121.99.228.40] (port=25804 helo=tower)
        by smtp-3.orcon.net.nz with esmtpa (Exim 4.86_2)
        (envelope-from <mcree@orcon.net.nz>)
        id 1h3b3V-0001wR-Df; Tue, 12 Mar 2019 19:38:30 +1300
Date:   Tue, 12 Mar 2019 19:38:24 +1300
From:   Michael Cree <mcree@orcon.net.nz>
To:     Matt Turner <mattst88@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH] x86: Deprecate a.out support
Message-ID: <20190312063824.wx7vow22cc35co77@tower>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
        Matt Turner <mattst88@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20190305181808.GH8256@zn.tnic>
 <CAEdQ38G5M3vq9pGBV1iyEViO7JhFuXk5g+VCs-vUH+Z62kNqgQ@mail.gmail.com>
 <CAHk-=wgt7M6yA5BJCJo0nF22WgPJnN8CvViL9CAJmd+S+Civ6w@mail.gmail.com>
 <yw1xa7i14btw.fsf@mansr.com>
 <CAHk-=whD1SumZUBQeuMT-GcciwPxg_jW_TsPAmokYp3sGGCGhA@mail.gmail.com>
 <yw1x5zsp473a.fsf@mansr.com>
 <CAHk-=wiU7xacTqDfm-x29-meyJWNd_X95K0T8FQMcDgy-yo3Qw@mail.gmail.com>
 <yw1x1s3d42ia.fsf@mansr.com>
 <CAK8P3a031d9mSOxVmCAGcrbdaCE8N3R4e2Smtxp-Z+cautTAvg@mail.gmail.com>
 <CAEdQ38HSKy+muCwAk9w0yNCt649HVja1Pe+yY23-4zBjDvWFRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEdQ38HSKy+muCwAk9w0yNCt649HVja1Pe+yY23-4zBjDvWFRA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 03:11:55PM -0700, Matt Turner wrote:
> On Mon, Mar 11, 2019 at 2:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Mar 11, 2019 at 8:47 PM Måns Rullgård <mans@mansr.com> wrote:
> > > Linus Torvalds <torvalds@linux-foundation.org> writes:
> > > > On Mon, Mar 11, 2019 at 11:08 AM Måns Rullgård <mans@mansr.com> wrote:
> > > > We don't have any specific support for ECOFF.
> > > >
> > > > I _think_. Again, it's been years and years.

I agree. I personally have never run any OSF/1 executables on
Linux Alpha and have no interest in doing so.

> > The main historic use case I've heard of was running Netscape
> > Navigator on Alpha Linux, before there was an open source version.
> > Doing this today to connect to the open internet is probably
> > a bit pointless, but there may be other use cases.
> 
> The best use case I know of is to run their C compiler. Måns sent
> patches in fact to make it work.
> 
> There is a Linux version of the same compiler but I have a vague
> memory that it's broken in various ways that the Tru64 version is
> not.

The last time I tried the Compaq C compiler for Alpha-Linux it still
worked, well, that is, the compiler worked, but the library header
files are broken and haven't worked with glibc for a long time.  So
it is only useful as a free-standing compiler.

In the past it also produced better code than gcc, but gcc is now
so vastly improved w.r.t. optimisation and compliance to more recent
standards, that I would be surprised if there is any real use for
the Compaq compiler.

Cheers,
Michael.
