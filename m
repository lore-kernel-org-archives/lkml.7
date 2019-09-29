Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44E8C32793
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C83E2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569779016;
	bh=5CWtG3b29b2lb4NXYKOeC/Hsp5itJeKwBFIVJ43OSLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xJCWIo9o00ZSSl/a2DnXOX/ph3amiZrxl5sS+UqVvGDEAlp/Go/uP0pRr/Img6Fsa
	 wPVt9+WsLJKaDWzRoUp6U0Ki9wWhufDBgs/nAuFWPgxv842BTcU8fibWSnvr+QVXkL
	 VRjbA5E52Nlyq/5xaqR00SsN3R9E6L3/Y1tgy7Mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfI2RbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:31:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbfI2RbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:31:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C3002190F;
        Sun, 29 Sep 2019 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778272;
        bh=5CWtG3b29b2lb4NXYKOeC/Hsp5itJeKwBFIVJ43OSLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkES1uvX74YvBoJd7R1fXLFE+99IPRqLvJU46qKrg0r+bOEBBmnq7BCSRRT1rRbrm
         KM6cr5gC5Rlm398sixTHSWS60xntruJz0b5QqVTwpYprJwnJT9kRew148X07SMLbyI
         mPZvygCJ3X0eYyz61vzYvC1KI7VF63B5hzhv1+oo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 09/49] rtc: bd70528: fix driver dependencies
Date:   Sun, 29 Sep 2019 13:30:09 -0400
Message-Id: <20190929173053.8400-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173053.8400-1-sashal@kernel.org>
References: <20190929173053.8400-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

[ Upstream commit 41a8e19f47dfe9154c56b35842700ad38a7c33e0 ]

With CONFIG_BD70528_WATCHDOG=m, a built-in rtc driver cannot call
into the low-level functions that are part of the watchdog module:

drivers/rtc/rtc-bd70528.o: In function `bd70528_set_time':
rtc-bd70528.c:(.text+0x22c): undefined reference to `bd70528_wdt_lock'
rtc-bd70528.c:(.text+0x2a8): undefined reference to `bd70528_wdt_unlock'
drivers/rtc/rtc-bd70528.o: In function `bd70528_set_rtc_based_timers':
rtc-bd70528.c:(.text+0x50c): undefined reference to `bd70528_wdt_set'

Add a Kconfig dependency which forces RTC to be a module if watchdog is a
module. If watchdog is not compiled at all the stub functions for watchdog
control are used. compiling the RTC without watchdog is fine.

Fixes: 32a4a4ebf768 ("rtc: bd70528: Initial support for ROHM bd70528 RTC")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Link: https://lore.kernel.org/r/84462e01e43d39024948a3bdd24087ff87dc2255.1565591387.git.matti.vaittinen@fi.rohmeurope.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e72f65b61176d..add43c3374895 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -500,6 +500,7 @@ config RTC_DRV_M41T80_WDT
 	  watchdog timer in the ST M41T60 and M41T80 RTC chips series.
 config RTC_DRV_BD70528
 	tristate "ROHM BD70528 PMIC RTC"
+	depends on MFD_ROHM_BD70528 && (BD70528_WATCHDOG || !BD70528_WATCHDOG)
 	help
 	  If you say Y here you will get support for the RTC
 	  on ROHM BD70528 Power Management IC.
-- 
2.20.1

