Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D9CC3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97702190F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="HARQ7LNh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K/R8LjBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfIBD6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 23:58:47 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:44357 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729262AbfIBD6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:58:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 380EF428;
        Sun,  1 Sep 2019 23:58:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 01 Sep 2019 23:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=L4EL0S354nCKb
        obvrleuPdmXpWAwO2XcwtXNi/sy4WI=; b=HARQ7LNhsamaQlUi8XrA9c9XgM4ej
        okbinmIfdkOyLMUHlFVu/WfWYSw/P/uFClhEk5UhKy/7Kh1XOn7o2p5B1ebEEC1m
        wJEf/MehcgXONCbfbtBZ1nNj5IbYQ5nIRaiAusgnk8jZPR1/60lHbifnOBhmTYa2
        6T5ZTtzpfM3n4J5iU6nMK9EUtaFrXZLXHTjT9+HQioBA43n1DuH4Opn47cNwgSWC
        xRjJ3w3EA18yEURb4nR2onFCWE37RNvHnkNVGEArpcZw0EELLlnFRdHFew3+auG2
        bi/kwJx+YCp9LLCgfZvo7DuNo0C1/KHguKJajkz7Rh56gJ+F/89mfMqzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=L4EL0S354nCKbobvrleuPdmXpWAwO2XcwtXNi/sy4WI=; b=K/R8LjBG
        ca3yJTTI1ErfnRSgU3X2raDIqDvDc3ZgFGyInGbt36buGSeTaWLQ22NVYJ2T+0Zt
        vUs8RC03tmdAs/BgBE6yjM8xicWuRngV7nIZInFobiYsiOT8QQDeEYyxpAZw8idh
        BjsSig2OcXirUzOkAp61cmsf257yoL0aKNxsJbeWFKPRqF/YvJFMM0zuLjzsMWEg
        fVS9HtWDMO4Y10SUWRUWCOoqY7bbjkpCVBIdQHEQR7xfRjkoOd7lm/4MevUD92fR
        6NJt+aIsqf25m1FPXScCN7s8BxUIwjNbDHbBP5fcCK7jZcIVm5xlBHvA91s9/n6E
        Gr7ClhgjeKymag==
X-ME-Sender: <xms:dJNsXS4FYebJUzXj6tQWUvzgWm-jkesn8Ws8e7AChMW2KBfR_wc6Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeiledgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecukfhppedvtdefrdehjedrvdduhedrudejkeenucfrrghrrghmpe
    hmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhi
    iigvpeef
X-ME-Proxy: <xmx:dJNsXeMsWIkZvls6181yCWKzUB2kZBpQ-lMIr2XHPYXkLJt8QKPfwQ>
    <xmx:dJNsXQJs9gqGYmgbdw1I1_rwBwqpW6ZZkPB0QFX-JA9Rn26rC6pX3w>
    <xmx:dJNsXcHe-ta20xQ8kutYalNx7E4OHCXasO3UrAD5cnrE-QjLrXVvlw>
    <xmx:dJNsXYfkF93ocDMrpJ6G9XWLFCNDZm33KA0MKpD-u68-U8yPj3rhRA>
Received: from localhost.localdomain (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id D8D6AD60062;
        Sun,  1 Sep 2019 23:58:41 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, joel@jms.id.au, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] mmc: sdhci-of-aspeed: Allow max-frequency limitation of SDCLK
Date:   Mon,  2 Sep 2019 13:28:42 +0930
Message-Id: <20190902035842.2747-5-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902035842.2747-1-andrew@aj.id.au>
References: <20190902035842.2747-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a get_max_clock() handler to sdhci-of-aspeed to report f_max as the
maximum clock rate if it is set. This enables artificial limitation of
the bus speed via max-frequency in the devicetree for e.g. the AST2600
evaluation board where I was seeing errors at 200MHz.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index c31d74427c49..a8a5341b526c 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -52,16 +52,24 @@ static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
 
 static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
+	struct sdhci_pltfm_host *pltfm_host;
+	unsigned long parent;
 	int div;
 	u16 clk;
 
+	pltfm_host = sdhci_priv(host);
+	parent = clk_get_rate(pltfm_host->clk);
+
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
 	if (clock == 0)
 		return;
 
+	if (WARN_ON(clock > host->max_clk))
+		clock = host->max_clk;
+
 	for (div = 1; div < 256; div *= 2) {
-		if ((host->max_clk / div) <= clock)
+		if ((parent / div) <= clock)
 			break;
 	}
 	div >>= 1;
@@ -71,6 +79,14 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_enable_clk(host, clk);
 }
 
+static unsigned int aspeed_sdhci_get_max_clock(struct sdhci_host *host)
+{
+	if (host->mmc->f_max)
+		return host->mmc->f_max;
+
+	return sdhci_pltfm_clk_get_max_clock(host);
+}
+
 static void aspeed_sdhci_set_bus_width(struct sdhci_host *host, int width)
 {
 	struct sdhci_pltfm_host *pltfm_priv;
@@ -97,7 +113,7 @@ static void aspeed_sdhci_set_bus_width(struct sdhci_host *host, int width)
 
 static const struct sdhci_ops aspeed_sdhci_ops = {
 	.set_clock = aspeed_sdhci_set_clock,
-	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_max_clock = aspeed_sdhci_get_max_clock,
 	.set_bus_width = aspeed_sdhci_set_bus_width,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.reset = sdhci_reset,
-- 
2.20.1

