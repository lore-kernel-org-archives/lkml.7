Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF3FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123CD21D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213301;
	bh=bps7aspVj9ihpI9mgbBFifMa6gO24Le9UKHhslhfgzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y6WlStO9ZXY1qaUGN+EpiQa1WugB6r5tx2oeUbl5PAzyIZOZ/cXaCRPYLqNnI+XsG
	 SkGNV+qCr7RWnPy8uOxe/ZDLpAUSJH2Y8ADwoH+d8CK+L1DZsDWBqOyzu5bUfTYLhL
	 bjyxjSkOa4m23GIwV3s3Ou/Bx8G/euW14pm3ST5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389571AbfKHLlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389504AbfKHLld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E5E222C4;
        Fri,  8 Nov 2019 11:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213292;
        bh=bps7aspVj9ihpI9mgbBFifMa6gO24Le9UKHhslhfgzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JTVoeLZo5IuudXehk9YEIyKICDmH4Hp5kVOm+sG/Eatpzv/Kqq5ZUT8OoWjbXta7l
         FeHLWxdnJpABpZrHcOd7++hDLwhkjeZW1gAeMoHeoavzbtDttUObCqLImYhyihVqIc
         pXOcMdafY0QHOmFV9I/e/iVwo5VWCarxZk0gsqD8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 151/205] ARM: imx6: register pm_power_off handler if "fsl,pmic-stby-poweroff" is set
Date:   Fri,  8 Nov 2019 06:36:58 -0500
Message-Id: <20191108113752.12502-151-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 8148d2136002da2e2887caf6a07bbd9c033f14f3 ]

One of the Freescale recommended sequences for power off with external
PMIC is the following:
...
3.  SoC is programming PMIC for power off when standby is asserted.
4.  In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.

See:
http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
page 5083

This patch implements step 4. of this sequence.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-imx/pm-imx6.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index b08e407d8d96f..529f4b5bbd3a7 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -618,6 +618,28 @@ static void __init imx6_pm_common_init(const struct imx6_pm_socdata
 				   IMX6Q_GPR1_GINT);
 }
 
+static void imx6_pm_stby_poweroff(void)
+{
+	imx6_set_lpm(STOP_POWER_OFF);
+	imx6q_suspend_finish(0);
+
+	mdelay(1000);
+
+	pr_emerg("Unable to poweroff system\n");
+}
+
+static int imx6_pm_stby_poweroff_probe(void)
+{
+	if (pm_power_off) {
+		pr_warn("%s: pm_power_off already claimed  %p %pf!\n",
+			__func__, pm_power_off, pm_power_off);
+		return -EBUSY;
+	}
+
+	pm_power_off = imx6_pm_stby_poweroff;
+	return 0;
+}
+
 void __init imx6_pm_ccm_init(const char *ccm_compat)
 {
 	struct device_node *np;
@@ -634,6 +656,9 @@ void __init imx6_pm_ccm_init(const char *ccm_compat)
 	val = readl_relaxed(ccm_base + CLPCR);
 	val &= ~BM_CLPCR_LPM;
 	writel_relaxed(val, ccm_base + CLPCR);
+
+	if (of_property_read_bool(np, "fsl,pmic-stby-poweroff"))
+		imx6_pm_stby_poweroff_probe();
 }
 
 void __init imx6q_pm_init(void)
-- 
2.20.1

