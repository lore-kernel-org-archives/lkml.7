Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B88C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1AD20830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfCYV7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:59:02 -0400
Received: from muru.com ([72.249.23.125]:42580 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbfCYV67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:58:59 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id B04C58120;
        Mon, 25 Mar 2019 21:59:12 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/14] bus: ti-sysc: Fix sysc_unprepare() when no clocks have been allocated
Date:   Mon, 25 Mar 2019 14:58:36 -0700
Message-Id: <20190325215849.13182-2-tony@atomide.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325215849.13182-1-tony@atomide.com>
References: <20190325215849.13182-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we return early before ddata->clocks have been allocated we will get a
NULL pointer dereference in sysc_unprepare(). Let's fix this by returning
early when no clocks are allocated.

Fixes: 0eecc636e5a2 ("bus: ti-sysc: Add minimal TI sysc interconnect target driver")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1331,6 +1331,9 @@ static void sysc_unprepare(struct sysc *ddata)
 {
 	int i;
 
+	if (!ddata->clocks)
+		return;
+
 	for (i = 0; i < SYSC_MAX_CLOCKS; i++) {
 		if (!IS_ERR_OR_NULL(ddata->clocks[i]))
 			clk_unprepare(ddata->clocks[i]);
-- 
2.21.0
