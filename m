Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B759DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5982186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/3Va+4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbfHZQs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:48:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34498 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733219AbfHZQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:48:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id s18so16028772wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SRhxgEvWQVs1ea73JEbbvWRCETzD6iEjJpSYclHjhyc=;
        b=X/3Va+4bMjUIzurD6wGQMAOoEEujrfWU7PM6u7RIEiGvFhdjn0OVNT0AbPtGenMdH+
         /i6p/TEo31Krgq+peIUPumD7Rf+13msz02Mt8RIiW/BnWsaEVqdq2vWyCk3RlkEIzE1K
         OH0noWzpBpa9N/ULhXR8pvPgjaRPQJ+sFX4C5aQDxxASww73c6T1aYF1ffJsA09vmEDq
         8HUVNU3BeqIDAw+IjY/OaWIJd+a+ZNKWEiQ4+/NzQSE5p/Uq/QRsXhEA5P7p9Joq8BKT
         Boya1nfoTJRq4isvaIpibtFroNjS41KPMsOXA5vot1Al3wAVLXF+UvNrEVoJC8tIwWlK
         QuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SRhxgEvWQVs1ea73JEbbvWRCETzD6iEjJpSYclHjhyc=;
        b=icmOV85ICFhhpzMvMe9vFOK2fA2m+kWLKykwzxtdgVy0NePvNvLPbMuzK6H14HO0Vw
         ybJNmtqCcf7amLNrXPGLOmuEvoR/MTLdi1IswGqBak1mfXSAXsbl4gqdDvof63h/j1/b
         9IguWA0YVGJMWmGhyG/uylR9WrSbMzccjOz7LqL7zMgpdK5gsUrUiQpsfMDwVCz4LQz+
         PxupXAwcbPFdZdeUUrZ0VGt6mm/LumGXnGbie5LmP4Kw+R2TKFu0jlJH5neInosbFwfx
         3Qxk/GGmhtFaxxss/hugZGqqSC8UfWrrza5PWiR2hll9M3skezLp0WF6UPZNVYGWr9ZC
         tuuw==
X-Gm-Message-State: APjAAAVzsQ+b1CUpAAiRG3jO+auY4EfVOmZF+DPUPAm7xG3xIRL/FxOx
        w02k+Nanw+vWSq3jDAuRXjdr1A==
X-Google-Smtp-Source: APXvYqzZ3xC4kfENRK961Lw1r8AEKtqPndX79PH8Zl7tkFhGXbf13HhvFBfq/02dXMrt+BqkZbslyg==
X-Received: by 2002:adf:9e09:: with SMTP id u9mr23619223wre.169.1566838095223;
        Mon, 26 Aug 2019 09:48:15 -0700 (PDT)
Received: from localhost.localdomain (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id o14sm21800076wrg.64.2019.08.26.09.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 09:48:14 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, agross@kernel.org, mark.rutland@arm.com
Cc:     niklas.cassel@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: defconfig: Enable HFPLL
Date:   Mon, 26 Aug 2019 18:48:07 +0200
Message-Id: <20190826164807.7028-6-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826164807.7028-1-jorge.ramirez-ortiz@linaro.org>
References: <20190826164807.7028-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The high frequency pll is required on compatible Qualcomm SoCs to
support the CPU frequency scaling feature.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 74f82901aa2d..af13602c3987 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -703,6 +703,7 @@ CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SDM_GCC_845=y
 CONFIG_SM_GCC_8150=y
+CONFIG_QCOM_HFPLL=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
-- 
2.22.0

