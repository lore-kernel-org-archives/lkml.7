Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA55C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4D1205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM4z/Nb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfD1D3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 23:29:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35780 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfD1D3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 23:29:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so3622988pfh.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 20:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yW25BIpw+3OdLrz2ZA6bQCaxdj/ZNzRUZJYjM1RP07U=;
        b=RM4z/Nb05WzDoLahxMBCYF4Q8IllpFaEJDf8a6fQ0p9uWyGtVrTJT1rupLk56+zjil
         s7rTbFmE4KrEkdKyNLqiVI5hDhahUWMYZby30123iIwAa3DGCILLC98kyBVnmGiMgRyA
         sCOn4gviOIAJmM0O7QcwX1UHQMxTNRZQRH9mSXgAwNmOcpImfft1F7o2S0IxZRHw4Cui
         i1OHt+BoX10nosrFuto8+0oitm4f71aRkacQwD0l5dbTc2tMfKQQ3gY36RB3NP1rsgCu
         ppX7CXRn5+/hek9j7d40xLzfTQvenzaZN4BPJXl6d7Mt6lLdvvE2xcTPDswE/eKGJGrQ
         daBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yW25BIpw+3OdLrz2ZA6bQCaxdj/ZNzRUZJYjM1RP07U=;
        b=uLn+YGw8P2qljV/giajmFgC4no8GSpjCOFxbS1Odu3HuSFQUCKY2buxMLVDYMp2caX
         8qNO1H/YplQNb8xdjpKwu5wfCmeP+cU8NwnuCGN0bXph8YuOsFyGojTpWYXrRG0pJxAp
         6bTIu4sYSSwH19uusrHwVs5SuhSThy9uQDSTR/3ASYKywJDi7tdRD8QOxcY+iEJs9tuH
         scAFDSuVX3s2+avESuNLGxJepLV3TnL10G7XQM8rh7W8ZmYivCaoTtg9fFUsiOdv+192
         nesHJITGP5ho6xv+7BfioxapDNa6OmhOeUUtH5UOV7tUGvmgL7bkJo/UMKnH3IwwIaP6
         lhxw==
X-Gm-Message-State: APjAAAVkTm3SSKcdl2shudfPMENR+72vvSHXUM9p+eI/LrOMauU6gFBi
        B+8Wvxi8DQAI0HWEi7Q+6iw=
X-Google-Smtp-Source: APXvYqwntT4VxgilEGo0GTeJ7I5DTmDtSzMB9cKie0r6ZFjIY4MddobH8Q74W1UjHCKYFnMIUJj0/A==
X-Received: by 2002:a63:5466:: with SMTP id e38mr52979594pgm.340.1556422188183;
        Sat, 27 Apr 2019 20:29:48 -0700 (PDT)
Received: from localhost ([2601:640:6:3484:bc53:6e04:b584:e900])
        by smtp.gmail.com with ESMTPSA id o9sm22758505pgh.68.2019.04.27.20.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 20:29:47 -0700 (PDT)
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
Subject: [PATCH 3/6] lib/bitmap: make bitmap_parse_user a wrapper on bitmap_parse
Date:   Sat, 27 Apr 2019 20:29:33 -0700
Message-Id: <20190428032936.1317-4-ynorov@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190428032936.1317-1-ynorov@marvell.com>
References: <20190428032936.1317-1-ynorov@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we parse user data byte after byte which leads to
overcomplicating of parsing algorithm. There are no performance
critical users of bitmap_parse_user(), and so we can duplicate
user data to kernel buffer and simply call bitmap_parselist().
This rework lets us unify and simplify bitmap_parse() and
bitmap_parse_user(), which is done in the following patch.

Signed-off-by: Yury Norov <ynorov@marvell.com>
---
 lib/bitmap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index f235434df87b..300732031fad 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -434,22 +434,22 @@ EXPORT_SYMBOL(__bitmap_parse);
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
2.17.1

