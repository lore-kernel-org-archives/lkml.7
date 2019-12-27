Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,NO_DNS_FOR_FROM,SIGNED_OFF_BY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9687C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B724C20740
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468530;
	bh=xliATFxaIc+DI3oWcgq4jydwYRh7rKbWojHiLvFhSpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h/nlUhr4BS/WhfS5H8JNttCDnz3iGyDjViN82b9a6yeGBuyxDumoVA5Hq8SmFydf7
	 ox4djxbMCcuNpoGE55b7gHkH7hae8EJ8e4cltrC8rdGW2OBOdP0QQyPnU48I5YrJgz
	 ibLgFxpvr3+FaUG9MXpaADPHDm1SmggIThCvqSl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfL0RmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:42:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfL0RmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:42:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C4A2173E;
        Fri, 27 Dec 2019 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468524;
        bh=xliATFxaIc+DI3oWcgq4jydwYRh7rKbWojHiLvFhSpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tv6Dh7QMt+OsieBq8OIoF160UvRlxBzUvTd3wUxj6J/LgWqcj9yYLAkpgybcOvsJh
         gA7t5mdDcjDkuZuC1ZGPbjLnsvueAs7h2f2ah8UpYYmebdbOjmnWdxGRaWsYpMJI4e
         rfoHc6u7D+fLLYFNx2C+FNKfpjRYcQow0rPn+H2k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 055/187] NFC: nxp-nci: Fix probing without ACPI
Date:   Fri, 27 Dec 2019 12:38:43 -0500
Message-Id: <20191227174055.4923-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 868afbaca1e2a7923e48b5e8c07be34660525db5 ]

devm_acpi_dev_add_driver_gpios() returns -ENXIO if CONFIG_ACPI
is disabled (e.g. on device tree platforms).
In this case, nxp-nci will silently fail to probe.

The other NFC drivers only log a debug message if
devm_acpi_dev_add_driver_gpios() fails.
Do the same in nxp-nci to fix this problem.

Fixes: ad0acfd69add ("NFC: nxp-nci: Get rid of code duplication in ->probe()")
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/nxp-nci/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 4d1909aecd6c..9f60e4dc5a90 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -278,7 +278,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client,
 
 	r = devm_acpi_dev_add_driver_gpios(dev, acpi_nxp_nci_gpios);
 	if (r)
-		return r;
+		dev_dbg(dev, "Unable to add GPIO mapping table\n");
 
 	phy->gpiod_en = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(phy->gpiod_en)) {
-- 
2.20.1

