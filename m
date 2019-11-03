Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CD9CA9ED1
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 01:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40EA20679
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 01:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfKCBg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 21:36:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:59462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727431AbfKCBg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 21:36:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20627AFD4;
        Sun,  3 Nov 2019 01:36:55 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC 06/11] soc: realtek: chip: Detect RTD1296
Date:   Sun,  3 Nov 2019 02:36:40 +0100
Message-Id: <20191103013645.9856-7-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191103013645.9856-1-afaerber@suse.de>
References: <20191103013645.9856-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detection logic from downstream drivers/soc/realtek/rtd129x/rtk_chip.c.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/soc/realtek/chip.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/realtek/chip.c b/drivers/soc/realtek/chip.c
index 9d13422e9936..ba653c097644 100644
--- a/drivers/soc/realtek/chip.c
+++ b/drivers/soc/realtek/chip.c
@@ -50,9 +50,25 @@ static const char *default_name(struct device *dev, const struct rtd_soc *s)
 	return s->family;
 }
 
+static const char *rtd1295_name(struct device *dev, const struct rtd_soc *s)
+{
+	void __iomem *base;
+
+	base = of_iomap(dev->of_node, 1);
+	if (base) {
+		u32 chipinfo1 = readl_relaxed(base);
+		iounmap(base);
+		if (chipinfo1 & BIT(11)) {
+			return "RTD1296";
+		}
+	}
+
+	return "RTD1295";
+}
+
 static const struct rtd_soc rtd_soc_families[] = {
 	{ 0x00006329, "RTD1195", default_name, rtd1195_revisions, "Phoenix" },
-	{ 0x00006421, "RTD1295", default_name, rtd1295_revisions, "Kylin" },
+	{ 0x00006421, "RTD1295", rtd1295_name, rtd1295_revisions, "Kylin" },
 };
 
 static const struct rtd_soc *rtd_soc_by_chip_id(u32 chip_id)
-- 
2.16.4

