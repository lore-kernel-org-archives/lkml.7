Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E4EC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC9220679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556272752;
	bh=USBSOIn9PPHmz35nori7rGi4K5WQipJCz6pyQldkYaA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sX9Hz1wU3sy16Ikwk9L5lbG447ob7iLSVSh4owIn5DGNv4ProL9X0TYwbvdWFzo+h
	 TIEjgfPbM/d2bG70f/8jxXRXnESj5rbTtzm5JFjL8vGRvzu8ErgzRUbYkcCN4Ub2BV
	 RLR20rspzPfAPJghiXy0c7kWNBtmjVSklWK34f2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfDZJ7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfDZJ7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:59:10 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECC8E20679;
        Fri, 26 Apr 2019 09:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556272750;
        bh=USBSOIn9PPHmz35nori7rGi4K5WQipJCz6pyQldkYaA=;
        h=From:To:Cc:Subject:Date:From;
        b=PILyeA2dwbdsHU0P2pvSPvm6o0Z57VQt2fYRKyL52gnvw0Qvj+nIyIim3aO9fTkNL
         Q2sxfrN+qo6CFkSrITtryQ+lCL2p2z2ORzKxOmAK+tQVncoppy3VzGrAcFB9S9dbYa
         m1czvc+3viT8Di8BDuiz3GeR/UFbfzGdyyLID364=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] power: supply: bq27xxx_battery: Notify also about status changes
Date:   Fri, 26 Apr 2019 11:59:02 +0200
Message-Id: <1556272742-17232-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User-space might be interested in receiving uevents when the charging
starts/stops or if conditions of battery changes (e.g.
over-temperature).  Notify about changes in battery also when the flags
change, not only SoC.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Remove unneeded backslash (pointed by Pali).
---
 drivers/power/supply/bq27xxx_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 29b3a4056865..195c18c2f426 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1612,7 +1612,8 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 			di->charge_design_full = bq27xxx_battery_read_dcap(di);
 	}
 
-	if (di->cache.capacity != cache.capacity)
+	if ((di->cache.capacity != cache.capacity) ||
+	    (di->cache.flags != cache.flags))
 		power_supply_changed(di->bat);
 
 	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
-- 
2.7.4

