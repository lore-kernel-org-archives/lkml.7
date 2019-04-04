Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363F1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DC52133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 03:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRzKh2vO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDDDgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 23:36:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45221 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfDDDgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 23:36:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so420734plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 20:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rHFVznWd3K/zryT+Tds7l4sZTdfDnutsgyti8B8Scew=;
        b=TRzKh2vOPOa2ZvsJuRkYqzZnXGyMeGuX67tGMNah46Ls86ESxy2T98bYlcFr3XX5Pk
         DKraZC1Md0//SeUaIhNQnCiQN2gQL4PFWNCaADEOZP4LpbFIACrY3Acn17x1LBbF85uw
         HJ3Cnm5HyTQErLC5YJqMSvvMdallW1tG/HC4NlV/b49PYn5ywYQ+mjNIGNciTAfGPbzn
         AdAhdAvw0pcWhT2TwZEbx6PnamyEkghvns7tqXOixdD5VKZRFqFwm1QLStM8JKC1ikfB
         ayyaufqpk1qc4Zwd7fF977eZdwWMGhCjNXb8jVSHrNQps8slJQw0rHTS7BEzsgZGhcQJ
         NVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rHFVznWd3K/zryT+Tds7l4sZTdfDnutsgyti8B8Scew=;
        b=EHFboj9AcYGqMwv3dcSO0Urav/JaIlHgsRVI12Av6O2VM23iyvINbozH/N+4joUUMl
         +c0Sff9oWL2hEnp420E3mQNjKntlRFOeuqmBfhgcCItS6ls1Qb+y2vznHA+rr0vKEGbi
         HIkABimTMYp9DYl3+ep3GaTPES+OFbRYe+1qNjyH3zI+hFmvJ28OjLYyucoJP0ecr9aE
         29p+h+QO0/DDWfibs5WfXvB81wFysz62S3JS8hYnJX+DR3feavL0IPB8J2x5yUxK24TY
         Glo6vzoWBhi03DCJZxoTI+EkifJu2qP8P87kqLWOqaZQwxdcmVbXQP3oMmvShRueXydU
         006Q==
X-Gm-Message-State: APjAAAWlHjf2RjP3pSKvJON7Sks+kR0W/vfAF0cqErBmvpZspWuz9zTz
        gCQlsMbjnTwUu5n9oVKbVpcVHA==
X-Google-Smtp-Source: APXvYqytpomhj0mjfSVM/ijFF454SAG2sPiKLFlp7k9sL+o0fxnfoV1qjz3gARA+mBuLtY969NEIDQ==
X-Received: by 2002:a17:902:403:: with SMTP id 3mr3816530ple.48.1554348960246;
        Wed, 03 Apr 2019 20:36:00 -0700 (PDT)
Received: from xps15.imgcgcw.net ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u5sm12212780pfm.121.2019.04.03.20.35.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:35:59 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        suzuki.poulose@arm.com, mike.leach@arm.com, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/20] coresight: etm4x: Skip selector pair 0
Date:   Wed,  3 Apr 2019 21:35:24 -0600
Message-Id: <20190404033541.14072-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404033541.14072-1-mathieu.poirier@linaro.org>
References: <20190404033541.14072-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resource selector pair 0 is always implemented and reserved.  As such
it should not be explicitly programmed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 732ae12fca9b..d64192c29860 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -138,8 +138,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 			       drvdata->base + TRCCNTVRn(i));
 	}
 
-	/* Resource selector pair 0 is always implemented and reserved */
-	for (i = 0; i < drvdata->nr_resource * 2; i++)
+	/*
+	 * Resource selector pair 0 is always implemented and reserved.  As
+	 * such start at 2.
+	 */
+	for (i = 2; i < drvdata->nr_resource * 2; i++)
 		writel_relaxed(config->res_ctrl[i],
 			       drvdata->base + TRCRSCTLRn(i));
 
-- 
2.17.1

