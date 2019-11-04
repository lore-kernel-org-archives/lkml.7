Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A371CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 05:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A0221D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 05:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCO4pLys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfKDFum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 00:50:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39252 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfKDFul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 00:50:41 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so8198790pfo.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 21:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6V4Ng2X5iyfEGtux8sUaqDYyz8AcDkQfQqSibvlYIc=;
        b=TCO4pLysvBOoL8EIC4plxLj8gT2iLvKmoR4+tiO8BnE81v1EhxFr72ndqebRTVeKT0
         1hOkd7EFETBgmGNMOJfJTXd5Ws6/XohdXNjXyHbSfBfJrtpeN5MQ58VPNTCnLVkIjLx0
         mCGjtqphAqjJzKN95Lhx32+FViP5JxkNG4ref0lL2bTNJS0xhVbJWqQRnwc8DNrc9JMR
         r35QrfQh9N11siawGdeiU6SeU2WJjwMl3C263KINGx6x0jbqY3BrhaH++2Tr+uX9mqh8
         EQFnLGU8+d1EtKujUUVdbwzt6sEikEzEvBb8aTpK3AfjAAnW4agbmcoEXjPc42Y2Hrch
         xCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6V4Ng2X5iyfEGtux8sUaqDYyz8AcDkQfQqSibvlYIc=;
        b=sRYDWSCLB11vTK8UPaZCMWpxGo9TlQbMTyh/gQSDtScaAdS3vtxbZKFfxSNMTOTSAf
         unQslhJdQ6jvVjgZJce9D7gMNjJVpH6iNcbRXLX/h+dLHBTWfnIrG90zspBrqachk08E
         CQr2PsBa0vygA+X8UF7wD0OIj2ga/wxy3xtIkJCGVIh4K2JfN+mTt1yR9hQlNAxVpxi6
         U0NPh9bRsBy4jeGWHjGXFZu3A6X7/asxvDsmfu7vvRPIFI/sUUrsWk4MvStz6I00uKPb
         F1FFU6LNGuqUsslKFlVxsNlVeqEnSvQcswas46QqW4nqna75psZYMF5u/WwKXNWSp6gQ
         BX4g==
X-Gm-Message-State: APjAAAVGFxC3aDGTwZE0B02ZpbhDBFvTTNtK7fcHCn88lBepjojKBulD
        dVQI5Lh2eRQlIWZZhVZaCvGowA==
X-Google-Smtp-Source: APXvYqxDddi16LlOqgfrQOBwBUsg/2SGpxXR7dY9XrhzQUmNAPSg6R/Gygx3anF1R6C85nbSpn6a7g==
X-Received: by 2002:a17:90a:ba17:: with SMTP id s23mr24849230pjr.78.1572846639768;
        Sun, 03 Nov 2019 21:50:39 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b82sm14107769pfb.33.2019.11.03.21.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 21:50:39 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add myself as co-maintainer for QCOM
Date:   Sun,  3 Nov 2019 21:50:36 -0800
Message-Id: <20191104055036.63414-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as co-maintainer for the Qualcomm SoC.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f33adc430230..8bba0f1a7077 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2126,6 +2126,7 @@ S:	Maintained
 
 ARM/QUALCOMM SUPPORT
 M:	Andy Gross <agross@kernel.org>
+M:	Bjorn Andersson <bjorn.andersson@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/soc/qcom/
-- 
2.23.0

