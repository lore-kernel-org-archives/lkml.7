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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D4ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8790621A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cefw/7Zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfIKFMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:12:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43002 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfIKFMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so10886491pgb.9;
        Tue, 10 Sep 2019 22:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpppCvLTedSBcBa/SOWBn2uRgFrhyeJNWahbBvWHMOc=;
        b=Cefw/7ZiVx/zPpNSOg/BSK1Sw41PPz7bSptSjbmvQDlg02T9DppRkILPp5PVqS0z6T
         kIkdnhUtKBkR6NUCs2PSkaIJetGsnIoEbOnll+OE3L2jMU/MAbMCTubZf8QcW/S2PvAr
         Sw1oyf9pjDoo4V3k9ZNw8Gig3qOXgbKe7aoVqhw/XMu0oKI2XRRgB+LAa2Q6mcRvnJpQ
         kPSzRkiJRuWLo7iXQw7r2XfPP7uzMEiR2j96nI51w3bW0qj5PN4C6yNnCfbAthiKj4lV
         i5cdn3Sobp7URjqlrJZzpP8Sd6fvnZX0lX6g64zjIruQXyCct40ctKC4f959eupP5l1m
         Cnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpppCvLTedSBcBa/SOWBn2uRgFrhyeJNWahbBvWHMOc=;
        b=PabNT5BBwtJfu3oCP5eWpM8ifrM2zLMuRc2CnWSpAzPrfhMWfj2Gv2/yZJLbwkHuIb
         vSW4j+xYI7LEWpQdGLdJ8AKBGE6JGYS6cjjtrTUPEaOp8zuWiYP3ko5emfzAFrmP5At8
         kkI4lnVeuBR5FB1jDbm3agHpjvv4JGTk6Zizpgrsvd+fs1hqV1AodbedLia0D45L5/5n
         9ih4fs8fJl6KwKfJpIrxuydM1A/yBt2YtalwDiZHFRBeti4KqpjwVwwv32HL3a3iwqCy
         ZxpcQxGKvRE7op4GjLRdl2/fVs3D3Upo1OLwwXLyHxKoauYJnR3ZbZy9BZaTFM0H/PAw
         QYEg==
X-Gm-Message-State: APjAAAWPK+UrSbi1uAiOX4Y3BIisBq+NWdLqSbHsMAS0W8LX9tdfzFVF
        KaOr2seDS+dg8RXw1T5N4bM=
X-Google-Smtp-Source: APXvYqz6ni7eaKI4KkLnbaoGvZuYdYoFnF02n6NwpjEHvihisSURrgC7MVpPNa0S1yQkbF/x2CwQ1w==
X-Received: by 2002:a63:c05:: with SMTP id b5mr6541439pgl.415.1568178759963;
        Tue, 10 Sep 2019 22:12:39 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:38 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 03/14] efi/apple-properties: use PROPERTY_ENTRY_U8_ARRAY_LEN
Date:   Tue, 10 Sep 2019 22:12:20 -0700
Message-Id: <20190911051231.148032-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's switch to using PROPERTY_ENTRY_U8_ARRAY_LEN() to initialize
property entries. Also, when dumping data, rely on local variables
instead of poking into the property entry structure directly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/firmware/efi/apple-properties.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
index 0e206c9e0d7a..5ccf39986a14 100644
--- a/drivers/firmware/efi/apple-properties.c
+++ b/drivers/firmware/efi/apple-properties.c
@@ -53,7 +53,8 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
 
 	for (i = 0; i < dev_header->prop_count; i++) {
 		int remaining = dev_header->len - (ptr - (void *)dev_header);
-		u32 key_len, val_len;
+		u32 key_len, val_len, entry_len;
+		const u8 *entry_data;
 		char *key;
 
 		if (sizeof(key_len) > remaining)
@@ -85,17 +86,14 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
 		ucs2_as_utf8(key, ptr + sizeof(key_len),
 			     key_len - sizeof(key_len));
 
-		entry[i].name = key;
-		entry[i].length = val_len - sizeof(val_len);
-		entry[i].is_array = !!entry[i].length;
-		entry[i].type = DEV_PROP_U8;
-		entry[i].pointer.u8_data = ptr + key_len + sizeof(val_len);
-
+		entry_data = ptr + key_len + sizeof(val_len);
+		entry_len = val_len - sizeof(val_len);
+		entry[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(key, entry_data,
+						       entry_len);
 		if (dump_properties) {
-			dev_info(dev, "property: %s\n", entry[i].name);
+			dev_info(dev, "property: %s\n", key);
 			print_hex_dump(KERN_INFO, pr_fmt(), DUMP_PREFIX_OFFSET,
-				16, 1, entry[i].pointer.u8_data,
-				entry[i].length, true);
+				16, 1, entry_data, entry_len, true);
 		}
 
 		ptr += key_len + val_len;
-- 
2.23.0.162.g0b9fbb3734-goog

