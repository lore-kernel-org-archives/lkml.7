Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E13BC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348FA21738
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2pIBOZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfHGBZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:25:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35514 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfHGBZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:25:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so38580450plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 18:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7FaHyZF1ytvXmMKwCY/+k3LPm48Hqmka/roO7lTdlfk=;
        b=W2pIBOZDMlqjCRetFToDIC8mCbZmZSEt/H5K/cFfP2QAj+Od/VAzU39DoUW/gu4mRh
         MfcvcIf34TrCsKQa7YjVxazj1Gzvnrik2WCVQMCQSskglgalm6XupTZwluycEDv051xH
         5pLALLcxXXgkIRz+3YC2zEOpiTXCb673jQ8IH0Jqm+c8V+QSLglNvsOy8hHF3pkIA5sU
         UbzUvQ3WZ/HOVdbU2uja1ewMrNfFZ6YpPor+o0W1FHaHKvEjpVEyi2cGz9Otoml6Tc3o
         719QBFWIWECKfiXvXn9LleI4h+7q3D19Px1wbOHB+yTc/wHKeUVSf+xct0s9Rbdu4mNs
         KDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7FaHyZF1ytvXmMKwCY/+k3LPm48Hqmka/roO7lTdlfk=;
        b=aeMClVdPRF4z8LjcS94n/EbLhFqGGH0UJ097hUvtMJSFPtUM2KZSbIvS65WYORJVA2
         GdsNWobP4SL0xMF996YpcXlwFf6qHxBAs8HvLFpaXRq8KKXCnGKWh7+hNmqnCqK3Nc4M
         vcFo6c7NjzcwKXNKsh+jtONb3Kpd+0HqQY1mYlhm0B2VfEgRcM7cy6d+NnLLI4U7sfy+
         g68Cs06xGTMvjv+CTrBitPiFDyGJHMBGkrmPh1Hnrnh3fbwt2LNqExoMag2lQ07TrFOJ
         A/k5hAZzhGkGxkDyhnlZqHtY14Whl7cde1d8X/NQ89mM4C1+kQwXq+oDuUFkvqxYDkof
         7Z3w==
X-Gm-Message-State: APjAAAXdCK1E/9F5Xl3hWhbUVoKUsDSqGddNqNC1X8vHSaF2a/wbuIzk
        Z+teGkf55+EcWf9cQhSJlObAkw==
X-Google-Smtp-Source: APXvYqz70zFAXr+KOybPQi1XC/A2h56130aPIZLAlrxB52DWP6wUc26wvAp+g/3nUGcOS2EQSNdAxQ==
X-Received: by 2002:a17:902:b497:: with SMTP id y23mr5916521plr.68.1565141100693;
        Tue, 06 Aug 2019 18:25:00 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a12sm16687179pgv.48.2019.08.06.18.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 18:25:00 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH] soc: qcom: socinfo: Annotate switch cases with fall through
Date:   Tue,  6 Aug 2019 18:24:57 -0700
Message-Id: <20190807012457.16820-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807100803.63007737@canb.auug.org.au>
References: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce fall through annotations in the switch statements of
socinfo_debugfs_init() to silence compiler warnings.

Fixes: 9c84c1e78634 ("soc: qcom: socinfo: Expose custom attributes")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/socinfo.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 855353bed19e..f0ca9d7c7966 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -323,17 +323,23 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 		debugfs_create_x32("raw_device_number", 0400,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.raw_device_num);
+		/* Fall through */
 	case SOCINFO_VERSION(0, 11):
+		/* Fall through */
 	case SOCINFO_VERSION(0, 10):
+		/* Fall through */
 	case SOCINFO_VERSION(0, 9):
 		qcom_socinfo->info.foundry_id = __le32_to_cpu(info->foundry_id);
 
 		debugfs_create_u32("foundry_id", 0400, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.foundry_id);
+		/* Fall through */
 	case SOCINFO_VERSION(0, 8):
+		/* Fall through */
 	case SOCINFO_VERSION(0, 7):
 		DEBUGFS_ADD(info, pmic_model);
 		DEBUGFS_ADD(info, pmic_die_rev);
+		/* Fall through */
 	case SOCINFO_VERSION(0, 6):
 		qcom_socinfo->info.hw_plat_subtype =
 			__le32_to_cpu(info->hw_plat_subtype);
@@ -341,6 +347,7 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 		debugfs_create_u32("hardware_platform_subtype", 0400,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.hw_plat_subtype);
+		/* Fall through */
 	case SOCINFO_VERSION(0, 5):
 		qcom_socinfo->info.accessory_chip =
 			__le32_to_cpu(info->accessory_chip);
@@ -348,23 +355,27 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 		debugfs_create_u32("accessory_chip", 0400,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.accessory_chip);
+		/* Fall through */
 	case SOCINFO_VERSION(0, 4):
 		qcom_socinfo->info.plat_ver = __le32_to_cpu(info->plat_ver);
 
 		debugfs_create_u32("platform_version", 0400,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.plat_ver);
+		/* Fall through */
 	case SOCINFO_VERSION(0, 3):
 		qcom_socinfo->info.hw_plat = __le32_to_cpu(info->hw_plat);
 
 		debugfs_create_u32("hardware_platform", 0400,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.hw_plat);
+		/* Fall through */
 	case SOCINFO_VERSION(0, 2):
 		qcom_socinfo->info.raw_ver  = __le32_to_cpu(info->raw_ver);
 
 		debugfs_create_u32("raw_version", 0400, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.raw_ver);
+		/* Fall through */
 	case SOCINFO_VERSION(0, 1):
 		DEBUGFS_ADD(info, build_id);
 		break;
-- 
2.18.0

