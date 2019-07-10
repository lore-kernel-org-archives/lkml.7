Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3638AC606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A8C20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfGJNGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:06:02 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:54643 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJNGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:06:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MG9To-1hhtRC0cVY-00GcBk; Wed, 10 Jul 2019 15:05:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        matt@codeblueprint.co.uk, xen-devel@lists.xenproject.org,
        Ingo Molnar <mingo@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] x86: fix LOWMEM_PAGES constant
Date:   Wed, 10 Jul 2019 15:04:55 +0200
Message-Id: <20190710130522.1802800-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:P4mHzcBPHXgdb+u5vlx/hBpSw2l3rZVeWH9UqWEV1mEVmDpXjqc
 JcS1nDm3cY6uP95lhZ6OmZV9FXhTFdBefNhUFcM/YEx5wWSzK7UfL3fNZdvXYsaVnlt9ygM
 oKo/NnHEx3zlZHa4vlzc9lXYhaGTlnESjypQx81UC210Q/dZBFOr0Q0XPSD9rlqhryzD441
 NW8eQsCEheKKtMQjTPZRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PZw3USf94/I=:M+icLSClyqLKdVhhCZubUA
 47jMTB4X8usjv8TaYgEmQHpWE1BGOo3gIbWMniuwY6yrjFjrglYMQbHIczZGTE9wc20s5+WSX
 81FFnw9MOZNvgdOrqFVuaTFOTXsKtCX9O52Gki/NToZ8/oyF4UZ/kh+uukfTcfq9BoBK/Bpdy
 AqQS5iSX3IvX9IMIf/QGTqPLMueDp3CQTo45P4Cp/7f3corWdKda00qH0EAnepwIyZp25zDpA
 bcOdI41sbabP3BVOYAwiup6Ig2fofbnUZ3r5NZ53XVkvpzZyClqKSTrsaApXIEab9hEvy/fML
 phIDyU5uxy5PsKZP2t0ZsQqTAWvlcfWXLZFfNhrNs9Ftkh5ncAPAeeIF3WBcZhrn3GnNIF2UC
 30Di1xjdKPuArGNV67oc5Ep/TtCFVxQgKhDSmIyNFx6/1Rvpw1dI6S5d7DF+v2NenNOec13UR
 g1bOQkXbwTzif1Zm8ytGOT0CPYld/GSsYUw1qlLY/sqhPBdFgX7j3g4kr7Ly+PFSnwK/LJxOo
 /5DStVTJAk2IJM2FbtI4wnpSV9ha2JytHOOO42NObZI/8v5pIE8aMxlRXcOJ6GzwrqE68uu+B
 tP5fFDmgsv1d3euocNJoIyDQ31evYwwZpl0AdTWgZlezZkrkQLGJMsJJPWfcfmgGpmp+x/SSm
 hAhw2yQiaplzkzTD+bs71xFgaGVTCW1oYeMCo3wsh9bp3/XWFAcq88FDfpBqtB5aoeUQ7/PhD
 pdqUkdJq1q7Y7bIbz7DEZRnRPYtezbWMXhbDPg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang points out that the computation of LOWMEM_PAGES causes
a signed integer overflow on 32-bit x86:

arch/x86/kernel/head32.c:83:20: error: signed shift result (0x100000000) requires 34 bits to represent, but 'int' only has 32 bits [-Werror,-Wshift-overflow]
                (PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
                                 ^~~~~~~~~~~~
arch/x86/include/asm/pgtable_32.h:109:27: note: expanded from macro 'LOWMEM_PAGES'
 #define LOWMEM_PAGES ((((2<<31) - __PAGE_OFFSET) >> PAGE_SHIFT))
                         ~^ ~~
arch/x86/include/asm/pgtable_32.h:98:34: note: expanded from macro 'PAGE_TABLE_SIZE'
 #define PAGE_TABLE_SIZE(pages) ((pages) / PTRS_PER_PGD)

Use the _ULL() macro to make it a 64-bit constant.

Fixes: 1e620f9b23e5 ("x86/boot/32: Convert the 32-bit pgtable setup code from assembly to C")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/pgtable_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 4fe9e7fc74d3..c78da8eda8f2 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -106,6 +106,6 @@ do {						\
  * with only a host target support using a 32-bit type for internal
  * representation.
  */
-#define LOWMEM_PAGES ((((2<<31) - __PAGE_OFFSET) >> PAGE_SHIFT))
+#define LOWMEM_PAGES ((((_ULL(2)<<31) - __PAGE_OFFSET) >> PAGE_SHIFT))
 
 #endif /* _ASM_X86_PGTABLE_32_H */
-- 
2.20.0

