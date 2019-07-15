Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A76C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9297E206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="shRscEPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfGOK7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:59:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45672 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfGOK7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:59:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so7230120pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 03:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=B1YAbpSS5mgxR2rSK8yIOSMTpfmddjyfeqWk7cKwfek=;
        b=shRscEPbU2pHhePVbFOZEFog2yEyNMGyBHGeQnBt86VaqRxeF7byOE29CKSlwBXLXp
         vO8VNbh0L/W0tCb1Rv1lAFIV8PLd7FxtXLie+OPDEeA0DexVfOxSL0lAh50+oOKBH/Rh
         DsGqShJebdVxaPSboulAzgHFy0T4LgkuX+B+FvfuoSHSmNM1vgSIST3QxmQqIU1osL8B
         dmnFDPvcby2/tnJFZUAExLcFyvag6qbIMh93z23GTxNGTJvLlwC+PvPTZcNyFcz+JbOa
         Gai4s3/HMXwfMrXop49y8xcHo2Jy+fvHTpXZ6WyJyR2oLY+ug3Ut1SQmXDIWPcn78VwQ
         Ue8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B1YAbpSS5mgxR2rSK8yIOSMTpfmddjyfeqWk7cKwfek=;
        b=ipzrZ9x81qDv6VWqa0do9mUCDpXHolf6XdtvxZyYiaS5P2WjK2TUOOJoHVHqES2VsV
         woGmox5YlBKAXcBoLpV1Q3j6bW86ALVoqQWvC+EaS6l+x0t1zhNTSyAtu5MfFVIKBSFA
         dptXpNlMz+byafDBGOmcmDKSSWgnq7MSwaxOgdZyAuzu70k1Pysyc8M7VgWFMkNuWwRG
         Z78GiHgwcBVlViHTfdLt2f5qXZpVB0ufjyOttxrDxpiCuW3voXWs45oWehFa48LA0jsd
         VBsknnXbmpmztdjB/VisElSENeLLSBUTjSMjzuhrCRaNQF8/d0YuhOwRGt2OQsexwQz8
         nWCA==
X-Gm-Message-State: APjAAAWgEWsG59+hue31P1zVFL2Qb0CIwWZMcT3BqRr1AfmzJI53m+c/
        632e6pYuV3lpjY9M/ThwjzO/1w==
X-Google-Smtp-Source: APXvYqxBkROzVd6Yks26rlFbTrB/gXodvtXJxAdJXMu6yuRES0sWN0HtWIvDFBJVPl7vJtYXFW8BnA==
X-Received: by 2002:a17:90a:9dca:: with SMTP id x10mr28831738pjv.100.1563188343464;
        Mon, 15 Jul 2019 03:59:03 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id h1sm22600791pfo.152.2019.07.15.03.59.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Jul 2019 03:59:02 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: host: sdhci: Fix the incorrect soft reset operation when runtime resuming
Date:   Mon, 15 Jul 2019 18:58:49 +0800
Message-Id: <4c5812f54e5094fa54a85bdc86687a523df254b3.1563184923.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sdhci_runtime_resume_host() function, we will always do software reset
for all, but according to the specification, we should issue reset command
and reinitialize the SD/eMMC card. However, we only do reinitialize the
SD/eMMC card when the SD/eMMC card are power down during runtime suspend.

Thus for those platforms that do not power down the SD/eMMC card during
runtime suspend, we should not do software reset for all. To fix this
issue, we can add one condition to validate the MMC_CAP_AGGRESSIVE_PM
to decide if we can do software reset for all or just reset command
and data lines.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9715834..470c5e0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3333,7 +3333,7 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 			host->ops->enable_dma(host);
 	}
 
-	sdhci_init(host, 0);
+	sdhci_init(host, !(mmc->caps & MMC_CAP_AGGRESSIVE_PM));
 
 	if (mmc->ios.power_mode != MMC_POWER_UNDEFINED &&
 	    mmc->ios.power_mode != MMC_POWER_OFF) {
-- 
1.7.9.5

