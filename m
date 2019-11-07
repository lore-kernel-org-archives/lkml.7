Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A23FC6198
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC6D2187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BSmq2BLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbfKGAJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 19:09:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44145 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbfKGAJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:09:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id q26so545119pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 16:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I4KKU3lnlQMUNYRTg4PG0tZkLk5GCpHdCevi44aaMqI=;
        b=BSmq2BLgOR2hAg+twaNBN+Lj06RNuWYteaIO9NyMxnlT2bzZibvLzHW0s8ALhlnOmx
         +ca0rhqfcYfyqeQ4dJJ8PDsPW2BNwJ4EJECnai5F9h/zDdn0cNA0JzHZxWo9cR00oYUM
         T68KXHA5q8BGJXdrLyXd990555c3Ysgg48PLrEAEakcMzsK3ru07Vm8GvYGQnEP3edO/
         WQ2BiGbhZ+W/IUUH7PwIdxUE4+9CvGy9P8xipawoJRpbr5gTC8Wyo3GUibMG+XFQnSOD
         xiaPU+tTleHyfOi2hemCu4pLCvo15tM4b08Ld12kmfC/LUUBGVIOGBG9KtLguHNcRWMw
         91ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I4KKU3lnlQMUNYRTg4PG0tZkLk5GCpHdCevi44aaMqI=;
        b=ECJeOpGUVRrrz9pP84aCLfI0JSG7WW1ZyvgGAyKBppGjJstK90loRsbBq0oLsdPRdd
         lFcy/zKB84IHnRT8POc5Q4H86BgBSpk2uzFs6wmg2mAqI/onL7XScyJt9UYc2cjVGxSs
         n3Px9LY0Q/gZw+pMVr0L2u7KyEJE6B1W418o94A3zskYIir4qqFbmoWZsuAIsJp8sIDz
         LVQUAyfgRibVmQOUmN2PbmsJ2XfXydEqhiRpS2vVJLU35JnsznMerjEnyHsyaplVajK/
         TmuY89A4zAsxC2hAI5B8FR2ivNp5T/AstVqd1HjHeqwxZ2NsaKzZN7wCTWRuCVPIVKQo
         qanA==
X-Gm-Message-State: APjAAAWdI8jpaYzW0QCMFqtBaWybMftH6h9cj5S+yAao8O/Zhb73JjFR
        f6kvQuenYgOAFMA7Vjlvt6l5Fg==
X-Google-Smtp-Source: APXvYqx4fX8Gn+t3Rh3bmDBrB/ZOu/6lTbIy0+fAFGSErMBTtjm4GnANtgUhaKocS8/SeNeX1xNL4g==
X-Received: by 2002:a63:a747:: with SMTP id w7mr772076pgo.310.1573085363153;
        Wed, 06 Nov 2019 16:09:23 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z23sm216549pgj.43.2019.11.06.16.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:09:22 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/5] phy: qcom-qmp: Increase PHY ready timeout
Date:   Wed,  6 Nov 2019 16:09:14 -0800
Message-Id: <20191107000917.1092409-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107000917.1092409-1-bjorn.andersson@linaro.org>
References: <20191107000917.1092409-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's typical for the QHP PHY to take slightly above 1ms to initialize,
so increase the timeout of the PHY ready check to 10ms - as already done
in the downstream PCIe driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None

 drivers/phy/qualcomm/phy-qcom-qmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 091e20303a14..66f91726b8b2 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -66,7 +66,7 @@
 /* QPHY_V3_PCS_MISC_CLAMP_ENABLE register bits */
 #define CLAMP_EN				BIT(0) /* enables i/o clamp_n */
 
-#define PHY_INIT_COMPLETE_TIMEOUT		1000
+#define PHY_INIT_COMPLETE_TIMEOUT		10000
 #define POWER_DOWN_DELAY_US_MIN			10
 #define POWER_DOWN_DELAY_US_MAX			11
 
-- 
2.23.0

