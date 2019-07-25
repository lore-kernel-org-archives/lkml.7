Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B628C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6E522C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 10:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xll25p++"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391258AbfGYKnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 06:43:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46339 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390594AbfGYKnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:43:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so47609508ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bqNWMnLE1PbsRnnTAlLi7jFwRUSXzMghW6te+X0yZdo=;
        b=Xll25p++OSqUympG1TKAn42FqQmeQWteoSD9URWb0ZedI4gKc+AC8GxyAuyEyNGFPt
         UZWbhBuSrtRR7sE7rXD19EcJT1aM3eMGJjGDenIhA8ya5vlewXcjoDp9Z1PvSdxHQnVg
         IEvOQecMvRMrMlV6fWr5FgGMhqMD8ToEERkByq8y+l3qtMByjjsGEwEqEVXTd4Prh/hF
         UB4OvljqaxQN6wHo2oay2+mQ8aBS/12QTCGDY7y/Bukv7b4Bhffgz9V9mKJB5wQ1/u5R
         YppvvAta56I7A+RsLGD5YxDcLSNVH7jOb5rEwdbF+TqlQ8wshQJ5oZ+yN0Yi0eFPpiR8
         +caA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bqNWMnLE1PbsRnnTAlLi7jFwRUSXzMghW6te+X0yZdo=;
        b=P4plLNTKRjhty7dOi09LnHo/4v2vBuRkZWpW1PkZXLWF2WY9Va8t3Q3lgOyBwfyYvA
         lGfbLo3u0F8eqqSyKjuFgqOsj6j2tEp6AJdETgrlj162OmrnsdYLZSnDXrBX8IfYVfSg
         aY0ajHnumDgRevs90uK24UF69MkVpwjKCyGTxCrPudGBB7d/Ibu+8vYVWFF0zrR7aNyZ
         IHrcPnuyVWn/JSJYiZRqdKch27Jp0+IcjZpjBwcTN7MmVFDvTKNHeteeo08sf+6ny+Sw
         haMqYfE/5gJwTTLpuYIdSJlsmul2vEpWgRwdVlNr923cyH+VRLlxV0PStkQp2Eue9OHY
         GclA==
X-Gm-Message-State: APjAAAUKeeBTISJ33KlKJ8XLRl9OnThYmizyjrU+Xu++Xt/Ub0vjFhlx
        vTDOZ9H09EgIcBUADZSNNrZCNTVHem4=
X-Google-Smtp-Source: APXvYqw5L6FlJHspttdMFLkgGxIyc8rrEJsJJ2fVabq6tJ+1l16Yk1HyGtXUmge5MbAWqs8jf0sSRw==
X-Received: by 2002:a2e:9209:: with SMTP id k9mr44596234ljg.96.1564051389696;
        Thu, 25 Jul 2019 03:43:09 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-44-230.bbcust.telenor.se. [83.226.44.230])
        by smtp.gmail.com with ESMTPSA id 63sm9139580ljs.84.2019.07.25.03.43.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:43:09 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 13/14] arm64: defconfig: enable CONFIG_QCOM_CPR
Date:   Thu, 25 Jul 2019 12:41:41 +0200
Message-Id: <20190725104144.22924-14-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725104144.22924-1-niklas.cassel@linaro.org>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_QCOM_CPR.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 04b7fb26a942..3e7618818250 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -420,6 +420,7 @@ CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_MAX77620=y
 CONFIG_POWER_AVS=y
 CONFIG_ROCKCHIP_IODOMAIN=y
+CONFIG_QCOM_CPR=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
-- 
2.21.0

