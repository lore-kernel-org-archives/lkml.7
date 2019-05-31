Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A016C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1302126367
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwklmqHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfEaDy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:54:26 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56116 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfEaDyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:54:18 -0400
Received: by mail-it1-f193.google.com with SMTP id g24so429494iti.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 20:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0MRFaUSMAfw/XRQQZHzE3aa0KzqIA2a6f7/ADiTDy48=;
        b=uwklmqHcoHhu1WLCfPLSWItOjPdTvghEYLBU6xALfWtsnd113VuUy3W4OCt7Gf7QPo
         41T0Kb96J3ZSXspViH4KCr3Z1SxedNQJeBOUBfoI6mWPpGqYqYDdnTOvkIRtYFl7he/C
         tuHhPYcxS4Bk+X35n/t9s33SCJGdhQWJcvM0GMVAvgKp0JhTyaf6a7pcaeMTEIKcmgXZ
         3tE7+sKkPwBES53s3TxVG2diUKbi6dwVeJNQMPdqSZXPSI3AAgq14TRNOQlsumqidDGX
         FlY+vsFjKBKkr8fzT6M0XgLfkjQO6tSythQDO4ptBHatoj3PqdEFPTk4RzUy6/qfC7sW
         yRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0MRFaUSMAfw/XRQQZHzE3aa0KzqIA2a6f7/ADiTDy48=;
        b=Qvy9W9iYvC7rsYVxGlO2dZgrX5T8BfIudMMuxBVQolVbMZ8X1uQ+z77u8hyXpQGtkU
         T9gAsEhvaAZLYw0Fg8dMWJ4rSbzLePTghoav/8P4q2/bGzZMkiuQN+0yOB2Vw5c40SQ3
         ShrMDY0OM1/nt5uReaxZSLVYtRGeghYnYOm/2PpNkij1QpXNt/0y79qKjAI4k9rHBNK4
         3eB1ZPuzYpU4OIl+ADOSrse8jUfFhqxHCbqi93JoVXH6v7fAWktFUwxdVHzXNcaIqo8R
         K+SicitLduY4keKiqPAr44AmmP0LaiMeVgo6GM2p8vGNM6SU0lg/FdR6tPqri9EhSM/A
         OILQ==
X-Gm-Message-State: APjAAAXDftGfk89VzNflUWt4cXVxivlnh+gLspnTkdvfXoq3vEtb90Kk
        o1DyjKS+5fXo93xqO3kf8c+nLA==
X-Google-Smtp-Source: APXvYqzAp7WqDtF2svw6m32RESqRJSWfwXgOZsWCJl/PO7gAfHjI0bpJKwO94bXVpo532sRxJONkgg==
X-Received: by 2002:a24:6583:: with SMTP id u125mr5701155itb.168.1559274858043;
        Thu, 30 May 2019 20:54:18 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id q15sm1626947ioi.15.2019.05.30.20.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 20:54:17 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        cpratapa@codeaurora.org, syadagir@codeaurora.org,
        subashab@codeaurora.org, abhishek.esse@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 17/17] arm64: defconfig: enable build of IPA code
Date:   Thu, 30 May 2019 22:53:48 -0500
Message-Id: <20190531035348.7194-18-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531035348.7194-1-elder@linaro.org>
References: <20190531035348.7194-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CONFIG_IPA to the 64-bit Arm defconfig.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4d583514258c..6ed86cb6b597 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -261,6 +261,7 @@ CONFIG_SMSC911X=y
 CONFIG_SNI_AVE=y
 CONFIG_SNI_NETSEC=y
 CONFIG_STMMAC_ETH=m
+CONFIG_IPA=m
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
 CONFIG_AT803X_PHY=m
 CONFIG_MARVELL_PHY=m
-- 
2.20.1

