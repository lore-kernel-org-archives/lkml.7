Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E5DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1D92184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 13:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UA6IDtRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfCTNS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 09:18:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46142 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfCTNS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 09:18:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so1673650pfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xvoojo3eKvN4L9IBWkrmUvvE40O1kNL0V6YvK2/qLWI=;
        b=UA6IDtRGG1iSXnGLCyBPaG1oaix6XoSFsMXsBU/HaGX/lRyR3s8eO7kDJh7A2Aziaw
         mSpDWFxMetNqY8YMvDCMz6zrHbMuO7u20p+1HlfN9JsoHVVbopHjQM8SzpJZF2kyx8mY
         uJaBB8e2K21w2MHHkgo87ne6eaGvpGv9ZyzjjXYtj2C6SV4wz/s9WsURw2f0D7kswzyY
         //s+Tc4UOFyZMauskzGFdPOWF8Qv+7sgrc+1EHPTV/IBgt2Rt1MJAK9lveTRSzQ5abXo
         zcAepPC9NE1Swcc50zRHPokuz+uLNRl0wU3rGklX7O+v9Xc8BzFsBnaytIH89luyIhNi
         TOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xvoojo3eKvN4L9IBWkrmUvvE40O1kNL0V6YvK2/qLWI=;
        b=Lm2jnrMrlYHdDpxcdFAw0M3ac1ekn82jNYim+KoNDOqkJ6qNiW4xyg2DeFnJTg3lzI
         MOS0tUIJDAo/LKnZrNdI34HRY69M+2+u8jt9uaUsAgMBrmSK2C6ehqbdtBIhnqBhHWUY
         wUTIP35s6mV/Akh7CV5PrLg70g+Qpt5JL9Lz54iYbMDDL7FVOs3JShpo9Ae+ViIqmLp8
         aquRj2w8iVFYULDkc79wTn2DX6K7SrvWNMlR2BmSv/Ld93V13/vxVGAXdpWdfJY6AM0j
         wXU73hlEJ0LFk+HY+vavaYwsIucgoR2FPTQDSw/fyjg4Kiacqwzh6qaAuy3DLQ2hrTyx
         CpGw==
X-Gm-Message-State: APjAAAUKtd9Wx46CVpq0/BZa6Ya1Y82qKBN/WaNm2CWTwSOEGUiaSq+/
        mdv84WrNagbpEKiaXqkFEoj6X9TOSk8=
X-Google-Smtp-Source: APXvYqzGTP4SEIDTetWccjFdXI1BVLfS6nOtusIGD2Pvz+InbtFxeGYmdlpx3wLkHxt7oSKoK8IXHg==
X-Received: by 2002:a63:4e64:: with SMTP id o36mr673064pgl.213.1553087935197;
        Wed, 20 Mar 2019 06:18:55 -0700 (PDT)
Received: from localhost ([114.143.122.221])
        by smtp.gmail.com with ESMTPSA id e14sm7704140pga.61.2019.03.20.06.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 06:18:54 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCHv3 07/23] drivers: thermal: tsens: Rename tsens-8916 to prepare to merge with tsens-8974
Date:   Wed, 20 Mar 2019 18:47:47 +0530
Message-Id: <fa9063b2d4f0b8bea8163d3fd9880f450fc57bc4.1553086065.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1553086065.git.amit.kucheria@linaro.org>
References: <cover.1553086065.git.amit.kucheria@linaro.org>
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

