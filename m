Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A5CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAAC21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 20:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjt/QIY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405655AbfJWUCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 16:02:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38930 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405370AbfJWUCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 16:02:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id p12so12762900pgn.6;
        Wed, 23 Oct 2019 13:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VR7AiOdmDydj8HrBpvMhfZ6ZAfhdNSHVw7PArSxQ9+U=;
        b=qjt/QIY1TJzaL0nUrb89fYCa6nwOiiO3tOt3NhHlMIS3BViRGj+MeStk4kBMZCUM0r
         68JETX725ibNtaFOS+VeJLNBDfkN0M2RrIHLIzMKkbaalQXSiPY3kay9ShuQtePYcpi3
         /sFbMOcVhIo9tuMI8Kl1/DJejJK2TdlZDMSPz5hVart/V0ljpb6Wbu+lUykiH09DeVXY
         c22tSvyX8cKhPVSJpjNGZPSUOWY/+e6USOKfQR7E2w02pUsyHjQG/LC/8C2dYk+0FESp
         05kuNOgnU13rcFSyl3KDJ1HLy+UqQS8Ava/8rKYtG8zP4DNpFW9h1l3SOpi0nsvKJLw1
         k2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VR7AiOdmDydj8HrBpvMhfZ6ZAfhdNSHVw7PArSxQ9+U=;
        b=BqlWtsLgraoO150FShx5rWL48y37FbIpUoTJEeWc5sPXq5ofN9fae6IlH81B6Zsb0y
         Cl1nxGNgTn1LAXaYqXnDX9LO1w92Owc6G+xOXXVmLyO+9TqIT12kC3AI6hSehTMRuf3Q
         NS3umBJvFt6A+kPPAJnwqZROaZdA8z+TG8ASjsGb5KBayMaCW/86EjmKPXjsJ0C5Jfks
         ov6rBqfqnLljcRUEKVJTeSAZUlCkdoQm1LUpJ9cyTkXK38CxS0MxEW4zhFFoIi7eAoMw
         dBJcOctMLOVaJbHPUZkJSh0AHl7Qi7newUY2GFWckV9tIaKYFBE6fK7PTew5i5IG3n93
         w0nA==
X-Gm-Message-State: APjAAAVOOo/mgNYt4WQrxG1IdSObpdAgwd9nUirfBiekOoPJG6d272jp
        fWnIk2rDbqhdzVSMWJVM0kg=
X-Google-Smtp-Source: APXvYqxfki5pvkdqjt6unEX84WC/q4jHXRwNaHLK/6VltlhWNzlEtvCCyrjp8qIurI8FUWV3bPpScA==
X-Received: by 2002:a63:f743:: with SMTP id f3mr12250897pgk.410.1571860970718;
        Wed, 23 Oct 2019 13:02:50 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 6sm10593598pfy.43.2019.10.23.13.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 13:02:49 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 07/15] software node: remove property_entry_read_uNN_array functions
Date:   Wed, 23 Oct 2019 13:02:25 -0700
Message-Id: <20191023200233.86616-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
In-Reply-To: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
References: <20191023200233.86616-1-dmitry.torokhov@gmail.com>
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
index fd667a73a201..f59dfd01725f 100644
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
2.23.0.866.gb869b98d4c-goog

