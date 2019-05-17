Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA0FC072AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6312B2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hCa6JuKS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfEQQsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:48:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43938 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfEQQrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:47:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so3578150plp.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZrfU3jaOv3gonSUyJKcZeL36dqfb9Wzrb+12t37zMDc=;
        b=hCa6JuKSMM9Bs3WxT0qkjiSBEXmEf/LJdLX0/dKlb6nuQwSG6kwb+JGDS+mg5gfu9X
         Qrs4zMwjPISN3L2TwsmafobEXz1L5rOYHtS6cdmePanxz8zkBJIDmu0PpB2QMuj3sFCm
         CTPLfkxGffpChmq0cY2gI2ZmTf4OFrXugT+0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZrfU3jaOv3gonSUyJKcZeL36dqfb9Wzrb+12t37zMDc=;
        b=bEWXWnD9qkyIYGtVml5oL8TRMen8re4Rmf6X8G83H++CjCyR97TsvjcWW61j0fgicX
         8djKUXMbiq+309AAmtPBu5wRU05YyRJwCH0aZoyfhJSI/IFGUHmryfggQV7ipQyc+UNd
         3oDxxVhQS0WAU8YGOm8xUUeWwMSv3wDAlVvGbIOpXUVLfnZZHmi+8YkpkVTOxPztPv32
         i+S0o+BT8F5cWmBLzn3JgRMVAJM00PajyjLM+MiBJ+QNsmo81USb0xPdvhNKD4kFBs92
         4yQXfhK0EhbhJa63Zo7r5u1futWYYJgK43KZpAcdAcmTXZ+awrANqvYdt8u6o7nV02O+
         F+Sg==
X-Gm-Message-State: APjAAAXE59l8mGLInkyBGlRmQsZ780B+Ix7rdJ6KfnylUa4gcBXQa9Mi
        5NNxJuK/pwHVehVe7UzRmvc6hHfbJKom9w==
X-Google-Smtp-Source: APXvYqwzfl7bTpdEQKPRd5yF2qk0elfKWYm1umwxZQ/tTfqWpMHqi0G8Q3pmuAWOtsRl2T6ICJd6KA==
X-Received: by 2002:a17:902:e108:: with SMTP id cc8mr46847446plb.145.1558111672832;
        Fri, 17 May 2019 09:47:52 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l141sm12229810pfd.24.2019.05.17.09.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 09:47:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC/PATCH 2/5] soc: qcom: cmd-db: Migrate to devm_memremap_reserved_mem()
Date:   Fri, 17 May 2019 09:47:43 -0700
Message-Id: <20190517164746.110786-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190517164746.110786-1-swboyd@chromium.org>
References: <20190517164746.110786-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gets rid of some duplicate code, and also makes the reserved memory
region show up as 'cmd-db' memory in /proc/iomem.

Cc: Evan Green <evgreen@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/cmd-db.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index f6c3d17b05c7..10a34d26b753 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -238,18 +238,11 @@ EXPORT_SYMBOL(cmd_db_read_slave_id);
 
 static int cmd_db_dev_probe(struct platform_device *pdev)
 {
-	struct reserved_mem *rmem;
 	int ret = 0;
 
-	rmem = of_reserved_mem_lookup(pdev->dev.of_node);
-	if (!rmem) {
-		dev_err(&pdev->dev, "failed to acquire memory region\n");
-		return -EINVAL;
-	}
-
-	cmd_db_header = memremap(rmem->base, rmem->size, MEMREMAP_WB);
-	if (!cmd_db_header) {
-		ret = -ENOMEM;
+	cmd_db_header = devm_memremap_reserved_mem(&pdev->dev, MEMREMAP_WB);
+	if (IS_ERR(cmd_db_header)) {
+		ret = PTR_ERR(cmd_db_header);
 		cmd_db_header = NULL;
 		return ret;
 	}
-- 
Sent by a computer through tubes

