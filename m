Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D88C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B85205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rh//OABQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbfDYTxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:53:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38432 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387650AbfDYTx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so367014pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cvob0FDX1MLZ+fYnYf8rcIMYa/saPGP93kDs1sAwGb4=;
        b=rh//OABQz7zsUprVfGn8AeYsjPLxok5dsW/boSDequbQ4T/RR+3w8L3NuINWOD5Jlj
         d32vwY+T97/8GSI+cebCzofMWDGB9I5byKBAnd0j1GS3fkHOzDwkWjiBp/ScPNuB7HLD
         8JEfonwA7XOJTWNLkwz2n0A5eCEdAlCIi8yDHzvtWllGkkcsEQ+KBq+TEOoAVmlSX5/6
         c/uRaFwzYVCOMWMw1OfIXQicfnM7GtXuFfJ0C9OlEtQja/RpbI0sb2/TxZSLLwnQkiN2
         YcRCijbcfUS0QNJXMMnFqy+v3X7LXI2tLVcEmcSOeSRTdm0MZm3eqnwAoaYzAWbNgqrd
         RVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cvob0FDX1MLZ+fYnYf8rcIMYa/saPGP93kDs1sAwGb4=;
        b=aP0/03bLvBK5SibW5a36Df3HKiB/xyaGEMb4p0jlAm+dd/BusltTWJYcEC6DV5ja+o
         Fv3JD0eXbJF8C/LpX3asJ/b9wtBRrjfpv7m6CyI9qM4323M4P5lS7XXJxz8jc10iHZQB
         ERkZvNrZa0p+W4SwciteSzxQ62Pt0d8bv/OAO89tgfWuX+Y1D1LeV1c847K+tBHHMTPs
         BfpJoBVh9Y3eNFPAhMLHdpy/mZf+bOpL6ApEIqzpeaYdflKYt91op5dVijT00RUqmXQC
         TTlgVGGGxOhvruVAOy1+NuM4F/UXxk7cdhiT4eYeEWgUcfpILc1KYSEGNwWi/uT1p3e+
         Njzw==
X-Gm-Message-State: APjAAAWuI7hivJqRaT6hsazBQEW0z2kpeFMD4xRvTKlrYpICcWFrOVeZ
        gXJLDDFaxpgGcDcfu6chqrtSM5a4iyw=
X-Google-Smtp-Source: APXvYqysyXj46XZKolpDVMKMm3N27kLYU6HO/5k9ZX0vZsM4pTd6G/V8oKqhDoJ1j9A3We6j6xi23A==
X-Received: by 2002:a63:d10:: with SMTP id c16mr3717008pgl.156.1556222006665;
        Thu, 25 Apr 2019 12:53:26 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t64sm47261961pfa.86.2019.04.25.12.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:53:25 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/32] coresight: catu: Cleanup power management
Date:   Thu, 25 Apr 2019 13:52:49 -0600
Message-Id: <20190425195310.31562-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425195310.31562-1-mathieu.poirier@linaro.org>
References: <20190425195310.31562-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Drop the power handle only if we were successful. Otherwise
the AMBA bus code would do the rest.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-catu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 057627a0753d..4ea68a3522e9 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -557,8 +557,9 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->csdev = coresight_register(&catu_desc);
 	if (IS_ERR(drvdata->csdev))
 		ret = PTR_ERR(drvdata->csdev);
+	else
+		pm_runtime_put(&adev->dev);
 out:
-	pm_runtime_put(&adev->dev);
 	return ret;
 }
 
-- 
2.17.1

