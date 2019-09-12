Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F155C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B527208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNhVc4+z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbfILJKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:10:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45280 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730352AbfILJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:10:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id l16so27492282wrv.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kn+E+YIgEzAwFw6LDS2rhCIDFOekAT5wUT4i1H5I0jU=;
        b=NNhVc4+zFj9YKvx2J6B6qN5MzAdlKTHdqGtnT1NG2nSB64+n6K54DSSyyJ1PJh9i/t
         qgkPmm4Dlocu4Q/kXKmEIw9CaUlN5pPj98lv2NtfOJhCNcb+PkL0GgB/GKKO0QSw/+m+
         ux6wA5JnTs0LrWB6mrNFN3GqKdB1O84PQKPIWjCJYmZbzCArKd7pUDbaXCyg+jSqBr79
         N0wkh4/lWNPUEBwjexjQerMxu2ukNFPI+TvGscxO+htoGSCzDoXTO9VaYS1ojZpLEdKJ
         cVaf++Kr4np3A/owArrlJYElzS2drX/Ly7W1aOm2P2sZPmmXNknjygzmHeWNUuAqrDnL
         ovow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kn+E+YIgEzAwFw6LDS2rhCIDFOekAT5wUT4i1H5I0jU=;
        b=O/zrYK0nSTYyhHARdnm3bx0/o8RngaH0AId7Rha0U2IKEFbumTbZztJXHkh29abiMC
         QlNdIx/u5IQLZ5lD+7om8jnTMFTEkE3jaAGoxBYEwgh7DbaCQ6p3SHIieNIPlzO3F8Xb
         7KXbG7jI7+uNa4FdD1eYeOU0nIq+zgz8a1ShmNH2iibPy2KfzmJw+Zr9p8K5ZZVH/Cs2
         5eIBHlPy4UntCVBW9erLEfqri+XfSzJvtppmxw3grIpJomqBZ9mdIasyX7qsPpG8cZdk
         YkFOiQxFf3W3sAAoN90KGgiv0r3+n2xHtns+hEuNb/2gBc7chxCNuYdjDd0txeJz2mHR
         d9Ew==
X-Gm-Message-State: APjAAAWR5WnFjZZ2V0LiVumDH8yqhZS4UCirqc0d2eHIs3KRf8LDoKhe
        Y4287hlEMRiBTb40ibVJPxnk3g==
X-Google-Smtp-Source: APXvYqzeFdxmytYWfmtUdm55ABcbUG4HVVjjMXD+aVaF/dEh3n1lMf+hJVKE/2IAWyG8Oz9kHLwNCA==
X-Received: by 2002:adf:ea0c:: with SMTP id q12mr1903410wrm.172.1568279433093;
        Thu, 12 Sep 2019 02:10:33 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y14sm39377181wrd.84.2019.09.12.02.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2019 02:10:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andy.gross@linaro.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soc: qcom: socinfo: add missing soc_id sysfs entry
Date:   Thu, 12 Sep 2019 10:10:19 +0100
Message-Id: <20190912091019.5334-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

looks like SoC ID is not exported to sysfs for some reason.
This patch adds it!

This is mostly used by userspace libraries like SNPE.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 8dc86a74559b..876a3f6612a3 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -422,6 +422,8 @@ static int qcom_socinfo_probe(struct platform_device *pdev)
 	qs->attr.family = "Snapdragon";
 	qs->attr.machine = socinfo_machine(&pdev->dev,
 					   le32_to_cpu(info->id));
+	qs->attr.soc_id = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%u",
+					 le32_to_cpu(info->id));
 	qs->attr.revision = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%u.%u",
 					   SOCINFO_MAJOR(le32_to_cpu(info->ver)),
 					   SOCINFO_MINOR(le32_to_cpu(info->ver)));
-- 
2.21.0

