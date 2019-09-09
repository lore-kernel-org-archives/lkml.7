Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B31CC00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE6E2196E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 03:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uEaSOUzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbfIIDdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 23:33:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37560 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387575AbfIIDdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 23:33:17 -0400
Received: by mail-lf1-f67.google.com with SMTP id w67so9271078lff.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 20:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ccv4bafeDoj3OKZyLytuyRgQXaqdOp558nRaH1DDw7Y=;
        b=uEaSOUzlDLYzmzm1PMbjv5NuefVsfsAps2AHEOdLSvgJaqfJDfgFgi7C0Ml7BzXulW
         ntCFn1MT4fGPeYZtP4SoKaF0TTy6jEyHSotGosPS2Mo24kZOKTaJ/o68Md08gXoyafia
         ugzPtzyS0EK+++Ju/tmVvJCVO3FG6h7OesobrPNJz3nGRrXmkBfZIYfX3Wvp078vJ26N
         9TuWEhKxhHlImuJrznC+r7VCG27z3w0ImSOKj9iV6XEuNcuej3epXwWSaLFt9SycyQs5
         44l7Vj4TVHRKmgOB4xID82VC5UxH8il7HShl7c/JNgVLje7jUyH6G/pXERoZHN+3Cucm
         KwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ccv4bafeDoj3OKZyLytuyRgQXaqdOp558nRaH1DDw7Y=;
        b=ejGE41YhW8FBgMooyvjek7s/0gOoDRzLOnsbMJRc8Z4G8GN7ysMpILBSXn0b7m+X78
         mh89NH13nGHCPn2YgJNmZtOV9vdqWHSgTt3GDo+l6ijabOmX/O142bFtU8zS9pJUxqyH
         4BCiLLJJqLLH6eHUP51zU7l+3wdslrThE18bKyPgtVMbfk/v0YYyh3DMTv6/y+hkVngr
         AXK2FC3LUdPg7KviSoGwl3ctFtMKSnsll5UcDsj2tYBHFrasK8ZgQ7QwUqufSYdEllWL
         NTo7U+LetCM2UvZeR8MmThAfcD6bDymkXHdpCBjpUjmX+g6WVK6B6yWZsxzDWTTSoV7X
         ynFA==
X-Gm-Message-State: APjAAAXEWEBhg4LQy+6B2dhW0UNEEP8OvR7Wj/n9KNHsUlaERPYBjoQx
        OQFCE5XVju3TYLDpR05RAs4=
X-Google-Smtp-Source: APXvYqyfdsvrC8mZOS/gwHyIdepXoGDqmzx/T6Vqmodi8L8QJxfHwe1zW5KJAS++fQUMiEYk272d3Q==
X-Received: by 2002:a19:f111:: with SMTP id p17mr14782421lfh.187.1567999995324;
        Sun, 08 Sep 2019 20:33:15 -0700 (PDT)
Received: from localhost.localdomain (128-73-37-85.broadband.corbina.ru. [128.73.37.85])
        by smtp.gmail.com with ESMTPSA id f22sm2783605lfk.56.2019.09.08.20.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 20:33:14 -0700 (PDT)
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
Date:   Sun,  8 Sep 2019 20:30:18 -0700
Message-Id: <20190909033021.11600-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909033021.11600-1-yury.norov@gmail.com>
References: <20190909033021.11600-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index f9e834841e941..51ee14577166e 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -452,22 +452,22 @@ EXPORT_SYMBOL(__bitmap_parse);
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

