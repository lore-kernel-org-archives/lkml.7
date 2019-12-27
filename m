Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD8C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F37220722
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577470774;
	bh=jKEoB//vvMiVIMHHwPC01aWBfdUgmVNVKxLl2DCEFhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2khnAsSlWnMzNf3JCudLEes9M4OL1sAOhbeArl5xYnFB4cLoLtZDFWoe9PjBAsxRq
	 sDFMiyH3x4SXVvy3wl05sOEUIL6jA6Vghse3JmVabRNrXwNe4aGBLvA3RYtTXkAik6
	 5qBkvsLG8ImT/tn29lPqj5WOoOrpYH1tV7CR5Y68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfL0ST1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:19:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbfL0SOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:14:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 198B821744;
        Fri, 27 Dec 2019 18:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577470491;
        bh=jKEoB//vvMiVIMHHwPC01aWBfdUgmVNVKxLl2DCEFhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DT7MwGdE7iXulBXIfYz530KNTJHn2F7ZV8EZn8/9/KsXlz08zBwdqZ5Gned8/RoVm
         tuAfOOv2pOm4s2nEcpoy1b0KyZN6DGFfe8CGoo62IiFOU8YYUyixCwhSB/nFPtofg5
         Iz35yGI9+Bd73Gz+j4qWBMwZGttFo/+9Ce1JucUc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 12/38] fjes: fix missed check in fjes_acpi_add
Date:   Fri, 27 Dec 2019 13:14:09 -0500
Message-Id: <20191227181435.7644-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227181435.7644-1-sashal@kernel.org>
References: <20191227181435.7644-1-sashal@kernel.org>
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
index bbc983b04561..3511d40ba3f1 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -148,6 +148,9 @@ static int fjes_acpi_add(struct acpi_device *device)
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

