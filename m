Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E283AC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56BE208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564601753;
	bh=mC0F05zb24kfpMyZ3+v4v/7g4/dLBRUB01BNOPklzuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RAcDx8s1tQpFpRZn29h7/j4N4cIgcXWSgGuchbO3CuIGBKgGwTeHdQNErs78TCxoG
	 2WX0iUd54w4rAnxALYVF/ziU5hqalqXSwwNmX/FrmH2IkR643fmdyR6Deyt4ZH8I1D
	 JMPGEwvP7oiMjq0iugKv3Xpw9NSJTVFd5yu/ktNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbfGaTfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730952AbfGaTfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:35:20 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BEE121773;
        Wed, 31 Jul 2019 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564601719;
        bh=mC0F05zb24kfpMyZ3+v4v/7g4/dLBRUB01BNOPklzuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x2viIRgA1PDDnCE5Ejdb6nELwb/3KksOL7b6RmBrbiBv7OFS6aq7XUFgDhTShS+aB
         nVEgUzP3TSDFlJldlidGu3BWnUmk4kZnGJcs24lgbrQ9UoxowShuQiZBeRNPgWg5Ns
         VSUeMnjKpRou2z/hzSAodHMJJvbEn1FyHa6+3wkI=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 3/9] clk: meson: axg-audio: Don't reference clk_init_data after registration
Date:   Wed, 31 Jul 2019 12:35:11 -0700
Message-Id: <20190731193517.237136-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190731193517.237136-1-sboyd@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A future patch is going to change semantics of clk_register() so that
clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
referencing this member here so that we don't run into NULL pointer
exceptions.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Please ack so I can take this through clk tree

 drivers/clk/meson/axg-audio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 8028ff6f6610..db0b73d53551 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -992,15 +992,18 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 
 	/* Take care to skip the registered input clocks */
 	for (i = AUD_CLKID_DDR_ARB; i < data->hw_onecell_data->num; i++) {
+		const char *name;
+
 		hw = data->hw_onecell_data->hws[i];
 		/* array might be sparse */
 		if (!hw)
 			continue;
 
+		name = hw->init->name;
+
 		ret = devm_clk_hw_register(dev, hw);
 		if (ret) {
-			dev_err(dev, "failed to register clock %s\n",
-				hw->init->name);
+			dev_err(dev, "failed to register clock %s\n", name);
 			return ret;
 		}
 	}
-- 
Sent by a computer through tubes

