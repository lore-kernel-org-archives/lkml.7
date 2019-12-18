Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0858AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE169206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfLRNhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:37:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33638 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLRNhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:37:19 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihZVo-0004sC-T1; Wed, 18 Dec 2019 13:37:13 +0000
Date:   Wed, 18 Dec 2019 13:37:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] remove ksys_mount() and ksys_dup()
Message-ID: <20191218133712.GK4203@ZenIV.linux.org.uk>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <157644301187.32474.6697415383792507785.pr-tracker-bot@kernel.org>
 <CAJmaN=ksaH5AgRUdVPGWKZzjEinU+goaCqedH1PW6OmKYc_TuA@mail.gmail.com>
 <CAHk-=wgjNqEfaVssn1Bd897dGFMVAjeg3tiDWZ7-z886fBCTLA@mail.gmail.com>
 <CAJmaN=mNVJVGPkwYvE6PmQSgT8o3Uo3=1iQm2NFicZ2fFC6Pxw@mail.gmail.com>
 <20191217225743.GD4203@ZenIV.linux.org.uk>
 <20191218075119.GA186397@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218075119.GA186397@light.dominikbrodowski.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 08:51:19AM +0100, Dominik Brodowski wrote:
> On Tue, Dec 17, 2019 at 10:57:43PM +0000, Al Viro wrote:
> > Seriously, these parts of init/* ought to be treated as userland code
> > that runs in kernel mode mostly because it's too much PITA to arrange
> > building a static ELF binary and linking it into the image.
> 
> Well, we have had the infrastructure for fork_usermode_blob() in the kernel
> since May 2018, though it is not really used so far (the bpfilter blob is
> just reporting its existence, and not doing anything substantial). Probably,
> significant parts of init/* could be migrated to such a blob. Would that be
> an alternative generally preferred, or is its dependence on CC_CAN_LINK a
> showstopper?

Well...  everything from default_rootfs/populate_rootfs call (incidentally,
stuff starting to leak into rootfs_initcall level shouldn't be mixed
with those two, but that's a separate story) and on to the end of
kernel_init_freeable() could be forked; the other bit (actual execve
attempts in the end of kernel_init()) must be in PID 1.

The problem is not just CC_CAN_LINK, it's the damn size of binaries...

> FWIW, non-initramfs boot code is considered to be "legacy" since 2.6.16, see
> filesystems/ramfs-rootfs-initramfs.txt:
> 
> | Today (2.6.16), initramfs is always compiled in, but not always used.  The
> | kernel falls back to legacy boot code that is reached only if initramfs does
> | not contain an /init program.  The fallback is legacy code, there to ensure a
> | smooth transition and allowing early boot functionality to gradually move to
> | "early userspace" (I.E. initramfs).
> |
> | ...
> |
> | This kind of complexity (which inevitably includes policy) is rightly handled
> | in userspace.  Both klibc and busybox/uClibc are working on simple initramfs
> | packages to drop into a kernel build.
> |
> | The klibc package has now been accepted into Andrew Morton's 2.6.17-mm tree.
> | The kernel's current early boot code (partition detection, etc) will probably
> | be migrated into a default initramfs, automatically created and used by the
> | kernel build.
> 
> That plan seems to have been obsoleted long ago, right?

klibc is not in mainline and I hadn't heard of attempts to get it into the
kernel git tree for quite a few years.  Whether this "just call sys_...()
instead of doing normal syscalls" is a stopgap measure until that happens
or something more permanent, the effect is the same - not poking in the
kernel internals from code with lousy test coverage...
