Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A62FCA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 19:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB8A222C5
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 19:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uG/U93b2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfJST6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 15:58:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38290 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfJST6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 15:58:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so5248377pgt.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=266Y0hXS9BC8c58tj7q4sT9jtJ0HQTa0yWk7IcR2wTs=;
        b=uG/U93b2A8I0PII6bxFfdt6TH1kECEIuI+qHTm6K3KY0l7I1StEOvn+GUkCZFZGlKr
         R0K3mq75ExZFMrumknpnY8XIfzX8oBIdma6UHZyEJugAdc5XYAgbJ7WPC1spzgoS8emV
         G3iopRckBMDrp3PlUBrjv4fjm4ExFy/LGiWIS9ynO+IJ73IGDDfJppCnZLKCr7RE0qSI
         QV8Bzds8wI6i2DkYLb1iysEgMiSirDuwBooSKX1WvMkelE1av2pCwKMl4gowVrybBF7y
         6bYl0xgazXqgiJ3fMHyi+1BOvcAaJzrdmhccY3RSdG6uSN3+MeeqZLlcxiSX/movlg6k
         1s/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=266Y0hXS9BC8c58tj7q4sT9jtJ0HQTa0yWk7IcR2wTs=;
        b=C3JWU8foYSyG0HYRzdTFR+4JmwSScnCTcGQGpjwPo/VvR5fzIV0P8/KioS4qjhy2HV
         omca4Ev21HpA88mF5yoJY9rSrF7xYWYcREfg/RW//1oBdAoCJTPFHF5sJvjxIz64TR+v
         k5iwBSxdoW8L5/qNRdYhCVfMyudBOm7uUEyVHbTvqPig3fgtzTGH5X1pmwqXeDZAHn0S
         Px8gJ7gXZBVm16TnOCKqpujrCsh3GJXSCY9PlsIFYV1qVjpTen9ixbLtBBiRXDoV7WFN
         8gtQgG8xFFtzz/F9malIDsCiU2vjBD92iFvBRsmN+OOqkcWSUIZgIyWHlKKHfWoye5VM
         LfZQ==
X-Gm-Message-State: APjAAAX6wL9m9UOet2IP6N82lGkJy/swUKqEnEDJZVZ7lojArE41eGoL
        RQy73YpCoZB9Telc2fKPPOzg7A==
X-Google-Smtp-Source: APXvYqxthdjowhAfa+DBog8jfZPwJlkwc/5bBE/nJLagsS8UKZv/Dc/OwAsuZFQAQGcWOh+laGTHFw==
X-Received: by 2002:a17:90a:bd0b:: with SMTP id y11mr19444285pjr.28.1571515097002;
        Sat, 19 Oct 2019 12:58:17 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v1sm10183866pjd.22.2019.10.19.12.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 12:58:16 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2] arm64: defconfig: Enable Qualcomm pseudo rng
Date:   Sat, 19 Oct 2019 12:58:12 -0700
Message-Id: <20191019195812.3834545-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most Qualcomm platforms contain a pseudo random number generator
hardware block. Enable the driver for this block and also enable the
interface for exposing this to userspace.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6baf90875263..4591bf1303da 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -860,6 +860,8 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_ECHAINIV=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
+CONFIG_CRYPTO_USER_API_RNG=m
+CONFIG_CRYPTO_DEV_QCOM_RNG=m
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y
-- 
2.23.0

