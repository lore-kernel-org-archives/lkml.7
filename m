Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2387C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9941C21823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141526;
	bh=bps7aspVj9ihpI9mgbBFifMa6gO24Le9UKHhslhfgzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eGtXv/JNjXlLWLmSXkdMaooHgiLEUXy7dnK6GJIk9T8NXAs09kjyj3SarOVKKLJus
	 cDVIGowF8oHJDTtJaMMZ5mcWy/3nRRTTihwLHY5yzY2zUzA4c7tP/3uxhf1QXoxz3Z
	 I3q2h8w3n1RnsPdLZesHnNm/P3U0CTwKIKnrKGsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfKSFcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbfKSFcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:32:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9316A208C3;
        Tue, 19 Nov 2019 05:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141522;
        bh=bps7aspVj9ihpI9mgbBFifMa6gO24Le9UKHhslhfgzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rsq9rnAiqADhhdmdQFohQvfzB5k0OrRsaY3CNomQRUXCBQ0aMCqnQ//uAkmakdgti
         xo3R9QkVHws1IQLQ70cGGR0RAX2bvYbkfjKus7E/XrcqUxDSeEo/hCDITdCSgqvtts
         se77CTZaurGeBchLFSOCCdif2JTp24i2QXmQCK5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 182/422] ARM: imx6: register pm_power_off handler if "fsl,pmic-stby-poweroff" is set
Date:   Tue, 19 Nov 2019 06:16:19 +0100
Message-Id: <20191119051410.265926410@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



