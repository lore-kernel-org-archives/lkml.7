Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CE9C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45D8214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 22:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS/HPJoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCQWzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 18:55:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41241 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfCQWzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 18:55:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so9918879pfn.8;
        Sun, 17 Mar 2019 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wNzJGGyEOize1LzTO0+y1Kgh6PGMJqQwtkfpH9Pt58o=;
        b=KS/HPJoCizQS/MGEIiwJMWEe55oqGw+mflnBa/9xG+7mjBVs6x+v3qYAUIXOalW1fW
         RJvQAFUTBDry4mmHZ1meEYtTZuSUUjphqLiXje1IrRRsLJazt3A26MrMcj755njP8XZF
         JXvmMoW8nWThkHRw1JwTfHm9qDXkGm8kKl2bPfcC8QEjVGItEwoeCgsJo+ViGMpzozll
         qmGG/1RTouaymqGSg/V7qlPVsOAtRHn2CD+mnH076g2fr9PJfGH4fiSftTHvszPkPlqF
         HxQe6cT9FmzPj7k7k5ccXMHqzSjtuiScme0EIgQmwI9sv3VWqo+ntVAmQ6d8OZb3O5Pg
         JqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wNzJGGyEOize1LzTO0+y1Kgh6PGMJqQwtkfpH9Pt58o=;
        b=Vbq7OmZ7QxEsUkhZNc/znPoe76eT6UZo8CINnSLc7dBL9VQxyMWiOpFySrsemqslne
         FcYBlHAs1x7L2zWkpOYzpaOaq/zeN5lLbtpXprx+5LPGXuWjjwtxEpUvXHyXmtAVv3SF
         e8oZ7loj2uL0MY2/uQvc4uy0+1OPhKYutaWPA+h1EvmbgfpK0K4QfSo9ngTZkxG+NDKa
         Zqk/qYV2Jgt/3MI0s817ctCX/PooiRemDDw5m8I+Sp3ZX2I6/ODNj1f980r41QPmouTV
         keo00MTJTF/DjN5vAugL7IuEhs+6uzNOwk2UqgxZqQm5roAvxAVPyrVHFXOVxHw48l9L
         e8Cg==
X-Gm-Message-State: APjAAAXdk6fGWhW0VKGT38iqYIfOjsbzPLEiTWSKL4jqF7juTLSouD5v
        mdSHTmrlHQJGO+d/9ILAaCE=
X-Google-Smtp-Source: APXvYqxcTo0Wcwu7bj5yIzZO1FtGxruGm26JpgvnPbswyc6Ya5LV5ZdYzM83DkpdMWOd8mh7xXJuWg==
X-Received: by 2002:a65:62c2:: with SMTP id m2mr14666478pgv.348.1552863348757;
        Sun, 17 Mar 2019 15:55:48 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.gmail.com with ESMTPSA id v2sm13738838pfg.118.2019.03.17.15.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 15:55:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 3/7] ARM: trusted_foundations: Provide information about whether firmware is registered
Date:   Mon, 18 Mar 2019 01:52:06 +0300
Message-Id: <20190317225211.23091-4-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190317225211.23091-1-digetx@gmail.com>
References: <20190317225211.23091-1-digetx@gmail.com>
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
index 201ceb259e71..54513c533811 100644
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
@@ -84,6 +86,11 @@ static inline void of_register_trusted_foundations(void)
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

