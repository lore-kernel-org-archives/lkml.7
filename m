Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06F1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3C7214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564601760;
	bh=IFRCG+DOCMsrYUaBHYTa4hu9qu6eBlLPQjBH37+RqZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cTvNeaqqCY2IaiBjlmC2eZJsVpXVAWlIXcF+ngEBFhYiBRKuyA5E4i6bzwX1o0lsF
	 Rj+oQx5h4lBkzUnCko9PNS88sv9M4z/oTUukJu/re3VoGtSS9E9CNQPYiuHOs/JkcO
	 UxDlRZJch9JjyvH552XNBHliNGfa9aI0rCEYdKn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfGaTfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729737AbfGaTfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:35:19 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFFC021726;
        Wed, 31 Jul 2019 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564601718;
        bh=IFRCG+DOCMsrYUaBHYTa4hu9qu6eBlLPQjBH37+RqZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmvPoHss4wBppEumgcwWs2sjose0JDB4PVjhaBEMUTB8m7wsgLQy/+Itf1MLYpa8Y
         jI2Jgvm8Zrz8U+R4XWgD33V9/jznPuedD8VzyXFbtEOf3PtmpXvEticwmcaujY6KIq
         G+8eL8T5xQ9CcqhKlXcoDAnJ1aniHYrCjr3Mg7/U=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/9] clk: actions: Don't reference clk_init_data after registration
Date:   Wed, 31 Jul 2019 12:35:09 -0700
Message-Id: <20190731193517.237136-2-sboyd@kernel.org>
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

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Please ack so I can take this through clk tree

 drivers/clk/actions/owl-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/actions/owl-common.c b/drivers/clk/actions/owl-common.c
index 32dd29e0a37e..71b683c4e643 100644
--- a/drivers/clk/actions/owl-common.c
+++ b/drivers/clk/actions/owl-common.c
@@ -68,6 +68,7 @@ int owl_clk_probe(struct device *dev, struct clk_hw_onecell_data *hw_clks)
 	struct clk_hw *hw;
 
 	for (i = 0; i < hw_clks->num; i++) {
+		const char *name = hw->init->name;
 
 		hw = hw_clks->hws[i];
 
@@ -77,7 +78,7 @@ int owl_clk_probe(struct device *dev, struct clk_hw_onecell_data *hw_clks)
 		ret = devm_clk_hw_register(dev, hw);
 		if (ret) {
 			dev_err(dev, "Couldn't register clock %d - %s\n",
-				i, hw->init->name);
+				i, name);
 			return ret;
 		}
 	}
-- 
Sent by a computer through tubes

