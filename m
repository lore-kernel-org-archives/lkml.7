Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF45C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 22:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E0E2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 22:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FLDJjxsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfLSWWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:22:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33045 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfLSWWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 17:22:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id d139so8061547wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 14:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I3Bk5DzXh21LjzbbFrLuxqc/f6SASou8FRBI3bqnTBA=;
        b=FLDJjxsEJG/wiTxMggZDT57y8zuOsasoO92JVnZnwWfr/G6LW7JICsrf9WSJtkfaTa
         OW0dfm6aPcCiFoCMDiRypVa+urEjemUEv4DoeeWLt/c6FdGb6FPZCVr/MtAYABVMI8p5
         B3kT/1uFHr5fhtMbjAzq/f7DO8bFMw6R0DrgrG1h0LaG5C77lQh8Ov9UZUVJUF/yLPIQ
         Tgkl21Nw8hNdAADDCX0GaH9cgc+wBucdPnMkcRNyPdQOXvg/pd65vIVtmOjN/e++ZN0q
         GXChjAXFKsf6y87HxmQgVASAZqEfGA7XWIe9RvYFXF4iZ1wqe2CdEKGElxen2uM9B51/
         0Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I3Bk5DzXh21LjzbbFrLuxqc/f6SASou8FRBI3bqnTBA=;
        b=L6VtAcsmSAn+9OJHoWDgMLklXLuDPESHJLEoivfIxVEm4iV/062sk41NYM6k5cpiDu
         18ZhxHcBZjLs/gubCyTVO80jjDLklclBhBtf5DWq2y3hbjU1/7Fr2rRTUKZYMRDcjafp
         B4bLq3hh8tdZ0wDbabzHoXYlDcPbBkec2tXjVMvWnG4Wn5YvShtuhburUnkcFfcVXHQ/
         03XNt6xfCWyHVMj88p912SqvwyMgQYpPB6DEpUfl/CCMW4LCRcjsnI+jf97nXO6FUmu3
         umeh2C0H1sab+9VYy93fxhhpFqH2aEaO5OvIl50cErykD/R0ils4LKVkHaMANw6b1+tC
         PD1g==
X-Gm-Message-State: APjAAAX6lX3SmpZ09joZ1NV+U3aIxV7LOEB0L52Lp7pAgu+q/Ws0lvOr
        wDLQlZ3hMSnvY97kbB/2JXbgh7/b4ys=
X-Google-Smtp-Source: APXvYqy8mmcX1je9IxY9DT1Y7bJ6fGzucgqMBmuqlo1zlJQsYhmpzsKJSU4AFCBWodxEGZYN+OnHrA==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr12245737wmi.45.1576794127988;
        Thu, 19 Dec 2019 14:22:07 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:58d:4e9b:2833:86c3])
        by smtp.gmail.com with ESMTPSA id q68sm8942295wme.14.2019.12.19.14.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 14:22:07 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] thermal/drivers/of-thermal: Move the of_thermal_free_zone() to the init section
Date:   Thu, 19 Dec 2019 23:21:53 +0100
Message-Id: <20191219222154.16100-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219222154.16100-1-daniel.lezcano@linaro.org>
References: <20191219222154.16100-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function of_thermal_free_zone() is only used the initialization
function which all belonging to the init section.

Move it also to the __init section.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/of-thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4333cd5f1073..27d5b85eb2ca 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -977,7 +977,7 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 	return ERR_PTR(ret);
 }
 
-static inline void of_thermal_free_zone(struct __thermal_zone *tz)
+static __init void of_thermal_free_zone(struct __thermal_zone *tz)
 {
 	struct __thermal_bind_params *tbp;
 	int i, j;
-- 
2.17.1

