Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2DEC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3538D2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+MCT6FC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfKOQ31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:29:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43590 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfKOQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:29:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id 3so6910667pfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LG1a1A4v+UDy0LaHh34rRqStYpMLpkQr762xn5ClOV4=;
        b=o+MCT6FCGd+WLPn8gFBDBblgf8rcOhwpFOShXrIAWCth1EDnZQgAh9wIktxAFxqmCE
         nYspZdlwdqiIT1+w6cDCDV/VEx9cSjYOGuZQ9Lv7MVj7rfwUSmalKKH0OmFltlO4V1dk
         0ry7DjJAKKNlD87Ms32P0yyyJKSpcSCbz8u42CMhLWz0GsbAe5107hZbmop17mHFa/em
         kx+IKHPL4psSWxuyYHURIkLPf0wTS3F95i6q99S21wsceMzDF2oNFVJT6eOpArwnkktg
         hPendNqL/Yqv2AgbzdS5h+T1Qm3adznCLHo3MC7XtUbswyNlQpzVz1CkhuKXKyhnH4XY
         XA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LG1a1A4v+UDy0LaHh34rRqStYpMLpkQr762xn5ClOV4=;
        b=j7AlpHofIOi7kyH2idl1cm0zpu65dVHL8cvre3rkqc/RZSLi08sfLPQA67nxXccbHG
         jqfzTPV5me2h2/UY2fwvJDP+m5uYjOZ6BKI/VhgOS7RcPmPoCTtv6bl762bVtK+7w4MD
         qncIdWUJcH+brC+qon7nOOIUVV4quxADy7yzTC+EjunWbQEtLhuyJZ4wdOu8Vq7mtKnT
         nBbmsIqy6IaOcGtQ/edrIMS1xxx1U4gpWyhESZZbW2RAIYtQyH8Dj3MxV15rOrCaZy0n
         ckJr3KAERDzryYBaC4fcsru/8xRU2WkKNo9gIMoKcZohOLZrKI4YpBgNl3/z/0k4CcCw
         pR0Q==
X-Gm-Message-State: APjAAAUgSXUYi8Q4fVD1rwaFbEOFLFCGMT/T5e+CA1852pEyaryYgDbo
        kVUdP9qUsZT+FHqCeiRy8d1x
X-Google-Smtp-Source: APXvYqys3mhTCTv093AwgzZUQrAVuIZ1cJROMu4m1S5NVk8Gg3X8cU/Dzy9MjpXeeLsMUPLH2WXqwg==
X-Received: by 2002:a63:e26:: with SMTP id d38mr17097947pgl.44.1573835364449;
        Fri, 15 Nov 2019 08:29:24 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6183:6d55:8418:2bbc:e6d8:2b4])
        by smtp.gmail.com with ESMTPSA id y24sm12295288pfr.116.2019.11.15.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 08:29:23 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 2/7] clk: Add clk_hw_unregister_composite helper function definition
Date:   Fri, 15 Nov 2019 21:58:56 +0530
Message-Id: <20191115162901.17456-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org>
References: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function has been delcared but not defined anywhere. Hence, this
commit adds definition for it.

Fixes: 49cb392d3639 ("clk: composite: Add hw based registration APIs")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/clk-composite.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 28aaf4a3b28a..3e9c3e608769 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -343,3 +343,14 @@ void clk_unregister_composite(struct clk *clk)
 	clk_unregister(clk);
 	kfree(composite);
 }
+
+void clk_hw_unregister_composite(struct clk_hw *hw)
+{
+	struct clk_composite *composite;
+
+	composite = to_clk_composite(hw);
+
+	clk_hw_unregister(hw);
+	kfree(composite);
+}
+EXPORT_SYMBOL_GPL(clk_hw_unregister_composite);
-- 
2.17.1

