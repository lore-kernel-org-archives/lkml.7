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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21A0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D31320678
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 08:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sq6dXyBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389017AbfIIIQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 04:16:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43793 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388970AbfIIIQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:16:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id u72so7364116pgb.10;
        Mon, 09 Sep 2019 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l9SexI8nasVLgeuYZYcGyM3Easa+d7jbfdU+iQ5eqQk=;
        b=sq6dXyBVTiW5dDplPWSvVD0Cb99T91Vj2r/kBxYePgU/RnGsn5aATmKiTvRWk0acDI
         GoF26DGwsNPtoqsH5EuOSAfZF62iyAe5tLoMzrH11VcBXqcvWGsCkDFSKIQwfnmlUVvT
         2gYb9gXbz+f2EDJOGRJ0Tl3hJItQ7Se65I6xYWwcbStMq66OR8sDZmVBjthRdUbbAtp4
         bSnaf6E5n2KDkMNVs5eBE6YjZTAXvozRJNn2sEFGhMk8fzpDK1eJLmvsH4aFl2xA05Ya
         ZZaD6jXU3LDPIIsg0kOr5ZDMstuKhGisQ655AW0I6inMp2sb6hVOtOujF7iXKkUxBud6
         /rIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l9SexI8nasVLgeuYZYcGyM3Easa+d7jbfdU+iQ5eqQk=;
        b=e0EzOIyFLw6r8x0g3eSWNo8oGW8PmM5v8ZqqBCxPEIMUeb1OtWTfWFmAWnuXCd/7/r
         oTG6Dk/Uibn21fmtFKTfgwnSn1PBbD9HK/tvszIVAZtGjOTliCo7tgbZbszizewIh/Xz
         lVWLqIEQJNhnZQ0Cz29rdH8Tummc4WGpGJOjuDBerSF5vc5xuzXsoIstPhC/oqrFhxW7
         3+dWzG83Nz6v12oE5xaSo2jdmRJ4B7h2Rd6M08JLDxZH/S/VUUvDbUoA2V4WIRR4iLBu
         QjY71loNapf09yRNVdl3K3YfPPc8gEAmtwdO3vo8N8tcCEtAMtFv6Rm5dCi2j5IGIt4d
         ubgA==
X-Gm-Message-State: APjAAAVwZSAb0L6ndgJS338BuS+GT+Bd59z6rnbBUpqSlj3OQ5Cabv7X
        sAaDr/ktgxSX20c+0qMpK0U=
X-Google-Smtp-Source: APXvYqzsr9e/FIkGAUX7UV75DQNvUOtMF3SkGBzhgOChHGSUEE8KjIW8KEsdRVapfbZEmwppgoE/DA==
X-Received: by 2002:aa7:91d3:: with SMTP id z19mr26081486pfa.135.1568016973523;
        Mon, 09 Sep 2019 01:16:13 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u65sm12686669pfu.104.2019.09.09.01.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 01:16:12 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 08/13] software node: introduce PROPERTY_ENTRY_ARRAY_XXX_LEN()
Date:   Mon,  9 Sep 2019 01:15:52 -0700
Message-Id: <20190909081557.93766-9-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
References: <20190909081557.93766-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want to initialize property entry array from a regular
pointer, when we can't determine length automatically via ARRAY_SIZE.
Let's introduce PROPERTY_ENTRY_ARRAY_XXX_LEN macros that take explicit
"len" argument.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/property.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index 911ace267247..793d05cbc3b2 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -280,6 +280,25 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)			\
 	PROPERTY_ENTRY_ARRAY(_name_, str, STRING, _val_)
 
+#define PROPERTY_ENTRY_ARRAY_LEN(_name_, _elem_, _Type_, _val_, _len_)	\
+(struct property_entry) {						\
+	.name = _name_,							\
+	.length = (_len_) * PROPERTY_ENTRY_ELSIZE(_elem_),	\
+	.type = DEV_PROP_##_Type_,					\
+	.pointer._elem_ = _val_,					\
+}
+
+#define PROPERTY_ENTRY_U8_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, u8_data, U8, _val_, _len_)
+#define PROPERTY_ENTRY_U16_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, u16_data, U16, _val_, _len_)
+#define PROPERTY_ENTRY_U32_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, u32_data, U32, _val_, _len_)
+#define PROPERTY_ENTRY_U64_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, u64_data, U64, _val_, _len_)
+#define PROPERTY_ENTRY_STRING_ARRAY_LEN(_name_, _val_, _len_)		\
+	PROPERTY_ENTRY_ARRAY_LEN(_name_, str, STRING, _val_, _len_)
+
 #define PROPERTY_ENTRY_ELEMENT(_name_, _elem_, _Type_, _val_)	\
 (struct property_entry) {					\
 	.name = _name_,						\
-- 
2.23.0.187.g17f5b7556c-goog

