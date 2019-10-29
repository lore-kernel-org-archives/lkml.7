Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9777ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699A0208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ZnRDMih+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733251AbfJ2JxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:53:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:27101 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733128AbfJ2JxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:53:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 472RjF0jdCz9tyh0;
        Tue, 29 Oct 2019 10:53:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ZnRDMih+; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id FegPIguYciNV; Tue, 29 Oct 2019 10:53:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 472RjD6kRQz9tygy;
        Tue, 29 Oct 2019 10:53:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1572342784; bh=P+2AjEXR23xT7K0XGXHw5fnf3v2rAlKDulVBaGhTKhM=;
        h=From:Subject:To:Cc:Date:From;
        b=ZnRDMih+ttNEq1o2wyXRU7OxSGZg8AjIKFErAb9l3N2ChbWi1aGZQOD2aSdeca1IK
         +/ahq0rZtTs59SOA6/7ed/H2QvrdUqXIaN1egiTmUnnycNnJhNg3k1ucCeHyZ4dWtD
         RuVMGDC2CIbtNDRdKFLQBrEb7+x7XI4nQ4Bzy8JA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ED2758B84C;
        Tue, 29 Oct 2019 10:53:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qt91em1JhDRG; Tue, 29 Oct 2019 10:53:05 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BAD0F8B755;
        Tue, 29 Oct 2019 10:53:05 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 4B98C6B6FD; Tue, 29 Oct 2019 09:53:05 +0000 (UTC)
Message-Id: <cover.1572342582.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 0/8] powerpc/vdso32 enhancement and optimisation
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 29 Oct 2019 09:53:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series:
- adds getcpu() on non SMP ppc32
- adds coarse clocks in clock_gettime
- fixes and adds all clocks in clock_getres
- optimises the retrieval of the datapage address
- optimises the cache functions

v3:
- Dropped the 'fast syscall' hack for getcpu() on SMP.
- Moved get_datapage macro into asm/vdso_datapage.h so that it can be used on PPC64 as well.

v2:
- Used named labels in patch 2
- Added patch from Vincenzo to fix clock_getres() (patch 3)
- Removed unnecessary label in patch 4 as suggested by Segher
- Added patches 5 to 8

Christophe Leroy (8):
  powerpc/32: Add VDSO version of getcpu on non SMP
  powerpc/vdso32: Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE
  powerpc: Fix vDSO clock_getres()
  powerpc/vdso32: inline __get_datapage()
  powerpc/vdso32: Don't read cache line size from the datapage on PPC32.
  powerpc/vdso32: use LOAD_REG_IMMEDIATE()
  powerpc/vdso32: implement clock_getres entirely
  powerpc/vdso32: miscellaneous optimisations

 arch/powerpc/include/asm/vdso_datapage.h  |  16 +++-
 arch/powerpc/kernel/asm-offsets.c         |   7 +-
 arch/powerpc/kernel/time.c                |   1 +
 arch/powerpc/kernel/vdso.c                |   5 --
 arch/powerpc/kernel/vdso32/Makefile       |   4 +-
 arch/powerpc/kernel/vdso32/cacheflush.S   |  32 ++++++--
 arch/powerpc/kernel/vdso32/datapage.S     |  31 +-------
 arch/powerpc/kernel/vdso32/getcpu.S       |  23 +++++-
 arch/powerpc/kernel/vdso32/gettimeofday.S | 124 +++++++++++++++++++++---------
 arch/powerpc/kernel/vdso32/vdso32.lds.S   |   2 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S |   7 +-
 11 files changed, 164 insertions(+), 88 deletions(-)

-- 
2.13.3

