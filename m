Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54721C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2901620B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HhguvRQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbfDWDWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:22:41 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:57404 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfDWDWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:22:35 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x3N3L8LC031384;
        Tue, 23 Apr 2019 12:21:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x3N3L8LC031384
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555989670;
        bh=bSpCfUAcyt+UjPMgYyZQmseLNPkdMgHIhxbhwQzsBmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HhguvRQPBV04y4e8uTU/yCcJnlGpGZVqQz/SkpmVCXuXmNhTv6CN/+Xsf+AqSUWE2
         DEO02/iGxqciaWSLDfzKCt8677bXXPM5n9VuxPOGV4fFetXdXEHpqPCfJ9naM3n94g
         xyIwH5yGiExYosKXtbvvhn0/xlHklTGGKvdmTCjO8WdctGc5UKfPD4E2Hy1U59F2vN
         279wTN33gi8iLgl/pY7I1JYAC1bw/Ag1dTa0cRby1+pShWAWQ6HPTY3P0BR311/vuc
         MEYtE7GpmVS8PX2kMpLhDn8gZ6Q+gThMCBHQmZmZtKRVcV5kbwRMDkJXnAqUnurOGi
         SJiKOWS4C8JJA==
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
Subject: [PATCH v3 01/10] arm64: mark (__)cpus_have_const_cap as __always_inline
Date:   Tue, 23 Apr 2019 12:20:57 +0900
Message-Id: <20190423032106.11960-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423032106.11960-1-yamada.masahiro@socionext.com>
References: <20190423032106.11960-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
place. We need to eliminate potential issues beforehand.

If it is enabled for arm64, the following errors are reported:

In file included from ././include/linux/compiler_types.h:68,
                 from <command-line>:
./arch/arm64/include/asm/jump_label.h: In function 'cpus_have_const_cap':
./include/linux/compiler-gcc.h:120:38: warning: asm operand 0 probably doesn't match constraints
 #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                      ^~~
./arch/arm64/include/asm/jump_label.h:32:2: note: in expansion of macro 'asm_volatile_goto'
  asm_volatile_goto(
  ^~~~~~~~~~~~~~~~~
./include/linux/compiler-gcc.h:120:38: error: impossible constraint in 'asm'
 #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
                                      ^~~
./arch/arm64/include/asm/jump_label.h:32:2: note: in expansion of macro 'asm_volatile_goto'
  asm_volatile_goto(
  ^~~~~~~~~~~~~~~~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3: None
Changes in v2:
  - split into a separate patch

 arch/arm64/include/asm/cpufeature.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index e505e1fbd2b9..77d1aa57323e 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -406,7 +406,7 @@ static inline bool cpu_have_feature(unsigned int num)
 }
 
 /* System capability check for constant caps */
-static inline bool __cpus_have_const_cap(int num)
+static __always_inline bool __cpus_have_const_cap(int num)
 {
 	if (num >= ARM64_NCAPS)
 		return false;
@@ -420,7 +420,7 @@ static inline bool cpus_have_cap(unsigned int num)
 	return test_bit(num, cpu_hwcaps);
 }
 
-static inline bool cpus_have_const_cap(int num)
+static __always_inline bool cpus_have_const_cap(int num)
 {
 	if (static_branch_likely(&arm64_const_caps_ready))
 		return __cpus_have_const_cap(num);
-- 
2.17.1

