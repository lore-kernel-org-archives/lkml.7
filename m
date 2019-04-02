Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98A3C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92115204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQzkuU6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbfDBQOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:14:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38782 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731078AbfDBQOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:14:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so4480895wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HADuYtPTNrxpcN8kfE8Fku8tuLIuxpjkI5Oi1Be3G+o=;
        b=VQzkuU6SBsI98fiYXZpMHIm4v6bJFj9DTp/Q0+njwXd9g6T7vvq8oKQVvBy8POX64z
         5vZQVrz0AKWEdIluRz8JSLlHcp6X8mbXSuYTW7nC2pHZK1nnmaxYpkicTyv6RrBr+zyF
         aDwbPBl+tZR2J9MH2qET6MDXNSgHIacNEL0R14ZhiI5+5ObMyusO174A78Ofm4PhCWkP
         hiuqnFKNbY89My7MINVDjxlYcugon8F3U70n71YVPJdis0NdO7HOPDvfFET2oixMAlEQ
         4enFDZncak6/0+L1JMg3OrXrl5vVtXC/onRA1c3mpURyupAfP6TLsx91XU/NxehbW90O
         7FAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HADuYtPTNrxpcN8kfE8Fku8tuLIuxpjkI5Oi1Be3G+o=;
        b=X+mpytid4z9eOirHEJrxiaGPh7Nse+gfrVUzcYODYp8eXFN8sxQWVap20fosJqNidA
         DQrxf1xPjRmogjMu0jGFBnThUwMV3lcR1OPGNqKufyLXVY/dU0nPglNgHEPKdIrnk2Ff
         F0SRQew70FJSNSmk5xr/b64RMWHK9PSXQJiuvlxj+jm/LBWILtAHS7M7EKq0YWqq/LRm
         dcSr4JQju9LRUzG6Vebur4KM4BHUuquxW8iEyaKo2lEN6Okvv9CCpNZiaAW0rjFzCX05
         01b8hzOlt7vnp3JUs66vnvIGiBtS/UxteXpiIyP4T7mM/k1ICrlK+EldrXBXC9xyQJNh
         GH9g==
X-Gm-Message-State: APjAAAV5KsKe4lq/ySII59T260hplJAlvu1Xr8KOKwtxry7PoY3Ro76x
        TNECX07DshG7w6HxoE6S11fiig==
X-Google-Smtp-Source: APXvYqzughbuoj39u5xAwXrVWiAdEaqUxu3pHQ2yxhtcHIv40hj2ARyQPUCITlM522cVS+LN1X4omw==
X-Received: by 2002:a1c:f310:: with SMTP id q16mr4100693wmq.102.1554221652721;
        Tue, 02 Apr 2019 09:14:12 -0700 (PDT)
Received: from mai.imgcgcw.net (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.gmail.com with ESMTPSA id a126sm17054999wmh.4.2019.04.02.09.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 09:14:12 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH 7/7] hwmon/drivers/core: Simplify complex dependency
Date:   Tue,  2 Apr 2019 18:12:50 +0200
Message-Id: <20190402161256.11044-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402161256.11044-1-daniel.lezcano@linaro.org>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the thermal framework does not longer compile as a module, we can
simplify this condition below:

 if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
       (!defined(CONFIG_THERMAL_HWMON) || \
        !(defined(MODULE) && IS_MODULE(CONFIG_THERMAL)))

 if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
       (!defined(CONFIG_THERMAL_HWMON) || \
        !(defined(MODULE) && 0))

=> (whatever && 0) = 0

 if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
       (!defined(CONFIG_THERMAL_HWMON) || !(0))

 if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
       (!defined(CONFIG_THERMAL_HWMON) || 1)

=> (whatever || 1) = 1

 if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
       (1)

=> (whatever && 1) = whatever

 if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF)

CONFIG_THERMAL can not be a module anymore, then:

 if defined(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF)

And CONFIG_THERMAL_OF already depends on CONFIG_THERMAL, so:

 if defined(CONFIG_THERMAL_OF)

Thus,

 ifdef CONFIG_THERMAL_OF

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/hwmon/hwmon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index c22dc1e07911..6f76f2484db0 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -118,9 +118,7 @@ static DEFINE_IDA(hwmon_ida);
  * The complex conditional is necessary to avoid a cyclic dependency
  * between hwmon and thermal_sys modules.
  */
-#if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
-	(!defined(CONFIG_THERMAL_HWMON) || \
-	 !(defined(MODULE) && IS_MODULE(CONFIG_THERMAL)))
+#ifdef CONFIG_THERMAL_OF
 static int hwmon_thermal_get_temp(void *data, int *temp)
 {
 	struct hwmon_thermal_data *tdata = data;
-- 
2.17.1

