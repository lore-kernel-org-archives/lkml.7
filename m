Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7DAC17440
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE7E206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610838;
	bh=xI+skwa8kTa6/wPWYDcvAJcHAf1EsrACC8CuciHJb3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gfu5nJh8bsrgqH2NUAu1vgl5x5YHbW7lNZISZCouGO4r5IdaU3bfvGb/YnHSex895
	 cQ/CggzJUjp4zK5N0ALNdGjlQ6xRAY3hmsU6L9J9G2BsVqoNQiaLDAaDpSxoDiGrZn
	 p/3YrYe6F90EMAvqyELzgA9mymhH3qwkWn6YONdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfKMCAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:00:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:55936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730527AbfKMCAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:00:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 907F02053B;
        Wed, 13 Nov 2019 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610436;
        bh=xI+skwa8kTa6/wPWYDcvAJcHAf1EsrACC8CuciHJb3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGXPbuPCYGFWpKPFb3irvi2xQIcFu0qPgEqRCw+qxXK0XSaJlYY2Asx+oDLbu4UTE
         BZPFid82nel9ZtoKvJA5ZOBJRDMRAJiWBkn7D9TfFEOyPSUgvYbsbhjRya5iWSB5tY
         vWqaY0ModYcQefxdCjdYg3uu1IhHsUAS0aBF40bo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 36/68] i2c: brcmstb: Allow enabling the driver on DSL SoCs
Date:   Tue, 12 Nov 2019 20:59:00 -0500
Message-Id: <20191113015932.12655-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015932.12655-1-sashal@kernel.org>
References: <20191113015932.12655-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit e1eba2ea54a2de0e4c58d87270d25706bb77b844 ]

ARCH_BCM_63XX which is used by ARM-based DSL SoCs from Broadcom uses the
same controller, make it possible to select the STB driver and update
the Kconfig and help text a bit.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d252276feadf6..759c621a860a9 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -397,12 +397,13 @@ config I2C_BCM_KONA
 	  If you do not need KONA I2C interface, say N.
 
 config I2C_BRCMSTB
-	tristate "BRCM Settop I2C controller"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
+	tristate "BRCM Settop/DSL I2C controller"
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_63XX || \
+		   COMPILE_TEST
 	default y
 	help
 	  If you say yes to this option, support will be included for the
-	  I2C interface on the Broadcom Settop SoCs.
+	  I2C interface on the Broadcom Settop/DSL SoCs.
 
 	  If you do not need I2C interface, say N.
 
-- 
2.20.1

