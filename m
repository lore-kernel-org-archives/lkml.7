Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C50C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246E820730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 16:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vYxpcpmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfKOQaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:30:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41947 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbfKOQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 11:29:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id p26so6915276pfq.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 08:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vyxQq6l0DnXXPlNTL9PGBy7Itz+G0TwXgp9Tr10w+hM=;
        b=vYxpcpmYjKU505XimxG9aE30KFTlxC3O2y6sV+mQAjvNjy/GP0tyg9bWBnxqBHXyup
         kN/FSlMRPGm0nSAEWl/wfvXvZnmCw0CPqq9kszndciTlgHWqgGQT5hW+QPJd6k46wuQp
         EATT0nvCSJztIcTfqEfIFdt5472rcLHHooeMLtjHsmYqr2oo6MZZsZTcGCGAA1vakiop
         ilN1gfkgAc4BE5i9UcBtFMwuMdOHTbFb/vnntnFZyRIm5dbP39LKMxsF74gmUjuL5PkP
         TjSiPci8ZiI5PCKlVMZ5delLH/tJJiycPvCriQrKz28Bkoyr7NRbegbINpM++fZFlk1L
         z7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vyxQq6l0DnXXPlNTL9PGBy7Itz+G0TwXgp9Tr10w+hM=;
        b=gZc8l/kqkSw/vjZFk3MqUJHqP5LXoSTMdJzXTQMIKRPD2tD5BxOsFMDdXYbeWuvI2C
         YVHAK+T4+g9nYy95fsMOlncoQWEaLcD81SqigRfX5XwIpCwPoXeC799VBPvzW8v40sTr
         quaXIkjzM2gVGeCgMdG4FYMam8JGeEPmIAf17c2P0CR32bC5MCOU5aVy8zhX3mFCmLv5
         2PFrI/LBZDcv7Mk5D98BKVhO4hbvt9ZTzSJnHvL8KsIriSEfXhDHLl3mvjAMIM3QyYOw
         KfShR9SYCnITMn2/n4PjSU8pOwIwy5mnoyk1ZbaiuiPoOJMldWjTUNLuAnDv0FAbTo4K
         HN6w==
X-Gm-Message-State: APjAAAU8cHIviejaEUVjjJAjwFnVQJ/KB4lFwJe0oSSymEoYy86znPJI
        Oj4jhpehPZbt1jlfaWBYNJ4h
X-Google-Smtp-Source: APXvYqyHvbWvUHsrotDXNo3Uqb/ciOmuTBbvH69h1MhX5fWECe2j+LdfQeiepIjfp6mk4OXar6ZLVw==
X-Received: by 2002:a62:ae11:: with SMTP id q17mr7393595pff.103.1573835398499;
        Fri, 15 Nov 2019 08:29:58 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6183:6d55:8418:2bbc:e6d8:2b4])
        by smtp.gmail.com with ESMTPSA id y24sm12295288pfr.116.2019.11.15.08.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 08:29:57 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 7/7] MAINTAINERS: Add entry for BM1880 SoC clock driver
Date:   Fri, 15 Nov 2019 21:59:01 +0530
Message-Id: <20191115162901.17456-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org>
References: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Bitmain BM1880 SoC clock driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 52f3ac28b69e..40e9ba15ad2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1529,8 +1529,10 @@ M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/bitmain/
+F:	drivers/clk/clk-bm1880.c
 F:	drivers/pinctrl/pinctrl-bm1880.c
 F:	Documentation/devicetree/bindings/arm/bitmain.yaml
+F:	Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
 F:	Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt
 
 ARM/CALXEDA HIGHBANK ARCHITECTURE
-- 
2.17.1

