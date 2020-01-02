Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D044C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3846215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaW4BGa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgABEbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:31:17 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38937 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgABEbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:31:15 -0500
Received: by mail-qv1-f67.google.com with SMTP id y8so14621241qvk.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 20:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lr/CRIb3WCPvkvNHOSIItQps2qBcOEYnNrElWW5KHfc=;
        b=qaW4BGa1AoUwUnlQsjObUfkDcR25ot+NuHTvWENBBqh38xzH+cEeFSiDNibFGIRwzW
         tZiKLQNwRJPxit1y+vJZrjDN2S//IRUrYTNP8KNk3pOmd8nzeT+q3KXdh1wXp1CkYkUn
         J/yTaiewGUhnvYkA3oh5vHVfPY4MfStTXMTYvZLWO/Ztm9GwXj/09ELpy5ij5817m7WR
         KqImYmNVRjMCkSvTE8mNqzLI3Se7NuBA9UwseCPkEdKVk3PFOtaIrbTnwAXnke5FMjmj
         GXI7jv17hk1/G9+/eJ5JiLOsDr+CBk1lPq7BFQuIaoVQLFtSMq1gCvAsFoo7ybLenn9Z
         XFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lr/CRIb3WCPvkvNHOSIItQps2qBcOEYnNrElWW5KHfc=;
        b=frgYQOPXvSFqZRXFT58/83UupJlhNRZRGJsTBW5zO69u91Ljr9yUQY7jPTJ9XebG/P
         VuURlN3ZT4Cyj2sSNaefeVnZH8aikhdokHcOkQ39crrlkTRaFkimYLj27iI4463+hM2O
         /8Hz5Hl03beGagFq/cBx4GaTGSkR5Lw4X/EmzwfETVYO61bmHIJslPsTHs7CIZYK0hRs
         XCJcJ6m+Ro7XxpEVSD1fhBKe5vUNtj+S+A5XD1VAvKbsaWd0SUDKKKC2ykoj7G0WSXiT
         BWNdT9HFdY4vv1mXwI0wZes1RYQyxhiBzXnJdYftxNrsik+jK+2wLcsXDo9CKCi+pGcb
         c8Tg==
X-Gm-Message-State: APjAAAWzvJZoPDI7SvYEy4xjikxUbJhQIARviBif40Sqfgf2CADK3Xel
        qo2ZBvQdIfVLLFa2NJLxAFnycpwX7DA=
X-Google-Smtp-Source: APXvYqzQ3HsIrYdTo+atQwUNSR3hHAKIbJNYDl9uTQ+iKKsr1Oqp+J6gKYo7gSBiTAfXIy8Y7XkO6w==
X-Received: by 2002:ad4:53a5:: with SMTP id j5mr60186037qvv.239.1577939474014;
        Wed, 01 Jan 2020 20:31:14 -0800 (PST)
Received: from yury-thinkpad.dhcp.amer.jpmchase.net ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id 16sm14876857qkj.77.2020.01.01.20.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 20:31:13 -0800 (PST)
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
Cc:     Yury Norov <yury.norov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 2/7] bitops: more BITS_TO_* macros
Date:   Wed,  1 Jan 2020 20:30:26 -0800
Message-Id: <20200102043031.30357-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200102043031.30357-1-yury.norov@gmail.com>
References: <20200102043031.30357-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Yury Norov <yury.norov@gmail.com>

Introduce BITS_TO_U64, BITS_TO_U32 and BITS_TO_BYTES as they are handy
in the following patches (BITS_TO_U32 specifically). Reimplement tools/
version of the macros according to the kernel implementation.

Also fix indentation for BITS_PER_TYPE definition.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitops.h       | 5 ++++-
 tools/include/linux/bitops.h | 9 +++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index e479067c202c9..47f54b459c264 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -11,8 +11,11 @@
 #  define aligned_byte_mask(n) (~0xffUL << (BITS_PER_LONG - 8 - 8*(n)))
 #endif
 
-#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
+#define BITS_TO_U64(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
+#define BITS_TO_U32(nr)		DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
+#define BITS_TO_BYTES(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
 extern unsigned int __sw_hweight8(unsigned int w);
 extern unsigned int __sw_hweight16(unsigned int w);
diff --git a/tools/include/linux/bitops.h b/tools/include/linux/bitops.h
index 140c8362f1139..5fca38fe1ba83 100644
--- a/tools/include/linux/bitops.h
+++ b/tools/include/linux/bitops.h
@@ -14,10 +14,11 @@
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

