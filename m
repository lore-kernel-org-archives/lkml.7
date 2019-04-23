Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDB6C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309C120B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TEhCVyzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbfDWDWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:22:36 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:57403 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbfDWDWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:22:35 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x3N3L8LB031384;
        Tue, 23 Apr 2019 12:21:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x3N3L8LB031384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555989669;
        bh=ZvmhJfQSmFExJTwu9DlsNkRFBkG2esWOCzRYnfleGSg=;
        h=From:To:Cc:Subject:Date:From;
        b=TEhCVyzRQIgZG/DnBdcjD2rEtIj55krqVUdqDQrqgQpeNHlxiI9gGQJEQ+SKatXI4
         dZ4d2uAkxwxSl2278Ri7iWgTdafb76wVFBE/LBPln70lB/adK4yAbJTTqogp/dZZRq
         fcCeNKeosQdNO40jcOyxlsN+kx6KwTIkIr4gEdrlCY1iV57JFcR5DNIaZJyHtmg8kw
         zUdk7imjG/4NOqvqi1PXQLQCSM4CRfSCpEOhdwVXeMs+RkpAXCRsOnPpkrkOeIuiTv
         Ziqjr6CvC2eN24n0IJfNLHZrDkBHiTUFUlyUjHRufPn+DjtxiJH642RSu6A6b3qJlN
         OfHtjNfgmwG/g==
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
        Mathieu Malaterre <malat@debian.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 00/10] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
Date:   Tue, 23 Apr 2019 12:20:56 +0900
Message-Id: <20190423032106.11960-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Major changes in v3:
 - Fix link error for arch/mips/configs/ci20_defconfig

Major changes in v2:
 - Eliminate more errors and warnings
 - Delete 'depends on !MIPS'
 - Split into separate patches

Masahiro Yamada (10):
  arm64: mark (__)cpus_have_const_cap as __always_inline
  MIPS: mark mult_sh_align_mod() as __always_inline
  s390/cpacf: mark scpacf_query() as __always_inline
  mtd: rawnand: vf610_nfc: add initializer to avoid
    -Wmaybe-uninitialized
  MIPS: mark __fls() and __ffs() as __always_inline
  ARM: mark setup_machine_tags() stub as __init __noreturn
  powerpc/prom_init: mark prom_getprop() and prom_getproplen() as __init
  powerpc/mm/radix: mark __radix__flush_tlb_range_psize() as
    __always_inline
  powerpc/mm/radix: mark as __tlbie_pid() and friends as__always_inline
  compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING

 arch/arm/kernel/atags.h             |  2 +-
 arch/arm64/include/asm/cpufeature.h |  4 ++--
 arch/mips/include/asm/bitops.h      |  4 ++--
 arch/mips/kernel/cpu-bugs64.c       |  4 ++--
 arch/powerpc/kernel/prom_init.c     |  6 +++---
 arch/powerpc/mm/tlb-radix.c         | 12 ++++++------
 arch/s390/include/asm/cpacf.h       |  2 +-
 arch/x86/Kconfig                    |  3 ---
 arch/x86/Kconfig.debug              | 14 --------------
 drivers/mtd/nand/raw/vf610_nfc.c    |  2 +-
 include/linux/compiler_types.h      |  3 +--
 lib/Kconfig.debug                   | 14 ++++++++++++++
 12 files changed, 33 insertions(+), 37 deletions(-)

-- 
2.17.1

