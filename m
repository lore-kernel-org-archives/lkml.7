Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2931DC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 14:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F369C2073C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 14:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="s7ea9Gwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfK3O4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 09:56:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35364 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfK3O4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 09:56:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id u8so2444002wmu.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 06:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bUD5FdR6g2ASiBzE14YJrcmNzasb1Y2tz62iUE7N/xc=;
        b=s7ea9GwcwXaGeE9Wx+YTpW6GFKPJtcTUDmn4vfvKpYbOTbO0B0BTxuDACSZONQsI8J
         kEemZNTf1R6rM5ldMhPomsojlD+CxfdNT8vJvnv6ln561hn3pAbegdsOy8LDsT9Hil4F
         sXtViNhlKDK5kMeAoVGCZXrG3tj6xIgV7TrhwL48kCm5SzjDVFd8GBP61HiM6NJno9Um
         1LW1S7s27cLhoOCsAf5vPf97LqucJAgpFYblLhCmOZ1ZldJL1tci5rn1PdxNl2/WAY67
         Obz6uRyDkzNCGYtzbBL6qn5cYFaU6e31xp7IW+oKZlNba4G8BltluLy8W29jz0Xgb3k4
         WORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUD5FdR6g2ASiBzE14YJrcmNzasb1Y2tz62iUE7N/xc=;
        b=c/oNMXGw0POfYeNVm22R2DQzlkn7RvG6ltDU3SWC8g7andyQNqxztqkWuevn6n8Iax
         KZiVCoa7pTywAK7vLxswxbT/s/+m3jc6OHvkhp8pS8A5ecEXED/YoirEw48HYJUv6psv
         m0NUtGcu24pwGvRjzsIlCOZUuglX4SIevS5zbwlhUWa0MPozW4JGTE8d1QVompjzeGJB
         2IDByIX+lAFIqs6KmMYiD9tMdoHfKyhXcjiOFTjI5G+DAnBWaKKdpGU90JN1A7krkAKM
         Q1P4FOASlO0nCdpEXogGu7FaqBlDfzuxNF5aD1J2ksBOxwykAyefM4pqYFopOlR5bMh4
         /UIw==
X-Gm-Message-State: APjAAAXeKehwyeoNtM+J5XYCpo/hnKZDZm7pi9vVFyPJrFaQceBqywZ0
        pjCuFyQuh/1oc1clH2wAe+4=
X-Google-Smtp-Source: APXvYqzZpWOgXW1gfWbWJi9PlT3GB5ebe5QB4uNaaCBAKAQTzRs1WcrUniu8FDKqrcNFkMMqjeVG2Q==
X-Received: by 2002:a1c:40c1:: with SMTP id n184mr20991135wma.116.1575125792804;
        Sat, 30 Nov 2019 06:56:32 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id b17sm7163391wrx.15.2019.11.30.06.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 06:56:32 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     khilman@baylibre.com, narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] soc: amlogic: meson-ee-pwrc: propagate errors from pm_genpd_init()
Date:   Sat, 30 Nov 2019 15:56:17 +0100
Message-Id: <20191130145617.1490233-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130145617.1490233-1-martin.blumenstingl@googlemail.com>
References: <20191130145617.1490233-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_genpd_init() can return an error. Propagate the error code to prevent
the driver from indicating that it successfully probed while there were
errors during pm_genpd_init().

Fixes: eef3c2ba0a42a6 ("soc: amlogic: Add support for Everything-Else power domains controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index df734a45da56..3f0261d53ad9 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -323,6 +323,8 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
 				     struct meson_ee_pwrc *pwrc,
 				     struct meson_ee_pwrc_domain *dom)
 {
+	int ret;
+
 	dom->pwrc = pwrc;
 	dom->num_rstc = dom->desc.reset_names_count;
 	dom->num_clks = dom->desc.clk_names_count;
@@ -368,15 +370,21 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
          * prepare/enable counters won't be in sync.
          */
 	if (dom->num_clks && dom->desc.get_power && !dom->desc.get_power(dom)) {
-		int ret = clk_bulk_prepare_enable(dom->num_clks, dom->clks);
+		ret = clk_bulk_prepare_enable(dom->num_clks, dom->clks);
 		if (ret)
 			return ret;
 
-		pm_genpd_init(&dom->base, &pm_domain_always_on_gov, false);
-	} else
-		pm_genpd_init(&dom->base, NULL,
-			      (dom->desc.get_power ?
-			       dom->desc.get_power(dom) : true));
+		ret = pm_genpd_init(&dom->base, &pm_domain_always_on_gov,
+				    false);
+		if (ret)
+			return ret;
+	} else {
+		ret = pm_genpd_init(&dom->base, NULL,
+				    (dom->desc.get_power ?
+				     dom->desc.get_power(dom) : true));
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.24.0

