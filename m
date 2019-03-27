Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE93C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE0E206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713596;
	bh=2CBvICdekNgi1+u9+4+/geoNZckF5aADKkW0VbqtMa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=acbua+2pqFQV7EN473VH7U9GJgfeC1nzJ6334KKNgztuYvUuG8uyqnPloMjobD9/M
	 XV0fwSNVLajDDHL9A3NmyPaW8wXP7rwIJrzy6xuNWDmPnX17AQViY3v/Ms0nSk9Koh
	 Xkn/iXrwHNjx4aHlA+Ay1YcYFk1A2757QTaIJupw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389659AbfC0TGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389191AbfC0SMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:12:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE7DE21738;
        Wed, 27 Mar 2019 18:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710341;
        bh=2CBvICdekNgi1+u9+4+/geoNZckF5aADKkW0VbqtMa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R9Ohfr/hJ3BExc0xJl3G5MGv9ajYLXKDcFVaTje8WZYO2mdaLB5glNgWj4ViR18GN
         pnVuRIAHDaE2Hi6meNX7xiqriRpvTfDZv/cRxycZxA387KEj+yqj+VtwS5ruEXzZqQ
         eYmIev9mGm+jjunZc2TTW9TKzQdwsL2xc18gWkPM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yang Fan <nullptr.cpp@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 066/192] platform/x86: ideapad-laptop: Fix no_hw_rfkill_list for Lenovo RESCUER R720-15IKBN
Date:   Wed, 27 Mar 2019 14:08:18 -0400
Message-Id: <20190327181025.13507-66-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Fan <nullptr.cpp@gmail.com>

[ Upstream commit 4d9b2864a415fec39150bc13efc730c7eb88711e ]

Commit ae7c8cba3221 ("platform/x86: ideapad-laptop: add lenovo RESCUER
R720-15IKBN to no_hw_rfkill_list") added
    DMI_MATCH(DMI_BOARD_NAME, "80WW")
for Lenovo RESCUER R720-15IKBN.

But DMI_BOARD_NAME does not match 80WW on Lenovo RESCUER R720-15IKBN,
thus cause Wireless LAN still be hard blocked.

On Lenovo RESCUER R720-15IKBN:
    ~$ cat /sys/class/dmi/id/sys_vendor
    LENOVO
    ~$ cat /sys/class/dmi/id/board_name
    Provence-5R3
    ~$ cat /sys/class/dmi/id/product_name
    80WW
    ~$ cat /sys/class/dmi/id/product_version
    Lenovo R720-15IKBN

So on Lenovo RESCUER R720-15IKBN:
    DMI_SYS_VENDOR should match "LENOVO",
    DMI_BOARD_NAME should match "Provence-5R3",
    DMI_PRODUCT_NAME should match "80WW",
    DMI_PRODUCT_VERSION should match "Lenovo R720-15IKBN".

Fix it, and in according with other entries in no_hw_rfkill_list,
use DMI_PRODUCT_VERSION instead of DMI_BOARD_NAME.

Fixes: ae7c8cba3221 ("platform/x86: ideapad-laptop: add lenovo RESCUER R720-15IKBN to no_hw_rfkill_list")
Signed-off-by: Yang Fan <nullptr.cpp@gmail.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/ideapad-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index d4f1259ff5a2..62d4b94e2531 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -989,7 +989,7 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
 		.ident = "Lenovo RESCUER R720-15IKBN",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_BOARD_NAME, "80WW"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo R720-15IKBN"),
 		},
 	},
 	{
-- 
2.19.1

