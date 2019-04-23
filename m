Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471E3C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168B620B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="I0CioBDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbfDWDWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:22:53 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:57830 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbfDWDWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:22:50 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x3N3L8LE031384;
        Tue, 23 Apr 2019 12:21:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x3N3L8LE031384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555989672;
        bh=WxeGjpwIMtUh4NapkUcSoliRiI5DD/Rdf3zwHkix9l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I0CioBDTkc1GHuaVSUtq8jVEnHXnq1hGY5fDTmiT2yZDSu6CTfVaaVXOU2ocZq0yd
         yau4zui0pA9Gklyfdi8o/AJZ0Ym0WBMT+wi/ZHIchu3uqVfAfpQFmT6dC6tCX/Ecrl
         cvxzp/A3CvHBT2XR5HyFgtORaimjq81j8GYVV04h9nnnWkEIg7LZQoh4wdOFskjT2d
         5eeCSxlqfwdPytf+3xnWAoqknX7CikjegNqgQuyxt3anZOWoLqsxIgU6AOl4i9IKb9
         pVYIeb0NCpH/BeB18yE5PgIoZGN8m8fwFMGMGGUgfjYtgwRleo8ZKHDsJzkNe/clDM
         UU4f0eSYQFKRQ==
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
Subject: [PATCH v3 03/10] s390/cpacf: mark scpacf_query() as __always_inline
Date:   Tue, 23 Apr 2019 12:20:59 +0900
Message-Id: <20190423032106.11960-4-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423032106.11960-1-yamada.masahiro@socionext.com>
References: <20190423032106.11960-1-yamada.masahiro@socionext.com>
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

