Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6B2C47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302B220867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 01:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="rgBL2WXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfJHBGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 21:06:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43877 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfJHBGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 21:06:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id f21so7682104plj.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 18:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xG4okJdw6yG0+dTVZUzXSvCaMqd7lfeqdk85b8htCP8=;
        b=rgBL2WXVr2trvPZShyRwXOB2KqvBn/el+0g8d6FvndBKzcvnVgOsBrX2oam1Z6mlb8
         ot+797QfI9z+GTYlc3Z8YFl1yeqGtRh/e4//aRtTEnH6jbRCOqZIGbyKXc57ArENrkfu
         dUJI2Msjol/rrNfDjwOcpFJ/wvd6H24GYfVhc5zixtLpQoQUz7AuubazLSR219DU5dFv
         kM8gL6Mz3CihTn6ZNefw1lg5RI4Q4R66VwibxmLSo5TeoeasRXNKthrHSy55CxWafV8q
         HvLxHZvACK7/NWLgxlbSZ9ws3NtmAVs4GozQIgL6nl6GsxNNc1jNrDpbk2JfPiXQsGRm
         c9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xG4okJdw6yG0+dTVZUzXSvCaMqd7lfeqdk85b8htCP8=;
        b=IPiGP8vMS8svGNAtOPCuPyakJt/ZqjO5o+MMuDW7khLUq92ptOS98zcfnq33EOSrek
         gOQye+EZVOctU3M5CfJLFYG3FGlMbzvhoJR4UqX9JMWw8LwPWEQGUjJ3gBhDHZ3yLVzi
         mywna+cAF3sSB2IEPnhnzcZTrJqwvT96L9dDf8Hiq94TlY5fSyz3BVWgwntM4cywc/2G
         k0uwMq/pto47mFAnO5JU9gmjAWxUGJYKQKnVZibHClxLmwQEBZJarkBaixYqMPVAenXF
         vyFPEse1F2N1xxcN+fmaoJYJkoZzkieJfqYJU4bdee0u334hUn5IrRaIdLvKYoMON+pC
         axwA==
X-Gm-Message-State: APjAAAWGqqzUYZiKlVNh0TqIPCRDOFrWhQEjgI85x7rFOBtXX+x/5nrl
        /cwihxmWm0/4QIZRXX6T2c8AIA==
X-Google-Smtp-Source: APXvYqyN5NDtYjHKIrfRAKGop7mU3OUpTZ85SPTXRyyKdVkQIZrC44zQeHxhwIe3+R4PbS8to4rBDQ==
X-Received: by 2002:a17:902:7782:: with SMTP id o2mr3280279pll.165.1570496801537;
        Mon, 07 Oct 2019 18:06:41 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id 18sm15563898pfp.100.2019.10.07.18.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 18:06:41 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Tony Xie <tony.xie@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 3/3] regulator: rk808: Remove rk817_set_suspend_voltage function
Date:   Tue,  8 Oct 2019 09:06:28 +0800
Message-Id: <20191008010628.8513-3-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008010628.8513-1-axel.lin@ingics.com>
References: <20191008010628.8513-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The implement is exactly the same as rk808_set_suspend_voltage, so just
use rk808_set_suspend_voltage instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rk808-regulator.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index d0d1b868b0cd..5b4003226484 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -411,21 +411,6 @@ static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
 				  sel);
 }
 
-static int rk817_set_suspend_voltage(struct regulator_dev *rdev, int uv)
-{
-	unsigned int reg;
-	int sel = regulator_map_voltage_linear(rdev, uv, uv);
-	/* only ldo1~ldo9 */
-	if (sel < 0)
-		return -EINVAL;
-
-	reg = rdev->desc->vsel_reg + RK808_SLP_REG_OFFSET;
-
-	return regmap_update_bits(rdev->regmap, reg,
-				  rdev->desc->vsel_mask,
-				  sel);
-}
-
 static int rk808_set_suspend_voltage_range(struct regulator_dev *rdev, int uv)
 {
 	unsigned int reg;
@@ -708,7 +693,7 @@ static const struct regulator_ops rk817_reg_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= rk8xx_is_enabled_wmsk_regmap,
-	.set_suspend_voltage	= rk817_set_suspend_voltage,
+	.set_suspend_voltage	= rk808_set_suspend_voltage,
 	.set_suspend_enable	= rk817_set_suspend_enable,
 	.set_suspend_disable	= rk817_set_suspend_disable,
 };
-- 
2.20.1

