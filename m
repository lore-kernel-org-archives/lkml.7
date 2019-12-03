Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC2FC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381ED214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413206;
	bh=1XraHiRGdK3fOvZxkYKzP947PwRAKgEMsREczj6U/sU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UGYqRyVlpI+aPRkZ8p+cNWRL07R5eVhgxTy3Tp8E7MKZ4uTXYhLVvzKQpnkw8ZtPS
	 zsT+LizdTIULSkwdYkbE9uFzNXOLftcM0WFkBjgO5ZukIGA0lQlsDK6fA6jgy7z1St
	 ruHhHz1uTMTiyaoHnmLEsEWylUlJJY0wxLMY3zQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfLCWqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:46:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbfLCWql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:46:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0065B20656;
        Tue,  3 Dec 2019 22:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413200;
        bh=1XraHiRGdK3fOvZxkYKzP947PwRAKgEMsREczj6U/sU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZhGqivVu0Gvui1/Jr2QFAluinGn08RiynNqt8oQVa0lDgdcupu36ZPEQiSfs33VC3
         7u5LHXh+/IEzM//FqJNcdSJ6wsOWTNhPOVPPop+rObfbbMNNPOnilyBebn3f3Pg3R0
         eIwpectwnlTiOIlTw5kI0TEIkeSmn/NDKpzUWAns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xingyu Chen <xingyu.chen@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/321] watchdog: meson: Fix the wrong value of left time
Date:   Tue,  3 Dec 2019 23:31:42 +0100
Message-Id: <20191203223428.992358523@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

[ Upstream commit 2c77734642d52448aca673e889b39f981110828b ]

The left time value is wrong when we get it by sysfs. The left time value
should be equal to preset timeout value minus elapsed time value. According
to the Meson-GXB/GXL datasheets which can be found at [0], the timeout value
is saved to BIT[0-15] of the WATCHDOG_TCNT, and elapsed time value is saved
to BIT[16-31] of the WATCHDOG_TCNT.

[0]: http://linux-meson.com

Fixes: 683fa50f0e18 ("watchdog: Add Meson GXBB Watchdog Driver")
Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/meson_gxbb_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index 69adeab3fde70..0a6672789640c 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -89,8 +89,8 @@ static unsigned int meson_gxbb_wdt_get_timeleft(struct watchdog_device *wdt_dev)
 
 	reg = readl(data->reg_base + GXBB_WDT_TCNT_REG);
 
-	return ((reg >> GXBB_WDT_TCNT_CNT_SHIFT) -
-		(reg & GXBB_WDT_TCNT_SETUP_MASK)) / 1000;
+	return ((reg & GXBB_WDT_TCNT_SETUP_MASK) -
+		(reg >> GXBB_WDT_TCNT_CNT_SHIFT)) / 1000;
 }
 
 static const struct watchdog_ops meson_gxbb_wdt_ops = {
-- 
2.20.1



