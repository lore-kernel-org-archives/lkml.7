Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E7DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A639823400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="B+jtpOPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbfHVQeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:34:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19398 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730610AbfHVQeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:34:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46DqqC6cmCz9v0d2;
        Thu, 22 Aug 2019 18:33:59 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=B+jtpOPd; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oQlzQ3FpwLRp; Thu, 22 Aug 2019 18:33:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46DqqC5b0Dz9v0d4;
        Thu, 22 Aug 2019 18:33:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566491639; bh=Kdm5BN3MSh4jmd1gvQf5NOGQGIfy+jba9n23a8nT9D0=;
        h=From:Subject:To:Cc:Date:From;
        b=B+jtpOPdcqq2126W9BjzD62GByRF8IzigU7Zz5okxFmURHa5u7ptX6FduM8M41k6K
         yhP2L7vwHc1efdFz1kAzdzewmKxyTk+gyY6eXycNbAhrlLbguzq+y3W+vyqJTHYZSg
         s2fc3l2KFTtQSVmsTQCpv3TkesPfx1VOJV0mMDaA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 766FF8B84C;
        Thu, 22 Aug 2019 18:34:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WsNVxstKHuCt; Thu, 22 Aug 2019 18:34:01 +0200 (CEST)
Received: from pc16032vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 39D158B81D;
        Thu, 22 Aug 2019 18:34:01 +0200 (CEST)
Received: by pc16032vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DDCD66B730; Thu, 22 Aug 2019 16:34:00 +0000 (UTC)
Message-Id: <cover.1566491310.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 0/8] powerpc/vdso32 enhancement and optimisation
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Aug 2019 16:34:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series:
- adds getcpu()
- adds coarse clocks in clock_gettime
- fixes and adds all clocks in clock_getres
- optimises the retrieval of the datapage address
- optimises the cache functions

It puts together the three patches sent out earlier allthought they
were not presented as a series, hence the 'v2' tag for now.

v2:
- Used named labels in patch 2
- Added patch from Vincenzo to fix clock_getres() (patch 3)
- Removed unnecessary label in patch 4 as suggested by Segher
- Added patches 5 to 8

Christophe Leroy (8):
  powerpc/32: Add VDSO version of getcpu
  powerpc/vdso32: Add support for CLOCK_{REALTIME/MONOTONIC}_COARSE
  powerpc: Fix vDSO clock_getres()
  powerpc/vdso32: inline __get_datapage()
  powerpc/vdso32: Don't read cache line size from the datapage on PPC32.
  powerpc/vdso32: use LOAD_REG_IMMEDIATE()
  powerpc/vdso32: implement clock_getres entirely
  powerpc/vdso32: miscellaneous optimisations

 arch/powerpc/include/asm/vdso.h           |   2 +
 arch/powerpc/include/asm/vdso_datapage.h  |   6 +-
 arch/powerpc/kernel/asm-offsets.c         |   7 +-
 arch/powerpc/kernel/head_32.h             |  13 ++++
 arch/powerpc/kernel/head_booke.h          |  11 +++
 arch/powerpc/kernel/time.c                |   1 +
 arch/powerpc/kernel/vdso.c                |   5 --
 arch/powerpc/kernel/vdso32/Makefile       |   4 +-
 arch/powerpc/kernel/vdso32/cacheflush.S   |  33 ++++++--
 arch/powerpc/kernel/vdso32/datapage.S     |  32 ++------
 arch/powerpc/kernel/vdso32/datapage.h     |  11 +++
 arch/powerpc/kernel/vdso32/getcpu.S       |  13 +++-
 arch/powerpc/kernel/vdso32/gettimeofday.S | 125 +++++++++++++++++++++---------
 arch/powerpc/kernel/vdso32/vdso32.lds.S   |   2 -
 arch/powerpc/kernel/vdso64/gettimeofday.S |   7 +-
 15 files changed, 183 insertions(+), 89 deletions(-)
 create mode 100644 arch/powerpc/kernel/vdso32/datapage.h

-- 
2.13.3

