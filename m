Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4E9C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFDF21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNSUIi6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbfGKUcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:32:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36521 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbfGKUcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:32:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so3625490plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 13:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XkYq7uT/CNUdv8Wag/pmsaqwtieqxy569t5n4hsEP2k=;
        b=QNSUIi6/JywXvRsdcCggLLKKWxpsTFA7kv56Cen4r7ynWMCGwz2B/Pz5kms6GM+fBl
         RfeMHSyFtMjCO1TbSWoqrXZcE9VcfVzxypHZu8ARhyLEq8Fh8NE+UbsJiDsyGKkmA+aR
         JxLU7XINELxFSiUazt3yK0PZwgfe7MvstUqvK46xheV6QPS72UadCPivC5+W0Ofch2f5
         sMtBQbkQTpO6x/khyX0tsnUTSH5EBvMICHSj+2bSL86eRNsqF16ui2ieJAoMJQ8Z+7o4
         NaYn5ZpX1JD7KOeNKj32TxJ1Rhhj8CsHp8atPVcPgSjLYJUah3neBUMStpO7bfz8LB13
         DkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XkYq7uT/CNUdv8Wag/pmsaqwtieqxy569t5n4hsEP2k=;
        b=nSZ2D39GjjLp5zisyr4c8Qc2NM89HcYq6r2hZADuuJN967DsqWFVbYS69XPjJkaMX4
         5TU6ANZuun7KDJ1XPaJURJJQA6GhxxcJ7Csj9x1nOaJJCJ/7NnirQ/fg4srHbJjSvZH8
         43ofOxC5Iq5y+z1/uKiJtfRH8yoc4JHx9hgBULhcUKYnHiRusJgJ215ly8X/9kbelAfw
         hijSCXGvmQf5GblSUV3+mhxc4xtfWruWiLKC1ZzS4fNnYvC2QansX/4WnYsV8URy3O4J
         Glk9mfSBCA9F+nVwWvrgQbiGSxXKprSF0rzh7pdeADZEp6nZaKGylZj3QW1zFe3OJNVP
         /LoQ==
X-Gm-Message-State: APjAAAVhPniIdffJzgDY0Bv9cB//b9P929C0PtMqbDOSkGFkLDq26DD5
        uUVIfhGFZLgl5lX2tewc4fiAYF+l1MnkJg==
X-Google-Smtp-Source: APXvYqxuiqD/QeFdfWOG0tlJem3oeWCYlhK+OsGUOgkfx68FOnXwufxYAiSVysaUMbTd+tVTuRakEw==
X-Received: by 2002:a17:902:9041:: with SMTP id w1mr6945324plz.132.1562877122722;
        Thu, 11 Jul 2019 13:32:02 -0700 (PDT)
Received: from localhost ([49.248.58.252])
        by smtp.gmail.com with ESMTPSA id u7sm6104032pgr.94.2019.07.11.13.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 13:32:01 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        joe@perches.com, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2] thermal: Add some error messages
Date:   Fri, 12 Jul 2019 02:01:58 +0530
Message-Id: <31a29628894a14e716fff113fd9ce945fe649c05.1562876950.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1562876950.git.amit.kucheria@linaro.org>
References: <cover.1562876950.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When registering a thermal zone device, we currently return -EINVAL in
four cases. This makes it a little hard to debug the real cause of the
failure.

Print some error messages to make it easier for developer to figure out
what happened.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/thermal_core.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 46cfb7de4eb2..e1c2c2638219 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1238,17 +1238,26 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	int count;
 	struct thermal_governor *governor;
 
-	if (!type || strlen(type) == 0)
+	if (!type || strlen(type) == 0) {
+		pr_err("Error: No thermal zone type defined\n");
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
+	if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
+		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
+		       type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips)
+	if (trips > THERMAL_MAX_TRIPS || trips < 0 || mask >> trips) {
+		pr_err("Error: Incorrect number of thermal trips\n");
 		return ERR_PTR(-EINVAL);
+	}
 
-	if (!ops)
+	if (!ops) {
+		pr_err("Error: Thermal zone device ops not defined\n");
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
 		return ERR_PTR(-EINVAL);
-- 
2.17.1

