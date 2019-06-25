Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F65C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD9320644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="lpQlvkR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbfFYK6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:58:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39904 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbfFYK6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:58:10 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45Y36P3KFfz9v17f;
        Tue, 25 Jun 2019 12:58:05 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=lpQlvkR/; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id qBNHEZMgdSYN; Tue, 25 Jun 2019 12:58:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45Y36P2Dfdz9v17d;
        Tue, 25 Jun 2019 12:58:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1561460285; bh=p3eeTI+CLV4Cw6857FHqOMSwyRSfA6hKAcK47GIkkNM=;
        h=From:Subject:To:Cc:Date:From;
        b=lpQlvkR/CoE/ae6r+0T0Jo9g702yhrroizh8/5Tz0w/QsB5r150WhEt4jwdRFfk2g
         B9ODTaVkDUiuFYojZjc2e4juyELFiQwMvMgr+W4M1xZLsgPFEKkhWSaTloa+2FQ3lS
         8cWc10TtgUtwT7lHaaZZnauFDaucfbzUReY2zAqU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6AB8A8B879;
        Tue, 25 Jun 2019 12:58:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Er14fu8irgrt; Tue, 25 Jun 2019 12:58:06 +0200 (CEST)
Received: from pc17473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 39E2C8B874;
        Tue, 25 Jun 2019 12:58:06 +0200 (CEST)
Received: by pc17473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DDB7F68E1B; Tue, 25 Jun 2019 10:58:05 +0000 (UTC)
Message-Id: <cover.1561459983.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 00/13] Reduce ifdef mess in ptrace
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 25 Jun 2019 10:58:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this series is to reduce the amount of #ifdefs
in ptrace.c

This is a first try. Most of it is done, there are still some #ifdefs that
could go away.

Please comment and tell whether it is worth continuing in that direction.

Christophe Leroy (13):
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
  powerpc/hw_breakpoint: move instruction stepping out of
    hw_breakpoint_handler()

 arch/powerpc/include/asm/ptrace.h           |    9 +-
 arch/powerpc/include/uapi/asm/ptrace.h      |   12 +-
 arch/powerpc/kernel/Makefile                |    7 +-
 arch/powerpc/kernel/hw_breakpoint.c         |   76 +-
 arch/powerpc/kernel/ptrace.c                | 3402 ---------------------------
 arch/powerpc/kernel/ptrace/Makefile         |   20 +
 arch/powerpc/kernel/ptrace/ptrace-adv.c     |  511 ++++
 arch/powerpc/kernel/ptrace/ptrace-altivec.c |  151 ++
 arch/powerpc/kernel/ptrace/ptrace-decl.h    |  150 ++
 arch/powerpc/kernel/ptrace/ptrace-noadv.c   |  291 +++
 arch/powerpc/kernel/ptrace/ptrace-novsx.c   |   83 +
 arch/powerpc/kernel/ptrace/ptrace-spe.c     |   94 +
 arch/powerpc/kernel/ptrace/ptrace-tm.c      |  877 +++++++
 arch/powerpc/kernel/ptrace/ptrace-view.c    |  966 ++++++++
 arch/powerpc/kernel/ptrace/ptrace-vsx.c     |  177 ++
 arch/powerpc/kernel/ptrace/ptrace.c         |  430 ++++
 arch/powerpc/kernel/{ => ptrace}/ptrace32.c |    0
 17 files changed, 3810 insertions(+), 3446 deletions(-)
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

