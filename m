Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92409C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8D220748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577643036;
	bh=9OSaqMyXEV1YSYkKHen15K8b+MmvCI0xuHw1grtnIUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RYZ0lLrvIsqwc+9jVEDPs4cmuCgPo9NzABzJbe+NJ9so3nIl0CKfPwLdlIx66HSFA
	 w1tdA9YtUYciHmesTp3I3WFg/S2xMfQKvbQdKKdb6O/ads1vp+RQyHqLnYnggt9Zsi
	 /30PoAi0Jgt67xXJKHy5A8lPMwh4X2c6/SAXgsa8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbfL2SKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:52244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbfL2RoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:44:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D33920718;
        Sun, 29 Dec 2019 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641454;
        bh=9OSaqMyXEV1YSYkKHen15K8b+MmvCI0xuHw1grtnIUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ktw/HK2FiwAGKR2cp0vZB6KFH0VY+v44XWbmpviUAhnfHyz6jdMqBmMsRAX3fYNiD
         VREo/yEGk8dDEwLYEYNP9QD4JN7yg2h1rJ5vEpd+YKA74prN/b89fHEL+sBkVdOlav
         MyU1BdfI3sRng+E5Dvq5Rwf3NWVIEddqzbPFkfog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 073/434] spi: gpio: prevent memory leak in spi_gpio_probe
Date:   Sun, 29 Dec 2019 18:22:06 +0100
Message-Id: <20191229172706.506071209@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit d3b0ffa1d75d5305ebe34735598993afbb8a869d ]

In spi_gpio_probe an SPI master is allocated via spi_alloc_master, but
this controller should be released if devm_add_action_or_reset fails,
otherwise memory leaks. In order to avoid leak spi_contriller_put must
be called in case of failure for devm_add_action_or_reset.

Fixes: 8b797490b4db ("spi: gpio: Make sure spi_master_put() is called in every error path")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Link: https://lore.kernel.org/r/20190930205241.5483-1-navid.emamdoost@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 1d3e23ec20a6..f9c5bbb74714 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -371,8 +371,10 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	status = devm_add_action_or_reset(&pdev->dev, spi_gpio_put, master);
-	if (status)
+	if (status) {
+		spi_master_put(master);
 		return status;
+	}
 
 	if (of_id)
 		status = spi_gpio_probe_dt(pdev, master);
-- 
2.20.1



