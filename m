Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7D1C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68483208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564601725;
	bh=sGoyST7R+Il/j+9IS7NusAhKzl7VfBqnA85LDyLP0Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bt1rHKfV0hCAmPUKgM2P0eiaeoVRx2am4xDH5morh9W1KpWBK9JLsQRthml/ij+SA
	 pdDqZhOgE5JetIkwUShqE77cxSgGFzKhQa/WjqZ5b+Ai0E6nddzZPUnW0I6kl/KR/B
	 Elfve4AhTW+BP7VqNNIK1A4r/eOMlr7bQnyGhwsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfGaTfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:35:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730967AbfGaTfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:35:20 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD6E721726;
        Wed, 31 Jul 2019 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564601719;
        bh=sGoyST7R+Il/j+9IS7NusAhKzl7VfBqnA85LDyLP0Cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L5Oy9tJ61dIJrI2NLL/Djd8UFQu05jGxcAOiBaiOZlO18axOVtmrmHVRiL/0E6FAe
         SaU6YUSDIO1murZOK00GZnTlHA5ZBX5kEwf56Ripo4XuDGXBnssrAra/QNd1HiCwIu
         2/y0750noBR47tXYn+5HJeONaC4ukpV8pOMaxmJU=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH 4/9] clk: qcom: Don't reference clk_init_data after registration
Date:   Wed, 31 Jul 2019 12:35:12 -0700
Message-Id: <20190731193517.237136-5-sboyd@kernel.org>
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

Cc: Taniya Das <tdas@codeaurora.org>
Cc: Andy Gross <agross@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Please ack so I can take this through clk tree

 drivers/clk/qcom/clk-rpmh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index c3fd632af119..7a8a84dcb70d 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -396,6 +396,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 	hw_clks = desc->clks;
 
 	for (i = 0; i < desc->num_clks; i++) {
+		const char *name = hw_clks[i]->init->name;
 		u32 res_addr;
 		size_t aux_data_len;
 		const struct bcm_db *data;
@@ -426,8 +427,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 
 		ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to register %s\n",
-				hw_clks[i]->init->name);
+			dev_err(&pdev->dev, "failed to register %s\n", name);
 			return ret;
 		}
 	}
-- 
Sent by a computer through tubes

