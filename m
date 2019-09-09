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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01897C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4F521A4C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz5jlN7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389130AbfIIIQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37098 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388905AbfIIIQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so5926220pfo.4;
        Mon, 09 Sep 2019 01:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUa+m3FqZ99xfkyvEvlA6sMFSjuli7hMMJB1FS1WyOg=;
        b=dz5jlN7i8loJALpN2oPiFnyUwtzjMWoePCx4bcpkm2tGDuitkABg0fXZ0YRwuJdpIQ
         4nxPD9xwy8javXgn5rJx16BCQpktjYRnb6HA+mT66OcXbYy7VmE0DQZAM3wPJJUySUgT
         R4vrRCTQAwNVUH/x868egLo0t6zvesjwXi82uVL0FouZCCZNb2/WGixiRVcGIqF70S8I
         85k/pcxrXwBkY0xHlKHLDDIf2uns8+MRRQTHHw1X2tPJi64sLG+9SoWz2wJWbV16UuzM
         G41cDfYInsQpi278kX9veGOrIkHqZvfngu31/r+NTE1W5e28+XWSgwJYzkmrmlwxxgzj
         kJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUa+m3FqZ99xfkyvEvlA6sMFSjuli7hMMJB1FS1WyOg=;
        b=rjURnKSDB/nlKlIFWFLvH28xOl/Qqe4dmVFeFRgHB3Hmw6eUo9o97OoGhYOYeJKRAe
         xC/VIVESKdcwHiFXqRH/f1N+dz7L+YTA8McOP495u3s5d5VYDijQ+H/EyMfbCZtyqK2q
         9AblyPQD4PTm7lJqQeTWV7e8L4u+DVqsdnb2AVGl9t4ujWJGF5ahUOcVLD3GS0jKVJFC
         c6SURiMtAxYLb/MboyQ9Fx80rfQ5/sgzi5H8CN+eDSuWzUPm1NM+6mR4gQEoywKCDjvQ
         mmoIDcLCFMsATpBSfD1+jcyp+U+x2Ou+neAqUfsfXKDBpd4F8btiawkuNuShG8GBtWfL
         ZyiQ==
X-Gm-Message-State: APjAAAUgXzWdk+WYB7CnZWG4pvY7qEzV59XSkbDLazNDT4OSsEFrXcx1
        ccGd1YG/zHzR5q7O6KmGyZc=
X-Google-Smtp-Source: APXvYqwU+lBn9p5HKygncaZkZeE12EpPAorple9LCeLGsPhjVwYrznNyh1luLVWSFLNN5qbHA5ivzg==
X-Received: by 2002:a63:f941:: with SMTP id q1mr20756332pgk.350.1568016974903;
        Mon, 09 Sep 2019 01:16:14 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm12686669pfu.104.2019.09.09.01.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 01:16:13 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 09/13] efi/apple-properties: use PROPERTY_ENTRY_U8_ARRAY_LEN
Date:   Mon,  9 Sep 2019 01:15:53 -0700
Message-Id: <20190909081557.93766-10-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's switch to using PROPERTY_ENTRY_U8_ARRAY_LEN() to initialize
property entries instead of poking into the structure directly.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/firmware/efi/apple-properties.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
index 0e206c9e0d7a..6a09174979b0 100644
--- a/drivers/firmware/efi/apple-properties.c
+++ b/drivers/firmware/efi/apple-properties.c
@@ -85,11 +85,9 @@ static void __init unmarshal_key_value_pairs(struct dev_header *dev_header,
 		ucs2_as_utf8(key, ptr + sizeof(key_len),
 			     key_len - sizeof(key_len));
 
-		entry[i].name = key;
-		entry[i].length = val_len - sizeof(val_len);
-		entry[i].is_array = !!entry[i].length;
-		entry[i].type = DEV_PROP_U8;
-		entry[i].pointer.u8_data = ptr + key_len + sizeof(val_len);
+		entry[i] = PROPERTY_ENTRY_U8_ARRAY_LEN(key,
+					ptr + key_len + sizeof(val_len),
+					val_len - sizeof(val_len));
 
 		if (dump_properties) {
 			dev_info(dev, "property: %s\n", entry[i].name);
-- 
2.23.0.187.g17f5b7556c-goog

