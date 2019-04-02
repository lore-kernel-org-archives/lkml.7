Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AFEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35A720840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NlJ+caLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbfDBQNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:13:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37031 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfDBQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:13:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so4467082wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sM5DuO7BoO8bwUSi7V7hLCJ54rIkdF19j/mFFbs42Qg=;
        b=NlJ+caLw05rQVlBrMZ4YpruY+cDR62RpZb0YT/tqf6xKqrqIKusuVbvwpqeJMQbynC
         wGo/bK8lQxeaIVeVwlcpKXJEc0kIBtM2BictJ3Nkp+V3QLaZXvjVQbguauc/NLIaVaof
         xnC/CN2VVWdz3OYJgdJSh8A8me2k9BXhXJNjc7maXtyCaK3MPImHUceT23FuVwBxqeBD
         0OENZnYQLPtAQagJPhvjfDXh1iVTzztiWMSnLyqn93yeHkYdSxJvDGAtyFEG9vNocshs
         iz08l1ytYZHjYc3HqwZqziTbTQzawBOx7q5DWtQrVdwbsMW6EDE5XHphmLn3sDch8Hje
         tY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sM5DuO7BoO8bwUSi7V7hLCJ54rIkdF19j/mFFbs42Qg=;
        b=kGnhL9X8aPM7pnv4TEZQS16fk59yRdygzkQRubUjTUmRrQ0TRfTy/TuGeoH5kCw73V
         gNh33uFr5IF2sb9xYxpDslZ9e4ChaDTyPr6GoWESBXAoeP9ZRlSSf9VBAxdwdRG6dMjQ
         mqpEVyXBmwnHWTyQZv7daKIS0IVhDcAl9lDKGzmS/RYSSsS6ydr68iDSXzIXnRwv2uKC
         Scltwo6YTaieIaabxaR0RLqnorpEoT7wFGTaMcLT1kOIppQ5L6IoEr4isYReQ761JB2Q
         HWVA7FfCnCzOzdi3qjfWXiEvk3TY5VgIW6kU9FRwACt4p10vriaKJUOSC4ih4lARJl1v
         IN/A==
X-Gm-Message-State: APjAAAVjzMZ2DDy8G3tM71NO6pJQZmZzHPfBeSLcG/hi7LepudL+EBi+
        8xXZbuLIO8jqR9kWDzRt62ehsg==
X-Google-Smtp-Source: APXvYqxC81avFPye7Rl55yyrcPjMGxkewAcawVIK5nVwn/RYE2jntn1T6F+NUX7Pw3+vmz5PyeKOBw==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr3380438wmi.1.1554221611184;
        Tue, 02 Apr 2019 09:13:31 -0700 (PDT)
Received: from mai.imgcgcw.net (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.gmail.com with ESMTPSA id a126sm17054999wmh.4.2019.04.02.09.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 09:13:30 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] thermal/drivers/core: Remove module unload code
Date:   Tue,  2 Apr 2019 18:12:45 +0200
Message-Id: <20190402161256.11044-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the thermal core is no longer compiled as a module. Remove the unloading
module code and move the unregister function to the __init section.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6590bb5cb688..28f7ece0e8fe 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -266,7 +266,7 @@ static int __init thermal_register_governors(void)
 	return thermal_gov_power_allocator_register();
 }
 
-static void thermal_unregister_governors(void)
+static void __init thermal_unregister_governors(void)
 {
 	thermal_gov_step_wise_unregister();
 	thermal_gov_fair_share_unregister();
@@ -1563,19 +1563,4 @@ static int __init thermal_init(void)
 	mutex_destroy(&poweroff_lock);
 	return result;
 }
-
-static void __exit thermal_exit(void)
-{
-	unregister_pm_notifier(&thermal_pm_nb);
-	of_thermal_destroy_zones();
-	genetlink_exit();
-	class_unregister(&thermal_class);
-	thermal_unregister_governors();
-	ida_destroy(&thermal_tz_ida);
-	ida_destroy(&thermal_cdev_ida);
-	mutex_destroy(&thermal_list_lock);
-	mutex_destroy(&thermal_governor_lock);
-}
-
 fs_initcall(thermal_init);
-module_exit(thermal_exit);
-- 
2.17.1

