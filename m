Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B5DC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E32021582
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469380;
	bh=m3R8VhV1A40UyZ5t6c5N/kTx1pW0D6+5BJNlJUMw+zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Izg88aMM8qJCyubJ8fWics1EIxky/5e5SX6LcO4TfXVpd4ElCH4+zEXuS6hhtYKGH
	 dk7YcxmW16Jj8vP6sXLZeGo5twS0MgZDXAT2ucD75EnGWeTklPeXEEhg27fD+3ycl6
	 mD/O/LR2NnfjQ02nEVrSbpIXbfYj78oGImuSpcwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfL0R4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:56:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbfL0RmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:42:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1569E22525;
        Fri, 27 Dec 2019 17:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468522;
        bh=m3R8VhV1A40UyZ5t6c5N/kTx1pW0D6+5BJNlJUMw+zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XOhzjzoCMEUm2YTUKhjJTfNaYBgN4RTa6g7AovFqsITNMcbd48X2zmvu9PE1IdDe7
         CGUM3d1pvqHXp8zYcubQnGsGtwLtO9vwccGAlWe858PYxQrGVvAizh4Qybvf6+hY0c
         WArowaUHe1eJ0OK8bRR7w0JM5nQUn6Xi1+zG5fNA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 054/187] fjes: fix missed check in fjes_acpi_add
Date:   Fri, 27 Dec 2019 12:38:42 -0500
Message-Id: <20191227174055.4923-54-sashal@kernel.org>
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

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit a288f105a03a7e0e629a8da2b31f34ebf0343ee2 ]

fjes_acpi_add() misses a check for platform_device_register_simple().
Add a check to fix it.

Fixes: 658d439b2292 ("fjes: Introduce FUJITSU Extended Socket Network Device driver")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/fjes/fjes_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index b517c1af9de0..91a1059517f5 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -166,6 +166,9 @@ static int fjes_acpi_add(struct acpi_device *device)
 	/* create platform_device */
 	plat_dev = platform_device_register_simple(DRV_NAME, 0, fjes_resource,
 						   ARRAY_SIZE(fjes_resource));
+	if (IS_ERR(plat_dev))
+		return PTR_ERR(plat_dev);
+
 	device->driver_data = plat_dev;
 
 	return 0;
-- 
2.20.1

