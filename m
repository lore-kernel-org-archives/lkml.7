Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B9C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3F72075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="OtZDZJs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfD3Miw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:38:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6466 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfD3Miv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:38:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44th0S2qfqz9vD32;
        Tue, 30 Apr 2019 14:38:48 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=OtZDZJs8; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id q4fZuo44I2TJ; Tue, 30 Apr 2019 14:38:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44th0S1dFjz9vD30;
        Tue, 30 Apr 2019 14:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556627928; bh=PvzCi0akimz4TuIjK+2h8t4FJuPEOVbjQQwCEjrFhZs=;
        h=From:Subject:To:Cc:Date:From;
        b=OtZDZJs8rYBXY5yKGxpy4RhGvzbPwFU4rw+o2KM5qfV2+RNW/BVo0iMf0gDFTjS7L
         MK95w9U0t1TOtyByZRTENbsqR9g6a/uFziHcwSgCO2lZXy4W/icXjABY0B91cuqS3T
         r2lmYYYa4Dce10THNw6yIJ65ipCm+nppfJGRUtY0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 962278B8DF;
        Tue, 30 Apr 2019 14:38:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id c4PZWLNDiXMf; Tue, 30 Apr 2019 14:38:49 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 63A6A8B8C2;
        Tue, 30 Apr 2019 14:38:49 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 138BD666F8; Tue, 30 Apr 2019 12:38:48 +0000 (UTC)
Message-Id: <cover.1556627571.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 00/16] powerpc/32: Implement fast syscall entry
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 30 Apr 2019 12:38:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this series is to implement a fast syscall entry
on ppc32, as already done on ppc64.

Unlike all other exceptions which can happen at any time and
require to preserve all registers, the syscalls do not
require the preservation of volatile registers (except LR).

Syscall entries can then be optimised with lighter entry code
than the general exception handling.

In the meantime this series refactorises the exception entry on
40x/6xx/8xx as they are pretty similar, and it takes benh series
on rationalising the settings of MSR_EE at exceptions/syscall entries
as this change pretty simplies exception entries.

The refactorisation of exception entry will help when it comes to
implementing VMAP_STACK

On a 8xx, this series improves null_syscall selftest by 17%
On a 83xx, this series improves null_syscall selftest by 12,5%

v3:
- Rebased on latest powerpc/merge branch
- Fixed trivial conflict due to KUP functionnality
- Dropped patch 15 (already applied)

v2:
- Rebased on latest powerpc/merge branch.
- Added booke support as well (tested on qemu bamboo).
- Added a patch to get rid of the dummy frames when calling trace_hardirqs_on/off.

Christophe Leroy (16):
  powerpc/32: Refactor EXCEPTION entry macros for head_8xx.S and
    head_32.S
  powerpc/32: move LOAD_MSR_KERNEL() into head_32.h and use it
  powerpc/32: make the 6xx/8xx EXC_XFER_TEMPLATE() similar to the
    40x/booke one
  powerpc/40x: Don't use SPRN_SPRG_SCRATCH2 in EXCEPTION_PROLOG
  powerpc/40x: add exception frame marker
  powerpc/40x: Split and rename NORMAL_EXCEPTION_PROLOG
  powerpc/40x: Refactor exception entry macros by using head_32.h
  powerpc/fsl_booke: ensure SPEFloatingPointException() reenables
    interrupts
  powerpc/32: enter syscall with MSR_EE inconditionaly set
  powerpc/32: Enter exceptions with MSR_EE unset
  powerpc/32: get rid of COPY_EE in exception entry
  powerpc: Fix 32-bit handling of MSR_EE on exceptions
  powerpc/32: implement fast entry for syscalls on non BOOKE
  powerpc/32: implement fast entry for syscalls on BOOKE
  powerpc/32: don't do syscall stuff in transfer_to_handler
  powerpc/32: Don't add dummy frames when calling trace_hardirqs_on/off

 arch/powerpc/kernel/entry_32.S       | 153 +++++++++++++-------------
 arch/powerpc/kernel/head_32.S        | 170 +++++++----------------------
 arch/powerpc/kernel/head_32.h        | 203 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/head_40x.S       | 152 +++++++-------------------
 arch/powerpc/kernel/head_44x.S       |   9 +-
 arch/powerpc/kernel/head_8xx.S       | 133 ++++-------------------
 arch/powerpc/kernel/head_booke.h     | 131 +++++++++++++++++-----
 arch/powerpc/kernel/head_fsl_booke.S |  29 +++--
 arch/powerpc/kernel/traps.c          |   8 ++
 9 files changed, 508 insertions(+), 480 deletions(-)
 create mode 100644 arch/powerpc/kernel/head_32.h

-- 
2.13.3

