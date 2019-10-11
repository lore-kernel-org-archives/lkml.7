Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A43ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEB4214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 23:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+ZBRH4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfJKXul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 19:50:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43727 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfJKXuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 19:50:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id i32so6642147pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 16:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EgtZMQuv8rVlaVgRlgv5EqHSKVxfWJrgFI1xeOtDznY=;
        b=Q+ZBRH4JMLVEz3cKNEBDilBpczI3cAfNTxVUQ0GmOaaYQMrnhMpBpG/oMkEbPv6Odf
         8GGYfPNZshLNysepMYmTkT+3aNAgXugsY1CpHbIdxbtdrQQ60VUYCVdhNKtGJPZ9XNmZ
         yeC9ihKcyyHJaIzy1EL8IqBelW7q7XUwmg/Hj26mRmV0FwdkKluXBx8bn/qC4si8Txjq
         BJcMrTQsWH7JShE3N5uQdrbWPaMlnQ7E4TerYqhVVbjckQYF1dRgiIH2UwHVA4jeybRa
         ct5jnHOzbs9B/OYFzSNZbT3pquua3lDioCSE2rTR4TEhQ2ocWM1R5k2um3dsc3fczhsT
         9efQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EgtZMQuv8rVlaVgRlgv5EqHSKVxfWJrgFI1xeOtDznY=;
        b=OKEsapGq5MkROMwLFWISSWWM8D568SfeMd7vkrKgLV7KkC3H7YXAuKeSfBHJoBjO18
         Lm4h3cra891EmGM+JCsOo8PnXp1Lkq0hG5QUh1fcLBKTnln1/Pu5fCGUFfLSaDovAE7+
         GuqxUsjTSIZLx7ApQIcVOy0TenbyohBJGaVLxQpC8lCTNLuGXgGLOcPdX48g4VIXFl+u
         YUIv2tjLioxHKLhtXvsR3N5eHSpBeTgVU80jH6R6qSL70yTMvVuPfNkUNRG/eZAnTMJR
         eN8cQGJmUtzunQbm4srqxRdx4RvuQZRv263jU5pnSEmjnfdfXLA5Y8szrRZvAUzdIiAm
         s7tg==
X-Gm-Message-State: APjAAAVmWrPT4XT8GGrk2mSmo4THAou9yjOmU/PxX2odk88ALOTsaCLu
        07+SFqo0+V6kTLCn4djdWwc5cA==
X-Google-Smtp-Source: APXvYqxyTECy/5ImThDv0fD4LqF+cLTW2tgyxri1a1OulnP2BTV3jWbPhAnqE9psBlNscebeW3EiBg==
X-Received: by 2002:a63:a357:: with SMTP id v23mr19518356pgn.383.1570837838628;
        Fri, 11 Oct 2019 16:50:38 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id ce16sm8784551pjb.29.2019.10.11.16.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 16:50:38 -0700 (PDT)
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
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Qualcomm pseudo rng
Date:   Fri, 11 Oct 2019 16:50:35 -0700
Message-Id: <20191011235035.374569-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most Qualcomm platforms contain a pseudo random number generator
hardware block. Enable the driver for this block.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a5953b0b382d..688c8f200034 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -855,6 +855,7 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_ECHAINIV=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
+CONFIG_CRYPTO_DEV_QCOM_RNG=m
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_PRINTK_TIME=y
-- 
2.23.0

