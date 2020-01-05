Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8C1C32771
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 01:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134C424655
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 01:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Tuu+H7gG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C7W3q8EU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgAEBYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 20:24:25 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37327 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726373AbgAEBYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 20:24:19 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B79521B5A;
        Sat,  4 Jan 2020 20:24:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 04 Jan 2020 20:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=+oIatr2C8rE1v
        lG4UtXIKFhzyVIliPbeiuok48925P8=; b=Tuu+H7gGssKemeSF0FmHrsgcgGpvP
        TTDQJfOMdQVtOZE7ACyIEBJH8tApgyZ9erLHjMIYgXBS+sBeGL0ZFOBjYpjf16ZG
        lwSGpFar2kVypWdZeKzv7KJQ7sN0cuFdCBrubYfukOVaxOZVHYkr0HsHo6auxNFL
        dtyjqY37TKb1jczruJf1ejhyZRbhKUlo1kalcQHKyzoStrQLXVBfC5OsyJypsXiB
        abUYZy3Iv3Xd/ApY1Rs0byur6C+AXaDOUFlUPVASITL4nZWfhdfymg333CzEgcIl
        KOLasEi470v6ZDi6vi4kn955DFhgpcU7IeILJNYtduQlk51h8N5rlSVdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=+oIatr2C8rE1vlG4UtXIKFhzyVIliPbeiuok48925P8=; b=C7W3q8EU
        9wInHZpikBAeNqAv0sz8pqcDbafAPmCN9/fn8PVC8Q728QkBU6O+0LBJ4J68w7VG
        ECdc8lxxRO8P94w2BZ/xVUwjpChyYgsUkXAq5y7t7GXUMZFp2mNTqr38qCPqK489
        /0A04w5QavfSN45G0zau6VnfFGFuCFJjPKWFzShLc+GeNutBUB/hEytyUY2hev/K
        G3uthueZvCvcazqNfHicody796g/UtCGISR/XxDUQNmAqR9rAcmGtp7W3FkNKzyq
        pM9iSHgrimk8noS7dC2rJCpZ+okLY5ZzQaCJMOANeLVKYZzkmGUXufuibn7O5qAc
        u7jOIZYwGfQl2Q==
X-ME-Sender: <xms:wjoRXqFlhQRYcqswsTD-0cB_cgTlLhCJzoUQKQiHQnTpTkc_1_1XQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdegiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:wjoRXho08KdbevzjEJnBe4IZyENou8QSykIY9KKZewelZkWR5zdMvQ>
    <xmx:wjoRXqIAmtWt3K0mtPc-4pfXVFpf3_flGPaYe6KE8YWdjMC1LigjkA>
    <xmx:wjoRXhZyeL8T0Xt61wSUb0XHkXGiQMtidpxPxjr_hCXmIk-pl_G--g>
    <xmx:wjoRXmklM8I3H4sWzGRFRawWtWGiOQBfO8ag4PZoBfJs-Yb7nx8buA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7711A80059;
        Sat,  4 Jan 2020 20:24:17 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 3/9] power: supply: axp20x_ac_power: Allow offlining
Date:   Sat,  4 Jan 2020 19:24:10 -0600
Message-Id: <20200105012416.23296-4-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200105012416.23296-1-samuel@sholland.org>
References: <20200105012416.23296-1-samuel@sholland.org>
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
 drivers/power/supply/axp20x_ac_power.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_ac_power.c b/drivers/power/supply/axp20x_ac_power.c
index ca0a28f72a27..bc2663cd47fa 100644
--- a/drivers/power/supply/axp20x_ac_power.c
+++ b/drivers/power/supply/axp20x_ac_power.c
@@ -24,6 +24,7 @@
 #define AXP20X_PWR_STATUS_ACIN_AVAIL	BIT(6)
 
 #define AXP813_ACIN_PATH_SEL		BIT(7)
+#define AXP813_ACIN_PATH_SEL_TO_BIT(x)	(!!(x) << 7)
 
 #define AXP813_VHOLD_MASK		GENMASK(5, 3)
 #define AXP813_VHOLD_UV_TO_BIT(x)	((((x) / 100000) - 40) << 3)
@@ -157,6 +158,11 @@ static int axp813_ac_power_set_property(struct power_supply *psy,
 	struct axp20x_ac_power *power = power_supply_get_drvdata(psy);
 
 	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		return regmap_update_bits(power->regmap, AXP813_ACIN_PATH_CTRL,
+					  AXP813_ACIN_PATH_SEL,
+					  AXP813_ACIN_PATH_SEL_TO_BIT(val->intval));
+
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
 		if (val->intval < 4000000 || val->intval > 4700000)
 			return -EINVAL;
@@ -183,7 +189,8 @@ static int axp813_ac_power_set_property(struct power_supply *psy,
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

