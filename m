Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9D1C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5942D2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 18:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvUog1CY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfHKSuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:50:13 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39274 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfHKSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 14:50:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so19084975lfn.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 11:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=huKzeJveUl46Z4R0QkbeDkdnGlxIMnjDuQYSIj+D3TA=;
        b=lvUog1CYF7fqUUlClqszooVVVxPZzUAhtcD1J9MCq04cpH3yJSqmNdgb2vl393BJcs
         Jarw5/+oi8BegE+cjFyg+gndI4iZvJDn/P+tS8DC+3jXjNkZPB6aB0AhCsLmza/ouJdU
         xXWmZrvgV1tCVyB1Lrl8uNK0SGWOpKgLhzW0OJkcEa/SgNqqQRvhQMgDsuYeuK3zD1eF
         sU6UukH84VaHWTy4GMQqYps5NTWAqfErZsJ3n3S2xy1s9nAGJhJtRqBGMlZqIazTm7WQ
         jsP5gCs13zmxglQMrEeo32cfm+6cDuIA3ubwlVwOf+cNNjPP+yh5U2ktvp87zERHzDlA
         cl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=huKzeJveUl46Z4R0QkbeDkdnGlxIMnjDuQYSIj+D3TA=;
        b=kqYWgL44R7tDxNy9u1CWmEYThPZ5XRD47J7X69UWpprs0+uJwNvT3bMqiTlcXI/LCI
         BuugH/ti/Dxa9T0bZ72WkcE5Bv2s1AWr1c9xGMlD0BrZpI9y++3hMOxelH0a0ZJiYQ7/
         o9VT+bBQq5YsnlDtypzS0yai3qz1tr+GW2QnQPEekceaQNEvsTiFP4xbZmVlZW4ir9TF
         BL92eRseIi3va58ND9NCVwBPD2qmMsxvvjHo+5JtbgThXpNy+h4h1XM0RSqi4BdmKpTW
         pWEzy62QkC5Rqwc1YiR17BoqCsfSGNkqo7c/Jal4urNppK1+wtAO0oToXbZhwT5WKzKv
         COtw==
X-Gm-Message-State: APjAAAX8OJtGtl25vGwHjQqxV0kGCyFKvgackNLwUjNaxLuKf+/y0zqq
        90FPyJ9s7cl/ACALEZj7kCAWAcF7u0E=
X-Google-Smtp-Source: APXvYqwkYy3RWYS3j92u4EDKhjLwq7QBSdVBxqiCcayqsX1944SPhtZfzm+hnbbQJevsYcJ7qPk6lQ==
X-Received: by 2002:a19:674d:: with SMTP id e13mr13737512lfj.176.1565549409458;
        Sun, 11 Aug 2019 11:50:09 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id r21sm5250117lfi.32.2019.08.11.11.50.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 11:50:08 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, joe@perches.com,
        johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com
Subject: [PATCH v3 3/3] linux/bits.h: Add compile time sanity check of GENMASK inputs
Date:   Sun, 11 Aug 2019 20:49:38 +0200
Message-Id: <20190811184938.1796-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
References: <20190801230358.4193-1-rikard.falkeborn@gmail.com>
 <20190811184938.1796-1-rikard.falkeborn@gmail.com>
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
checking to the arguments of GENMASK() and GENMASK_ULL(). If both
arguments are known at compile time, and the low bit is higher than the
high bit, break the build to detect the mistake immediately.

Since GENMASK() is used in declarations, BUILD_BUG_ON_ZERO() must be
used instead of BUILD_BUG_ON().

__builtin_constant_p does not evaluate is argument, it only checks if it
is a constant or not at compile time, and __builtin_choose_expr does not
evaluate the expression that is not chosen. Therefore, GENMASK(x++, 0)
does only evaluate x++ once.

Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
available in assembly") made the macros in linux/bits.h available in
assembly. Since BUILD_BUG_OR_ZERO() is not asm compatible, disable the
checks if the file is included in an asm file.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Changes in v3:
  - Changed back to shorter macro argument names
  - Remove casts and use 0 instead of UL(0) in GENMASK_INPUT_CHECK(),
    since all results in GENMASK_INPUT_CHECK() are now ints. Update
    commit message to reflect that.

Changes in v2:
  - Add comment about why inputs are not checked when used in asm file
  - Use UL(0) instead of 0
  - Extract mask creation in a separate macro to improve readability
  - Use high and low instead of h and l (part of this was extracted to a
    separate patch)
  - Updated commit message

Joe Perches sent a series to fix the existing misuses of GENMASK() that
needs to be merged before this to avoid build failures. Currently, 5 of
the patches are not in Linus tree, and 2 are not in linux-next. There is
also a patch pending by Nathan Chancellor that also needs to be merged
before this patch is merged to avoid build failures.

 include/linux/bits.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 669d69441a62..4ba0fb609239 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -18,12 +18,29 @@
  * position @h. For example
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
-#define GENMASK(h, l) \
+#ifndef __ASSEMBLY__
+#include <linux/build_bug.h>
+#define GENMASK_INPUT_CHECK(h, l) \
+	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
+		__builtin_constant_p((l) > (h)), (l) > (h), 0)))
+#else
+/*
+ * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
+ * disable the input check if that is the case.
+ */
+#define GENMASK_INPUT_CHECK(h, l) 0
+#endif
+
+#define __GENMASK(h, l) \
 	(((~UL(0)) - (UL(1) << (l)) + 1) & \
 	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
+#define GENMASK(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
 
-#define GENMASK_ULL(h, l) \
+#define __GENMASK_ULL(h, l) \
 	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
 	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
+#define GENMASK_ULL(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
 
 #endif	/* __LINUX_BITS_H */
-- 
2.22.0

