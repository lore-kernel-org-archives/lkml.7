Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDEFC00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA7A2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE+X37pV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbfIIIQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41621 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388916AbfIIIQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so7371489pgg.8;
        Mon, 09 Sep 2019 01:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdFrF4kqXfmGSe2ALsY5G2nBL3lyWxDSNKJUbnUAk5Q=;
        b=jE+X37pVimPNz8wxNG/xCcqLPw36+vaR+nviOmlSI7B6OGNc8BdZfKM0O8tTKkItLF
         pDpwNLK/bZBp6Hl3vq+TeKufOnCVq2XAo50lFM0r5zBsbDpsJ5z7T9uG858VlQSXDCJC
         dpiEY8mLoEcnpzT5+q1iGoXJwr3H9zF4awIWvO1t8KDGV2IIbu+Kni6xrg0BQZTMvrc2
         uC9VI+Qe9swDRw57tcnR7wqgMVJK1qkCClGFLG9LIk27SECWU4LX7xwM4UQmyNaN+0Kq
         6JUoIjHKTlw0ngo+asoV7zoXQQsEeHPvFsmri9Kbf1PN/WD+qM6KUn8X2Xv2sJzd2Ovs
         rSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdFrF4kqXfmGSe2ALsY5G2nBL3lyWxDSNKJUbnUAk5Q=;
        b=QLxnC76yAQIuiLHwyOJsldZT66zIr49QU6/7QySXimEMHZpUE8ZcwPzZp4HlpiM+6p
         wvqRzSg3OoYFNRon7aPnafo3x420lTPqEKCydtNOLSbXmUmr+NolIqXdMiJJGIoQUD1W
         brvem1h2E7+PZaGxAiARNcPZx8Bk6x/3vBt6jTlPMtzcak4f9oKQ8KuYyivscYU8KGO3
         322zkX46D5KD1Hts6X14RSy3RzFBiYnEjQlBnDMyhmTKgl7flIsal8IBPCBhv8SA/xSb
         5osmTzBPwk6dNgePyCE/o0bP+zOejrwUwxhlZE5+stTn2LEIsxcxbE70gI8ZZ3H06bMz
         DRiQ==
X-Gm-Message-State: APjAAAUpjVdnVCTPgQveZn8eljWmwX6LCFawtNpKhlBmHxuTJ4Fe5z4l
        7za/kw8yUzrm77e9gwF1u9k=
X-Google-Smtp-Source: APXvYqysTwLG9wNm1R6USqSGzJzOoGG9ZxL+ksUkqDLcbdnr4hk7dDyMwM2DxhgnW1PSf9WLPxKZcA==
X-Received: by 2002:a63:de07:: with SMTP id f7mr21017561pgg.213.1568016968349;
        Mon, 09 Sep 2019 01:16:08 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm12686669pfu.104.2019.09.09.01.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 01:16:06 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 05/13] software node: remove property_entry_read_uNN_array functions
Date:   Mon,  9 Sep 2019 01:15:49 -0700
Message-Id: <20190909081557.93766-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is absolutely no reason to have them as we can handle it all nicely in
property_entry_read_int_array().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c | 85 +++++++------------------------------------
 1 file changed, 14 insertions(+), 71 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index bedc26189bed..a0629365972d 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -131,66 +131,6 @@ static const void *property_entry_find(const struct property_entry *props,
 	return pointer;
 }
 
-static int property_entry_read_u8_array(const struct property_entry *props,
-					const char *propname,
-					u8 *values, size_t nval)
-{
-	const void *pointer;
-	size_t length = nval * sizeof(*values);
-
-	pointer = property_entry_find(props, propname, length);
-	if (IS_ERR(pointer))
-		return PTR_ERR(pointer);
-
-	memcpy(values, pointer, length);
-	return 0;
-}
-
-static int property_entry_read_u16_array(const struct property_entry *props,
-					 const char *propname,
-					 u16 *values, size_t nval)
-{
-	const void *pointer;
-	size_t length = nval * sizeof(*values);
-
-	pointer = property_entry_find(props, propname, length);
-	if (IS_ERR(pointer))
-		return PTR_ERR(pointer);
-
-	memcpy(values, pointer, length);
-	return 0;
-}
-
-static int property_entry_read_u32_array(const struct property_entry *props,
-					 const char *propname,
-					 u32 *values, size_t nval)
-{
-	const void *pointer;
-	size_t length = nval * sizeof(*values);
-
-	pointer = property_entry_find(props, propname, length);
-	if (IS_ERR(pointer))
-		return PTR_ERR(pointer);
-
-	memcpy(values, pointer, length);
-	return 0;
-}
-
-static int property_entry_read_u64_array(const struct property_entry *props,
-					 const char *propname,
-					 u64 *values, size_t nval)
-{
-	const void *pointer;
-	size_t length = nval * sizeof(*values);
-
-	pointer = property_entry_find(props, propname, length);
-	if (IS_ERR(pointer))
-		return PTR_ERR(pointer);
-
-	memcpy(values, pointer, length);
-	return 0;
-}
-
 static int
 property_entry_count_elems_of_size(const struct property_entry *props,
 				   const char *propname, size_t length)
@@ -209,21 +149,24 @@ static int property_entry_read_int_array(const struct property_entry *props,
 					 unsigned int elem_size, void *val,
 					 size_t nval)
 {
+	const void *pointer;
+	size_t length;
+
 	if (!val)
 		return property_entry_count_elems_of_size(props, name,
 							  elem_size);
-	switch (elem_size) {
-	case sizeof(u8):
-		return property_entry_read_u8_array(props, name, val, nval);
-	case sizeof(u16):
-		return property_entry_read_u16_array(props, name, val, nval);
-	case sizeof(u32):
-		return property_entry_read_u32_array(props, name, val, nval);
-	case sizeof(u64):
-		return property_entry_read_u64_array(props, name, val, nval);
-	}
 
-	return -ENXIO;
+	if (!is_power_of_2(elem_size) || elem_size > sizeof(u64))
+		return -ENXIO;
+
+	length = nval * elem_size;
+
+	pointer = property_entry_find(props, name, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(val, pointer, length);
+	return 0;
 }
 
 static int property_entry_read_string_array(const struct property_entry *props,
-- 
2.23.0.187.g17f5b7556c-goog

