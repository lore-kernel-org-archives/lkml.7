Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC577CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B9C21655
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BStLCrRV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfJZLDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 07:03:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40595 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfJZLDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:03:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so2784908pll.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LG1a1A4v+UDy0LaHh34rRqStYpMLpkQr762xn5ClOV4=;
        b=BStLCrRVcfc9W2U7icjoCMX1Gj2iRhLpWeDE7qvJtv6LcI9rhj70IuJbL0jmQZ3NuP
         Thp+P7E0x4aeamgW204c1aDtCszgv5gf5jDU8zIG+As1R5vO6Pgqvttvz11RxCs5eYiM
         YSJWVo0gp6EVaeN/5LeNqOF5MpAodMT00ThV4Yx8A2kM4v/FDfk78BfgqU2k5uFk9R7k
         Nu+1gfqE3TflzF8j3navuOEVe0cgZU95yYeI3V6CaHemVb6LgzUwd5jng+DST/+eK+uf
         wrhytSbHS4AHuggxdSCgeZc1knDQgChWTwclqOxabp5ZpXH1DZFUkaCKTdIEysWNrMC2
         fYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LG1a1A4v+UDy0LaHh34rRqStYpMLpkQr762xn5ClOV4=;
        b=VqpFpUNs36YStAGwLd8YpqYHKtW5BF7VBZmpGh0NITlIQOAXVG8R/gFYlN/KGLsQ54
         aei8DDVxoM0SRn7dV7YMOih4EgMNXAx6R78wfI5qoO/ir49qHeh0vaCq71P81mZ8PN01
         y+9A3DjsDmI1uhPpsBKJslJX+yYDc5J0ZQMbRix+oCCIh3gabarezsBqtTzi/t53KlhH
         EB0IUGw3Uu7PFEQ2HTCf8elj2R0Q6VTNKrJVy2pQaUwKymnSXeKK2rWOtXY70Tp2LvMh
         zZ5WkaXbfpdVv+pDwA8BD/vBsrwooB7pvQ41azhT0zD7UeqGeSpIJXyqjk9uMcN2025e
         kHkg==
X-Gm-Message-State: APjAAAWzxEBOpjAVetQ0iE6IXy+fTkNerWcLursjw59Mz3llcBfoQnHv
        FYsj4nN64b8wTZTQb3mq1Byr
X-Google-Smtp-Source: APXvYqz1uqRPaKKF0vNoP/cKXvuFKk9g7nVxs3J+M5W2qBHBPSzRNdJaW7SN2BUOGyi9FoXo7mqZoA==
X-Received: by 2002:a17:902:700b:: with SMTP id y11mr9348966plk.29.1572087798132;
        Sat, 26 Oct 2019 04:03:18 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6214:69c4:49ad:ba3c:6f9:2d8a])
        by smtp.gmail.com with ESMTPSA id x129sm5543379pfx.14.2019.10.26.04.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 04:03:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 2/7] clk: Add clk_hw_unregister_composite helper function definition
Date:   Sat, 26 Oct 2019 16:32:48 +0530
Message-Id: <20191026110253.18426-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org>
References: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org>
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

