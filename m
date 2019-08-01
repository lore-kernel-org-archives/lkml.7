Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E1C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96E32080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk0POyiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390203AbfHAXEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:04:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40398 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390169AbfHAXEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:04:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id m8so37396471lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 16:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=75kyKOg+It2ehvAh8LlI8jSSftjjZmGeTxvfzWDereM=;
        b=fk0POyiOICDm/J3V10ofJ2z62cGnewG3KDLraOqT3PcWNGFJJDbaQUgi5js47ned+S
         OR/DQ9SHo0JTsD3QMKJLcvhlxbKwtSZs/t5CTNUozRa0LMFNAWuY9D7+d2PFFSwwIZlI
         emD8MVZCz/JW/VEShCAbrIkKJ1KsulAIkF1vrTyKM6yJ7ceIlE0V5Ose1dLbGWlV7BGy
         D8xXmSonwENBXAhMH3bUC4Dj33EPwEN+CdHqYxf/ja3nWi3QriiveH3MMZ6qo+flDqEu
         xIEj/OoLB0ErnyZ1TGDQHXUKUJT1bRzmq1Uhq46KiA51Q+/MZSVq3/E/tgHsnxER7a6f
         P78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=75kyKOg+It2ehvAh8LlI8jSSftjjZmGeTxvfzWDereM=;
        b=BV11bgfgAS1Qu2UaM9Tcj+wO9kgUOzAvoDwAseay94MPE/QdY1nzH01RYYlbYlk48Q
         zeCqwZp68tB1O73FBCK9pqywu9HZ3T5SoHaF0llaFaChe0cH+COW2fPfi87CG5d13Hn+
         5kPqZs4tHUtTMsxHovcMAcJi/z/YKIjUn5UuZ/Ad1ahSgH9Y558FLhUjcXwEDHrJ2Dbv
         iire1/FkQu+Zs1dp9Uvi1RzjedzLe73Gw1qDO34saXoBpcvYjU8o4Xz7nwpdQxlSZJTF
         VYGPzMKsCk5QdiCc6sqa05ie6Ev4Ob6bTgmt7woDOljqE1AydhZ/UvQIGFYwMgz2iKY8
         dfOg==
X-Gm-Message-State: APjAAAWlBv36ZtvIrXQrzqBJPYeJIZYT7KMA75R324ubNxrunNAK7IEy
        swaEbZ2joae8sBNvd5DNrO0=
X-Google-Smtp-Source: APXvYqyTor/K62SpWbbAIFNPE/LJMHIbpONLe+/+pMqv/f/8hplqYMmMKporLjhlyzV6a7pnQL5JZA==
X-Received: by 2002:a2e:7f05:: with SMTP id a5mr7403781ljd.190.1564700659208;
        Thu, 01 Aug 2019 16:04:19 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id u18sm12377017lfe.65.2019.08.01.16.04.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 16:04:18 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, joe@perches.com,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com
Subject: [PATCH v2 2/2] linux/bits.h: Add compile time sanity check of GENMASK inputs
Date:   Fri,  2 Aug 2019 01:03:58 +0200
Message-Id: <20190801230358.4193-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
References: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
 <20190801230358.4193-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GENMASK() and GENMASK_ULL() are supposed to be called with the high bit
as the first argument and the low bit as the second argument. Mixing
them will return a mask with zero bits set.

Recent commits show getting this wrong is not uncommon, see e.g.
commit aa4c0c9091b0 ("net: stmmac: Fix misuses of GENMASK macro") and
commit 9bdd7bb3a844 ("clocksource/drivers/npcm: Fix misuse of GENMASK
macro").

To prevent such mistakes from appearing again, add compile time sanity
checking to the arguments of GENMASK() and GENMASK_ULL(). If both the
arguments are known at compile time, and the low bit is higher than the
high bit, break the build to detect the mistake immediately.

Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
of __builtin_constant_p().

If successful, BUILD_BUG_OR_ZERO() returns 0 of type size_t. To avoid
problems with implicit conversions, cast the result of BUILD_BUG_OR_ZERO
to unsigned long.

Since both BUILD_BUG_ON_ZERO() and __is_constexpr() only uses sizeof()
on the arguments passed to them, neither of them evaluate the expression
unless it is a VLA. Therefore, GENMASK(1, x++) still behaves as
expected.

Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
available in assembly") made the macros in linux/bits.h available in
assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
compatible, disable the checks if the file is included in an asm file.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Changes in v2:
  - Add comment about why inputs are not checked when used in asm file
  - Use UL(0) instead of 0
  - Extract mask creation in a separate macro to improve readability
  - Use high and low instead of h and l (part of this was extracted to a
    separate patch)
  - Updated commit message

Joe Perches sent a series to fix the existing misuses of GENMASK() that
needs to be merged before this to avoid build failures. Currently, 6 of
the patches are not in Linus tree, and 2 are not in linux-next.


 include/linux/bits.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index d4466aa42a9c..955e9e43c4a5 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -18,12 +18,30 @@
  * position @high. For example
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
-#define GENMASK(high, low) \
+#ifndef __ASSEMBLY__
+#include <linux/build_bug.h>
+#define GENMASK_INPUT_CHECK(high, low) \
+	((unsigned long)BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
+		__is_constexpr(high) && __is_constexpr(low), \
+		(low) > (high), UL(0))))
+#else
+/*
+ * BUILD_BUG_ON_ZERO and __is_constexpr() are not available in h files
+ * included from asm files, disable the input check if that is the case.
+ */
+#define GENMASK_INPUT_CHECK(high, low) UL(0)
+#endif
+
+#define __GENMASK(high, low) \
 	(((~UL(0)) - (UL(1) << (low)) + 1) & \
 	 (~UL(0) >> (BITS_PER_LONG - 1 - (high))))
+#define GENMASK(high, low) \
+	(GENMASK_INPUT_CHECK(high, low) + __GENMASK(high, low))
 
-#define GENMASK_ULL(high, low) \
+#define __GENMASK_ULL(high, low) \
 	(((~ULL(0)) - (ULL(1) << (low)) + 1) & \
 	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (high))))
+#define GENMASK_ULL(high, low) \
+	(GENMASK_INPUT_CHECK(high, low) + __GENMASK_ULL(high, low))
 
 #endif	/* __LINUX_BITS_H */
-- 
2.22.0

