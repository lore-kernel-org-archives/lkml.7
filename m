Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8449C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD4A206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469770;
	bh=e2NVxWlbOXz9zU0iEoJ6LBslPQrNM4A+koOlBVZQMg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k73Xp28i8ek/qtUv6SAoDIFQh7VqVVw5woBpxH/TR2U7yt2jzcGuBQWVZsovstL26
	 e3JBcz8pbPMwF9VEnTo6mCD/5MJgDAuhllDWByGFHKKXJ6PbpVoEklEicURliVP+ah
	 2AYtXjcivTl5OuUTO7Gb6T3Lhsob/7YAWT1bKHM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfL0SCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:02:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:59718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbfL0SCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:02:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 885BF21775;
        Fri, 27 Dec 2019 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577469766;
        bh=e2NVxWlbOXz9zU0iEoJ6LBslPQrNM4A+koOlBVZQMg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3IsdS03g/T1oBob0tiK29BBGSv7xzznNftWqEDqSS3EbtSjdT2GQ96Bt7JVQUMuz
         Tev77BPN1NQaHNYkK3d4q55VJ3s/eUKJPdqLD87EMGd9jdHhzi9iGLF+S+ocS0nFtZ
         RrVE9hp7BzjZE9LeYxwX89QuvYk3Db2vSORB5g1o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 18/57] fjes: fix missed check in fjes_acpi_add
Date:   Fri, 27 Dec 2019 13:01:43 -0500
Message-Id: <20191227180222.7076-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227180222.7076-1-sashal@kernel.org>
References: <20191227180222.7076-1-sashal@kernel.org>
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
index 14d6579b292a..314e3eac09b9 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -181,6 +181,9 @@ static int fjes_acpi_add(struct acpi_device *device)
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

