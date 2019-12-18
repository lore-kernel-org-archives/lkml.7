Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BA2C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A82206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLRHyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:54:10 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:60920 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRHyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:54:10 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id C5788200AC8;
        Wed, 18 Dec 2019 07:54:08 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id A1B0B20114; Wed, 18 Dec 2019 08:51:19 +0100 (CET)
Date:   Wed, 18 Dec 2019 08:51:19 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] remove ksys_mount() and ksys_dup()
Message-ID: <20191218075119.GA186397@light.dominikbrodowski.net>
References: <20191212181422.31033-1-linux@dominikbrodowski.net>
 <157644301187.32474.6697415383792507785.pr-tracker-bot@kernel.org>
 <CAJmaN=ksaH5AgRUdVPGWKZzjEinU+goaCqedH1PW6OmKYc_TuA@mail.gmail.com>
 <CAHk-=wgjNqEfaVssn1Bd897dGFMVAjeg3tiDWZ7-z886fBCTLA@mail.gmail.com>
 <CAJmaN=mNVJVGPkwYvE6PmQSgT8o3Uo3=1iQm2NFicZ2fFC6Pxw@mail.gmail.com>
 <20191217225743.GD4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217225743.GD4203@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:57:43PM +0000, Al Viro wrote:
> Seriously, these parts of init/* ought to be treated as userland code
> that runs in kernel mode mostly because it's too much PITA to arrange
> building a static ELF binary and linking it into the image.

Well, we have had the infrastructure for fork_usermode_blob() in the kernel
since May 2018, though it is not really used so far (the bpfilter blob is
just reporting its existence, and not doing anything substantial). Probably,
significant parts of init/* could be migrated to such a blob. Would that be
an alternative generally preferred, or is its dependence on CC_CAN_LINK a
showstopper?

FWIW, non-initramfs boot code is considered to be "legacy" since 2.6.16, see
filesystems/ramfs-rootfs-initramfs.txt:

| Today (2.6.16), initramfs is always compiled in, but not always used.  The
| kernel falls back to legacy boot code that is reached only if initramfs does
| not contain an /init program.  The fallback is legacy code, there to ensure a
| smooth transition and allowing early boot functionality to gradually move to
| "early userspace" (I.E. initramfs).
|
| ...
|
| This kind of complexity (which inevitably includes policy) is rightly handled
| in userspace.  Both klibc and busybox/uClibc are working on simple initramfs
| packages to drop into a kernel build.
|
| The klibc package has now been accepted into Andrew Morton's 2.6.17-mm tree.
| The kernel's current early boot code (partition detection, etc) will probably
| be migrated into a default initramfs, automatically created and used by the
| kernel build.

That plan seems to have been obsoleted long ago, right?

Thanks,
	Dominik
