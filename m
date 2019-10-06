Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F42C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD8D20862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383715;
	bh=/P72MjB8XhN4/ZZi1bmLbv5QAnQz2BwhA6RjE5T6u/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vV/6cfyeOB0NiRE8K9M705s+LkPr/zyIKlZuSktAgIeUx4qrv3p9JaOUpuEsVb80c
	 LFrkNN7QV6lHDQ5PnqSM/3sVMWoVU+v5L/2WmhgQe89vyisJaSTwhFVXQkmok9d+Kp
	 N3YEdoCvzMkFFJNxV5XXFdfrsPYfel6r25qAeeIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfJFRlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730904AbfJFRjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:39:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC6F020700;
        Sun,  6 Oct 2019 17:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383592;
        bh=/P72MjB8XhN4/ZZi1bmLbv5QAnQz2BwhA6RjE5T6u/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UByN6hUw8+16soSfpBR1tScePHSYCMBpLPc+2ccI9VHDr7gF6N0OY9Gnoukqes24h
         dM0D5oiCrf8lpMtkuCiyEuuys2YpNHzRvG1sE4GnmhCd38JpKWG+TwWwUUYoe7IaKF
         0Pe8rSUoRSc3BxfJ1rL8l654C9x++9QE+tT0OZOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 023/166] pinctrl: stmfx: update pinconf settings
Date:   Sun,  6 Oct 2019 19:19:49 +0200
Message-Id: <20191006171215.115873449@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Torgue <alexandre.torgue@st.com>

[ Upstream commit a502b343ebd0eab38f3cb33fbb84011847cf5aac ]

According to the following tab (coming from STMFX datasheet), updates
have to done in stmfx_pinconf_set function:

-"type" has to be set when "bias" is configured as "pull-up or pull-down"
-PIN_CONFIG_DRIVE_PUSH_PULL should only be used when gpio is configured as
 output. There is so no need to check direction.

DIR | TYPE | PUPD | MFX GPIO configuration
----|------|------|---------------------------------------------------
1   | 1    | 1    | OUTPUT open drain with internal pull-up resistor
----|------|------|---------------------------------------------------
1   | 1    | 0    | OUTPUT open drain with internal pull-down resistor
----|------|------|---------------------------------------------------
1   | 0    | 0/1  | OUTPUT push pull no pull
----|------|------|---------------------------------------------------
0   | 1    | 1    | INPUT with internal pull-up resistor
----|------|------|---------------------------------------------------
0   | 1    | 0    | INPUT with internal pull-down resistor
----|------|------|---------------------------------------------------
0   | 0    | 1    | INPUT floating
----|------|------|---------------------------------------------------
0   | 0    | 0    | analog (GPIO not used, default setting)

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Link: https://lore.kernel.org/r/1564053416-32192-1-git-send-email-amelie.delaunay@st.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-stmfx.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index d3332da356372..31b6e511670fc 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -296,29 +296,29 @@ static int stmfx_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 		switch (param) {
 		case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
 		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_DRIVE_PUSH_PULL:
+			ret = stmfx_pinconf_set_type(pctl, pin, 0);
+			if (ret)
+				return ret;
+			break;
 		case PIN_CONFIG_BIAS_PULL_DOWN:
+			ret = stmfx_pinconf_set_type(pctl, pin, 1);
+			if (ret)
+				return ret;
 			ret = stmfx_pinconf_set_pupd(pctl, pin, 0);
 			if (ret)
 				return ret;
 			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
-			ret = stmfx_pinconf_set_pupd(pctl, pin, 1);
+			ret = stmfx_pinconf_set_type(pctl, pin, 1);
 			if (ret)
 				return ret;
-			break;
-		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-			if (!dir)
-				ret = stmfx_pinconf_set_type(pctl, pin, 1);
-			else
-				ret = stmfx_pinconf_set_type(pctl, pin, 0);
+			ret = stmfx_pinconf_set_pupd(pctl, pin, 1);
 			if (ret)
 				return ret;
 			break;
-		case PIN_CONFIG_DRIVE_PUSH_PULL:
-			if (!dir)
-				ret = stmfx_pinconf_set_type(pctl, pin, 0);
-			else
-				ret = stmfx_pinconf_set_type(pctl, pin, 1);
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+			ret = stmfx_pinconf_set_type(pctl, pin, 1);
 			if (ret)
 				return ret;
 			break;
-- 
2.20.1



