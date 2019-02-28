Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984F7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AE2214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alAznjjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbfB1MWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:22:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54618 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbfB1MWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:22:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so9070415wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xvoojo3eKvN4L9IBWkrmUvvE40O1kNL0V6YvK2/qLWI=;
        b=alAznjjtQ1KMI/tIuggzk0YX+9RfADJ/PPXCFpt+B48IiYVQisU3vf7Qwg4U5LAvAf
         hNrDjZwVl606qA2ZMqJafnhog1ur09n2ppLg+k2TPKI4HwXKAEkm0GqtVpXcD/tbq4fk
         69EU1C0DPu0XKUwqLdQ8Pn98GYKC9DPB2MkbHNl4X35EYYc+D/ds6dbfSBHCNRRlsGQT
         Bdeth3VrVfveEVIL6fVu/xOts9VT1o6O2m5u47dujJ4srCnsFhx+faip1l0fyHpjh1xf
         uBKBED32XzGrQ1sJE2BHcF1GxLSJquIdGz3y2rUtHhmysHoDaLvXl8aOOV8GlpnUAtPc
         vnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xvoojo3eKvN4L9IBWkrmUvvE40O1kNL0V6YvK2/qLWI=;
        b=AqeiPveyRi76RkU/xAzHEUdRgkIXy4k/KVkBAKolIZcPNEAOzTfPDz1HMstBM/KDpM
         H4Felev44+uriblEJWfhtdOteXneQvxnCv2wn5Tiz/L3QVL8y03ZSPWeZCK++Lal9Fz4
         ZRCERFpJoPhBUaKCggAMIjUb0wxcGSJavjkBbWZm67XWMXTkUfXtVtsn5wmgulbSwqcQ
         LKe00xMIlRIRsNB6JrrYovnmcbcVScL8PjdjXECyArXIpnLVevZXpXaB757ltaWOv1KH
         GwDfR75rAr0Nc+fcRianjQKgOnasZ/vme7Hm+uGfnTSh4i4bDIyHrgdoa4wMyVEgUVaF
         Yd5g==
X-Gm-Message-State: AHQUAubYNVorj1QLdA7tnG335IiV+c+qXs5qa7GMqEUnDrPkRKUV3/hO
        3f/r4vN6i264voXZMMA2iMrYHT1fi/M=
X-Google-Smtp-Source: APXvYqzcrvtWdrSJG2kC2af8pThY4dHRm/sFO6JBfITZNKinw15cRmJBWBatk2WgZDT+gYD6qOlV4Q==
X-Received: by 2002:a05:600c:224c:: with SMTP id a12mr2700481wmm.103.1551356534426;
        Thu, 28 Feb 2019 04:22:14 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id c202sm3869561wme.38.2019.02.28.04.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:22:13 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 07/24] drivers: thermal: tsens: Rename tsens-8916 to prepare to merge with tsens-8974
Date:   Thu, 28 Feb 2019 17:50:57 +0530
Message-Id: <00f3091fa0ab3211c831a6be877a627d771b6150.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8916 and 8974 use v0.1.0 of the TSENS IP. Rename tsens-8916 to prepare
it for merging with tsens-8974 in a later commit.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/Makefile                       | 2 +-
 drivers/thermal/qcom/{tsens-8916.c => tsens-v0_1.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/thermal/qcom/{tsens-8916.c => tsens-v0_1.c} (100%)

diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 717a08600bb5..1f2fafd43dff 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
-qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o tsens-v2.o
+qcom_tsens-y			+= tsens.o tsens-common.o tsens-v0_1.o tsens-8974.o tsens-8960.o tsens-v2.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-v0_1.c
similarity index 100%
rename from drivers/thermal/qcom/tsens-8916.c
rename to drivers/thermal/qcom/tsens-v0_1.c
-- 
2.17.1

