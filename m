Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167F0C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A0922DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567612978;
	bh=g/ydxlUsCuG4kg0oFB4HZlFFa3Ik6DRsFehImxU9jHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNRa2KAcwFuDq7Pk9XPQGYa8e0zMP7Ohnzv2f1hWU5O+5wEFm3voHO/Og/2IdeTPY
	 IImtRSvMLHOBHKHtpB6NI2l0Emu/+GHG+0IoylMU6BpUoVfNh5b+VRZ18iL8sGWkse
	 en7dXH1s2w56Zwhk7NkGDw7zh0XaScxjAPKCX6Sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbfIDQC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387514AbfIDQCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:02:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CDEE22CF5;
        Wed,  4 Sep 2019 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612973;
        bh=g/ydxlUsCuG4kg0oFB4HZlFFa3Ik6DRsFehImxU9jHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWX4RQoDqNhVDloNHeYkOY06ZmIhqsVLmjnJo4adNi4updi9Nft6z47IsDoDUntLk
         mYnZLYzti8AuVUw+E6z+/77w/kod/y1G7fAU2vEvK3EqfIl9MbsDbx168cS1XOBexL
         4cSynC0h+4b1sN6AUwMG8LM75heAgDzNSXC5WJZs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, SteveM <swm@swm1.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 22/27] sky2: Disable MSI on yet another ASUS boards (P6Xxxx)
Date:   Wed,  4 Sep 2019 12:02:15 -0400
Message-Id: <20190904160220.4545-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904160220.4545-1-sashal@kernel.org>
References: <20190904160220.4545-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 189308d5823a089b56e2299cd96589507dac7319 ]

A similar workaround for the suspend/resume problem is needed for yet
another ASUS machines, P6X models.  Like the previous fix, the BIOS
doesn't provide the standard DMI_SYS_* entry, so again DMI_BOARD_*
entries are used instead.

Reported-and-tested-by: SteveM <swm@swm1.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/sky2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 59dbecd19c93f..49f692907a30b 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -4946,6 +4946,13 @@ static const struct dmi_system_id msi_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "P6T"),
 		},
 	},
+	{
+		.ident = "ASUS P6X",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "P6X"),
+		},
+	},
 	{}
 };
 
-- 
2.20.1

