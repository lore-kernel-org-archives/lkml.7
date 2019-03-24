Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2B1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 07:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A8221019
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 07:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfCXHSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 03:18:16 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42662 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfCXHSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 03:18:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id w139so4681610oie.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 00:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p6YU+zDYiefJ3LfU1CTV9V30b9NyJOktuTy7ANCETss=;
        b=bGfvkJEunD5GebC8uSzuy/8C/csSUfy4RvB+ajbfyAIAb56YnuKUhz0CrcD6OzpRZM
         5snnJSuQYMYw/KEPZR01khVTZI0c+br7VcK7duCnUet7+jvVVhns6nveMauCindvnHeu
         HGn9EhDEL+IixbZNfGj7OmRWVORAjWc2CntBTzfZoPWGS5eFUl8/0LATz6tIeKwARjFm
         lzbch8hjywuh2BwP/r5RFuMzqipgp5TEX+uA/hquBJS45rwWQQfb/sWubB3t45sNTu62
         epJLrs+VWL1b5Nj589bV6WTh9E6CTpzVRWK61UibOPn7vnsVuj3cg1+yEMUZWF7KPSI5
         jTXQ==
X-Gm-Message-State: APjAAAVvkNfC8qpjSDCAJkFU46YLQA7kE5clN5tVp9XgjXRdHImvNfQr
        z1FmYR73lkXtgicEls4BTN4=
X-Google-Smtp-Source: APXvYqxADTAtfZOswOsCabuhfOEPM0VXy3THdVtp+XxxcWPnG7BwQ7MaOd2pT8cc8DnVQGgxxAWd7A==
X-Received: by 2002:aca:4e50:: with SMTP id c77mr7636817oib.109.1553411894460;
        Sun, 24 Mar 2019 00:18:14 -0700 (PDT)
Received: from sultan-box.localdomain ([107.193.118.89])
        by smtp.gmail.com with ESMTPSA id w141sm2379363oie.1.2019.03.24.00.18.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 00:18:13 -0700 (PDT)
Date:   Sun, 24 Mar 2019 00:18:07 -0700
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, keescook@chromium.org, linux@rasmusvillemoes.dk,
        rostedt@goodmis.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Subject: Re: [RFC v3] string: Use faster alternatives when constant arguments
 are used
Message-ID: <20190324071807.GA29837@sultan-box.localdomain>
References: <20190324014445.28688-1-sultan@kerneltoast.com>
 <20190324022406.GA18988@sultan-box.localdomain>
 <20190324033153.GA15815@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324033153.GA15815@archlinux-ryzen>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 08:31:53PM -0700, Nathan Chancellor wrote:
> Explicitly cc'ing some folks who have touched include/linux/string.h in
> the past and might want to take a look at this.
> 
> Nathan

Thanks. One last revision with some nitpicks fixed is attached, though I doubt
it'll influence any comments on the concept of this anyway.

---
 include/linux/string.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b875f..40a8a9436 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -476,4 +476,34 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
 	return strncmp(str, prefix, len) == 0 ? len : 0;
 }
 
+/*
+ * Replace some common string helpers with faster alternatives when one of the
+ * arguments is a constant (i.e., literal string). This uses strlen instead of
+ * sizeof for calculating the string length in order to silence compiler
+ * warnings that may arise due to what the compiler thinks is incorrect sizeof
+ * usage. The strlen calls on constants are folded into scalar values at compile
+ * time, so performance is not reduced by using strlen.
+ */
+#define strcpy(dest, src)							\
+	__builtin_choose_expr(__builtin_constant_p(src),			\
+		memcpy((dest), (src), strlen(src) + 1),				\
+		(strcpy)((dest), (src)))
+
+#define strcat(dest, src)							\
+	__builtin_choose_expr(__builtin_constant_p(src),			\
+		({								\
+			memcpy((dest) + strlen(dest), (src), strlen(src) + 1);	\
+			(dest);							\
+		}),								\
+		(strcat)((dest), (src)))
+
+#define strcmp(left, right)							\
+	__builtin_choose_expr(__builtin_constant_p(left),			\
+		__builtin_choose_expr(__builtin_constant_p(right),		\
+			(strcmp)((left), (right)),				\
+			memcmp((left), (right), strlen(left) + 1)),		\
+		__builtin_choose_expr(__builtin_constant_p(right),		\
+			memcmp((left), (right), strlen(right) + 1),		\
+			(strcmp)((left), (right))))
+
 #endif /* _LINUX_STRING_H_ */
-- 
2.21.0

