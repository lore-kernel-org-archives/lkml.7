Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7B3C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C43D205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMeeUUra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfDYTxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44242 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730462AbfDYTxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id y12so297635plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B6YOKndeL0EWlcm2T3uwDyiC+zH1O061uyWZY8bijIU=;
        b=CMeeUUraxtzcJFg299FssNH86trZlcWw1aC6lcyd6p7JCmBELlkh+MCBl4NsblNCPr
         o3D8caqf3euguHRFf2RD4AFcDW1rhtjCAaSV9YdzGoWibvwz88T5mpcgBD89raQLMJVQ
         aTAdE312nxL6dCvbOe0rQpAo6AHMVjDh/oWmt1OtPshtO+cucab7TayV6HSBR4RY6OGC
         wnxUbI0vIyxYzBsAqkVNI01g0zj7XBUV8jJQ3mPd0xXz7ZZ+PrfU6pU3zD2Y+Li6yuam
         K3KV3eaUtgHESBZWBRlh5t38Y6tgv3ZZmGlH43lL0bWowrXV3aamR3gsO7YP9FmRSx6+
         MS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B6YOKndeL0EWlcm2T3uwDyiC+zH1O061uyWZY8bijIU=;
        b=hiT2vRopNRXN1qjEs2ZufgWmBkqLmh1qzd1NCK3SeT9puD1SWeCCyci9NAAGK89bgg
         CAv+RcxyhhN4g7I1s4tZH7GG706tdQonEKiiXaKL9nochVf2pr/FlQfa5IL7rPvx+OQk
         dv4Ezc8A4T/nGSK8SEhWLumwdF1qbq5Cj5YET1pv1EZAbOoCkfU/29hXB+eH98F9PrNr
         bSpxgq9zKQP4B13fMEVvy7/BgwjgiBepOFBSygVzRqsfg4oeQRV3Hp/rxbnJjpkUL365
         5l9MBg+ajwHKk+iZVRLBWZAIPuCPmXsqNtkbbbQqxQIWny3OwkNuwvEXI3zNjIfMwMHm
         Q8gA==
X-Gm-Message-State: APjAAAUnmkN6/hFXMr2FsZ1J0BnlBPq120lFUTEbh/lVmoTvMRafWPwx
        Vrv0B0htfWep/A05XJ0A338lrw==
X-Google-Smtp-Source: APXvYqzjiFXELZzy/hvo91NI93ZRJ/kEM1iBBStqLbYz+gf+CQpAi1YU6WfWaW97oajkF+NEvJGjgQ==
X-Received: by 2002:a17:902:e091:: with SMTP id cb17mr40670214plb.222.1556222017246;
        Thu, 25 Apr 2019 12:53:37 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:36 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 19/32] coresight: Properly address errors in sink::disable() functions
Date:   Thu, 25 Apr 2019 13:52:57 -0600
Message-Id: <20190425195310.31562-20-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When disabling a sink the reference counter ensures the operation goes
through if nobody else is using it.  As such if drvdata::mode is already
set do CS_MODE_DISABLED, it is an error and should be reported as such.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Robert Walker <robert.walker@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 9 ++++-----
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 9 ++++-----
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 9 ++++-----
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 8e63863cf950..6b73bc2e0dbd 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -333,11 +333,10 @@ static int etb_disable(struct coresight_device *csdev)
 		return -EBUSY;
 	}
 
-	/* Disable the ETB only if it needs to */
-	if (drvdata->mode != CS_MODE_DISABLED) {
-		etb_disable_hw(drvdata);
-		drvdata->mode = CS_MODE_DISABLED;
-	}
+	/* Complain if we (somehow) got out of sync */
+	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
+	etb_disable_hw(drvdata);
+	drvdata->mode = CS_MODE_DISABLED;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(drvdata->dev, "ETB disabled\n");
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index d50a608a60f1..30f868676540 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -297,11 +297,10 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 		return -EBUSY;
 	}
 
-	/* Disable the TMC only if it needs to */
-	if (drvdata->mode != CS_MODE_DISABLED) {
-		tmc_etb_disable_hw(drvdata);
-		drvdata->mode = CS_MODE_DISABLED;
-	}
+	/* Complain if we (somehow) got out of sync */
+	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
+	tmc_etb_disable_hw(drvdata);
+	drvdata->mode = CS_MODE_DISABLED;
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 6a8f39d03de3..9a0b346be58b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1417,11 +1417,10 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 		return -EBUSY;
 	}
 
-	/* Disable the TMC only if it needs to */
-	if (drvdata->mode != CS_MODE_DISABLED) {
-		tmc_etr_disable_hw(drvdata);
-		drvdata->mode = CS_MODE_DISABLED;
-	}
+	/* Complain if we (somehow) got out of sync */
+	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
+	tmc_etr_disable_hw(drvdata);
+	drvdata->mode = CS_MODE_DISABLED;
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-- 
2.17.1

