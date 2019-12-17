Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C279CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8D721835
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfLQAJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:09:17 -0500
Received: from muru.com ([72.249.23.125]:48586 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfLQAJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:09:15 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 6FA0E8126;
        Tue, 17 Dec 2019 00:09:53 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     "Andrew F . Davis" <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] bus: ti-sysc: Fix iterating over clocks
Date:   Mon, 16 Dec 2019 16:09:06 -0800
Message-Id: <20191217000906.43658-2-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217000906.43658-1-tony@atomide.com>
References: <20191217000906.43658-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d878970f6ce1 ("bus: ti-sysc: Add separate functions for handling
clocks") separated handling of optional clocks from the main clocks, but
introduced an issue where we do not necessarily allocate a slot for both
fck and ick clocks, but still assume fixed slots for enumerating over the
clocks.

Let's fix the issue by ensuring we always have slots for both fck and ick
even if we don't use ick, and don't attempt to enumerate optional clocks
if not allocated.

In the long run we might want to simplify things a bit by only allocating
space only for the optional clocks as we have only few devices with
optional clocks.

Fixes: d878970f6ce1 ("bus: ti-sysc: Add separate functions for handling clocks")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -343,6 +343,12 @@ static int sysc_get_clocks(struct sysc *ddata)
 		return -EINVAL;
 	}
 
+	/* Always add a slot for main clocks fck and ick even if unused */
+	if (!nr_fck)
+		ddata->nr_clocks++;
+	if (!nr_ick)
+		ddata->nr_clocks++;
+
 	ddata->clocks = devm_kcalloc(ddata->dev,
 				     ddata->nr_clocks, sizeof(*ddata->clocks),
 				     GFP_KERNEL);
@@ -421,7 +427,7 @@ static int sysc_enable_opt_clocks(struct sysc *ddata)
 	struct clk *clock;
 	int i, error;
 
-	if (!ddata->clocks)
+	if (!ddata->clocks || ddata->nr_clocks < SYSC_OPTFCK0 + 1)
 		return 0;
 
 	for (i = SYSC_OPTFCK0; i < SYSC_MAX_CLOCKS; i++) {
@@ -455,7 +461,7 @@ static void sysc_disable_opt_clocks(struct sysc *ddata)
 	struct clk *clock;
 	int i;
 
-	if (!ddata->clocks)
+	if (!ddata->clocks || ddata->nr_clocks < SYSC_OPTFCK0 + 1)
 		return;
 
 	for (i = SYSC_OPTFCK0; i < SYSC_MAX_CLOCKS; i++) {
-- 
2.24.1
