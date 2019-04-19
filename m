Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527D8C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201F220449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XuDk5pY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfDSSbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:31:03 -0400
Received: from condef-06.nifty.com ([202.248.20.71]:25329 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfDSSbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:31:02 -0400
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-06.nifty.com with ESMTP id x3J9nQ9e029017;
        Fri, 19 Apr 2019 18:49:26 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x3J9mDiL012304;
        Fri, 19 Apr 2019 18:48:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x3J9mDiL012304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555667295;
        bh=KIJsj9BjbJCKV5d3TQJAGFjQI0UA9lTr5KAl3uaBdzI=;
        h=From:To:Cc:Subject:Date:From;
        b=XuDk5pY0o90ECZwUqGP84ppzgA6XEFU/Q8b2Wpng7fY2TlkWcTHQKCAwfKS3dEkoJ
         /wM2hrBugVAd8GDB21Y8r0JmiV1i/gqCD2bM8RPKqcOV7FCV/a2Iu+967c3DkrjItY
         prjosvSKi8xi6N93D24mp+8Bpa0LsxVR4uwfvLM6ReLlODp1Xe6kOsbWU9InjeslPy
         yjlzg2YpxqNZbvyhGr5IALaj3VQob8rd8k4t/yp4OMWFo109A06sOFx+WGB5wXNN+x
         SclFXVMgtA/pdCK17FEbRqdD8lS8YsTeJeaU6jfT33kteQIcqOupLrNvGeHjD25cCx
         DUnO5stjBOW0A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 00/11] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
Date:   Fri, 19 Apr 2019 18:47:43 +0900
Message-Id: <20190419094754.24667-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Major changes in v2:
 - Eliminate more errors and warnings
 - Delete 'depends on !MIPS'
 - Split into separate patches

Arnd Bergmann (1):
  ARM: prevent tracing IPI_CPU_BACKTRACE

Masahiro Yamada (10):
  arm64: mark (__)cpus_have_const_cap as __always_inline
  MIPS: mark mult_sh_align_mod() as __always_inline
  s390/cpacf: mark scpacf_query() as __always_inline
  mtd: rawnand: vf610_nfc: add initializer to avoid
    -Wmaybe-uninitialized
  MIPS: mark __fls() as __always_inline
  ARM: mark setup_machine_tags() stub as __init __noreturn
  powerpc/prom_init: mark prom_getprop() and prom_getproplen() as __init
  powerpc/mm/radix: mark __radix__flush_tlb_range_psize() as
    __always_inline
  powerpc/mm/radix: mark as __tlbie_pid() and friends as__always_inline
  compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING

 arch/arm/include/asm/hardirq.h      |  1 +
 arch/arm/kernel/atags.h             |  2 +-
 arch/arm/kernel/smp.c               |  6 +++++-
 arch/arm64/include/asm/cpufeature.h |  4 ++--
 arch/mips/include/asm/bitops.h      |  2 +-
 arch/mips/kernel/cpu-bugs64.c       |  4 ++--
 arch/powerpc/kernel/prom_init.c     |  6 +++---
 arch/powerpc/mm/tlb-radix.c         | 12 ++++++------
 arch/s390/include/asm/cpacf.h       |  2 +-
 arch/x86/Kconfig                    |  3 ---
 arch/x86/Kconfig.debug              | 14 --------------
 drivers/mtd/nand/raw/vf610_nfc.c    |  2 +-
 include/linux/compiler_types.h      |  3 +--
 lib/Kconfig.debug                   | 14 ++++++++++++++
 14 files changed, 38 insertions(+), 37 deletions(-)

-- 
2.17.1

