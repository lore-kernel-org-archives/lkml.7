Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3DCCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3C7217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450966;
	bh=KgnIv4iX5ytbpJXt/i/8vSkzCpA+EnsIz5HAgfGpj3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fqt1AZhM/G+WOCKf4FyF9Wis7aF5h4sbdQglz+xBWJ/TTzxCNjHy3mk71h6y/g9pH
	 Dzosj8rIog9u+Qhx26onqD3hNC4/CzMEMtbgC9hrk4k7gX03hZ/F4KlrSTqD0epZ10
	 bNZULPVVOHDYINKtqxZAYdS9Nq2bIFZISfy5gzY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfJ3P4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbfJ3P4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:56:03 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D42B220656;
        Wed, 30 Oct 2019 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450963;
        bh=KgnIv4iX5ytbpJXt/i/8vSkzCpA+EnsIz5HAgfGpj3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IE8Ke5RXs0YUNnZm2E6k0bHjRy7REes5Ate7WUlsvIzWRkm3/IQt5ZFzgsUsAC9D/
         cAGW7HJ1E26mwtsvVlgH7iUSC+3tuL+bFW5CbHTQI7vLfncHi3nftQRNpkVS6YXQgm
         w3hQ63p4zkFoya5g7rTn42cW11BsaAJ81nmy4hRA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yizhuo <yzhai003@ucr.edu>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 03/24] regulator: pfuze100-regulator: Variable "val" in pfuze100_regulator_probe() could be uninitialized
Date:   Wed, 30 Oct 2019 11:55:34 -0400
Message-Id: <20191030155555.10494-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155555.10494-1-sashal@kernel.org>
References: <20191030155555.10494-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yizhuo <yzhai003@ucr.edu>

[ Upstream commit 1252b283141f03c3dffd139292c862cae10e174d ]

In function pfuze100_regulator_probe(), variable "val" could be
initialized if regmap_read() fails. However, "val" is used to
decide the control flow later in the if statement, which is
potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
Link: https://lore.kernel.org/r/20190929170957.14775-1-yzhai003@ucr.edu
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/pfuze100-regulator.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 659e516455bee..4f205366d8aea 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -632,7 +632,13 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 
 		/* SW2~SW4 high bit check and modify the voltage value table */
 		if (i >= sw_check_start && i <= sw_check_end) {
-			regmap_read(pfuze_chip->regmap, desc->vsel_reg, &val);
+			ret = regmap_read(pfuze_chip->regmap,
+						desc->vsel_reg, &val);
+			if (ret) {
+				dev_err(&client->dev, "Fails to read from the register.\n");
+				return ret;
+			}
+
 			if (val & sw_hi) {
 				if (pfuze_chip->chip_id == PFUZE3000) {
 					desc->volt_table = pfuze3000_sw2hi;
-- 
2.20.1

