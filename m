Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99474C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607E120651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i1jTiAj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfC0PNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:13:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45722 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfC0PNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:13:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so19007091wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3oew5ViwTuk1kp7BHOXkdHpa+6yyRMKho3UTYQdnYI=;
        b=i1jTiAj3AoEO6myDfncnDV1jLZnvl64EVCtJl1etsyCMiWhgofoHdX4YJwiqNH0SoL
         mloR1rI47Q9Q0awzpgdPQuQLyJPM2gOgpAQkdIkj7wUbZP79Ax6pqPVrvZZulSM0vT0U
         Np7PmmvFdc8OKkqaWjthX+OaUOdtX+/ksKoKxUia3MnB/eO7LcN4k3FeihUvZBObfOm6
         0DIMUfOVHfcjSyL/aK05Nf2VijcoPNudsAS+6QyBqSpgUwd0H+GsC9pESCxENGiOth8r
         YGU1LhqMKZLPYuX666T66wucJ+YZ4TZ5bu8T8PlYXpn2S993SwMHwrTv1BR0pSvgW3/G
         d62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3oew5ViwTuk1kp7BHOXkdHpa+6yyRMKho3UTYQdnYI=;
        b=IwpVVQZK5YwpIPojyhmpMETO0dO/PXnX/oUh+Pxv5DMJRGKuyoxFI3jVlKsb0bfmhn
         qwiTMHWQLwKnQgsc5zCdGkn5MlNSBuFMYraAcMhDR1CcRkzwTwkPlM6DhRRt3D/A4vPL
         12h3eoZ6SAiyzWoEeQEiTVnowtMeWofvdF5xIJvwlxK2U6HdlKDlp3d5Ei2rFIbdkCyv
         XtB16iD/TUs3vqEjdQLT9NwZXxhDbVe5tl1HgQ7L2YJCJHrWwyPPlJo+qHMHKL46eDDx
         9RWDyYZ4JaXuiabg7oixc9GGaB3tO8Wxa84SSlvhNNnHdUPPiRWshdrW+FwRepERCv/O
         2j0w==
X-Gm-Message-State: APjAAAWzWqOCtgFnKqRrqJjhfZz46vX+XiMaJVqMs4UEIEAVQsESUilk
        rlsg9JQvdV07/+E7XMgNOcilXPEocEEPsQ==
X-Google-Smtp-Source: APXvYqwaRk8d6lxeTnXqorNA366NMkTZpHeSdyCOnqkam9kOh62Jl92t32Sxurm+tceugrwK3TWVRw==
X-Received: by 2002:a5d:6209:: with SMTP id y9mr25533754wru.140.1553699630784;
        Wed, 27 Mar 2019 08:13:50 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x84sm406285wmg.13.2019.03.27.08.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Mar 2019 08:13:50 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: meson: vid-pll-div: remove warning and return 0 on invalid config
Date:   Wed, 27 Mar 2019 16:13:48 +0100
Message-Id: <20190327151348.27402-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vid_pll_div is a programmable fractional divider, but vendor gives a
limited of known configuration value and it's corresponding fraction.

Thus when at reset value (0) or unknown value, we cannot determine the
result rate.

The initial behaviour was to print a warning, but the warning triggers
at each boot and when the clock tree is refreshed.

This patch moves the print to debug and returns 0 instead of the
parent rate.

Fixes: 72dbb8c94d0d ("clk: meson: Add vid_pll divider driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/vid-pll-div.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/vid-pll-div.c b/drivers/clk/meson/vid-pll-div.c
index 08bcc01c0923..daff235bc763 100644
--- a/drivers/clk/meson/vid-pll-div.c
+++ b/drivers/clk/meson/vid-pll-div.c
@@ -82,8 +82,8 @@ static unsigned long meson_vid_pll_div_recalc_rate(struct clk_hw *hw,
 	div = _get_table_val(meson_parm_read(clk->map, &pll_div->val),
 			     meson_parm_read(clk->map, &pll_div->sel));
 	if (!div || !div->divider) {
-		pr_info("%s: Invalid config value for vid_pll_div\n", __func__);
-		return parent_rate;
+		pr_debug("%s: Invalid config value for vid_pll_div\n", __func__);
+		return 0;
 	}
 
 	return DIV_ROUND_UP_ULL(parent_rate * div->multiplier, div->divider);
-- 
2.21.0

