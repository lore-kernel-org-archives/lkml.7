Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4435C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48132184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhfeQSB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbfB1PA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:00:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46779 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfB1O77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:59:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id v16so17377553ljg.13;
        Thu, 28 Feb 2019 06:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNbW3l3o/P4hn2mX7vFhF+9pskSRu4PZ9nUssgs6kiU=;
        b=jhfeQSB4Cggj9LKy4w4SMTQS+85TdmOI0gM1XhQcyPy6eZLeywevuea0IOjumWpkbs
         m5Ld9pLBgF11k2dCbcDMTY4deiczOU/ZQOo9xQXRjO5YqJEXCkUzUqPJ+SPL99MpJ7Eo
         RGWQyQJh+zKBNEiSj3T6YV3Jio6iJ1ElsiUDqLeVF7kESNz+57doduOi6UwDeDiwS7gY
         vEyv5MSMo+bROPNH8aMiMJY60X+r+QttrlQ3nUeRDKV6mqvteD2AY/V2gSGjI5zDJr/p
         69QPxeKynPYpAm+GRp3w8/UrZ3zsgtJSKf7Kfb/A/rMtueiCk2XeJLnZJ5kv84C28XvM
         CLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNbW3l3o/P4hn2mX7vFhF+9pskSRu4PZ9nUssgs6kiU=;
        b=Fwvt/xEAWHWTNRIZnrdELdYJf6i5hOka/m5CJwomDo2xmZnKsZw0Bt1kFu/RBdG1Dg
         tdS7/F40vXKa1Q/+FO/166pxoKA6uB1basks5MnRWSZxWX77k6LeMIoO40vzeKMl6Bbi
         bwAEwshIkI3Bp900rKtc6p8wq+NIVOwzd9zHqKkZnB8PiGYbH/tgt1kiMghDfUyj0QRb
         0IoXhmdfl+u6L0R+A7uJnpey93d1GnSP8dIRa0lbxV60RtAO7UVpDfQm9d4rTXIqsbrn
         31UXz+iJTdGDtz8hz46aBZ49hfR5k6RW1xEpmlKizR1AgrOCJww9+s+hvYIUkxPmceAL
         Os6g==
X-Gm-Message-State: AHQUAubR4bdiN3IyAyuZ8lgqGaHvzoTcZZY2aGDJqaU2XGdX98ErzxVA
        u9hhlJShvvZ7iSmUpsXRQBg=
X-Google-Smtp-Source: AHgI3IaipTqldr6WDy2H2RuYtOvqiyhOkgtq64yAIJpOfGESvH5tCebXZjiCx5bj+7VOo5f5UYvGDg==
X-Received: by 2002:a2e:934a:: with SMTP id m10mr4969641ljh.164.1551365997108;
        Thu, 28 Feb 2019 06:59:57 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id z20sm4728309lff.87.2019.02.28.06.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 06:59:56 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/7] ARM: trusted_foundations: Provide information about whether firmware is registered
Date:   Thu, 28 Feb 2019 17:59:33 +0300
Message-Id: <20190228145937.27725-4-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228145937.27725-1-digetx@gmail.com>
References: <20190228145937.27725-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper that provides information about whether Trusted Foundations
firmware operations have been registered.

Tested-by: Robert Yang <decatf@gmail.com>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c    | 5 +++++
 arch/arm/include/asm/trusted_foundations.h | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 720904a43c00..bb2ee73d9e02 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -167,3 +167,8 @@ void of_register_trusted_foundations(void)
 		panic("Trusted Foundation: missing version-minor property\n");
 	register_trusted_foundations(&pdata);
 }
+
+bool trusted_foundations_registered(void)
+{
+	return firmware_ops == &trusted_foundations_ops;
+}
diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
index 650cca7435f4..ff6e4cb4ca9d 100644
--- a/arch/arm/include/asm/trusted_foundations.h
+++ b/arch/arm/include/asm/trusted_foundations.h
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/cpu.h>
 #include <linux/smp.h>
+#include <linux/types.h>
 
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/outercache.h>
@@ -50,6 +51,7 @@ struct trusted_foundations_platform_data {
 
 void register_trusted_foundations(struct trusted_foundations_platform_data *pd);
 void of_register_trusted_foundations(void);
+bool trusted_foundations_registered(void);
 
 #else /* CONFIG_TRUSTED_FOUNDATIONS */
 static inline void tf_dummy_write_sec(unsigned long val, unsigned int reg)
@@ -86,6 +88,11 @@ static inline void of_register_trusted_foundations(void)
 	if (of_find_compatible_node(NULL, NULL, "tlm,trusted-foundations"))
 		register_trusted_foundations(NULL);
 }
+
+static inline bool trusted_foundations_registered(void)
+{
+	return false;
+}
 #endif /* CONFIG_TRUSTED_FOUNDATIONS */
 
 #endif
-- 
2.20.1

