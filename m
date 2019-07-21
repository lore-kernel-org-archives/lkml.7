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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F281CC76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3282171F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PACsRuX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfGUV2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 17:28:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41997 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfGUV2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 17:28:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id t132so16652083pgb.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K8FB9RF5SHEac+q5dj+6I8Eps3UIxveRknLKwpzB0D8=;
        b=PACsRuX5hAyKYzpINx37McFMDJT7DAtuyvT2tkz8AFPE+CMpCIWxeMQKgaTFgB6RSe
         o/rjfCCl3ws0I+su0VaPX/LdXzvg/2IATN8ng1I6mmZJjH1lJQnzeYuAOKCEHFf6qWWn
         wo9zGovjJEBZr9jU+Q+QR1vlToIFceH3Mlk2TxDeXnDD/XSJpcIWra2+DQT4oKvj0emj
         jdII/7VDpixjd8MiHDa8Ge66Dez410XoOvoq/qAN3gisImXRLfCdVlxneloqUKf7c8oF
         DXzc6M67sZmHkFbDPsVCvHS8bG5tjSxOKOeHchw/YcqIe5/IesvyfOP29WyA8NvkL69C
         6Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K8FB9RF5SHEac+q5dj+6I8Eps3UIxveRknLKwpzB0D8=;
        b=KwZv7Gskfo/0LFT1A55WDxFtL0zkhCpMSWqruOL1tL28fToqSL1L0mNi8wQ8JLsf4J
         3ihPZ1uJ6MT1hPMhwT07+D/gyZ7CQ5PGwjZKBzqWB+env3IInny/H4HRCALXvWZAARws
         QKucTJm5jvN/ZAJaVq57T3QIRPktlXkt/eMQzGKCQ6vx0nHhJgNdkj4eM6qs1u1KsXtY
         13s2B3qM3m2S+C4Iq31OxTAqHanZe2F+hUjgVuM3jSVtSouWUkN/ryA5TuQyoi9O6731
         dB1lACzO9zw4LBBG2pWKs3VAlXt1mLesr91uQa/QylSdJ48vdC5dah1EVcHWwaGc/VaP
         RQmg==
X-Gm-Message-State: APjAAAUloKXXH23K++3PrI+Jm5GgbF9wYTCo7jOqVUpp8HfKDnkhnA6o
        t4626aXt8L//aQyVXaSBgYc=
X-Google-Smtp-Source: APXvYqxqzX4rQQ2TQqzoO3iKaxvx/uGKl1b6bF53ZlSlx5pC6hpkEvybLFuAEYZ7NaiOdrLdUhaXcQ==
X-Received: by 2002:a17:90a:bb0c:: with SMTP id u12mr74424195pjr.132.1563744518284;
        Sun, 21 Jul 2019 14:28:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:105:2ef8:a909:5e8d:6363:7009])
        by smtp.gmail.com with ESMTPSA id t9sm37970510pji.18.2019.07.21.14.28.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 14:28:37 -0700 (PDT)
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
Subject: [PATCH 4/7] lib: make bitmap_parse_user a wrapper on bitmap_parse
Date:   Sun, 21 Jul 2019 14:27:50 -0700
Message-Id: <20190721212753.3287-5-yury.norov@gmail.com>
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

Currently we parse user data byte after byte which leads to
overcomplicating of parsing algorithm. There are no performance
critical users of bitmap_parse_user(), and so we can duplicate
user data to kernel buffer and simply call bitmap_parselist().
This rework lets us unify and simplify bitmap_parse() and
bitmap_parse_user(), which is done in the following patch.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <ynorov@marvell.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index bbe2589e8497d..fbd4121c540b8 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -432,22 +432,22 @@ EXPORT_SYMBOL(__bitmap_parse);
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

