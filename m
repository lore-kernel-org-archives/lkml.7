Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4885DC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1749320818
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3t9Riyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfCCRNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:13:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34505 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfCCRNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:13:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id u9so1292856pfn.1;
        Sun, 03 Mar 2019 09:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=09wpTThfZ2pWFmgypLfEoMbwgOxZpXVNvgWK6RajSSA=;
        b=H3t9RiyhiqIXJPkJEx2r0D5Tx/5itCDkr/LcUSgOZxExrsgdWJtCtaX6VFjYTxSSTk
         IvfwO/N6d/6+pd9PGPnyshsRKD34EvPAPW1YuQR3q706DEOqf0UEsR2isUH9wqtrPddY
         FZZpbGwLYqok97YPrSpWyL94doqyDx1fD77bGmh27nT0dC+K8E7u0l6uUVQFQGGdX5NF
         QToo2R25uP3qntnnMBOmDqfm47hDjWn4eaAmSHErL7oZ8CJr3WrqZbdNlU5Rn9SpjNUT
         n3hTQeQVqZt0ac6EsXx4RKMhHQoIEIk1L7SrYU/dE94k7d3s/Aw3fqrc549fa1Sq2zRS
         3rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09wpTThfZ2pWFmgypLfEoMbwgOxZpXVNvgWK6RajSSA=;
        b=jSokBwQywrBBcxHhiW23DZk9Aw6Jj/7IJOi/SiKbxQWwu0k0wLc6OYFeGe6RpS6/8A
         51OAP6ysQU3GTqzmirOGlL0bYk5MvOrjr7e5wvUevrR+DryRqBINx8ZG6zSoN7W4NKTo
         3294qdjvfoYZK3TpQQYsNlPwiyCPj22dNNMjogwI6XbKnCt8M4ptKYb3oqdka/HMiU4e
         YaF3ngL2mb0I6WJJlspsl2FgrlwJh6RbYiyEqTeKVq0AstZROPeeHUhSmPiBlAT/rdFU
         k7CrDHD9WGaldWOR/mVYevPDBVBILby5aigJxlWkHbK+EFWCXigtjtmFw89ip7RV61al
         ewIA==
X-Gm-Message-State: APjAAAVFgOsVDUBUcMuBZkgss3S+pM4WcWayUAhtfO7wp4Sf4shjW/pY
        PAGP67K86TIoQSzBapTm0Go=
X-Google-Smtp-Source: APXvYqzlCnIK9lYswSG3Ccr3eckFrqZMrtpwoVwbTTNd+gLesvEy8vQiBSmKMOTrWT9PGSsqLu4qQA==
X-Received: by 2002:a63:440d:: with SMTP id r13mr14553203pga.5.1551633225256;
        Sun, 03 Mar 2019 09:13:45 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e22sm5349412pfi.126.2019.03.03.09.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:13:44 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/7] ARM: trusted_foundations: Provide information about whether firmware is registered
Date:   Sun,  3 Mar 2019 20:12:10 +0300
Message-Id: <20190303171214.24821-4-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303171214.24821-1-digetx@gmail.com>
References: <20190303171214.24821-1-digetx@gmail.com>
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
index 40445389ffe7..253747789958 100644
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

