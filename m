Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB37BC76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFCF20644
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8SLlfk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfGUV2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 17:28:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41996 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfGUV2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 17:28:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so16652027pgb.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 14:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oRUP0UchEpb1eSfjO5KwsTKWdyNrE42klGRqHKw10R8=;
        b=g8SLlfk450vAV4efCicxziHHy5E6yfnUav8u6W439Ydu2G02goGRgAkCblOxYlcOzd
         smNYiC6MlIEAHM4nVUY3Z8KCDbHUeHQ23reNfNEiCaoHyJfRWtxRnuTYZUKI9RrSRn+Z
         dh5hbdxsCOxVAfR2Ruy9uYijZLY/sijgubVfap7M/IrprmrnarGuC+YAlRamJ6/RGkFP
         ijIbtB6qQA+zWEZw/9sCqV6f70v3oYio5TAhuuUGuOtnjLDNALaFdjlmSnZru9RbH52V
         U8+hEOpgPH/YCxHkERJIVQn5zCL8Z7MYuqArfm3dbB6CDGn4v+g4Y8Mn2QMDKISnu1Vy
         7KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRUP0UchEpb1eSfjO5KwsTKWdyNrE42klGRqHKw10R8=;
        b=gGOn4chS7KHgAeW41zXeh02r0EFeQ9yQJDk0VQL+LGQEsm1BsAncygvdCxW1rTxUMh
         Vb+qPcwFe3fV7PM3LgMZ08SvZUs8d3tkfgtqQvS380RKc6aQN8gBXACXQyYoqdD25vd5
         nHENxKQihN1CKJEcRi3M9ipGHmgFqgJWm3+ldrmGnDlo048a6D9xb6h2TdXgIvd5f/De
         Y+ru0hF7pYU3m2BY9wFfzA7OeHBGCUV8NImP3d0ITnhaHTJ79ZLPHPzsj1gbbtdTaHhB
         dnXFmfTnb0AsnuJXaFvmoERNMkkHsiYpCvge4cENkB0e7V0p7utVGpwh9rQoyws93KfD
         kDEA==
X-Gm-Message-State: APjAAAXi55iaXlOYgGC6pF00womkUxAUSJIVh0B3Z0UVmoD5u58eRd9Y
        //QT4OF3GsFcLvDRCz+Qze0=
X-Google-Smtp-Source: APXvYqwXqHZx2wDfizM5tdWsc7rNznj+baARiHj10+ZPir5xq7P2OnuOFDf/JlMTqVCsKf8RHF5bMA==
X-Received: by 2002:a17:90a:2023:: with SMTP id n32mr70338845pjc.3.1563744514622;
        Sun, 21 Jul 2019 14:28:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:105:2ef8:a909:5e8d:6363:7009])
        by smtp.gmail.com with ESMTPSA id t9sm37970510pji.18.2019.07.21.14.28.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 14:28:34 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
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
Cc:     Yury Norov <yury.norov@gmail.com>, Yury Norov <ynorov@marvell.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 2/7] bitops: more BITS_TO_* macros
Date:   Sun, 21 Jul 2019 14:27:48 -0700
Message-Id: <20190721212753.3287-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190721212753.3287-1-yury.norov@gmail.com>
References: <20190721212753.3287-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yury Norov <ynorov@marvell.com>

Introduce BITS_TO_U64, BITS_TO_U32 and BITS_TO_BYTES as they are handy
in the following patches (BITS_TO_U32 specifically). Reimplement tools/
version of the macros according to the kernel implementation.

Also fix indentation for BITS_PER_TYPE definition.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <ynorov@marvell.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitops.h       | 5 ++++-
 tools/include/linux/bitops.h | 9 +++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index cf074bce3eb32..e61c4e6142641 100644
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
index 0b0ef3abc966e..a8ba37a50d086 100644
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
2.20.1

