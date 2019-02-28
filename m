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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0D9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447FC20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUacrCWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbfB1NTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:19:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40588 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732570AbfB1NSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:18:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id w6so17081855ljd.7;
        Thu, 28 Feb 2019 05:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzyGiH2ChxicEKeWJXu+4hX+Dt5ldMGxbVc+PSHIupg=;
        b=sUacrCWmjU36pzRjjOS+WdWQ/SMvUZicfXQYfM/jFcOyzfgkBPZEj73RFRJmkPo1s/
         OCfBAjmqDfy5PNnp4Z25p3WxJ9G7wKo7LIo48cqtDJH/AXwrQKqV9X2ChlO84dBG0K3n
         IwWt4b/FQhjyj8VSeCQ9pOg1ebOkRzm1Cl4aOWC7j/FKU6MHBtLhWs71QrwEZ9cxORAL
         BgD1mUOtFxaOkwF/3AkP+CYQzrr4hnq5LDhTqEhdTgesDqgwZar/WBev3CT/7BFvFXs9
         ZR2vmoyM3EAZJ+9Nx1W8QrzY/7ZXWaLvZoXJHxYvk9YUfwegf5EnHGfl8KWgmePFJILz
         tB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzyGiH2ChxicEKeWJXu+4hX+Dt5ldMGxbVc+PSHIupg=;
        b=Sk0YMUdr77fisFjYByd8Rb7P6XnKuyCq6bsp2eDGCtBNi8gXw1tFnkXbX/ziyuCTwl
         42lGTggNEn2LkmcwhDdVJD46iEO6ICy6MTtt6DC7GKcQHkYC7JMF5tJ2AGtyD5lqd4T1
         UzRe+KFgkzUxCVIkXDM2UgwbfWMw6h/mcgf/i+8Eb91LjXN9/1DNxAoESIIRLJkX87CU
         A4VLU+TM9UZSqwVemfmwyY2cdGornCPssHd9OhNZymcPeYDcVpHnv811anTpBOiUfu9k
         xXtFaDNiDhF5t1JB5hLd3IGEKih4YGXwBMD/VxXb6F1WiQ8Fly736sCP5sFKSNiDN7QD
         Jb8Q==
X-Gm-Message-State: APjAAAWK244BXTMzR630WISIO8hqcOQEIQ5Q3C/muhZSscntLzXD/iwF
        0NTCMjnn5AfCpiVIe6IeL/o=
X-Google-Smtp-Source: APXvYqwrTxg3+L7S9QiiZbXHVlSkQQXj43Tt3vbHcR2Sq1AU3S3efmdNsEy8sF6xOnF20wLI+60klA==
X-Received: by 2002:a2e:709:: with SMTP id 9mr4738701ljh.4.1551359926226;
        Thu, 28 Feb 2019 05:18:46 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id l26sm4600069lfc.37.2019.02.28.05.18.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:18:45 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/7] ARM: trusted_foundations: Provide information about whether firmware is registered
Date:   Thu, 28 Feb 2019 16:17:03 +0300
Message-Id: <20190228131707.2592-4-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228131707.2592-1-digetx@gmail.com>
References: <20190228131707.2592-1-digetx@gmail.com>
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
index 188b9a33f72b..ca2e31aa1a17 100644
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

