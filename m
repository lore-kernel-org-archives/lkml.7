Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4505C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 13:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392002084B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 13:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rwUHjWUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfJFNJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 09:09:37 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34778 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfJFNJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 09:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5zJMUhh4vs1DR6oFs+4OGLIzC0493FOWFbIKOdJDxnU=; b=rwUHjWUKG3oCkozL70tgxXbZR
        a8N0gtUUdT32tnx9MFQhfBdZigfjSiRKhASx/08EIM9aT0ht4PUsHLy+5KavPyRwUGSKDz/eiSauF
        ywDtW52Ft/ix5Z0GLVzqXpDTVVK+EVktaQJe439Dovug8P+e6Jj7FetgURfpr2stmDNH8xi33xDlV
        H4J8FU0bE3C+hGNwohjd5cYQVeBTvsg/YgjdLppE+Q8wJ7FvVZuOLisuHXNniRtoLVTdQ+w0eu7qv
        G/pcweLIOsHqSxoDvz9X+t4iFLl5VmQs8N6tMS8WQD6Fbr/Wd4QaUAHldW46nHU3pu8EppR2L2bwP
        3Fn61AADQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:48282)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iH6Hw-0000E5-3n; Sun, 06 Oct 2019 14:09:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iH6Hs-0004jp-Vn; Sun, 06 Oct 2019 14:09:25 +0100
Date:   Sun, 6 Oct 2019 14:09:24 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MAP_FIXED_NOREPLACE appears to break older i386 binaries
Message-ID: <20191006130924.GC25745@shell.armlinux.org.uk>
References: <20191005233227.GB25745@shell.armlinux.org.uk>
 <CAHk-=wiy9MWteoaoV15FJ7QJeRhBtCVgo6ECiLb4khuc5PxHUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiy9MWteoaoV15FJ7QJeRhBtCVgo6ECiLb4khuc5PxHUg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 05:18:05PM -0700, Linus Torvalds wrote:
> Duh.
> 
> I only looked at recent issues in this area, and overlooked your
> sentence in between the two ELF section dumps, and it appears that you
> have already biseced it to something else:

I hadn't - I'd looked at the changes and identified a likely culpret
that fit with the symptoms and the layout of the binary.

What I'm basically trying to do is update my laptop - it was running
an x86_64 4.5.7 kernel but with 32-bit userland.  I've just installed
into a separate partition Debian Stable with the view to seeing
whether I like it, which means migrating stuff over - and I hit a
problem with the newer Evolution not wanting to recognise the
configuration/data from the previous version.

So I thought... I can just chroot into the old setup, run up evolution
there, export its configuration, so I can import it into the newer
version without having to go through a reboot cycle.

The chroot and exec of bin/bash in the old setup was successful, as
was dmesg, but useful tools like ls failed with a segfault.

The difference between working binaries and non-working binaries seems
to be whether the r-x and rw- LOAD sections in the ELF program headers
overlap on a page.  Here's bash:

    LOAD off    0x00000000 vaddr 0x08047000 paddr 0x08047000 align 2**12
         filesz 0x000bbb08 memsz 0x000bbb08 flags r-x
    LOAD off    0x000bc000 vaddr 0x08103000 paddr 0x08103000 align 2**12
         filesz 0x00004864 memsz 0x00009648 flags rw-

So, the r-x load covers 0x08047000-0x08102b08, and the following rw-
load covers 0x08103000 onwards - so next page.  dmesg is similar:

    LOAD off    0x00000000 vaddr 0x08048000 paddr 0x08048000 align 2**12
         filesz 0x00009c64 memsz 0x00009c64 flags r-x
    LOAD off    0x00009e28 vaddr 0x08052e28 paddr 0x08052e28 align 2**12
         filesz 0x000028ce memsz 0x000028ce flags rw-

0x08048000-0x08051c64 vs 0x08052e28 - so next page.  In contrast, ls:

    LOAD off    0x00000000 vaddr 0x08048000 paddr 0x08048000 align 2**12
         filesz 0x0001d620 memsz 0x0001d620 flags r-x
    LOAD off    0x0001d950 vaddr 0x08065950 paddr 0x08065950 align 2**12
         filesz 0x00000a50 memsz 0x000016e4 flags rw-

0x08048000-0x08065620 vs 0x08065950 - so same page, and fails.

Looking at the commit I referred to, what we end up with is:

- Initially, elf_fixed is MAP_FIXED_NOREPLACE and load_addr_set is false
- elf_brk and elf_bss are initially zero
- The first LOAD requests a mapping for 0x08048000 .. 0x08065fff inclusive
- since this is an executable mapping, we use elf_fixed to set the
  MAP_FIXED* flags, so this mapping is established with
  MAP_FIXED_NOREPLACE.
- load_addr_set is now set to true
- elf_bss is set to vaddr + filesz => 0x08065620
- elf_brk is set to vaddr + memsz => 0x08065620
- Moving on to the second LOAD, this is a mapping starting at 0x08065950
- Since elf_brk > elf_bss is false, we don't take that path through the
  code, which _would_ have set elf_fixed to MAP_FIXED (that's the only
  case which we would do - for the BSS.)
- As load_addr_set is true, we again use elf_fixed to set the
  MAP_FIXED* flags.  elf_fixed is still MAP_FIXED_NOREPLACE, so this
  mapping uses MAP_FIXED_NOREPLACE.
- Since this mapping overlaps the previous mapping, it fails with the
  error mentioned.

Since the ELF load_binary() method returns -EEXIST, we end up in this
code path in fs/exec.c:

                if (retval < 0 && !bprm->mm) {
                        /* we got to flush_old_exec() and failed after it */
                        read_unlock(&binfmt_lock);
                        force_sigsegv(SIGSEGV);
                        return retval;
                }

and the program is killed with a SIGSEGV.

So, from a code inspection point of view, it seems that this is likely
the culpret.

I don't yet have the debian stable system setup enough to build kernels;
that may be today's project, but I'd first like to solve the original
issue (migrating the evolution setup) so I can first see whether it's
going to be worth me continuing, or whether I persist with my existing
setup.

However, I think it _is_ worth highlighting that we seem to have broken
binary compatibility with older i386 userspace with newer kernels.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
