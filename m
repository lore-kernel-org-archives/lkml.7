Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAABC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D84620811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552578953;
	bh=c6QhG/BiRfCVbpnx6YDq2s671rbz/C2QWbBMsWvTj4U=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=KsViIbnebWo9/f8YEhwIyyJTbxlGWQiUolDRUH5PueKKCaCxmp19xDHw9w4TSoUf4
	 Vg0wQLiUvvIwHsb8+oCB6OVRZmGO5ovq/UM6CU2bevymaT5ZeWpsCuI1gM977gs91b
	 qLP3zQYDteEDjRVVCimhBUaOBKC64A/yPu4PSnGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbfCNPzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:55:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35842 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfCNPyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=qr3eoAlqU7RWrC7DmzRiPHZ9fAtx5MB2D9DVR/McsBE=; b=p0i9eI83TCSY
        Y3ACnwfJrSTdlW2wYd0g/7uXJjknWsZhfPygRc5/84mCL2IFrs4K0RI4m7YU9+IsnAxliZMAwOQKJ
        szF2lRhCNH2pqCzL1XRg5rFytnLMx+bbEdnRVf4q265xV/8IqcmXhRdoepFsg9auZ2eJ3PaFzblzw
        x5EBY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4SgJ-0002hl-FX; Thu, 14 Mar 2019 15:54:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F21B21126E65; Thu, 14 Mar 2019 15:54:01 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm831x-isink: Select maximum current in specific range" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190314155401.F21B21126E65@debutante.sirena.org.uk>
Date:   Thu, 14 Mar 2019 15:54:01 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm831x-isink: Select maximum current in specific range

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 45aa908d9b720f9fe44100fe099d6fd5ab9f12ab Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 13 Mar 2019 00:33:54 +0800
Subject: [PATCH] regulator: wm831x-isink: Select maximum current in specific
 range

.set_current_limit callback should select the current closest to max_uA.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/wm831x-isink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index 11f351191dba..5611890a724b 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -99,7 +99,7 @@ static int wm831x_isink_set_current(struct regulator_dev *rdev,
 	struct wm831x *wm831x = isink->wm831x;
 	int ret, i;
 
-	for (i = 0; i < ARRAY_SIZE(wm831x_isinkv_values); i++) {
+	for (i = ARRAY_SIZE(wm831x_isinkv_values) - 1; i >= 0; i--) {
 		int val = wm831x_isinkv_values[i];
 		if (min_uA <= val && val <= max_uA) {
 			ret = wm831x_set_bits(wm831x, isink->reg,
-- 
2.20.1

