Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9594C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE806206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkBGZvTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfGaTEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:04:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42898 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfGaTEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:04:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so66710039lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 12:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4R4JIwEkzgPRY5Q32Ye/hIHj7mVNSnkxupaRXo12Q0E=;
        b=kkBGZvTrTWC/DUxOXrHA/63lm2j9IOD3LkoZaj4y4bkYZ5MdV9QojNfcHFJ5naC45N
         iCZ3g6IEaY+9tpEczjQwvrjqTsmgLbDnvMJJMFjdmO+069GFzkKpm/BKNn3TwcD5ts5h
         8RxqKsB5YRN6v1OV8QE+klWU9EvEF0tZ/wcL+H8Mp7tVKNHwSHJEsYIo1p1EnI2PEsK/
         SnaXkxSLbBsd/2qmJxe6JYqEFsWpce036GSFP7GyyBqcDQmwfz63FKdIQJ9YLrIvxxB5
         CnUpWYpqCh0QEViaV7vubMxG/jGg0q4y/c+meFfbyZWXMWO72D35XPoxKJiDePFm8HWA
         Ax3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4R4JIwEkzgPRY5Q32Ye/hIHj7mVNSnkxupaRXo12Q0E=;
        b=qFaJ65StEQc5/FUVO4T2fK0pansrK0cEDBUaLJ9TL8UhI5a4YAELA6F7ptcjk6tkd2
         eGT9ZCUVoDBzv8FhmOPdDSo/fjecJ4hvZpGtF+Gf/Lt7UBH5nOK4gmQYVQz0lPbDF3vg
         SUGAOvgTXzoSzlxwn3fllElpnZ75XWwnnjcz/lpzOxh/wiic5LzKcNB4cxWQCnFR9r0d
         oY8UQ+jX41Tlka7V2fEDwKl5Mxo1mMopICgGY+Cz4HvmF+/NcqQTQtGIWd6IPad8YBRT
         RGNpB8d2Ak4Nyo4Cvl7pV3LgpmU1vNcsPT3P7qQ58flj2ppNVTWbtRrfstuQzI1fB2OL
         bTuw==
X-Gm-Message-State: APjAAAXHRALDxq9XNXEexJT3mtr1WbMUzhqMwJCnKR7yuApuVptZL5WX
        AWDpbzn72LQE3BvJnsIe/zs=
X-Google-Smtp-Source: APXvYqw/Cjh2E7fsvlMZpS7STQ2YeZhCs8omtYrwn8xdwq4b3RiOWQrxufWqSDN8CR/gzTaybStKsQ==
X-Received: by 2002:a2e:9d8a:: with SMTP id c10mr41108845ljj.147.1564599872221;
        Wed, 31 Jul 2019 12:04:32 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id i23sm14138025ljb.7.2019.07.31.12.04.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 12:04:31 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     joe@perches.com
Cc:     akpm@linux-foundation.org, johannes@sipsolutions.net,
        linux-kernel@vger.kernel.org, rikard.falkeborn@gmail.com,
        yamada.masahiro@socionext.com
Subject: [PATCH] linux/bits.h: Add compile time sanity check of GENMASK inputs
Date:   Wed, 31 Jul 2019 21:03:09 +0200
Message-Id: <20190731190309.19909-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
References: <0306bec0ec270b01b09441da3200252396abed27.camel@perches.com>
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

Since GENMASK() is used in declarations, BUILD_BUG_OR_ZERO() must be
used instead of BUILD_BUG_ON(), and __is_constexpr() must be used instead
of __builtin_constant_p().

Commit 95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends
available in assembly") made the macros in linux/bits.h available in
assembly. Since neither BUILD_BUG_OR_ZERO() or __is_constexpr() are asm
compatible, disable the checks if the file is included in an asm file.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Joe Perches sent a series to fix the existing misuses of GENMASK() that
needs to be merged before this to avoid build failures. Currently, 7 of
the patches were not in Linus tree, and 2 were not in linux-next.

Also, there's currently no asm users of bits.h, but since it was made
asm-compatible just two weeks ago it would be a shame to break it right
away...

 include/linux/bits.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 669d69441a62..73489579eef9 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -18,12 +18,22 @@
  * position @h. For example
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
+#ifndef __ASSEMBLY__
+#include <linux/build_bug.h>
+#define GENMASK_INPUT_CHECK(h, l)  BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
+		__is_constexpr(h) && __is_constexpr(l), (l) > (h), 0))
+#else
+#define GENMASK_INPUT_CHECK(h, l) 0
+#endif
+
 #define GENMASK(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + \
 	(((~UL(0)) - (UL(1) << (l)) + 1) & \
-	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
+	 (~UL(0) >> (BITS_PER_LONG - 1 - (h)))))
 
 #define GENMASK_ULL(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + \
 	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
-	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
+	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h)))))
 
 #endif	/* __LINUX_BITS_H */
-- 
2.22.0

