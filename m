Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7637EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EB822DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566329290;
	bh=j/vDrKbHbr8qOf1Hkj3IK8hYr1O4TheSjayhDDUR0Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KjiU6AXXOt21N7RQH7iaiHZqVgUz1ey5HEY3RpMj+1/eVXfM3AZIspTO7Wm591P+K
	 SoLxzmKBwAExhEiUt/1ItJEtApZrfp5VapT1fUHb8zeOys9za4u6BZXXdg8PAdAeyB
	 JkT3gQwmvZCnshSWyo9rzdB/nuPw9CqQqjbxiU6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfHTT2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730773AbfHTT2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:28:08 -0400
Received: from quaco.ghostprotocols.net (177.206.236.100.dynamic.adsl.gvt.net.br [177.206.236.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14E8A2332A;
        Tue, 20 Aug 2019 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566329287;
        bh=j/vDrKbHbr8qOf1Hkj3IK8hYr1O4TheSjayhDDUR0Rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7c/a0V6rGam+sN1lj3zawfzF9p5bkMF96kCukiq2lMDTm0GEkCQTr4cczh/uZPdO
         nardAci/HWYd0+z0tqgKcB2UTRVTGeiAu7q+SOv5YMISullJzs76dDfuRhl5mlVMML
         bYn7+2GjhHiZPz6g4Z6d6kfK+hR4bIUZx0tLZJ2o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 04/17] tools headers: Synchronize linux/bits.h with the kernel sources
Date:   Tue, 20 Aug 2019 16:27:20 -0300
Message-Id: <20190820192733.19180-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in this cset:

  95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends available in assembly")

To address this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/include/linux/bits.h' differs from latest version at 'include/linux/bits.h'
  diff -u tools/include/linux/bits.h include/linux/bits.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1if3iga5r3di6oyddgxsr225@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/bits.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 2b7b532c1d51..669d69441a62 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -1,13 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_BITS_H
 #define __LINUX_BITS_H
+
+#include <linux/const.h>
 #include <asm/bitsperlong.h>
 
-#define BIT(nr)			(1UL << (nr))
-#define BIT_ULL(nr)		(1ULL << (nr))
-#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
+#define BIT(nr)			(UL(1) << (nr))
+#define BIT_ULL(nr)		(ULL(1) << (nr))
+#define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
-#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
+#define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
 
@@ -17,10 +19,11 @@
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
 #define GENMASK(h, l) \
-	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+	(((~UL(0)) - (UL(1) << (l)) + 1) & \
+	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
 
 #define GENMASK_ULL(h, l) \
-	(((~0ULL) - (1ULL << (l)) + 1) & \
-	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
+	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
 
 #endif	/* __LINUX_BITS_H */
-- 
2.21.0

