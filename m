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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0C8C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D605B21734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiaY/Y2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgABEbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:31:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41285 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgABEbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:31:17 -0500
Received: by mail-qk1-f193.google.com with SMTP id x129so30605151qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 20:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NpqU1xm4hNnjdFhU/EPerrQR3O04pAhofn4iqB3IAtI=;
        b=CiaY/Y2hjcuthGEwrWBX+bmJHvKILURe9wtlPJrITUCg0xeuX2/TmXxehxHIZ/6xTb
         2ovevQjXdTegn8zqGWPJ2AbmhQAs3aOPIXn13Fej1lYtl3J0nB2wdlJkMIp0p4FIvPEZ
         kyzE/Iii8OTo4IFpVZA6MJSkYcvdnYW6M/K4n4tT/ZiybWisM+1U8u1rN1NP4QmLkr/5
         zXWipEAdgpjeUwSTsEDz0o1MZCH+0sqjBxhZhn5KF4axitUBANp44Yeojzu8N8ySEcxR
         GIMODnOeZA2STR8zicpHuC/Rej3nA1uUSK6ffxiUCxIh/So6enUOodz+1IMh4AuxFu0f
         VlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NpqU1xm4hNnjdFhU/EPerrQR3O04pAhofn4iqB3IAtI=;
        b=g9SnY8eZmgQ43Zr1AcWi1MQueSx4VDXcFtn6t67QWXzJZgkuN7Zf/iquYumvSUtVtx
         3khqfRA3tnWr3WrqL0QP85RCMrPCa43RyVgO4nJtSUjGBoAGBPUl/PIYey6oNgPJ83Rg
         l6zNpOWEauPHmfmMAI7Wi+KVtZdreO18zTWRxiiBLBuKT1ca5UVDHfszX72eN+B5wHRT
         eXrRXezgHzgyQ2Rvw8fKoVWwckKu6XJGtYVe7eHesLtWF5zimNpwFg4u6Td6BrON4tAT
         sfU4uELOsqyVQR46U1uvZ36BNEAe9XUOopAc7vWWoHgiaod52ELkoG0x9qa47kARdB03
         5IVg==
X-Gm-Message-State: APjAAAVBz1QlkKTszI6Dku0MFRAf9fR1ExLD0Ip7BetXe8rRCT81dEXQ
        AwGOz7sYlBu7c8uWGGmQT5k=
X-Google-Smtp-Source: APXvYqxMDHpnokX5Mmv3Dv0kJCX0f2DYioVB7RYrbPHVjtWJ7/yj1LNN138aVEuAm5XrA/NnSGIeSA==
X-Received: by 2002:a37:7b43:: with SMTP id w64mr64699250qkc.203.1577939476511;
        Wed, 01 Jan 2020 20:31:16 -0800 (PST)
Received: from yury-thinkpad.dhcp.amer.jpmchase.net ([2604:2000:4185:2300:b196:4884:e960:2cb8])
        by smtp.gmail.com with ESMTPSA id 16sm14876857qkj.77.2020.01.01.20.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 20:31:16 -0800 (PST)
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
Subject: [PATCH 4/7] lib: make bitmap_parse_user a wrapper on bitmap_parse
Date:   Wed,  1 Jan 2020 20:30:28 -0800
Message-Id: <20200102043031.30357-5-yury.norov@gmail.com>
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

Currently we parse user data byte after byte which leads to
overcomplicating of parsing algorithm. There are no performance
critical users of bitmap_parse_user(), and so we can duplicate
user data to kernel buffer and simply call bitmap_parselist().
This rework lets us unify and simplify bitmap_parse() and
bitmap_parse_user(), which is done in the following patch.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 4250519d7d1c5..b9ac2d42b99e1 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -464,22 +464,22 @@ EXPORT_SYMBOL(__bitmap_parse);
  *    then it must be terminated with a \0.
  * @maskp: pointer to bitmap array that will contain result.
  * @nmaskbits: size of bitmap, in bits.
- *
- * Wrapper for __bitmap_parse(), providing it with user buffer.
- *
- * We cannot have this as an inline function in bitmap.h because it needs
- * linux/uaccess.h to get the access_ok() declaration and this causes
- * cyclic dependencies.
  */
 int bitmap_parse_user(const char __user *ubuf,
 			unsigned int ulen, unsigned long *maskp,
 			int nmaskbits)
 {
-	if (!access_ok(ubuf, ulen))
-		return -EFAULT;
-	return __bitmap_parse((const char __force *)ubuf,
-				ulen, 1, maskp, nmaskbits);
+	char *buf;
+	int ret;
 
+	buf = memdup_user_nul(ubuf, ulen);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	ret = bitmap_parse(buf, ulen, maskp, nmaskbits);
+
+	kfree(buf);
+	return ret;
 }
 EXPORT_SYMBOL(bitmap_parse_user);
 
-- 
2.20.1

