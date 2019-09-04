Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16849C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB89722CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbfIDGmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:42:39 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:34391 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfIDGmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:42:38 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id x846gWAq028106
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Sep 2019 08:42:32 +0200
Received: from [167.87.42.80] ([167.87.42.80])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x846gVpF006197;
        Wed, 4 Sep 2019 08:42:31 +0200
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] platform/x86: pmc_atom: Add Siemens SIMATIC IPC227E to
 critclk_systems DMI table
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <c090302a-da38-5764-2a84-399ed6b333f5@siemens.com>
Date:   Wed, 4 Sep 2019 08:42:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

The SIMATIC IPC227E uses the PMC clock for on-board components and gets
stuck during boot if the clock is disabled. Therefore, add this device
to the critical systems list.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - fixed cut-off subject line (local tooling bug...)

Should go into stable as well, down to 4.19.

 drivers/platform/x86/pmc_atom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index aa53648a2214..9aca5e7ce6d0 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -415,6 +415,13 @@ static const struct dmi_system_id critclk_systems[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "CB6363"),
 		},
 	},
+	{
+		.ident = "SIMATIC IPC227E",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "6ES7647-8B"),
+		},
+	},
 	{ /*sentinel*/ }
 };
 
-- 

2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
