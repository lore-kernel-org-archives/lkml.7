Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0EDC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2E92077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556270819;
	bh=fhNkvRB4wRn3bg/u+c3v8maFQ5a5icxUBYeoSwqYGEs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=q+F0EODrTMxmbOAMO+CaIbedu0UW8rI87iHm9PdNeVLRtstH0OkCDThlUnfAYcpq3
	 udQ2hfuFVubevj6zMxij+oMo+tblpZSx5h0N2KzKYZdFW6z9xhahApm1EjDEIDOFOG
	 hvyp8LEfvjvIrlTV+AtCXaahlFWgfETFMz59UTxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfDZJ06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfDZJ05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:26:57 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8BD22077B;
        Fri, 26 Apr 2019 09:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556270817;
        bh=fhNkvRB4wRn3bg/u+c3v8maFQ5a5icxUBYeoSwqYGEs=;
        h=From:To:Cc:Subject:Date:From;
        b=WFYR+hAeX8R6KwM6oD3/oBzfafJBX2X/t/KsZqqdoqI2lPd/OxFeurIFv/N+sciob
         fd68VIalcp7he5HZdt6EslCbPmNL9MdDuZaEekMRwa51W1b96s++qAcXMibvVW/sxy
         0NkeBH9Z2ElwRbpzvjWY+nFUo+nAbGaFtcKt/cMo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] power: supply: bq27xxx_battery: Notify also about status changes
Date:   Fri, 26 Apr 2019 11:26:48 +0200
Message-Id: <1556270808-21331-1-git-send-email-krzk@kernel.org>
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
 drivers/power/supply/bq27xxx_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 29b3a4056865..cb9306160c14 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1612,7 +1612,8 @@ void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 			di->charge_design_full = bq27xxx_battery_read_dcap(di);
 	}
 
-	if (di->cache.capacity != cache.capacity)
+	if ((di->cache.capacity != cache.capacity) || \
+	    (di->cache.flags != cache.flags))
 		power_supply_changed(di->bat);
 
 	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
-- 
2.7.4

