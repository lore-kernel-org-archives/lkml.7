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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8772C76196
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3E621721
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsdNsgdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfGUV2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 17:28:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43439 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfGUV2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 17:28:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so16372277pfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 14:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2Z6q8ck1RIyh1hSmuStD87TyKPTUPv+AqsUwd0PZas=;
        b=UsdNsgdKUucUE1b5Vo2HibCW9ifgF34ltHi3FJubq3dY3okBQK4kF2wL1LZkTiADXE
         d8+NGVFRyeCwIBx3vJs3JqMI6x4XAtc3RY1KDGj8kEq9xQhmfcmoSfGn1V4ZMsH26Rue
         nVk63uE1VPamZJ51xS2IwGWH9I3J3T56ujxoBCcG5dJjlCoiusbkhTrvb9ygvyLokMIv
         jJbuH/AhVFNF3frQVbsl55FnqPfltm7/XJ4Rx6TUB9YOWDLRUe+2hffzaxK8zna9ezrS
         N/UQhRF4kuHvmRyFlirI8NvSaUMlxEwSJDRbPvnJdDCWanK/ULBkivy59TarfbwcwW/D
         H6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2Z6q8ck1RIyh1hSmuStD87TyKPTUPv+AqsUwd0PZas=;
        b=jzRrIWXrT+ikaO9VsRNOG3caj8RI5MAbVIWkPw9PDvGTbLfyAGovAdwLRgvXRKKneS
         y/y0MFwNTdu6atJZdl9dITD1vHCzIwz5W1gt7Bxo54ZMsLk+hKkWB/BMWaP3yHoZKfPV
         D4qCpgYkaNFchB3yzaTXbiPtVDWZsYugEyoga5blQYDJN8ebXh4534hDxIoDJRFKrllk
         hHQlPc5Kra3g+3Qedxc7jr3zWIzLKJih79xuhrGGZaLpz18sxfMSk3U+cc61uEksjwbD
         3oEp6XNYj1QnOahKnUQk6Bkn5ymlWu9isXy+RHQlg9pKMGfTFBllQxts8s7mGbzaM2M7
         iXTQ==
X-Gm-Message-State: APjAAAUIhejL24ffDoOWt0rdnXM/Hgv0MwVDt4I6wZ/6RECm5sKq8uXM
        H7TrR8qqPyQRECQ1MKBB72c=
X-Google-Smtp-Source: APXvYqx8mp+hft3QwW7/KNHUelenEkP0bS0mYY83EGIt50wQtccAnEXlnS+Jff26wsdogvQ0mxWeug==
X-Received: by 2002:a65:464d:: with SMTP id k13mr61606941pgr.99.1563744512754;
        Sun, 21 Jul 2019 14:28:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:105:2ef8:a909:5e8d:6363:7009])
        by smtp.gmail.com with ESMTPSA id t9sm37970510pji.18.2019.07.21.14.28.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 14:28:32 -0700 (PDT)
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
Subject: [PATCH 1/7] lib/string: add strnchrnul()
Date:   Sun, 21 Jul 2019 14:27:47 -0700
Message-Id: <20190721212753.3287-2-yury.norov@gmail.com>
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

New function works like strchrnul() with a length limited strings.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <ynorov@marvell.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/string.h |  1 +
 lib/string.c           | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 4deb11f7976bc..ae934d6c50bf5 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -62,6 +62,7 @@ extern char * strchr(const char *,int);
 #ifndef __HAVE_ARCH_STRCHRNUL
 extern char * strchrnul(const char *,int);
 #endif
+extern char * strnchrnul(const char *, size_t, int);
 #ifndef __HAVE_ARCH_STRNCHR
 extern char * strnchr(const char *, size_t, int);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 461fb620f85f3..5b5fee266c193 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -432,6 +432,23 @@ char *strchrnul(const char *s, int c)
 EXPORT_SYMBOL(strchrnul);
 #endif
 
+/**
+ * strnchrnul - Find and return a character in a length limited string,
+ * or end of string
+ * @s: The string to be searched
+ * @count: The number of characters to be searched
+ * @c: The character to search for
+ *
+ * Returns pointer to the first occurrence of 'c' in s. If c is not found,
+ * then return a pointer to the last character of the string.
+ */
+char *strnchrnul(const char *s, size_t count, int c)
+{
+	while (count-- && *s && *s != (char)c)
+		s++;
+	return (char *)s;
+}
+
 #ifndef __HAVE_ARCH_STRRCHR
 /**
  * strrchr - Find the last occurrence of a character in a string
-- 
2.20.1

