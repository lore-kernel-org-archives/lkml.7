Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B24AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA0120863
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687772;
	bh=1G9EpUnjxZcqPVd0mncOiAGszpfypH/QgZc0XsEUtlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oeL1Jq+Z3RTjWkEi4HWaeZaJu0tO3Bx55P0wHGxZsLCAN5p4gDSQlbzTbDOoZtpLI
	 eJWGMt+H5Qb+QH/mM2rtNbsV5KVauiqy1Y1rhScROfzqOYGwyauxiNU+e2e9BHO4M1
	 kwrynnNvAaQIb2/uo3Dj9zz1nbvH1B2SS84ZOac4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCDIWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:22:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfCDIWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:22:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B755920823;
        Mon,  4 Mar 2019 08:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687766;
        bh=1G9EpUnjxZcqPVd0mncOiAGszpfypH/QgZc0XsEUtlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dN8dFAMuBNfr9/eJ/kQOaMZSpcDwm56A5vObA9uiOOjkk/rxBiJFoxiLJ9k1eKXUv
         jmDIy5R0KHgS7HnYEnkLiuTWNwkAe7xrgJtr78stZuf/6tSrxnju2u/mZVXFCujlvJ
         OXPk6Y0HSG21+gsrf2Td1pZ5zyQ/hy/XT66SrMeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 14/32] ARC: fix __ffs return value to avoid build warnings
Date:   Mon,  4 Mar 2019 09:22:02 +0100
Message-Id: <20190304081603.313531022@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4e868f8419cb4cb558c5d428e7ab5629cef864c7 ]

|  CC      mm/nobootmem.o
|In file included from ./include/asm-generic/bug.h:18:0,
|                 from ./arch/arc/include/asm/bug.h:32,
|                 from ./include/linux/bug.h:5,
|                 from ./include/linux/mmdebug.h:5,
|                 from ./include/linux/gfp.h:5,
|                 from ./include/linux/slab.h:15,
|                 from mm/nobootmem.c:14:
|mm/nobootmem.c: In function '__free_pages_memory':
|./include/linux/kernel.h:845:29: warning: comparison of distinct pointer types lacks a cast
|   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
|                             ^
|./include/linux/kernel.h:859:4: note: in expansion of macro '__typecheck'
|   (__typecheck(x, y) && __no_side_effects(x, y))
|    ^~~~~~~~~~~
|./include/linux/kernel.h:869:24: note: in expansion of macro '__safe_cmp'
|  __builtin_choose_expr(__safe_cmp(x, y), \
|                        ^~~~~~~~~~
|./include/linux/kernel.h:878:19: note: in expansion of macro '__careful_cmp'
| #define min(x, y) __careful_cmp(x, y, <)
|                   ^~~~~~~~~~~~~
|mm/nobootmem.c:104:11: note: in expansion of macro 'min'
|   order = min(MAX_ORDER - 1UL, __ffs(start));

Change __ffs return value from 'int' to 'unsigned long' as it
is done in other implementations (like asm-generic, x86, etc...)
to avoid build-time warnings in places where type is strictly
checked.

As __ffs may return values in [0-31] interval changing return
type to unsigned is valid.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/include/asm/bitops.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index 8da87feec59aa..99e6d8948f4ac 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -340,7 +340,7 @@ static inline __attribute__ ((const)) int __fls(unsigned long x)
 /*
  * __ffs: Similar to ffs, but zero based (0-31)
  */
-static inline __attribute__ ((const)) int __ffs(unsigned long word)
+static inline __attribute__ ((const)) unsigned long __ffs(unsigned long word)
 {
 	if (!word)
 		return word;
@@ -400,9 +400,9 @@ static inline __attribute__ ((const)) int ffs(unsigned long x)
 /*
  * __ffs: Similar to ffs, but zero based (0-31)
  */
-static inline __attribute__ ((const)) int __ffs(unsigned long x)
+static inline __attribute__ ((const)) unsigned long __ffs(unsigned long x)
 {
-	int n;
+	unsigned long n;
 
 	asm volatile(
 	"	ffs.f	%0, %1		\n"  /* 0:31; 31(Z) if src 0 */
-- 
2.19.1



