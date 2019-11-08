Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF632FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E1D20656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240859;
	bh=KgnIv4iX5ytbpJXt/i/8vSkzCpA+EnsIz5HAgfGpj3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cDyMyp7ek6GPfL02m3TW3FsdnpGTG2LIL+hV+Cq0tRYAI8hrF6v3UeTueXi1djAJm
	 vit3EhN+t255ua29pI3y1f3wks2B679oM9t45m9AuMYkpHqoqcPjewZu404Z6Cu74r
	 qGleQZf2AzAzyRz0+Zwrr7LItRwnASRrcu7z794M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391440AbfKHTU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:20:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731304AbfKHTAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B902222C9;
        Fri,  8 Nov 2019 18:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239455;
        bh=KgnIv4iX5ytbpJXt/i/8vSkzCpA+EnsIz5HAgfGpj3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t/MAvOOHCTneplpjpihi6/028AOfqq1z4EEGAsCK4FOa3+HxH99ahYp889IZWjvd/
         em3Kn3a7qxiSCotOKaDL8f4pcS4Y0NlvwdENg3tZnaxTkJAm336uzReZ9BlHtXA1DH
         u2wqXm8mY3GGWevhKgBGhsU2nAs6j0KCpHR3GHxE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yizhuo <yzhai003@ucr.edu>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 03/62] regulator: pfuze100-regulator: Variable "val" in pfuze100_regulator_probe() could be uninitialized
Date:   Fri,  8 Nov 2019 19:49:51 +0100
Message-Id: <20191108174722.029704992@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174719.228826381@linuxfoundation.org>
References: <20191108174719.228826381@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



