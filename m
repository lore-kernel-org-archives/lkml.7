Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759F3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458B92084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554246075;
	bh=7rorqV/VsBfFebbPCtoYldhwyDIn7d6gM23qMxulJlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nXs4IhSUe/ev94y/Uk9q1Og4/dGPD0WK2g6LDF+wz5dLrL7+QIm8d9Q16hGfWh34s
	 Z6waPckputO4ZX6+qCQOB76DjHvxO616CiCMWGLmZQnMGgyr1m0+7Iqu8Pr/dhIZPY
	 383NrDUTnrGwLjXKI74KrnkGXTnB+bWdLrZZbkPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDBXBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfDBXBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:01:06 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A6E220882;
        Tue,  2 Apr 2019 23:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554246065;
        bh=7rorqV/VsBfFebbPCtoYldhwyDIn7d6gM23qMxulJlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kX+xsByTBV7ZbIODI9xg0oA2pYE+Wmcv2vO/DQ1MrriItlbidDJnh+7YfgP1APL6q
         08DvzEiiO3RwpDokYBnny8seEEa57kuwtB+sYwSdzth4H1HLe/+ROlPZC3p4JPDVd4
         vt55Uzu/fL51969j20x9hid8Mi8E597X9xHHAPUk=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 1/8] clk: Collapse gpio clk kerneldoc
Date:   Tue,  2 Apr 2019 16:00:57 -0700
Message-Id: <20190402230104.105845-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190402230104.105845-1-sboyd@kernel.org>
References: <20190402230104.105845-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have two kernel-docs for gpio clks, but there is only one gpio clk
structure. Collapse the two so we have proper kerneldoc for this basic
clk type.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 include/linux/clk-provider.h | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index e443fa9fa859..b65b48cc31f1 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -712,16 +712,19 @@ struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
 		unsigned long flags);
 void clk_hw_unregister_composite(struct clk_hw *hw);
 
-/***
- * struct clk_gpio_gate - gpio gated clock
+/**
+ * struct clk_gpio - gpio gated clock
  *
  * @hw:		handle between common and hardware-specific interfaces
  * @gpiod:	gpio descriptor
  *
- * Clock with a gpio control for enabling and disabling the parent clock.
- * Implements .enable, .disable and .is_enabled
+ * Clock with a gpio control for enabling and disabling the parent clock
+ * or switching between two parents by asserting or deasserting the gpio.
+ *
+ * Implements .enable, .disable and .is_enabled or
+ * .get_parent, .set_parent and .determine_rate depending on which clk_ops
+ * is used.
  */
-
 struct clk_gpio {
 	struct clk_hw	hw;
 	struct gpio_desc *gpiod;
@@ -738,16 +741,6 @@ struct clk_hw *clk_hw_register_gpio_gate(struct device *dev, const char *name,
 		unsigned long flags);
 void clk_hw_unregister_gpio_gate(struct clk_hw *hw);
 
-/**
- * struct clk_gpio_mux - gpio controlled clock multiplexer
- *
- * @hw:		see struct clk_gpio
- * @gpiod:	gpio descriptor to select the parent of this clock multiplexer
- *
- * Clock with a gpio control for selecting the parent clock.
- * Implements .get_parent, .set_parent and .determine_rate
- */
-
 extern const struct clk_ops clk_gpio_mux_ops;
 struct clk *clk_register_gpio_mux(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents, struct gpio_desc *gpiod,
-- 
Sent by a computer through tubes

