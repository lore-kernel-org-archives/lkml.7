Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E73EC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E726215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="cWzXmAlX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H1MVasdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgABGgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 01:36:39 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40555 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbgABGgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 01:36:36 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B1E8721D46;
        Thu,  2 Jan 2020 01:36:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Jan 2020 01:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=eR/RTzq+jdWmJ
        Il0pyBHpgF8i6B4qMRvVJ2hxPiiC9Y=; b=cWzXmAlXJ2D9cf9xPTewu+bSi3Gsh
        tWKUUXIpThodkICmhbw4Eo10UqU0hxUqIc1g0TUZtt242e6i7iMvAET2NsKBRDHW
        LJ43ENqTVA3KVE95YgVY8/fpfr1mf+AZyq6PPk2EzaItT1ylVr42RRslxFJxneh/
        Chjc13fkeOUC9pBVbKuVaWhKmg5l6J9phSB/XXkko511Uw2dkejjBD3Fdhq/8n7Z
        uutxHLOU186AmUyQ7zwGyGSCCm8EUWhprwT2MuxKhMDOyjwn/g+waH5A0eoghnJ1
        9yuBlsjiu2NhVkK2RAPP2UgLV2dxHfD/XGJ15N2Cx87MMfd9DuMOjvrwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=eR/RTzq+jdWmJIl0pyBHpgF8i6B4qMRvVJ2hxPiiC9Y=; b=H1MVasdR
        EEOykW1wsmhnkLq4agzim8BZ3YtoJ4yyLE4PqrxxTGQ/KvAzCyXx9ZHFUGUPTtZm
        Xg+oNsMJ1dXgIoOaXvFdpYSltMm/n5Fpnejs+vi6qaPo/yJOr+KaQNsEjvdm9fF9
        UiiUOQsUc5skw6ly+QTUhcjekPqw4ikz9z/+xjuR8P5NB0Hp1XNUiXruCo9shHDu
        /Nc/BD5leaT7PMZkplq+zCHs8mixxWSzDVrkua2/VxIz99Cs1K+VKb/2nZElJLKy
        okDcsfXJCoQYDCHdieRBuBAxzd0kyNC8FNK4Hwcy6NGWaixF241QQL83LZr66/kq
        SndIE0j+Ym4CmA==
X-ME-Sender: <xms:c48NXqaJMFPlNNfX3ks3LeQSlopj1rk13cL8-FBYY36CMl79SSUEZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegtddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:c48NXvzlz8OxYYzhaM5BAHhGnyNIn-Uhpe0ok7JnClnihvRyMo8Qmw>
    <xmx:c48NXuNVCK5QO3lNHg1DxkJhtpdPPIsagvDNPscY5kAN_EisCrF7iw>
    <xmx:c48NXvwuuynJE-8jio2Eh33zdS-cPfEATsgJC3IYsG0XIKbR1xLClQ>
    <xmx:c48NXncWmk3KWI3IIyt9b1JPa53d_XaIMrsc9bNcqxEnnLRzBhRc9g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3DDC98005B;
        Thu,  2 Jan 2020 01:36:35 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 3/7] power: supply: axp20x_usb_power: Remove unused device_node
Date:   Thu,  2 Jan 2020 00:36:29 -0600
Message-Id: <20200102063633.65388-3-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200102063633.65388-1-samuel@sholland.org>
References: <20200102063633.65388-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This member of struct axp20x_usb_power is not used anywhere.
Remove it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_usb_power.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 5f0a5722b19e..dd3f3f12e41d 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -57,7 +57,6 @@
 #define DEBOUNCE_TIME			msecs_to_jiffies(50)
 
 struct axp20x_usb_power {
-	struct device_node *np;
 	struct regmap *regmap;
 	struct power_supply *supply;
 	enum axp20x_variants axp20x_id;
@@ -465,7 +464,6 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	power->axp20x_id = (enum axp20x_variants)of_device_get_match_data(
 								&pdev->dev);
 
-	power->np = pdev->dev.of_node;
 	power->regmap = axp20x->regmap;
 
 	if (power->axp20x_id == AXP202_ID) {
-- 
2.23.0

