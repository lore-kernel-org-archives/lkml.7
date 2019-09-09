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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07D6C00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6F22086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPwFmX/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbfIIIQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33241 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388894AbfIIIQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so7396125pgn.0;
        Mon, 09 Sep 2019 01:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KsgRNFOCDuIZ11czAPgOqHyEf7Ffyioe5wChnknAWcs=;
        b=CPwFmX/k6223gC6lxq0CVIqaai8IZGQVXc+n5Pi2h9gZHb1rVL2j25Bcp34l6YF6Mc
         +ab4eIz0sX3I3C4qR6zr4/u15xuZ1VDPuW8sm5vql1pdM0zuSFnnwXQoiTstXKS9TU/S
         u9xJQpLyFK49Xa8QpHCJq9ByqdHurFrWruPrjGdiq2dlgG3HVRDalPvGOc2mI3scaE7K
         K51qzp7b4tW93/WirZS77nM+wLch8Fa3xpbIE3NsZXB3Dc7vK7lmIDwYVPg/fJtfzInu
         GRujdjsFGe7/b+7L6sxr/mFZDRys1vUCme2bxR7jEjXhVnYL5g4ZRzCy+6Xu/ED/Ad1S
         JPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KsgRNFOCDuIZ11czAPgOqHyEf7Ffyioe5wChnknAWcs=;
        b=SkhvufKuAzxLDk5HpBr76x1m8BVAozQci7imZuYtfc8lPsNNA9Ha6zT355WQ7PKJiC
         JteoZDNom28kE2YA0z8nFR0noseAON3Jf7470yAD8yXXHL0u5sTjLiJx7Vlh4lEjMoU9
         cYndTVlhFoM8MDFTWWtGW3lH0JFuxR81aUHVr/qfCZ1JvdMmeZoSoCkv7s7f0j8WnHGg
         TjYhwBaLyUMP1eLGshqEIKQvnsqe/MXfIQAKwvqeUOzMD+wESbh2fEY+Fbwd5HTMxrNV
         x7bNBnBfceF7rbs2AZ8y2m4MGADoTRzIT9CHNYJl4VrJggNyz34p7rQ+kJqjYMdkkj+S
         KFlA==
X-Gm-Message-State: APjAAAXjMrVQRODX3JQa9X7RULm3IPRAWOv3atR2dRswHU9sigwncKHf
        ST0XkFIbq727hbbummDv/CVd+bOHfUo=
X-Google-Smtp-Source: APXvYqwygXmyzpqW2sKjwn/gui2KPWp0UkRNk2iptbPf9j3be4dzy96fYpNF7Rqm/G0gK55MAnyHyw==
X-Received: by 2002:aa7:9343:: with SMTP id 3mr25821006pfn.145.1568016966653;
        Mon, 09 Sep 2019 01:16:06 -0700 (PDT)
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
Subject: [PATCH v3 04/13] software node: simplify property_get_pointer()
Date:   Mon,  9 Sep 2019 01:15:48 -0700
Message-Id: <20190909081557.93766-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not need to handle each data type separately, we can simply return either
the raw pointer or pointer to values union.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index a8d12046105e..bedc26189bed 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -105,30 +105,13 @@ property_entry_get(const struct property_entry *prop, const char *name)
 
 static const void *property_get_pointer(const struct property_entry *prop)
 {
-	switch (prop->type) {
-	case DEV_PROP_U8:
-		if (prop->is_array)
-			return prop->pointer.u8_data;
-		return &prop->value.u8_data;
-	case DEV_PROP_U16:
-		if (prop->is_array)
-			return prop->pointer.u16_data;
-		return &prop->value.u16_data;
-	case DEV_PROP_U32:
-		if (prop->is_array)
-			return prop->pointer.u32_data;
-		return &prop->value.u32_data;
-	case DEV_PROP_U64:
-		if (prop->is_array)
-			return prop->pointer.u64_data;
-		return &prop->value.u64_data;
-	case DEV_PROP_STRING:
-		if (prop->is_array)
-			return prop->pointer.str;
-		return &prop->value.str;
-	default:
+	if (!prop->length)
 		return NULL;
-	}
+
+	if (prop->is_array)
+		return prop->pointer.raw;
+
+	return &prop->value;
 }
 
 static const void *property_entry_find(const struct property_entry *props,
-- 
2.23.0.187.g17f5b7556c-goog

