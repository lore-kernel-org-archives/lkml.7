Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBA0ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E7E206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aro6Dw4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfJIVpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 17:45:36 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32962 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbfJIVpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 17:45:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id y127so2797205lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yeGFMT9Yh2tGCKL21UmED8zMeUsn9uXz7yiydih8u2o=;
        b=Aro6Dw4HUegRE4qm00O9kN0d5nleuW9jEB84K8+6B+fAyven4Qzb3ypgNIyJBDgCsn
         BGKEcjUsHu99qZ3BCQeXBuq2FyryPjkPXFsanrJzB4rwzir4qX0ceyIyvBHjACMDm0Rr
         mClkZgtAelQOn7+UodkQJGAW5BLESikLg//AcZSTXUhdTjZTSMbgQOM0ie6wd/g8fYOF
         aeSHEnlfy6FrkaTqbUc4lh5qAempGQNYK9ZXWM93aS4OEVBotZptO6ZKFzZ6T6jvakVa
         7rtYc1vX1tov4JEHztUz2fmEz0mnlQaNPUvodYEDlVgfaijf8nHEu1JjxLtBjSpJXU/u
         bo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yeGFMT9Yh2tGCKL21UmED8zMeUsn9uXz7yiydih8u2o=;
        b=QQv4i1SA+0lrYGglqM44oMkUQLcajU2SsWNYJn6PpH7TzRGG8wJiO9ziw4V5ZDI5Dm
         x34NPGxKMKJpVxLlhJVMdWVyGs2sM8sZAGOqf4y9LC+FSLd/ZuEQcWjEfFBipm30PJLD
         dgqHhAksu5RpMJbkq+xmU/Msj4DHY88enO3t4IqJ91tPq0QSdi6OHOfXyd5vG374Wpy1
         504fGPOcXewSU+tS2/95XSsloiUiXfOESgudojGCS1xKUVND3WIeR8ygNOwYUSDh1BV9
         tGqtMtyxF/bmfGrZmBgy70cJfSE8rx3r6H8ucu9gT1H5QUBS8fvQWwLUGs7iSPzT8m8I
         4M8Q==
X-Gm-Message-State: APjAAAWdfupL56YzXCjOTckNSpnD1UabWuOL8WdF3gOKWmDIvhhI1tcG
        JaJqddbGgrcLkK/mz6nah/sZC8fUmfk=
X-Google-Smtp-Source: APXvYqxW9oiAImp22CzUegOrSuk4UnNtjH2pJ3KD6zXxJfgSxIflgtxAbzmr4STf93vL4d+WLN3poA==
X-Received: by 2002:a19:f610:: with SMTP id x16mr3107275lfe.139.1570657533555;
        Wed, 09 Oct 2019 14:45:33 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-153.NA.cust.bahnhof.se. [98.128.228.153])
        by smtp.gmail.com with ESMTPSA id v22sm701503ljh.56.2019.10.09.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 14:45:32 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     rikard.falkeborn@gmail.com
Cc:     akpm@linux-foundation.org, bp@alien8.de, joe@perches.com,
        johannes@sipsolutions.net, keescook@chromium.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        yamada.masahiro@socionext.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Haren Myneni <haren@us.ibm.com>
Subject: [Patch v4 2/2] linux/bits.h: Add compile time sanity check of GENMASK inputs
Date:   Wed,  9 Oct 2019 23:45:02 +0200
Message-Id: <20191009214502.637875-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009214502.637875-1-rikard.falkeborn@gmail.com>
References: <20190811184938.1796-1-rikard.falkeborn@gmail.com>
 <20191009214502.637875-1-rikard.falkeborn@gmail.com>
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

Due to bugs in GCC versions before 4.9 [0], disable the check if
building with a too old GCC compiler.

[0]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=19449

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Geert, can you check if this works better? I do not have gcc 4.6-4.8
readily installed.

Kees, Masahiro, since I changed this patch, I didn't include your
reviewed-by tags.

Changes in v4:
  - Disable the argument check for GCC < 4.9 due to a compiler bug.
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

Joe Perches sent a series to fix the existing misuses of GENMASK().
Those patches have been merged into Linus tree except two places where
the GENMASK misuse is in unused macros, which will not fail to build.
There was also a patch by Nathan Chancellor that have now been merged.

 include/linux/bits.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 669d69441a62..f108302a3121 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -18,12 +18,30 @@
  * position @h. For example
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
-#define GENMASK(h, l) \
+#if !defined(__ASSEMBLY__) && \
+	(!defined(CONFIG_CC_IS_GCC) || CONFIG_GCC_VERSION >= 49000)
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
2.23.0

