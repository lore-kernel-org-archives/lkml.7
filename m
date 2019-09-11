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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B98BECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F21621D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhuQTpR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfIKFN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:13:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36981 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfIKFMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:12:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so10141881pfo.4;
        Tue, 10 Sep 2019 22:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eO8kYN9dCKJpVNrT1gZqNTBkkExiu3MjUltw/zl2pgs=;
        b=JhuQTpR3cIX4KQCSoGChxjU8n5tf4t0H6tqOQe9DCehfKA86vNh/IFTBSSUfm6wOAO
         k7MD6LpdLbSLR7CmgOXaL80Ez0LkqO1pPJ0Ojn/6/69IEcivohKaWYD71dwlKUAxkHSK
         eNP7HxtyY7JmZH7ACvwoeHyrBvXMLG6SZoZWCLiMA5vnnmN66k8Dc5PzeAVL2OEXEMFM
         ZcXMEChRqV0a4U/AF7w5bytBTews5i7Aqw94AYxhHtjeoSBQUVa2POs+mD9kBNh4COZM
         pvV4ilEEVCsGPRMM1NzPjvzRDtBijIFRQkpt65M8GMVUi+kQqZ/r66TEdSeWP2k6c1DU
         C5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eO8kYN9dCKJpVNrT1gZqNTBkkExiu3MjUltw/zl2pgs=;
        b=dV6kQAYAn3KTX46TWUmiTvimBs2pyICaJiHohuxYDp1n1p/9tSomQ6S/pfyXwMtJlc
         E6GHV5rWHCIbMisPx1U21KwkAxkRAI4slcOMVJAFOaf+kjl/sHtvp+q1VlUV8zI8jCks
         da8rJuxblin413HGSlDtRT0eGGdRsN6evoJ4N/Dmufr6iHDmqwGRZVUUy/xSnFxuq+Ug
         n9feBKb7eNTgdz4po26Y7qYK2Kja929VcoE6x646fHT0wnXCRP9FcgEZV0ItjXP5QwrW
         +5pZYwh1FyiAdCZ4cMN6fOhDkjTc0RN3SBz6C6AO91MFyG255cSQJlveavW0IXwvp8Zo
         r0xg==
X-Gm-Message-State: APjAAAUFtWhk1/tSrw7ZFhzZXlkn0mLt+/DfyermA9dZMfxMLE0hlhtH
        wt7dHBeaKZoQG6+j1dvOUTQ=
X-Google-Smtp-Source: APXvYqzP0qF9m+m375uNm4tLF58AeA5zYrlo+rn232PVTpNnaIA7kpYyCpFWrLBEetDj4tcFNAyXPA==
X-Received: by 2002:a62:f80a:: with SMTP id d10mr39536697pfh.98.1568178763022;
        Tue, 10 Sep 2019 22:12:43 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p11sm22011149pff.136.2019.09.10.22.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 22:12:42 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 05/14] software node: clean up property_copy_string_array()
Date:   Tue, 10 Sep 2019 22:12:22 -0700
Message-Id: <20190911051231.148032-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
References: <20190911051231.148032-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because property_copy_string_array() stores the newly allocated pointer in the
destination property, we have an awkward code in property_entry_copy_data()
where we fetch the new pointer from dst.

Let's change property_copy_string_array() to return pointer and rely on the
common path in property_entry_copy_data() to store it in destination structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index ee2a405cca9a..7bad41a8f65d 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -337,8 +337,8 @@ static void property_entry_free_data(const struct property_entry *p)
 	kfree(p->name);
 }
 
-static int property_copy_string_array(struct property_entry *dst,
-				      const struct property_entry *src)
+static const char * const *
+property_copy_string_array(const struct property_entry *src)
 {
 	const char **d;
 	size_t nval = src->length / sizeof(*d);
@@ -346,7 +346,7 @@ static int property_copy_string_array(struct property_entry *dst,
 
 	d = kcalloc(nval, sizeof(*d), GFP_KERNEL);
 	if (!d)
-		return -ENOMEM;
+		return NULL;
 
 	for (i = 0; i < nval; i++) {
 		d[i] = kstrdup(src->pointer.str[i], GFP_KERNEL);
@@ -354,12 +354,11 @@ static int property_copy_string_array(struct property_entry *dst,
 			while (--i >= 0)
 				kfree(d[i]);
 			kfree(d);
-			return -ENOMEM;
+			return NULL;
 		}
 	}
 
-	dst->pointer.str = d;
-	return 0;
+	return d;
 }
 
 static int property_entry_copy_data(struct property_entry *dst,
@@ -367,17 +366,15 @@ static int property_entry_copy_data(struct property_entry *dst,
 {
 	const void *pointer = property_get_pointer(src);
 	const void *new;
-	int error;
 
 	if (src->is_array) {
 		if (!src->length)
 			return -ENODATA;
 
 		if (src->type == DEV_PROP_STRING) {
-			error = property_copy_string_array(dst, src);
-			if (error)
-				return error;
-			new = dst->pointer.str;
+			new = property_copy_string_array(src);
+			if (!new)
+				return -ENOMEM;
 		} else {
 			new = kmemdup(pointer, src->length, GFP_KERNEL);
 			if (!new)
-- 
2.23.0.162.g0b9fbb3734-goog

