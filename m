Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF082075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714801;
	bh=PmCfeuNZEXhjKcbb/lgZr2WT2SI5XaUTxSyJhKXAmJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2twpfv23YM2+jQ9FcSNJODG9Ie85POT+re03NcPOJAc6qE/4e0IcP6+aM0eoD+0hh
	 PCKZHjXBpRp1ff/IuqnPoCOAWkaePRlXBLAu5wDXxm96CM9vppQnSi9wk4OWejarTH
	 26PphSpdyWd4/TUhzqZRj6xv79XRyMSBGHIuHe/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbfC0T0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387530AbfC0SFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D26402177E;
        Wed, 27 Mar 2019 18:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709901;
        bh=PmCfeuNZEXhjKcbb/lgZr2WT2SI5XaUTxSyJhKXAmJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXxT3JxRr56DBUpkjj6PpL44toE053974PUswdJIC2GVHrkNygIZvvFY8hbBCqPum
         V7jSnJZgydYfCIcw5ycZ/G5Z8zRq+Zue0jxsvxZYjxzBnAuCkcCVZUaey/j8YmKvmn
         wSQMMemKqdHY4s5CE33fJ7aP0pKbSK4IXtpGOvBg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yang Fan <nullptr.cpp@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 099/262] platform/x86: ideapad-laptop: Fix no_hw_rfkill_list for Lenovo RESCUER R720-15IKBN
Date:   Wed, 27 Mar 2019 13:59:14 -0400
Message-Id: <20190327180158.10245-99-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
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
index 1589dffab9fa..8b53a9ceb897 100644
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

