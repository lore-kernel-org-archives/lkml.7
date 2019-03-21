Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2358C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F70F21873
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553158146;
	bh=9lo5abKzrujA1fpYwQ1eEUvJPcIJ2p4DKf5MnAZl4ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BzZhfVq1H7f8oTS6R6L5QAKq2hcxx5LYoE0hRiM/KfnRq40kzEq/WOpuP4GX9rCcp
	 zGCcvXdWjitoUVJpkdziL+KkGDQlmG8WQKGjQ6hePKXEnSaCspwqnwdUeEclgfmmPK
	 hba63Okn0BhXJH0Ip0dwg1aKdvqXfxJTGi2eSjVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfCUItF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:49:05 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:41416 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbfCUItD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:49:03 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 356885FDBD; Thu, 21 Mar 2019 16:48:59 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 3/9] power: supply: axp20x_usb_power: allow disabling input current limiting
Date:   Thu, 21 Mar 2019 16:48:44 +0800
Message-Id: <20190321084850.20769-4-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321084850.20769-1-wens@kernel.org>
References: <20190321084850.20769-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The AXP PMICs allow the user to disable current limiting on the VBUS
input. While read-out of this setting was already supported by the
driver, it did not allow the user to configure the PMIC to disable
current limiting.

Add support for this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_usb_power.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index cd9b90d79839..e2f353906bb1 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -230,6 +230,11 @@ static int axp20x_usb_power_set_current_max(struct axp20x_usb_power *power,
 		return regmap_update_bits(power->regmap,
 					  AXP20X_VBUS_IPSOUT_MGMT,
 					  AXP20X_VBUS_CLIMIT_MASK, val);
+	case -1:
+		return regmap_update_bits(power->regmap,
+					  AXP20X_VBUS_IPSOUT_MGMT,
+					  AXP20X_VBUS_CLIMIT_MASK,
+					  AXP20X_VBUS_CLIMIT_NONE);
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1

