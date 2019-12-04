Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCF8C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0422084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482846;
	bh=iWz+xQsYxy64C4DLxGQ1cBWmn/n02k3AjJMBZLWgd68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OjkaKvGZndlmjwSCPjKB2F7Yh/bKdVq7O6mZ9r+PFDEeMaoEuZ0J+DBbxVmPDQqSR
	 Ox4dv4uwNln5Y2vU2scbo0eA+U0FCaP8QBsXQfbxhGf9saNlabwX5usN7fAH1XV3zC
	 BLgGRKTBZ6EyKXOnxCnjkU6ZNaaU4YmuOMg2ZM0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfLDSHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730755AbfLDSHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:07:22 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C65520675;
        Wed,  4 Dec 2019 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482842;
        bh=iWz+xQsYxy64C4DLxGQ1cBWmn/n02k3AjJMBZLWgd68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvoLY7iBaH2gN/v+G24/XGP9ZuIkHf02qZ0E0QD74P3XYgykH8yMEWuINYRdr6Tuv
         QznOLkWJKFQHMXyvMMjlxyhIBeYMy7dowThoR0oiYNWM7tN8kHGMOXHJ1sgu/mgStT
         XXTJdUQIqUFCgNIn1jpSgVWyfCb1Qd6JOTdkKvI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.14 157/209] clk: at91: generated: set audio_pll_allowed in at91_clk_register_generated()
Date:   Wed,  4 Dec 2019 18:56:09 +0100
Message-Id: <20191204175334.289705755@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

commit c1e4580a1d0ff510d56268c1fc7fcfeec366fe70 upstream.

Set gck->audio_pll_allowed in at91_clk_register_generated. This makes it
easier to do it from code that is not parsing device tree.

Also, this fixes an issue where the resulting clk_hw can be dereferenced
before being tested for error.

Fixes: 1a1a36d72e3d ("clk: at91: clk-generated: make gclk determine audio_pll rate")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/at91/clk-generated.c |   28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -284,7 +284,7 @@ static void clk_generated_startup(struct
 static struct clk_hw * __init
 at91_clk_register_generated(struct regmap *regmap, spinlock_t *lock,
 			    const char *name, const char **parent_names,
-			    u8 num_parents, u8 id,
+			    u8 num_parents, u8 id, bool pll_audio,
 			    const struct clk_range *range)
 {
 	struct clk_generated *gck;
@@ -308,6 +308,7 @@ at91_clk_register_generated(struct regma
 	gck->regmap = regmap;
 	gck->lock = lock;
 	gck->range = *range;
+	gck->audio_pll_allowed = pll_audio;
 
 	clk_generated_startup(gck);
 	hw = &gck->hw;
@@ -333,7 +334,6 @@ static void __init of_sama5d2_clk_genera
 	struct device_node *gcknp;
 	struct clk_range range = CLK_RANGE(0, 0);
 	struct regmap *regmap;
-	struct clk_generated *gck;
 
 	num_parents = of_clk_get_parent_count(np);
 	if (num_parents == 0 || num_parents > GENERATED_SOURCE_MAX)
@@ -350,6 +350,8 @@ static void __init of_sama5d2_clk_genera
 		return;
 
 	for_each_child_of_node(np, gcknp) {
+		bool pll_audio = false;
+
 		if (of_property_read_u32(gcknp, "reg", &id))
 			continue;
 
@@ -362,24 +364,14 @@ static void __init of_sama5d2_clk_genera
 		of_at91_get_clk_range(gcknp, "atmel,clk-output-range",
 				      &range);
 
+		if (of_device_is_compatible(np, "atmel,sama5d2-clk-generated") &&
+		    (id == GCK_ID_I2S0 || id == GCK_ID_I2S1 ||
+		     id == GCK_ID_CLASSD))
+			pll_audio = true;
+
 		hw = at91_clk_register_generated(regmap, &pmc_pcr_lock, name,
 						  parent_names, num_parents,
-						  id, &range);
-
-		gck = to_clk_generated(hw);
-
-		if (of_device_is_compatible(np,
-					    "atmel,sama5d2-clk-generated")) {
-			if (gck->id == GCK_ID_SSC0 || gck->id == GCK_ID_SSC1 ||
-			    gck->id == GCK_ID_I2S0 || gck->id == GCK_ID_I2S1 ||
-			    gck->id == GCK_ID_CLASSD)
-				gck->audio_pll_allowed = true;
-			else
-				gck->audio_pll_allowed = false;
-		} else {
-			gck->audio_pll_allowed = false;
-		}
-
+						  id, pll_audio, &range);
 		if (IS_ERR(hw))
 			continue;
 


