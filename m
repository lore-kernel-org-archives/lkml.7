Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D332BC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B49220830
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0qCAX5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfCCRrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:47:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44616 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfCCRrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:47:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id w2so3017068wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 09:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OdgdKxvHCodWmIn4SkSaU9dK2gm8DmroVHVrA/2IPhQ=;
        b=k0qCAX5yiKvyRXT2dedhmsIN6Xvc5//HtJOm+2gpSW/kr7Xl2O7hQl2MM+8eBuVv3e
         mC/+FeJTUX8+PvatD3NoUpuOFAV6XuTPX417KgtjRQQRQHqkKDcFRRweftcnojvNL5pu
         5/4izTLZGn9DLKBnbvdTZ1NcPKuNX0BZHma1rS7t6wF3IDTwwUr8ixqvo3ZNH+bM1a2F
         9c3eYLqw/Wt0/LfqDis3vqouYsEoTpQ0VCh8oGXn4as9iu7UNDsk2vrA2nik1ef7CAc2
         Oyq1CluCNO+KnHMI1TllqdcPn1cgjU7PuRlF6016JEXz8EHDMdchfdQ0c7kCUWDTPNUp
         xC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OdgdKxvHCodWmIn4SkSaU9dK2gm8DmroVHVrA/2IPhQ=;
        b=dnUkQ7yk+DF85lqSj58DiXlU85RCeL0+MoPACmyLJi+mskJQ3vgQFlgJ4D1hqebMSl
         gbi6vzgSb+zQn0R4Krs/Gdz0ajgGvwH8UyXWhNOiwQiwd1aBt0tc8z/sXw3QR3lztPQe
         MVDdtBaMOUk9YgjoLAWY24PS8OEvwIeSm4rMKhaNZxIW8scT4eHfh201wQKkelXMUUaD
         P8TzZ8m5SyHW5r2lDV7EPG8vRySbhLTGNQ7sclk+jPmD9xkZx+cL4ULoZ0pRJNqVXick
         NaqQsOYImzjBuJGHDl2s4Z/B5VcmDkXKcJYxLAcogEKRvAgmseDUagSly8FC4UKMkFxZ
         GmRw==
X-Gm-Message-State: APjAAAVkV9CbnYLysJbqxs8H7aFUbyTYz6EqjA+G14VIWemqjy6LBWmV
        i1ByRArUU/sCutpEZnYY096Q6Khk
X-Google-Smtp-Source: APXvYqyzuW7tDDxVx6CJJwAPSnu2dDcNdDGS9XBdUb7+B6l2PUdNoh9MZXCM2CUm9eZqLoaBQO/NwA==
X-Received: by 2002:adf:e548:: with SMTP id z8mr10432331wrm.52.1551635257584;
        Sun, 03 Mar 2019 09:47:37 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:35a8:f48d:4b19:96c9? (p200300EA8BF1E20035A8F48D4B1996C9.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:35a8:f48d:4b19:96c9])
        by smtp.googlemail.com with ESMTPSA id m26sm3203338wmg.13.2019.03.03.09.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:47:36 -0800 (PST)
Subject: Fwd: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
References: <981d965e-b25b-be2b-2067-07aec5eafc7a@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
X-Forwarded-Message-Id: <981d965e-b25b-be2b-2067-07aec5eafc7a@gmail.com>
Message-ID: <43eb3aad-0e0b-9019-dfe3-47f205607df0@gmail.com>
Date:   Sun, 3 Mar 2019 18:47:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <981d965e-b25b-be2b-2067-07aec5eafc7a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I submitted this through the netdev tree, maybe relevant for you as well.
See also here: https://marc.info/?t=155103900100003&r=1&w=2

-------- Forwarded Message --------
Subject: [PATCH net-next 1/2] lib: string: add strreplace_nonalnum
Date: Sun, 3 Mar 2019 18:20:50 +0100
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>
CC: netdev@vger.kernel.org <netdev@vger.kernel.org>

Add a new function strreplace_nonalnum that replaces all
non-alphanumeric characters. Such functionality is needed e.g. when a
string is supposed to be used in a sysfs file name. If '\0' is given
as new character then non-alphanumeric characters are cut. 

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/string.h |  1 +
 lib/string.c           | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 7927b875f..d827b0b0f 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -169,6 +169,7 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 #endif
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *s, char old, char new);
+char *strreplace_nonalnum(char *s, char new);
 
 extern void kfree_const(const void *x);
 
diff --git a/lib/string.c b/lib/string.c
index 38e4ca08e..f2b1baf96 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -1047,6 +1047,33 @@ char *strreplace(char *s, char old, char new)
 }
 EXPORT_SYMBOL(strreplace);
 
+/**
+ * strreplace_nonalnum - Replace all non-alphanumeric characters in a string.
+ * @s: The string to operate on.
+ * @new: The character non-alphanumeric characters are replaced with.
+ *
+ * If new is '\0' then non-alphanumeric characters are cut.
+ *
+ * Returns pointer to the nul byte at the end of the modified string.
+ */
+char *strreplace_nonalnum(char *s, char new)
+{
+	char *p = s;
+
+	for (; *s; ++s)
+		if (isalnum(*s)) {
+			if (p != s)
+				*p = *s;
+			++p;
+		} else if (new) {
+			*p++ = new;
+		}
+	*p = '\0';
+
+	return p;
+}
+EXPORT_SYMBOL(strreplace_nonalnum);
+
 void fortify_panic(const char *name)
 {
 	pr_emerg("detected buffer overflow in %s\n", name);
-- 
2.21.0


