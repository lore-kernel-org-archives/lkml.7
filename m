Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF7BC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711B3222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LZ5W5Sbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfDSSWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:22:23 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:19737 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfDSSWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:22:20 -0400
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-08.nifty.com with ESMTP id x3J9nRpa012747;
        Fri, 19 Apr 2019 18:49:27 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x3J9mDiR012304;
        Fri, 19 Apr 2019 18:48:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x3J9mDiR012304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555667303;
        bh=may15rFpYiMjCv7Gx5d6Hnsbnx9+yCkdoijkrZ87+8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZ5W5SbtA5B2oGV0h5lwznB9JKhiilqmHNUldJhrjUQTSZY9vxebvU3V7wW56NkbJ
         Rnc6SQfGcsB1yMXTT+NdVLIhmHL7U1Z4tH9i+YXCl33cqFQ7SJd9WsB/oZJXRgygOI
         YKzZqdsmMW2A3uMDwjeooQdN420x/jTTBNIWOjFmEDNg1gF3/PyTiLDOXwX8pu7ByU
         lEDznHHJXJN1BHX3WLczN7spS778ABE8MnFmpxa63+ccInS3ZWvDEHfu0ez4+mDf8B
         8Xtzq+72fPoa1Remq9MZ6OTJJTm0MBQ7h8USCIRhuHh5oWB6nWd5uVtKxJPxM9yyu6
         FUEmIviUowLIg==
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
Subject: [PATCH v2 06/11] MIPS: mark __fls() as __always_inline
Date:   Fri, 19 Apr 2019 18:47:49 +0900
Message-Id: <20190419094754.24667-7-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190419094754.24667-1-yamada.masahiro@socionext.com>
References: <20190419094754.24667-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for mips, the following errors are reported:

arch/mips/mm/sc-mips.o: In function `mips_sc_prefetch_enable.part.2':
sc-mips.c:(.text+0x98): undefined reference to `mips_gcr_base'
sc-mips.c:(.text+0x9c): undefined reference to `mips_gcr_base'
sc-mips.c:(.text+0xbc): undefined reference to `mips_gcr_base'
sc-mips.c:(.text+0xc8): undefined reference to `mips_gcr_base'
sc-mips.c:(.text+0xdc): undefined reference to `mips_gcr_base'
arch/mips/mm/sc-mips.o:sc-mips.c:(.text.unlikely+0x44): more undefined references to `mips_gcr_base'

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - new patch

 arch/mips/include/asm/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 830c93a010c3..6a26ead1c2b6 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -482,7 +482,7 @@ static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *
  * Return the bit position (0..63) of the most significant 1 bit in a word
  * Returns -1 if no 1 bit exists
  */
-static inline unsigned long __fls(unsigned long word)
+static __always_inline unsigned long __fls(unsigned long word)
 {
 	int num;
 
-- 
2.17.1

