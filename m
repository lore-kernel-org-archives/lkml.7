Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D4FC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7554420645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561522509;
	bh=S1eiOvdZMkoN8l8BhRNif+YXsf8oBLitRpZS4y2TeQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sAQMCUqIBlACjOB3v+EyzyH7ZAaD3PZg95oBNZv7HquGfzULYGJuX42SbZ5RMHJw4
	 K7KigO8B6OUlsGWN2l0/lw1YGANjNkSCqMyEtyAjaHsgdTdaNhmny3G9H9QSevyBzG
	 Rtsy1iY5psbk/Hc0gUXH9h2Df/LeuZRb7mApqI2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfFZEPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 00:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfFZEPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 00:15:04 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DDE8208CB;
        Wed, 26 Jun 2019 04:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561522503;
        bh=S1eiOvdZMkoN8l8BhRNif+YXsf8oBLitRpZS4y2TeQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OG65F81QAiXa1JlfObZyr4u9Z4SQSryhrzJdh2mCXeCb9CWm0h99PCBM8y7K4+TFk
         sJqr/1PEuAbRshKzbsTCoysFDFoS2EpWiyBAoN/v2OeLMrp8k0NJT+me6dtrKO1jvV
         ji8blzlSbKNlHkQIq9uLN+H2C42KDzG0I8OKNZPE=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 1/2] clk: Remove ifdef for COMMON_CLK in clk-provider.h
Date:   Tue, 25 Jun 2019 21:15:01 -0700
Message-Id: <20190626041502.237211-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190626041502.237211-1-sboyd@kernel.org>
References: <20190626041502.237211-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ifdef has been there since the beginning of this file, but it
doesn't really seem to serve any purpose besides obfuscating the struct
definitions and #defines here from compilation units that include it.
Let's always expose these function prototypes and struct definitions so
that code can inspect clk providers without needing to have
CONFIG_COMMON_CLK enabled.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 include/linux/clk-provider.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index bb6118f79784..3bced2ec9f26 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -9,8 +9,6 @@
 #include <linux/of.h>
 #include <linux/of_clk.h>
 
-#ifdef CONFIG_COMMON_CLK
-
 /*
  * flags used across common struct clk.  these flags should only affect the
  * top-level framework.  custom flags for dealing with hardware specifics
@@ -1019,5 +1017,4 @@ static inline int of_clk_detect_critical(struct device_node *np, int index,
 
 void clk_gate_restore_context(struct clk_hw *hw);
 
-#endif /* CONFIG_COMMON_CLK */
 #endif /* CLK_PROVIDER_H */
-- 
Sent by a computer through tubes

