Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32EAC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C954020828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 15:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="U35KPiat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfF1Pry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 11:47:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57897 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfF1Prx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:47:53 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45b1PK5ffXzB09ZP;
        Fri, 28 Jun 2019 17:47:49 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=U35KPiat; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id M7G8GO5ZVxxo; Fri, 28 Jun 2019 17:47:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45b1PK4RsqzB09ZN;
        Fri, 28 Jun 2019 17:47:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561736869; bh=OtgqE3CIuXfno8vKIOCfy9CK71bNHwOgFmM5CWrbuH0=;
        h=From:Subject:To:Cc:Date:From;
        b=U35KPiat7UOwS9Ud+WYA0tb81Xp3wWVlM0UaCT8cLhnwNLiZuFIFxd91a/pgBqsVs
         OsRHvfI0OHF/fKJuKVJXJLlskEj+Ixz8M5+Q1PK4efGjbfU5oboGY0+5MZ1XL8vk1P
         PhrxVuNPZuG2cnQm9H/BX2u/aFKH18qb7Gp0vi5g=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ADF168B975;
        Fri, 28 Jun 2019 17:47:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PNO5VCEVwrie; Fri, 28 Jun 2019 17:47:50 +0200 (CEST)
Received: from localhost.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EC50C8B955;
        Fri, 28 Jun 2019 17:47:49 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 9B11468DBC; Fri, 28 Jun 2019 15:47:49 +0000 (UTC)
Message-Id: <cover.1561735587.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 00/12] Reduce ifdef mess in ptrace
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 28 Jun 2019 15:47:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this series is to reduce the amount of #ifdefs
in ptrace.c

This is a first try. Most of it is done, there are still some #ifdefs that
could go away.

Please comment and tell whether it is worth continuing in that direction.

v2:
- Fixed several build failures. Now builts cleanly on kisskb, see http://kisskb.ellerman.id.au/kisskb/head/840e53cf913d6096dd60181a085f102c85d6e526/
- Droped last patch which is not related to ptrace and can be applies independently.

Christophe Leroy (12):
  powerpc: move ptrace into a subdirectory.
  powerpc/ptrace: drop unnecessary #ifdefs CONFIG_PPC64
  powerpc/ptrace: drop PARAMETER_SAVE_AREA_OFFSET
  powerpc/ptrace: split out VSX related functions.
  powerpc/ptrace: split out ALTIVEC related functions.
  powerpc/ptrace: split out SPE related functions.
  powerpc/ptrace: split out TRANSACTIONAL_MEM related functions.
  powerpc/ptrace: move register viewing functions out of ptrace.c
  powerpc/ptrace: split out ADV_DEBUG_REGS related functions.
  powerpc/ptrace: create ptrace_get_debugreg()
  powerpc/ptrace: create ppc_gethwdinfo()
  powerpc/ptrace: move ptrace_triggered() into hw_breakpoint.c

 arch/powerpc/include/asm/ptrace.h           |    9 +-
 arch/powerpc/include/uapi/asm/ptrace.h      |   12 +-
 arch/powerpc/kernel/Makefile                |    7 +-
 arch/powerpc/kernel/hw_breakpoint.c         |   16 +
 arch/powerpc/kernel/ptrace.c                | 3402 ---------------------------
 arch/powerpc/kernel/ptrace/Makefile         |   20 +
 arch/powerpc/kernel/ptrace/ptrace-adv.c     |  511 ++++
 arch/powerpc/kernel/ptrace/ptrace-altivec.c |  151 ++
 arch/powerpc/kernel/ptrace/ptrace-decl.h    |  184 ++
 arch/powerpc/kernel/ptrace/ptrace-noadv.c   |  291 +++
 arch/powerpc/kernel/ptrace/ptrace-novsx.c   |   83 +
 arch/powerpc/kernel/ptrace/ptrace-spe.c     |   92 +
 arch/powerpc/kernel/ptrace/ptrace-tm.c      |  879 +++++++
 arch/powerpc/kernel/ptrace/ptrace-view.c    |  953 ++++++++
 arch/powerpc/kernel/ptrace/ptrace-vsx.c     |  177 ++
 arch/powerpc/kernel/ptrace/ptrace.c         |  430 ++++
 arch/powerpc/kernel/{ => ptrace}/ptrace32.c |    0
 17 files changed, 3798 insertions(+), 3419 deletions(-)
 delete mode 100644 arch/powerpc/kernel/ptrace.c
 create mode 100644 arch/powerpc/kernel/ptrace/Makefile
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-adv.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-altivec.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-decl.h
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-noadv.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-novsx.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-spe.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-tm.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-view.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace-vsx.c
 create mode 100644 arch/powerpc/kernel/ptrace/ptrace.c
 rename arch/powerpc/kernel/{ => ptrace}/ptrace32.c (100%)

-- 
2.13.3

