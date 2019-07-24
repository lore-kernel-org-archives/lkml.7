Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C662C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313E9229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="LQOKtAL1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fmfvulHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfGXIN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:13:26 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:34039 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726276AbfGXINS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:13:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2E09B15EF;
        Wed, 24 Jul 2019 04:13:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 24 Jul 2019 04:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=cmUXGTItnE6GV
        H81XcleXlJaOd7fWAre1oKtPY17jkw=; b=LQOKtAL12oayKyiU9odpP/ruor5Ku
        9tWk/BuisxAvi3hDQJbt4kxr3+lFgj2mXvBmqCYM51U//mjyK0oBpjh8RCKutr+Z
        sJbJwX8cIBSrf10rbAAD3KU+11C0Bs3Xmy8yEAxlaAg250oYSXru1G53F8O5oNmk
        MLCXivPSxHvcrCLEDEztAPB5h+IL75OSAwOSZiExw28VXqWTSh1+3aA1g3Tt+7UQ
        H29G6K27sn27oCvQRryX07uK51X7nXHAAcqA1IrJhE/d2oyNau9XSSjp8vGnF2UW
        IhpXucVPJbHg3c8Vy3K95VgGeagOzNYaOEAFXjrHtiTRL7tWOVq2kN5bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=cmUXGTItnE6GVH81XcleXlJaOd7fWAre1oKtPY17jkw=; b=fmfvulHL
        WotHA6oU1mJHho9UkAy9Sem1KQOVeiLhiLkyhPkmIX1r+tMJFMB01nlLPAAClaSD
        RfMKk0WnGrvnUs0FTMAnx6KH4/VePL61O9jstIc+XyABo2imV6DXiSEqp3TuSVmF
        lrNlNKd/IBDf3NWA2Y2qP0M4iOqdlBxjZ4PQltRQhdASCAoauEIEOEDJZgDRSCkU
        l4HwPVleln5BhFL0EoxYqsZaTlaIWT7Ftl9TkSIiignw3OZsLUAaSDqgX7O5DUoA
        jRwkpYtTfzWQcLB1B5XToJUngbvEfm3VVZeBAuFZEDoNq/Ck3OtQ0EukXDc5Z92z
        JBTeethB7ejBTA==
X-ME-Sender: <xms:HRM4XTXbAB4Lmk_53B4dx2rmWKv_-BtyPL1QI8v-S1Ne3O5L7OGaOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrjeelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecukfhppedvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrg
    hilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigv
    pedu
X-ME-Proxy: <xmx:HhM4XYUdkDQmoMg7fGDln2zdKHfqTxwVQAXQVOJRfe7oeHRlDGgPbA>
    <xmx:HhM4Xe_ZnzCmDpchc-JgPRayDZt9ejhnSZe6tD-sQHgpJrqNo6vpiA>
    <xmx:HhM4XW_flE-Wmajk1lWC6j2CPbneL9msbkY_oVRxtx9ED66OnQrtBQ>
    <xmx:HhM4XVmVC8RYKGjQ87xjIJOr4FHZHQZl1knln3uZP2ZtS1AzI8VuIg>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7A65980059;
        Wed, 24 Jul 2019 04:13:14 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 2/3] pinctrl: aspeed: Document existence of deprecated compatibles
Date:   Wed, 24 Jul 2019 17:43:12 +0930
Message-Id: <20190724081313.12934-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724081313.12934-1-andrew@aj.id.au>
References: <20190724081313.12934-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise they look odd in the face of not being listed in the bindings
documents.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c | 4 ++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
index 384396cbb22d..0e087fe759d2 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
@@ -2531,6 +2531,10 @@ static int aspeed_g4_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id aspeed_g4_pinctrl_of_match[] = {
 	{ .compatible = "aspeed,ast2400-pinctrl", },
+	/*
+	 * The aspeed,g4-pinctrl compatible has been removed the from the
+	 * bindings, but keep the match in case of old devicetrees.
+	 */
 	{ .compatible = "aspeed,g4-pinctrl", },
 	{ },
 };
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index 053101f795a2..49255802735b 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -2676,6 +2676,10 @@ static int aspeed_g5_pinctrl_probe(struct platform_device *pdev)
 
 static const struct of_device_id aspeed_g5_pinctrl_of_match[] = {
 	{ .compatible = "aspeed,ast2500-pinctrl", },
+	/*
+	 * The aspeed,g5-pinctrl compatible has been removed the from the
+	 * bindings, but keep the match in case of old devicetrees.
+	 */
 	{ .compatible = "aspeed,g5-pinctrl", },
 	{ },
 };
-- 
2.20.1

