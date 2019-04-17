Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8275BC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E474206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUdIgNlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfDQIyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:54:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50804 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfDQIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:54:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so2410240wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FbeBFpn+y42+bGubMile1GVQyTxVPR9FxPAa5oQU7cI=;
        b=LUdIgNlbv3x0dDytjkavVezGXWrekvR4fZgMI2G64Q7bjpcVSkNXd1aJmBGsmo3LQ8
         KVKvGGODA/sPSSLsi8oIzV3cj6Y8Ex1JnATJitL8VOiSdQiV8EO6Z9Q4Nmrf/JqJXEv6
         V0Wu+U6bnjGUb+pvLi0tz7/YMYemhA2PZVCVomGIbtsHblmAwv99sVdftpzFAIgy8Gjz
         q2l3XRN1vFnTpT67IW/u5c4Q7wZIYM8PKRs5cCmGpxxOnIXrcR8mepKL73nP1nbD0BIz
         rDq5sPSIfyrSbYXB35RdAj0MGVS8/WFxMNexW4aS+BG/G1BK1bNVgN64mgcTPYJrohLY
         uOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FbeBFpn+y42+bGubMile1GVQyTxVPR9FxPAa5oQU7cI=;
        b=Bfoa7NbuXqi3DQJvvlEXOX/9KODbrS4reSoC6WyIGzbdaR2qr+V8tvzdj4UxPLVnYf
         OQC7FqGbMcsTazVvTEk7QkGHP6OK1Yvywzoiphnqc6zbBrcdkg+Gy/iSCCndfeaDPa3X
         isPF/U6HpUZytqUXKK/e2cDJLnun8J8rEu9Bt9Xhs1pwwrYjOi7OgiH3pGZRcjyteAAX
         dDlrn48H1n9roFRTNixnkY19kUA+zMykwrQWgxifmCO85K5KRGaXviQGLXVPp8poglk4
         hLKYH3KwG6PQ3g8A7wekYeZNz/DvI53+x9YoWnokcYZxU72MJzC2a2UFnLk1np7oYHMz
         vOWA==
X-Gm-Message-State: APjAAAVH6ctOPIprvI/kQl73SeA/u9zrlGQPVu9y+OxW63Am6wyTsfcb
        ueq88D6nnVZ/DCfN1+4nO98oNQ==
X-Google-Smtp-Source: APXvYqxXoAWcfKJ7jWJKgqGJTIIzESZh7MPLrfBwNXnhQS+C1+yMWHrjo3MNRkgqDCtCDxdrU72hvw==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr29497812wmc.49.1555491257501;
        Wed, 17 Apr 2019 01:54:17 -0700 (PDT)
Received: from localhost.localdomain (200.red-83-34-200.dynamicip.rima-tde.net. [83.34.200.200])
        by smtp.gmail.com with ESMTPSA id p6sm50111766wrt.4.2019.04.17.01.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Apr 2019 01:54:17 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH] regulator: core: do not report EPROBE_DEFER as error.
Date:   Wed, 17 Apr 2019 10:54:11 +0200
Message-Id: <20190417085411.14552-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not log a temporary failure to get a regulator (EPROBE_DEFER) while
the driver is requesting retries.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/regulator/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 186a37675b50..0ca18bbdcd32 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4342,8 +4342,9 @@ int regulator_bulk_get(struct device *dev, int num_consumers,
 						      consumers[i].supply);
 		if (IS_ERR(consumers[i].consumer)) {
 			ret = PTR_ERR(consumers[i].consumer);
-			dev_err(dev, "Failed to get supply '%s': %d\n",
-				consumers[i].supply, ret);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to get supply '%s': %d\n",
+					consumers[i].supply, ret);
 			consumers[i].consumer = NULL;
 			goto err;
 		}
-- 
2.21.0

