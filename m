Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54344C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2424521916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254217;
	bh=4NRlzDN5xczftzgnkYcP521MITiceK0edatCMwnHNGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bs7pP6H8EeXpY5vJ2MZ5B9mhUyMgGF8hpAcrzKKbHziXUMgKODpRIOyzQXMSGDB/X
	 7fwJVOEv+r4P9otQPRXKYTCebWJKPDSLXRlJw4ztOrstByp+MSCzTZAQtH9DTiwNTD
	 kts8oc3SEz46hEyF8adqBZKdA/h1w3hlrP6nQLbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfCVLaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729888AbfCVLaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:30:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48FF320449;
        Fri, 22 Mar 2019 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254210;
        bh=4NRlzDN5xczftzgnkYcP521MITiceK0edatCMwnHNGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1rIndEZF+H4rEVCjpxKz47JiYBhQJ9mD464AHNpmLXd875KgDVj+M7jolUgC/vld/
         uBc6MrekQVbZG6sWt/blDIyYEGd8pRfNVo76O8KE+f67k4b2Ba5uZ4PWgSg0Rmk2tT
         BxQuhRVdLEW1k4evsV0eRoejAs82iprzYOctA3os=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 040/230] ARC: fix __ffs return value to avoid build warnings
Date:   Fri, 22 Mar 2019 12:12:58 +0100
Message-Id: <20190322111239.514756485@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index 0352fb8d21b99..9623ae002f5b4 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -286,7 +286,7 @@ static inline __attribute__ ((const)) int __fls(unsigned long x)
 /*
  * __ffs: Similar to ffs, but zero based (0-31)
  */
-static inline __attribute__ ((const)) int __ffs(unsigned long word)
+static inline __attribute__ ((const)) unsigned long __ffs(unsigned long word)
 {
 	if (!word)
 		return word;
@@ -346,9 +346,9 @@ static inline __attribute__ ((const)) int ffs(unsigned long x)
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



