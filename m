Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3894C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FCF207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569269306;
	bh=Ab4rZ4uY05EZoxb5wQEUKbN7XfOxGeM045TcLeQR3/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=JgW2ls1kHDYWhVWQlZ4SoKuoP8pl9hXKsn0iO8fzYaglxzjHRwusIXHSDEqD4NiZI
	 We3WX1ntUhCIWa0MX/xAs0s1R9mcD+CZSgNfDECTwzvnF3p5+B2odmfNpbW+HN9A5l
	 4EwBmZ7n9EviaiEsfCw0zHL0fV8z3KMIObYff13U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502343AbfIWUIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:08:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38591 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfIWUIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:08:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so10616023wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nXi7/ONuPG7gYM14nxcA/YNbkxLisbAhUdDyufHT4Gs=;
        b=fXqrhibESWmvhBLMXupTaL/DG2zK28DqaPaZZvgaqsFLXog5heTO9pEli7laAm/oUW
         bYaZhPMnb3luHIMTA8kPaLIeICU1CE4S2TqcTjQoYbx6JIrZHCdpgGNNpqPYkotQ3GF/
         XO59WBT5u51cLxZ49BQJdvGjxwghbB2MwVIEvM+nKowb9BJYw7sgFFeRkSY8qtmNyP2E
         VpH56hz/tDNqoz5U0qk8I9o7yUeRKGJpLS9CBAyK0XjJj4QPl20MHKp3B/GOaoD4iEt5
         hpcQo7Dze0N+WJgDLp+JcoRhuuYyI+hTi8l2kwaodNjU4TWaXtrb+8WTwibsbe68XZo2
         pU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nXi7/ONuPG7gYM14nxcA/YNbkxLisbAhUdDyufHT4Gs=;
        b=izqbQ25g729HxisrXjy8eRoJ1VV0/0tVhpsBRcwP6juORg5mjfp5sh/ru2YwGOQu64
         YaUrMJPv2obXqc36nIF2PRTwKhczh3EUecNd4hNrIx1xByzWrs9QECZWqBYqrUYJ/zs7
         AlXk5PLsblpU0bpOqut275c6vfsVsEVkWl46Sv++WL54/JpOevLSLE3BeJ7KpwA/uH4J
         CZ76oSFbtS8iTh/8UICXLFVYqreCSpOne2I5dH8kOI5L2F2r1GorHm01aQboj4qAxeVm
         zkhsyVq7tbD7I3h4r4xj1AOh9FtmEHMweDUAuXSxmeyRrb3HXRGlgxrxiFXE09NeGNt/
         NhDw==
X-Gm-Message-State: APjAAAXzuu3cHaAguX339NJnPkLsmZ+Xj6L2OUa+OvzmHVrzAFp2gN/v
        I2JaeGX42cm8S1D3hQENv7g=
X-Google-Smtp-Source: APXvYqz6QqFmAuPWF0qlmgeG0teQXv9bXiCQCRz5yPkhXriedwepo64WoVb+5v4El7q9IgrSBDD8sw==
X-Received: by 2002:a1c:a6ca:: with SMTP id p193mr951565wme.103.1569269301100;
        Mon, 23 Sep 2019 13:08:21 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h9sm11619066wrv.30.2019.09.23.13.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 13:08:20 -0700 (PDT)
Date:   Mon, 23 Sep 2019 22:08:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC, Tree] De-clutter the top level directory, move ipc/ =>
 kernel/ipc/, samples/ => Documentation/samples/ and sound/ => drivers/sound/
Message-ID: <20190923200818.GA116090@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190922115247.GA2679387@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sun, Sep 22, 2019 at 01:25:55PM +0200, Ingo Molnar wrote:
> > 
> > * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > > On Fri, Sep 20, 2019 at 9:35 AM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > > >
> > > > Sorry about that. I am surprised that none of the other reviewers
> > > > brought this up.
> > > 
> > > I think I'm "special".
> > > 
> > > There was some other similar change a few years ago, which I
> > > absolutely hated because of how it broke autocomplete for me. Very few
> > > other people seemed to react to it.
> > 
> > FWIW, I am obsessively sensitive to autocomplete and overall source code 
> > file hieararchy and nomenclature details as well, so it's not just you.
> > 
> > Beyond the muscle memory aspect, nonsensical naming and inanely flat file 
> > hierarchies annoy kernel developers and makes it harder for newbies to 
> > understand the kernel source as well.
> > 
> > The less clutter, the more organization, the better - and there's very 
> > few valid technical reasons to add any new files or directories to the 
> > top level directory - we should probably *remove* quite a few.
> > 
> > For example 'firmware/' was recently moved to drivers/firmware/, and in a 
> > similar fashion about a third of the remaining 22 directories should 
> > probably be moved too:
> > 
> >   drwxr-xr-x    arch
> >   drwxr-xr-x    block
> >   drwxr-xr-x    certs           # move to build/certs/ dir
> >   drwxr-xr-x    crypto          # move to kernel/crypto/ or security/crypto/
> >   drwxr-xr-x    Documentation
> >   drwxr-xr-x    drivers
> >   drwxr-xr-x    fs
> >   drwxr-xr-x    include
> >   drwxr-xr-x    init
> >   drwxr-xr-x    ipc             # move to kernel/ipc/
> >   drwxr-xr-x    kernel
> >   drwxr-xr-x    lib
> >   drwxr-xr-x    LICENSES
> >   drwxr-xr-x    mm
> >   drwxr-xr-x    net
> >   drwxr-xr-x    samples         # move to Documentation/samples/
> >   drwxr-xr-x    scripts         # move to build/scripts/
> >   drwxr-xr-x    security
> >   drwxr-xr-x    sound           # move to drivers/sound/
> >   drwxr-xr-x    tools
> >   drwxr-xr-x    usr             # move to build/usr/
> >   drwxr-xr-x    virt            # move to the already existing drivers/virt/
> > 
> >   -rw-r--r--    COPYING
> >   -rw-r--r--    CREDITS
> >   -rw-r--r--    Kbuild
> >   -rw-r--r--    Kconfig
> >   -rw-r--r--    MAINTAINERS
> >   -rw-r--r--    Makefile
> >   -rw-r--r--    README
> > 
> > There's a few borderline ones:
> > 
> >  - 'block' could in principle move to drivers/block/core/ but it's fine 
> >    at the top level too I think.
> > 
> >  - 'init' could in principle be moved to kernel/init/ - but it's not 
> >    wrong at the top level either.
> > 
> > The remaining top level hierarchy would look pretty sweet and short:
> > 
> >   drwxr-xr-x    arch
> >   drwxr-xr-x    block
> >   drwxr-xr-x    build             # new
> >   drwxr-xr-x    Documentation
> >   drwxr-xr-x    drivers
> >   drwxr-xr-x    fs
> >   drwxr-xr-x    include
> >   drwxr-xr-x    init
> >   drwxr-xr-x    kernel
> >   drwxr-xr-x    lib
> >   drwxr-xr-x    LICENSES
> >   drwxr-xr-x    mm
> >   drwxr-xr-x    net
> >   drwxr-xr-x    security
> >   drwxr-xr-x    tools
> > 
> >   -rw-r--r--    COPYING
> >   -rw-r--r--    CREDITS
> >   -rw-r--r--    Kbuild
> >   -rw-r--r--    Kconfig
> >   -rw-r--r--    MAINTAINERS
> >   -rw-r--r--    Makefile
> >   -rw-r--r--    README
> > 
> > I'm volunteering to do this (in a scripted, repeatable, reviewable, 
> > tweakable and "easy to execute in a quiet moment" fashion), although
> > I also expect you to balk at the churn. :-)
> 
> I for one would love the above changes.  And I'm the one that has to
> deal with all of the backporting issues that arise with stable backports :)

Oh, that's a pleasant surprise, I didn't expect _100%_ support! :-)

So I started working on this today and whipped up three of these 
movements, in a 100% scripted fashion.

You can have a sneak preview at the result in this tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.core/toplevel

   ...

   2515 files changed, 42476 insertions(+), 42476 deletions(-)

I decided not to post these first patches to lkml, because many of the 
patches are unreviewably large even with smart rename detection. Even the 
diffstat was 5,000+ lines so I abbreviated it ...

The tree has 6 commits for now:

  6576382877c0: toplevel: Move ipc/ to kernel/ipc/
  8f7ace98971a: toplevel: Fix up kernel/ipc/ movement effects
  cc703bc54b00: toplevel: Move sound/ to drivers/sound/
  a63bdbd797da: toplevel: Fix up drivers/sound/ movement effects
  28adaae5ae8f: toplevel: Move samples/ to Documentation/samples/
  4e9f67e3bc48: toplevel: Fix up samples/ movement effects

Due to the scripting all the commits are auto-generated for the time 
being - without SOB lines and proper changelogs, etc.

Note that each movement action consists of two commits:

  cc703bc54b00: toplevel: Move sound/ to drivers/sound/
  a63bdbd797da: toplevel: Fix up drivers/sound/ movement effects

The first one is just the result of the 'git mv', which gets most of the 
noise.

The second one fixes up the build system, Kconfig system and any 
references to the old file names. Forward and backward porting of patches 
across the rename boundary is in most cases a simple matter of fixing up 
the file names in the patches - I'll put both forward and backward 
patch-consersion one-liner scripts for that into the changelog itself.

I believe this is easier to review, but it has the disadvantage that 
bisection will trivially break if it hits any of the base commits. Can 
combine the commits as well, or can add a suggestion to use
"git bisect next" to the changelog itself. Either approach is fine to me.

Anyway, I will fix the aforementioned details, but wanted to show the 
gist of these changes and give you an opportunity to request changes, 
before I go down this path too much.

The tree is functional here after some light testing - will put it 
through more rigorous testing before posting future iterations.

The advantage of the scripting is that:

 - I can re-run this on any base tree and with any granularity, and my 
   scripts also have some sanity checks to see whether any old filename 
   patterns escaped the conversion, etc.

 - The order of the movement is discretionary as well, i.e. if you prefer 
   the sound/ movement in a single tree and at a specific time, that all 
   can be phased arbitrarily.

 - The scripts can be re-run with less than a minute of runtime, so it 
   can all be timed for maximum convenience to you, Linus and affected 
   maintainers.

Is this close to what you had in mind?

Thanks,

	Ingo

------------------>
Ingo Molnar (6):
      toplevel: Move ipc/ to kernel/ipc/
      toplevel: Fix up kernel/ipc/ movement effects
      toplevel: Move sound/ to drivers/sound/
      toplevel: Fix up drivers/sound/ movement effects
      toplevel: Move samples/ to Documentation/samples/
      toplevel: Fix up samples/ movement effects

 2515 files changed, 42476 insertions(+), 42476 deletions(-)
