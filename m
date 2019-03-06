Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A307C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B5920854
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nI2UrWF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfCFRr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:47:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34285 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbfCFRrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:47:14 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so8985150pgd.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 09:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oBZ8sxxMGg3aMYJDNUgn+TSIDMbgVfPO7ogD65Yj6kM=;
        b=nI2UrWF7RpU7tNN8WkgmIPRpACpS7NRT1WKf5L/6h3GqcnncisSQrXLv7yzBRrOV0J
         8vIcnudSCbQ+85cTQUgDpJsX+Fr34PzfJ3jQxspVFi1qsnyFm/m3Xs8AR/S6njfp2X2w
         l6EwaZLuFOlyNiP3YEr1ORGO8HN6ExP4envur8iDON40kR446+EguUftAsmvdmt8JgQp
         5bwF68bqXNDhS8Q1AYCSbojfe/ExxO5+Aw0nAN1YOBxM4bKoOOJ8jIXu0wOXJZrj6elh
         8jJClWN3s6yWbyy/i2O7jQatH8f3aPrCPjHlhg5yQTcxCQnG3U5LquI59ABl/iSvGgoY
         /g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oBZ8sxxMGg3aMYJDNUgn+TSIDMbgVfPO7ogD65Yj6kM=;
        b=UZqtDOKxzUqJNo2IcPq3iZ4jL3kKoxM3h0/VxGt1Z9EeFB33YVM3ikSfSnZ01i2s/H
         CwvwKLxb6RlxvQOpd6Rp5dZ+nyKKPeWNVllETNyKrJ+y7QlxE6zIeeDfh/I+Hac4P/gs
         xtlpRaKgYKlcTBc1GT5Lo5YbT3I5q0APyYBmf4SjeRfMj7V/ThNPhyQTIAxUUyRLF16B
         CxGtAeFOLZK1FOWD5hfbwsesINHfUBgjFiU87DpPCWvmfrHKpOldoLEcaf7H3erUPzti
         Kp2t1wTe975HI7hZ4RVUIrfH08tl6u2lw9b9RT01K4sVl6yQdVZ8t0/bpwxRZo0jznP8
         YleQ==
X-Gm-Message-State: APjAAAVoehw1fcKTsNLUAhqTLGa1iWvad1b2FEcLvxf6n1syEzmIV4vF
        Hu8rIBsVxLaPc65C76+FTvspcg==
X-Google-Smtp-Source: APXvYqwvOm5jgoN9OHBhMYX768Y3KCZWsp6YwEfaPkb0XZY4qFhssogqi64csOCMNU5vFlWxTveObQ==
X-Received: by 2002:a63:2c50:: with SMTP id s77mr7392020pgs.440.1551894433640;
        Wed, 06 Mar 2019 09:47:13 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h64sm4098293pfj.40.2019.03.06.09.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 09:47:13 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] clk: qcom: branch: Add AON clock ops
Date:   Wed,  6 Mar 2019 09:47:57 -0800
Message-Id: <20190306174758.22462-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190306174758.22462-1-bjorn.andersson@linaro.org>
References: <20190306174758.22462-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks can only be turned on by resetting the block containing
them, provide a clock type that allow us to reference these clocks and
have the client drivers enable and "disable" them.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/clk-branch.c | 6 ++++++
 drivers/clk/qcom/clk-branch.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index 99446bf630aa..f869fc6aaed6 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -146,6 +146,12 @@ const struct clk_ops clk_branch2_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_branch2_ops);
 
+const struct clk_ops clk_branch2_aon_ops = {
+	.enable = clk_branch2_enable,
+	.is_enabled = clk_is_enabled_regmap,
+};
+EXPORT_SYMBOL_GPL(clk_branch2_aon_ops);
+
 const struct clk_ops clk_branch_simple_ops = {
 	.enable = clk_enable_regmap,
 	.disable = clk_disable_regmap,
diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index b3561e0a3984..17a58119165e 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -40,6 +40,7 @@ struct clk_branch {
 extern const struct clk_ops clk_branch_ops;
 extern const struct clk_ops clk_branch2_ops;
 extern const struct clk_ops clk_branch_simple_ops;
+extern const struct clk_ops clk_branch2_aon_ops;
 
 #define to_clk_branch(_hw) \
 	container_of(to_clk_regmap(_hw), struct clk_branch, clkr)
-- 
2.18.0

