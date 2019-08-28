Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECF7C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F432070B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfH1Gb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:31:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:49892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbfH1Gb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:31:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9510B12E;
        Wed, 28 Aug 2019 06:31:24 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, SteveM <swm@swm1.com>
Subject: [PATCH] sky2: Disable MSI on yet another ASUS boards (P6Xxxx)
Date:   Wed, 28 Aug 2019 08:31:19 +0200
Message-Id: <20190828063119.22248-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A similar workaround for the suspend/resume problem is needed for yet
another ASUS machines, P6X models.  Like the previous fix, the BIOS
doesn't provide the standard DMI_SYS_* entry, so again DMI_BOARD_*
entries are used instead.

Reported-and-tested-by: SteveM <swm@swm1.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/net/ethernet/marvell/sky2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index c2e00bb587cd..5f56ee83e3b1 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -4931,6 +4931,13 @@ static const struct dmi_system_id msi_blacklist[] = {
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
2.16.4

