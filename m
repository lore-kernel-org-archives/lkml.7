Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19809C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5C6821BE6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 05:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+ko+PGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfHGFju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 01:39:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44370 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfHGFjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 01:39:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so38912735plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 22:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Azf6n5aesLfo8ksF3UKgIcdUJWEiOJj+3CTvEIIBQEU=;
        b=r+ko+PGSH4q8aK6qnYsbCZwtAtGxCRoBAu0UqNc0v5qIAR1lC/J8nryL8EDZyoEMDG
         4r9EpEmt/97cLz8NEBISJRXL0rMq9YX93YRnbATgXoVc+oMZ1CZ1KAW97mWoeS8T5i63
         7Z+e8Rx1mPZHgYWigWROV/kgUgBJuSuSKQZGQdQ/S77mJodtmalmc0ov7gSKpf59tQu8
         +vhcxV3mwTeFx2YGPSEWzCuRVr1+uEoIGHp7XA4AbYpIboXOzCKseekx1AViw+avyrUS
         E+Z91JLny9fG6QnGJS3wocoAWRaJ7DUWgZ83p/mpnLRMxyWKseQMJ55WUSUsyQQoBKA0
         Ebgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Azf6n5aesLfo8ksF3UKgIcdUJWEiOJj+3CTvEIIBQEU=;
        b=r0XXJbXW7g/WQx6LnPHt+U/lRqpUXdlgnSjMeGptzarycxIwtruwj3AhYER3YLH0VO
         m5kZZd+GAfLYvV2wPKux2yHSq+7+dGtBhgomXE4/jQ53hsaAtrMDCHH0yIjAKiLls9GL
         9yb+iK9TLCpxS9IQ3Hvor6xQL9cGy7d3hBRm1AoDPyL/qfq2wK2ftyhrI9Lr2nsmB5cc
         obouhbS1UpA0rvS97dmfMmxhrWSWKe3VI6Ue4dq1BVONuwaHIX5LAU4BdiArfxlfu+s7
         nK8QfxG8m8fg4+/EvCXBdhb72loY9zXEE1N0QQ9beF079WEKb18L66XtEZ/v0/DcaFT5
         3Wyw==
X-Gm-Message-State: APjAAAV/+BewdXUrybUL9U34bI9Wi81vm3X+M9iTxjmP3zB2nJ/DZSpr
        g1xQFa5TkuLaSrgNLfsodYkhDw==
X-Google-Smtp-Source: APXvYqyKuaBrPqGXok98ifNvfg6y5GqCqXCL+MIHLatCigfYzr5K3VlYQwdzBhg3v3fj813Aanwqyw==
X-Received: by 2002:a17:902:788f:: with SMTP id q15mr6697292pll.236.1565156388456;
        Tue, 06 Aug 2019 22:39:48 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u7sm86070777pfm.96.2019.08.06.22.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 22:39:47 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH 2/9] remoteproc: qcom: mss: Update IMEM PIL info on load
Date:   Tue,  6 Aug 2019 22:39:35 -0700
Message-Id: <20190807053942.9836-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807053942.9836-1-bjorn.andersson@linaro.org>
References: <20190807053942.9836-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the MPSS address is calculated during load store it, and the size, in
the PIL info region structure in IMEM.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/remoteproc/Kconfig         | 1 +
 drivers/remoteproc/qcom_q6v5_mss.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 3984bd16e670..b88d74632d39 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -119,6 +119,7 @@ config QCOM_Q6V5_MSS
 	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
 	depends on QCOM_SYSMON || QCOM_SYSMON=n
 	select MFD_SYSCON
+	select QCOM_PIL_INFO
 	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 8fcf9d28dd73..d9192fa40e05 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -28,6 +28,7 @@
 
 #include "remoteproc_internal.h"
 #include "qcom_common.h"
+#include "qcom_pil_info.h"
 #include "qcom_q6v5.h"
 
 #include <linux/qcom_scm.h>
@@ -1040,6 +1041,8 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 	else if (ret < 0)
 		dev_err(qproc->dev, "MPSS authentication failed: %d\n", ret);
 
+	qcom_pil_info_store("modem", mpss_reloc, qproc->mpss_size);
+
 release_firmware:
 	release_firmware(fw);
 out:
-- 
2.18.0

