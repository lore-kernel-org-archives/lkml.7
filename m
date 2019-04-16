Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39187C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0771F20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF07nlNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfDPQXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:23:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36434 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfDPQXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:23:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so10589474pgc.3;
        Tue, 16 Apr 2019 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+443J6WdsUQskMitvLq9h/wv6uWnm+Lk4TG8Q2wjNNU=;
        b=YF07nlNR4xipxuE9qtDsxP+9QyiflcsMGxM1a8UA7fBZHFB0v8Bwsn+6VezyBBxkW+
         /u7FalAU57TNFqijI9PU14bNhR6QqpESFm3HnWQ90jesldOFs3WXWiPef6nmDdVpLaf9
         AwnV9dQ3KspPIZ6TDI5PE8pcj9hdyODPZ/FReldiahH3LX6bVfR6U+JzJi8HDpI8kyyq
         ck/lLIDUCgE9LHtmEUF7xWoZ5HSLlMwT4Vnppsmfy56CLxurpmyU8U01QEEfov/hBO9z
         pDWWxXhAdvh7PC9a9TLiouYlWJsZPcOfFOfDfi67Dbs2t5XSylrUXhOiWzUrn95A+h19
         U3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+443J6WdsUQskMitvLq9h/wv6uWnm+Lk4TG8Q2wjNNU=;
        b=afTIx+xkNz+uEZ7IAHEsFAjXuxmZUDgwVG5+NL6Z6zkMK+lDc7UtRNFfBOInoLlvCm
         lGKnF6hBp/TYaJGdYxCZ4CjfFODyoPuDEe4aeW1vdbNNacCS99Aq/FA2nVmA0sxKhEUR
         TFM8CMT1bJOs+4/HWO+NGXJjffJLnN5vwnHuFFE1IuSF0l3IKoShDQTW9+/J42QoAT5M
         auYRI+yBPlT99fqnheRtX2NzMKruRpVp/9pSsqwdEtxt14xqzFwPp++yImY8XCRfWehA
         Fikl2G3QakzyX8fEcuDslfNAlYSvNB8csqsk5ZuzyLd9dM0KXun3c3HDZJnfR/9idNOw
         IUnA==
X-Gm-Message-State: APjAAAVaSjPT/nfGJkMkwEI2TsuekHxOgsqK7fCf0hXYfjJ+IXbP/vJO
        jNxwXKt8FGSYUeYqVC0gXTM=
X-Google-Smtp-Source: APXvYqzLLF2O9LAHWA8Zn5hO6qCFh1Ja5HWAPhZ4HpUuo7FUYWaz/Sl4M047gwqq1FT2659EofoSNA==
X-Received: by 2002:a63:7153:: with SMTP id b19mr74644345pgn.289.1555431787628;
        Tue, 16 Apr 2019 09:23:07 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id n21sm102391148pfb.42.2019.04.16.09.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 09:23:06 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org,
        pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] PM / Domains: remove unnecessary unlikely()
Date:   Tue, 16 Apr 2019 12:23:05 -0400
Message-Id: <20190416162305.24375-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to use
unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/domain.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 96a6dc9d305c..598a4e02aee1 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -391,11 +391,9 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 	if (unlikely(!genpd->set_performance_state))
 		return -EINVAL;
 
-	if (unlikely(!dev->power.subsys_data ||
-		     !dev->power.subsys_data->domain_data)) {
-		WARN_ON(1);
+	if (WARN_ON(!dev->power.subsys_data ||
+		     !dev->power.subsys_data->domain_data))
 		return -EINVAL;
-	}
 
 	genpd_lock(genpd);
 
-- 
2.17.0

