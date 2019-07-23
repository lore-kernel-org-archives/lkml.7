Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3925AC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09000229F3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DVedO5PJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391898AbfGWUuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:50:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39075 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732877AbfGWUuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:50:22 -0400
Received: by mail-qk1-f193.google.com with SMTP id w190so32126914qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 13:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CmnfNtgiMAfp2Il+YyakJvBaajWojL1MC+DBGGpZ1g4=;
        b=DVedO5PJpKlFqbEBexij3Upmidl5volPSXQLTD9vV5mbxSTvz/BRl7lHvCFJ8+E8z1
         C9fxnNKFiuZwFWeOEiczxjJtuHGyulMOwUbUcgL3iQBY/C6IL4C6/jHTaTl6xflT4VSH
         NzKbWmlvVp4qn5Znx8rDhF8H3niaNCuFeIYNyDYJmi2m/N0vp23/SuL0cmht7/C/oqaX
         wFcG4ADt0Q/ZgVCoDGHY4yE1RHh/jUSKCYx1aM/VeHF5uK6TsT0n1hNRVHL40HGhbkXV
         I8+IRY9fKorWggN2FebwoNCsrBdlGM6KhvDY7kDuxClBGqT9qmTknRAEOxT2O8v0+Ftc
         KT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CmnfNtgiMAfp2Il+YyakJvBaajWojL1MC+DBGGpZ1g4=;
        b=GphOIX9xkt1zwifnuLjPzfYa3PdAhQBdCoOuPX/lYcjWQvQZgLGIJznVfeMJsFDPho
         /1DjbHnt4zObJWs59hRZTiHMLlS0JDO4kh/pRLWTaue6AmxL9HxsyxudDzzjUCMXdemK
         f0wPO6uiJfWG4syYbug6d/fTZ39k34eH7Xv1C+hjZ3MOd+0epgqmCNkuISVdoxRAf2zW
         B1IyzR9KciQAAG3091mT9xHLPN1NgkWjSVsJcOI97pRr5rK1LmbvsFH1YTwGofC3tMKw
         Y+hCJcZ78vUwDu9lTgtVWTA4zbuNpHLbvlVyOD+CsVwVMcUk/civbcBn5sfyAPjvUkgk
         Qf5w==
X-Gm-Message-State: APjAAAWDUdYSFsW+MYaQWsOA4KP5Y+2d9Yf5Wq+2WIPkftXiolPTrL1M
        hAqFSZmzXPRMezEXVbfjTzKK9w==
X-Google-Smtp-Source: APXvYqwTX1VldzlCMOHNg9PynG6cKPHKOvzIfOE8DTljIeC32sLsWx125SW6cUSaV4Qfvk/8wFYlew==
X-Received: by 2002:a37:4714:: with SMTP id u20mr51193790qka.162.1563915021913;
        Tue, 23 Jul 2019 13:50:21 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m10sm19335819qka.43.2019.07.23.13.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 13:50:21 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     davem@davemloft.net, arnd@arndb.de, dhowells@redhat.com,
        jakub@redhat.com, ndesaulniers@google.com, morbo@google.com,
        jyknight@google.com, natechancellor@gmail.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] asm-generic: fix -Wtype-limits compiler warnings
Date:   Tue, 23 Jul 2019 16:49:46 -0400
Message-Id: <1563914986-26502-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d66acc39c7ce ("bitops: Optimise get_order()") introduced a
compilation warning because "rx_frag_size" is an "ushort" while
PAGE_SHIFT here is 16. The commit changed the get_order() to be a
multi-line macro where compilers insist to check all statements in the
macro even when __builtin_constant_p(rx_frag_size) will return false as
"rx_frag_size" is a module parameter.

In file included from ./arch/powerpc/include/asm/page_64.h:107,
                 from ./arch/powerpc/include/asm/page.h:242,
                 from ./arch/powerpc/include/asm/mmu.h:132,
                 from ./arch/powerpc/include/asm/lppaca.h:47,
                 from ./arch/powerpc/include/asm/paca.h:17,
                 from ./arch/powerpc/include/asm/current.h:13,
                 from ./include/linux/thread_info.h:21,
                 from ./arch/powerpc/include/asm/processor.h:39,
                 from ./include/linux/prefetch.h:15,
                 from drivers/net/ethernet/emulex/benet/be_main.c:14:
drivers/net/ethernet/emulex/benet/be_main.c: In function
'be_rx_cqs_create':
./include/asm-generic/getorder.h:54:9: warning: comparison is always
true due to limited range of data type [-Wtype-limits]
   (((n) < (1UL << PAGE_SHIFT)) ? 0 :  \
         ^
drivers/net/ethernet/emulex/benet/be_main.c:3138:33: note: in expansion
of macro 'get_order'
  adapter->big_page_size = (1 << get_order(rx_frag_size)) * PAGE_SIZE;
                                 ^~~~~~~~~

Fix it by moving almost all of this multi-line macro into a proper
function __get_order(), and leave get_order() as a single-line macro in
order to avoid compilation errors.

Fixes: d66acc39c7ce ("bitops: Optimise get_order()")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/asm-generic/getorder.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/getorder.h b/include/asm-generic/getorder.h
index c64bea7a52be..c6a6d3cd7007 100644
--- a/include/asm-generic/getorder.h
+++ b/include/asm-generic/getorder.h
@@ -15,6 +15,16 @@ int __get_order(unsigned long size)
 {
 	int order;
 
+	if (__builtin_constant_p(size)) {
+		if (!size)
+			return BITS_PER_LONG - PAGE_SHIFT;
+
+		if (size < (1UL << PAGE_SHIFT))
+			return 0;
+
+		return ilog2((size) - 1) - PAGE_SHIFT + 1;
+	}
+
 	size--;
 	size >>= PAGE_SHIFT;
 #if BITS_PER_LONG == 32
@@ -49,11 +59,6 @@ int __get_order(unsigned long size)
  */
 #define get_order(n)						\
 (								\
-	__builtin_constant_p(n) ? (				\
-		((n) == 0UL) ? BITS_PER_LONG - PAGE_SHIFT :	\
-		(((n) < (1UL << PAGE_SHIFT)) ? 0 :		\
-		 ilog2((n) - 1) - PAGE_SHIFT + 1)		\
-	) :							\
 	__get_order(n)						\
 )
 
-- 
1.8.3.1

