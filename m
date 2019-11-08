Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FF8C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D575207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213990;
	bh=EM/ae9hhkuNWZohlWx0eu1ZZYFSYW5nNEk4i47F0nXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AmxRpClt1LCALZma9DmznrDiQGwef444Jl6l+6yKXAFihuckNn2rRHkoEok6PBVMJ
	 Ok6uYYmFCaiBbicUk3CcO9v79jzvXr3b+nOTbdB241kLvE6/XJJrHXEcgpwPTDIJ7W
	 hS9XE9fgbHmnV5HA2HgrK97UC6dGR+bWZIyUiS0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391636AbfKHLxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:53:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391472AbfKHLq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:46:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72A3622459;
        Fri,  8 Nov 2019 11:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213616;
        bh=EM/ae9hhkuNWZohlWx0eu1ZZYFSYW5nNEk4i47F0nXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OaWjhw1Nbsb//hKlM0Yq/+Lo/FoeDzjd5W68bRNj2uwb4SC853yrKmQbxUYP9BCpC
         oQ/b98od1IeUfVsfghpSmBZBiscEtTA6xC4WoTB9yWdU+FWIJ9jXZxyJRRq8snlcc3
         ENxLp4fUl6+CHbyvFwwHLo5ZB0rmCWn0NDeUF2qY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 50/64] pinctrl: at91-pio4: fix has_config check in atmel_pctl_dt_subnode_to_map()
Date:   Fri,  8 Nov 2019 06:45:31 -0500
Message-Id: <20191108114545.15351-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114545.15351-1-sashal@kernel.org>
References: <20191108114545.15351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b97760ae8e3dc8bb91881c13425a0bff55f2bd85 ]

Smatch complains about this condition:

	if (has_config && num_pins >= 1)

The "has_config" variable is either uninitialized or true.  The
"num_pins" variable is unsigned and we verified that it is non-zero on
the lines before so we know "num_pines >= 1" is true.  Really, we could
just check "num_configs" directly and remove the "has_config" variable.

Fixes: 776180848b57 ("pinctrl: introduce driver for Atmel PIO4 controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 88ba9c50cc8ed..b596f45426ea0 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -479,7 +479,6 @@ static int atmel_pctl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	unsigned num_pins, num_configs, reserve;
 	unsigned long *configs;
 	struct property	*pins;
-	bool has_config;
 	u32 pinfunc;
 	int ret, i;
 
@@ -495,9 +494,6 @@ static int atmel_pctl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		return ret;
 	}
 
-	if (num_configs)
-		has_config = true;
-
 	num_pins = pins->length / sizeof(u32);
 	if (!num_pins) {
 		dev_err(pctldev->dev, "no pins found in node %s\n",
@@ -511,7 +507,7 @@ static int atmel_pctl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	 * map for each pin.
 	 */
 	reserve = 1;
-	if (has_config && num_pins >= 1)
+	if (num_configs)
 		reserve++;
 	reserve *= num_pins;
 	ret = pinctrl_utils_reserve_map(pctldev, map, reserved_maps, num_maps,
@@ -534,7 +530,7 @@ static int atmel_pctl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		pinctrl_utils_add_map_mux(pctldev, map, reserved_maps, num_maps,
 					  group, func);
 
-		if (has_config) {
+		if (num_configs) {
 			ret = pinctrl_utils_add_map_configs(pctldev, map,
 					reserved_maps, num_maps, group,
 					configs, num_configs,
-- 
2.20.1

