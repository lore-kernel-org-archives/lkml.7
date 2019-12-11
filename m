Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12FEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70D720836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576080444;
	bh=UXnO5c4FLyYN9Gmyu429fTyxrF3mqzIcAgwWMCRZe3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yBvnIeGUvNPNVfb6R7PxtQbXniY6OnYRH/79UavRcnfh12IeSQQvstm95f5+X/MeJ
	 +TJb8EaQ8MNoo3KVjTGm9TxZUE91+4Tz3YRzZ0VXUgGCqP9Q0WCg4bR5oAevTD1Ixk
	 ZUhcZA32CfuhAifafb0rbtG8HW1Uoqw/ST+Y8nvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388813AbfLKQHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:07:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730763AbfLKPMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:12:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E8E208C3;
        Wed, 11 Dec 2019 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077149;
        bh=UXnO5c4FLyYN9Gmyu429fTyxrF3mqzIcAgwWMCRZe3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdzi2jlL+9LO9KDxXDWTu9tCWB9qPqByHQOfXym4Ul6DnqkrY29nTt9XacqftntbW
         P+OOvjPBfGZ7CyZX673BR6Cg0vHLolOtXuTwWtrjlMfDnhnkUJ5fZ6GxMA/n4Aek05
         IoSKNgqazCCabcj59wPoH+s039G/hJ/8FPOkD6VI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 036/134] clocksource/drivers/timer-of: Use unique device name instead of timer
Date:   Wed, 11 Dec 2019 10:10:12 -0500
Message-Id: <20191211151150.19073-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 4411464d6f8b5e5759637235a6f2b2a85c2be0f1 ]

If a hardware-specific driver does not provide a name, the timer-of core
falls back to device_node.name.  Due to generic DT node naming policies,
that name is almost always "timer", and thus doesn't identify the actual
timer used.

Fix this by using device_node.full_name instead, which includes the unit
addrees.

Example impact on /proc/timer_list:

    -Clock Event Device: timer
    +Clock Event Device: timer@fcfec400

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191016144747.29538-3-geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 11ff701ff4bb9..a3c73e972fce1 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -192,7 +192,7 @@ int __init timer_of_init(struct device_node *np, struct timer_of *to)
 	}
 
 	if (!to->clkevt.name)
-		to->clkevt.name = np->name;
+		to->clkevt.name = np->full_name;
 
 	to->np = np;
 
-- 
2.20.1

