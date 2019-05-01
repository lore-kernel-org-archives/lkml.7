Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363FCC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CA721743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 01:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA+e/upP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfEABGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 21:06:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36565 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfEABGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 21:06:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so7662467pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 18:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=keS3dQD8Cb6V5fI8fDtNlG4hJozz2dcnbyekIZ9/IQ0=;
        b=cA+e/upPFkrqCEncdqHipMluPbo+oEsFvE1YnOO9/CtzF9dlveVZXWKfSBEFb7oG79
         Clzj6Kz2bP91aYxjc0P39hf5tEvHGjgK27WX3F1SlpHkOxKAHT82l7t6g4u7T4o+JpbD
         1oRu9F+wResofveybBqwlKf1vxsQP50sJf5TFmbKqjpdKde7h8++YM2+OkhvQ/vnzHS9
         6IUYWX6S9CdAgFLIafdWiOBkLde+i3HOEJYXfy8jqjtDJ2OyXopZTFtyCyO6JYIhVej3
         ZGVxmHHUSe5DiPf9M73vK6KEmqv8pxCW88l5wnJV1ve6YAsiwD3c0VG6Im/3PyiCy83I
         TrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=keS3dQD8Cb6V5fI8fDtNlG4hJozz2dcnbyekIZ9/IQ0=;
        b=VpQZJrTP3jlTh6P/ymGdg3vWy3yGXJ3vlP/QMN/cXMlZV7dM0rsOW+/x1acDP9xF5j
         2mu8Vv52+tkeEGMe6v5oubrqA/7rs7JS5GhmSCMitKYEOYUQaH7hOLQpbiTPFpeis/8Z
         REWEcgq4fEUN0Zn04hjk/nLQOAg89gLCzuw6EeU8R/7Vb5bJGJdvPsRAnxA2MshjNBnT
         GpsOWfmD/bD8HrgZTDPwUHPPzuIYu2x1tXN21/WK+LbvwQq4Jkz2tdJ3QXMPV+2QDKnp
         GXu8BhzW+x8EpPcEZnwUkHZF8DiMi1ksnbOqubxLCDxuW51CubjJqtzaQyWM8E7iEKQI
         n64w==
X-Gm-Message-State: APjAAAUxdXM+ARgO5DCj1cuPndSCz2rRjTA5uZcKEoMJRvPwseHXp34F
        7SMy6zdlwUlPoBihxbbd8zg=
X-Google-Smtp-Source: APXvYqxvCRtK6SVcEX33zvCttRjKc3daJzgQQl1wmztmi+Rcqj1VhJtZhA7f5b/XNMxKIaTWM8woeg==
X-Received: by 2002:a63:5b4d:: with SMTP id l13mr70026732pgm.160.1556672805559;
        Tue, 30 Apr 2019 18:06:45 -0700 (PDT)
Received: from localhost ([2601:640:7:332f:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id 10sm50167247pfh.14.2019.04.30.18.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 18:06:45 -0700 (PDT)
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
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <ynorov@marvell.com>, Yury Norov <yury.norov@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 2/7] bitops: more BITS_TO_* macros
Date:   Tue, 30 Apr 2019 18:06:31 -0700
Message-Id: <20190501010636.30595-3-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501010636.30595-1-ynorov@marvell.com>
References: <20190501010636.30595-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce BITS_TO_U64, BITS_TO_U32 and BITS_TO_BYTES as they are handy
in the following patches (BITS_TO_U32 specifically). Reimplement tools/
version of the macros according to the kernel implementation.

Also fix indentation for BITS_PER_TYPE definition.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 include/linux/bitops.h       | 5 ++++-
 tools/include/linux/bitops.h | 9 +++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index cf074bce3eb3..e61c4e614264 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -4,8 +4,11 @@
 #include <asm/types.h>
 #include <linux/bits.h>
 
-#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
+#define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
+#define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
+#define BITS_TO_BYTES(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index 0b0ef3abc966..a8ba37a50d08 100644
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

