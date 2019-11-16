Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A42C43141
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D772081E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919352;
	bh=vm84ASlpradK3YRp36649IF0WvfGXEHeTtm8gY3B1AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gS3Ep+IlKUSsfp1pBv1zQCzOy0RWc/7dOiEYff8F6wZvnoPLZpjAhwvap+KXevIoN
	 7FNwdTKJ/41AK59Hmr+MiUyvx9UGwV/VltQEvl+9ZGJ45fdJHKfo8xSrnz+9Svp2SG
	 e1iLcplSq7VgT1CKLeJIhqcNbNtFb5pmnTdJGrzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfKPPs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730177AbfKPPsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:48:46 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C774020729;
        Sat, 16 Nov 2019 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919326;
        bh=vm84ASlpradK3YRp36649IF0WvfGXEHeTtm8gY3B1AY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6q0zvd9GqAsgtnTX7L30hSkLGakCElKsmoNQhPl6krOdoSZ0ll98Q8+I/5uaUnb9
         h4kxEmH+fGbe2W4uOFo3o5zqxNmSqNuuRK/ibvmsHJF80AvCqpm3i/27d9FNyBP4gr
         jwtga3XPdB0qnzEE+9q96R6clvqUi7FqgRZ/iGf8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 068/150] mfd: mc13xxx-core: Fix PMIC shutdown when reading ADC values
Date:   Sat, 16 Nov 2019 10:46:06 -0500
Message-Id: <20191116154729.9573-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

[ Upstream commit 55143439b7b501882bea9d95a54adfe00ffc79a3 ]

When trying to read any MC13892 ADC channel on a imx51-babbage board:

The MC13892 PMIC shutdowns completely.

After debugging this issue and comparing the MC13892 and MC13783
initializations done in the vendor kernel, it was noticed that the
CHRGRAWDIV bit of the ADC0 register was not being set.

This bit is set by default after power on, but the driver was
clearing it.

After setting this bit it is possible to read the ADC values correctly.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Tested-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/mc13xxx-core.c  | 3 ++-
 include/linux/mfd/mc13xxx.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 6c16f170529f5..75d52034f89da 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -278,7 +278,8 @@ int mc13xxx_adc_do_conversion(struct mc13xxx *mc13xxx, unsigned int mode,
 	if (ret)
 		goto out;
 
-	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2;
+	adc0 = MC13XXX_ADC0_ADINC1 | MC13XXX_ADC0_ADINC2 |
+	       MC13XXX_ADC0_CHRGRAWDIV;
 	adc1 = MC13XXX_ADC1_ADEN | MC13XXX_ADC1_ADTRIGIGN | MC13XXX_ADC1_ASC;
 
 	if (channel > 7)
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index 638222e43e489..93011c61aafd2 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -247,6 +247,7 @@ struct mc13xxx_platform_data {
 #define MC13XXX_ADC0_TSMOD0		(1 << 12)
 #define MC13XXX_ADC0_TSMOD1		(1 << 13)
 #define MC13XXX_ADC0_TSMOD2		(1 << 14)
+#define MC13XXX_ADC0_CHRGRAWDIV		(1 << 15)
 #define MC13XXX_ADC0_ADINC1		(1 << 16)
 #define MC13XXX_ADC0_ADINC2		(1 << 17)
 
-- 
2.20.1

