Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99324C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684FF205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="BqlEU3+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfCEVSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:18:17 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:52246 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbfCEVSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:18:16 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44DV9f5Cvwz9v6LQ;
        Tue,  5 Mar 2019 22:18:14 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=BqlEU3+v; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XKhztWVu6jzK; Tue,  5 Mar 2019 22:18:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44DV9f46T2z9v6HM;
        Tue,  5 Mar 2019 22:18:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1551820694; bh=U/avHXAM61Oykdu9eXfUdeCw0IRrsRItgwl63tp+/+c=;
        h=From:Subject:To:Cc:Date:From;
        b=BqlEU3+vir/sKgFzI59VGajtmT0U4BJtewHrOZT1bun7MUCB88pt2XQMgn7JLwJVO
         0xHT/WypDkko1Y2LfPhf4MB2JpSKOKkTLdrAqOH/8QE5kk2uz4Mf7gOElQlCZW8DyL
         NVP7WdPcnq6rW9KVKiIzvo4iNDtqIojcrmJI7Zdo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B79388B860;
        Tue,  5 Mar 2019 22:18:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Q_YrwuO711Or; Tue,  5 Mar 2019 22:18:14 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 871B28B83A;
        Tue,  5 Mar 2019 22:18:14 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id B526A6F8CD; Tue,  5 Mar 2019 21:18:13 +0000 (UTC)
Message-Id: <cover.1551820474.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/7] Kernel Userspace protection for PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ruscur@russell.cc
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  5 Mar 2019 21:18:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series intend to implement Kernel Userspace protection for PPC32.
It comes on top of the v4 series for Radix.

Christophe Leroy (6):
  powerpc/8xx: Only define APG0 and APG1
  powerpc/8xx: Add Kernel Userspace Execution Prevention
  powerpc/32: Prepare for Kernel Userspace Access Protection
  powerpc/8xx: Add Kernel Userspace Access Protection
  powerpc/book3s32: Prepare Kernel Userspace Access Protection
  powerpc/book3s32: Implement Kernel Userspace Access Protection

Russell Currey (1):
  powerpc/64s: Implement KUAP for Radix MMU (SQUASH)

 Documentation/admin-guide/kernel-parameters.txt |  4 +-
 arch/powerpc/include/asm/book3s/32/kup.h        | 96 +++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/32/mmu-hash.h   |  4 ++
 arch/powerpc/include/asm/book3s/64/kup-radix.h  | 79 ++++++++++++++++++++
 arch/powerpc/include/asm/exception-64s.h        |  2 +
 arch/powerpc/include/asm/feature-fixups.h       |  3 +
 arch/powerpc/include/asm/futex.h                |  4 ++
 arch/powerpc/include/asm/kup.h                  | 72 +++++++++++++++++++
 arch/powerpc/include/asm/mmu.h                  | 10 ++-
 arch/powerpc/include/asm/nohash/32/kup-8xx.h    | 52 ++++++++++++++
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h    | 26 +++++--
 arch/powerpc/include/asm/processor.h            |  3 +
 arch/powerpc/include/asm/ptrace.h               | 11 ++-
 arch/powerpc/include/asm/reg.h                  |  1 +
 arch/powerpc/include/asm/uaccess.h              | 38 +++++++---
 arch/powerpc/kernel/asm-offsets.c               |  7 ++
 arch/powerpc/kernel/entry_32.S                  | 16 +++--
 arch/powerpc/kernel/entry_64.S                  | 22 +++++-
 arch/powerpc/kernel/exceptions-64s.S            |  3 +
 arch/powerpc/kernel/head_32.S                   | 35 ++++++---
 arch/powerpc/kernel/idle_book3s.S               | 39 ++++++++++
 arch/powerpc/kernel/setup_64.c                  | 10 +++
 arch/powerpc/lib/checksum_wrappers.c            |  4 ++
 arch/powerpc/lib/code-patching.c                |  4 +-
 arch/powerpc/mm/8xx_mmu.c                       | 24 +++++++
 arch/powerpc/mm/fault.c                         | 28 +++++---
 arch/powerpc/mm/hash_low_32.S                   |  6 +-
 arch/powerpc/mm/init-common.c                   | 26 +++++++
 arch/powerpc/mm/init_32.c                       |  3 +
 arch/powerpc/mm/pgtable-radix.c                 | 31 +++++++-
 arch/powerpc/mm/pkeys.c                         |  1 +
 arch/powerpc/mm/ppc_mmu_32.c                    | 10 +++
 arch/powerpc/platforms/Kconfig.cputype          | 36 ++++++++++
 33 files changed, 657 insertions(+), 53 deletions(-)
 create mode 100644 arch/powerpc/include/asm/book3s/32/kup.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/kup-radix.h
 create mode 100644 arch/powerpc/include/asm/kup.h
 create mode 100644 arch/powerpc/include/asm/nohash/32/kup-8xx.h

-- 
2.13.3

