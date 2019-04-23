Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3908EC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F416220811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JRgS6Tvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbfDWDwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:52:24 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:38300 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfDWDv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:51:26 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x3N3o2cC023044;
        Tue, 23 Apr 2019 12:50:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x3N3o2cC023044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555991409;
        bh=WxeGjpwIMtUh4NapkUcSoliRiI5DD/Rdf3zwHkix9l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRgS6TvykK2VfzGREOAHkRyhk2HU8HY8tH8Qv2cO2WA0R9pxRuSnRL2l2nwF2rSl2
         uFBXOndu6Yxp30Ok+h6kuTyz1lG3PihD63BocSfvTU5n31Jo+S9vy3jMsA6nTJtEZs
         vm6Y9xJflB9iaVlWxhtuLPtePohZQGxBk6DAICJ/P8KdMoexqYceDJBLIBPcwtsL5p
         R/jAaPfkqPKMSUUT42VfBdxfmrbSbnp+alKzF5A7WCi2a92an7hfPqXb6HgnjbDNNN
         QjXdLJUq/2K/5VL0Ur5Ot1MGSdmgWZkTb+J72txXZMzvax7raUOfVsy5FUhwCuulkR
         uyV+27X02YYgg==
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
Subject: [RESEND PATCH v3 04/11] s390/cpacf: mark scpacf_query() as __always_inline
Date:   Tue, 23 Apr 2019 12:49:52 +0900
Message-Id: <20190423034959.13525-5-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423034959.13525-1-yamada.masahiro@socionext.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for s390, the following error is reported:

In file included from arch/s390/crypto/des_s390.c:19:
./arch/s390/include/asm/cpacf.h: In function 'cpacf_query':
./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably doesn't match constraints
  asm volatile(
  ^~~
./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'asm'

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - split into a separate patch

 arch/s390/include/asm/cpacf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index 3cc52e37b4b2..f316de40e51b 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -202,7 +202,7 @@ static inline int __cpacf_check_opcode(unsigned int opcode)
 	}
 }
 
-static inline int cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
+static __always_inline int cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
 {
 	if (__cpacf_check_opcode(opcode)) {
 		__cpacf_query(opcode, mask);
-- 
2.17.1

