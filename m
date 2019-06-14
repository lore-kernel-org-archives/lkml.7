Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C41C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE92F2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OLPYBKcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfFNUh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:37:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38126 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfFNUhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:37:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so2162759pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lsF1y/LAf5L+2wQLGdeHEaRtoQrXQNuhBq52QCwbapo=;
        b=OLPYBKcTI+78/S0FOVJMy9P3vw12j1xgEFVW/Zh4gP7hfjAUxnZ/FizK29hQocZGeB
         2VpJiAbbc9MRZmfY6iqA6wq4sqz/DCAzWfkPb3oBtXfVwHvMeiqwUEbDqYQklOTGGTb+
         Mt95Re9HEDvxMcRC3XaQjslmVZQNgfybwBtYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lsF1y/LAf5L+2wQLGdeHEaRtoQrXQNuhBq52QCwbapo=;
        b=RmFNKwWiLyXa7eM6scrwZPMBou1dll3L9cGxIKTyQ5j9NCzMh1tnhEWOH3TYL2my3q
         cg38cztRBGq6KYqWcwPTa7CgyVJc5d4dy3Z75UHTIWIZ1S3cwrQ5+IYkC06kQuvqQwWN
         wjbdQ1dai5sa6FFlOp5Xk/adA+p1d3JVGfDRS96BvqFVUbTP7rKLcqGinalz22CQzxPh
         j2JXa2GlQ0rBhNlt8AGJzjDX3bh9eaACh/18AW5ORmZRWjQGzD6c3d8M0d6klxrMMYzK
         I4X821IZEkXgdi8SfY76vODF1lKhe9ANeJG4xBBB5bWpTjO6FpXTKCh1ksAyfBotABgG
         rFxQ==
X-Gm-Message-State: APjAAAW1m4wjbFs8+YiPi5Hoz3R6ZvEBXoIrUJJqu+bJlFsclPlc4OgV
        F5wB6XEnAepGbbkLLutIPCdEkQ==
X-Google-Smtp-Source: APXvYqyh8elsGc5/c/L5iwGKta5WBR5tLdN1CqyHJTufMS/UgZnVCWVLvirzqoh1gd6Gf0IQIIbSKw==
X-Received: by 2002:a17:90a:d14a:: with SMTP id t10mr13015629pjw.85.1560544643851;
        Fri, 14 Jun 2019 13:37:23 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x5sm3673187pjp.21.2019.06.14.13.37.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 13:37:23 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 5/5] soc: qcom: cmd-db: Map with read-only mappings
Date:   Fri, 14 Jun 2019 13:37:17 -0700
Message-Id: <20190614203717.75479-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190614203717.75479-1-swboyd@chromium.org>
References: <20190614203717.75479-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command DB is read-only already to the kernel because everything is
const marked once we map it. Let's go one step further and try to map
the memory as read-only in the page tables. This should make it harder
for random code to corrupt the database and change the contents.

Cc: Evan Green <evgreen@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/cmd-db.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 10a34d26b753..6365e8260282 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -240,7 +240,8 @@ static int cmd_db_dev_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 
-	cmd_db_header = devm_memremap_reserved_mem(&pdev->dev, MEMREMAP_WB);
+	cmd_db_header = devm_memremap_reserved_mem(&pdev->dev,
+						   MEMREMAP_RO | MEMREMAP_WB);
 	if (IS_ERR(cmd_db_header)) {
 		ret = PTR_ERR(cmd_db_header);
 		cmd_db_header = NULL;
-- 
Sent by a computer through tubes

