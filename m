Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E521C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722F020869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfDMEDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 00:03:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44157 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfDMEDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 00:03:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44h1MV05S5z9s4V;
        Sat, 13 Apr 2019 14:03:17 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@c-s.fr, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-5 tag
Date:   Sat, 13 Apr 2019 14:03:19 +1000
Message-ID: <87zhoutuuw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull some more powerpc fixes for 5.1:

The following changes since commit 6f845ebec2706841d15831fab3ffffcfd9e676fa:

  powerpc/pseries/mce: Fix misleading print for TLB mutlihit (2019-03-29 16:59:19 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-5

for you to fetch changes up to cf7cf6977f531acd5dfe55250d0ee8cbbb6f1ae8:

  powerpc/mm: Define MAX_PHYSMEM_BITS for all 64-bit configs (2019-04-10 14:45:57 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.1 #5

A minor build fix for 64-bit FLATMEM configs.

A fix for a boot failure on 32-bit powermacs.

My commit to fix CLOCK_MONOTONIC across Y2038 broke the 32-bit VDSO on 64-bit
kernels, ie. compat mode, which is only used on big endian.

The rewrite of the SLB code we merged in 4.20 missed the fact that the 0x380
exception is also used with the Radix MMU to report out of range accesses. This
could lead to an oops if userspace tried to read from addresses outside the user
or kernel range.

Thanks to:
  Aneesh Kumar K.V, Christophe Leroy, Larry Finger, Nicholas Piggin.

- ------------------------------------------------------------------
Christophe Leroy (2):
      powerpc/32: Fix early boot failure with RTAS built-in
      powerpc/vdso32: fix CLOCK_MONOTONIC on PPC64

Michael Ellerman (1):
      powerpc/mm: Define MAX_PHYSMEM_BITS for all 64-bit configs

Nicholas Piggin (1):
      powerpc/64s/radix: Fix radix segment exception handling


 arch/powerpc/include/asm/mmu.h            |  2 +-
 arch/powerpc/kernel/exceptions-64s.S      | 12 ++++++++++++
 arch/powerpc/kernel/head_32.S             |  8 --------
 arch/powerpc/kernel/vdso32/gettimeofday.S |  2 +-
 4 files changed, 14 insertions(+), 10 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcsV9SAAoJEFHr6jzI4aWAhi8P/RB37+hOMXUP4CzX4VSKuorG
pIDo8rfAL8pmw+6gGooG4VNTfjoaENKdLygYIG+jFhh/xJx3lIUkfL970dWHv+la
bCUpofJvCwW00ZQRbjBDn8GihhZUQMITPlFSrnj1bz/hmFmMFjANFSPAOuGL7AY5
OIWQ2kzBkxFTkx7H60UPWPBQ0N+KI7DiFEX14Eg8UlEl5rWS/SBmnAL/1B+vYoLs
A8z71OXL0QD1mg0zTfevNzY7p5enOaGrZqau9Rs3QuKPb95XjiSL15jq5XwrggDy
4fvDTxrHHZOo383H9UZo4ZdY+mxgRnqhpyWgnBvxBc7JJgE/pCg5LOIE7aq/0DbY
4XaQ66BOr7d5Qw41KTs/XOHsmFTdYgfN91KwY/3UgB0740xdAhMPLn+fLxrs4iBL
xAmDS4luqk2+i8WLvUZsXh9L9b/ul41rN1q8xH0O2/ARTaTFarGo0KOsqNv2DGmW
oAiHpTA/mKkzN/I8iNBM057r8WTuunScyvjviNW9sKY36lbdvKbxndBmT5Ew9a1I
5L7c+xKPJNCjxX6iFtXaEQBYM47k+bwP+VxA8SAamvZmo+UXME01zoYeHzSRgmdX
oaYjMv1BEeWAf9eWsitV7rShZTDoJR7glMuBG4rHU3pzO0kMQTIAGM1wsVAs5XK6
z8EX5UlhVxwjFGvCDsKq
=3Jqz
-----END PGP SIGNATURE-----
