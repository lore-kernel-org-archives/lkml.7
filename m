Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3BDC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC57A205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2oBGk1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfD1D3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 23:29:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33016 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfD1D3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 23:29:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id y3so2575719plp.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 20:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lf7Pn102VRECpBWkPWLUC4FT7Hq7UjO+2Zgtn7zYt9U=;
        b=L2oBGk1iDlIwfk6YbG/L9fLG0xK9O6g/Py4aizbhGLYrUl/mMq/+btyr/WE8Fyiq85
         OVZ8fBmaHGRwaVWc5+XFvccR6J8FFkS6nvZsO8zrWbSygk7CBIJGXYgiYlMucC0oyRVp
         B5lnFT1es4CFZJvRb297nM5ajS/9/yGGx6Jwc3Js8Iu9l/4AcsrF0llbMVRRKnwMejTu
         kqEaGBvchsfGm3gSLkYym1gDKp6f2U1TmqKiQbGJCb39a2VCPy5fu1WuYFJDdBSQwBai
         XKoaavLswR2ACnng0kkBniGJUVTUUoSYNonKgC0zGr58m/qh6RINX3dJvMHlUlZ5jSFz
         FtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lf7Pn102VRECpBWkPWLUC4FT7Hq7UjO+2Zgtn7zYt9U=;
        b=W8xgXGzMU1qYr0AAY0JLdqCYU/Rlua8RW7XJBc25zc85cF9mHA7ydxXsdycTnK5dIt
         T6ftq6veJPhkNaaa6wMa/aU3YlejXQDRBObb38uOLpaCtkRxwQZpgtqe9z40DFldirHi
         uy7x49t/jQcsYTwXbC0SUItnZ5WI2aSEaxw6dBiEP/wL0M3aWtK/GXuW3BmwokTg3bB2
         ywcPa57Z6p6ALIsFDogVKLmpnT8Hp7u6ew68u4PSfgWJBidpMwPi30YzC7NH/vqHl/UT
         4sPc/Kugm++7yHTQyHiJNp36ypNx0+FTf2yyJtQqAQTgdWmWubvgQ7yrSHAhoHr7WnV0
         1BNQ==
X-Gm-Message-State: APjAAAUTodVUwlRNj6woT8OKuxTijQC6osXLjM8ausTWgdDBXSdJjZ87
        ueDsWv8NkblA0/eZx/Y9yNs=
X-Google-Smtp-Source: APXvYqyEkzGVRTyBS9u2/HAaxQqZHTUZpuzaP/0B1enpx2h+VfZRjB+K7J4WrXdjJkoRjF4OGyoDGw==
X-Received: by 2002:a17:902:f209:: with SMTP id gn9mr55442585plb.109.1556422186244;
        Sat, 27 Apr 2019 20:29:46 -0700 (PDT)
Received: from localhost ([2601:640:6:3484:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id c28sm19513732pgm.42.2019.04.27.20.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 20:29:45 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@marvell.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Yury Norov <ynorov@marvell.com>, linux-kernel@vger.kernel.org,
        Yury Norov <yury.norov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 2/6] bitops: more BITS_TO_* macros
Date:   Sat, 27 Apr 2019 20:29:32 -0700
Message-Id: <20190428032936.1317-3-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190428032936.1317-1-ynorov@marvell.com>
References: <20190428032936.1317-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce BITS_TO_U64, BITS_TO_U32 and BITS_TO_BYTES as they are handy
in the following changes (BITS_TO_U32 specifically). Sync tools/
version of the macros with the kernel implementation.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 include/linux/bitops.h       | 3 +++
 tools/include/linux/bitops.h | 9 +++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index cf074bce3eb3..3477e179dca7 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -6,6 +6,9 @@
 
 #define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
+#define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
+#define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
+#define BITS_TO_BYTES(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index 0b0ef3abc966..959dcb8214ba 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -13,10 +13,11 @@
 #include <linux/bits.h>
 #include <linux/compiler.h>
 
-#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
-#define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u64))
-#define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u32))
-#define BITS_TO_BYTES(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE)
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
+#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
+#define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
+#define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
+#define BITS_TO_BYTES(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
-- 
2.17.1

