Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26904C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DBC2054F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369097;
	bh=8ofB9mGq0Ysuh/8d9RIlNFh9yWXt5I9D82g0eufEBQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=08PPuzPkpO2wQ3Bv3vH04u69yKaiXVFqolXaqGk0nB8+IzNjlS3x5zGmE2ogp3kDk
	 xNU+LwbRRDuTs48J6GL52ehdtf6E2fiQMgal5EeVLo1tv/H9QfwZg8qWlTIYfEroJk
	 nAtYlk6c7IWc6lIuEqug5LEL2v0qDoyx+Xqx7pyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbfDDJLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733171AbfDDJLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:11:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E693620693;
        Thu,  4 Apr 2019 09:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369089;
        bh=8ofB9mGq0Ysuh/8d9RIlNFh9yWXt5I9D82g0eufEBQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rv74lQda8LYV0MHl4ZWuhoDS2LAH31MIi/x1yYRcj8814vA+x8K4UWhynUWmS/I4+
         JJiykBKwlWXXD97JAKZjCSq51g0qEAsoGn5epsTsYFPxrr0s5OJu7UD8/51iHtU1Mr
         q0qeXMfc2e9ffZnKbd4xrdO/+X/YaGpYau432g/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Fan <nullptr.cpp@gmail.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 093/246] platform/x86: ideapad-laptop: Fix no_hw_rfkill_list for Lenovo RESCUER R720-15IKBN
Date:   Thu,  4 Apr 2019 10:46:33 +0200
Message-Id: <20190404084622.401549363@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



