Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB70C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4D2222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="iVOkC8ET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VmZZQ+uP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgABGgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 01:36:36 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57085 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgABGgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 01:36:36 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4AB4B21DC4;
        Thu,  2 Jan 2020 01:36:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 Jan 2020 01:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=I8ZYnQjSH8txck0Jh+S2HWu249
        qfAu3d1NXsu4L1oWY=; b=iVOkC8ETydRFwsyQyzu5YAF+5C971qqazORftbbh/L
        Ihyh3/i/q7kHSqEkJAZ8C794WWlKxTVHyQYt7+fROiTg+y4J0sizWqdfDeYEiY/D
        5Rj6iKdSsdoHJ8Znf6VTawNwMeMxwlXcEKT/iB8q5clv5jwCD7Nez0SqYy4Hfhx6
        AA/OnSsc7sfoviMMTfQxCRhpTzen5ajfA5wz+pT8VUByqhv9lqGH9J4Nux8ngVvr
        AIboTInmPDbewvu+WctO/c5dj2WMFz7aSyculrRYSO2U6PEaOXOC3o/zWw3NVu9S
        xRJ5h636WDbUVy5b7mdIy/A6YcxePk10cw9hLcblMckA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=I8ZYnQjSH8txck0Jh
        +S2HWu249qfAu3d1NXsu4L1oWY=; b=VmZZQ+uPfRF6ZUgVXAjSiFZ1Sg59BjPG3
        nALAgCbAUkak+CX/U7cUGr22YirZxLpe2W3aBAEk0q2U/jNqVfcG7/DOg8nghgqt
        GWZDk8jkF4vvANuI4tfIDqX6sCp9d9yEmkYW/+ECqj6BpwpjNQMG9s8khg+bHhRT
        ar6E8TTJa9UCIylK/2HEyZvHeSQjZt/eBatdySj/ITCiGERvXOcseXERrMnshBa0
        TCKT4+dZ6nfdxk32MlPbjhW0CYEaUXCg4lcqhYL5rOHlyB/kJElBS/Lq3LC1llbD
        f9eJPo4JM02zJPsiXfSSG5aUsB16Y58zc1nj4uU0TI9Me93BOYvUQ==
X-ME-Sender: <xms:co8NXo6_nTigkHCWyesmhnMocQaEc9C4L5_NWPxQsD34rF855OQl9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegtddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkphepje
    dtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgv
    lhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:co8NXpdiSi7b6DgG_ZTIUgtUqTpy0BzNdHgXJPmRSfNZP8ix03pfBQ>
    <xmx:co8NXrw370ET5ySBNZnVRaKaetHE9v0PxBTXllNVUnVqtlhfOxqjew>
    <xmx:co8NXvoiHqlk_0swukDu8rVEMp81UcdOI0LKZdhH-211fsi2V38oDQ>
    <xmx:c48NXrkrYZCmSIJi_j-0qN3bMHET1bLtQtbRK4_78twf1HCFprzRAA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7883F8005C;
        Thu,  2 Jan 2020 01:36:34 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/7] power: supply: axp20x_ac_power: Allow offlining
Date:   Thu,  2 Jan 2020 00:36:27 -0600
Message-Id: <20200102063633.65388-1-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXP803/AXP813 have a flag that enables/disables the AC power supply
input. Allow control of this flag via the ONLINE property on those
variants.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/power/supply/axp20x_ac_power.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index 0d34a932b6d5..4410e7b89383 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -23,6 +23,8 @@
 #define AXP20X_PWR_STATUS_ACIN_PRESENT	BIT(7)
 #define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
 
+#define AXP813_ACIN_PATH_SELECT		BIT(7)
+
 #define AXP813_VHOLD_MASK		GENMASK(5, 3)
 #define AXP813_VHOLD_UV_TO_BIT(x)	((((x) / 100000) - 40) << 3)
 #define AXP813_VHOLD_REG_TO_UV(x)	\
@@ -143,6 +145,11 @@ static int axp813_ac_power_set_property(struct power_supply *psy,
 	struct axp20x_ac_power *power = power_supply_get_drvdata(psy);
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		return regmap_update_bits(power->regmap, AXP813_ACIN_PATH_CTRL,
+					  AXP813_ACIN_PATH_SELECT,
+					  !!val->intval);
+
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		if (val->intval < 4000000 || val->intval > 4700000)
 			return -EINVAL;
@@ -169,7 +176,8 @@ static int axp813_ac_power_set_property(struct power_supply *psy,
 static int axp813_ac_power_prop_writeable(struct power_supply *psy,
 					  enum power_supply_property psp)
 {
-	return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
+	return psp == POWER_SUPPLY_PROP_ONLINE ||
+	       psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
 	       psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT;
 }
 
-- 
2.23.0

