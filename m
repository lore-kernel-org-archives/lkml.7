Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EF5C4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 23:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74387222C8
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 23:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FW2fQQZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfJEXcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 19:32:35 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54184 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJEXcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 19:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=inWe+wPQDL49R+6KPC7i1d3SgmP+UMc6gWI6aNa5Y5g=; b=FW2fQQZROZZYU6Vf86snokEbY
        EXEQGaYX0wahhGIrwzGjWrKSEzRrJFW5ZUBtWZO9QT0fx4+5DvhBsMVXlHNsKXsHBTbt+MFihu7Vn
        6wwoM8gMsTpKekHmkGP1iKdUlwqRkdZqqkuhcrGk1PR47YaJWWNWX67t/0bDcQAO8pvU8vwRT9EVc
        P2ristjMCaHcau0mqKCCFUWDTWrcg99b/POWQpBLIF+uF2iFUkTvMWSTBf8NqLvqqQShQmSR74q6u
        L1KT078DQSFrFmUiGzV0biqSaZc//r/5Ar/CkM3BGdItWKmkWmWX9lO9kVQUoGiSyPsZyl439qQdG
        N0S24n1Xg==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:40546)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iGtXK-0005NC-5Z; Sun, 06 Oct 2019 00:32:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iGtXH-0004DK-Jb; Sun, 06 Oct 2019 00:32:27 +0100
Date:   Sun, 6 Oct 2019 00:32:27 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: MAP_FIXED_NOREPLACE appears to break older i386 binaries
Message-ID: <20191005233227.GB25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under a 4.19 kernel (debian stable), I am surprised to find that some
previously working i386 binaries no longer work, whereas others are
fine.  ls, for example, dies with a SEGV, but bash is fine.

Looking at the kernel log reveals:

[13117.361000] 20899 (ls): Uhuuh, elf segment at 0000000008065000 requested but
the memory is mapped already
[13120.367221] 20935 (vdir): Uhuuh, elf segment at 0000000008065000 requested but the memory is mapped already
[13122.891253] 20936 (ls): Uhuuh, elf segment at 0000000008065000 requested but
the memory is mapped already
[13137.719143] 20940 (ls): Uhuuh, elf segment at 0000000008065000 requested but
the memory is mapped already
[13139.202469] 20978 (ls): Uhuuh, elf segment at 0000000008065000 requested but
the memory is mapped already
[13158.093533] 21007 (ls): Uhuuh, elf segment at 0000000008065000 requested but
the memory is mapped already
[13221.920939] 21021 (objdump): Uhuuh, elf segment at 00000000080a1000 requested but the memory is mapped already

Looking at /bin/ls:

Program Header:
    PHDR off    0x00000034 vaddr 0x08048034 paddr 0x08048034 align 2**2
         filesz 0x00000120 memsz 0x00000120 flags r-x
  INTERP off    0x00000154 vaddr 0x08048154 paddr 0x08048154 align 2**0
         filesz 0x00000013 memsz 0x00000013 flags r--
    LOAD off    0x00000000 vaddr 0x08048000 paddr 0x08048000 align 2**12
         filesz 0x0001d620 memsz 0x0001d620 flags r-x
    LOAD off    0x0001d950 vaddr 0x08065950 paddr 0x08065950 align 2**12
         filesz 0x00000a50 memsz 0x000016e4 flags rw-
 DYNAMIC off    0x0001dec4 vaddr 0x08065ec4 paddr 0x08065ec4 align 2**2
         filesz 0x00000100 memsz 0x00000100 flags rw-
    NOTE off    0x00000168 vaddr 0x08048168 paddr 0x08048168 align 2**2
         filesz 0x00000044 memsz 0x00000044 flags r--
EH_FRAME off    0x00018e68 vaddr 0x08060e68 paddr 0x08060e68 align 2**2
         filesz 0x00000774 memsz 0x00000774 flags r--
   STACK off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**4
         filesz 0x00000000 memsz 0x00000000 flags rw-
   RELRO off    0x0001d950 vaddr 0x08065950 paddr 0x08065950 align 2**0
         filesz 0x000006b0 memsz 0x000006b0 flags r--

Note that the executable part of ls extends from 0x08048000 for
0x0001d620 bytes in memory and file, which takes that up to
0x08065620.  The rw data section starts at 0x08065950.

Seems we've broken older i386 binaries with commit ad55eac74f20
("elf: enforce MAP_FIXED on overlaying elf segments").  Maybe the
MAP_FIXED_NOREPLACE stuff needs to have an on/off switch?

Here's the objdump -h output for the same binary:

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .interp       00000013  08048154  08048154  00000154  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  1 .note.ABI-tag 00000020  08048168  08048168  00000168  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .note.gnu.build-id 00000024  08048188  08048188  00000188  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 .gnu.hash     0000003c  080481ac  080481ac  000001ac  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .dynsym       00000840  080481e8  080481e8  000001e8  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .gnu.liblist  000000c8  08048a28  08048a28  00000a28  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 .gnu.version  00000108  08049020  08049020  00001020  2**1
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  7 .gnu.version_r 000000c0  08049128  08049128  00001128  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  8 .rel.dyn      00000048  080491e8  080491e8  000011e8  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  9 .rel.plt      00000390  08049230  08049230  00001230  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 10 .init         00000023  080495c0  080495c0  000015c0  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 11 .plt          00000730  080495f0  080495f0  000015f0  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 12 .text         00013274  08049d20  08049d20  00001d20  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 13 .fini         00000014  0805cf94  0805cf94  00014f94  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 14 .rodata       00003ea8  0805cfc0  0805cfc0  00014fc0  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 15 .eh_frame_hdr 00000774  08060e68  08060e68  00018e68  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 16 .eh_frame     0000341c  080615dc  080615dc  000195dc  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 17 .dynstr       0000064c  080649f8  080649f8  0001c9f8  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 18 .gnu.conflict 000005dc  08065044  08065044  0001d044  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 19 .init_array   00000004  08065950  08065950  0001d950  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 20 .fini_array   00000004  08065954  08065954  0001d954  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 21 .jcr          00000004  08065958  08065958  0001d958  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 22 .data.rel.ro  00000544  08065980  08065980  0001d980  2**6
                  CONTENTS, ALLOC, LOAD, DATA
 23 .dynamic      00000100  08065ec4  08065ec4  0001dec4  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 24 .got          00000024  08065fc4  08065fc4  0001dfc4  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 25 .got.plt      000001d4  08066000  08066000  0001e000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
 26 .data         000001a0  08066200  08066200  0001e200  2**6
                  CONTENTS, ALLOC, LOAD, DATA
 27 .bss          00000c74  080663c0  080663c0  0001e3a0  2**6
                  ALLOC
 28 .gnu_debuglink 00000010  00000000  00000000  0001e3a0  2**2
                  CONTENTS, READONLY
 29 .gnu_debugdata 00001170  00000000  00000000  0001e3b0  2**0
                  CONTENTS, READONLY
 30 .gnu.prelink_undo 000005dc  00000000  00000000  0001f520  2**2
                  CONTENTS, READONLY

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
