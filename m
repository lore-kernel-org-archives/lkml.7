Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D0AC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45674205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cOk+SU1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEGXup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 19:50:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38453 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGXuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 19:50:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so9476228pfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 16:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C2o4ETy+vWyO645V7kF5tMNDqsri4a3cWb41vpQuvow=;
        b=cOk+SU1iuvIll4eRwwIrl5D3fmLsvWuhtE1OcoCzB240FCv3dCCE2VDX8UL/cD5vIS
         x1XUhb0ErANI7cOso8PoCamjW1SavXsouvxL+B20d1sExG7iHT8GufU1y+biN/X1HoEg
         becIXZZzA9wVvAnEdU6TZhncZ3bW0qSkIbDs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C2o4ETy+vWyO645V7kF5tMNDqsri4a3cWb41vpQuvow=;
        b=C0cEA8BA5diECKJXFmhI/q6v6k86KP3JGJr6sXdfmPlINvc9xVhCFJAK+EW1K76Tct
         2lFf7atw1+LmpyYAppOxAqCvHZuaVoYa5RN0othxxD3PLyBuMFCOTps+FgwBNEbKZMfV
         907asCWAnoNIqcnDSvAHVbRl5NT2JbWE+mMT+UlCi25fXpQ7wkVkqYh12zhdbYkXXQm1
         6oULaxlYmD/2q3GMIGBUPiils+nYYxhY7/RpwqgPrjRGfi1m1w940Ot32KTV69VVyN27
         uLZAzR9WRn8gqZJJkhJ8WpCvG960sAjHNOiXwh89HSlhEhPzKL33lItt3iXUavO1Sz6u
         U9jA==
X-Gm-Message-State: APjAAAUvEon35pYcoz98AG3PBiHi8dKMDrNIXw3sVwbcGLsX/Lk2f2cI
        4QQ9+gakTckCTqGXagXwQWML+nZLSps=
X-Google-Smtp-Source: APXvYqyPRHj71I0RtZt1k/NbQYF+jTnztfdDZMDt/S2D2rOv+RAfu+tJI8s6apjo+dh+q0OSW58e1A==
X-Received: by 2002:a63:6b49:: with SMTP id g70mr43558513pgc.340.1557273044079;
        Tue, 07 May 2019 16:50:44 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id n18sm30268927pfi.48.2019.05.07.16.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 16:50:43 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     hl@rock-chips.com, linux-rockchip@lists.infradead.org,
        dbasehore@chromium.org, mka@chromium.org, ryandcase@chromium.org,
        groeck@chromium.org, Elaine Zhang <zhangqing@rock-chips.com>,
        wxt@rock-chips.com, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] phy: rockchip-dp: Avoid power leak by leaving the PHY power on
Date:   Tue,  7 May 2019 16:48:56 -0700
Message-Id: <20190507234857.81414-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing a newer kernel on rk3288-based Chromebooks I found that
the power draw in suspend was higher on newer kernels compared to the
downstream Chrome OS 3.14 kernel.  Specifically the power of an
rk3288-veyron-jerry board that I tested (as measured by the smart
battery) was ~16 mA on Chrome OS 3.14 and ~21 mA on a newer kernel.

I tracked the regression down to the fact that the "DP PHY" driver
didn't exist in our downstream 3.14.  We relied on the eDP driver to
turn on the clock and relied on the fact that the power for the PHY
was default turned on.

Specifically the thing that caused the power regression was turning
the eDP PHY _off_.  Presumably there is some sort of power leak in the
system and when we turn the PHY off something is leaching power from
something else and causing excessive power draw.

Doing a search through device trees shows that this PHY is only ever
used on rk3288.  Presumably this power leak is present on all
rk3288-SoCs running upstream Linux so let's just whack the driver to
make sure we never turn off power.  We'll still leave the parts that
turn _on_ the power and grab the clock, though.

NOTES:
A) If someone can identify what this power leak is and fix it in some
   other way we can revert this patch.
B) If someone can show that their particular board doesn't have this
   power leak (maybe they have rails hooked up differently?) we can
   perhaps add a device tree property indicating that for some boards
   it's OK to turn this rail off.  I don't want to add this property
   until I know of a board that needs it.

Fixes: fd968973de95 ("phy: Add driver for rockchip Display Port PHY")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
As far as I know Yakir (the original author) is no longer at Rockchip.
I've added a few other Rockchip people and hopefully one of them can
help direct even if they're not directly responsible.

 drivers/phy/rockchip/phy-rockchip-dp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-dp.c b/drivers/phy/rockchip/phy-rockchip-dp.c
index 8b267a746576..10bbcd69d6f5 100644
--- a/drivers/phy/rockchip/phy-rockchip-dp.c
+++ b/drivers/phy/rockchip/phy-rockchip-dp.c
@@ -35,7 +35,7 @@ struct rockchip_dp_phy {
 static int rockchip_set_phy_state(struct phy *phy, bool enable)
 {
 	struct rockchip_dp_phy *dp = phy_get_drvdata(phy);
-	int ret;
+	int ret = 0;
 
 	if (enable) {
 		ret = regmap_write(dp->grf, GRF_SOC_CON12,
@@ -50,9 +50,12 @@ static int rockchip_set_phy_state(struct phy *phy, bool enable)
 	} else {
 		clk_disable_unprepare(dp->phy_24m);
 
-		ret = regmap_write(dp->grf, GRF_SOC_CON12,
-				   GRF_EDP_PHY_SIDDQ_HIWORD_MASK |
-				   GRF_EDP_PHY_SIDDQ_OFF);
+		/*
+		 * Intentionally don't turn SIDDQ off when disabling
+		 * the PHY.  There is a power leak on rk3288 and
+		 * suspend power _increases_ by 5 mA if you turn this
+		 * off.
+		 */
 	}
 
 	return ret;
-- 
2.21.0.1020.gf2820cf01a-goog

