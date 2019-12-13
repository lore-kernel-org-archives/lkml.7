Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35ADC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC31420706
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RD/8Wp23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfLMWbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:31:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40258 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMWbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:31:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1819048plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 14:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6xiPB4V1MquUiOmcSV74SL5uCSBXsqT0lweR/qYDigQ=;
        b=RD/8Wp23u2HL+Of7WXX/WBYuFgXFrxWHZT9+pRV1xNQmg6N/L1av0fnq378xoYuMGK
         gXqnEvWiYxdnv07ysfWJHJS3kc4NlOy8vd7UgpJMXh8QfL2i1Q7cJEkB4hhHPZVa8Sc/
         ycW8+VVbe8xvjJFP/6dy4MaIAHldnUrAsOOhJmgnYaqMd3isSTJMJcPNJ0tyO1KsyLvu
         u1kb+nA4PhxoHaNtwdd19jfcrI0FBKMVfnwxA4drknbIhWjRVY96Fm1T8Y3sTiQ1PrtF
         QekxQqU5UQty1cozgGdsWfMqkI7FQ+fpQR34xTByrgCfgverDuhyVhMqyHjlS5ptMEQi
         vUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6xiPB4V1MquUiOmcSV74SL5uCSBXsqT0lweR/qYDigQ=;
        b=rVzhCoWLqyqEdrcl0XltdRGp7gp1dXF4oQmF1i1ecf/I9vQDoEHT/OyALn4BflNom5
         VKVx+d2I7IC0e3LBRQ2FyLP3xw6X4mXPXjOu3hpB4FombO2JEtSizNU/3ye8W3oWwiGI
         yn+5gnftXoPUbATwHTfeNMAkDBe0VGGcLVNoJPZNd6XA5JqlPMS2jRSAqHjy0ZaVlxvY
         bbz+Z5f/p80YqAiJwlpOs9hNkEPMpPHWwE8ZHlrpJ/PML9MPdzSdGhQIhEVBANin91tN
         fvS5k2pR6KizTfC5fXe6ikBGC0DfIY7dmP2UddS7YzT6J7N4OVlHSYT6t0wqooTBr+A5
         Q7Qw==
X-Gm-Message-State: APjAAAXZU7o6wSbV1SCmvuMdb9UGT0HYVxAXEiCBKpl/g32UagJqziKL
        h9RHvz01HR+KSK1/4cB6smeXF9Ne3AM=
X-Google-Smtp-Source: APXvYqxQn0YUbrOLh36feQfvxK5Y5frN9aMYM1JviFC9pwwWoUhOT1jRHwqaDvdGV1oRSaZ3PdMtmQ==
X-Received: by 2002:a17:902:a9c7:: with SMTP id b7mr1912322plr.23.1576276270618;
        Fri, 13 Dec 2019 14:31:10 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d26sm11556782pgv.66.2019.12.13.14.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 14:31:10 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] coresight: etm4x: Fix unused function warning
Date:   Fri, 13 Dec 2019 15:31:07 -0700
Message-Id: <20191213223107.1484-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191213223107.1484-1-mathieu.poirier@linaro.org>
References: <20191213223107.1484-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Some of the newly added code in the etm4x driver is inside of an #ifdef,
and some other code is outside of it, leading to a harmless warning when
CONFIG_CPU_PM is disabled:

drivers/hwtracing/coresight/coresight-etm4x.c:68:13: error: 'etm4_os_lock' defined but not used [-Werror=unused-function]
 static void etm4_os_lock(struct etmv4_drvdata *drvdata)
             ^~~~~~~~~~~~

To avoid the warning and simplify the the #ifdef checks, use
IS_ENABLED() instead, so the compiler can drop the unused functions
without complaining.

Fixes: f188b5e76aae ("coresight: etm4x: Save/restore state across CPU low power states")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[Fixed capital 'f' in title]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index dc3f507e7562..a90d757f7043 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1132,7 +1132,6 @@ static void etm4_init_trace_id(struct etmv4_drvdata *drvdata)
 	drvdata->trcid = coresight_get_trace_id(drvdata->cpu);
 }
 
-#ifdef CONFIG_CPU_PM
 static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 {
 	int i, ret = 0;
@@ -1402,17 +1401,17 @@ static struct notifier_block etm4_cpu_pm_nb = {
 
 static int etm4_cpu_pm_register(void)
 {
-	return cpu_pm_register_notifier(&etm4_cpu_pm_nb);
+	if (IS_ENABLED(CONFIG_CPU_PM))
+		return cpu_pm_register_notifier(&etm4_cpu_pm_nb);
+
+	return 0;
 }
 
 static void etm4_cpu_pm_unregister(void)
 {
-	cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
+	if (IS_ENABLED(CONFIG_CPU_PM))
+		cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
 }
-#else
-static int etm4_cpu_pm_register(void) { return 0; }
-static void etm4_cpu_pm_unregister(void) { }
-#endif
 
 static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 {
-- 
2.17.1

