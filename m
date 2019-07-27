Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2303AC76186
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB50208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 19:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua7JqKg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbfG0TzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 15:55:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41527 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0TzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 15:55:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so54656141ljg.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 12:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bUx8yvuKqDXHL8O5vZ38a4jABCZKfUuj9Gna9bLoUg=;
        b=Ua7JqKg+yCL9sTAFGeMu6bnW2e2ALKennFe+K1RfOjrxHrWS9nVNOFUslb01ixzQtj
         MmLuVnJZFlEGBCYYgV0KhcF0T26gz7qDCM0I/79ITDu40TXi/PwitJlZFHDFA8vdhG9Z
         Dfbj0l9UKvKagRGSqNdRFp1DIx1C7Rg+SaIaOuptH2x/d4L7r+P41BGhuvd1dFKk4r8g
         3Kut8MSbu4UVt7I73RT5CEs5K7Zb00j+14NP9rscE0zFajom7OYHNIP+07WigT4RCDlM
         jha5EM3gQdeT0F/y3jqFgL5VCQdsv0jj2AxsWss9eC7khxzjIci7Kv8vSNGguAqTxV+W
         21Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bUx8yvuKqDXHL8O5vZ38a4jABCZKfUuj9Gna9bLoUg=;
        b=miQtHlCrbTNr3hwtvlml1o8f+ppAiK6L7Yh0kEmjcMmlz/YZ8xMIXCB0sHT6rVWw3A
         QK7p3RxbNk6WoZ3RtsFSHhx1Kf9NRazTIUPivkerKrQZIyQFI8FQkC+Ec76eUjpoaiWC
         45N1iH9+1pufj6DUqXIU9uYYuWX9D8ve3Z6dd3ivlPcAw2sqRBwFNCVv3GoqrpPQcYNe
         JTKR4Atz83gktrSgXbxOdFF4QG4mGvkG5G5+iJcZR+6b3Y6OQrKuCmqAItO43DeJRZcz
         jp0wFE782FClB5ajrcaoy725R/nj1/wYDx6csmFXgMWihawitSP1NpgE3yM9S6Jgw801
         LNEQ==
X-Gm-Message-State: APjAAAWnUwxirAYv/zCmaqXC0INdEg2KsCRsmSmGbkWBLBNHrvp7tRun
        Qr6j9+oVuYbxusFk7+PnivA=
X-Google-Smtp-Source: APXvYqwx2qsu2HLrnZYeF+n0M7M/8+KLDQIV9DzQNLZUJXbU7bwpsakL5U6zyph2Jsxp8c8H/2ukMw==
X-Received: by 2002:a2e:9c9a:: with SMTP id x26mr1856283lji.47.1564257323486;
        Sat, 27 Jul 2019 12:55:23 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-186-115.NA.cust.bahnhof.se. [158.174.186.115])
        by smtp.gmail.com with ESMTPSA id e26sm9550684lfc.68.2019.07.27.12.55.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 12:55:22 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     joe@perches.com
Cc:     johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH 00/12] treewide: Fix GENMASK misuses
Date:   Sat, 27 Jul 2019 21:54:55 +0200
Message-Id: <20190727195455.1558-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <c94a0a50c41c7530354b4a662ee945212424c8c7.camel@perches.com>
References: <c94a0a50c41c7530354b4a662ee945212424c8c7.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trimming CC-list.

> It'd can't be done as it's used in declarations
> and included in asm files and it uses the UL()
> macro.

Can the BUILD_BUG_ON_ZERO() macro be used instead? It works in
declarations. I don't know if it works in asm-files, but the below
changes builds an x86-64 allyesconfig without problems (after the rest
of this series have been applied.

/Rikard

---
 include/linux/bits.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/bits.h b/include/linux/bits.h
index 669d69441a62..52e747d27f87 100644
--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_BITS_H
 #define __LINUX_BITS_H
 
+#include <linux/build_bug.h>
 #include <linux/const.h>
 #include <asm/bitsperlong.h>
 
@@ -19,11 +20,15 @@
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
 #define GENMASK(h, l) \
+	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
+		__is_constexpr(h) && __is_constexpr(l), (l) > (h), 0)) + \
 	(((~UL(0)) - (UL(1) << (l)) + 1) & \
-	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
+	 (~UL(0) >> (BITS_PER_LONG - 1 - (h)))))
 
 #define GENMASK_ULL(h, l) \
+	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
+		__is_constexpr(h) && __is_constexpr(l), (l) > (h), 0)) + \
 	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
-	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
+	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h)))))
 
 #endif	/* __LINUX_BITS_H */
-- 
2.22.0

