Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E79C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883AA218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 17:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y9jsDNqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfC2Rxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:53:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43408 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbfC2Rxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 13:53:45 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2THrddH088448;
        Fri, 29 Mar 2019 12:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553882019;
        bh=cvHe9NSYoH2d70qEsIdJOSEV+cwJznw3SeuyN2Kj274=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Y9jsDNqadalZuV6u6jBKN4YS1UMEstLgqvjzR8C/6z6pvHnzTIESEgiIO+d79hXjx
         zcEJCtHIEN+hHkaydsX9t4auw0+go39sOAHlb+1NGWV/Yt9KAMVkryr0mo/OI70AYg
         jYIzSTP16XxSJsHiKIh94c2aP1YgcofOf69Qr0VE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2THrd5s048621
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 12:53:39 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 12:53:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 12:53:39 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2THrcHc023161;
        Fri, 29 Mar 2019 12:53:39 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2THrcU25935;
        Fri, 29 Mar 2019 12:53:38 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 4/5] ARM: OMAP: Wakeupgen: AM43xx HS devices should save context like non-HS
Date:   Fri, 29 Mar 2019 12:53:35 -0500
Message-ID: <20190329175336.19824-4-afd@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329175336.19824-1-afd@ti.com>
References: <20190329175336.19824-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike some previous generation devices, AM43xx HS IRQ and Wakegen
context is handled by the ROM for us, and no secure service call
is needed or supported. Non-GP AM43xx devices should take the
same path as GP.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/mach-omap2/omap-wakeupgen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 17558be4bf0a..7dcbe1736f7e 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -436,13 +436,13 @@ static int irq_notifier(struct notifier_block *self, unsigned long cmd,	void *v)
 {
 	switch (cmd) {
 	case CPU_CLUSTER_PM_ENTER:
-		if (omap_type() == OMAP2_DEVICE_TYPE_GP)
+		if (omap_type() == OMAP2_DEVICE_TYPE_GP || soc_is_am43xx())
 			irq_save_context();
 		else
 			irq_save_secure_context();
 		break;
 	case CPU_CLUSTER_PM_EXIT:
-		if (omap_type() == OMAP2_DEVICE_TYPE_GP)
+		if (omap_type() == OMAP2_DEVICE_TYPE_GP || soc_is_am43xx())
 			irq_restore_context();
 		break;
 	}
-- 
2.21.0

