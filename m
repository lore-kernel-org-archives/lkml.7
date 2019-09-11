Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CB0ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69B3222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2Pl0HTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfIKFMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:12:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46921 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfIKFMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3so10863201pgv.13;
        Tue, 10 Sep 2019 22:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E1vVs3Lzody5lrf1o5ZR077jKGjcCEkV/NBzcDZrQso=;
        b=V2Pl0HTIX2QlLG1iLAkV58snVQjE0MkmuArkqfGK3bYdjoPUwfTe9RnyQ88HJIXhOW
         TugiuIj5wrWS8dVUbLAwsbnoMXlOsRZn4R3IuaZDgLuT7MXJVFSY7R0TStUse+IMf771
         Ed7NBuTKMQvHcIOvVquXo3AKO35x3jUGnV6liXexFVZ9f4DWxDD2GgXeHdE9GMKZKlzx
         TBfGLo8N+6EhBqosOcXM1hmpc5bo01nMdtIO3gSPBQxawdPi5vSzPpGpyLdJcvIQQvQE
         4iWVEPRY4cf+BGoasI/NAApYZc+JXkNxZegfaRYlYqoe2I3q5qLiNSh3an0wsiNcvcCi
         9BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E1vVs3Lzody5lrf1o5ZR077jKGjcCEkV/NBzcDZrQso=;
        b=n+0EnpjoT6sM8fInrSwxiRFYp0OmAZnhAzf/ndbFYz075nq2StpH+wqs4oX9OTVSxk
         u0Gpnrlq38MNJq4iHVqH3FXXYpb+WvA3fUjdg/ZfJg4K1WQW8qMkCRNFbGtw+SZQvb0X
         nYntGW02uVNOQb5IjJ069yMSJ9aTNDTtx6DOwpVPEfsuHgbYvT+QJq+W1a5d9xeLJKWL
         KH69FCD06EjXp5FuzrsUY74xZB+/5YT08yFT1H6AAC1FWE6q8EaTLsL1uvrI6ND4CtlL
         OpRh/fW9EQF/3vrmuSGujqj7oFaQ4FShyPXuHg5quXKxLkHTKzqeCLDWbXRjMdHwCL7i
         gMHg==
X-Gm-Message-State: APjAAAXBymeJhr5FAZjXOW8hNRVbz4s+6Okhdj4j34MyuuspQZAc2ynB
        vS1AsHf6Qbzm/HH2BhxL2to=
X-Google-Smtp-Source: APXvYqzzWqGo9Ae1XocivC2km4QBMwwacG5wThNB7peEYMoUlbV8+7vKWkD6k9xpcSbihHGxKZTNoA==
X-Received: by 2002:a17:90a:ff04:: with SMTP id ce4mr3438503pjb.121.1568178765635;
        Tue, 10 Sep 2019 22:12:45 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:44 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 07/14] software node: remove property_entry_read_uNN_array functions
Date:   Tue, 10 Sep 2019 22:12:24 -0700
Message-Id: <20190911051231.148032-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
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
index 726195d334e4..a019b5e90d3b 100644
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
2.23.0.162.g0b9fbb3734-goog

